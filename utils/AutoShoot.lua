local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local CombatController = require(ReplicatedStorage.Controllers.CombatController)
local CombatUtil = require(ReplicatedStorage.Modules.CombatUtil)

local TargetPart = nil
local TargetModel = nil

local function getModelHealth(model)
    if not model then return math.huge end
    local humanoid = model:FindFirstChildOfClass("Humanoid") or model:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health ~= nil then
        return humanoid.Health
    end
    local hv = model:FindFirstChild("Health")
    if hv and hv.Value ~= nil then
        return hv.Value
    end
    return math.huge
end

local function GetBladeHits(distance)
    local targets = {}
    local seen = {}
    local char = LocalPlayer.Character
    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return targets end

    local function GetDistance(pos)
        return (pos - rootPart.Position).Magnitude
    end

    for _, containerName in ipairs({"Enemies", "Characters"}) do
        local container = workspace:FindFirstChild(containerName)
        if container then
            for _, v in ipairs(container:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChildOfClass("Humanoid") then
                    local player = Players:GetPlayerFromCharacter(v)
                    if player and player == LocalPlayer then
                        continue
                    end
                    local health = getModelHealth(v)
                    if health <= 0 then
                        continue
                    end
                    local dist = GetDistance(v.HumanoidRootPart.Position)
                    local maxDist = distance or 60
                    if dist < maxDist then
                        table.insert(targets, v)
                        seen[v] = true
                    end
                end
            end
        end
    end

    local enemiesFolder = workspace:FindFirstChild("Enemies")
    if enemiesFolder then
        for _, v in ipairs(enemiesFolder:GetChildren()) do
            if v:IsA("Model") and not seen[v] then
                local seat = v:FindFirstChildOfClass("VehicleSeat") or v:FindFirstChild("VehicleSeat", true)
                if seat then
                    local health = getModelHealth(v)
                    if health <= 0 then
                        continue
                    end
                    local dist = GetDistance(seat.Position)
                    local maxDist = distance or 60
                    if dist < maxDist then
                        table.insert(targets, v)
                        seen[v] = true
                    end
                end
            end
        end
    end

    local seaFolder = workspace:FindFirstChild("SeaBeasts")
    if seaFolder then
        for _, v in ipairs(seaFolder:GetChildren()) do
            if v:IsA("Model") and not seen[v] then
                local hrp = v:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local health = getModelHealth(v)
                    if health <= 0 then
                        continue
                    end
                    local dist = GetDistance(hrp.Position)
                    local maxDist = distance or 60
                    if dist < maxDist then
                        table.insert(targets, v)
                        seen[v] = true
                    end
                end
            end
        end
    end

    return targets
end

local function hookShootEvent()
    local ok, targetRemote = pcall(function()
        return ReplicatedStorage:WaitForChild("Modules")
                              :WaitForChild("Net")
                              :WaitForChild("RE/ShootGunEvent")
    end)
    if not ok or not targetRemote then return end

    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "FireServer" and self == targetRemote then
            if TargetPart and TargetPart.Parent then
                if args[1] and typeof(args[1]) == "Vector3" then
                    args[1] = TargetPart.Position
                    if args[2] and type(args[2]) == "table" then
                        args[2] = {TargetPart}
                    end
                end
            end
        end
        return oldNamecall(self, unpack(args))
    end))
end

local function hookRequestM1()
    local success, requestFunc = pcall(function()
        return require(ReplicatedStorage:WaitForChild("Effect"):WaitForChild("Container"):WaitForChild("Gun_M1"):WaitForChild("RequestM1"))
    end)
    if not success or type(requestFunc) ~= "function" then
        return
    end
    local old; old = clonefunction(hookfunction(requestFunc, newcclosure(function(p1, ...)
        if type(p1) == "table" and TargetPart and TargetPart.Parent then
            p1.TargetPosition = TargetPart.Position
            if p1.ExplodePos then
                p1.ExplodePos = TargetPart.Position
            end
        end
        return old(p1, ...)
    end)))
end

pcall(hookShootEvent)
pcall(hookRequestM1)

local function ensureShootAttachment(tool)
    if not tool then return end
    local ptr = tool:FindFirstChild("LocalEquippedWeaponPointer")
    if (not ptr) or (not ptr:IsA("ObjectValue")) then
        ptr = Instance.new("ObjectValue")
        ptr.Name = "LocalEquippedWeaponPointer"
        ptr.Value = tool
        ptr.Parent = tool
    elseif not ptr.Value then
        ptr.Value = tool
    end
    local parentModel = ptr.Value
    if not parentModel then return end
    local shoot = parentModel:FindFirstChild("ShootAttachment", true) or parentModel:FindFirstChild("ShootAttachment1", true)
    if not shoot then
        local attachParent = parentModel:FindFirstChild("Handle") or parentModel
        local a = Instance.new("Attachment")
        a.Name = "ShootAttachment1"
        a.Parent = attachParent
    end
