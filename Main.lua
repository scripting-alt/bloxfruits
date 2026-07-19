
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau"))()

ScriptVersion = {
    Version = "v1.1.2",
    Date = "2026-07-18"
}

_G.SelectTool = "Melee"
_G.FastAttack = true
_G.FastAttackSpeed = 0.1
_G.AutoFarmNear = false
_G.AutoFarmLevel = false
_G.ConfigStopFarm = {
    FruitSpawn = false,
    PirateRaid = false,
    Saw = false,
    Factory = false,
}
_G.FarmType = "Up"

Mon = "Bandit"
LevelQuest = 1
NameQuest = "BanditQuest1"
NameMon = "Bandit"
CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
World1 = false
World2 = false
World3 = false
LevelFarmToggle = {}

StatsAdd = {Melee = false, Defense = false, Sword = false, Gun = false, Fruit = false}

Pos = CFrame.new(0,0,0)
BringPos = CFrame.new(0,0,0)
PosY = 30
TweenON = false

if game.PlaceId == 2753915549 then
    World1 = true
    warn("[REDZ HUB] SEA 1")
elseif game.PlaceId == 79091703265657 then
    World2 = true
    warn("[REDZ HUB] SEA 2")
elseif game.PlaceId == 7449423635 then
    World3 = true
    warn("[REDZ HUB] SEA 3")
end

local Window
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Net = ReplicatedStorage.Modules.Net
local RegisterAttack = Net["RE/RegisterAttack"]
local RegisterHit = Net["RE/RegisterHit"]
local LastHealth = nil
local StuckTime = 0

function checkEnemySpawns(EnemyName)
    if ReplicatedStorage:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder"):FindFirstChild(EnemyName) then
        return true, ReplicatedStorage:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder"):FindFirstChild(EnemyName).CFrame
    end
    return false
end

function checkStopFarm()
    for _, v in pairs(_G.ConfigStopFarm) do
        if v == true then
            return false
        end
    end

    return true
end

local function GetBladeHits()
    local targets = {}
    local function GetDistance(v)
        return (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end
    
    for _, part in pairs({game.Workspace.Enemies, game.Workspace.Characters}) do
        for _, v in pairs(part:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") then
                if GetDistance(v.HumanoidRootPart) < 60 then
                    table.insert(targets, v)
                end
            end
        end
    end

    return targets
end

local function EquipWeapon(weapon)
    if not weapon then
        return
    end

    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChild("Humanoid")

    if not Humanoid then
        return
    end

    local Equipped = Character:FindFirstChildOfClass("Tool")

    if Equipped and (Equipped:GetAttribute("WeaponType") == weapon or Equipped.Name == weapon) then
        return
    end

    local ToolToEquip
    for _, Tool in ipairs(Player.Backpack:GetChildren()) do
        if Tool:IsA("Tool") and Tool:GetAttribute("WeaponType") == weapon then
            ToolToEquip = Tool
            break
        end
    end

    if not ToolToEquip then
        for _, Tool in ipairs(Player.Backpack:GetChildren()) do
            if Tool:IsA("Tool") and Tool.Name == weapon then
                ToolToEquip = Tool
                break
            end
        end
    end

    if ToolToEquip then
        Humanoid:UnequipTools()
        task.wait()
        Humanoid:EquipTool(ToolToEquip)
    end
end

local function AttackAll()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local equippedWeapon = character:FindFirstChild("EquippedWeapon")
    if not equippedWeapon then return end


    local enemies = GetBladeHits()
    if #enemies > 0 then
        local netModule = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net")
        netModule:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
        
        local args = {nil, {}}
        for i, v in pairs(enemies) do
            if not args[1] then
                args[1] = v.Head
            end
            args[2][i] = {v, v.HumanoidRootPart}
        end
        
        netModule:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
    end
end

function BringMob(MobName)
    for _, Enemy in ipairs(workspace.Enemies:GetChildren()) do
        local Humanoid = Enemy:FindFirstChild("Humanoid")
        local HumanoidRootPart = Enemy:FindFirstChild("HumanoidRootPart")

        if Enemy.Name == MobName
        and Enemy.Parent
        and Humanoid
        and HumanoidRootPart
        and Humanoid.Health > 0
        and (HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= _G.BringDistance then
            HumanoidRootPart.CFrame = BringPos
            Humanoid.JumpPower = 0
            Humanoid.WalkSpeed = 0
            HumanoidRootPart:SetNetworkOwner(game.Players.LocalPlayer)
            HumanoidRootPart.Transparency = 1
            --HumanoidRootPart.CanCollide = false

            local Head = Enemy:FindFirstChild("Head")
            if Head then
                Head.CanCollide = false
            end

            local Animator = Humanoid:FindFirstChild("Animator")
            if Animator then
                Animator:Destroy()
            end

            if not HumanoidRootPart:FindFirstChild("Lock") then
                local BodyVelocity = Instance.new("BodyVelocity")

                BodyVelocity.Name = "Lock"
                BodyVelocity.Parent = HumanoidRootPart
                BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BodyVelocity.Velocity = Vector3.zero
            end

            sethiddenproperty(plr, "SimulationRadius", math.huge)

            Humanoid:ChangeState(11)
        end
    end
end

function WaitHRP(Player)
    if Player and Player.Character then
        return Player.Character:WaitForChild("HumanoidRootPart")
    end
end

function CheckNearestTeleporter(TargetCFrame)
    if not TargetCFrame then
        return
    end

    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

    if not HRP then
        return
    end

    local TeleportPositions = {
        [2753915549] = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            ["Underwater City"] = Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625),
            ["Pirate Village"] = Vector3.new(-1242.4625244140625, 4.787059783935547, 3901.282958984375),
            UnderwaterExit = Vector3.new(4050, -1, -1814),
        },

        [79091703265657] = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133),
        },

        [7449423635] = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625),
            Mansion = Vector3.new(-12462, 375, -7552),
            Castle = Vector3.new(-5036, 315, -3179),
            ["Dimensional Shift"] = Vector3.new(-2097.3447265625, 4776.24462890625, -15013.4990234375),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58203, 22.5364361, -125.942276),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103),
        }
    }

    local Positions = TeleportPositions[game.PlaceId]
    if not Positions then
        return
    end

    local TargetPosition = TargetCFrame.Position
    local ClosestTeleporter
    local ClosestDistance = math.huge

    for _, Position in pairs(Positions) do
        local Distance = (Position - TargetPosition).Magnitude

        if Distance < ClosestDistance then
            ClosestDistance = Distance
            ClosestTeleporter = Position
        end
    end

    local PlayerDistance = (TargetPosition - HRP.Position).Magnitude

    if ClosestDistance <= PlayerDistance then
        return ClosestTeleporter
    end
end

function requestEntrance(entrance)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('requestEntrance', entrance)
    local _HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    _HumanoidRootPart.CFrame = _HumanoidRootPart.CFrame + Vector3.new(0, 50, 0)
    task.wait(0.5)
