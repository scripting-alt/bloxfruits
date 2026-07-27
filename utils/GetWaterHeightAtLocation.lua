local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Locations = Workspace._WorldOrigin:WaitForChild("Locations")

local Module = {}
local Regions = {}
local SortedRegions = {}

_G.GLOBAL_WATER_HEIGHT_BONUS = _G.GLOBAL_WATER_HEIGHT_BONUS or 0

local DEFAULT_WATER_HEIGHT = -4

local function GetWaterBonus()
    return _G.GLOBAL_WATER_HEIGHT_BONUS or 0
end

local function AddRegion(Name, LocationInstance, WaterHeight, ScaleMultiplier)
    if not LocationInstance then
        return
    end

    local Mesh = LocationInstance:FindFirstChild("Mesh")

    local Scale = Mesh and Mesh.Scale or Vector3.one
    ScaleMultiplier = ScaleMultiplier or 1

    Scale *= ScaleMultiplier

    Regions[Name] = {
        LocationInstance = LocationInstance,
        Position = LocationInstance.Position,
        Scale = Scale,
        ScaleMagnitude = Scale.Magnitude,
        WaterHeight = WaterHeight
    }

    table.clear(SortedRegions)

    for Name, Data in pairs(Regions) do
        table.insert(SortedRegions, {
            Name = Name,
            Data = Data
        })
    end

    table.sort(SortedRegions, function(A, B)
        return A.Data.ScaleMagnitude < B.Data.ScaleMagnitude
    end)
end

local function RemoveRegion(Name)
    Regions[Name] = nil

    table.clear(SortedRegions)

    for RegionName, Data in pairs(Regions) do
        table.insert(SortedRegions, {
            Name = RegionName,
            Data = Data
        })
    end

    table.sort(SortedRegions, function(A, B)
        return A.Data.ScaleMagnitude < B.Data.ScaleMagnitude
    end)
end

local function GetDynamicSubmergedWater()
    if not game:GetService("ReplicatedStorage").Util.GetWaterHeightAtLocation:GetAttribute("Enabled") then
        return -2162.033
    end

    local Time = os.clock() % 80

    if Time < 10 then
        return -2174.033 + 12 * (1 - Time / 10)
    elseif Time < 40 then
        return -2174.033
    elseif Time < 50 then
        return -2174.033 + 12 * ((Time - 40) / 10)
    else
        return -2162.033
    end
end

local function IsInsideRegion(Position, Region)
    local Difference = Position - Region.Position
    local HalfScale = Region.Scale * 0.5

    return math.abs(Difference.X) < HalfScale.X
        and math.abs(Difference.Y) < HalfScale.Y
        and math.abs(Difference.Z) < HalfScale.Z
end

local function GetPosition(Value)
    if typeof(Value) == "CFrame" then
        return Value.Position
    end

    return Value
end

local function GetWaterHeightAtLocationRaw(Value)
    local Position = GetPosition(Value)

    for _, RegionInfo in ipairs(SortedRegions) do
        local Region = RegionInfo.Data

        if IsInsideRegion(Position, Region) then
            return Region.WaterHeight(Position - Region.Position) + GetWaterBonus()
        end
    end

    return DEFAULT_WATER_HEIGHT + GetWaterBonus()
end

local function GetWaterHeightAtLocation(Value)
    local Position = GetPosition(Value)

    for _, RegionInfo in ipairs(SortedRegions) do
        local Region = RegionInfo.Data

        if IsInsideRegion(Position, Region) then
            return Region.WaterHeight(Position - Region.Position) + GetWaterBonus(),
                true,
                RegionInfo.Name
        end
    end

    return DEFAULT_WATER_HEIGHT + GetWaterBonus(), false
end