end

local function makeFakeInput()
    local fakeInput = {
        UserInputState = Enum.UserInputState.Begin,
        UserInputType = Enum.UserInputType.MouseButton1
    }
    local listeners = {}
    function fakeInput:GetPropertyChangedSignal(property)
        if property ~= "UserInputState" then
            return {
                Connect = function()
                    return { Disconnect = function() end }
                end
            }
        end
        return {
            Connect = function(_, callback)
                table.insert(listeners, callback)
                local disconnected = false
                return {
                    Disconnect = function()
                        if disconnected then return end
                        for i = #listeners, 1, -1 do
                            if listeners[i] == callback then
                                table.remove(listeners, i)
                                break
                            end
                        end
                        disconnected = true
                    end
                }
            end
        }
    end
    function fakeInput:SetState(state)
        self.UserInputState = state
        for _, cb in ipairs(listeners) do
            pcall(cb)
        end
    end
    return fakeInput
end

local function chooseClosest(targets)
    if not targets or #targets == 0 then return nil end
    local char = LocalPlayer.Character
    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
    if not rootPart then return targets[1] end
    local function getPos(v)
        if v:FindFirstChild("Head") then
            return v.Head.Position
        end
        if v:FindFirstChild("HumanoidRootPart") then
            return v.HumanoidRootPart.Position
        end
        local seat = v:FindFirstChildOfClass("VehicleSeat") or v:FindFirstChild("VehicleSeat", true)
        if seat then
            return seat.Position
        end
        return nil
    end
    local best = nil
    local bestDist = math.huge
    for i = 1, #targets do
        local v = targets[i]
        local pos = getPos(v)
        if pos then
            local d = (pos - rootPart.Position).Magnitude
            if d < bestDist then
                bestDist = d
                best = v
            end
        end
    end
    return best
end

local function ShootAll()
    local char = LocalPlayer and LocalPlayer.Character
    local tool = char and char:FindFirstChildOfClass("Tool")
    if not (char and tool) then return end
    if tool.ToolTip ~= "Gun" then return end

    local enemies = GetBladeHits(500)
    local closestEnemy = chooseClosest(enemies)
    if not closestEnemy then
        TargetPart = nil
        TargetModel = nil
        return
    end

    local seat = closestEnemy:FindFirstChildOfClass("VehicleSeat") or closestEnemy:FindFirstChild("VehicleSeat", true)
    local hrp = closestEnemy:FindFirstChild("HumanoidRootPart")
    local head = closestEnemy:FindFirstChild("Head")
    if head then
        TargetPart = head
        TargetModel = closestEnemy
    elseif seat then
        TargetPart = seat
        TargetModel = closestEnemy
    elseif hrp then
        TargetPart = hrp
        TargetModel = closestEnemy
    else
        TargetPart = nil
        TargetModel = nil
        return
    end

    local health = getModelHealth(TargetModel)
    if health <= 0 then
        TargetPart = nil
        TargetModel = nil
        return
    end

    ensureShootAttachment(tool)
    local weaponName = CombatUtil:GetWeaponName(tool)
    local wdata = CombatUtil:GetWeaponData(weaponName)
    local fakeInput = makeFakeInput()
    CombatController:Attack(tool, fakeInput)

    if wdata and wdata.ShootStyle == "Gatling" then
        local OverheatLimit = wdata.OverheatLimit or 100
        while not tool:GetAttribute("IsAutoShooting") do
            if not tool or not tool.Parent or tool.Parent ~= LocalPlayer.Character then
                fakeInput:SetState(Enum.UserInputState.End)
                TargetPart = nil
                TargetModel = nil
                return
            end
            task.wait(0.03)
        end

        while true do
            local over = tool:GetAttribute("LocalOverheat") or 0
            local isAuto = tool:GetAttribute("IsAutoShooting")
            if (over >= OverheatLimit) then
                break
            end
            if not isAuto then
                break
            end
            if not tool or not tool.Parent or tool.Parent ~= LocalPlayer.Character then
                break
            end
            if not TargetPart or not TargetPart.Parent then
                break
            end
            local h = getModelHealth(TargetModel)
            if h <= 0 then
                break
            end
            task.wait(0.05)
        end

        fakeInput:SetState(Enum.UserInputState.End)
    else
        task.delay(0.06, function()
            fakeInput:SetState(Enum.UserInputState.End)
        end)
    end
end

task.spawn(function()
    while task.wait(0.12) do
        pcall(ShootAll)
    end
end)