end

function topos(TargetCFrame)
    if not TargetCFrame then
        return
    end

    local Player = game.Players.LocalPlayer
    local Character = Player.Character

    if not Character then
        return
    end

    local Humanoid = Character:FindFirstChild("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or Humanoid.Health <= 0 or not HumanoidRootPart then
        return
    end

    local Distance = (TargetCFrame.Position - HumanoidRootPart.Position).Magnitude

    local NearestTeleporter = CheckNearestTeleporter(TargetCFrame)
    if NearestTeleporter then
        requestEntrance(NearestTeleporter)
    end

    local PartTele = Character:FindFirstChild("PartTele")

    if not PartTele then
        PartTele = Instance.new("Part")
        PartTele.Name = "PartTele"
        PartTele.Size = Vector3.new(10, 1, 10)
        PartTele.Anchored = true
        PartTele.Transparency = 1
        PartTele.CanCollide = true
        PartTele.CFrame = WaitHRP(Player).CFrame
        PartTele.Parent = Character

        PartTele:GetPropertyChangedSignal("CFrame"):Connect(function()
            if not TweenON then
                return
            end

            task.wait()

            local Root = WaitHRP(Player)
            if Root then
                Root.CFrame = PartTele.CFrame
            end
        end)
    end

    TweenON = true

    local Tween = game:GetService("TweenService"):Create(
        PartTele,
        TweenInfo.new(Distance / _G.TweenSpeed, Enum.EasingStyle.Linear),
        {
            CFrame = TargetCFrame
        }
    )

    Tween:Play()

    Tween.Completed:Connect(function(State)
        if State == Enum.PlaybackState.Completed then
            if Character:FindFirstChild("PartTele") then
                Character.PartTele:Destroy()
            end

            TweenON = false
        end
    end)
end

function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function CheckQuest() 
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if World1 then
        if MyLevel == 1 or MyLevel <= 9 then
            Mon = "Bandit"
            LevelQuest = 1
            NameQuest = "BanditQuest1"
            NameMon = "Bandit"
            CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
            CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
        elseif MyLevel == 10 or MyLevel <= 14 then
            Mon = "Monkey"
            LevelQuest = 1
            NameQuest = "JungleQuest"
            NameMon = "Monkey"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
        elseif MyLevel == 15 or MyLevel <= 29 then
            Mon = "Gorilla"
            LevelQuest = 2
            NameQuest = "JungleQuest"
            NameMon = "Gorilla"
            CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
        elseif MyLevel == 30 or MyLevel <= 39 then
            Mon = "Pirate"
            LevelQuest = 1
            NameQuest = "BuggyQuest1"
            NameMon = "Pirate"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
        elseif MyLevel == 40 or MyLevel <= 59 then
            Mon = "Brute"
            LevelQuest = 2
            NameQuest = "BuggyQuest1"
            NameMon = "Brute"
            CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
        elseif MyLevel == 60 or MyLevel <= 74 then
            Mon = "Desert Bandit"
            LevelQuest = 1
            NameQuest = "DesertQuest"
            NameMon = "Desert Bandit"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
        elseif MyLevel == 75 or MyLevel <= 89 then
            Mon = "Desert Officer"
            LevelQuest = 2
            NameQuest = "DesertQuest"
            NameMon = "Desert Officer"
            CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
            CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
        elseif MyLevel == 90 or MyLevel <= 99 then
            Mon = "Snow Bandit"
            LevelQuest = 1
            NameQuest = "SnowQuest"
            NameMon = "Snow Bandit"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
        elseif MyLevel == 100 or MyLevel <= 119 then
            Mon = "Snowman"
            LevelQuest = 2
            NameQuest = "SnowQuest"
            NameMon = "Snowman"
            CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
            CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif MyLevel == 120 or MyLevel <= 149 then
            Mon = "Chief Petty Officer"
            LevelQuest = 1
            NameQuest = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
        elseif MyLevel == 150 or MyLevel <= 174 then
            Mon = "Sky Bandit"
            LevelQuest = 1
            NameQuest = "SkyQuest"
            NameMon = "Sky Bandit"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
        elseif MyLevel == 175 or MyLevel <= 189 then
            Mon = "Dark Master"
            LevelQuest = 2
            NameQuest = "SkyQuest"
            NameMon = "Dark Master"
            CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
        elseif MyLevel == 190 or MyLevel <= 209 then
            Mon = "Prisoner"
            LevelQuest = 1
            NameQuest = "PrisonerQuest"
            NameMon = "Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
        elseif MyLevel == 210 or MyLevel <= 249 then
            Mon = "Dangerous Prisoner"
            LevelQuest = 2
            NameQuest = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
            CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
        elseif MyLevel == 250 or MyLevel <= 274 then
            Mon = "Toga Warrior"
            LevelQuest = 1
            NameQuest = "ColosseumQuest"
            NameMon = "Toga Warrior"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
            CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
        elseif MyLevel == 275 or MyLevel <= 299 then
            Mon = "Gladiator"
            LevelQuest = 2
            NameQuest = "ColosseumQuest"
            NameMon = "Gladiator"
            CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, 0.857167721, 0, -0.515037298)
            CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
        elseif MyLevel == 300 or MyLevel <= 324 then
            Mon = "Military Soldier"
            LevelQuest = 1
            NameQuest = "MagmaQuest"
            NameMon = "Military Soldier"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
        elseif MyLevel == 325 or MyLevel <= 374 then
            Mon = "Military Spy"
            LevelQuest = 2
            NameQuest = "MagmaQuest"
            NameMon = "Military Spy"
            CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, 0.866048813, 0, 1, 0, -0.866048813, 0, -0.499959469)
            CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
        elseif MyLevel == 375 or MyLevel <= 399 then
            Mon = "Fishman Warrior"
            LevelQuest = 1
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Warrior"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 400 or MyLevel <= 449 then
            Mon = "Fishman Commando"
            LevelQuest = 2
            NameQuest = "FishmanQuest"
            NameMon = "Fishman Commando"
            CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif MyLevel == 450 or MyLevel <= 474 then
            Mon = "God's Guard"
            LevelQuest = 1
            NameQuest = "SkyExp1Quest"
            NameMon = "God's Guard"
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
            CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif MyLevel == 475 or MyLevel <= 524 then
            Mon = "Shanda"
            LevelQuest = 2
            NameQuest = "SkyExp1Quest"
            NameMon = "Shanda"
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
            CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif MyLevel == 525 or MyLevel <= 549 then
            Mon = "Royal Squad"
            LevelQuest = 1
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Squad"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
        elseif MyLevel == 550 or MyLevel <= 624 then
            Mon = "Royal Soldier"
            LevelQuest = 2
            NameQuest = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
        elseif MyLevel == 625 or MyLevel <= 649 then
            Mon = "Galley Pirate"
            LevelQuest = 1
            NameQuest = "FountainQuest"
            NameMon = "Galley Pirate"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
        elseif MyLevel >= 650 then
            Mon = "Galley Captain"
            LevelQuest = 2
            NameQuest = "FountainQuest"
            NameMon = "Galley Captain"
            CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
            CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
        end
    elseif World2 then
        if MyLevel == 700 or MyLevel <= 724 then
            Mon = "Raider"
            LevelQuest = 1
            NameQuest = "Area1Quest"
            NameMon = "Raider"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-728.3267211914062, 52.779319763183594, 2345.7705078125)
        elseif MyLevel == 725 or MyLevel <= 774 then
            Mon = "Mercenary"
            LevelQuest = 2
            NameQuest = "Area1Quest"
            NameMon = "Mercenary"
            CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
            CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
        elseif MyLevel == 775 or MyLevel <= 799 then
            Mon = "Swan Pirate"
            LevelQuest = 1
            NameQuest = "Area2Quest"
            NameMon = "Swan Pirate"
            CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
            CFrameMon = CFrame.new(1068.664306640625, 137.61428833007812, 1322.1060791015625)
        elseif MyLevel == 800 or MyLevel <= 874 then
            Mon = "Factory Staff"
            NameQuest = "Area2Quest"
            LevelQuest = 2
            NameMon = "Factory Staff"
            CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
            CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
        elseif MyLevel == 875 or MyLevel <= 899 then
            Mon = "Marine Lieutenant"
            LevelQuest = 1
            NameQuest = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
        elseif MyLevel == 900 or MyLevel <= 949 then
            Mon = "Marine Captain"
            LevelQuest = 2
            NameQuest = "MarineQuest3"
            NameMon = "Marine Captain"
            CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
            CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
        elseif MyLevel == 950 or MyLevel <= 974 then
            Mon = "Zombie"
            LevelQuest = 1
            NameQuest = "ZombieQuest"
            NameMon = "Zombie"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
        elseif MyLevel == 975 or MyLevel <= 999 then
            Mon = "Vampire"
            LevelQuest = 2
            NameQuest = "ZombieQuest"
            NameMon = "Vampire"
            CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
            CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
        elseif MyLevel == 1000 or MyLevel <= 1049 then
            Mon = "Snow Trooper"
            LevelQuest = 1
            NameQuest = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
        elseif MyLevel == 1050 or MyLevel <= 1099 then
            Mon = "Winter Warrior"
            LevelQuest = 2
            NameQuest = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
            CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
        elseif MyLevel == 1100 or MyLevel <= 1124 then
            Mon = "Lab Subordinate"
            LevelQuest = 1
            NameQuest = "IceSideQuest"
            NameMon = "Lab Subordinate"
            CFrameQuest = CFrame.new(-6231.22803, 82.2736664, -4852.95801, -0.908178151, 7.81125564e-09, 0.41858381, 5.5849001e-09, 1, -6.54390142e-09, -0.41858381, -3.60527963e-09, -0.908178151)
            CFrameMon = CFrame.new(-5782.05419921875, 383.233642578125, -4553.45751953125)
        elseif MyLevel == 1125 or MyLevel <= 1174 then
            Mon = "Horned Warrior"
            LevelQuest = 2
            NameQuest = "IceSideQuest"
            NameMon = "Horned Warrior"
            CFrameQuest = CFrame.new(-6231.22803, 82.2736664, -4852.95801, -0.908178151, 7.81125564e-09, 0.41858381, 5.5849001e-09, 1, -6.54390142e-09, -0.41858381, -3.60527963e-09, -0.908178151)
            CFrameMon = CFrame.new(-6568.48681640625, 83.62020874023438, -5817.66357421875)
        elseif MyLevel == 1175 or MyLevel <= 1199 then
            Mon = "Magma Ninja"
            LevelQuest = 1
            NameQuest = "FireSideQuest"
            NameMon = "Magma Ninja"
            CFrameQuest = CFrame.new(-5401.63232, 29.3890209, -5371.26221, 0.513783574, -1.93253147e-08, 0.857919812, -1.8253143e-08, 1, 3.34570665e-08, -0.857919812, -3.28494245e-08, 0.513783574)
            CFrameMon = CFrame.new(-5770.48974609375, 76.585693359375, -5664.71484375)
        elseif MyLevel == 1200 or MyLevel <= 1249 then
            Mon = "Lava Pirate"
            LevelQuest = 2
            NameQuest = "FireSideQuest"
            NameMon = "Lava Pirate"
            CFrameQuest = CFrame.new(-5401.63232, 29.3890209, -5371.26221, 0.513783574, -1.93253147e-08, 0.857919812, -1.8253143e-08, 1, 3.34570665e-08, -0.857919812, -3.28494245e-08, 0.513783574)
            CFrameMon = CFrame.new(-5033.35009765625, 85.82057189941406, -5009.0732421875)
        elseif MyLevel == 1250 or MyLevel <= 1274 then
            Mon = "Ship Deckhand"
            LevelQuest = 1
            NameQuest = "ShipQuest1"
            NameMon = "Ship Deckhand"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)         
            CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)    
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1275 or MyLevel <= 1299 then
            Mon = "Ship Engineer"
            LevelQuest = 2
            NameQuest = "ShipQuest1"
            NameMon = "Ship Engineer"
            CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)   
            CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)   
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end             
        elseif MyLevel == 1300 or MyLevel <= 1324 then
            Mon = "Ship Steward"
            LevelQuest = 1
            NameQuest = "ShipQuest2"
            NameMon = "Ship Steward"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)         
            CFrameMon = CFrame.new(919.4385375976562, 129.55599975585938, 33436.03515625)      
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1325 or MyLevel <= 1349 then
            Mon = "Ship Officer"
            LevelQuest = 2
            NameQuest = "ShipQuest2"
            NameMon = "Ship Officer"
            CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
            CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif MyLevel == 1350 or MyLevel <= 1374 then
            Mon = "Arctic Warrior"
            LevelQuest = 1
            NameQuest = "FrostQuest"
            NameMon = "Arctic Warrior"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            if _G.AutoFarmLevel and (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 5000.034996032715, -132.83953857422))
            end
        elseif MyLevel == 1375 or MyLevel <= 1424 then
            Mon = "Snow Lurker"
            LevelQuest = 2
            NameQuest = "FrostQuest"
            NameMon = "Snow Lurker"
            CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
            CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
        elseif MyLevel == 1425 or MyLevel <= 1449 then
            Mon = "Sea Soldier"
            LevelQuest = 1
            NameQuest = "ForgottenQuest"
            NameMon = "Sea Soldier"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
            CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
        elseif MyLevel >= 1450 then
            Mon = "Water Fighter"
            LevelQuest = 2
            NameQuest = "ForgottenQuest"
            NameMon = "Water Fighter"
            CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
            CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
        end
    elseif World3 then
        if MyLevel == 1500 or MyLevel <= 1524 then
            Mon = "Pirate Millionaire"
            LevelQuest = 1
            NameQuest = "PiratePortQuest"
            NameMon = "Pirate Millionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
        elseif MyLevel == 1525 or MyLevel <= 1574 then
            Mon = "Pistol Billionaire"
            LevelQuest = 2
            NameQuest = "PiratePortQuest"
            NameMon = "Pistol Billionaire"
            CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
            CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
        elseif MyLevel == 1575 or MyLevel <= 1599 then
            Mon = "Dragon Crew Warrior"
            LevelQuest = 1
            NameQuest = "AmazonQuest"
            NameMon = "Dragon Crew Warrior"
            CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
            CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
        elseif MyLevel == 1600 or MyLevel <= 1624 then 
            Mon = "Dragon Crew Archer [Lv. 1600]"
            NameQuest = "AmazonQuest"
            LevelQuest = 2
            NameMon = "Dragon Crew Archer"
            CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
            CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
        elseif MyLevel == 1625 or MyLevel <= 1649 then
            Mon = "Female Islander"
            NameQuest = "AmazonQuest2"
            LevelQuest = 1
            NameMon = "Female Islander"
            CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320312)
        elseif MyLevel == 1650 or MyLevel <= 1699 then 
            Mon = "Giant Islander [Lv. 1650]"
            NameQuest = "AmazonQuest2"
            LevelQuest = 2
            NameMon = "Giant Islander"
            CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
        elseif MyLevel == 1700 or MyLevel <= 1724 then
            Mon = "Marine Commodore"
            LevelQuest = 1
            NameQuest = "MarineTreeIsland"
            NameMon = "Marine Commodore"
            CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
            CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
        elseif MyLevel == 1725 or MyLevel <= 1774 then
            Mon = "Marine Rear Admiral [Lv. 1725]"
            NameMon = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            LevelQuest = 2
            CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
            CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
        elseif MyLevel == 1775 or MyLevel <= 1799 then
            Mon = "Fishman Raider"
            LevelQuest = 1
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Raider"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
        elseif MyLevel == 1800 or MyLevel <= 1824 then
            Mon = "Fishman Captain"
            LevelQuest = 2
            NameQuest = "DeepForestIsland3"
            NameMon = "Fishman Captain"
            CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)   
            CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625) 
        elseif MyLevel == 1825 or MyLevel <= 1849 then
            Mon = "Forest Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland"
            NameMon = "Forest Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
            CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
        elseif MyLevel == 1850 or MyLevel <= 1899 then
            Mon = "Mythological Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland"
            NameMon = "Mythological Pirate"
            CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)   
            CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
        elseif MyLevel == 1900 or MyLevel <= 1924 then
            Mon = "Jungle Pirate"
            LevelQuest = 1
            NameQuest = "DeepForestIsland2"
            NameMon = "Jungle Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
        elseif MyLevel == 1925 or MyLevel <= 1974 then
            Mon = "Musketeer Pirate"
            LevelQuest = 2
            NameQuest = "DeepForestIsland2"
            NameMon = "Musketeer Pirate"
            CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
            CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
        elseif MyLevel == 1975 or MyLevel <= 1999 then
            Mon = "Reborn Skeleton"
            LevelQuest = 1
            NameQuest = "HauntedQuest1"
            NameMon = "Reborn Skeleton"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
        elseif MyLevel == 2000 or MyLevel <= 2024 then
            Mon = "Living Zombie"
            LevelQuest = 2
            NameQuest = "HauntedQuest1"
            NameMon = "Living Zombie"
            CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, -0, -1, 0, 0)
            CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
        elseif MyLevel == 2025 or MyLevel <= 2049 then
            Mon = "Demonic Soul"
            LevelQuest = 1
            NameQuest = "HauntedQuest2"
            NameMon = "Demonic Soul"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0) 
            CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
        elseif MyLevel == 2050 or MyLevel <= 2074 then
            Mon = "Posessed Mummy"
            LevelQuest = 2
            NameQuest = "HauntedQuest2"
            NameMon = "Posessed Mummy"
            CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
        elseif MyLevel == 2075 or MyLevel <= 2099 then
            Mon = "Peanut Scout"
            LevelQuest = 1
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut Scout"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
        elseif MyLevel == 2100 or MyLevel <= 2124 then
            Mon = "Peanut President"
            LevelQuest = 2
            NameQuest = "NutsIslandQuest"
            NameMon = "Peanut President"
            CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
        elseif MyLevel == 2125 or MyLevel <= 2149 then
            Mon = "Ice Cream Chef"
            LevelQuest = 1
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Chef"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
        elseif MyLevel == 2150 or MyLevel <= 2199 then
            Mon = "Ice Cream Commander"
            LevelQuest = 2
            NameQuest = "IceCreamIslandQuest"
            NameMon = "Ice Cream Commander"
            CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
        elseif MyLevel == 2200 or MyLevel <= 2224 then
            Mon = "Cookie Crafter"
            LevelQuest = 1
            NameQuest = "CakeQuest1"
            NameMon = "Cookie Crafter"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
        elseif MyLevel == 2225 or MyLevel <= 2249 then
            Mon = "Cake Guard"
            LevelQuest = 2
            NameQuest = "CakeQuest1"
            NameMon = "Cake Guard"
            CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-08, 0.288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, 0.957576931)
            CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
        elseif MyLevel == 2250 or MyLevel <= 2274 then
            Mon = "Baking Staff"
            LevelQuest = 1
            NameQuest = "CakeQuest2"
            NameMon = "Baking Staff"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
        elseif MyLevel == 2275 or MyLevel <= 2299 then
            Mon = "Head Baker"
            LevelQuest = 2
            NameQuest = "CakeQuest2"
            NameMon = "Head Baker"
            CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, 0.250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
            CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
        elseif MyLevel == 2300 or MyLevel <= 2324 then
            Mon = "Cocoa Warrior"
            LevelQuest = 1
            NameQuest = "ChocQuest1"
            NameMon = "Cocoa Warrior"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
        elseif MyLevel == 2325 or MyLevel <= 2349 then
            Mon = "Chocolate Bar Battler"
            LevelQuest = 2
            NameQuest = "ChocQuest1"
            NameMon = "Chocolate Bar Battler"
            CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
            CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
        elseif MyLevel == 2350 or MyLevel <= 2374 then
            Mon = "Sweet Thief"
            LevelQuest = 1
            NameQuest = "ChocQuest2"
            NameMon = "Sweet Thief"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
        elseif MyLevel == 2375 or MyLevel <= 2399 then
            Mon = "Candy Rebel"
            LevelQuest = 2
            NameQuest = "ChocQuest2"
            NameMon = "Candy Rebel"
            CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
            CFrameMon = CFrame.new(134.86563110351562, 77.2476806640625, -12876.5478515625)
        elseif MyLevel == 2400 or MyLfevel <= 2424 then
            Mon = "Candy Pirate"
            LevelQuest = 1
            NameQuest = "CandyQuest1"
            NameMon = "Candy Pirate"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
        elseif MyLevel == 2425 or MyLevel <= 2449 then
            Mon = "Snow Demon"
            LevelQuest = 2
            NameQuest = "CandyQuest1"
            NameMon = "Snow Demon"
            CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
            CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
        elseif MyLevel == 2450 or MyLevel <= 2474 then
            Mon = "Isle Outlaw"
            LevelQuest = 1
            NameQuest = "TikiQuest1"
            NameMon = "Isle Outlaw"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
        elseif MyLevel == 2475 or MyLevel <= 2499 then
            Mon = "Island Boy"
            LevelQuest = 2
            NameQuest = "TikiQuest1"
            NameMon = "Island Boy"
            CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632812)
            CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351562)
        elseif MyLevel == 2500 or MyLevel <= 2524 then
            Mon = "Sun-kissed Warrior"
            LevelQuest = 1
            NameQuest = "TikiQuest2"
            NameMon = "kissed"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16349.8779296875, 92.0808334350586, 1123.4169921875)
        elseif MyLevel == 2525 or MyLevel <= 2550 then
            Mon = "Isle Champion"
            LevelQuest = 2
            NameQuest = "TikiQuest2"
            NameMon = "Isle Champion"
            CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
            CFrameMon = CFrame.new(-16347.4150390625, 92.09503936767578, 1122.335205078125)
        end
    end
