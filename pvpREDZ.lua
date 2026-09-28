local function safeLoad(url)
    local success, content = pcall(game.HttpGet, game, url)
    if success and content then
        local fn, err = loadstring(content)
        if fn then
            return fn()
        else
            warn("[REDZ HUB] Erro ao compilar: " .. url .. " -> " .. tostring(err))
        end
    else
        warn("[REDZ HUB] Erro ao baixar: " .. url)
    end
    return nil
end

local Library = safeLoad("https://raw.githubusercontent.com/scripting-alt/bloxfruits/refs/heads/main/library.luau")

Window = Library:MakeWindow({
  Title = "redz Hub PvP: Blox Fruits",
  SubTitle = "by felipenhrt",
  ScriptFolder = "redz-library-pvp"
})
local Tab_General = Window:MakeTab({ "General", "Home" })
local Tab_Combat = Window:MakeTab({ "Combat", "swords" })
local Tab_WebHook = Window:MakeTab({ "Webhook", "info" })
local Tab_Blacklist = Window:MakeTab({ "Blacklist", "diamond" })
local Tab_Macro = Window:MakeTab({ "Macro", "scroll" })
local Tab_Misc = Window:MakeTab({ "Misc", "settings" })
Tab_General:AddSection("Discord")
Tab_General:AddDiscordInvite({
    Title = "redz Hub | Community",
    Description = "A community for redz Hub Users -- official scripts, updates, and suport in one place.",
    Banner = "rbxassetid://17382040552", -- You can put an RGB Color: Color3.fromRGB(233, 37, 69)
    Logo = "rbxassetid://17382040552",
    Invite = "https://discord.gg/redz-hub",
    Members = 470000, -- Optional
    Online = 20000, -- Optional
})

local function pvpStatus(player)
    if not player then 
        return "error" 
    end
    local character = player.Character
    if character and character:GetAttribute("InCombat") then
        return "combat"
    end
    if player:GetAttribute("PvpDisabled") then
        return "off"
    end
    if player:GetAttribute("InSafeZone") or (character and character:GetAttribute("InSafeZone")) then
        return "safe"
    end
    return "on"
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local function getPvp(player, teamHex)
    local char = player.Character
    if char and char:GetAttribute("InCombat") then return "IN COMBAT", "#ffffff" end
    if player:GetAttribute("PvpDisabled") then return "PvP OFF", "#54A0FF" end
    if player:GetAttribute("InSafeZone") or (char and char:GetAttribute("InSafeZone")) then return "Safe Zone", "#ffffff" end
    return "PvP ON", "#ffffff"
end

local function IsFriendly(player)
    if player == LocalPlayer then
        return true
    end
    if not player:IsA("Player") then
        return false
    end
    local stats, s = getPvp(player)
    if stats == "PvP OFF" then return true end
    if stats == "Safe Zone" then return true end
    return CollectionService:HasTag(player, "Ally" .. LocalPlayer.Name) or CollectionService:HasTag(LocalPlayer, "Ally" .. player.Name) or (LocalPlayer.Team and game:GetService("Teams"):FindFirstChild("Marines") and LocalPlayer.Team == game.Teams.Marines and player.Team == game.Teams.Marines)
end

local function GetNearestEnemy()
    local Character = LocalPlayer.Character
    local Root = Character and Character:FindFirstChild("HumanoidRootPart")
    if not Root then return nil end

    local Closest, CharClosest, Distance = nil, nil, _G.DistanceBuuut or math.huge
    local Targets = {}

    if _G.AimbotType.Players then
        for _, v in ipairs(Players:GetPlayers()) do
            if v ~= LocalPlayer then
                table.insert(Targets, v)
            end
        end
    end

    if _G.AimbotType.Enemies and workspace:FindFirstChild("Enemies") then
        for _, v in ipairs(workspace.Enemies:GetChildren()) do
            table.insert(Targets, v)
        end
    end

    for _, Entity in ipairs(Targets) do
        local Char = Entity:IsA("Player") and Entity.Character or Entity
        if Entity.Name == "Player" then continue end
        if Char and not IsFriendly(Entity) then
            local Hum = Char:FindFirstChildOfClass("Humanoid")
            local HRP = Char:FindFirstChild("HumanoidRootPart") or Char:FindFirstChild("PrimaryPart")

            if Hum and Hum.Health > 0 and HRP then
                local Magnitude = (HRP.Position - Root.Position).Magnitude

                if Magnitude < Distance then
                    Distance = Magnitude
                    Closest = HRP
                    CharClosest = Char
                end
            end
        end
    end

    return Closest, CharClosest
end

local cd = 1        

local function GetBladeHits()
    local targets = {}
    local playerChar = game.Players.LocalPlayer.Character
    if not playerChar or not playerChar:FindFirstChild("HumanoidRootPart") then return targets end
    local rootPos = playerChar.HumanoidRootPart.Position

    for _, folder in pairs({workspace:FindFirstChild("Enemies"), workspace:FindFirstChild("Characters")}) do
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") then
                    local plr = game.Players:GetPlayerFromCharacter(v)
                    if not (plr and IsFriendly and IsFriendly(plr)) then
                        if (v.HumanoidRootPart.Position - rootPos).Magnitude < _G.ClickerDistance then
                            table.insert(targets, v)
                        end
                    end
                end
            end
        end
    end
    return targets
end

local function AttackAll()
    local character = game.Players.LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return end

    local net = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net")
    local rootPos = character.HumanoidRootPart.Position
    local enemies = GetBladeHits()

    if tool:FindFirstChild("LeftClickRemote") and enemies[1] then
        tool.LeftClickRemote:FireServer((enemies[1].HumanoidRootPart.Position - character:GetPivot().Position).Unit, cd)
    end

    if #enemies > 0 then
        net:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
        local args = {nil, {}}
        for i, v in pairs(enemies) do
            if not args[1] then args[1] = v.Head end
            args[2][i] = {v, v.HumanoidRootPart}
        end
        net:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
    end

    local tablet = workspace:FindFirstChild("Archaeologist's Tablet")
    if tablet and tablet:FindFirstChild("Pillars") then
        local closestPart, minDist = nil, 60
        for _, pillar in ipairs(tablet.Pillars:GetChildren()) do
            if (pillar:GetAttribute("NumHits") or 0) < 3 and pillar:FindFirstChild("SandLayer3") then
                local dist = (pillar.SandLayer3.Position - rootPos).Magnitude
                if dist < minDist then minDist, closestPart = dist, pillar.SandLayer3 end
            end
        end
        if closestPart then
            net:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
            task.wait()
            net:WaitForChild("RE/RegisterHit"):FireServer(closestPart)
        end
    end

    local cloudPieces = workspace:FindFirstChild("CloudPieces")
    if cloudPieces then
        for _, mesh in ipairs(cloudPieces:GetChildren()) do
            if mesh:IsA("BasePart") and (mesh.Position - rootPos).Magnitude < 150 then
                net:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
                net:WaitForChild("RE/RegisterHit"):FireServer(mesh)
            end
        end
    end

    local map = workspace:FindFirstChild("Map")
    local rock = map and map:FindFirstChild("Magma") and map.Magma:FindFirstChild("BonusMoment_Locations") and map.Magma.BonusMoment_Locations:FindFirstChild("SlimeGeyser") and map.Magma.BonusMoment_Locations.SlimeGeyser:FindFirstChild("Rock.001")
    if rock and rock:IsA("BasePart") and (rock.Position - rootPos).Magnitude < 60 then
        net:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
        net:WaitForChild("RE/RegisterHit"):FireServer(rock)
    end
end