end

spawn(function()
    while task.wait() do
        if not _G.AutoFarmLevel or not checkStopFarm() then
            continue
        end

        pcall(function()
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
            local QuestGui = Player.PlayerGui.Main.Quest

            if not HRP then
                return
            end

            local QuestTitle = QuestGui.Container.QuestTitle.Title.Text

            if not string.find(QuestTitle, NameMon) then
                StartMagnet = false
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
                LevelFarmToggle.Description = "Level Farm"
            end

            CheckQuest()

            if not QuestGui.Visible then
                StartMagnet = false
                topos(CFrameQuest)

                if (HRP.Position - CFrameQuest.Position).Magnitude <= 5 then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                end

                return
            end

            LevelFarmToggle.Description = "Level Farm : " .. Mon

            local Target

            for _, Enemy in ipairs(workspace.Enemies:GetChildren()) do
                local Humanoid = Enemy:FindFirstChild("Humanoid")
                local EnemyHRP = Enemy:FindFirstChild("HumanoidRootPart")

                if Enemy.Name == Mon
                and Humanoid
                and EnemyHRP
                and Humanoid.Health > 0
                and string.find(QuestTitle, NameMon) then
                    Target = Enemy
                    break
                end
            end

            if not Target then
                StartMagnet = false

                local Respawn = checkEnemySpawns(Mon)
                if Respawn and Respawn:FindFirstChild("HumanoidRootPart") then
                    topos(Respawn.HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
                else
                    topos(CFrameMon)
                end

                return
            end

            local Humanoid = Target.Humanoid
            local EnemyHRP = Target.HumanoidRootPart

            LastHealth = Humanoid.Health
            StuckTime = 0

            repeat
                task.wait(_G.Fast_Delay)

                if not Target.Parent then
                    break
                end

                if Humanoid.Health == LastHealth then
                    StuckTime += 1
                else
                    LastHealth = Humanoid.Health
                    StuckTime = 0
                end

                if StuckTime >= 15 then
                    break
                end

                BringPos = EnemyHRP.CFrame
                StartMagnet = true

                topos(EnemyHRP.CFrame * Pos)
                AutoHaki()
                EquipWeapon(_G.SelectTool)
                BringMob(Mon)

                Humanoid.WalkSpeed = 0

                local Head = Target:FindFirstChild("Head")
                if Head then
                    Head.CanCollide = false
                end

            until not _G.AutoFarmLevel
                or not checkStopFarm()
                or not QuestGui.Visible
                or not Target.Parent
                or Humanoid.Health <= 0
        end)
    end
end)

spawn(function()
    while task.wait() do
        local Character = game.Players.LocalPlayer.Character
        local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

        if not HRP then
            continue
        end

        if _G.AutoFarmLevel or _G.AutoFarmNear then
            if not HRP:FindFirstChild("BodyClip") then
                local BodyVelocity = Instance.new("BodyVelocity")
                BodyVelocity.Name = "BodyClip"
                BodyVelocity.Parent = HRP
                BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BodyVelocity.Velocity = Vector3.zero
            end
        else
            local BodyClip = HRP:FindFirstChild("BodyClip")
            if BodyClip then
                BodyClip:Destroy()
            end
        end
    end
end)

function stopTeleport()
    TweenON = false
    local _LocalPlayer = game.Players.LocalPlayer
    if _LocalPlayer.Character:FindFirstChild('PartTele') then
        _LocalPlayer.Character.PartTele:Destroy()
    end
end

spawn(function()
    local Player = game.Players.LocalPlayer

    while task.wait() do
        pcall(function()
            local Character = Player.Character
            if not Character then
                return
            end
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            local PartTele = Character:FindFirstChild("PartTele")
            if not HumanoidRootPart or not PartTele then
                return
            end
            HumanoidRootPart.CFrame = PartTele.CFrame
            if (HumanoidRootPart.Position - PartTele.Position).Magnitude >= 100 then
                stopTeleport()
            end
        end)
    end
end)

spawn(function()
    while wait() do
        if _G.FarmType == "Orbit" then
            Pos = CFrame.new(0, PosY, -20)

            wait(0.1)

            Pos = CFrame.new(-20, PosY, 0)

            wait(0.1)

            Pos = CFrame.new(0, PosY, 20)

            wait(0.1)

            Pos = CFrame.new(20, PosY, 0)
        else
            Pos = CFrame.new(0, PosY, 0)
        end
    end
end)
spawn(function()
    while task.wait(_G.FastAttackSpeed) do
        if not _G.FastAttack then
            continue
        end
        AttackAll()
    end
end)

workspace:GetDescendants(function(v)
    if string.find(v.Name, "Fruit") then
        Window:Notify({
                Title = "Fruit Notification",
                Content = "Fruit "..v.Name.." has spawned!",
                Image = "rbxassetid://10709761889",
                Duration = 15
        })
    end
end)

function storageFruit(v)
    if v:IsA("Tool") and string.find(v.Name, "Fruit") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
        Window:Notify({
                Title = "Auto Storage Fruits",
                Content = "Fruit "..v:GetAttribute("OriginalName").." stored successfully!",
                Image = "rbxassetid://10709761889",
                Duration = 15
        })
    end
end

function reload()
    game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(v)
        if _G.AutoStorageFruits then
            storageFruit(v)
        end
    end)
    workspace._WorldOrigin["Foam;"].CanCollide = _G.WaterWalk
    game.Players.LocalPlayer.Character:SetAttribute("SpeedMultiplier",_G.Speed)
    game.Players.LocalPlayer.Character.ChildAdded:Connect(function(v)
        if _G.AutoStorageFruits then
            storageFruit(v)
        end
    end)
end

game.Players.LocalPlayer.CharacterAdded:connect(reload)
reload()

spawn(function()
    while task.wait(1) do
        if _G.randomFruits then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
        end

        if _G.getFruits then
            _G.ConfigStopFarm.FruitSpawn = false

            for _,v in ipairs(workspace:GetChildren()) do
                if v.Name:find("Fruit") and v:FindFirstChild("Handle") then
                    _G.ConfigStopFarm.FruitSpawn = true
                    topos(v.Handle.CFrame)
                    break
                end
            end
        end
    end
end)

spawn(function()
    while task.wait() do
        if not _G.AutoFarmNear or not checkStopFarm() then
            continue
        end

        pcall(function()
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local HRP = Character and Character:FindFirstChild("HumanoidRootPart")

            if not HRP then
                return
            end

            for _, Enemy in ipairs(workspace.Enemies:GetChildren()) do
                local Humanoid = Enemy:FindFirstChild("Humanoid")
                local EnemyHRP = Enemy:FindFirstChild("HumanoidRootPart")

                if Humanoid and EnemyHRP 
                and Humanoid.Health > 0 
                and (HRP.Position - EnemyHRP.Position).Magnitude <= 1000 then

                    LastHealth = Humanoid.Health
                    StuckTime = 0

                    repeat
                        task.wait(_G.Fast_Delay)

                        if not Enemy.Parent or Humanoid.Health <= 0 then
                                break
                        end

                        if Humanoid.Health == LastHealth then
                            StuckTime += 1
                        else
                            LastHealth = Humanoid.Health
                            StuckTime = 0
                        end

                        -- ficou travado
                        if StuckTime >= 20 then
                            print("NPC travado, pulando:", Enemy.Name)
                            break
                        end

                        topos(EnemyHRP.CFrame * CFrame.new(0, 30, 0))
                        AutoHaki()
                        EquipWeapon(_G.SelectTool)
                        BringPos = EnemyHRP.CFrame
                        BringMob(Enemy.Name)

                        EnemyHRP.Transparency = 1
                        --EnemyHRP.CanCollide = false

                        Humanoid.WalkSpeed = 0
                        Humanoid.JumpPower = 0

                    until not _G.AutoFarmNear or Humanoid.Health <= 0

                    break
                end
            end
        end)
    end
end)