local Aim = require(game:GetService("ReplicatedStorage").MovesetUtil.Aim)
local oldFromMouse
oldFromMouse = hookfunction(Aim.fromMouse, function(...)
    if targetSelect ~= nil and targetPos then
        return targetPos
    end
    return oldFromMouse(...)
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if targetSelect then
        if method == "FireServer" then
            if self.Name == "RemoteEvent" then
                if typeof(args[1]) == "Vector3" then
                    args[1] = targetPos
                elseif args[1] == "TAP" and typeof(args[2]) == "Vector3" then
                    args[2] = targetPos
                end
                return oldNamecall(self, unpack(args))
            end
            if self.Name == "RE/ShootGunEvent" then
                if typeof(args[1]) == "Vector3" then
                    args[1] = targetPos
                end
                args[2] = {targetSelect.HumanoidRootPart}
                return oldNamecall(self, unpack(args))
            end
        end
        if method == "InvokeServer" and self.Name == "" then
            if typeof(args[2]) == "Vector3" then
                args[2] = targetPos
                args[3] = targetSelect.HumanoidRootPart
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

local function isIgnoringSkill(char)
    local hum = char:FindFirstChild("Humanoid")
    local anim = hum and hum:FindFirstChildOfClass("Animator")
    if anim then
        for _, track in pairs(anim:GetPlayingAnimationTracks()) do
            if track.Animation then
                local n = track.Animation.Name:lower()
                if n:match("flight") or n:match("dash") or n:match("dodge") or n:match("ghost") then return true end
            end
        end
    end
    return false
end

local validKeys = {
    ["Z"] = true,
    ["X"] = true,
    ["C"] = true,
    ["V"] = true,
    ["F"] = false
}

local oldRequire
oldRequire = hookfunction(require, function(module, ...)
    local result = oldRequire(module, ...)
    
    if typeof(module) == "Instance" and module.Name == "Client" then
        local parentFolder = module.Parent
        
        if parentFolder and validKeys[parentFolder.Name] then
            if type(result) == "table" and result.onInput then
                local originalOnInput = result.onInput
                
                result.onInput = function(p1, ...)
                    if _G.botEnabled and targetSelect and targetPos then
                        if p1 then
                            p1.aim = function()
                                return targetPos
                            end
                            
                            if p1.mouse then
                                local realMouse = p1.mouse
                                p1.mouse = setmetatable({}, {
                                    __index = function(_, key)
                                        if key == "Hit" then
                                            return CFrame.new(targetPos)
                                        end
                                        if type(realMouse) == "table" or typeof(realMouse) == "userdata" then
                                            return realMouse[key]
                                        end
                                    end
                                })
                            else
                                p1.mouse = setmetatable({}, {
                                    __index = function(_, key)
                                        if key == "Hit" then
                                            return CFrame.new(targetPos)
                                        end
                                    end
                                })
                            end
                        end
                    end
                    return originalOnInput(p1, ...)
                end
            end
        end
    end
    
    return result
end)

task.spawn(function()
    while task.wait() do
        local char = game.Players.LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        
        if _G.botEnabled then
            local Target, CharClosest = GetNearestEnemy()
            if Target and CharClosest then
                targetSelect = CharClosest
                targetPos = Target.Position
            else
                targetSelect = nil
                targetPos = Vector3.zero
            end
        else
            targetSelect = nil
            targetPos = Vector3.zero
        end
        
        if char and hum then
            char:SetAttribute("UnbreakableAll", _G.Unbreakable)
            char:SetAttribute("WaterWalking", _G.WaterWalk)
            hum.JumpPower = _G.JumpBoost and _G.MultiJump or 50
            char:SetAttribute("SpeedMultiplier", _G.SpeedBoost and _G.MultiSpeed or 3)
            char:SetAttribute("DashLength", _G.DashBoost and _G.DashSpeed or 10)
            if _G.noStun then
                if char.HumanoidRootPart then
                    char.HumanoidRootPart.Anchored = false
                end
                local stunObj = char:FindFirstChild("Stun")
                if stunObj then 
                    stunObj.Value = 0 
                end
            
                local bodyVel = char:FindFirstChild("BodyVelocity") or char:FindFirstChildOfClass("BodyVelocity")
                if bodyVel then 
                    bodyVel.MaxForce = Vector3.new(0, 0, 0) 
                end
            end
        end
    end
end)

pcall(function()
    local realDevilFruit = LocalPlayer:WaitForChild("Data"):WaitForChild("DevilFruit")
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(self, key)
        if not checkcaller() and self == realDevilFruit and key == "Value" then
            local callerScript = getcallingscript()
            if callerScript and callerScript.Name == "Movement + Swim" then
                return "Yeti-Yeti"
            end
        end
        return oldIndex(self, key)
    end)
end)