Window = Library:MakeWindow({
  Title = "redz Hub : Blox Fruits",
  SubTitle = "by real_redz",
  ScriptFolder = "redz-library-V5"
})

local Minimizer = Window:NewMinimizer({
  KeyCode = Enum.KeyCode.K
})

local MobileButton = Minimizer:CreateMobileMinimizer({
  Image = "rbxassetid://0",
  BackgroundColor3 = Color3.fromRGB(0, 0, 0)
})

local Tab_Discord = Window:MakeTab({ "Discord", "info" })
local Tab_Farm = Window:MakeTab({ "Farm", "Home" })
local Tab_Sea = Window:MakeTab({ "Sea", "waves" })
local Tab_Race = Window:MakeTab({ "Race", "moon" })
local Tab_Islands = Window:MakeTab({ "Islands", "palmtree" })
local Tab_Quests = Window:MakeTab({ "Quests/Items", "swords" })
local Tab_Fruit = Window:MakeTab({ "Fruit/Raid", "Cherry" })
local Tab_Fishing = Window:MakeTab({ "Fishing", "fish" })
local Tab_WebHook = Window:MakeTab({ "Webhook", "info" })
local Tab_Hop = Window:MakeTab({ "Hop", "diamond" })
local Tab_Status = Window:MakeTab({ "Status", "scroll" })
local Tab_Pvp = Window:MakeTab({ "PvP", "swords" })
local Tab_Stats = Window:MakeTab({ "Stats", "signal" })
local Tab_Teleport = Window:MakeTab({ "Teleport", "locate" })
local Tab_Visual = Window:MakeTab({ "Visual", "user" })
local Tab_Shop = Window:MakeTab({ "Shop", "shoppingcart" })
local Tab_Misc = Window:MakeTab({ "Misc", "settings" })