function Esp()
    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        
        local char = p.Character
        local head = char and char:FindFirstChild("Head")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local esp = head and head:FindFirstChild("NameEsp_" .. p.Name)

        if _G.EspEnabled then
            if not head or not hum then continue end
            
            local locChar = LocalPlayer.Character
            local locHead = locChar and locChar:FindFirstChild("Head")
            if not locHead then continue end

            local dist = math.floor((locHead.Position - head.Position).Magnitude / 3)
            local hp = math.max(0, math.floor((hum.Health / math.max(1, hum.MaxHealth)) * 100))
            
            local lvlObj = p:FindFirstChild("Data"):FindFirstChild("Level")
            local lvl = lvlObj.Value or 0
            
            local teamHex = "#" .. p.TeamColor.Color:ToHex()
            local tag, tagCol = getPvp(p, teamHex)

            if not esp then
                esp = Instance.new("BillboardGui")
                esp.Name = "NameEsp_" .. p.Name
                esp.Adornee = head
                esp.AlwaysOnTop = true
                esp.ExtentsOffset = Vector3.new(0, 3, 0)
                esp.Size = UDim2.new(1, 200, 1, 30)

                local lbl = Instance.new("TextLabel")
                lbl.Name = "TextLabel"
                lbl.Size = UDim2.new(1, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamSemibold
                lbl.TextSize = 14
                lbl.TextWrapped = true
                lbl.TextYAlignment = Enum.TextYAlignment.Top
                lbl.TextStrokeTransparency = 0.5
                lbl.RichText = true
                lbl.Parent = esp
                
                esp.Parent = head
            end

            local lbl = esp:FindFirstChild("TextLabel")
            if lbl then
                lbl.Text = string.format(
                    '<font color="%s">%s</font> <font color="%s">[</font> <font color="%s">%s</font> <font color="%s">]</font>\n<font color="%s">[</font> <font color="#FFFFFF">%d Distance</font> <font color="%s">]</font>\n<font color="#FFFFFF">Health: %d%% | Lv. %d</font>',
                    teamHex, p.Name, teamHex, tagCol, tag, teamHex, teamHex, dist, teamHex, hp, lvl
                )
            end
        else
            if esp then
                esp:Destroy()
            end
        end
    end
end

Tab_General:AddSection("Movement")
Tab_General:AddToggle({
  Name = "Speed Boost",
  Default = false,
  Flag = "Speed_flag",
  Callback = function(Value)
    _G.SpeedBoost = Value
  end
})  
Tab_General:AddSlider({
  Name = "Speed Multiplier",
  Min = 1,
  Max = 6,
  Increment = 1,
  Default = 3,
  Flag = "MultiSpeed_flag",
  Callback = function(Value)
    _G.MultiSpeed = Value
  end
})

Tab_General:AddToggle({
  Name = "Custom Dash",
  Default = false,
  Flag = "Dash_flag",
  Callback = function(Value)
    _G.DashBoost = Value
  end
})  
Tab_General:AddSlider({
  Name = "Dash Multiplier",
  Min = 1,
  Max = 300,
  Increment = 10,
  Default = 15,
  Flag = "MultiDash_flag",
  Callback = function(Value)
    _G.DashSpeed = Value
  end
})

Tab_General:AddToggle({
  Name = "Custom Jump",
  Default = false,
  Flag = "Jump_flag",
  Callback = function(Value)
    _G.JumpBoost = Value
  end
})  
Tab_General:AddSlider({
  Name = "Jump Multiplier",
  Min = 1,
  Max = 300,
  Increment = 10,
  Default = 15,
  Flag = "MultiJump_flag",
  Callback = function(Value)
    _G.MultiJump = Value
  end
})

Tab_General:AddToggle({
  Name = "Walking on water",
  Default = true,
  Flag = "WaterWalk_flag",
  Callback = function(Value)
    _G.WaterWalk = Value
  end
})
Tab_General:AddToggle({
  Name = "Unbreakable Skills",
  Default = true,
  Flag = "Unbreakable_flag",
  Callback = function(Value)
    _G.Unbreakable = Value
  end
})  
Tab_General:AddToggle({
  Name = "No Stun",
  Default = true,
  Flag = "noStun_flag",
  Callback = function(Value)
    _G.noStun = Value
  end
})  
Tab_General:AddSection("Race")
Tab_General:AddToggle({
  Name = "Auto V3",
  Default = false,
  Flag = "AutoV3_flag",
  Callback = function(Value)
    _G.AutoV3 = Value
  end
})
--[[
Tab_General:AddToggle({
  Name = "Smart Auto V3",
  Default = true,
  Flag = "Unbreakable_flag",
  Callback = function(Value)
    _G.Unbreakable = Value
  end
}) 
]]
Tab_General:AddToggle({
  Name = "Auto V4",
  Default = true,
  Flag = "AutoV4_flag",
  Callback = function(Value)
    _G.AutoV4 = Value
  end
})
--[[
Tab_General:AddToggle({
  Name = "Smart Auto V4",
  Default = true,
  Flag = "Unbreakable_flag",
  Callback = function(Value)
    _G.Unbreakable = Value
  end
})  
]]  
Tab_Combat:AddSection("Fast Clicks")
Tab_Combat:AddToggle({
  Name = "Fast Attack",
  Default = true,
  Flag = "Attack_flag",
  Callback = function(Value)
    _G.FastAttack = Value
  end
})

spawn(function()
    while task.wait(_G.AttackSpeed) do
        if not _G.FastAttack then
            continue
        end
        AttackAll()
    end
end)

Tab_Combat:AddSlider({
  Name = "Attack Speed",
  Min = 0,
  Max = 10,
  Increment = .1,
  Default = 0,
  Flag = "FastAttack_flag",
  Callback = function(Value)
    _G.AttackSpeed = Value
  end
})
Tab_Combat:AddSlider({
  Name = "Attack Distance",
  Min = 5,
  Max = 60,
  Increment = 1,
  Default = 60,
  Flag = "DisAttack_flag",
  Callback = function(Value)
    _G.ClickerDistance = Value
  end
})
Tab_Combat:AddSection("Visual")
Tab_Combat:AddToggle({
  Name = "Esp Players",
  Default = false,
  Flag = "Esp_flag",
  Callback = function(Value)
    _G.EspEnabled = Value
    if _G.EspEnabled then
        task.spawn(function()
            while _G.EspEnabled do
                Esp()
                task.wait(1)
            end
        end)
    else
        Esp()
    end
  end
})
Tab_Combat:AddSection("PvP")
Tab_Combat:AddToggle({
  Name = "Aimbot",
  Default = true,
  Flag = "Aimbot_flag",
  Callback = function(Value)
    _G.botEnabled = Value
  end
})
Tab_Combat:AddSlider({
  Name = "Aimbot Distance",
  Min = 50,
  Max = 1000,
  Increment = 10,
  Default = 500,
  Flag = "AimbotDistance_flag",
  Callback = function(Value)
    _G.DistanceBuuut = Value
  end
})
Tab_Combat:AddDropdown({
  Name = "Aimbot Type",
  MultiSelect = true,
  Options = {"Players", "Enemies", "Monsters (EM BREVE)"},
  Default = {"Players"},
  Flag = "AimbotType_flag",
  Callback = function(Value)
     _G.AimbotType = Value
  end
})

Tab_Combat:AddSection("FPS")
Tab_Combat:AddToggle({
  Name = "Show Fps",
  Default = true,
  Flag = "FpsEnabled_flag",
  Callback = function(Value)
    _G.fpsShow = Value
  end
})
Tab_Combat:AddSlider({
  Name = "Fps Limit",
  Min = 30,
  Max = 1000,
  Increment = 10,
  Default = 120,
  Flag = "fpsLimit_flag",
  Callback = function(Value)
    setfpscap(Value)
  end
})

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "StatsDisplayGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer.PlayerGui

local statsLabel = Instance.new("TextLabel")
statsLabel.Name = "StatsLabel"
statsLabel.Position = UDim2.new(0.015, 0, 0.015, 0)
statsLabel.Size = UDim2.new(0.12, 0, 0.06, 0)
statsLabel.BackgroundTransparency = 1
statsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statsLabel.TextScaled = true
statsLabel.Font = Enum.Font.MontserratBold
statsLabel.TextXAlignment = Enum.TextXAlignment.Left
statsLabel.TextYAlignment = Enum.TextYAlignment.Top
statsLabel.Parent = screenGui

local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 1.5
uiStroke.Color = Color3.fromRGB(0, 0, 0)
uiStroke.Parent = statsLabel

local lastTime, frameCount, currentFPS = tick(), 0, 60

RunService.RenderStepped:Connect(function()
	frameCount += 1
	local currentTime = tick()
	if currentTime - lastTime >= 1 then
		currentFPS = frameCount
		frameCount = 0
		lastTime = currentTime
	end
    screenGui.Enabled = _G.fpsShow
	statsLabel.Text = string.format("%d FPS\n%d MS", currentFPS, math.floor(LocalPlayer:GetNetworkPing() * 1000))
end)