Tab_Discord:AddDiscordInvite({
    Title = "redz Hub | Community",
    Description = "A community for redz Hub Users -- official scripts, updates, and suport in one place.",
    Banner = "rbxassetid://17382040552", -- You can put an RGB Color: Color3.fromRGB(233, 37, 69)
    Logo = "rbxassetid://17382040552",
    Invite = "https://discord.gg/redz-hub",
    Members = 470000, -- Optional
    Online = 20000, -- Optional
})
Tab_Discord:AddParagraph("Version:", ScriptVersion.Version)
Tab_Discord:AddParagraph("Date:", ScriptVersion.Date)

Tab_Farm:AddDropdown({
  Name = "Select Tool",
  MultiSelect = false,
  Options = {"Melee", "Sword", "Blox Fruit"},
  Default = {"Melee"},
  Flag = "selectTool_flag",
  Callback = function(Value)
     _G.SelectTool = Value
  end
})
Tab_Farm:AddDropdown({
  Name = "UI Scale",
  MultiSelect = false,
  Options = {"Large", "Medium", "Small"},
  Default = {"Large"},
  Flag = "scale_flag",
  Callback = function(Value)
     if Value == "Large" then
        Library:SetUIScale(1)
     elseif Value == "Medium" then
        Library:SetUIScale(.8)
     else
        Library:SetUIScale(0.6)
     end
  end
})

Tab_Farm:AddSection("Farm")

LevelFarmToggle = Tab_Farm:AddToggle({
  Name = "Auto Farm Level",
  Default = false,
  Description = "Level Farm",
  Flag = "farmLevel_flag",
  Callback = function(Value)
    _G.AutoFarmLevel = Value
    stopTeleport()
    --topos(CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125))
  end
})

Tab_Farm:AddToggle({
  Name = "Auto Farm Nearest",
  Default = false,
  Description = "Farm Nearest Mobs",
  Flag = "farmNearest_flag",
  Callback = function(Value)
    _G.AutoFarmNear = Value
    stopTeleport()
  end
})

Tab_Farm:AddToggle({
  Name = "Fast Attack",
  Default = _G.FastAttack,
  Description = "Teste",
  Flag = "fastAttack_flag",
  Callback = function(Value)
    _G.FastAttack = Value
  end
})

Tab_Farm:AddSlider({
  Name = "Fast Attack Speed",
  Min = 0,
  Max = 1,
  Increment = 0.1,
  Default = _G.FastAttackSpeed,
  Flag = "fastAttack_flag",
  Callback = function(Value)
    _G.FastAttackSpeed = Value
  end
})

function debug(msg)
    Window:Notify({
      Title = "Debug",
      Content = msg,
      Image = "rbxassetid://10709752996",
      Duration = 5
    })
end
Tab_Fruit:AddSection("Fruits")
Tab_Fruit:AddToggle({
  Name = "Auto Storage Fruits",
  Default = false,
  Flag = "storageFruits_flag",
  Callback = function(Value)
    _G.AutoStorageFruits = Value
  end
})
Tab_Fruit:AddToggle({
  Name = "Get Fruits",
  Default = false,
  Flag = "getFruits_flag",
  Callback = function(Value)
    _G.getFruits = Value
    stopTeleport()
  end
})
Tab_Fruit:AddToggle({
  Name = "Auto Random Fruit",
  Default = false,
  Flag = "randomFruits_flag",
  Callback = function(Value)
    _G.randomFruits = Value
  end
})

if World1 then
    Tab_Quests:AddSection("Quest Sword")
    Tab_Quests:AddToggle({
      Name = "Auto Get Saber",
      Default = false,
      Description = "Level 200",
      Callback = function(Value)
        _G.AutoSaber = Value
        stopTeleport()
      end
    })
    Tab_Quests:AddToggle({
      Name = "Auto Second Sea",
      Default = false,
      Description = "Level 700",
      Callback = function(Value)
        _G.AutoSecondSea = Value
        stopTeleport()
      end
    })
elseif World2 then
    Tab_Quests:AddSection("Quest Sword")
    Tab_Quests:AddToggle({
              Name = "Auto Get Sword Rengoku",
              Default = false,
              Callback = function(Value)
                _G.AutoLengendary = Value
              end
            })

    Tab_Quests:AddSection("Legendary Sword")
    Tab_Quests:AddParagraph("Legendary Sword Dealer")
    Tab_Quests:AddToggle({
          Name = "Auto Buy Legendary Sword",
          Default = false,
          Callback = function(Value)
            _G.AutoLengendary = Value
          end
        })
elseif World3 then

end

spawn(function()
        while wait() do
            if _G.AutoLengendary then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LegendarySwordDealer',
                    '1',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LegendarySwordDealer',
                    '2',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LegendarySwordDealer',
                    '3',
                }))
            end
        end
    end)

local function Debug(...)
    print("[AutoSecondSea]", ...)
end

spawn(function()
    while task.wait() do
        if _G.AutoSecondSea then
            pcall(function()
                local Player = game.Players.LocalPlayer
                local MyLevel = Player.Data.Level.Value

                Debug("Loop iniciado | Level:", MyLevel)

                if MyLevel >= 700 and World1 then
                    Debug("No World1")

                    local Door = workspace.Map.Ice.Door
                    Debug("Door -> CanCollide:", Door.CanCollide, "| Transparency:", Door.Transparency)

                    if Door.CanCollide == true and Door.Transparency == 0 then
                        Debug("Porta aberta")

                        local CFrame1 = CFrame.new(4849.29883,5.65138149,719.611877)
                        repeat
                            topos(CFrame1)
                            task.wait()
                        until (CFrame1.Position - Player.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoSecondSea

                        Debug("Chegou no primeiro ponto")

                        task.wait(1.1)

                        local Result = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                        Debug("DressrosaQuestProgress:", Result)

                        task.wait(0.5)

                        Debug("Equipando Key")
                        EquipWeapon("Key")

                        repeat
                            topos(CFrame.new(1347.7124,37.3751602,-1325.6488))
                            task.wait()
                        until (Vector3.new(1347.7124,37.3751602,-1325.6488) - Player.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoSecondSea

                        Debug("Chegou na porta")

                    else
                        Debug("Entrou no ELSE")

                        if Door.CanCollide == false and Door.Transparency == 1 then
                            Debug("Porta aberta novamente")

                            local Ice = workspace.Enemies:FindFirstChild("Ice Admiral")

                            if Ice then
                                Debug("Ice Admiral encontrado")

                                for _,v in ipairs(workspace.Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral" then
                                        Debug("HP:", v.Humanoid.Health)

                                        if v.Humanoid.Health > 0 then
                                            Debug("Começando ataque")

                                            OldCFrameSecond = v.HumanoidRootPart.CFrame

                                            repeat
                                                task.wait()

                                                AutoHaki()
                                                EquipWeapon(_G.SelectTool)

                                                --v.HumanoidRootPart.CanCollide = false
                                                v.Head.CanCollide = false
                                                v.Humanoid.WalkSpeed = 0
                                                v.HumanoidRootPart.CFrame = OldCFrameSecond

                                                topos(v.HumanoidRootPart.CFrame * Pos)

                                                sethiddenproperty(Player,"SimulationRadius",math.huge)

                                            until not _G.AutoSecondSea or not v.Parent or v.Humanoid.Health <= 0

                                            Debug("Ice Admiral derrotado")
                                        else
                                            Debug("Boss morto, viajando para Dressrosa")
                                            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDressrosa")
                                        end
                                    end
                                end
                            else
                                Debug("Ice Admiral NÃO encontrado")

                                local Spawn = game.ReplicatedStorage:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")

                                if Spawn and Spawn:FindFirstChild("Ice Admiral") then
                                    Debug("Indo até o spawn do Ice Admiral")

                                    topos(
                                        Spawn["Ice Admiral"].HumanoidRootPart.CFrame *
                                        CFrame.new(5,10,7)
                                    )
                                else
                                    Debug("Spawn do Ice Admiral não encontrado")
                                end
                            end
                        else
                            Debug("Porta fechada")
                        end
                    end
                else
                    Debug("Condição falhou | World1:", World1)
                end
            end)
        end
    end
end)

--if workspace._WorldOrigin["SABER EXPERT Respawn Marker"] and workspace._WorldOrigin["SABER EXPERT Respawn Marker"].RespawnTimer.Frame.Timer then
--    local time = workspace._WorldOrigin["SABER EXPERT Respawn Marker"].RespawnTimer.Frame.Timer.Text
--    text = <font color="rgb(255,0,0)">[06:18]</font>
--end



spawn(function()
        while task.wait() do
            if _G.AutoSaber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                pcall(function()
                    if game:GetService('Workspace').Map.Jungle.Final.Part.Transparency == 0 then
                        if game:GetService('Workspace').Map.Jungle.QuestPlates.Door.Transparency ~= 0 then
                            if game:GetService('Workspace').Map.Desert.Burn.Part.Transparency ~= 0 then
                                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan') == 0 then
                                    if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') ~= 'RichSon' then
                                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') == 0 then
                                            if game:GetService('Workspace').Enemies:FindFirstChild('Mob Leader') or game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader') then
                                                topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))

                                                local v887, v888, v889 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                                while true do
                                                    local v890

                                                    v889, v890 = v887(v888, v889)

                                                    if v889 == nil then
                                                        break
                                                    end
                                                    if v890.Name == 'Mob Leader' then
                                                        if game:GetService('Workspace').Enemies:FindFirstChild('Mob Leader') and (v890:FindFirstChild('Humanoid') and (v890:FindFirstChild('HumanoidRootPart') and v890.Humanoid.Health > 0)) then
                                                            repeat
                                                                task.wait()
                                                                AutoHaki()
                                                                EquipWeapon(_G.SelectTool)

                                                                --v890.HumanoidRootPart.CanCollide = false
                                                                v890.Humanoid.WalkSpeed = 0
                                                                v890.HumanoidRootPart.Size = Vector3.new(80, 80, 80)

                                                                topos(v890.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                                                game:GetService('VirtualUser'):CaptureController()
                                                                game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
                                                                sethiddenproperty(game:GetService('Players').LocalPlayer, 'SimulationRadius', math.huge)
                                                            until v890.Humanoid.Health <= 0 or not _G.AutoSaber
                                                        end
                                                        if game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader [Lv. 120] [Boss]') then
                                                            topos(game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader [Lv. 120] [Boss]').HumanoidRootPart.CFrame * Farm_Mode)
                                                        end
                                                    end
                                                end
                                            end
                                        elseif game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') == 1 then
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                            wait(0.5)
                                            EquipWeapon('Relic')
                                            wait(0.5)
                                            topos(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-9, 0.481375456, 2.53851997e-8, 1, -5.79995607e-8, -0.481375456, 6.30572643e-8, 0.876514494))
                                        end
                                    else
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                    end
                                else
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'GetCup')
                                    wait(0.5)
                                    EquipWeapon('Cup')
                                    wait(0.5)
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'FillCup', game:GetService('Players').LocalPlayer.Character.Cup)
                                    wait(0)
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan')
                                end
                            elseif game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Torch') or game.Players.LocalPlayer.Character:FindFirstChild('Torch') then
                                EquipWeapon('Torch')
                                topos(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-9, 0.761243105, -5.70652914e-10, 1, 1.20584542e-9, -0.761243105, 3.4754488199999996e-10, -0.648466587))
                            else
                                topos(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.0000342372805, -0.258850515, 0.965917408))
                            end
                        elseif (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, -0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, -4.39869794e-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                            topos(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame)
                            wait(1)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate1.Button.CFrame

                            wait(1)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate2.Button.CFrame

                            wait(1)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate3.Button.CFrame

                            wait(1)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate4.Button.CFrame

                            wait(1)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate5.Button.CFrame

                            wait(1)
                        else
                            topos(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, -0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, -4.39869794e-8, 0.37091279))
                        end
                    elseif game:GetService('Workspace').Enemies:FindFirstChild('Saber Expert') or checkEnemySpawns("Saber Expert [Lv. 200] [Boss]") then
                        local v891, v892, v893 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v894

                            v893, v894 = v891(v892, v893)

                            if v893 == nil then
                                break
                            end
                            if v894:FindFirstChild('Humanoid') and (v894:FindFirstChild('HumanoidRootPart') and (v894.Humanoid.Health > 0 and v894.Name == 'Saber Expert')) then
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectTool)
                                    topos(v894.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                    AutoHaki()
                                    v894.HumanoidRootPart.Transparency = 1
                                    v894.Humanoid.JumpPower = 0
                                    v894.Humanoid.WalkSpeed = 0
                                    --v894.HumanoidRootPart.CanCollide = false
                                    FarmPos = v894.HumanoidRootPart.CFrame
                                    MonFarm = v894.Name
                                    _G.ConfigStopFarm.SaberSpawn = true
                                until v894.Humanoid.Health <= 0 or not _G.AutoSaber

                                if v894.Humanoid.Health <= 0 then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'PlaceRelic')
                                end
                            end
                        end
                        else
                            _G.ConfigStopFarm.SaberSpawn = false
                    end
                end)
            end
        end
    end)

Tab_Misc:AddSection("Farm Config")

Tab_Misc:AddDropdown({
  Name = "Farm Type",
  MultiSelect = false,
  Options = {"Up", "Below", "Orbit"},
  Default = {"Up"},
  Flag = "farmType_flag",
  Callback = function(Value)
    if Value == "Up" then
        PosY = 30
    elseif Value == "Below" then
        PosY = -30
    else
        PosY = 30
    end
     _G.FarmType = Value
  end
})

Tab_Misc:AddSection("Config")

Tab_Misc:AddSlider({
  Name = "Tween Speed",
  Min = 50,
  Max = 600,
  Increment = 1,
  Default = 350,
  Flag = "tweenSpeed_flag",
  Callback = function(Value)
    _G.TweenSpeed = Value
  end
})
Tab_Misc:AddSlider({
  Name = "Bring Distance",
  Min = 50,
  Max = 600,
  Increment = 1,
  Default = 350,
  Callback = function(Value)
    _G.BringDistance = Value
  end
})

Tab_Misc:AddSection("Player")

Tab_Misc:AddToggle({
  Name = "Water Walk",
  Default = true,
  Flag = "waterWalk_flag",
  Callback = function(Value)
    _G.WaterWalk = Value
    workspace._WorldOrigin["Foam;"].CanCollide = _G.WaterWalk
  end
})

Tab_Misc:AddSlider({
  Name = "Walk Speed",
  Min = 1,
  Max = 10,
  Increment = 1,
  Default = 1,
  Callback = function(Value)
    game.Players.LocalPlayer.Character:SetAttribute("SpeedMultiplier",_G.Speed)
    _G.Speed = Value
  end
})

Tab_Misc:AddSection("Server")
Tab_Misc:AddButton({
  Name = "Rejoin Server",
  Debounce = 0.5,
  Callback = function()
    game.ReplicatedStorage:WaitForChild("__ServerBrowser"):InvokeServer("teleport", game.JobId)
  end
})

Tab_Stats:AddSection("Auto Stats")
Tab_Stats:AddToggle({Name = "Auto Stats Melee",Default = false,Flag = "statsMelee_flag",
Callback = function(Value)
    melee = Value
end})
Tab_Stats:AddToggle({Name = "Auto Stats Defense",Default = false,Flag = "statsDefense_flag",
Callback = function(Value)
    defense = Value
end})
Tab_Stats:AddToggle({Name = "Auto Stats Sword",Default = false,Flag = "statsSword_flag",
Callback = function(Value)
    sword = Value
end})
Tab_Stats:AddToggle({Name = "Auto Stats Gun",Default = false,Flag = "statsGun_flag",
Callback = function(Value)
    gun = Value
end})
Tab_Stats:AddToggle({Name = "Auto Stats Fruit",Default = false,Flag = "statsFruit_flag",
Callback = function(Value)
    fruit = Value
end})

spawn(function()
    while wait() do
        if game.Players.localPlayer.Data.Points.Value >= 1 then
            if melee then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Melee",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end 
            if defense then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Defense",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end 
            if sword then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Sword",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end 
            if gun then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Gun",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end 
            if fruit then
                local args = {
                    [1] = "AddPoint",
                    [2] = "Demon Fruit",
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        end
    end
end)

local Queue = queue_on_teleport or syn and syn.queue_on_teleport

if Queue then
    Queue('loadstring(game:HttpGet("https://raw.githubusercontent.com/scripting-alt/bloxfruits/refs/heads/main/Main.lua"))()')
end