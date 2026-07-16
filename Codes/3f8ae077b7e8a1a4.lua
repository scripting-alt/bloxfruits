-- ts file was generated at discord.gg/25ms

local v1 = getconnections or get_signal_cons

if v1 then
    local v2, v3, v4 = pairs(v1(game.Players.LocalPlayer.Idled))

    while true do
        local v5, v6 = v2(v3, v4)

        if v5 == nil then
            break
        end

        v4 = v5

        if v6.Disable then
            v6:Disable()
        elseif v6.Disconnect then
            v6:Disconnect()
        end
    end
else
    local _VirtualUser = game:GetService('VirtualUser')

    game:GetService('Players').LocalPlayer.Idled:connect(function()
        _VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        _VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
end

_G.AntiFlagReset = true

spawn(function()
    while wait(2000) do
        if _G.AntiFlagReset then
            game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService('Players').LocalPlayer)
        end
    end
end)

if game:GetService('Players').LocalPlayer.PlayerGui.Main:FindFirstChild('ChooseTeam') then
    while true do
        wait()

        if game:GetService('Players').LocalPlayer.PlayerGui:WaitForChild('Main').ChooseTeam.Visible == true then
            if _G.Team ~= 'Pirates' then
                if _G.Team == 'Marines' then
                    local v8, v9, v10 = pairs(getconnections(game:GetService('Players').LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.TextButton.Activated))

                    while true do
                        local v11

                        v10, v11 = v8(v9, v10)

                        if v10 == nil then
                            break
                        end

                        v11.Function()
                    end
                end
            else
                local v12, v13, v14 = pairs(getconnections(game:GetService('Players').LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.TextButton.Activated))

                while true do
                    local v15

                    v14, v15 = v12(v13, v14)

                    if v14 == nil then
                        break
                    end

                    v15.Function()
                end
            end
        end
        if game.Players.LocalPlayer.Team ~= nil and game:IsLoaded() then
        end
    end
else
    local function u19(p16)
        local v17, v18 = pcall(function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, p16, game.Players.LocalPlayer)
        end)

        if not v17 then
            print(v18)
        end
    end

    local u20 = {
        'rip_indra',
        'wenlocktoad',
        'toilamvidamme',
        'Uzoth',
        'Azarth',
        'Hingoi',
        'Axiore',
        'Death_King',
        'Polkster',
        'Lunoven',
        'TheGreateAced',
        'rip_fud',
        'drip_mama',
        'oofficialnoobie',
        'Daigrock',
        'layandikit12',
        'red_game43',
        'arlthmetic',
    }

    task.spawn(function()
        while wait() do
            local v21, v22, v23 = ipairs(game.Players:GetPlayers())

            while true do
                local v24

                v23, v24 = v21(v22, v23)

                if v23 == nil then
                    break
                end
                if table.find(u20, v24.Name) then
                    local _PlaceId = game.PlaceId
                    local v26 = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. _PlaceId .. '/servers/Public?sortOrder=Asc&limit=100'))

                    if v26 and v26.data and #v26.data > 0 then
                        u19(v26.data[1].id)
                    end
                end
            end
        end
    end)

    if game.PlaceId ~= 2753915549 then
        if game.PlaceId ~= 4442272183 then
            if game.PlaceId ~= 7449423635 then
                game.Players.LocalPlayer:Kick('Script Only Support Blox Fruit')
            else
                World3 = true
            end
        else
            World2 = true
        end
    else
        World1 = true
    end

    function CheckQuest()
        MyLevel = game:GetService('Players').LocalPlayer.Data.Level.Value

        if World1 then
            if MyLevel == 1 or MyLevel <= 9 then
                Mon = 'Bandit'
                LevelQuest = 1
                NameQuest = 'BanditQuest1'
                NameMon = 'Bandit'
                CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, -0, 1, -0, 0.341998369, -0, 0.939700544)
                CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
            elseif MyLevel == 10 or MyLevel <= 14 then
                Mon = 'Monkey'
                LevelQuest = 1
                NameQuest = 'JungleQuest'
                NameMon = 'Monkey'
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
            elseif MyLevel == 15 or MyLevel <= 29 then
                Mon = 'Gorilla'
                LevelQuest = 2
                NameQuest = 'JungleQuest'
                NameMon = 'Gorilla'
                CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
            elseif MyLevel == 30 or MyLevel <= 39 then
                Mon = 'Pirate'
                LevelQuest = 1
                NameQuest = 'BuggyQuest1'
                NameMon = 'Pirate'
                CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
            elseif MyLevel == 40 or MyLevel <= 59 then
                Mon = 'Brute'
                LevelQuest = 2
                NameQuest = 'BuggyQuest1'
                NameMon = 'Brute'
                CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
            elseif MyLevel == 60 or MyLevel <= 74 then
                Mon = 'Desert Bandit'
                LevelQuest = 1
                NameQuest = 'DesertQuest'
                NameMon = 'Desert Bandit'
                CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
            elseif MyLevel == 75 or MyLevel <= 89 then
                Mon = 'Desert Officer'
                LevelQuest = 2
                NameQuest = 'DesertQuest'
                NameMon = 'Desert Officer'
                CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, -0, 1, -0, 0.573571265, -0, 0.819155693)
                CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
            elseif MyLevel == 90 or MyLevel <= 99 then
                Mon = 'Snow Bandit'
                LevelQuest = 1
                NameQuest = 'SnowQuest'
                NameMon = 'Snow Bandit'
                CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
            elseif MyLevel == 100 or MyLevel <= 119 then
                Mon = 'Snowman'
                LevelQuest = 2
                NameQuest = 'SnowQuest'
                NameMon = 'Snowman'
                CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, -0, 0.939684391, -0, 1, -0, -0.939684391, -0, -0.342042685)
                CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
            elseif MyLevel == 120 or MyLevel <= 149 then
                Mon = 'Chief Petty Officer'
                LevelQuest = 1
                NameQuest = 'MarineQuest2'
                NameMon = 'Chief Petty Officer'
                CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
            elseif MyLevel == 150 or MyLevel <= 174 then
                Mon = 'Sky Bandit'
                LevelQuest = 1
                NameQuest = 'SkyQuest'
                NameMon = 'Sky Bandit'
                CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
            elseif MyLevel == 175 or MyLevel <= 189 then
                Mon = 'Dark Master'
                LevelQuest = 2
                NameQuest = 'SkyQuest'
                NameMon = 'Dark Master'
                CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
            elseif MyLevel == 190 or MyLevel <= 209 then
                Mon = 'Prisoner'
                LevelQuest = 1
                NameQuest = 'PrisonerQuest'
                NameMon = 'Prisoner'
                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-9, -0.995993316, 1.60817859e-9, 1, -5.16744869e-9, 0.995993316, -2.06384709e-9, -0.0894274712)
                CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
            elseif MyLevel == 210 or MyLevel <= 249 then
                Mon = 'Dangerous Prisoner'
                LevelQuest = 2
                NameQuest = 'PrisonerQuest'
                NameMon = 'Dangerous Prisoner'
                CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-9, -0.995993316, 1.60817859e-9, 1, -5.16744869e-9, 0.995993316, -2.06384709e-9, -0.0894274712)
                CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
            elseif MyLevel == 250 or MyLevel <= 274 then
                Mon = 'Toga Warrior'
                LevelQuest = 1
                NameQuest = 'ColosseumQuest'
                NameMon = 'Toga Warrior'
                CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
            elseif MyLevel == 275 or MyLevel <= 299 then
                Mon = 'Gladiator'
                LevelQuest = 2
                NameQuest = 'ColosseumQuest'
                NameMon = 'Gladiator'
                CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, -0, -0.857167721, -0, 1, -0, 0.857167721, -0, -0.515037298)
                CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
            elseif MyLevel == 300 or MyLevel <= 324 then
                Mon = 'Military Soldier'
                LevelQuest = 1
                NameQuest = 'MagmaQuest'
                NameMon = 'Military Soldier'
                CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
            elseif MyLevel == 325 or MyLevel <= 374 then
                Mon = 'Military Spy'
                LevelQuest = 2
                NameQuest = 'MagmaQuest'
                NameMon = 'Military Spy'
                CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, -0, 0.866048813, -0, 1, -0, -0.866048813, -0, -0.499959469)
                CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
            elseif MyLevel == 375 or MyLevel <= 399 then
                Mon = 'Fishman Warrior'
                LevelQuest = 1
                NameQuest = 'FishmanQuest'
                NameMon = 'Fishman Warrior'
                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
            elseif MyLevel == 400 or MyLevel <= 449 then
                Mon = 'Fishman Commando'
                LevelQuest = 2
                NameQuest = 'FishmanQuest'
                NameMon = 'Fishman Commando'
                CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
            elseif MyLevel == 450 or MyLevel <= 474 then
                Mon = "God's Guard"
                LevelQuest = 1
                NameQuest = 'SkyExp1Quest'
                NameMon = "God's Guard"
                CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, -0, 1, -0, 0.0871884301, -0, 0.996191859)
                CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
            elseif MyLevel == 475 or MyLevel <= 524 then
                Mon = 'Shanda'
                LevelQuest = 2
                NameQuest = 'SkyExp1Quest'
                NameMon = 'Shanda'
                CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, -0, 0.906319618, -0, 1, -0, -0.906319618, -0, -0.422592998)
                CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
            elseif MyLevel == 525 or MyLevel <= 549 then
                Mon = 'Royal Squad'
                LevelQuest = 1
                NameQuest = 'SkyExp2Quest'
                NameMon = 'Royal Squad'
                CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
            elseif MyLevel == 550 or MyLevel <= 624 then
                Mon = 'Royal Soldier'
                LevelQuest = 2
                NameQuest = 'SkyExp2Quest'
                NameMon = 'Royal Soldier'
                CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
            elseif MyLevel == 625 or MyLevel <= 649 then
                Mon = 'Galley Pirate'
                LevelQuest = 1
                NameQuest = 'FountainQuest'
                NameMon = 'Galley Pirate'
                CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
            elseif MyLevel >= 650 then
                Mon = 'Galley Captain'
                LevelQuest = 2
                NameQuest = 'FountainQuest'
                NameMon = 'Galley Captain'
                CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, 0.087131381)
                CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
            end
        elseif World2 then
            if MyLevel == 700 or MyLevel <= 724 then
                Mon = 'Raider'
                LevelQuest = 1
                NameQuest = 'Area1Quest'
                NameMon = 'Raider'
                CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
                CFrameMon = CFrame.new(-728.3267211914063, 52.779319763183594, 2345.7705078125)
            elseif MyLevel == 725 or MyLevel <= 774 then
                Mon = 'Mercenary'
                LevelQuest = 2
                NameQuest = 'Area1Quest'
                NameMon = 'Mercenary'
                CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, -0, -0.974368095, -0, 1, -0, 0.974368095, -0, -0.22495985)
                CFrameMon = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
            elseif MyLevel == 775 or MyLevel <= 799 then
                Mon = 'Swan Pirate'
                LevelQuest = 1
                NameQuest = 'Area2Quest'
                NameMon = 'Swan Pirate'
                CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, -0, 0.99026376, -0, 1, -0, -0.99026376, -0, 0.139203906)
                CFrameMon = CFrame.new(1068.664306640625, 137.61428833007813, 1322.1060791015625)
            elseif MyLevel == 800 or MyLevel <= 874 then
                Mon = 'Factory Staff'
                NameQuest = 'Area2Quest'
                LevelQuest = 2
                NameMon = 'Factory Staff'
                CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.0773208699999999e-10, -0.0319722369)
                CFrameMon = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
            elseif MyLevel == 875 or MyLevel <= 899 then
                Mon = 'Marine Lieutenant'
                LevelQuest = 1
                NameQuest = 'MarineQuest3'
                NameMon = 'Marine Lieutenant'
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
            elseif MyLevel == 900 or MyLevel <= 949 then
                Mon = 'Marine Captain'
                LevelQuest = 2
                NameQuest = 'MarineQuest3'
                NameMon = 'Marine Captain'
                CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, -0, 0.500031412, -0, 1, -0, -0.500031412, -0, 0.866007268)
                CFrameMon = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
            elseif MyLevel == 950 or MyLevel <= 974 then
                Mon = 'Zombie'
                LevelQuest = 1
                NameQuest = 'ZombieQuest'
                NameMon = 'Zombie'
                CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                CFrameMon = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
            elseif MyLevel == 975 or MyLevel <= 999 then
                Mon = 'Vampire'
                LevelQuest = 2
                NameQuest = 'ZombieQuest'
                NameMon = 'Vampire'
                CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, -0, -0.95628953, -0, 1, -0, 0.95628953, -0, -0.29242146)
                CFrameMon = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
            elseif MyLevel == 1000 or MyLevel <= 1049 then
                Mon = 'Snow Trooper'
                LevelQuest = 1
                NameQuest = 'SnowMountainQuest'
                NameMon = 'Snow Trooper'
                CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                CFrameMon = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
            elseif MyLevel == 1050 or MyLevel <= 1099 then
                Mon = 'Winter Warrior'
                LevelQuest = 2
                NameQuest = 'SnowMountainQuest'
                NameMon = 'Winter Warrior'
                CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, -0, 0.92718488, -0, 1, -0, -0.92718488, -0, -0.374604106)
                CFrameMon = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
            elseif MyLevel == 1100 or MyLevel <= 1124 then
                Mon = 'Lab Subordinate'
                LevelQuest = 1
                NameQuest = 'IceSideQuest'
                NameMon = 'Lab Subordinate'
                CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                CFrameMon = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
            elseif MyLevel == 1125 or MyLevel <= 1174 then
                Mon = 'Horned Warrior'
                LevelQuest = 2
                NameQuest = 'IceSideQuest'
                NameMon = 'Horned Warrior'
                CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, -0, 1, -0, 0.891015649, -0, 0.453972578)
                CFrameMon = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
            elseif MyLevel == 1175 or MyLevel <= 1199 then
                Mon = 'Magma Ninja'
                LevelQuest = 1
                NameQuest = 'FireSideQuest'
                NameMon = 'Magma Ninja'
                CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                CFrameMon = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
            elseif MyLevel == 1200 or MyLevel <= 1249 then
                Mon = 'Lava Pirate'
                LevelQuest = 2
                NameQuest = 'FireSideQuest'
                NameMon = 'Lava Pirate'
                CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                CFrameMon = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
            elseif MyLevel == 1250 or MyLevel <= 1274 then
                Mon = 'Ship Deckhand'
                LevelQuest = 1
                NameQuest = 'ShipQuest1'
                NameMon = 'Ship Deckhand'
                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                CFrameMon = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
            elseif MyLevel == 1275 or MyLevel <= 1299 then
                Mon = 'Ship Engineer'
                LevelQuest = 2
                NameQuest = 'ShipQuest1'
                NameMon = 'Ship Engineer'
                CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016)
                CFrameMon = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
            elseif MyLevel == 1300 or MyLevel <= 1324 then
                Mon = 'Ship Steward'
                LevelQuest = 1
                NameQuest = 'ShipQuest2'
                NameMon = 'Ship Steward'
                CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                CFrameMon = CFrame.new(919.4385375976563, 129.55599975585938, 33436.03515625)
            elseif MyLevel == 1325 or MyLevel <= 1349 then
                Mon = 'Ship Officer'
                LevelQuest = 2
                NameQuest = 'ShipQuest2'
                NameMon = 'Ship Officer'
                CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125)
                CFrameMon = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
            elseif MyLevel == 1350 or MyLevel <= 1374 then
                Mon = 'Arctic Warrior'
                LevelQuest = 1
                NameQuest = 'FrostQuest'
                NameMon = 'Arctic Warrior'
                CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                CFrameMon = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
            elseif MyLevel == 1375 or MyLevel <= 1424 then
                Mon = 'Snow Lurker'
                LevelQuest = 2
                NameQuest = 'FrostQuest'
                NameMon = 'Snow Lurker'
                CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, -0, -0.358349502, -0, 1, -0, 0.358349502, -0, -0.933587909)
                CFrameMon = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
            elseif MyLevel == 1425 or MyLevel <= 1449 then
                Mon = 'Sea Soldier'
                LevelQuest = 1
                NameQuest = 'ForgottenQuest'
                NameMon = 'Sea Soldier'
                CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                CFrameMon = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
            elseif MyLevel >= 1450 then
                Mon = 'Water Fighter'
                LevelQuest = 2
                NameQuest = 'ForgottenQuest'
                NameMon = 'Water Fighter'
                CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, -0, 1, -0, 0.13915664, -0, 0.990270376)
                CFrameMon = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
            end
        elseif World3 then
            if MyLevel == 1500 or MyLevel <= 1524 then
                Mon = 'Pirate Millionaire'
                LevelQuest = 1
                NameQuest = 'PiratePortQuest'
                NameMon = 'Pirate Millionaire'
                CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                CFrameMon = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            elseif MyLevel == 1525 or MyLevel <= 1574 then
                Mon = 'Pistol Billionaire'
                LevelQuest = 2
                NameQuest = 'PiratePortQuest'
                NameMon = 'Pistol Billionaire'
                CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, -0, 1, -0, 0.258804798, -0, 0.965929627)
                CFrameMon = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
            elseif MyLevel == 1575 or MyLevel <= 1599 then
                Mon = 'Dragon Crew Warrior'
                LevelQuest = 1
                NameQuest = 'AmazonQuest'
                NameMon = 'Dragon Crew Warrior'
                CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, -0, 1, -0, 0.438378751, -0, 0.898790359)
                CFrameMon = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
            elseif MyLevel == 1600 or MyLevel <= 1624 then
                Mon = 'Dragon Crew Archer [Lv. 1600]'
                NameQuest = 'AmazonQuest'
                LevelQuest = 2
                NameMon = 'Dragon Crew Archer'
                CFrameQuest = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
                CFrameMon = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
            elseif MyLevel == 1625 or MyLevel <= 1649 then
                Mon = 'Female Islander'
                NameQuest = 'AmazonQuest2'
                LevelQuest = 1
                NameMon = 'Female Islander'
                CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320313)
            elseif MyLevel == 1650 or MyLevel <= 1699 then
                Mon = 'Giant Islander [Lv. 1650]'
                NameQuest = 'AmazonQuest2'
                LevelQuest = 2
                NameMon = 'Giant Islander'
                CFrameQuest = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
                CFrameMon = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
            elseif MyLevel == 1700 or MyLevel <= 1724 then
                Mon = 'Marine Commodore'
                LevelQuest = 1
                NameQuest = 'MarineTreeIsland'
                NameMon = 'Marine Commodore'
                CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, -0, 0.258804798, -0, 1, -0, -0.258804798, -0, -0.965929747)
                CFrameMon = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
            elseif MyLevel == 1725 or MyLevel <= 1774 then
                Mon = 'Marine Rear Admiral [Lv. 1725]'
                NameMon = 'Marine Rear Admiral'
                NameQuest = 'MarineTreeIsland'
                LevelQuest = 2
                CFrameQuest = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
                CFrameMon = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
            elseif MyLevel == 1775 or MyLevel <= 1799 then
                Mon = 'Fishman Raider'
                LevelQuest = 1
                NameQuest = 'DeepForestIsland3'
                NameMon = 'Fishman Raider'
                CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                CFrameMon = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
            elseif MyLevel == 1800 or MyLevel <= 1824 then
                Mon = 'Fishman Captain'
                LevelQuest = 2
                NameQuest = 'DeepForestIsland3'
                NameMon = 'Fishman Captain'
                CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, -0, 0.469463557, -0, 1, -0, -0.469463557, -0, -0.882952213)
                CFrameMon = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
            elseif MyLevel == 1825 or MyLevel <= 1849 then
                Mon = 'Forest Pirate'
                LevelQuest = 1
                NameQuest = 'DeepForestIsland'
                NameMon = 'Forest Pirate'
                CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                CFrameMon = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
            elseif MyLevel == 1850 or MyLevel <= 1899 then
                Mon = 'Mythological Pirate'
                LevelQuest = 2
                NameQuest = 'DeepForestIsland'
                NameMon = 'Mythological Pirate'
                CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, -0, 1, -0, 0.707079291, -0, 0.707134247)
                CFrameMon = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
            elseif MyLevel == 1900 or MyLevel <= 1924 then
                Mon = 'Jungle Pirate'
                LevelQuest = 1
                NameQuest = 'DeepForestIsland2'
                NameMon = 'Jungle Pirate'
                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                CFrameMon = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
            elseif MyLevel == 1925 or MyLevel <= 1974 then
                Mon = 'Musketeer Pirate'
                LevelQuest = 2
                NameQuest = 'DeepForestIsland2'
                NameMon = 'Musketeer Pirate'
                CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, -0, 0.996196866, -0, 1, -0, -0.996196866, -0, -0.0871315002)
                CFrameMon = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
            elseif MyLevel == 1975 or MyLevel <= 1999 then
                Mon = 'Reborn Skeleton'
                LevelQuest = 1
                NameQuest = 'HauntedQuest1'
                NameMon = 'Reborn Skeleton'
                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
            elseif MyLevel == 2000 or MyLevel <= 2024 then
                Mon = 'Living Zombie'
                LevelQuest = 2
                NameQuest = 'HauntedQuest1'
                NameMon = 'Living Zombie'
                CFrameQuest = CFrame.new(-9479.2168, 141.215088, 5566.09277, -0, -0, 1, -0, 1, -0, -1, -0, -0)
                CFrameMon = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
            elseif MyLevel == 2025 or MyLevel <= 2049 then
                Mon = 'Demonic Soul'
                LevelQuest = 1
                NameQuest = 'HauntedQuest2'
                NameMon = 'Demonic Soul'
                CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
            elseif MyLevel == 2050 or MyLevel <= 2074 then
                Mon = 'Posessed Mummy'
                LevelQuest = 2
                NameQuest = 'HauntedQuest2'
                NameMon = 'Posessed Mummy'
                CFrameQuest = CFrame.new(-9516.99316, 172.017181, 6078.46533, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
            elseif MyLevel == 2075 or MyLevel <= 2099 then
                Mon = 'Peanut Scout'
                LevelQuest = 1
                NameQuest = 'NutsIslandQuest'
                NameMon = 'Peanut Scout'
                CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
            elseif MyLevel == 2100 or MyLevel <= 2124 then
                Mon = 'Peanut President'
                LevelQuest = 2
                NameQuest = 'NutsIslandQuest'
                NameMon = 'Peanut President'
                CFrameQuest = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
            elseif MyLevel == 2125 or MyLevel <= 2149 then
                Mon = 'Ice Cream Chef'
                LevelQuest = 1
                NameQuest = 'IceCreamIslandQuest'
                NameMon = 'Ice Cream Chef'
                CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
            elseif MyLevel == 2150 or MyLevel <= 2199 then
                Mon = 'Ice Cream Commander'
                LevelQuest = 2
                NameQuest = 'IceCreamIslandQuest'
                NameMon = 'Ice Cream Commander'
                CFrameQuest = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, -0, -0, -1, -0, 1, -0, 1, -0, -0)
                CFrameMon = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
            elseif MyLevel == 2200 or MyLevel <= 2224 then
                Mon = 'Cookie Crafter'
                LevelQuest = 1
                NameQuest = 'CakeQuest1'
                NameMon = 'Cookie Crafter'
                CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-8, 0.288177818, 6.9301186999999995e-8, 1, 7.5193121099999995e-8, -0.288177818, -5.2032135e-8, 0.957576931)
                CFrameMon = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
            elseif MyLevel == 2225 or MyLevel <= 2249 then
                Mon = 'Cake Guard'
                LevelQuest = 2
                NameQuest = 'CakeQuest1'
                NameMon = 'Cake Guard'
                CFrameQuest = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-8, 0.288177818, 6.9301186999999995e-8, 1, 7.5193121099999995e-8, -0.288177818, -5.2032135e-8, 0.957576931)
                CFrameMon = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
            elseif MyLevel == 2250 or MyLevel <= 2274 then
                Mon = 'Baking Staff'
                LevelQuest = 1
                NameQuest = 'CakeQuest2'
                NameMon = 'Baking Staff'
                CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.2214214299999995e-8, 0.250778586, 4.74911062e-8, 1, 1.49904711e-8, -0.250778586, 2.64211941e-8, -0.96804446)
                CFrameMon = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
            elseif MyLevel == 2275 or MyLevel <= 2299 then
                Mon = 'Head Baker'
                LevelQuest = 2
                NameQuest = 'CakeQuest2'
                NameMon = 'Head Baker'
                CFrameQuest = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.2214214299999995e-8, 0.250778586, 4.74911062e-8, 1, 1.49904711e-8, -0.250778586, 2.64211941e-8, -0.96804446)
                CFrameMon = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
            elseif MyLevel == 2300 or MyLevel <= 2324 then
                Mon = 'Cocoa Warrior'
                LevelQuest = 1
                NameQuest = 'ChocQuest1'
                NameMon = 'Cocoa Warrior'
                CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                CFrameMon = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
            elseif MyLevel == 2325 or MyLevel <= 2349 then
                Mon = 'Chocolate Bar Battler'
                LevelQuest = 2
                NameQuest = 'ChocQuest1'
                NameMon = 'Chocolate Bar Battler'
                CFrameQuest = CFrame.new(233.22836303710938, 29.876001358032227, -12201.2333984375)
                CFrameMon = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
            elseif MyLevel == 2350 or MyLevel <= 2374 then
                Mon = 'Sweet Thief'
                LevelQuest = 1
                NameQuest = 'ChocQuest2'
                NameMon = 'Sweet Thief'
                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                CFrameMon = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
            elseif MyLevel == 2375 or MyLevel <= 2399 then
                Mon = 'Candy Rebel'
                LevelQuest = 2
                NameQuest = 'ChocQuest2'
                NameMon = 'Candy Rebel'
                CFrameQuest = CFrame.new(150.5066375732422, 30.693693161010742, -12774.5029296875)
                CFrameMon = CFrame.new(134.86563110351563, 77.2476806640625, -12876.5478515625)
            elseif MyLevel == 2400 or MyLevel <= 2424 then
                Mon = 'Candy Pirate'
                LevelQuest = 1
                NameQuest = 'CandyQuest1'
                NameMon = 'Candy Pirate'
                CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                CFrameMon = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
            elseif MyLevel == 2425 or MyLevel <= 2449 then
                Mon = 'Snow Demon'
                LevelQuest = 2
                NameQuest = 'CandyQuest1'
                NameMon = 'Snow Demon'
                CFrameQuest = CFrame.new(-1150.0400390625, 20.378934860229492, -14446.3349609375)
                CFrameMon = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
            elseif MyLevel == 2450 or MyLevel <= 2474 then
                Mon = 'Isle Outlaw'
                LevelQuest = 1
                NameQuest = 'TikiQuest1'
                NameMon = 'Isle Outlaw'
                CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632813)
                CFrameMon = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
            elseif MyLevel == 2475 or MyLevel <= 2499 then
                Mon = 'Island Boy'
                LevelQuest = 2
                NameQuest = 'TikiQuest1'
                NameMon = 'Island Boy'
                CFrameQuest = CFrame.new(-16547.748046875, 61.13533401489258, -173.41360473632813)
                CFrameMon = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351563)
            elseif MyLevel == 2500 or MyLevel <= 2524 then
                Mon = 'Sun-kissed Warrior'
                LevelQuest = 1
                NameQuest = 'TikiQuest2'
                NameMon = 'Sun-kissed Warrior'
                CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
                CFrameMon = CFrame.new(-16349.8779296875, 92.0808334350586, 1123.4169921875)
            elseif MyLevel == 2525 or MyLevel <= 2550 then
                Mon = 'Isle Champion'
                LevelQuest = 2
                NameQuest = 'TikiQuest2'
                NameMon = 'Isle Champion'
                CFrameQuest = CFrame.new(-16539.078125, 55.68632888793945, 1051.5738525390625)
                CFrameMon = CFrame.new(-16933.2129, 93.3503036, 999.450989)
            end
        end
    end
    function MaterialMon()
        if World1 then
            if SelectMaterial ~= 'Magma Ore' then
                if SelectMaterial == 'Leather' or SelectMaterial == 'Scrap Metal' then
                    MMon = 'Brute'
                    MPos = CFrame.new(-1145, 15, 4350)
                    MMon1 = 'Pirate'
                    MPos1 = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
                elseif SelectMaterial ~= 'Angel Wings' then
                    if SelectMaterial == 'Fish Tail' then
                        MMon = 'Fishman Warrior'
                        MPos = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
                        MMon1 = 'Fishman Commando'
                        MPos1 = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                    end
                else
                    MMon = "God's Guard"
                    MPos = CFrame.new(-4698, 845, -1912)
                    MMon1 = "God's Guard"
                    MPos1 = CFrame.new(-4698, 845, -1912)
                end
            else
                MMon = 'Military Soldier'
                MPos = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
                MMon1 = 'Military Spy'
                MPos1 = CFrame.new(-5815, 84, 8820)
            end
        end
        if World2 then
            if SelectMaterial ~= 'Magma Ore' then
                if SelectMaterial == 'Leather' or SelectMaterial == 'Scrap Metal' then
                    MMon = 'Marine Captain'
                    MPos = CFrame.new(-2010, 73, -3326)
                    MMon1 = 'Marine Captain'
                    MPos1 = CFrame.new(-2010, 73, -3326)
                elseif SelectMaterial ~= 'Radioactive Material' then
                    if SelectMaterial ~= 'Vampire Fang' then
                        if SelectMaterial == 'Mystic Droplet' then
                            MMon = 'Water Fighter'
                            MPos = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
                            MMon1 = 'Sea Soldier'
                            MPos1 = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
                        end
                    else
                        MMon = 'Vampire'
                        MPos = CFrame.new(-6033, 7, -1317)
                        MMon1 = 'Vampire'
                        MPos1 = CFrame.new(-6033, 7, -1317)
                    end
                else
                    MMon = 'Factory Staff'
                    MPos = CFrame.new(295, 73, -56)
                    MMon1 = 'Factory Staff'
                    MPos1 = CFrame.new(295, 73, -56)
                end
            else
                MMon = 'Magma Ninja'
                MPos = CFrame.new(-5428, 78, -5959)
                MMon1 = 'Lava Pirate'
                MPos1 = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
            end
        end
        if World3 then
            if SelectMaterial ~= 'Mini Tusk' then
                if SelectMaterial ~= 'Fish Tail' then
                    if SelectMaterial == 'Leather' or SelectMaterial == 'Scrap Metal' then
                        MMon = 'Jungle Pirate'
                        MPos = CFrame.new(-12107, 332, -10549)
                        MMon1 = 'Jungle Pirate'
                        MPos1 = CFrame.new(-12107, 332, -10549)
                    elseif SelectMaterial ~= 'Dragon Scale' then
                        if SelectMaterial ~= 'Conjured Cocoa' then
                            if SelectMaterial ~= 'Demonic Wisp' then
                                if SelectMaterial == 'Gunpowder' then
                                    MMon = 'Pistol Billionaire'
                                    MPos = CFrame.new(-469, 74, 5904)
                                    MMon1 = 'Pistol Billionaire'
                                    MPos1 = CFrame.new(-469, 74, 5904)
                                end
                            else
                                MMon = 'Demonic Soul'
                                MPos = CFrame.new(-9507, 172, 6158)
                                MMon1 = 'Demonic Soul'
                                MPos1 = CFrame.new(-9507, 172, 6158)
                            end
                        else
                            MMon = 'Cocoa Warrior'
                            MPos = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
                            MMon1 = 'Chocolate Bar Battler'
                            MPos1 = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
                        end
                    else
                        MMon = 'Dragon Crew Warrior'
                        MPos = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
                        MMon1 = 'Dragon Crew Warrior'
                        MPos1 = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
                    end
                else
                    MMon = 'Fishman Raider'
                    MPos = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
                    MMon1 = 'Fishman Captain'
                    MPos1 = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                end
            else
                MMon = 'Mythological Pirate'
                MPos = CFrame.new(-13545, 470, -6917)
                MMon1 = 'Mythological Pirate'
                MPos1 = CFrame.new(-13545, 470, -6917)
            end
        end
    end
    function CheckMonFarm()
        if World1 then
            if SelectMob ~= 'Bandit' then
                if SelectMob ~= 'Monkey' then
                    if SelectMob ~= 'Gorilla' then
                        if SelectMob ~= 'Pirate' then
                            if SelectMob ~= 'Brute' then
                                if SelectMob ~= 'Desert Bandit' then
                                    if SelectMob ~= 'Desert Officer' then
                                        if SelectMob ~= 'Snow Bandit' then
                                            if SelectMob ~= 'Snowman' then
                                                if SelectMob ~= 'Chief Petty Officer' then
                                                    if SelectMob ~= 'Sky Bandit' then
                                                        if SelectMob ~= 'Dark Master' then
                                                            if SelectMob ~= 'Prisoner' then
                                                                if SelectMob ~= 'Dangerous Prisoner' then
                                                                    if SelectMob ~= 'Toga Warrior' then
                                                                        if SelectMob ~= 'Gladiator' then
                                                                            if SelectMob ~= 'Military Soldier' then
                                                                                if SelectMob ~= 'Military Spy' then
                                                                                    if SelectMob ~= 'Fishman Warrior' then
                                                                                        if SelectMob ~= 'Fishman Commando' then
                                                                                            if SelectMob ~= "God's Guard" then
                                                                                                if SelectMob ~= 'Shanda' then
                                                                                                    if SelectMob ~= 'Royal Squad' then
                                                                                                        if SelectMob ~= 'Royal Soldier' then
                                                                                                            if SelectMob ~= 'Galley Pirate' then
                                                                                                                if SelectMob == 'Galley Captain' then
                                                                                                                    PosMonster = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375)
                                                                                                                end
                                                                                                            else
                                                                                                                PosMonster = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875)
                                                                                                            end
                                                                                                        else
                                                                                                            PosMonster = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625)
                                                                                                        end
                                                                                                    else
                                                                                                        PosMonster = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875)
                                                                                                    end
                                                                                                else
                                                                                                    PosMonster = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531)
                                                                                                end
                                                                                            else
                                                                                                PosMonster = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375)
                                                                                            end
                                                                                        else
                                                                                            PosMonster = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875)
                                                                                        end
                                                                                    else
                                                                                        PosMonster = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625)
                                                                                    end
                                                                                else
                                                                                    PosMonster = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375)
                                                                                end
                                                                            else
                                                                                PosMonster = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875)
                                                                            end
                                                                        else
                                                                            PosMonster = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625)
                                                                        end
                                                                    else
                                                                        PosMonster = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625)
                                                                    end
                                                                else
                                                                    PosMonster = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375)
                                                                end
                                                            else
                                                                PosMonster = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781)
                                                            end
                                                        else
                                                            PosMonster = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625)
                                                        end
                                                    else
                                                        PosMonster = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625)
                                                    end
                                                else
                                                    PosMonster = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625)
                                                end
                                            else
                                                PosMonster = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
                                            end
                                        else
                                            PosMonster = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125)
                                        end
                                    else
                                        PosMonster = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875)
                                    end
                                else
                                    PosMonster = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375)
                                end
                            else
                                PosMonster = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875)
                            end
                        else
                            PosMonster = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125)
                        end
                    else
                        PosMonster = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875)
                    end
                else
                    PosMonster = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209)
                end
            else
                PosMonster = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125)
            end
        elseif World2 then
            if SelectMob ~= 'Raider' then
                if SelectMob ~= 'Mercenary' then
                    if SelectMob ~= 'Swan Pirate' then
                        if SelectMob ~= 'Factory Staff' then
                            if SelectMob ~= 'Marine Lieutenant' then
                                if SelectMob ~= 'Marine Captain' then
                                    if SelectMob ~= 'Zombie' then
                                        if SelectMob ~= 'Vampire' then
                                            if SelectMob ~= 'Snow Trooper' then
                                                if SelectMob ~= 'Winter Warrior' then
                                                    if SelectMob ~= 'Lab Subordinate' then
                                                        if SelectMob ~= 'Horned Warrior' then
                                                            if SelectMob ~= 'Magma Ninja' then
                                                                if SelectMob ~= 'Lava Pirate' then
                                                                    if SelectMob ~= 'Ship Deckhand' then
                                                                        if SelectMob ~= 'Ship Engineer' then
                                                                            if SelectMob ~= 'Ship Steward' then
                                                                                if SelectMob ~= 'Ship Officer' then
                                                                                    if SelectMob ~= 'Arctic Warrior' then
                                                                                        if SelectMob ~= 'Snow Lurker' then
                                                                                            if SelectMob ~= 'Sea Soldier' then
                                                                                                if SelectMob == 'Water Fighter' then
                                                                                                    PosMonster = CFrame.new(-3352.9013671875, 285.01556396484375, -10534.841796875)
                                                                                                end
                                                                                            else
                                                                                                PosMonster = CFrame.new(-3028.2236328125, 64.67451477050781, -9775.4267578125)
                                                                                            end
                                                                                        else
                                                                                            PosMonster = CFrame.new(5407.07373046875, 69.19437408447266, -6880.88037109375)
                                                                                        end
                                                                                    else
                                                                                        PosMonster = CFrame.new(5966.24609375, 62.97002029418945, -6179.3828125)
                                                                                    end
                                                                                else
                                                                                    PosMonster = CFrame.new(1036.0179443359375, 181.4390411376953, 33315.7265625)
                                                                                end
                                                                            else
                                                                                PosMonster = CFrame.new(919.4385375976563, 129.55599975585938, 33436.03515625)
                                                                            end
                                                                        else
                                                                            PosMonster = CFrame.new(919.4786376953125, 43.54401397705078, 32779.96875)
                                                                        end
                                                                    else
                                                                        PosMonster = CFrame.new(1212.0111083984375, 150.79205322265625, 33059.24609375)
                                                                    end
                                                                else
                                                                    PosMonster = CFrame.new(-5213.33154296875, 49.73788070678711, -4701.451171875)
                                                                end
                                                            else
                                                                PosMonster = CFrame.new(-5449.6728515625, 76.65874481201172, -5808.20068359375)
                                                            end
                                                        else
                                                            PosMonster = CFrame.new(-6341.36669921875, 15.951770782470703, -5723.162109375)
                                                        end
                                                    else
                                                        PosMonster = CFrame.new(-5707.4716796875, 15.951709747314453, -4513.39208984375)
                                                    end
                                                else
                                                    PosMonster = CFrame.new(1142.7451171875, 475.6398010253906, -5199.41650390625)
                                                end
                                            else
                                                PosMonster = CFrame.new(549.1473388671875, 427.3870544433594, -5563.69873046875)
                                            end
                                        else
                                            PosMonster = CFrame.new(-6037.66796875, 32.18463897705078, -1340.6597900390625)
                                        end
                                    else
                                        PosMonster = CFrame.new(-5657.77685546875, 78.96973419189453, -928.68701171875)
                                    end
                                else
                                    PosMonster = CFrame.new(-1861.2310791015625, 80.17658233642578, -3254.697509765625)
                                end
                            else
                                PosMonster = CFrame.new(-2821.372314453125, 75.89727783203125, -3070.089111328125)
                            end
                        else
                            PosMonster = CFrame.new(73.07867431640625, 81.86344146728516, -27.470672607421875)
                        end
                    else
                        PosMonster = CFrame.new(1068.664306640625, 137.61428833007813, 1322.1060791015625)
                    end
                else
                    PosMonster = CFrame.new(-1004.3244018554688, 80.15886688232422, 1424.619384765625)
                end
            else
                PosMonster = CFrame.new(-728.3267211914063, 52.779319763183594, 2345.7705078125)
            end
        elseif World3 then
            if SelectMob ~= 'Pirate Millionaire' then
                if SelectMob ~= 'Pistol Billionaire' then
                    if SelectMob ~= 'Dragon Crew Warrior' then
                        if SelectMob ~= 'Dragon Crew Archer' then
                            if SelectMob ~= 'Female Islander' then
                                if SelectMob ~= 'Giant Islander' then
                                    if SelectMob ~= 'Marine Commodore' then
                                        if SelectMob ~= 'Marine Rear Admiral' then
                                            if SelectMob ~= 'Fishman Raider' then
                                                if SelectMob ~= 'Fishman Captain' then
                                                    if SelectMob ~= 'Forest Pirate' then
                                                        if SelectMob ~= 'Mythological Pirate' then
                                                            if SelectMob ~= 'Jungle Pirate' then
                                                                if SelectMob ~= 'Musketeer Pirate' then
                                                                    if SelectMob ~= 'Reborn Skeleton' then
                                                                        if SelectMob ~= 'Living Zombie' then
                                                                            if SelectMob ~= 'Demonic Soul' then
                                                                                if SelectMob ~= 'Posessed Mummy' then
                                                                                    if SelectMob ~= 'Peanut Scout' then
                                                                                        if SelectMob ~= 'Peanut President' then
                                                                                            if SelectMob ~= 'Ice Cream Chef' then
                                                                                                if SelectMob ~= 'Ice Cream Commander' then
                                                                                                    if SelectMob ~= 'Cookie Crafter' then
                                                                                                        if SelectMob ~= 'Cake Guard' then
                                                                                                            if SelectMob ~= 'Baking Staff' then
                                                                                                                if SelectMob ~= 'Head Baker' then
                                                                                                                    if SelectMob ~= 'Cocoa Warrior' then
                                                                                                                        if SelectMob ~= 'Chocolate Bar Battler' then
                                                                                                                            if SelectMob ~= 'Sweet Thief' then
                                                                                                                                if SelectMob ~= 'Candy Rebel' then
                                                                                                                                    if SelectMob ~= 'Candy Pirate' then
                                                                                                                                        if SelectMob ~= 'Snow Demon' then
                                                                                                                                            if SelectMob ~= 'Isle Outlaw' then
                                                                                                                                                if SelectMob ~= 'Island Boy' then
                                                                                                                                                    if SelectMob ~= 'Sun-kissed Warrior' then
                                                                                                                                                        if SelectMob == 'Isle Champion' then
                                                                                                                                                            PosMonster = CFrame.new(-16347.4150390625, 92.09503936767578, 1122.335205078125)
                                                                                                                                                        end
                                                                                                                                                    else
                                                                                                                                                        PosMonster = CFrame.new(-16349.8779296875, 92.0808334350586, 1123.4169921875)
                                                                                                                                                    end
                                                                                                                                                else
                                                                                                                                                    PosMonster = CFrame.new(-16901.26171875, 84.06756591796875, -192.88906860351563)
                                                                                                                                                end
                                                                                                                                            else
                                                                                                                                                PosMonster = CFrame.new(-16442.814453125, 116.13899993896484, -264.4637756347656)
                                                                                                                                            end
                                                                                                                                        else
                                                                                                                                            PosMonster = CFrame.new(-880.2006225585938, 71.24776458740234, -14538.609375)
                                                                                                                                        end
                                                                                                                                    else
                                                                                                                                        PosMonster = CFrame.new(-1310.5003662109375, 26.016523361206055, -14562.404296875)
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    PosMonster = CFrame.new(134.86563110351563, 77.2476806640625, -12876.5478515625)
                                                                                                                                end
                                                                                                                            else
                                                                                                                                PosMonster = CFrame.new(165.1884765625, 76.05885314941406, -12600.8369140625)
                                                                                                                            end
                                                                                                                        else
                                                                                                                            PosMonster = CFrame.new(582.590576171875, 77.18809509277344, -12463.162109375)
                                                                                                                        end
                                                                                                                    else
                                                                                                                        PosMonster = CFrame.new(-21.55328369140625, 80.57499694824219, -12352.3876953125)
                                                                                                                    end
                                                                                                                else
                                                                                                                    PosMonster = CFrame.new(-2216.188232421875, 82.884521484375, -12869.2939453125)
                                                                                                                end
                                                                                                            else
                                                                                                                PosMonster = CFrame.new(-1887.8099365234375, 77.6185073852539, -12998.3505859375)
                                                                                                            end
                                                                                                        else
                                                                                                            PosMonster = CFrame.new(-1598.3070068359375, 43.773197174072266, -12244.5810546875)
                                                                                                        end
                                                                                                    else
                                                                                                        PosMonster = CFrame.new(-2374.13671875, 37.79826354980469, -12125.30859375)
                                                                                                    end
                                                                                                else
                                                                                                    PosMonster = CFrame.new(-558.06103515625, 112.04895782470703, -11290.7744140625)
                                                                                                end
                                                                                            else
                                                                                                PosMonster = CFrame.new(-872.24658203125, 65.81957244873047, -10919.95703125)
                                                                                            end
                                                                                        else
                                                                                            PosMonster = CFrame.new(-1859.35400390625, 38.10316848754883, -10422.4296875)
                                                                                        end
                                                                                    else
                                                                                        PosMonster = CFrame.new(-2143.241943359375, 47.72198486328125, -10029.9951171875)
                                                                                    end
                                                                                else
                                                                                    PosMonster = CFrame.new(-9582.0224609375, 6.251527309417725, 6205.478515625)
                                                                                end
                                                                            else
                                                                                PosMonster = CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625)
                                                                            end
                                                                        else
                                                                            PosMonster = CFrame.new(-10144.1318359375, 138.62667846679688, 5838.0888671875)
                                                                        end
                                                                    else
                                                                        PosMonster = CFrame.new(-8763.7236328125, 165.72299194335938, 6159.86181640625)
                                                                    end
                                                                else
                                                                    PosMonster = CFrame.new(-13457.904296875, 391.545654296875, -9859.177734375)
                                                                end
                                                            else
                                                                PosMonster = CFrame.new(-12256.16015625, 331.73828125, -10485.8369140625)
                                                            end
                                                        else
                                                            PosMonster = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
                                                        end
                                                    else
                                                        PosMonster = CFrame.new(-13274.478515625, 332.3781433105469, -7769.58056640625)
                                                    end
                                                else
                                                    PosMonster = CFrame.new(-10994.701171875, 352.38140869140625, -9002.1103515625)
                                                end
                                            else
                                                PosMonster = CFrame.new(-10407.5263671875, 331.76263427734375, -8368.5166015625)
                                            end
                                        else
                                            PosMonster = CFrame.new(3656.773681640625, 160.52406311035156, -7001.5986328125)
                                        end
                                    else
                                        PosMonster = CFrame.new(2286.0078125, 73.13391876220703, -7159.80908203125)
                                    end
                                else
                                    PosMonster = CFrame.new(4729.09423828125, 590.436767578125, -36.97627639770508)
                                end
                            else
                                PosMonster = CFrame.new(4685.25830078125, 735.8078002929688, 815.3425903320313)
                            end
                        else
                            PosMonster = CFrame.new(6616.41748046875, 441.7670593261719, 446.0469970703125)
                        end
                    else
                        PosMonster = CFrame.new(6141.140625, 51.35136413574219, -1340.738525390625)
                    end
                else
                    PosMonster = CFrame.new(-187.3301544189453, 86.23987579345703, 6013.513671875)
                end
            else
                PosMonster = CFrame.new(-245.9963836669922, 47.30615234375, 5584.1005859375)
            end
        end
    end
    function CheckBossQuest()
        if SelectBoss ~= 'Saber Expert' then
            if SelectBoss ~= 'The Saw' then
                if SelectBoss ~= 'Greybeard' then
                    if SelectBoss ~= 'The Gorilla King' then
                        if SelectBoss ~= 'Bobby' then
                            if SelectBoss ~= 'Yeti' then
                                if SelectBoss ~= 'Mob Leader' then
                                    if SelectBoss ~= 'Vice Admiral' then
                                        if SelectBoss ~= 'Warden' then
                                            if SelectBoss ~= 'Chief Warden' then
                                                if SelectBoss ~= 'Swan' then
                                                    if SelectBoss ~= 'Magma Admiral' then
                                                        if SelectBoss ~= 'Fishman Lord' then
                                                            if SelectBoss ~= 'Wysper' then
                                                                if SelectBoss ~= 'Thunder God' then
                                                                    if SelectBoss ~= 'Cyborg' then
                                                                        if SelectBoss ~= 'Diamond' then
                                                                            if SelectBoss ~= 'Jeremy' then
                                                                                if SelectBoss ~= 'Fajita' then
                                                                                    if SelectBoss ~= 'Don Swan' then
                                                                                        if SelectBoss ~= 'Smoke Admiral' then
                                                                                            if SelectBoss ~= 'Cursed Captain' then
                                                                                                if SelectBoss ~= 'Darkbeard' then
                                                                                                    if SelectBoss ~= 'Order' then
                                                                                                        if SelectBoss ~= 'Awakened Ice Admiral' then
                                                                                                            if SelectBoss ~= 'Tide Keeper' then
                                                                                                                if SelectBoss ~= 'Stone' then
                                                                                                                    if SelectBoss ~= 'Island Empress' then
                                                                                                                        if SelectBoss ~= 'Kilo Admiral' then
                                                                                                                            if SelectBoss ~= 'Captain Elephant' then
                                                                                                                                if SelectBoss ~= 'Beautiful Pirate' then
                                                                                                                                    if SelectBoss ~= 'Cake Queen' then
                                                                                                                                        if SelectBoss ~= 'rip_indra True Form' then
                                                                                                                                            if SelectBoss ~= 'Longma' then
                                                                                                                                                if SelectBoss == 'Soul Reaper' then
                                                                                                                                                    MsBoss = 'Soul Reaper'
                                                                                                                                                    NameBoss = 'Soul Reaper'
                                                                                                                                                    CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
                                                                                                                                                end
                                                                                                                                            else
                                                                                                                                                MsBoss = 'Longma'
                                                                                                                                                NameBoss = 'Longma'
                                                                                                                                                CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
                                                                                                                                            end
                                                                                                                                        else
                                                                                                                                            MsBoss = 'rip_indra True Form'
                                                                                                                                            NameBoss = 'rip_indra True Form'
                                                                                                                                            CFrameBoss = CFrame.new(-5359, 424, -2735)
                                                                                                                                        end
                                                                                                                                    else
                                                                                                                                        MsBoss = 'Cake Queen'
                                                                                                                                        NameBoss = 'Cake Queen'
                                                                                                                                        NameQuestBoss = 'IceCreamIslandQuest'
                                                                                                                                        LevelQuestBoss = 3
                                                                                                                                        CFrameQuestBoss = CFrame.new(-716, 382, -11010)
                                                                                                                                        CFrameBoss = CFrame.new(-821, 66, -10965)
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    MsBoss = 'Beautiful Pirate'
                                                                                                                                    NameBoss = 'Beautiful Pirate'
                                                                                                                                    NameQuestBoss = 'DeepForestIsland2'
                                                                                                                                    LevelQuestBoss = 3
                                                                                                                                    CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
                                                                                                                                    CFrameBoss = CFrame.new(5182, 23, -20)
                                                                                                                                end
                                                                                                                            else
                                                                                                                                MsBoss = 'Captain Elephant'
                                                                                                                                NameBoss = 'Captain Elephant'
                                                                                                                                NameQuestBoss = 'DeepForestIsland'
                                                                                                                                LevelQuestBoss = 3
                                                                                                                                CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
                                                                                                                                CFrameBoss = CFrame.new(-13221, 325, -8405)
                                                                                                                            end
                                                                                                                        else
                                                                                                                            MsBoss = 'Kilo Admiral'
                                                                                                                            NameBoss = 'Kilo Admiral'
                                                                                                                            NameQuestBoss = 'MarineTreeIsland'
                                                                                                                            LevelQuestBoss = 3
                                                                                                                            CFrameQuestBoss = CFrame.new(2178, 29, -6737)
                                                                                                                            CFrameBoss = CFrame.new(2846, 433, -7100)
                                                                                                                        end
                                                                                                                    else
                                                                                                                        MsBoss = 'Island Empress'
                                                                                                                        NameBoss = 'Island Empress'
                                                                                                                        NameQuestBoss = 'AmazonQuest2'
                                                                                                                        LevelQuestBoss = 3
                                                                                                                        CFrameQuestBoss = CFrame.new(5443, 602, 752)
                                                                                                                        CFrameBoss = CFrame.new(5659, 602, 244)
                                                                                                                    end
                                                                                                                else
                                                                                                                    MsBoss = 'Stone'
                                                                                                                    NameBoss = 'Stone'
                                                                                                                    NameQuestBoss = 'PiratePortQuest'
                                                                                                                    LevelQuestBoss = 3
                                                                                                                    CFrameQuestBoss = CFrame.new(-290, 44, 5577)
                                                                                                                    CFrameBoss = CFrame.new(-1085, 40, 6779)
                                                                                                                end
                                                                                                            else
                                                                                                                MsBoss = 'Tide Keeper'
                                                                                                                NameBoss = 'Tide Keeper'
                                                                                                                NameQuestBoss = 'ForgottenQuest'
                                                                                                                LevelQuestBoss = 3
                                                                                                                CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-9, 0.16681771, -3.07832915e-9, 1, 3.29612559e-9, -0.16681771, 2.73641976e-9, -0.985987961)
                                                                                                                CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857325999999999e-8, 0.885206044, 4.0332897e-9, 1, 1.35347511e-8, -0.885206044, -2.72606271e-9, 0.465199202)
                                                                                                            end
                                                                                                        else
                                                                                                            MsBoss = 'Awakened Ice Admiral'
                                                                                                            NameBoss = 'Awakened Ice Admiral'
                                                                                                            NameQuestBoss = 'FrostQuest'
                                                                                                            LevelQuestBoss = 3
                                                                                                            CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-8, 0.388910472, 4.72230788e-8, 1, -7.96414241e-8, -0.388910472, 9.17372489e-8, 0.921275556)
                                                                                                            CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-8, -0.871432424, -2.76146022e-8, 1, -7.58250565e-8, 0.871432424, 6.125763009999999e-8, 0.49051559)
                                                                                                        end
                                                                                                    else
                                                                                                        MsBoss = 'Order'
                                                                                                        NameBoss = 'Order'
                                                                                                        CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-8, 0.924687505, 5.85604774e-8, 1, -5.6073854899999995e-8, -0.924687505, 3.28013137e-8, -0.380726993)
                                                                                                    end
                                                                                                else
                                                                                                    MsBoss = 'Darkbeard'
                                                                                                    NameBoss = 'Darkbeard'
                                                                                                    CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-8, 0.213458836, 4.57335361e-8, 1, -2.3686862200000003e-8, -0.213458836, -1.33787044e-8, -0.976951957)
                                                                                                end
                                                                                            else
                                                                                                MsBoss = 'Cursed Captain'
                                                                                                NameBoss = 'Cursed Captain'
                                                                                                CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.263104949999999e-9, 0.0314563364, 8.42916226e-9, 1, -2.6643713e-8, -0.0314563364, -2.63653774e-8, -0.999505103)
                                                                                            end
                                                                                        else
                                                                                            MsBoss = 'Smoke Admiral'
                                                                                            NameBoss = 'Smoke Admiral'
                                                                                            NameQuestBoss = 'IceSideQuest'
                                                                                            LevelQuestBoss = 3
                                                                                            CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-9, 0.895534337, -3.64098796e-8, 1, -1.4644522e-8, -0.895534337, -3.91229982e-8, -0.444992423)
                                                                                            CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-8, -0.967869282, 4.02796978e-8, 1, 2.57916977e-8, 0.967869282, -4.54708946e-8, 0.251453817)
                                                                                        end
                                                                                    else
                                                                                        MsBoss = 'Don Swan'
                                                                                        NameBoss = 'Don Swan'
                                                                                        CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-8, -0.0227668174, 8.4774733e-8, 1, 2.75850098e-8, 0.0227668174, -2.95079072e-8, 0.99974072)
                                                                                    end
                                                                                else
                                                                                    MsBoss = 'Fajita'
                                                                                    NameBoss = 'Fajita'
                                                                                    NameQuestBoss = 'MarineQuest3'
                                                                                    LevelQuestBoss = 3
                                                                                    CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-8, -0.486752301, 5.64383384e-8, 1, -1.4322078599999999e-8, 0.486752301, -3.9982399600000003e-8, -0.873540044)
                                                                                    CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-9, -0.275756449, -2.3212845e-9, 1, -1.34094433e-8, 0.275756449, 1.35296352e-8, 0.961227536)
                                                                                end
                                                                            else
                                                                                MsBoss = 'Jeremy'
                                                                                NameBoss = 'Jeremy'
                                                                                NameQuestBoss = 'Area2Quest'
                                                                                LevelQuestBoss = 3
                                                                                CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.0773208699999999e-10, -0.0319722369)
                                                                                CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
                                                                            end
                                                                        else
                                                                            MsBoss = 'Diamond'
                                                                            NameBoss = 'Diamond'
                                                                            NameQuestBoss = 'Area1Quest'
                                                                            LevelQuestBoss = 3
                                                                            CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-8, 0.967323601, -6.0014777100000005e-8, 1, 3.04272909e-8, -0.967323601, -6.576839699999999e-8, 0.253544956)
                                                                            CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
                                                                        end
                                                                    else
                                                                        MsBoss = 'Cyborg'
                                                                        NameBoss = 'Cyborg'
                                                                        NameQuestBoss = 'FountainQuest'
                                                                        LevelQuestBoss = 3
                                                                        CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-8, -0.999936521, 2.55291371e-10, 1, -9.93769547e-8, 0.999936521, -1.37512213e-9, -0.0112687312)
                                                                        CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-9, -0.826346457, -5.94632716e-8, 1, 4.26280238e-8, 0.826346457, 7.31437524e-8, -0.563162148)
                                                                    end
                                                                else
                                                                    MsBoss = 'Thunder God'
                                                                    NameBoss = 'Thunder God'
                                                                    NameQuestBoss = 'SkyExp2Quest'
                                                                    LevelQuestBoss = 3
                                                                    CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-7, 0.999347389, 1.4453396299999999e-9, 1, 1.17024491e-7, -0.999347389, 5.6715117e-9, -0.0361216255)
                                                                    CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-8, -0.261550069, -6.73089886e-8, 1, -6.46515304e-8, 0.261550069, 8.00056768e-8, 0.965189934)
                                                                end
                                                            else
                                                                MsBoss = 'Wysper'
                                                                NameBoss = 'Wysper'
                                                                NameQuestBoss = 'SkyExp1Quest'
                                                                LevelQuestBoss = 3
                                                                CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-8, -0.886386991, 1.0534996e-8, 1, 2.19553424e-8, 0.886386991, -1.95022007e-8, 0.462944925)
                                                                CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-9, 0.697619379, 3.37381434e-9, 1, -1.70304748e-9, -0.697619379, 3.57381835e-9, 0.716468513)
                                                            end
                                                        else
                                                            MsBoss = 'Fishman Lord'
                                                            NameBoss = 'Fishman Lord'
                                                            NameQuestBoss = 'FishmanQuest'
                                                            LevelQuestBoss = 3
                                                            CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-7, 0.374700129, -6.98219367e-8, 1, -1.10790765e-7, -0.374700129, 7.65569368e-8, 0.927145958)
                                                            CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
                                                        end
                                                    else
                                                        MsBoss = 'Magma Admiral'
                                                        NameBoss = 'Magma Admiral'
                                                        NameQuestBoss = 'MagmaQuest'
                                                        LevelQuestBoss = 3
                                                        CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.6550880599999998e-8, -0.859131515, -3.9113157199999997e-8, 1, -5.42026761e-8, 0.859131515, 6.1341829400000005e-8, 0.51175487)
                                                        CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-8, 0.513919294, 1.53689133e-8, 1, -6.91265853e-8, -0.513919294, 6.719783840000001e-8, 0.857838571)
                                                    end
                                                else
                                                    MsBoss = 'Swan'
                                                    NameBoss = 'Swan'
                                                    NameQuestBoss = 'ImpelQuest'
                                                    LevelQuestBoss = 3
                                                    CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-8, -0.842635691, 1.38001752e-8, 1, -8.813007919999999e-8, 0.842635691, -5.90851599e-8, -0.538484037)
                                                    CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-8, 0.330433697, 3.47818627e-8, 1, 3.81658154e-8, -0.330433697, -2.45289105e-8, 0.943829298)
                                                end
                                            else
                                                MsBoss = 'Chief Warden'
                                                NameBoss = 'Chief Warden'
                                                NameQuestBoss = 'ImpelQuest'
                                                LevelQuestBoss = 2
                                                CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-8, -0.842635691, 1.38001752e-8, 1, -8.813007919999999e-8, 0.842635691, -5.90851599e-8, -0.538484037)
                                                CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-8, 0.330433697, 3.47818627e-8, 1, 3.81658154e-8, -0.330433697, -2.45289105e-8, 0.943829298)
                                            end
                                        else
                                            MsBoss = 'Warden'
                                            NameBoss = 'Warden'
                                            NameQuestBoss = 'ImpelQuest'
                                            LevelQuestBoss = 1
                                            CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-8, -0.842635691, 1.38001752e-8, 1, -8.813007919999999e-8, 0.842635691, -5.90851599e-8, -0.538484037)
                                            CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-8, 0.330433697, 3.47818627e-8, 1, 3.81658154e-8, -0.330433697, -2.45289105e-8, 0.943829298)
                                        end
                                    else
                                        MsBoss = 'Vice Admiral'
                                        NameBoss = 'Vice Admiral'
                                        NameQuestBoss = 'MarineQuest2'
                                        LevelQuestBoss = 2
                                        CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-8, 0.998130739, -1.57416586e-8, 1, 8.00271849e-8, -0.998130739, -1.08217701e-8, -0.0611100644)
                                        CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.3550828600000004e-8, 1, -4.23449258e-8, -0.831466436, -7.636616319999999e-8, -0.555574954)
                                    end
                                else
                                    MsBoss = 'Mob Leader'
                                    NameBoss = 'Mob Leader'
                                    CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-8, 0.371961564, -7.61816636e-8, 1, 4.44474857e-8, -0.371961564, 1.29216433e-8, -0.92824)
                                end
                            else
                                MsBoss = 'Yeti'
                                NameBoss = 'Yeti'
                                NameQuestBoss = 'SnowQuest'
                                LevelQuestBoss = 3
                                CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-8, -0.959938943, -6.756908279999999e-8, 1, 8.6151708e-9, 0.959938943, 6.24481444e-8, 0.280209213)
                                CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-8, 0.936994851, 6.29478194e-8, 1, 7.783842900000001e-8, -0.936994851, 3.1789465299999997e-8, 0.349343032)
                            end
                        else
                            MsBoss = 'Bobby'
                            NameBoss = 'Bobby'
                            NameQuestBoss = 'BuggyQuest1'
                            LevelQuestBoss = 3
                            CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.585705399999999e-9, 0.280922383, -4.06310328e-8, 1, -1.11807175e-7, -0.280922383, -1.18718916e-7, -0.959730506)
                            CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.1653087399999995e-10, 1, 1.0889780199999999e-9, 0.29113996, -1.19218679e-9, 0.956680477)
                        end
                    else
                        MsBoss = 'The Gorilla King'
                        NameBoss = 'The Gorilla King'
                        NameQuestBoss = 'JungleQuest'
                        LevelQuestBoss = 3
                        CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-6, -0.997892559, 1.41431883e-7, 1, -4.70933674e-6, 0.997892559, 1.64442184e-7, 0.0648873374)
                        CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-8, 0.950426519, -3.3727548799999996e-8, 1, 7.065018080000001e-8, -0.950426519, -5.40241736e-8, 0.310949147)
                    end
                else
                    MsBoss = 'Greybeard'
                    NameBoss = 'Greybeard'
                    CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-8, 0.901083171, -3.0443168e-8, 1, -3.17633075e-9, -0.901083171, -2.88092288e-8, -0.433646321)
                end
            else
                MsBoss = 'The Saw'
                NameBoss = 'The Saw'
                CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.8836577299999995e-8, 0.956968188, 6.9841362899999995e-8, 1, -5.07531119e-8, -0.956968188, 5.21077759e-8, -0.290192783)
            end
        else
            MsBoss = 'Saber Expert'
            NameBoss = 'Saber Expert'
            CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-8, 0.512275636, -4.85649254e-9, 1, -1.40823326e-8, -0.512275636, 9.6063415e-9, 0.858821094)
        end
    end
    function isnil(p27)
        return p27 == nil
    end

    local function u29(p28)
        return math.floor(tonumber(p28) + 0.5)
    end

    Number = math.random(1, 1000000)

    function UpdatePlayerChams()
        local v30, v31, v32 = pairs(game:GetService('Players'):GetChildren())

        while true do
            local u33

            v32, u33 = v30(v31, v32)

            if v32 == nil then
                break
            end

            pcall(function()
                if not isnil(u33.Character) then
                    if _G.ESPPlayer then
                        if isnil(u33.Character.Head) or u33.Character.Head:FindFirstChild('NameEsp' .. Number) then
                            u33.Character.Head['NameEsp' .. Number].TextLabel.Text = '[ Player: ' .. u33.Name .. ' ]\n[ Distance: ' .. u29((game:GetService('Players').LocalPlayer.Character.Head.Position - u33.Character.Head.Position).Magnitude / 3) .. 'm ]'
                        else
                            local _BillboardGui = Instance.new('BillboardGui', u33.Character.Head)

                            _BillboardGui.Name = 'NameEsp' .. Number
                            _BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
                            _BillboardGui.Size = UDim2.new(1, 200, 1, 30)
                            _BillboardGui.Adornee = u33.Character.Head
                            _BillboardGui.AlwaysOnTop = true

                            local _TextLabel = Instance.new('TextLabel', _BillboardGui)

                            _TextLabel.Font = Enum.Font.GothamSemibold
                            _TextLabel.FontSize = 'Size12'
                            _TextLabel.TextWrapped = true
                            _TextLabel.Size = UDim2.new(1, 0, 1, 0)
                            _TextLabel.TextYAlignment = 'Top'
                            _TextLabel.BackgroundTransparency = 1
                            _TextLabel.TextStrokeTransparency = 0.5
                            _TextLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
                        end
                    elseif u33.Character.Head:FindFirstChild('NameEsp' .. Number) then
                        u33.Character.Head:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end)
        end
    end
    function UpdateIslandESP()
        local v36, v37, v38 = pairs(game:GetService('Workspace')._WorldOrigin.Locations:GetChildren())

        while true do
            local u39

            v38, u39 = v36(v37, v38)

            if v38 == nil then
                break
            end

            pcall(function()
                if _G.IslandESP then
                    if u39.Name ~= 'Sea' then
                        if u39:FindFirstChild('NameEsp') then
                            u39.NameEsp.TextLabel.Text = '[ Island: ' .. u39.Name .. ' ]\n[ Distance: ' .. u29((game:GetService('Players').LocalPlayer.Character.Head.Position - u39.Position).Magnitude / 3) .. 'm ]'
                        else
                            local _BillboardGui2 = Instance.new('BillboardGui', u39)

                            _BillboardGui2.Name = 'NameEsp'
                            _BillboardGui2.ExtentsOffset = Vector3.new(0, 1, 0)
                            _BillboardGui2.Size = UDim2.new(1, 200, 1, 30)
                            _BillboardGui2.Adornee = u39
                            _BillboardGui2.AlwaysOnTop = true

                            local _TextLabel2 = Instance.new('TextLabel', _BillboardGui2)

                            _TextLabel2.Font = 'GothamBold'
                            _TextLabel2.FontSize = 'Size12'
                            _TextLabel2.TextWrapped = true
                            _TextLabel2.Size = UDim2.new(1, 0, 1, 0)
                            _TextLabel2.TextYAlignment = 'Top'
                            _TextLabel2.BackgroundTransparency = 1
                            _TextLabel2.TextStrokeTransparency = 0.5
                            _TextLabel2.TextColor3 = Color3.fromRGB(255, 165, 0)
                        end
                    end
                elseif u39:FindFirstChild('NameEsp') then
                    u39:FindFirstChild('NameEsp'):Destroy()
                end
            end)
        end
    end
    function UpdateChestChams()
        local v42, v43, v44 = pairs(game.Workspace:GetChildren())

        while true do
            local u45

            v44, u45 = v42(v43, v44)

            if v44 == nil then
                break
            end

            pcall(function()
                if string.find(u45.Name, 'Chest') then
                    if _G.ChestESP then
                        if string.find(u45.Name, 'Chest') then
                            if u45:FindFirstChild('NameEsp' .. Number) then
                                u45['NameEsp' .. Number].TextLabel.Text = '[ ' .. u45.Name .. ' ]\n[ Distance: ' .. u29((game:GetService('Players').LocalPlayer.Character.Head.Position - u45.Position).Magnitude / 3) .. 'm ]'
                            else
                                local _BillboardGui3 = Instance.new('BillboardGui', u45)

                                _BillboardGui3.Name = 'NameEsp' .. Number
                                _BillboardGui3.ExtentsOffset = Vector3.new(0, 1, 0)
                                _BillboardGui3.Size = UDim2.new(1, 200, 1, 30)
                                _BillboardGui3.Adornee = u45
                                _BillboardGui3.AlwaysOnTop = true

                                local _TextLabel3 = Instance.new('TextLabel', _BillboardGui3)

                                _TextLabel3.Font = Enum.Font.GothamSemibold
                                _TextLabel3.FontSize = 'Size12'
                                _TextLabel3.TextWrapped = true
                                _TextLabel3.Size = UDim2.new(1, 0, 1, 0)
                                _TextLabel3.TextYAlignment = 'Top'
                                _TextLabel3.BackgroundTransparency = 1
                                _TextLabel3.TextStrokeTransparency = 0.5

                                if u45.Name == 'Chest1' then
                                    _TextLabel3.TextColor3 = Color3.fromRGB(128, 128, 128)
                                end
                                if u45.Name == 'Chest2' then
                                    _TextLabel3.TextColor3 = Color3.fromRGB(255, 255, 0)
                                end
                                if u45.Name == 'Chest3' then
                                    _TextLabel3.TextColor3 = Color3.fromRGB(0, 191, 255)
                                end
                            end
                        end
                    elseif u45:FindFirstChild('NameEsp' .. Number) then
                        u45:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end)
        end
    end
    function UpdateDevilChams()
        local v48, v49, v50 = pairs(game.Workspace:GetChildren())

        while true do
            local u51

            v50, u51 = v48(v49, v50)

            if v50 == nil then
                break
            end

            pcall(function()
                if _G.DevilFruitESP then
                    if string.find(u51.Name, 'Fruit') then
                        if u51.Handle:FindFirstChild('NameEsp' .. Number) then
                            u51.Handle['NameEsp' .. Number].TextLabel.Text = '[ ' .. u51.Name .. ' ]\n[ Distance: ' .. u29((game:GetService('Players').LocalPlayer.Character.Head.Position - u51.Handle.Position).Magnitude / 3) .. 'm ]'
                        else
                            local _BillboardGui4 = Instance.new('BillboardGui', u51.Handle)

                            _BillboardGui4.Name = 'NameEsp' .. Number
                            _BillboardGui4.ExtentsOffset = Vector3.new(0, 1, 0)
                            _BillboardGui4.Size = UDim2.new(1, 200, 1, 30)
                            _BillboardGui4.Adornee = u51.Handle
                            _BillboardGui4.AlwaysOnTop = true

                            local _TextLabel4 = Instance.new('TextLabel', _BillboardGui4)

                            _TextLabel4.Font = Enum.Font.GothamSemibold
                            _TextLabel4.FontSize = 'Size12'
                            _TextLabel4.TextWrapped = true
                            _TextLabel4.Size = UDim2.new(1, 0, 1, 0)
                            _TextLabel4.TextYAlignment = 'Top'
                            _TextLabel4.BackgroundTransparency = 1
                            _TextLabel4.TextStrokeTransparency = 0.5
                            _TextLabel4.TextColor3 = Color3.fromRGB(255, 255, 255)
                        end
                    end
                elseif u51.Handle:FindFirstChild('NameEsp' .. Number) then
                    u51.Handle:FindFirstChild('NameEsp' .. Number):Destroy()
                end
            end)
        end
    end
    function UpdateFlowerChams()
        local v54, v55, v56 = pairs(game.Workspace:GetChildren())

        while true do
            local u57

            v56, u57 = v54(v55, v56)

            if v56 == nil then
                break
            end

            pcall(function()
                if u57.Name == 'Flower2' or u57.Name == 'Flower1' then
                    if _G.FlowerESP then
                        if u57:FindFirstChild('NameEsp' .. Number) then
                            u57['NameEsp' .. Number].TextLabel.Text = '[ ' .. u57.Name .. ' ]\n[ Distance: ' .. u29((game:GetService('Players').LocalPlayer.Character.Head.Position - u57.Position).Magnitude / 3) .. 'm ]'
                        else
                            local _BillboardGui5 = Instance.new('BillboardGui', u57)

                            _BillboardGui5.Name = 'NameEsp' .. Number
                            _BillboardGui5.ExtentsOffset = Vector3.new(0, 1, 0)
                            _BillboardGui5.Size = UDim2.new(1, 200, 1, 30)
                            _BillboardGui5.Adornee = u57
                            _BillboardGui5.AlwaysOnTop = true

                            local _TextLabel5 = Instance.new('TextLabel', _BillboardGui5)

                            _TextLabel5.Font = Enum.Font.GothamSemibold
                            _TextLabel5.FontSize = 'Size12'
                            _TextLabel5.TextWrapped = true
                            _TextLabel5.Size = UDim2.new(1, 0, 1, 0)
                            _TextLabel5.TextYAlignment = 'Top'
                            _TextLabel5.BackgroundTransparency = 1
                            _TextLabel5.TextStrokeTransparency = 0.5
                            _TextLabel5.TextColor3 = Color3.fromRGB(255, 0, 0)

                            if u57.Name == 'Flower1' then
                                _TextLabel5.TextColor3 = Color3.fromRGB(0, 0, 255)
                            end
                            if u57.Name == 'Flower2' then
                                _TextLabel5.TextColor3 = Color3.fromRGB(255, 0, 0)
                            end
                        end
                    elseif u57:FindFirstChild('NameEsp' .. Number) then
                        u57:FindFirstChild('NameEsp' .. Number):Destroy()
                    end
                end
            end)
        end
    end
    function UnEquipWeapon(p60)
        if game.Players.LocalPlayer.Character:FindFirstChild(p60) then
            _G.NotAutoEquip = true

            wait(0.5)

            game.Players.LocalPlayer.Character:FindFirstChild(p60).Parent = game.Players.LocalPlayer.Backpack

            wait(0.1)

            _G.NotAutoEquip = false
        end
    end
    function EquipWeapon(p61)
        if game.Players.LocalPlayer.Backpack:FindFirstChild(p61) then
            local v62 = game.Players.LocalPlayer.Backpack:FindFirstChild(p61)

            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v62)
        end
    end
    function GetDistance(p63, p64)
        local u65 = p64 or game.Players.LocalPlayer.Character.HumanoidRootPart
        local v66, v67 = pcall(function()
            a = p63.Position
            a2 = u65.Position
        end)

        bbos2 = v67
        bbos = v66

        if bbos then
            a = p63.Position
            a2 = u65.Position

            return (a - a2).Magnitude
        end
    end

    local _LocalPlayer = game.Players.LocalPlayer
    local _Workspace = game:GetService('Workspace')

    NpcList = {}

    local v70, v71, v72 = pairs(_Workspace.NPCs:GetChildren())

    while true do
        local v73, v74 = v70(v71, v72)

        if v73 == nil then
            break
        end

        v72 = v73

        if string.find(string.lower(v74.Name), 'home point') then
            table.insert(NpcList, v74:GetModelCFrame())
        end
    end

    local v75, v76, v77 = pairs(getnilinstances())

    while true do
        local v78, v79 = v75(v76, v77)

        if v78 == nil then
            break
        end

        v77 = v78

        if string.find(string.lower(v79.Name), 'home point') then
            table.insert(NpcList, v79:GetModelCFrame())
        end
    end

    local _PlaceId2 = game.PlaceId

    if _PlaceId2 == 2753915549 then
        World1 = true
        gQ = {
            Vector3.new(-7894.6201171875, 5545.49169921875, -380.246346191406),
            Vector3.new(-4607.82275390625, 872.5422973632813, -1667.556884765625),
            Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
            Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875),
        }
    elseif _PlaceId2 == 4442272183 then
        World2 = true
        gQ = {
            Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320313),
            Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
            Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
            Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422),
        }
    elseif _PlaceId2 == 7449423635 then
        World3 = true
        gQ = {
            Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
            Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
            Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
            Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
            Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
            Vector3.new(5314.58203125, 25.419387817382813, -125.94227600097656),
        }
    end

    function GetPortal(p81)
        local _Position = p81.Position
        local v83 = Vector3.new(0, 0, 0)
        local _huge = math.huge
        local v85, v86, v87 = pairs(gQ)

        while true do
            local v88

            v87, v88 = v85(v86, v87)

            if v87 == nil then
                break
            end
            if (v88 - _Position).Magnitude < _huge and v83 ~= v88 then
                _huge = (v88 - _Position).Magnitude
                v83 = v88
            end
        end

        return v83
    end
    function BypassTeleport(p89)
        if _LocalPlayer.Character:FindFirstChild('PartTele') then
            _LocalPlayer.Character.PartTele.CFrame = CFrame.new(_LocalPlayer.Character.PartTele.CFrame.X, _LocalPlayer.Character.PartTele.CFrame.Y, _LocalPlayer.Character.PartTele.CFrame.Z)

            wait(0.5)

            _LocalPlayer.Character.PartTele.CFrame = p89

            wait(0.1)

            _LocalPlayer.Character.PrimaryPart.CFrame = p89

            _LocalPlayer.Character:WaitForChild('Humanoid'):ChangeState(15)
            wait(0.5)

            repeat
                wait()
            until _LocalPlayer.Character:FindFirstChild('Humanoid') and _LocalPlayer.Character.Humanoid.Health <= 0

            while true do
                wait()

                if _LocalPlayer.Character:FindFirstChild('PartTele') then
                    _LocalPlayer.Character.PartTele.CFrame = p89
                end
                if _LocalPlayer.Character:FindFirstChild('PrimaryPart') then
                    _LocalPlayer.Character.PrimaryPart.CFrame = p89
                end
                if _LocalPlayer.Character:FindFirstChild('Humanoid') and 0 < _LocalPlayer.Character.Humanoid.Health then
                end
            end
        else
            return
        end
    end
    function GetBypassPos(p90)
        local v91 = Vector3.new(p90.X, p90.Y, p90.Z)
        local _huge2 = math.huge
        local v93, v94, v95 = pairs(NpcList)
        local v96 = nil

        while true do
            local v97

            v95, v97 = v93(v94, v95)

            if v95 == nil then
                break
            end
            if (v97.p - v91).Magnitude < _huge2 then
                _huge2 = (v97.p - v91).Magnitude
                v96 = v97
            end
        end

        return v96
    end
    function RequestEntrance(p98)
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack({
            'requestEntrance',
            p98,
        }))

        if _LocalPlayer.Character:FindFirstChild('PartTele') then
            _LocalPlayer.Character.PartTele.CFrame = WaitHRP(_LocalPlayer).CFrame
        end

        wait(0.01)
    end
    function WaitHRP(p99)
        if p99 then
            return p99.Character:WaitForChild('HumanoidRootPart', 9)
        end
    end
    function CalcDistance(p100, p101)
        local v102 = p101 or _LocalPlayer.Character.PrimaryPart.CFrame

        return (Vector3.new(p100.X, 0, p100.Z) - Vector3.new(v102.X, 0, v102.Z)).Magnitude
    end
    function topos(p103)
        if p103 then
            if not _LocalPlayer.Character:FindFirstChild('PartTele') then
                local _Part = Instance.new('Part', _LocalPlayer.Character)

                _Part.Size = Vector3.new(0, 0, 0)
                _Part.Name = 'PartTele'
                _Part.Anchored = true
                _Part.Transparency = 1
                _Part.CanCollide = false
                _Part.CFrame = WaitHRP(_LocalPlayer).CFrame

                local v105 = _Part

                _Part.GetPropertyChangedSignal(v105, 'CFrame'):Connect(function()
                    task.wait(0.01)

                    WaitHRP(_LocalPlayer).CFrame = _Part.CFrame
                end)
            end

            Portal = GetPortal(p103)
            Spawn = GetBypassPos(p103)
            MyCFrame = WaitHRP(_LocalPlayer).CFrame
            Distance = CalcDistance(MyCFrame, p103)

            if CalcDistance(Portal, p103) < CalcDistance(p103) and 500 < CalcDistance(Portal) then
                return RequestEntrance(Portal)
            end
            if _G.BypassTele == true and 1000 < CalcDistance(p103) - CalcDistance(Spawn, p103) and CalcDistance(Spawn) > 1000 then
                return BypassTeleport(Spawn)
            end
            if _LocalPlayer.Character:FindFirstChild('Humanoid') and (_LocalPlayer.Character.Humanoid:FindFirstChild('Sit') and _LocalPlayer.Character.Humanoid.Sit == true) then
                _LocalPlayer.Character.Humanoid.Sit = false
            end
            if Distance <= 250 then
                _LocalPlayer.Character.HumanoidRootPart.CFrame = p103
            end

            Tween = game:GetService('TweenService'):Create(_LocalPlayer.Character.PartTele, TweenInfo.new(Distance / _G.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = p103})

            Tween:Play()
        end
    end
    function Tween(p106)
        Distance = (p106.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        Tween = game:GetService('TweenService'):Create(_LocalPlayer.Character.PartTele, TweenInfo.new(Distance / _G.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = p106})

        Tween:Play()
    end
    function StopTween(p107)
        if not p107 then
            topos(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame)
            game:GetService('TweenService'):Create(_LocalPlayer.Character.PartTele, TweenInfo.new(Distance / _G.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = Pos}):Cancel()
        end
    end

    spawn(function()
        while task.wait() do
            if (_LocalPlayer.Character:FindFirstChild('Humanoid').Health <= 0 or not _LocalPlayer.Character:FindFirstChild('HumanoidRootPart')) and _LocalPlayer.Character:FindFirstChild('TweenSmooth') then
                _LocalPlayer.Character:FindFirstChild('TweenSmooth'):Destroy()
            end
            if (_LocalPlayer.Character.HumanoidRootPart.Position - _LocalPlayer.Character:FindFirstChild('PartTele').Position).Magnitude <= 100 and _LocalPlayer.Character:FindFirstChild('PartTele') then
                _LocalPlayer.Character:FindFirstChild('PartTele'):Destroy()
            end
        end
    end)

    Type = 1

    spawn(function()
        while wait() do
            Type = 1

            wait(0.5)

            Type = 2

            wait(0.5)

            Type = 3

            wait(0.5)

            Type = 4

            wait(0.5)
        end
    end)
    spawn(function()
        while wait() do
            if Type ~= 1 then
                if Type ~= 2 then
                    if Type ~= 3 then
                        if Type == 4 then
                            Pos = CFrame.new(-20, 30, 0)
                        end
                    else
                        Pos = CFrame.new(0, 30, 20)
                    end
                else
                    Pos = CFrame.new(20, 30, 0)
                end
            else
                Pos = CFrame.new(0, 30, -20)
            end
        end
    end)
    spawn(function()
        while wait() do
            if Type ~= 1 then
                if Type ~= 2 then
                    if Type ~= 3 then
                        if Type == 4 then
                            PosSea = CFrame.new(-60, 400, 0)
                        end
                    else
                        PosSea = CFrame.new(0, 400, 60)
                    end
                else
                    PosSea = CFrame.new(60, 400, 0)
                end
            else
                PosSea = CFrame.new(0, 400, -60)
            end
        end
    end)
    spawn(function()
        while wait() do
            if Type ~= 1 then
                if Type ~= 2 then
                    if Type ~= 3 then
                        if Type == 4 then
                            PosCaMap = CFrame.new(-30, 60, 0)
                        end
                    else
                        PosCaMap = CFrame.new(0, 60, 30)
                    end
                else
                    PosCaMap = CFrame.new(30, 60, 0)
                end
            else
                PosCaMap = CFrame.new(0, 60, -30)
            end
        end
    end)
    spawn(function()
        game:GetService('RunService').Stepped:Connect(function()
            pcall(function()
                if _G.AutoFarm or (_G.FarmSkip or _G.AutoFarmNearest) or (_G.AutoDoughtBoss or _G.Auto_Bone or (_G.Auto_Soul_Reaper or _G.AutoFarmFruitMastery)) or (_G.AutoFarmGunMastery or _G.FarmAllSword or (_G.FarmAllMelee or _G.AutoFarmBoss) or (_G.AutoAllBoss or _G.AutoFarmMob or (_G.AutoMaterial or _G.Tweenfruit))) or (_G.NextIsland or _G.AutoOderSword or (_G.RaidPirate or _G.AutoFactory) or (_G.AutoElitehunter or _G.ChestBypass or (_G.AutoFarmChest or _G.TeleSafe)) or (_G.AutoSpawnRip or _G.AutoKillRipIndra or (_G.AutoSpawnDark or _G.AutoKillDark) or (_G.AutoObservation or _G.AutoObservationv2 or (_G.Auto_Rainbow_Haki or _G.AutoYama)))) or (_G.AutoHolyTorch or _G.Autotushita or (_G.Auto_Saber or _G.Autowaden) or (_G.AutoRengoku or _G.Autopole or (_G.Autosaw or _G.AutoCarvender)) or (_G.Auto_Dragon_Trident or _G.AutoTwinHook or (_G.AutoCarvender or _G.AutoBudySword) or (_G.AutoSerpentBow or _G.Auto_EvoRace or (_G.AutoMusketeerHat or _G.AutoSecondSea))) or (_G.AutoThirdSea or _G.Teleport or (_G.AutoKillFishCrew or _G.RelzFishBoat) or (_G.RelzPirateGrandBrigade or _G.RelzPirateBrigade or (_G.AutoTerrorshark or _G.AutoSeaBest)) or (_G.AutoKillShark or _G.AutoKillPiranha or (_G.TeleportKitsune or _G.CollectAzure) or (_G.TweenMGear or _G.AutoMysticIsland or (_G.Miragenpc or _G.AutoQuestRace))))) or (_G.KillAfterTrials or _G.TeleportIsland) then
                    if not game:GetService('Players').LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyVelocity') then
                        local _BodyVelocity = Instance.new('BodyVelocity')

                        _BodyVelocity.Name = 'BodyVelocity'
                        _BodyVelocity.P = 9000
                        _BodyVelocity.Parent = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart
                        _BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                        _BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end

                    local v109, v110, v111 = pairs(game:GetService('Players').LocalPlayer.Character:GetDescendants())

                    while true do
                        local v112

                        v111, v112 = v109(v110, v111)

                        if v111 == nil then
                            break
                        end
                        if v112:IsA('BasePart') then
                            v112.CanCollide = false
                        end
                    end
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild('BodyVelocity'):Destroy()
                end
            end)
        end)
    end)
    spawn(function()
        while task.wait() do
            if setscriptable then
                setscriptable(game.Players.LocalPlayer, 'SimulationRadius', true)
            end
            if sethiddenproperty then
                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
            end
        end
    end)

    function CheckMob(p113)
        local v114, v115, v116 = pairs(game:GetService('ReplicatedStorage'):GetChildren())

        while true do
            local v117

            v116, v117 = v114(v115, v116)

            if v116 == nil then
                break
            end
            if v117.Name == p113 then
                return v117
            end
        end

        local v118, v119, v120 = pairs(game.workspace.Enemies:GetChildren())

        while true do
            local v121

            v120, v121 = v118(v119, v120)

            if v120 == nil then
                break
            end
            if v121.Name == p113 then
                return v121
            end
        end
    end
    function CheckAncientOneStatus()
        if game.Players.LocalPlayer.Character:FindFirstChild('RaceTransformed') then
            local _UpgradeRace, v123, v124 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('UpgradeRace', 'Check')

            if _UpgradeRace == 1 then
                return 'Required Train More'
            elseif _UpgradeRace == 2 or _UpgradeRace == 4 or _UpgradeRace == 7 then
                return 'Can Buy Gear With ' .. v124 .. ' Fragments'
            elseif _UpgradeRace == 3 then
                return 'Required Train More'
            elseif _UpgradeRace == 5 then
                return 'You Are Done Your Race.'
            elseif _UpgradeRace == 6 then
                return 'Upgrades completed: ' .. v123 - 2 .. '/3, Need Trains More'
            else
                return _UpgradeRace ~= 8 and (_UpgradeRace == 0 and 'Ready For Trial' or 'You Have Yet To Achieve Greatness') or 'Remaining ' .. 10 - v123 .. ' Training Sessions'
            end
        else
            return 'You Have Yet To Achieve Greatness'
        end
    end
    function CheckRace()
        local _Wenlocktoad = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('Wenlocktoad', '1')
        local _Alchemist = game.ReplicatedStorage.Remotes.CommF_:InvokeServer('Alchemist', '1')

        if game.Players.LocalPlayer.Character:FindFirstChild('RaceTransformed') then
            return game:GetService('Players').LocalPlayer.Data.Race.Value .. ' V4'
        elseif _Wenlocktoad == -2 then
            return game:GetService('Players').LocalPlayer.Data.Race.Value .. ' V3'
        elseif _Alchemist == -2 then
            return game:GetService('Players').LocalPlayer.Data.Race.Value .. ' V2'
        else
            return game:GetService('Players').LocalPlayer.Data.Race.Value .. ' V1'
        end
    end

    local u127 = CFrame.new(28282.5703125, 14896.8505859375, 105.1042709350586)

    function Templeteleport()
        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586))
    end
    function CheckAndTweenTemple()
        if (u127.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1200 then
            Templeteleport()
        end
        if (u127.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1200 then
            Templeteleport()
        end
    end
    function MoonTextureId()
        if World1 then
            return game:GetService('Lighting').FantasySky.MoonTextureId
        end
        if World2 then
            return game:GetService('Lighting').FantasySky.MoonTextureId
        end
        if World3 then
            return game:GetService('Lighting').Sky.MoonTextureId
        end
    end
    function CheckMoon()
        moon8 = 'http://www.roblox.com/asset/?id=9709150401'
        moon7 = 'http://www.roblox.com/asset/?id=9709150086'
        moon6 = 'http://www.roblox.com/asset/?id=9709149680'
        moon5 = 'http://www.roblox.com/asset/?id=9709149431'
        moon4 = 'http://www.roblox.com/asset/?id=9709149052'
        moon3 = 'http://www.roblox.com/asset/?id=9709143733'
        moon2 = 'http://www.roblox.com/asset/?id=9709139597'
        moon1 = 'http://www.roblox.com/asset/?id=9709135895'
        moonreal = MoonTextureId()
        cofullmoonkothangbeo = 'Bad Moon'

        if moonreal == moon5 or moonreal == moon4 then
            if moonreal ~= moon5 then
                if moonreal == moon4 then
                    cofullmoonkothangbeo = 'Next Night'
                end
            else
                cofullmoonkothangbeo = 'Full Moon'
            end
        end

        return cofullmoonkothangbeo
    end
    function function7()
        GameTime = 'Error'

        local _ClockTime = game.Lighting.ClockTime

        if _ClockTime >= 18 or _ClockTime < 5 then
            GameTime = 'Night'
        else
            GameTime = 'Day'
        end

        return GameTime
    end
    function function6()
        return math.floor(game.Lighting.ClockTime)
    end
    function getServerTime()
        RealTime = tostring(math.floor(game.Lighting.ClockTime * 100) / 100)
        RealTime = tostring(game.Lighting.ClockTime)
        RealTimeTable = RealTime:split('.')

        local v129 = RealTimeTable[1]

        Second = tonumber(0 + tonumber(RealTimeTable[2] / 100)) * 60
        Minute = v129

        return Minute, Second
    end
    function function8()
        local _ClockTime2 = game.Lighting.ClockTime

        if CheckMoon() ~= 'Full Moon' or _ClockTime2 > 5 then
            if CheckMoon() ~= 'Full Moon' or 5 >= _ClockTime2 or _ClockTime2 >= 12 then
                if CheckMoon() ~= 'Full Moon' or 12 >= _ClockTime2 or _ClockTime2 >= 18 then
                    if CheckMoon() ~= 'Full Moon' or 18 >= _ClockTime2 or _ClockTime2 > 24 then
                        if CheckMoon() ~= 'Next Night' or _ClockTime2 >= 12 then
                            if CheckMoon() ~= 'Next Night' or 12 >= _ClockTime2 then
                                return tostring(function6())
                            else
                                return tostring(function6()) .. ' ( Will Full Moon In ' .. math.floor(30 - _ClockTime2) .. ' Minutes )'
                            end
                        else
                            return tostring(function6()) .. ' ( Will Full Moon In ' .. math.floor(18 - _ClockTime2) .. ' Minutes )'
                        end
                    else
                        return tostring(function6()) .. ' ( Will End Moon In ' .. math.floor(30 - _ClockTime2) .. ' Minutes )'
                    end
                else
                    return tostring(function6()) .. ' ( Will Full Moon In ' .. math.floor(18 - _ClockTime2) .. ' Minutes )'
                end
            else
                return tostring(function6()) .. ' ( Fake Moon )'
            end
        else
            return tostring(function6()) .. ' ( Will End Moon In ' .. math.floor(5 - _ClockTime2) .. ' Minutes )'
        end
    end
    function FullMoobCheck()
        return function8()
    end
    function CheckCakeSpawn()
        if World3 then
            if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) == 88 then
                return 'Defeat: ' .. string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 39, 41) .. '/500 Mobs'
            end
            if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) == 87 then
                return 'Defeat: ' .. string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 39, 40) .. '/500 Mobs'
            end
            if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) == 86 then
                return 'Defeat: ' .. string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 39, 39) .. '/500 Mobs'
            end
            if CheckMob('Cake Prince') then
                return 'Cake Prince Spawned'
            end
            if CheckMob('Dough King') then
                return 'Dough King Spawned'
            end
        elseif World1 or World2 then
            return 'Defeat: 500/500 Mobs'
        end
    end
    function CheckElite()
        return CheckMob('Diablo') and 'Elite Diablo Spawned' or (CheckMob('Deandre') and 'Elite Deandre Spawned' or (CheckMob('Urban') and 'Elite Urban Spawned' or 'Not Spawned'))
    end
    function CheckSword()
        return game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LegendarySwordDealer', '1') and 'Sword Name: Shisui' or (game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LegendarySwordDealer', '2') and 'Sword Name: Wando' or (game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LegendarySwordDealer', '3') and 'Sword Name: Saddi' or 'Not Found Legendary Sword Dealer'))
    end
    function CheckHaki()
        return not game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '1') and 'Not Found Haki Dealer' or 'Haki Colors: ' .. game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '1')
    end
    function CheckMirage()
        return game.Workspace._WorldOrigin.Locations:FindFirstChild('Mirage Island') and 'Spawned' or 'Not Spawned'
    end
    function CheckKitsune()
        return game:GetService('Workspace').Map:FindFirstChild('KitsuneIsland') and 'Spawned' or 'Not Spawned'
    end
    function CheckFrozen()
        return game.Workspace._WorldOrigin.Locations:FindFirstChild('Frozen Dimension') and 'Spawned' or 'Not Spawned'
    end
    function CDarkness()
        return (game.Players.LocalPlayer.Backpack:FindFirstChild('Fist of Darkness') or game.Players.LocalPlayer.Character:FindFirstChild('Fist of Darkness')) and 'Fist Of Darkness: Yes' or 'Fist Of Darkness: No'
    end
    function CheckRauDen()
        return CheckMob('Darkbeard') and 'Darkbeard Spawned' or 'Darkbeard Not Spawned'
    end
    function GodChalice()
        return (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice")) and "God's Chalice: Yes" or "God's Chalice: No"
    end
    function CheckTrumAd()
        return CheckMob('rip_indra True Form') and 'Rip_Indra Spawned' or 'Rip_Indra Not Spawned'
    end

    spawn(function()
        game:GetService('RunService').RenderStepped:Connect(function()
            pcall(function()
                if UseSkill or (UseGunSkill or SeaSkill) then
                    local v131, v132, v133 = pairs(game:GetService('Players').LocalPlayer.PlayerGui.Notifications:GetChildren())

                    while true do
                        local v134

                        v133, v134 = v131(v132, v133)

                        if v133 == nil then
                            break
                        end

                        local v135, v136, v137 = pairs(v134:GetChildren())

                        while true do
                            local v138

                            v137, v138 = v135(v136, v137)

                            if v137 == nil then
                                break
                            end
                            if string.find(v138.Text, 'Skill Locked!') then
                                v134:Destroy()
                            end
                        end
                    end
                end
            end)
        end)
    end)

    local v139 = getrawmetatable(game)
    local ___namecall = v139.__namecall

    setreadonly(v139, false)

    v139.__namecall = newcclosure(function(...)
        local v141 = getnamecallmethod()
        local v142 = {...}

        if tostring(v141) ~= 'FireServer' or (tostring(v142[1]) ~= 'RemoteEvent' or tostring(v142[2]) == 'true') or (tostring(v142[2]) == 'false' or not (Skillaimbot or Skillaimbotpl)) then
            return ___namecall(...)
        end

        v142[2] = AimBotSkillPosition

        return ___namecall(unpack(v142))
    end)

    setreadonly(v139, false)

    v139.__namecall = newcclosure(function(...)
        local v143 = {...}

        if getnamecallmethod() ~= 'InvokeServer' or tostring(v143[2]) ~= 'TAP' or not (Skillaimbot or Skillaimbotpl) then
            return ___namecall(...)
        end

        v143[3] = AimBotSkillPosition

        return ___namecall(unpack(v143))
    end)

    if game:GetService('ReplicatedStorage').Assets:FindFirstChild('SlashHit') then
        game:GetService('ReplicatedStorage').Assets:FindFirstChild('SlashHit'):Destroy()
    end

    require(game.ReplicatedStorage.Util.CameraShaker):Stop()
    game:GetService('ReplicatedStorage').Util.Sound.Storage.Swing:Destroy()

    local _LocalPlayer2 = game.Players.LocalPlayer
    local u145 = getupvalues(require(_LocalPlayer2.PlayerScripts.CombatFramework))[2]
    local u146 = debug.getupvalues(require(game:GetService('Players').LocalPlayer.PlayerScripts:WaitForChild('CombatFramework')))[2]

    function GetCurrentBlade()
        local _activeController = u146.activeController

        if not _activeController then
            return nil
        end

        local v148 = _activeController.blades[1]

        if not v148 then
            return nil
        end

        while v148.Parent ~= game.Players.LocalPlayer.Character do
            v148 = v148.Parent
        end

        return v148
    end
    function AttackNoCD()
        local _activeController2 = u145.activeController

        if _activeController2 then
            for v150 = 1, 1 do
                local v151 = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(_LocalPlayer2.Character, {
                    _LocalPlayer2.Character:FindFirstChild('HumanoidRootPart'),
                }, 70)
                local v152, v153, v154 = pairs(v151)
                local u155 = v150
                local v156 = {}
                local u157 = {}

                while true do
                    local v158, v159 = v152(v153, v154)

                    if v158 == nil then
                        break
                    end

                    v154 = v158

                    if v159.Parent:FindFirstChild('HumanoidRootPart') and not v156[v159.Parent] then
                        table.insert(u157, v159.Parent:FindFirstChild('HumanoidRootPart'))

                        v156[v159.Parent] = true
                    end
                end

                if #u157 > 0 then
                    local u160 = debug.getupvalue(_activeController2.attack, 5)
                    local u161 = debug.getupvalue(_activeController2.attack, 6)
                    local u162 = debug.getupvalue(_activeController2.attack, 4)
                    local v163 = debug.getupvalue(_activeController2.attack, 7)
                    local u164 = (u160 * 798405 + u162 * 727595) % u161
                    local u165 = u162 * 798405

                    (function()
                        u164 = (u164 * u161 + u165) % 1099511627776
                        u160 = math.floor(u164 / u161)
                        u162 = u164 - u160 * u161
                    end)()

                    local u166 = v163 + 1

                    debug.setupvalue(_activeController2.attack, 5, u160)
                    debug.setupvalue(_activeController2.attack, 6, u161)
                    debug.setupvalue(_activeController2.attack, 4, u162)
                    debug.setupvalue(_activeController2.attack, 7, u166)
                    pcall(function()
                        if _LocalPlayer2.Character:FindFirstChildOfClass('Tool') and (_activeController2.blades and _activeController2.blades[1]) then
                            _activeController2.animator.anims.basic[1]:Play(0.01, 0.01, 0.01)
                            game:GetService('ReplicatedStorage').RigControllerEvent:FireServer('weaponChange', tostring(GetCurrentBlade()))
                            game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u164 / 1099511627776 * 16777215), u166)
                            game:GetService('ReplicatedStorage').RigControllerEvent:FireServer('hit', u157, u155, '')
                        end
                    end)
                end
            end
        end
    end

    local v167 = require(game:GetService('Players').LocalPlayer.PlayerScripts.CombatFramework)
    local u168 = debug.getupvalues(v167)[2]

    spawn(function()
        while task.wait() do
            if KillPlayerAttack and u168.activeController then
                Click()

                u168.activeController.attacking = false
                u168.activeController.timeToNextAttack = 0
                u168.activeController.increment = 3
                u168.activeController.hitboxMagnitude = 70
                u168.activeController.blocking = false
                u168.activeController.timeToNextBlock = 0
                u168.activeController.focusStart = 0
                u168.activeController.humanoid.AutoRotate = true
            end
        end
    end)

    function Click()
        game:GetService('VirtualUser'):CaptureController()
        game:GetService('VirtualUser'):Button1Down(Vector2.new(1280, 672))
    end

    spawn(function()
        while task.wait() do
            if KillPlayerAttack then
                AttackNoCD()
            end
        end
    end)

    ScreenGui = Instance.new('ScreenGui')
    Frame = Instance.new('Frame')
    UIStroke = Instance.new('UIStroke')
    UIGradient = Instance.new('UIGradient')
    UICorner = Instance.new('UICorner')
    TextLabel = Instance.new('TextLabel')
    UIGradient1 = Instance.new('UIGradient')
    TextLabel1 = Instance.new('TextLabel')
    UIGradient2 = Instance.new('UIGradient')
    ImageLabel = Instance.new('ImageButton')
    adiadi = true

    ImageLabel.Activated:Connect(function()
        game:GetService('RunService'):Set3dRenderingEnabled(not a)

        adiadi = not a
    end)

    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = game:GetService('CoreGui')
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0.499250829, 0, 0.05, 0)
    Frame.Size = UDim2.new(0, 170, 0, 50)
    Frame.Parent = ScreenGui
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Frame
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15.000000055879354, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(207.00000286102295, 62.00000010430813, 255)),
    })
    UIGradient.Parent = UIStroke
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Frame
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.Text = 'Tinh Linh Hub Script'
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 15
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.0199637525, 0, 0.276315689, 0)
    TextLabel.Size = UDim2.new(0, 170, 0, 6)
    TextLabel.Parent = Frame
    UIGradient1.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15.000000055879354, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(207.00000286102295, 62.00000010430813, 255)),
    })
    UIGradient1.Parent = TextLabel
    TextLabel1.Font = Enum.Font.FredokaOne
    TextLabel1.Text = 'discord.gg/C8YjpmQPJp'
    TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel1.TextSize = 15
    TextLabel1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel1.BackgroundTransparency = 1
    TextLabel1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel1.BorderSizePixel = 0
    TextLabel1.Position = UDim2.new(0.0199637525, 0, 0.539473593, 0)
    TextLabel1.Size = UDim2.new(0, 170, 0, 11)
    TextLabel1.Parent = Frame
    UIGradient2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15.000000055879354, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(207.00000286102295, 62.00000010430813, 255)),
    })
    UIGradient2.Parent = TextLabel1
    ImageLabel.Image = 'rbxassetid://16730867128'
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Position = UDim2.new(0.448140889, 0, -0.3, 0)
    ImageLabel.Size = UDim2.new(0, 30, 0, 30)
    ImageLabel.Parent = Frame

    local u169 = loadstring(game:HttpGet('https://raw.githubusercontent.com/HuyLocDz/Ui/main/OrionUi.lua'))()
    local v170 = u169
    local v171 = u169.MakeWindow(v170, {
        Name = ':)',
        IntroEnabled = true,
        IntroText = 'Tinh Linh Hub',
        IntroIcon = 'rbxassetid://16730867128',
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = 'TinhLinhHub',
    })
    local v172 = u169

    u169.MakeNotification(v172, {
        Name = 'Tinh Linh Hub',
        Content = 'Loading Script Tinh Linh Hub...',
        Image = 'rbxassetid://16730867128',
        Time = 5,
    })

    local v173 = v171:MakeTab({
        Name = 'Settings',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v174 = v171:MakeTab({
        Name = 'Farm',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v175 = v171:MakeTab({
        Name = 'Fruit & Raid',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v176 = v171:MakeTab({
        Name = 'Other',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v177 = v171:MakeTab({
        Name = 'Item & Quest',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v178 = v171:MakeTab({
        Name = 'Player',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v179 = v171:MakeTab({
        Name = 'PvP',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v180 = v171:MakeTab({
        Name = 'Sea Event',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v181 = v171:MakeTab({
        Name = 'Race',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v182 = v171:MakeTab({
        Name = 'Stats & Esp',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local u183 = v171:MakeTab({
        Name = 'Teleport',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v184 = v171:MakeTab({
        Name = 'Status & Server',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })
    local v185 = v171:MakeTab({
        Name = 'Shop',
        Icon = 'rbxassetid://4483345998',
        PremiumOnly = false,
    })

    v173:AddSection({
        Name = '~ Setting Farm ~',
    })
    v173:AddDropdown({
        Name = 'Select Weapon',
        Default = 'Melee',
        Options = {
            'Melee',
            'Sword',
            'Gun',
            'Blox Fruit',
        },
        Callback = function(p186)
            _G.SelectWeapons = p186
        end,
    })
    spawn(function()
        while wait() do
            if _G.SelectWeapons == _G.SelectWeapons then
                local v187, v188, v189 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                while true do
                    local v190

                    v189, v190 = v187(v188, v189)

                    if v189 == nil then
                        break
                    end
                    if v190.ToolTip == _G.SelectWeapons and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v190.Name)) then
                        _G.SelectWeapon = v190.Name
                    end
                end
            end
        end
    end)
    v173:AddDropdown({
        Name = 'Select Speed \u{200b}\u{200b}Attack',
        Default = 'Fast [ 0.1s ]',
        Options = {
            'No Delay [ 0.0s ]',
            'Super Fast [ 0.05s ]',
            'Fast [ 0.1s ]',
            'Moderate [ 0.3s ]',
            'Default [ 0.5s ]',
            'Medium [ 0.8s ]',
            'Slow [ 1.0s ]',
        },
        Callback = function(p191)
            _G.SelectAttackDelay = p191

            if _G.SelectAttackDelay ~= 'No Delay [ 0.0s ]' then
                if _G.SelectAttackDelay ~= 'Super Fast [ 0.05s ]' then
                    if _G.SelectAttackDelay ~= 'Fast [ 0.1s ]' then
                        if _G.SelectAttackDelay ~= 'Moderate [ 0.3s ]' then
                            if _G.SelectAttackDelay ~= 'Default [ 0.5s ]' then
                                if _G.SelectAttackDelay ~= 'Medium [ 0.8s ]' then
                                    if _G.SelectAttackDelay == 'Slow [ 1.0s ]' then
                                        FastAttackDelay = 1
                                    end
                                else
                                    FastAttackDelay = 0.8
                                end
                            else
                                FastAttackDelay = 0.5
                            end
                        else
                            FastAttackDelay = 0.3
                        end
                    else
                        FastAttackDelay = 0.1
                    end
                else
                    FastAttackDelay = 0.05
                end
            else
                FastAttackDelay = 0
            end
        end,
    })
    v173:AddToggle({
        Name = 'Fast Attack',
        Default = true,
        Callback = function(p192)
            _G.FastAttack = p192
        end,
    })
    spawn(function()
        while task.wait(FastAttackDelay) do
            if _G.FastAttack then
                AttackNoCD()
            end
        end
    end)
    v173:AddToggle({
        Name = 'Auto Click [ 75% Kick System ]',
        Default = false,
        Callback = function(p193)
            _G.AutoClick = p193
        end,
    })
    spawn(function()
        game:GetService('RunService').RenderStepped:Connect(function()
            if _G.AutoClick then
                game:GetService('VirtualUser'):CaptureController()
                game:GetService('VirtualUser'):Button1Down(Vector2.new(0, 1, 0, 1))
            end
        end)
    end)
    v173:AddDropdown({
        Name = 'Select Range Collect Mob',
        Default = 'Slightly Far [ 300m ]',
        Options = {
            'Really Far [ 350m ]',
            'Distant [ 325m ]',
            'Slightly Far [ 300m ]',
            'Near The [ 275m ]',
            'Very Close [ 250m ]',
        },
        Callback = function(p194)
            _G.SelectRange = p194

            if _G.SelectRange ~= 'Really Far [ 350m ]' then
                if _G.SelectRange ~= 'Distant [ 325m ]' then
                    if _G.SelectRange ~= 'Slightly Far [ 300m ]' then
                        if _G.SelectRange ~= 'Near The [ 275m ]' then
                            if _G.SelectRange == 'Very Close [ 250m ]' then
                                BringRange = 250
                            end
                        else
                            BringRange = 275
                        end
                    else
                        BringRange = 300
                    end
                else
                    BringRange = 325
                end
            else
                BringRange = 350
            end
        end,
    })
    v173:AddToggle({
        Name = 'Bring Mobs',
        Default = true,
        Callback = function(p195)
            _G.BringMonster = p195
        end,
    })
    spawn(function()
        while wait() do
            if _G.BringMonster then
                pcall(function()
                    CheckQuest()

                    local v196, v197, v198 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v199

                        v198, v199 = v196(v197, v198)

                        if v198 == nil then
                            break
                        end
                        if (_G.AutoFarm or _G.AutoFarmFruitMastery or (_G.AutoFarmGunMastery or _G.AutoSwordMastery)) and (StartMagnet and v199.Name == Mon and (v199.HumanoidRootPart.Position - PosFarm.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = PosFarm

                            v199.Humanoid:ChangeState(14)
                        end
                        if MagnetNear and not string.find(v199.Name, 'Boss') and (v199.HumanoidRootPart.Position - PosNear.Position).Magnitude <= BringRange then
                            v199.HumanoidRootPart.CFrame = PosNear

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.AutoMusketeerHat and StartMagnetMusketeerhat and (v199.Name == 'Forest Pirate' and (v199.HumanoidRootPart.Position - MusketeerHatMon.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = MusketeerHatMon

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.Auto_EvoRace and StartEvoMagnet and (v199.Name == 'Zombie' and (v199.HumanoidRootPart.Position - PosMonEvo.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = PosMonEvo

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.AutoMaterial and BringMonMaterial and (v199.Name == MMon or v199.Name == MMon1) and (v199.HumanoidRootPart.Position - MaterialPos.Position).Magnitude <= BringRange then
                            v199.HumanoidRootPart.CFrame = MaterialPos

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.AutoFarmMob and SelectMag and (v199.Name == SelectMob and (v199.HumanoidRootPart.Position - PosMonFarm.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = PosMonFarm

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.AutoBartilo and AutoBartiloBring and (v199.Name == 'Swan Pirate' and (v199.HumanoidRootPart.Position - PosMonBarto.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = PosMonBarto

                            v199.Humanoid:ChangeState(14)
                        end
                        if _G.FarmSkip and StartBring and (v199.Name == 'Shanda' and (v199.HumanoidRootPart.Position - PosMon.Position).Magnitude <= BringRange) then
                            v199.HumanoidRootPart.CFrame = PosMon

                            v199.Humanoid:ChangeState(14)
                        end
                    end
                end)
            end
        end
    end)
    v173:AddSection({
        Name = '~ Tween ~',
    })
    v173:AddSlider({
        Name = 'Tween Speed',
        Min = 1,
        Max = 350,
        Default = 325,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '',
        Callback = function(p200)
            _G.TweenSpeed = p200
        end,
    })
    v173:AddToggle({
        Name = 'Bypass Teleport',
        Default = false,
        Callback = function(p201)
            _G.BypassTele = p201
        end,
    })
    v173:AddButton({
        Name = 'Reset Character',
        Callback = function()
            game:GetService('Players').LocalPlayer.Character.Humanoid.Health = 0
        end,
    })
    v173:AddSection({
        Name = '~ Graphic & Reduce Lag ~',
    })
    v173:AddToggle({
        Name = 'White Screen',
        Default = false,
        Callback = function(p202)
            _G.WhiteScreen = p202

            if _G.WhiteScreen ~= true then
                if _G.WhiteScreen == false then
                    game:GetService('RunService'):Set3dRenderingEnabled(true)
                end
            else
                game:GetService('RunService'):Set3dRenderingEnabled(false)
            end
        end,
    })
    spawn(function()
        while wait() do
            if _G.WhiteScreen then
                local v203, v204, v205 = pairs(game.Workspace._WorldOrigin:GetChildren())

                while true do
                    local v206

                    v205, v206 = v203(v204, v205)

                    if v205 == nil then
                        break
                    end
                    if v206.Name == 'CurvedRing' or v206.Name == 'SlashHit' or (v206.Name == 'DamageCounter' or v206.Name == 'SwordSlash') or (v206.Name == 'SlashTail' or v206.Name == 'Sounds') then
                        v206:Destroy()
                    end
                end
            end
        end
    end)
    v173:AddButton({
        Name = 'Remove Fog',
        Callback = function()
            game:GetService('Lighting').LightingLayers:Destroy()
            game:GetService('Lighting').Sky:Destroy()
        end,
    })
    v173:AddButton({
        Name = 'Fps Booster',
        Callback = function()
            FPSBooster()
        end,
    })

    function FPSBooster()
        local v207 = game
        local _Workspace2 = v207.Workspace
        local _Lighting = v207.Lighting
        local _Terrain = _Workspace2.Terrain

        sethiddenproperty(_Lighting, 'Technology', 2)
        sethiddenproperty(_Terrain, 'Decoration', false)

        _Terrain.WaterWaveSize = 0
        _Terrain.WaterWaveSpeed = 0
        _Terrain.WaterReflectance = 0
        _Terrain.WaterTransparency = 0
        _Lighting.GlobalShadows = false
        _Lighting.FogEnd = 9000000000
        _Lighting.Brightness = 0
        settings().Rendering.QualityLevel = 'Level01'

        local v211, v212, v213 = pairs(v207:GetDescendants())
        local v214 = true

        while true do
            local v215

            v213, v215 = v211(v212, v213)

            if v213 == nil then
                break
            end
            if v215:IsA('Part') or v215:IsA('Union') or (v215:IsA('CornerWedgePart') or v215:IsA('TrussPart')) then
                v215.Material = 'Plastic'
                v215.Reflectance = 0
            elseif v215:IsA('Decal') or v215:IsA('Texture') and v214 then
                v215.Transparency = 1
            elseif v215:IsA('ParticleEmitter') or v215:IsA('Trail') then
                v215.Lifetime = NumberRange.new(0)
            elseif v215:IsA('Explosion') then
                v215.BlastPressure = 1
                v215.BlastRadius = 1
            elseif v215:IsA('Fire') or v215:IsA('SpotLight') or (v215:IsA('Smoke') or v215:IsA('Sparkles')) then
                v215.Enabled = false
            elseif v215:IsA('MeshPart') then
                v215.Material = 'Plastic'
                v215.Reflectance = 0
                v215.TextureID = 1.0385902758728955e16
            end
        end

        local v216, v217, v218 = pairs(_Lighting:GetChildren())

        while true do
            local v219

            v218, v219 = v216(v217, v218)

            if v218 == nil then
                break
            end
            if v219:IsA('BlurEffect') or v219:IsA('SunRaysEffect') or (v219:IsA('ColorCorrectionEffect') or v219:IsA('BloomEffect')) or v219:IsA('DepthOfFieldEffect') then
                v219.Enabled = false
            end
        end
    end

    v173:AddButton({
        Name = 'Remove Lava',
        Callback = function()
            local v220, v221, v222 = pairs(game.Workspace:GetDescendants())

            while true do
                local v223

                v222, v223 = v220(v221, v222)

                if v222 == nil then
                    break
                end
                if v223.Name == 'Lava' then
                    v223:Destroy()
                end
            end

            local v224, v225, v226 = pairs(game.ReplicatedStorage:GetDescendants())

            while true do
                local v227

                v226, v227 = v224(v225, v226)

                if v226 == nil then
                    break
                end
                if v227.Name == 'Lava' then
                    v227:Destroy()
                end
            end
        end,
    })
    v173:AddToggle({
        Name = 'Disabled Notifications Text',
        Default = false,
        Callback = function(p228)
            _G.Remove_trct = p228
        end,
    })
    spawn(function()
        while wait() do
            if _G.Remove_trct then
                game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
            else
                game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
            end
        end
    end)
    v173:AddToggle({
        Name = 'Disabled Damage Counter',
        Default = true,
        Callback = function(p229)
            _G.DisabledDamage = p229
        end,
    })
    spawn(function()
        while wait() do
            if _G.DisabledDamage then
                game:GetService('ReplicatedStorage').Assets.GUI.DamageCounter.Enabled = false
            else
                game:GetService('ReplicatedStorage').Assets.GUI.DamageCounter.Enabled = true
            end
        end
    end)
    v173:AddSlider({
        Name = 'Select Brightnes',
        Min = 1,
        Max = 100,
        Default = 20,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '%',
        Callback = function(p230)
            _G.BrightValue = p230
        end,
    })
    v173:AddButton({
        Name = 'Set Brightnes',
        Callback = function()
            game:GetService('Lighting').Brightness = _G.BrightValue
        end,
    })
    v173:AddSection({
        Name = '~ Other ~',
    })
    v173:AddToggle({
        Name = 'Auto Rejoin When Disconnect',
        Default = true,
        Callback = function(p231)
            _G.AutoRejoin = p231
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoRejoin then
                getgenv().rejoin = game:GetService('CoreGui').RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(p232)
                    if p232.Name == 'ErrorPrompt' and p232:FindFirstChild('MessageArea') and p232.MessageArea:FindFirstChild('ErrorFrame') then
                        game:GetService('TeleportService'):Teleport(game.PlaceId)
                    end
                end)
            end
        end
    end)
    v173:AddSlider({
        Name = 'Value Health',
        Min = 1,
        Max = 100,
        Default = 30,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '%',
        Callback = function(p233)
            _G.Health = p233
        end,
    })
    v173:AddToggle({
        Name = 'Teleport To Y If Low Health [ Test ]',
        Default = false,
        Callback = function(p234)
            _G.LowHealth = p234
        end,
    })
    spawn(function()
        while wait() do
            if _G.LowHealth and game.Players.LocalPlayer.Character and (game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') and game.Players.LocalPlayer.Character.Humanoid.Health / game.Players.LocalPlayer.Character.Humanoid.MaxHealth * 100 < _G.Health) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 100, 0)
            end
        end
    end)
    v173:AddSection({
        Name = '~ Hold Skill Mastery ~',
    })
    v173:AddLabel('Hold Skill Devil Fruit')
    v173:AddTextbox({
        Name = 'Hold Skill Z',
        Default = '0',
        TextDisappear = false,
        Callback = function(p235)
            _G.HoldSKillZ = p235
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill X',
        Default = '0',
        TextDisappear = false,
        Callback = function(p236)
            _G.HoldSKillX = p236
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill C',
        Default = '0',
        TextDisappear = false,
        Callback = function(p237)
            _G.HoldSKillC = p237
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill V',
        Default = '0',
        TextDisappear = false,
        Callback = function(p238)
            _G.HoldSKillV = p238
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill F',
        Default = '0',
        TextDisappear = false,
        Callback = function(p239)
            _G.HoldSKillF = p239
        end,
    })
    v173:AddSection({
        Name = '~ Hold Skill Sea Event ~',
    })
    v173:AddLabel('Hold Skill Devil Fruit')
    v173:AddTextbox({
        Name = 'Hold Skill Z',
        Default = '0',
        TextDisappear = false,
        Callback = function(p240)
            _G.HoldSKillFruitZ = p240
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill X',
        Default = '0',
        TextDisappear = false,
        Callback = function(p241)
            _G.HoldSKillFruitX = p241
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill C',
        Default = '0',
        TextDisappear = false,
        Callback = function(p242)
            _G.HoldSKillFruitC = p242
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill V',
        Default = '0',
        TextDisappear = false,
        Callback = function(p243)
            _G.HoldSKillFruitV = p243
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill F',
        Default = '0',
        TextDisappear = false,
        Callback = function(p244)
            _G.HoldSKillFruitF = p244
        end,
    })
    v173:AddLabel('Hold Skill Melee')
    v173:AddTextbox({
        Name = 'Hold Skill Z',
        Default = '0',
        TextDisappear = false,
        Callback = function(p245)
            _G.HoldSKillMeleeZ = p245
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill X',
        Default = '0',
        TextDisappear = false,
        Callback = function(p246)
            _G.HoldSKillMeleeX = p246
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill C',
        Default = '0',
        TextDisappear = false,
        Callback = function(p247)
            _G.HoldSKillMeleeC = p247
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill V',
        Default = '0',
        TextDisappear = false,
        Callback = function(p248)
            _G.HoldSKillMeleeV = p248
        end,
    })
    v173:AddLabel('Hold Skill Sword')
    v173:AddTextbox({
        Name = 'Hold Skill Z',
        Default = '0',
        TextDisappear = false,
        Callback = function(p249)
            _G.HoldSKillSwordZ = p249
        end,
    })
    v173:AddTextbox({
        Name = 'Hold Skill X',
        Default = '0',
        TextDisappear = false,
        Callback = function(p250)
            _G.HoldSKillSwordX = p250
        end,
    })
    v174:AddSection({
        Name = '~ Level ~',
    })

    local _YourLevel = v174:AddParagraph('Your Level')

    v174:AddDropdown({
        Name = 'Select Farm Level Mode',
        Default = 'Get Quest',
        Options = {
            'No Quest',
            'Get Quest',
        },
        Callback = function(p252)
            LevelFMode = p252
        end,
    })

    local u254 = v174:AddToggle({
        Name = 'Auto Farm Level',
        Default = false,
        Callback = function(p253)
            _G.AutoFarm = p253

            StopTween(_G.AutoFarm)
        end,
    })

    spawn(function()
        while wait() do
            if LevelFMode == 'No Quest' and _G.AutoFarm then
                pcall(function()
                    CheckQuest()

                    if game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                        local v255, v256, v257 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v258

                            v257, v258 = v255(v256, v257)

                            if v257 == nil then
                                break
                            end
                            if v258:FindFirstChild('HumanoidRootPart') and v258:FindFirstChild('Humanoid') and (v258.Humanoid.Health > 0 and v258.Name == Mon) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v258.HumanoidRootPart.CFrame * Pos)

                                    PosFarm = v258.HumanoidRootPart.CFrame
                                    StartMagnet = true
                                until not (_G.AutoFarm and v258:FindFirstChild('HumanoidRootPart')) or v258.Humanoid.Health <= 0

                                StartMagnet = false
                            end
                        end
                    else
                        topos(CFrameMon)
                        UnEquipWeapon(_G.SelectWeapon)

                        StartMagnet = false
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if LevelFMode == 'Get Quest' and _G.AutoFarm then
                pcall(function()
                    local _Text = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text, NameMon) then
                        StartMagnet = false

                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                        if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            CheckQuest()

                            if game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                                local v260, v261, v262 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                while true do
                                    local v263

                                    v262, v263 = v260(v261, v262)

                                    if v262 == nil then
                                        break
                                    end
                                    if v263:FindFirstChild('HumanoidRootPart') and v263:FindFirstChild('Humanoid') and (v263.Humanoid.Health > 0 and v263.Name == Mon) then
                                        if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                topos(v263.HumanoidRootPart.CFrame * Pos)

                                                PosFarm = v263.HumanoidRootPart.CFrame
                                                StartMagnet = true
                                            until not _G.AutoFarm or v263.Humanoid.Health <= 0 or not v263.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        else
                                            StartMagnet = false

                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                                        end
                                    end
                                end
                            else
                                topos(CFrameMon)
                                UnEquipWeapon(_G.SelectWeapon)

                                StartMagnet = false
                            end
                        end
                    else
                        StartMagnet = false

                        CheckQuest()
                        topos(CFrameQuest)

                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuest, LevelQuest)
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Farm Fast [ Lv. 1 -> Lv. 310 ]',
        Default = false,
        Callback = function(p264)
            _G.FarmSkip = p264

            if _G.FarmSkip == true then
                game:GetService('ReplicatedStorage').Remotes.Redeem:InvokeServer('TantaiGaming')
            end

            StopTween(_G.FarmSkip)
        end,
    })
    spawn(function()
        while wait() do
            if _G.FarmSkip then
                pcall(function()
                    LvCount = game:GetService('Players').LocalPlayer.Data.Level.Value

                    if LvCount >= 1 and LvCount < 60 then
                        CFrame.new(-7894.6176757813, 5547.1416015625, -380.29119873047)
                        topos(CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531))

                        if game:GetService('Workspace').Enemies:FindFirstChild('Shanda') then
                            local v265, v266, v267 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v268

                                v267, v268 = v265(v266, v267)

                                if v267 == nil then
                                    break
                                end
                                if v268.Name == 'Shanda' and v268:FindFirstChild('HumanoidRootPart') and (v268:FindFirstChild('Humanoid') and 0 < v268.Humanoid.Health) then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v268.HumanoidRootPart.CFrame * Pos)

                                        PosMon = v268.HumanoidRootPart.CFrame
                                        StartBring = true
                                    until not (_G.FarmSkip and v268:FindFirstChild('HumanoidRootPart')) or v268.Humanoid.Health <= 0

                                    StartBring = false
                                end
                            end
                        end
                    end
                    if LvCount < 60 or LvCount >= 300 then
                        u254:Set(true)

                        if game:GetService('Players').LocalPlayer.Data.Points.Value >= 1 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                                'AddPoint',
                                'Melee',
                                5,
                            }))
                        end

                        return
                    end

                    CheckPlayer = 0

                    local v269 = game:GetService('Players'):GetPlayers()
                    local _Quest = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest
                    local _Value = game:GetService('Players').LocalPlayer.Data.Level.Value
                    local _Text2 = _Quest.Container.QuestTitle.Title.Text

                    if game:GetService('Players').LocalPlayer.Team.Name == 'Marines' then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Pirates')
                    end
                    if _Quest.Visible ~= true then
                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('PlayerHunter') == "I don't have anything for you right now. Come back later." then
                            CheckPlayer = CheckPlayer + 1
                        end
                    end
                    if not string.find(_Text2, 'Defeat') then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('PlayerHunter')

                        if CheckPlayer >= 12 and _Quest.Visible == false and not string.find(_Text2, 'Defeat') then
                            Hop()
                            wait(0.1)
                            u169:MakeNotification({
                                Name = 'Tinh Linh Hub',
                                Content = 'Hop Servers Because Not Players',
                                Image = 'rbxassetid://16730867128',
                                Time = 5,
                            })
                        end
                    end

                    PlayerKill = string.split(_Text2, ' ')[2]

                    local v273, v274, v275 = pairs(v269)

                    while true do
                        local v276

                        v275, v276 = v273(v274, v275)

                        if v275 == nil then
                        end
                        if v276.Name == PlayerKill and 0 < v276.Character.Humanoid.Health then
                        end
                    end

                    wait()

                    if v276.Data.Level.Value < 20 or v276.Data.Level.Value > _Value * 5 then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('PlayerHunter')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EnablePvp')
                    end

                    EquipWeapon(_G.SelectWeapon)
                    topos(v276.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))

                    KillPlayerAttack = true

                    if (v276.Character.HumanoidRootPart.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 30 then
                        AimBotSkillPosition = v276.Character.HumanoidRootPart.CFrame.Position
                        Skillaimbot = true

                        game:GetService('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                        game:GetService('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                        wait()
                        game:GetService('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                        game:GetService('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                    end
                    if _G.FarmSkip and v276:FindFirstChild('HumanoidRootPart') and v276.Character.Humanoid.Health > 0 then
                    else
                    end

                    Skillaimbot = false
                    KillPlayerAttack = false
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Farm Nearest',
        Default = false,
        Callback = function(p277)
            _G.AutoFarmNearest = p277

            StopTween(_G.AutoFarmNearest)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoFarmNearest then
                pcall(function()
                    local v278, v279, v280 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v281

                        v280, v281 = v278(v279, v280)

                        if v280 == nil then
                            break
                        end
                        if v281.Name and v281:FindFirstChild('Humanoid') and (v281.Humanoid.Health > 0 and (v281.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1500) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v281.HumanoidRootPart.CFrame * Pos)

                                PosNear = v281.HumanoidRootPart.CFrame
                                MagnetNear = true
                            until not (_G.AutoFarmNearest and v281.Parent) or v281.Humanoid.Health <= 0

                            MagnetNear = false
                        end
                    end
                end)
            end
        end
    end)
    v174:AddSection({
        Name = '~ Katakuri ~',
    })

    local _CakePrince = v174:AddParagraph('Cake Prince')

    v174:AddDropdown({
        Name = 'Select Farm Katakuri Mode',
        Default = 'Get Quest',
        Options = {
            'No Quest',
            'Get Quest',
        },
        Callback = function(p283)
            CakeFMode = p283
        end,
    })
    v174:AddToggle({
        Name = 'Auto Farm Cake Prince',
        Default = false,
        Callback = function(p284)
            _G.AutoDoughtBoss = p284

            StopTween(_G.AutoDoughtBoss)
        end,
    })
    spawn(function()
        while wait() do
            pcall(function()
                if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) ~= 88 then
                    if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) ~= 87 then
                        if string.len(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner')) == 86 then
                            KillMob = tonumber(string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 41, 41)) - 500
                        end
                    else
                        KillMob = tonumber(string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 40, 41)) - 500
                    end
                else
                    KillMob = tonumber(string.sub(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner'), 39, 41)) - 500
                end
            end)
        end
    end)

    local u285 = CFrame.new(-2091.911865234375, 70.00884246826172, -12142.8359375)

    spawn(function()
        while wait() do
            if CakeFMode == 'No Quest' and _G.AutoDoughtBoss then
                pcall(function()
                    if game:GetService('Workspace').Enemies:FindFirstChild('Cake Prince') then
                        local v286, v287, v288 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v289

                            v288, v289 = v286(v287, v288)

                            if v288 == nil then
                                break
                            end
                            if (v289.Name == 'Cake Prince' or v289.Name == 'Dough King') and (v289:FindFirstChild('Humanoid') and v289:FindFirstChild('HumanoidRootPart')) and v289.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v289.HumanoidRootPart.CFrame * Pos)
                                until not (_G.AutoDoughtBoss and v289.Parent) or v289.Humanoid.Health <= 0
                            end
                        end
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]').HumanoidRootPart.CFrame * Pos)
                    else
                        local _ = KillMob ~= 0

                        if game:GetService('Workspace').Map.CakeLoaf.BigMirror.Other.Transparency == 1 then
                            if game:GetService('Workspace').Enemies:FindFirstChild('Cookie Crafter') or game:GetService('Workspace').Enemies:FindFirstChild('Cake Guard') or (game:GetService('Workspace').Enemies:FindFirstChild('Baking Staff') or game:GetService('Workspace').Enemies:FindFirstChild('Head Baker')) then
                                local v290, v291, v292 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                while true do
                                    local v293

                                    v292, v293 = v290(v291, v292)

                                    if v292 == nil then
                                        break
                                    end
                                    if (v293.Name == 'Cookie Crafter' or v293.Name == 'Cake Guard' or (v293.Name == 'Baking Staff' or v293.Name == 'Head Baker')) and (v293:FindFirstChild('Humanoid') and v293:FindFirstChild('HumanoidRootPart') and v293.Humanoid.Health > 0) then
                                        repeat
                                            wait()
                                            EquipWeapon(_G.SelectWeapon)
                                            topos(v293.HumanoidRootPart.CFrame * Pos)

                                            PosNear = v293.HumanoidRootPart.CFrame
                                            MagnetNear = true
                                        until not (_G.AutoDoughtBoss and v293.Parent) or v293.Humanoid.Health <= 0 or (game:GetService('Workspace').Map.CakeLoaf.BigMirror.Other.Transparency == 0 or game:GetService('ReplicatedStorage'):FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]')) or (game:GetService('Workspace').Enemies:FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]') or KillMob == 0)
                                    end
                                end
                            else
                                topos(u285)

                                MagnetNear = false

                                UnEquipWeapon(_G.SelectWeapon)
                            end
                        end
                    end
                end)
            end
        end
    end)

    local u294 = CFrame.new(-2021.32007, 37.7982254, -12028.7295, 0.957576931, -8.80302053e-8, 0.288177818, 6.9301186999999995e-8, 1, 7.5193121099999995e-8, -0.288177818, -5.2032135e-8, 0.957576931)

    spawn(function()
        while wait() do
            if CakeFMode == 'Get Quest' and _G.AutoDoughtBoss and World3 then
                pcall(function()
                    if game:GetService('Workspace').Enemies:FindFirstChild('Cake Prince') or game:GetService('Workspace').Enemies:FindFirstChild('Dough King') then
                        local v295, v296, v297 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v298

                            v297, v298 = v295(v296, v297)

                            if v297 == nil then
                                break
                            end
                            if (v298.Name == 'Cake Prince' or v298.Name == 'Dough King') and (v298:FindFirstChild('Humanoid') and v298:FindFirstChild('HumanoidRootPart')) and v298.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v298.HumanoidRootPart.CFrame * Pos)
                                until not (_G.AutoDoughtBoss and v298.Parent) or v298.Humanoid.Health <= 0
                            end
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if CakeFMode == 'Get Quest' and _G.AutoDoughtBoss and World3 and not game:GetService('ReplicatedStorage'):FindFirstChild('Cake Prince') then
                pcall(function()
                    local _Text3 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text3, 'Cookie Crafter') then
                        MagnetNear = false

                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        MagnetNear = false

                        topos(u294)

                        if (u294.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', 'CakeQuest1', 1)
                        end
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Cookie Crafter') or game:GetService('Workspace').Enemies:FindFirstChild('Cake Guard') or (game:GetService('Workspace').Enemies:FindFirstChild('Baking Staff') or game:GetService('Workspace').Enemies:FindFirstChild('Head Baker')) then
                            local v300, v301, v302 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v303

                                v302, v303 = v300(v301, v302)

                                if v302 == nil then
                                    break
                                end
                                if v303:FindFirstChild('HumanoidRootPart') and v303:FindFirstChild('Humanoid') and v303.Humanoid.Health > 0 and (v303.Name == 'Cookie Crafter' or v303.Name == 'Cake Guard' or (v303.Name == 'Baking Staff' or v303.Name == 'Head Baker')) then
                                    if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Cookie Crafter') then
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v303.HumanoidRootPart.CFrame * Pos)

                                        PosNear = v303.HumanoidRootPart.CFrame
                                        MagnetNear = true

                                        if _G.AutoDoughtBoss and v303.Parent and (game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false and v303.Humanoid.Health > 0) and (game:GetService('Workspace').Map.CakeLoaf.BigMirror.Other.Transparency ~= 0 and not game:GetService('ReplicatedStorage'):FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]')) and (not game:GetService('Workspace').Enemies:FindFirstChild('Cake Prince [Lv. 2300] [Raid Boss]') and KillMob ~= 0) then
                                        end
                                    else
                                        MagnetNear = false

                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                                    end
                                end
                            end
                        else
                            topos(u285)

                            MagnetNear = false

                            UnEquipWeapon(_G.SelectWeapon)
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Spawn Katakuri',
        Default = true,
        Callback = function(p304)
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CakePrinceSpawner', p304)
        end,
    })
    v174:AddSection({
        Name = '~ Bone ~',
    })

    local _YourBone = v174:AddParagraph('Your Bone')

    v174:AddDropdown({
        Name = 'Select Farm Bone Mode',
        Default = 'Get Quest',
        Options = {
            'No Quest',
            'Get Quest',
        },
        Callback = function(p306)
            BoneFMode = p306
        end,
    })
    v174:AddToggle({
        Name = 'Auto Farm Bone',
        Default = false,
        Callback = function(p307)
            _G.Auto_Bone = p307

            StopTween(_G.Auto_Bone)
        end,
    })

    local u308 = CFrame.new(-9506.234375, 172.130615234375, 6117.0771484375)

    spawn(function()
        while wait() do
            if BoneFMode == 'No Quest' and _G.Auto_Bone and World3 then
                pcall(function()
                    if game:GetService('Workspace').Enemies:FindFirstChild('Reborn Skeleton') or (game:GetService('Workspace').Enemies:FindFirstChild('Living Zombie') or game:GetService('Workspace').Enemies:FindFirstChild('Demonic Soul')) or game:GetService('Workspace').Enemies:FindFirstChild('Posessed Mummy') then
                        local v309, v310, v311 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v312

                            v311, v312 = v309(v310, v311)

                            if v311 == nil then
                                break
                            end
                            if (v312.Name == 'Reborn Skeleton' or v312.Name == 'Living Zombie' or (v312.Name == 'Demonic Soul' or v312.Name == 'Posessed Mummy')) and (v312:FindFirstChild('Humanoid') and v312:FindFirstChild('HumanoidRootPart') and v312.Humanoid.Health > 0) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v312.HumanoidRootPart.CFrame * Pos)

                                    PosNear = v312.HumanoidRootPart.CFrame
                                    MagnetNear = true
                                until not (_G.Auto_Bone and v312.Parent) or v312.Humanoid.Health <= 0
                            end
                        end
                    else
                        topos(u308)
                        UnEquipWeapon(_G.SelectWeapon)

                        MagnetNear = false
                    end
                end)
            end
        end
    end)

    local u313 = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)

    spawn(function()
        while wait() do
            if BoneFMode == 'Get Quest' and _G.Auto_Bone and World3 then
                pcall(function()
                    local _Text4 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text4, 'Demonic Soul') then
                        MagnetNear = false

                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        MagnetNear = false

                        topos(u313)

                        if (u313.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', 'HauntedQuest2', 1)
                        end
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Reborn Skeleton') or game:GetService('Workspace').Enemies:FindFirstChild('Living Zombie') or (game:GetService('Workspace').Enemies:FindFirstChild('Demonic Soul') or game:GetService('Workspace').Enemies:FindFirstChild('Posessed Mummy')) then
                            local v315, v316, v317 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v318

                                v317, v318 = v315(v316, v317)

                                if v317 == nil then
                                    break
                                end
                                if v318:FindFirstChild('HumanoidRootPart') and v318:FindFirstChild('Humanoid') and v318.Humanoid.Health > 0 and (v318.Name == 'Reborn Skeleton' or v318.Name == 'Living Zombie' or (v318.Name == 'Demonic Soul' or v318.Name == 'Posessed Mummy')) then
                                    if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Demonic Soul') then
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v318.HumanoidRootPart.CFrame * Pos)

                                        PosNear = v318.HumanoidRootPart.CFrame
                                        MagnetNear = true

                                        if _G.Auto_Bone and v318.Humanoid.Health > 0 and v318.Parent and game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                                        end
                                    else
                                        MagnetNear = false

                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                                    end
                                end
                            end
                        else
                            topos(u308)
                            UnEquipWeapon(_G.SelectWeapon)

                            MagnetNear = false
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Random Bone',
        Default = false,
        Callback = function(p319)
            _G.Auto_Random_Bone = p319
        end,
    })
    spawn(function()
        while task.wait() do
            if _G.Auto_Random_Bone then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Bones', 'Buy', 1, 1)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Spawn & Kill Soul Reaper',
        Default = false,
        Callback = function(p320)
            _G.Auto_Soul_Reaper = p320

            StopTween(_G.Auto_Soul_Reaper)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_Soul_Reaper then
                if game.Players.LocalPlayer.Backpack:FindFirstChild('Hallow Essence') then
                    EquipWeapon('Hallow Essence')
                    topos(CFrame.new(-8932.83789, 144.098709, 6059.34229, -0.999290943, 7.956234779999999e-9, -0.0376505218, 4.4684243e-9, 1, 9.27205832e-8, 0.0376505218, 9.24866086e-8, -0.999290943))
                elseif game:GetService('Workspace').Enemies:FindFirstChild('Soul Reaper') then
                    if game.Workspace.Enemies:FindFirstChild('Soul Reaper') then
                        local v321, v322, v323 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v324

                            v323, v324 = v321(v322, v323)

                            if v323 == nil then
                                break
                            end
                            if v324.Name == 'Soul Reaper' and v324:FindFirstChild('HumanoidRootPart') and (v324:FindFirstChild('Humanoid') and 0 < v324.Humanoid.Health) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v324.HumanoidRootPart.CFrame * Pos)
                                until not (_G.Auto_Soul_Reaper and v324.Parent) or v324.Humanoid.Health <= 0
                            end
                        end
                    end
                else
                    topos(u308)
                    UnEquipWeapon(_G.SelectWeapon)
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                        'Bones',
                        'Buy',
                        1,
                        1,
                    }))
                end
            end
        end
    end)
    v174:AddSection({
        Name = '~ Gun & Devil Fruit Mastery ~',
    })
    v174:AddToggle({
        Name = 'Auto Farm Devil Fruit Mastery',
        Default = false,
        Callback = function(p325)
            _G.AutoFarmFruitMastery = p325

            StopTween(_G.AutoFarmFruitMastery)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoFarmFruitMastery then
                pcall(function()
                    CheckQuest()

                    local _Text5 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text5, NameMon) then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        repeat
                            wait()
                            topos(CFrameQuest)
                        until (CFrameQuest.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoFarmFruitMastery

                        if (CFrameQuest.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuest, LevelQuest)
                        end
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                        return
                    end
                    if not game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                        topos(CFrameMon)
                        UnEquipWeapon(_G.SelectWeapon)
                    end

                    local v327, v328, v329 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v330

                        v329, v330 = v327(v328, v329)

                        if v329 == nil then
                        end
                        if v330:FindFirstChild('HumanoidRootPart') and v330:FindFirstChild('Humanoid') and (v330.Humanoid.Health > 0 and v330.Name == Mon) and string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                            HealthMs = v330.Humanoid.MaxHealth * _G.Kill_At / 100

                            repeat
                                if true then
                                    wait()

                                    if v330.Humanoid.Health > HealthMs then
                                        UseSkill = false
                                        Skillaimbot = false

                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v330.HumanoidRootPart.CFrame * Pos)
                                    else
                                        EquipWeapon(game:GetService('Players').LocalPlayer.Data.DevilFruit.Value)

                                        UseSkill = true
                                        Skillaimbot = true

                                        topos(v330.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                    end
                                end

                                AimBotSkillPosition = v330.HumanoidRootPart.CFrame.Position
                                MonFarm = v330.Name
                                PosFarm = v330.HumanoidRootPart.CFrame
                                StartMagnet = true
                            until not _G.AutoFarmFruitMastery or v330.Humanoid.Health <= 0 or not v330.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false

                            StartMagnet = false
                            UseSkill = false
                            Skillaimbot = false
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Farm Gun Mastery',
        Default = false,
        Callback = function(p331)
            _G.AutoFarmGunMastery = p331

            StopTween(_G.AutoFarmGunMastery)
        end,
    })

    function EquipWeaponGun()
        local v332, v333, v334 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

        while true do
            local v335

            v334, v335 = v332(v333, v334)

            if v334 == nil then
                break
            end
            if v335.ToolTip == 'Gun' and v335:IsA('Tool') then
                local v336 = game.Players.LocalPlayer.Backpack:FindFirstChild(v335.Name)

                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v336)
            end
        end
    end

    spawn(function()
        while wait() do
            if _G.AutoFarmGunMastery then
                pcall(function()
                    CheckQuest()

                    local _Text6 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text6, NameMon) then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                        if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                            if game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                                pcall(function()
                                    local v338, v339, v340 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v341

                                        v340, v341 = v338(v339, v340)

                                        if v340 == nil then
                                            return
                                        end
                                        if v341.Name == Mon and string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                            repeat
                                                if true then
                                                    wait()

                                                    HealthMin = v341.Humanoid.MaxHealth * _G.Kill_At / 100
                                                    ShootPosition = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -15, 0)

                                                    if v341.Humanoid.Health > HealthMin then
                                                        EquipWeapon(_G.SelectWeapon)
                                                        topos(v341.HumanoidRootPart.CFrame * Pos)

                                                        UseGunSkill = false
                                                        Skillaimbot = false
                                                    else
                                                        EquipWeaponGun()
                                                        topos(v341.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                                        game:GetService('Players').LocalPlayer.Character.Humanoid:FindFirstChild(''):InvokeServer('TAP', Vector3.new(ShootPosition.Position))

                                                        UseGunSkill = true
                                                        Skillaimbot = true
                                                    end
                                                end

                                                AimBotSkillPosition = v341.HumanoidRootPart.CFrame.Position
                                                StartMagnet = true
                                                PosFarm = v341.HumanoidRootPart.CFrame
                                                MonFarm = v341.Name
                                            until v341.Humanoid.Health <= 0 or _G.AutoFarmGunMastery == false or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false

                                            UseGunSkill = false
                                            Skillaimbot = false
                                            StartMagnet = false
                                        end
                                    end
                                end)
                            else
                                topos(CFrameMon)
                                UnEquipWeapon(_G.SelectWeapon)
                            end
                        end
                    else
                        topos(CFrameQuest)

                        if (CFrameQuest.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuest, LevelQuest)
                        end
                    end
                end)
            end
        end
    end)
    v174:AddSlider({
        Name = 'Kill Mobs At % Health',
        Min = 1,
        Max = 100,
        Default = 20,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '%',
        Callback = function(p342)
            _G.Kill_At = p342
        end,
    })
    v174:AddToggle({
        Name = 'Use Skill Z',
        Default = false,
        Callback = function(p343)
            _G.SkillZ = p343
        end,
    })
    v174:AddToggle({
        Name = 'Use Skill X',
        Default = false,
        Callback = function(p344)
            _G.SkillX = p344
        end,
    })
    v174:AddToggle({
        Name = 'Use Skill C',
        Default = false,
        Callback = function(p345)
            _G.SkillC = p345
        end,
    })
    v174:AddToggle({
        Name = 'Use Skill V',
        Default = false,
        Callback = function(p346)
            _G.SkillV = p346
        end,
    })
    v174:AddToggle({
        Name = 'Use Skill F',
        Default = false,
        Callback = function(p347)
            _G.SkillF = p347
        end,
    })
    spawn(function()
        while wait() do
            if UseSkill then
                local v348, v349, v350 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                while true do
                    local v351

                    v350, v351 = v348(v349, v350)

                    if v350 == nil then
                        break
                    end
                    if v351.Name == MonFarm and v351:FindFirstChild('Humanoid') and (v351:FindFirstChild('HumanoidRootPart') and v351.Humanoid.Health <= v351.Humanoid.MaxHealth * _G.Kill_At / 100) then
                        if _G.SkillZ then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                            wait(_G.HoldSKillZ)
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                        end
                        if _G.SkillX then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                            wait(_G.HoldSKillX)
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                        end
                        if _G.SkillC then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                            wait(_G.HoldSKillC)
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                        end
                        if _G.SkillV then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                            wait(_G.HoldSKillV)
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                        end
                        if _G.SkillF then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'F', false, game)
                            wait(_G.HoldSKillF)
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'F', false, game)
                        end
                    end
                end
            end
        end
    end)
    spawn(function()
        while wait() do
            if UseGunSkill then
                local v352, v353, v354 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                while true do
                    local v355

                    v354, v355 = v352(v353, v354)

                    if v354 == nil then
                        break
                    end
                    if v355.Name == MonFarm and v355:FindFirstChild('Humanoid') and (v355:FindFirstChild('HumanoidRootPart') and v355.Humanoid.Health <= v355.Humanoid.MaxHealth * _G.Kill_At / 100) then
                        if _G.SkillZ then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                            wait()
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                        end
                        if _G.SkillX then
                            game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                            wait()
                            game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                        end
                    end
                end
            end
        end
    end)
    v174:AddSection({
        Name = '~ Melee & Sword Mastery ~',
    })
    v174:AddParagraph('Note', 'Put Points Into Melee If Farming Melee Mastery, Same For Sword Mastery')
    v174:AddSlider({
        Name = 'Select Mastery ',
        Min = 1,
        Max = 600,
        Default = 300,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = 'Mastery',
        Callback = function(p356)
            _G.SeMastery = p356
        end,
    })

    function CheckMasSelect(p357)
        local v358, v359, v360 = pairs(game:GetService('Players').LocalPlayer.Backpack:GetChildren())

        while true do
            local v361

            v360, v361 = v358(v359, v360)

            if v360 == nil then
                break
            end
            if v361.ToolTip == p357 then
                return v361.Level.Value
            end
        end
    end

    spawn(function()
        while wait() do
            if _G.FarmAllMelee then
                if CheckMasSelect('Melee') == _G.SeMastery then
                    local v362, v363, v364 = pairs(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory'))

                    while true do
                        local v365

                        v364, v365 = v362(v363, v364)

                        if v364 == nil then
                            break
                        end
                        if type(v365) == 'table' and v365.Type == 'Melee' and v365.Mastery >= _G.SeMastery and not (game:GetService('Players').LocalPlayer.Backpack:FindFirstChild(v365.Name) or game:GetService('Players').LocalPlayer.Character:FindFirstChild(v365.Name)) then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LoadItem', v365.Name)
                        end
                    end
                end
            elseif _G.FarmAllSword and CheckMasSelect('Sword') == _G.SeMastery then
                local v366, v367, v368 = pairs(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory'))

                while true do
                    local v369

                    v368, v369 = v366(v367, v368)

                    if v368 == nil then
                        break
                    end
                    if type(v369) == 'table' and v369.Type == 'Sword' and v369.Mastery >= _G.SeMastery and not (game:GetService('Players').LocalPlayer.Backpack:FindFirstChild(v369.Name) or game:GetService('Players').LocalPlayer.Character:FindFirstChild(v369.Name)) then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('LoadItem', v369.Name)
                    end
                end
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.FarmAllMelee then
                local v370, v371, v372 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                while true do
                    local v373

                    v372, v373 = v370(v371, v372)

                    if v372 == nil then
                        break
                    end
                    if v373.ToolTip == 'Melee' and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v373.Name)) then
                        SelectAllMelee = v373.Name
                    end
                end
            elseif _G.FarmAllSword then
                local v374, v375, v376 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                while true do
                    local v377

                    v376, v377 = v374(v375, v376)

                    if v376 == nil then
                        break
                    end
                    if v377.ToolTip == 'Sword' and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v377.Name)) then
                        SelectAllSword = v377.Name
                    end
                end
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Farm All Melee Mastery',
        Default = false,
        Callback = function(p378)
            _G.FarmAllMelee = p378
        end,
    })
    spawn(function()
        while wait() do
            if _G.FarmAllMelee then
                pcall(function()
                    local _Text7 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text7, NameMon) then
                        StartMagnet = false

                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        StartMagnet = false

                        CheckQuest()
                        topos(CFrameQuest)

                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuest, LevelQuest)
                        end
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        CheckQuest()

                        if game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                            local v380, v381, v382 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v383

                                v382, v383 = v380(v381, v382)

                                if v382 == nil then
                                    break
                                end
                                if v383:FindFirstChild('HumanoidRootPart') and v383:FindFirstChild('Humanoid') and (v383.Humanoid.Health > 0 and v383.Name == Mon) then
                                    if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        wait()
                                        EquipWeapon(SelectAllMelee)
                                        topos(v383.HumanoidRootPart.CFrame * Pos)

                                        PosFarm = v383.HumanoidRootPart.CFrame
                                        StartMagnet = true

                                        if _G.FarmAllMelee and v383.Humanoid.Health > 0 and v383.Parent and game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                                        end
                                    else
                                        StartMagnet = false

                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                                    end
                                end
                            end
                        else
                            topos(CFrameMon)
                            UnEquipWeapon(_G.SelectWeapon)

                            StartMagnet = false
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Farm All Sword Mastery',
        Default = false,
        Callback = function(p384)
            _G.FarmAllSword = p384
        end,
    })
    spawn(function()
        while wait() do
            if _G.FarmAllSword then
                pcall(function()
                    local _Text8 = game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text

                    if not string.find(_Text8, NameMon) then
                        StartMagnet = false

                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                        StartMagnet = false

                        CheckQuest()
                        topos(CFrameQuest)

                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuest, LevelQuest)
                        end
                    end
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        CheckQuest()

                        if game:GetService('Workspace').Enemies:FindFirstChild(Mon) then
                            local v386, v387, v388 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v389

                                v388, v389 = v386(v387, v388)

                                if v388 == nil then
                                    break
                                end
                                if v389:FindFirstChild('HumanoidRootPart') and v389:FindFirstChild('Humanoid') and (v389.Humanoid.Health > 0 and v389.Name == Mon) then
                                    if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                        wait()
                                        EquipWeapon(SelectAllSword)
                                        topos(v389.HumanoidRootPart.CFrame * Pos)

                                        PosFarm = v389.HumanoidRootPart.CFrame
                                        StartMagnet = true

                                        if _G.FarmAllSword and v389.Humanoid.Health > 0 and v389.Parent and game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                                        end
                                    else
                                        StartMagnet = false

                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                                    end
                                end
                            end
                        else
                            topos(CFrameMon)
                            UnEquipWeapon(_G.SelectWeapon)

                            StartMagnet = false
                        end
                    end
                end)
            end
        end
    end)
    v174:AddSection({
        Name = '~ Boss ~',
    })

    local v390, v391, v392 = pairs(game:GetService('ReplicatedStorage'):GetChildren())
    local u393 = u127
    local u394 = u169
    local u395 = {}

    while true do
        local v396

        v392, v396 = v390(v391, v392)

        if v392 == nil then
            break
        end
        if v396.Name == 'rip_indra' or v396.Name == 'Ice Admiral' or (v396.Name == 'Saber Expert' or v396.Name == 'The Saw') or (v396.Name == 'Greybeard' or v396.Name == 'Mob Leader' or (v396.Name == 'The Gorilla King' or v396.Name == 'Bobby')) or (v396.Name == 'Yeti' or v396.Name == 'Vice Admiral' or (v396.Name == 'Warden' or v396.Name == 'Chief Warden') or (v396.Name == 'Swan' or v396.Name == 'Magma Admiral' or (v396.Name == 'Fishman Lord' or v396.Name == 'Wysper'))) or (v396.Name == 'Thunder God' or v396.Name == 'Cyborg' or (v396.Name == 'Don Swan' or v396.Name == 'Diamond') or (v396.Name == 'Jeremy' or v396.Name == 'Fajita' or (v396.Name == 'Smoke Admiral' or v396.Name == 'Awakened Ice Admiral')) or (v396.Name == 'Tide Keeper' or v396.Name == 'Order' or (v396.Name == 'Darkbeard' or v396.Name == 'Cursed Captain') or (v396.Name == 'Stone' or v396.Name == 'Island Empress' or (v396.Name == 'Kilo Admiral' or v396.Name == 'Captain Elephant')))) or (v396.Name == 'Beautiful Pirate' or v396.Name == 'Cake Queen' or (v396.Name == 'rip_indra True Form' or v396.Name == 'Longma') or (v396.Name == 'Soul Reaper' or v396.Name == 'Cake Prince' or v396.Name == 'Dough King')) then
            table.insert(u395, v396.Name)
        end
    end

    v174:AddDropdown({
        Name = 'Select Farm Boss Mode',
        Default = 'No Quest',
        Options = {
            'No Quest',
            'Get Quest',
        },
        Callback = function(p397)
            ModeBoss = p397
        end,
    })

    local u399 = v174:AddDropdown({
        Name = 'Select Boss',
        Default = '',
        Options = u395,
        Callback = function(p398)
            SelectBoss = p398
        end,
    })

    v174:AddButton({
        Name = 'Refresh Boss List',
        Callback = function()
            u399:Refresh(u395, true)

            local v400, v401, v402 = pairs(game:GetService('ReplicatedStorage'):GetChildren())
            local v403 = {}

            while true do
                local v404

                v402, v404 = v400(v401, v402)

                if v402 == nil then
                    break
                end
                if v404.Name == 'rip_indra' or v404.Name == 'Ice Admiral' or (v404.Name == 'Saber Expert' or v404.Name == 'The Saw') or (v404.Name == 'Greybeard' or v404.Name == 'Mob Leader' or (v404.Name == 'The Gorilla King' or v404.Name == 'Bobby')) or (v404.Name == 'Yeti' or v404.Name == 'Vice Admiral' or (v404.Name == 'Warden' or v404.Name == 'Chief Warden') or (v404.Name == 'Swan' or v404.Name == 'Magma Admiral' or (v404.Name == 'Fishman Lord' or v404.Name == 'Wysper'))) or (v404.Name == 'Thunder God' or v404.Name == 'Cyborg' or (v404.Name == 'Don Swan' or v404.Name == 'Diamond') or (v404.Name == 'Jeremy' or v404.Name == 'Fajita' or (v404.Name == 'Smoke Admiral' or v404.Name == 'Awakened Ice Admiral')) or (v404.Name == 'Tide Keeper' or v404.Name == 'Order' or (v404.Name == 'Darkbeard' or v404.Name == 'Cursed Captain') or (v404.Name == 'Stone' or v404.Name == 'Island Empress' or (v404.Name == 'Kilo Admiral' or v404.Name == 'Captain Elephant')))) or (v404.Name == 'Beautiful Pirate' or v404.Name == 'Cake Queen' or (v404.Name == 'rip_indra True Form' or v404.Name == 'Longma') or (v404.Name == 'Soul Reaper' or v404.Name == 'Cake Prince' or v404.Name == 'Dough King')) then
                    table.insert(v403, v404.Name)
                end
            end

            u399:Refresh(v403)
        end,
    })
    v174:AddToggle({
        Name = 'Auto Farm Boss',
        Default = false,
        Callback = function(p405)
            _G.AutoFarmBoss = p405

            StopTween(_G.AutoFarmBoss)
        end,
    })
    spawn(function()
        while wait() do
            if ModeBoss == 'No Quest' and _G.AutoFarmBoss then
                pcall(function()
                    CheckBossQuest()

                    if game:GetService('Workspace').Enemies:FindFirstChild(SelectBoss) then
                        local v406, v407, v408 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v409

                            v408, v409 = v406(v407, v408)

                            if v408 == nil then
                                break
                            end
                            if v409.Name == SelectBoss and v409:FindFirstChild('Humanoid') and (v409:FindFirstChild('HumanoidRootPart') and 0 < v409.Humanoid.Health) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v409.HumanoidRootPart.CFrame * Pos)
                                until not (_G.AutoFarmBoss and v409.Parent) or v409.Humanoid.Health <= 0
                            end
                        end
                    else
                        topos(CFrameBoss)
                        UnEquipWeapon(_G.SelectWeapon)
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if ModeBoss == 'Get Quest' and _G.AutoFarmBoss then
                pcall(function()
                    CheckBossQuest()

                    if MsBoss == 'Soul Reaper' or (MsBoss == 'Longma' or MsBoss == 'Don Swan') or (MsBoss == 'Cursed Captain' or MsBoss == 'Order' or MsBoss == 'rip_indra True Form') then
                        if game:GetService('Workspace').Enemies:FindFirstChild(MsBoss) then
                            local v410, v411, v412 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v413

                                v412, v413 = v410(v411, v412)

                                if v412 == nil then
                                    break
                                end
                                if v413.Name == MsBoss then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v413.HumanoidRootPart.CFrame * Pos)
                                    until _G.AutoFarmBoss == false or not v413.Parent or v413.Humanoid.Health <= 0
                                end
                            end
                        else
                            topos(CFrameBoss)
                        end
                    elseif ModeBoss ~= 'Get Quest' or not _G.AutoFarmBoss then
                        if game:GetService('Workspace').Enemies:FindFirstChild(MsBoss) then
                            local v414, v415, v416 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v417

                                v416, v417 = v414(v415, v416)

                                if v416 == nil then
                                    break
                                end
                                if v417.Name == MsBoss then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v417.HumanoidRootPart.CFrame * Pos)
                                    until _G.AutoFarmBoss == false or not v417.Parent or v417.Humanoid.Health <= 0
                                end
                            end
                        else
                            topos(CFrameBoss)
                        end
                    else
                        CheckBossQuest()

                        if not string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameBoss) then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
                        end
                        if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                            if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                                if game:GetService('Workspace').Enemies:FindFirstChild(MsBoss) then
                                    local v418, v419, v420 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v421

                                        v420, v421 = v418(v419, v420)

                                        if v420 == nil then
                                            break
                                        end
                                        if v421.Name == MsBoss then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                topos(v421.HumanoidRootPart.CFrame * Pos)
                                            until _G.AutoFarmBoss == false or not v421.Parent or v421.Humanoid.Health <= 0
                                        end
                                    end
                                else
                                    topos(CFrameBoss)
                                end
                            end
                        else
                            repeat
                                wait()
                                topos(CFrameQuestBoss)
                            until (CFrameQuestBoss.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.AutoFarmBoss

                            if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                wait(1.1)
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', NameQuestBoss, LevelQuestBoss)
                            end
                        end
                    end
                end)
            end
        end
    end)
    v174:AddToggle({
        Name = 'Auto Farm All Boss',
        Default = false,
        Callback = function(p422)
            _G.AutoAllBoss = p422

            StopTween(_G.AutoAllBoss)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoAllBoss then
                pcall(function()
                    local v423, v424, v425 = pairs(game.ReplicatedStorage:GetChildren())

                    while true do
                        local v426

                        v425, v426 = v423(v424, v425)

                        if v425 == nil then
                            break
                        end
                        if (v426.Name == 'rip_indra' or v426.Name == 'Ice Admiral' or (v426.Name == 'Saber Expert' or v426.Name == 'The Saw') or (v426.Name == 'Greybeard' or v426.Name == 'Mob Leader' or (v426.Name == 'The Gorilla King' or v426.Name == 'Bobby')) or (v426.Name == 'Yeti' or v426.Name == 'Vice Admiral' or (v426.Name == 'Warden' or v426.Name == 'Chief Warden') or (v426.Name == 'Swan' or v426.Name == 'Magma Admiral' or (v426.Name == 'Fishman Lord' or v426.Name == 'Wysper'))) or (v426.Name == 'Thunder God' or v426.Name == 'Cyborg' or (v426.Name == 'Don Swan' or v426.Name == 'Diamond') or (v426.Name == 'Jeremy' or v426.Name == 'Fajita' or (v426.Name == 'Smoke Admiral' or v426.Name == 'Awakened Ice Admiral')) or (v426.Name == 'Tide Keeper' or v426.Name == 'Order' or (v426.Name == 'Darkbeard' or v426.Name == 'Cursed Captain') or (v426.Name == 'Stone' or v426.Name == 'Island Empress' or (v426.Name == 'Kilo Admiral' or v426.Name == 'Captain Elephant')))) or (v426.Name == 'Beautiful Pirate' or v426.Name == 'Cake Queen' or (v426.Name == 'rip_indra True Form' or v426.Name == 'Longma') or (v426.Name == 'Soul Reaper' or v426.Name == 'Cake Prince' or v426.Name == 'Dough King'))) and (v426.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 17000 then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v426.HumanoidRootPart.CFrame * Pos)
                            until v426.Humanoid.Health <= 0 or _G.AutoAllBoss == false or not v426.Parent
                        end
                    end
                end)
            end
        end
    end)
    v174:AddSection({
        Name = '~ Mobs ~',
    })

    if World1 then
        TableMon = {
            'Bandit',
            'Monkey',
            'Gorilla',
            'Pirate',
            'Brute',
            'Desert Bandit',
            'Desert Officer',
            'Snow Bandit',
            'Snowman',
            'Chief Petty Officer',
            'Sky Bandit',
            'Dark Master',
            'Toga Warrior',
            'Gladiator',
            'Military Soldier',
            'Military Spy',
            'Fishman Warrior',
            'Fishman Commando',
            "God's Guard",
            'Shanda',
            'Royal Squad',
            'Royal Soldier',
            'Galley Pirate',
            'Galley Captain',
        }
    elseif World2 then
        TableMon = {
            'Raider',
            'Mercenary',
            'Swan Pirate',
            'Factory Staff',
            'Marine Lieutenant',
            'Marine Captain',
            'Zombie',
            'Vampire',
            'Snow Trooper',
            'Winter Warrior',
            'Lab Subordinate',
            'Horned Warrior',
            'Magma Ninja',
            'Lava Pirate',
            'Ship Deckhand',
            'Ship Engineer',
            'Ship Steward',
            'Ship Officer',
            'Arctic Warrior',
            'Snow Lurker',
            'Sea Soldier',
            'Water Fighter',
        }
    elseif World3 then
        TableMon = {
            'Pirate Millionaire',
            'Dragon Crew Warrior',
            'Dragon Crew Archer',
            'Female Islander',
            'Giant Islander',
            'Marine Commodore',
            'Marine Rear Admiral',
            'Fishman Raider',
            'Fishman Captain',
            'Forest Pirate',
            'Mythological Pirate',
            'Jungle Pirate',
            'Musketeer Pirate',
            'Reborn Skeleton',
            'Living Zombie',
            'Demonic Soul',
            'Posessed Mummy',
            'Peanut Scout',
            'Peanut President',
            'Ice Cream Chef',
            'Ice Cream Commander',
            'Cookie Crafter',
            'Cake Guard',
            'Baking Staff',
            'Head Baker',
            'Cocoa Warrior',
            'Chocolate Bar Battler',
            'Sweet Thief',
            'Candy Rebel',
            'Candy Pirate',
            'Snow Demon',
            'Isle Outlaw',
            'Island Boy',
            'Sun-kissed Warrior',
            'Isle Champion',
        }
    end

    v174:AddDropdown({
        Name = 'Select Mobs',
        Default = '',
        Options = TableMon,
        Callback = function(p427)
            SelectMob = p427
        end,
    })
    v174:AddToggle({
        Name = 'Auto Farm Mobs',
        Default = false,
        Callback = function(p428)
            _G.AutoFarmMob = p428

            StopTween(_G.AutoFarmMob)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoFarmMob then
                pcall(function()
                    CheckMonFarm(SelectMob)

                    if game:GetService('Workspace').Enemies:FindFirstChild(SelectMob) then
                        local v429, v430, v431 = pairs(game.Workspace.Enemies:GetChildren())

                        while true do
                            local v432

                            v431, v432 = v429(v430, v431)

                            if v431 == nil then
                                break
                            end
                            if v432:FindFirstChild('Humanoid') and v432:FindFirstChild('HumanoidRootPart') and (v432.Humanoid.Health > 0 and v432.Name == SelectMob) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v432.HumanoidRootPart.CFrame * Pos)

                                    PosMonFarm = v432.HumanoidRootPart.CFrame
                                    SelectMag = true
                                until not (_G.AutoFarmMob and v432.Parent) or v432.Humanoid.Health <= 0

                                SelectMag = false
                            end
                        end
                    else
                        topos(PosMonster)
                        UnEquipWeapon(_G.SelectWeapon)
                    end
                end)
            end
        end
    end)
    v174:AddSection({
        Name = '~ Material ~',
    })

    if World1 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Angel Wings',
            'Magma Ore',
            'Fish Tail',
        }
    elseif World2 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Radioactive Material',
            'Ectoplasm',
            'Mystic Droplet',
            'Magma Ore',
            'Vampire Fang',
        }
    elseif World3 then
        MaterialList = {
            'Scrap Metal',
            'Leather',
            'Demonic Wisp',
            'Conjured Cocoa',
            'Dragon Scale',
            'Gunpowder',
            'Fish Tail',
            'Mini Tusk',
        }
    end

    v174:AddDropdown({
        Name = 'Select Material',
        Default = '',
        Options = MaterialList,
        Callback = function(p433)
            SelectMaterial = p433
        end,
    })
    v174:AddToggle({
        Name = 'Auto Farm Material',
        Default = false,
        Callback = function(p434)
            _G.AutoMaterial = p434

            StopTween(_G.AutoMaterial)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoMaterial then
                pcall(function()
                    MaterialMon(SelectMaterial)

                    if game:GetService('Workspace').Enemies:FindFirstChild(MMon) or game:GetService('Workspace').Enemies:FindFirstChild(MMon1) then
                        local v435, v436, v437 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v438

                            v437, v438 = v435(v436, v437)

                            if v437 == nil then
                                break
                            end
                            if v438:FindFirstChild('Humanoid') and v438:FindFirstChild('HumanoidRootPart') and v438.Humanoid.Health > 0 and (v438.Name == MMon or v438.Name == MMon1) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v438.HumanoidRootPart.CFrame * Pos)

                                    MaterialPos = v438.HumanoidRootPart.CFrame
                                    BringMonMaterial = true
                                until not (_G.AutoMaterial and v438.Parent) or v438.Humanoid.Health <= 0

                                BringMonMaterial = false
                            end
                        end
                    else
                        UnEquipWeapon(_G.SelectWeapon)
                        topos(MPos)
                        wait(3)
                        topos(MPos1)
                        wait(3)
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if SelectMaterial == 'Ectoplasm' and _G.AutoMaterial then
                pcall(function()
                    if game:GetService('Workspace').Enemies:FindFirstChild('Ship Deckhand') or (game:GetService('Workspace').Enemies:FindFirstChild('Ship Engineer') or game:GetService('Workspace').Enemies:FindFirstChild('Ship Steward')) or (game:GetService('Workspace').Enemies:FindFirstChild('Ship Officer') or game:GetService('Workspace').Enemies:FindFirstChild('Cursed Captain')) then
                        local v439, v440, v441 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v442

                            v441, v442 = v439(v440, v441)

                            if v441 == nil then
                                break
                            end
                            if v442.Name == 'Ship Deckhand' or v442.Name == 'Ship Engineer' or (v442.Name == 'Ship Steward' or v442.Name == 'Ship Officer') or v442.Name == 'Cursed Captain' then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v442.HumanoidRootPart.CFrame * Pos)

                                    PosNear = v442.HumanoidRootPart.CFrame
                                    MagnetNear = true
                                until not (_G.AutoMaterial and v442.Parent) or v442.Humanoid.Health <= 0

                                MagnetNear = false
                            end
                        end
                    else
                        topos(CFrame.new(916.928589, 181.092773, 33422))
                        UnEquipWeapon(_G.SelectWeapon)
                    end
                end)
            end
        end
    end)
    v175:AddSection({
        Name = '~ Devil Fruit ~',
    })

    FruitList = {
        'Rocket-Rocket',
        'Spin-Spin',
        'Chop-Chop',
        'Spring-Spring',
        'Bomb-Bomb',
        'Smoke-Smoke',
        'Spike-Spike',
        'Flame-Flame',
        'Falcon-Falcon',
        'Ice-Ice',
        'Sand-Sand',
        'Dark-Dark',
        'Diamond-Diamond',
        'Light-Light',
        'Rubber-Rubber',
        'Barrier-Barrier',
        'Ghost-Ghost',
        'Magma-Magma',
        'Quake-Quake',
        'Buddha-Buddha',
        'Love-Love',
        'Spider-Spider',
        'Sound-Sound',
        'Phoenix-Phoenix',
        'Portal-Portal',
        'Rumble-Rumble',
        'Pain-Pain',
        'Blizzard-Blizzard',
        'Gravity-Gravity',
        'Mammoth-Mammoth',
        'T-Rex-T-Rex',
        'Dough-Dough',
        'Shadow-Shadow',
        'Venom-Venom',
        'Control-Control',
        'Spirit-Spirit',
        'Dragon-Dragon',
        'Leopard-Leopard',
        'Kitsune-Kitsune',
    }

    local _GetFruits = game.ReplicatedStorage:FindFirstChild('Remotes').CommF_:InvokeServer('GetFruits')

    Table_DevilFruitSniper = {}
    ShopDevilSell = {}

    local v444 = next
    local v445 = nil

    while true do
        local v446

        v445, v446 = v444(_GetFruits, v445)

        if v445 == nil then
            break
        end

        table.insert(Table_DevilFruitSniper, v446.Name)

        if v446.OnSale then
            table.insert(ShopDevilSell, v446.Name)
        end
    end

    _G.SelectFruit = ''

    v175:AddDropdown({
        Name = 'Select Devil Fruit',
        Default = '',
        Options = Table_DevilFruitSniper,
        Callback = function(p447)
            _G.SelectFruit = p447
        end,
    })
    v175:AddToggle({
        Name = 'Auto Buy Devil Fruit Sniper',
        Default = false,
        Callback = function(p448)
            _G.AutoBuyFruitSniper = p448
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyFruitSniper then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('GetFruits')
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('PurchaseRawFruit', _G.SelectFruit)
            end
        end
    end)
    v175:AddButton({
        Name = 'Random Devil Fruit',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Cousin', 'Buy')
        end,
    })
    v175:AddToggle({
        Name = 'Auto Random Devil Fruit',
        Default = false,
        Callback = function(p449)
            _G.Random_Auto = p449
        end,
    })
    spawn(function()
        while wait() do
            if _G.Random_Auto then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Cousin', 'Buy')
            end
        end
    end)

    local u450 = {
        Common = {
            'Rocket Fruit',
            'Spin Fruit',
            'Chop Fruit',
            'Spring Fruit',
            'Bomb Fruit',
            'Smoke Fruit',
            'Spike Fruit',
        },
        Uncommon = {
            'Flame Fruit',
            'Falcon Fruit',
            'Ice Fruit',
            'Sand Fruit',
            'Diamond Fruit',
            'Dark Fruit',
        },
        Rare = {
            'Light Fruit',
            'Rubber Fruit',
            'Barrier Fruit',
            'Ghost Fruit',
            'Magma Fruit',
        },
        Legendary = {
            'Quake Fruit',
            'Budha Fruit',
            'Love Fruit',
            'Spider Fruit',
            'Sound Fruit',
            'Phoenix Fruit',
            'Portal Fruit',
            'Rumble Fruit',
            'Pain Fruit',
            'Blizzard Fruit',
        },
        Mythical = {
            'Gravity Fruit',
            'Mammoth Fruit',
            'T-Rex Fruit',
            'Dough Fruit',
            'Shadow Fruit',
            'Venom Fruit',
            'Control Fruit',
            'Spirit Fruit',
            'Dragon Fruit',
            'Leopard Fruit',
            'Kitsune Fruit',
        },
    }

    v175:AddDropdown({
        Name = 'Store Rarity Devil Fruit',
        Default = 'Common -> Mythical',
        Options = {
            'Common -> Mythical',
            'Uncommon -> Mythical',
            'Rare -> Mythical',
            'Legendary -> Mythical',
            'Mythical',
        },
        Callback = function(p451)
            _G.SetRarityFruits = p451
        end,
    })

    function CheckFruits()
        local v452, v453, v454 = pairs(u450)

        while true do
            local v455

            v454, v455 = v452(v453, v454)

            if v454 == nil then
                break
            end
            if _G.SetRarityFruits ~= 'Common -> Mythical' then
                if _G.SetRarityFruits ~= 'Uncommon -> Mythical' then
                    if _G.SetRarityFruits ~= 'Rare -> Mythical' then
                        if _G.SetRarityFruits ~= 'Legendary -> Mythical' then
                            if _G.SetRarityFruits == 'Mythical' and v454 == 'Mythical' then
                                local v456, v457, v458 = ipairs(v455)

                                while true do
                                    local v459

                                    v458, v459 = v456(v457, v458)

                                    if v458 == nil then
                                        break
                                    end

                                    table.insert(ResultStoreFruits, v459)
                                end
                            end
                        elseif v454 == 'Legendary' or v454 == 'Mythical' then
                            local v460, v461, v462 = ipairs(v455)

                            while true do
                                local v463

                                v462, v463 = v460(v461, v462)

                                if v462 == nil then
                                    break
                                end

                                table.insert(ResultStoreFruits, v463)
                            end
                        end
                    elseif v454 == 'Rare' or v454 == 'Legendary' or v454 == 'Mythical' then
                        local v464, v465, v466 = ipairs(v455)

                        while true do
                            local v467

                            v466, v467 = v464(v465, v466)

                            if v466 == nil then
                                break
                            end

                            table.insert(ResultStoreFruits, v467)
                        end
                    end
                elseif v454 == 'Uncommon' or v454 == 'Rare' or (v454 == 'Legendary' or v454 == 'Mythical') then
                    local v468, v469, v470 = ipairs(v455)

                    while true do
                        local v471

                        v470, v471 = v468(v469, v470)

                        if v470 == nil then
                            break
                        end

                        table.insert(ResultStoreFruits, v471)
                    end
                end
            elseif v454 == 'Common' or v454 == 'Uncommon' or (v454 == 'Rare' or v454 == 'Legendary') or v454 == 'Mythical' then
                local v472, v473, v474 = ipairs(v455)

                while true do
                    local v475

                    v474, v475 = v472(v473, v474)

                    if v474 == nil then
                        break
                    end

                    table.insert(ResultStoreFruits, v475)
                end
            end
        end
    end

    v175:AddToggle({
        Name = 'Auto Store Devil Fruit',
        Default = false,
        Callback = function(p476)
            _G.AutoStoreFruit = p476
        end,
    })
    spawn(function()
        while wait() do
            pcall(function()
                if _G.AutoStoreFruit then
                    local v477, v478, v479 = pairs(game:GetService('Players').LocalPlayer.Backpack:GetChildren())

                    while true do
                        local v480

                        v479, v480 = v477(v478, v479)

                        if v479 == nil then
                            break
                        end
                        if string.find(v480.Name, 'Fruit') then
                            ResultStoreFruits = {}

                            CheckFruits()

                            local v481, v482, v483 = pairs(ResultStoreFruits)

                            while true do
                                local v484

                                v483, v484 = v481(v482, v483)

                                if v483 == nil then
                                    break
                                end
                                if v480.Name == v484 then
                                    local _Name = v480.Name
                                    local v486 = string.gsub(v480.Name, ' Fruit', '')

                                    if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild(_Name) then
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StoreFruit', v486 .. '-' .. v486, game:GetService('Players').LocalPlayer.Backpack:FindFirstChild(_Name))
                                    end
                                end
                            end
                        end
                    end

                    local v487, v488, v489 = pairs(game:GetService('Players').LocalPlayer.Character:GetChildren())

                    while true do
                        local v490

                        v489, v490 = v487(v488, v489)

                        if v489 == nil then
                            break
                        end
                        if string.find(v490.Name, 'Fruit') then
                            ResultStoreFruits = {}

                            CheckFruits()

                            local v491, v492, v493 = pairs(ResultStoreFruits)

                            while true do
                                local v494

                                v493, v494 = v491(v492, v493)

                                if v493 == nil then
                                    break
                                end
                                if v490.Name == v494 then
                                    local _Name2 = v490.Name
                                    local v496 = string.gsub(v490.Name, ' Fruit', '')

                                    if game:GetService('Players').LocalPlayer.Character:FindFirstChild(_Name2) then
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StoreFruit', v496 .. '-' .. v496, game:GetService('Players').LocalPlayer.Character:FindFirstChild(_Name2))
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    v175:AddToggle({
        Name = 'Teleport To Devil Fruit',
        Default = false,
        Callback = function(p497)
            _G.Tweenfruit = p497

            StopTween(_G.Tweenfruit)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Tweenfruit then
                local v498, v499, v500 = pairs(game.Workspace:GetChildren())

                while true do
                    local v501

                    v500, v501 = v498(v499, v500)

                    if v500 == nil then
                        break
                    end
                    if string.find(v501.Name, 'Fruit') then
                        topos(v501.Handle.CFrame)
                    end
                end
            end
        end
    end)
    v175:AddToggle({
        Name = 'Bring To Devil Fruit [ 75% Kick System ]',
        Default = false,
        Callback = function(p502)
            _G.Grabfruit = p502
        end,
    })
    spawn(function()
        while wait(1) do
            if _G.Grabfruit then
                local v503, v504, v505 = pairs(game.Workspace:GetChildren())

                while true do
                    local v506

                    v505, v506 = v503(v504, v505)

                    if v505 == nil then
                        break
                    end
                    if string.find(v506.Name, 'Fruit') then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v506.Handle.CFrame
                    end
                end
            end
        end
    end)
    v175:AddSection({
        Name = '~ Raid ~',
    })

    SelectChip = selectraids or ''
    Raidslist = {}
    RaidsModule = require(game.ReplicatedStorage.Raids)

    local v507, v508, v509 = pairs(RaidsModule.raids)

    while true do
        local v510

        v509, v510 = v507(v508, v509)

        if v509 == nil then
            break
        end

        table.insert(Raidslist, v510)
    end

    local v511, v512, v513 = pairs(RaidsModule.advancedRaids)

    while true do
        local v514

        v513, v514 = v511(v512, v513)

        if v513 == nil then
            break
        end

        table.insert(Raidslist, v514)
    end

    v175:AddDropdown({
        Name = 'Select Chip',
        Default = '',
        Options = Raidslist,
        Callback = function(p515)
            SelectChip = p515
        end,
    })
    v175:AddToggle({
        Name = 'Auto Buy Chip',
        Default = false,
        Callback = function(p516)
            _G.AutoBuyChip = p516
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyChip then
                local v517 = {
                    'RaidsNpc',
                    'Select',
                    SelectChip,
                }

                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v517))
            end
        end
    end)
    v175:AddToggle({
        Name = 'Auto Get Devil Fruit [ Under 1M Beli ]',
        Default = false,
        Callback = function(p518)
            _G.AutoFruit = p518
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoFruit then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Rocket-Rocket',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Spin-Spin',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Chop-Chop',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Spring-Spring',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Bomb-Bomb',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Smoke-Smoke',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Spike-Spike',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Flame-Flame',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Falcon-Falcon',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Ice-Ice',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Sand-Sand',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Dark-Dark',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Ghost-Ghost',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Diamond-Diamond',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Light-Light',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Rubber-Rubber',
                }))
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                    'LoadFruit',
                    'Barrier-Barrier',
                }))
            end
        end
    end)
    v175:AddToggle({
        Name = 'Auto Start Raid',
        Default = false,
        Callback = function(p519)
            _G.Auto_StartRaid = p519
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_StartRaid and game:GetService('Players').LocalPlayer.PlayerGui.Main.Timer.Visible == false and (not game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 1') and game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Special Microchip') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Special Microchip')) then
                if World2 then
                    fireclickdetector(game:GetService('Workspace').Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                elseif World3 then
                    fireclickdetector(game:GetService('Workspace').Map['Boat Castle'].RaidSummon2.Button.Main.ClickDetector)
                end
            end
        end
    end)
    v175:AddToggle({
        Name = 'Kill Aura',
        Default = false,
        Callback = function(p520)
            _G.Kill_Aura = p520
        end,
    })
    spawn(function()
        while wait() do
            if _G.Kill_Aura then
                local v521, v522, v523 = pairs(game.Workspace.Enemies:GetDescendants())

                while true do
                    local v524

                    v523, v524 = v521(v522, v523)

                    if v523 == nil then
                        break
                    end
                    if v524:FindFirstChild('Humanoid') and v524:FindFirstChild('HumanoidRootPart') and v524.Humanoid.Health > 0 then
                        repeat
                            wait()
                            sethiddenproperty(game:GetService('Players').LocalPlayer, 'SimulationRadius', math.huge)

                            v524.Humanoid.Health = 0
                            v524.HumanoidRootPart.CanCollide = false
                        until not (_G.Kill_Aura and v524.Parent) or v524.Humanoid.Health <= 0
                    end
                end
            end
        end
    end)
    v175:AddToggle({
        Name = 'Auto Next Island',
        Default = false,
        Callback = function(p525)
            _G.NextIsland = p525

            StopTween(_G.NextIsland)
        end,
    })

    RaidPos = CFrame.new(0, 70, 0)

    spawn(function()
        while wait() do
            if _G.NextIsland and game:GetService('Players').LocalPlayer.PlayerGui.Main.Timer.Visible == true then
                if game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 5') then
                    topos(game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 5').CFrame * RaidPos)
                elseif game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 4') then
                    topos(game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 4').CFrame * RaidPos)
                elseif game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 3') then
                    topos(game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 3').CFrame * RaidPos)
                elseif game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 2') then
                    topos(game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 2').CFrame * RaidPos)
                elseif game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 1') then
                    topos(game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Island 1').CFrame * RaidPos)
                end
            end
        end
    end)
    v175:AddToggle({
        Name = 'Auto Awakener Devil Fruit',
        Default = false,
        Callback = function(p526)
            _G.Auto_Awakener = p526
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_Awakener then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Awakener', 'Check')
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Awakener', 'Awaken')
            end
        end
    end)
    v175:AddSection({
        Name = '~ Law Raid ~',
    })
    v175:AddButton({
        Name = 'Buy Chip Law',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                'BlackbeardReward',
                'Microchip',
                '2',
            }))
        end,
    })
    v175:AddToggle({
        Name = 'Auto Start Raid Law',
        Default = false,
        Callback = function(p527)
            _G.StartRaidLaw = p527
        end,
    })
    spawn(function()
        while wait() do
            if _G.StartRaidLaw and World2 then
                fireclickdetector(game:GetService('Workspace').Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
            end
        end
    end)
    v175:AddToggle({
        Name = 'Auto Kill Law',
        Default = false,
        Callback = function(p528)
            _G.AutoOderSword = p528

            StopTween(_G.AutoOderSword)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoOderSword and (game:GetService('ReplicatedStorage'):FindFirstChild('Order') or game:GetService('Workspace').Enemies:FindFirstChild('Order')) then
                if game:GetService('Workspace').Enemies:FindFirstChild('Order') then
                    local v529, v530, v531 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v532

                        v531, v532 = v529(v530, v531)

                        if v531 == nil then
                            break
                        end
                        if v532.Name == 'Order' then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v532.HumanoidRootPart.CFrame * Pos)
                            until not v532.Parent or v532.Humanoid.Health <= 0 or _G.AutoOderSword == false
                        end
                    end
                elseif game:GetService('ReplicatedStorage'):FindFirstChild('Order') then
                    topos(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Game Event ~',
    })
    v176:AddToggle({
        Name = 'Auto Pirate Raid',
        Default = false,
        Callback = function(p533)
            _G.RaidPirate = p533

            StopTween(_G.RaidPirate)
        end,
    })
    spawn(function()
        while wait() do
            if _G.RaidPirate and World3 then
                if (CFrame.new(-5118.48682, 314.54129, -2958.64404, -0.387232125, 1.81507858e-8, 0.921982229, -7.54388907e-8, 1, -5.13709999e-8, -0.921982229, -8.944581959999999e-8, -0.387232125).Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
                    if (CFrame.new(-5118.48682, 314.54129, -2958.64404, -0.387232125, 1.81507858e-8, 0.921982229, -7.54388907e-8, 1, -5.13709999e-8, -0.921982229, -8.944581959999999e-8, -0.387232125).Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                        local v534, v535, v536 = pairs(game.ReplicatedStorage:GetChildren())

                        while true do
                            local v537

                            v536, v537 = v534(v535, v536)

                            if v536 == nil then
                                break
                            end
                            if v537:FindFirstChild('Humanoid') and v537:FindFirstChild('HumanoidRootPart') and v537.Humanoid.Health > 0 and (v537.HumanoidRootPart.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                                topos(v537.HumanoidRootPart.CFrame * Pos)
                            end
                        end
                    end

                    topos(CFrame.new(-5118.48682, 314.54129, -2958.64404, -0.387232125, 1.81507858e-8, 0.921982229, -7.54388907e-8, 1, -5.13709999e-8, -0.921982229, -8.944581959999999e-8, -0.387232125))
                else
                    local v538, v539, v540 = pairs(game.Workspace.Enemies:GetChildren())

                    while true do
                        local v541

                        v540, v541 = v538(v539, v540)

                        if v540 == nil then
                            break
                        end
                        if v541:FindFirstChild('Humanoid') and v541:FindFirstChild('HumanoidRootPart') and v541.Humanoid.Health > 0 and (v541.HumanoidRootPart.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v541.HumanoidRootPart.CFrame * Pos)

                                PosNear = v541.HumanoidRootPart.CFrame
                                MagnetNear = true
                            until not (_G.RaidPirate and v541.Parent) or v541.Humanoid.Health <= 0

                            MagnetNear = false
                        end
                    end
                end
            end
        end
    end)
    v176:AddToggle({
        Name = 'Auto Factory',
        Default = false,
        Callback = function(p542)
            _G.AutoFactory = p542

            StopTween(_G.AutoFactory)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoFactory and World2 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Core') then
                    local v543, v544, v545 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v546

                        v545, v546 = v543(v544, v545)

                        if v545 == nil then
                            break
                        end
                        if v546.Name == 'Core' and 0 < v546.Humanoid.Health then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(CFrame.new(448.46756, 199.356781, -441.389252))
                            until v546.Humanoid.Health <= 0 or _G.AutoFactory == false
                        end
                    end
                else
                    topos(CFrame.new(448.46756, 199.356781, -441.389252))
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Elite Hunter ~',
    })

    local _Elite = v176:AddParagraph('Elite')

    v176:AddToggle({
        Name = 'Auto Kill Elite',
        Default = false,
        Callback = function(p548)
            _G.AutoElitehunter = p548

            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
            StopTween(_G.AutoElitehunter)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoElitehunter then
                if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter')
                elseif string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Diablo') or string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Deandre') or string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Urban') then
                    if game:GetService('Workspace').Enemies:FindFirstChild('Diablo') or game:GetService('Workspace').Enemies:FindFirstChild('Deandre') or game:GetService('Workspace').Enemies:FindFirstChild('Urban') then
                        local v549, v550, v551 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v552

                            v551, v552 = v549(v550, v551)

                            if v551 == nil then
                                break
                            end
                            if (v552.Name == 'Diablo' or v552.Name == 'Deandre' or v552.Name == 'Urban') and (v552:FindFirstChild('Humanoid') and v552:FindFirstChild('HumanoidRootPart') and v552.Humanoid.Health > 0) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v552.HumanoidRootPart.CFrame * Pos)
                                until not _G.AutoElitehunter or v552.Humanoid.Health <= 0 or not v552.Parent
                            end
                        end
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Diablo') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Diablo').HumanoidRootPart.CFrame * Pos)
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Deandre') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Deandre').HumanoidRootPart.CFrame * Pos)
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Urban') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Urban').HumanoidRootPart.CFrame * Pos)
                    end
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Chest ~',
    })
    v176:AddDropdown({
        Name = 'Select Team When Farm Chest [ Bypass ]',
        Default = 'Pirates',
        Options = {
            'Pirates',
            'Marines',
        },
        Callback = function(p553)
            _G.TeamChest = p553
        end,
    })
    v176:AddToggle({
        Name = 'Auto Farm Chest [ Bypass ]',
        Default = false,
        Callback = function(p554)
            _G.ChestBypass = p554

            StopTween(_G.ChestBypass)
        end,
    })
    spawn(function()
        while wait() do
            if _G.ChestBypass then
                local _TeamChest = _G.TeamChest

                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', _TeamChest)
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.ChestBypass then
                game.Players.LocalPlayer:FindFirstChild('Character')

                if game.Players.LocalPlayer.Character then
                    local _CrewBBG = game.Players.LocalPlayer.Character:FindFirstChild('CrewBBG', true)

                    if _CrewBBG then
                        _CrewBBG:Destroy()
                    end
                    if game.Players.LocalPlayer.Character:FindFirstChild('Humanoid') then
                        local v557 = game.Workspace:FindFirstChild('Chest4') or game.Workspace:FindFirstChild('Chest3') or (game.Workspace:FindFirstChild('Chest2') or game.Workspace:FindFirstChild('Chest1'))

                        if v557 then
                            game.Players.LocalPlayer.Character:PivotTo(v557:GetPivot())
                            firesignal(v557.Touched, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        elseif _G.TeleSafe == true and (game.Players.LocalPlayer.Backpack:FindFirstChild('Fist of Darkness') or game.Players.LocalPlayer.Character:FindFirstChild('Fist of Darkness') or (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice"))) then
                            _G.ChestBypass = false

                            break
                        end
                    end
                end
            end
        end
    end)
    v176:AddToggle({
        Name = 'Auto Farm Chest [ Tween ]',
        Default = false,
        Callback = function(p558)
            _G.AutoFarmChest = p558

            StopTween(_G.AutoFarmChest)
        end,
    })

    _G.MagnitudeAdd = 0

    spawn(function()
        while true do
            if not wait() then
                return
            end
            if _G.AutoFarmChest then
                local v559, v560, v561 = pairs(game:GetService('Workspace'):GetChildren())

                while true do
                    local v562

                    v561, v562 = v559(v560, v561)

                    if v561 == nil then
                        break
                    end
                    if v562.Name:find('Chest') and (game:GetService('Workspace'):FindFirstChild(v562.Name) and (v562.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000 + _G.MagnitudeAdd) then
                        while true do
                            wait()

                            if game:GetService('Workspace'):FindFirstChild(v562.Name) then
                                topos(v562.CFrame)

                                if (v562.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                    EquipWeapon(_G.SelectWeapon)
                                    UnEquipWeapon(_G.SelectWeapon)
                                end
                            end
                            if _G.AutoFarmChest == false or not v562.Parent then
                                topos(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame)

                                _G.MagnitudeAdd = _G.MagnitudeAdd + 1500

                                break
                            end
                        end
                    end
                end
            end
        end
    end)
    v176:AddToggle({
        Name = 'Teleport To Safe If Have Item',
        Default = false,
        Callback = function(p563)
            _G.TeleSafe = p563

            StopTween(_G.TeleSafe)
        end,
    })
    spawn(function()
        while wait() do
            if _G.TeleSafe and (game.Players.LocalPlayer.Backpack:FindFirstChild('Fist of Darkness') or game.Players.LocalPlayer.Character:FindFirstChild('Fist of Darkness') or (game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice"))) then
                _G.ChestBypass = false
                _G.AutoFarmChest = false

                if World3 then
                    topos(CFrame.new(-12489.4893, 336.895721, -7446.056153))
                elseif World2 then
                    topos(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Rip_Indra ~',
    })

    local _Rip_IndraStatus = v176:AddParagraph('Rip_Indra Status')

    v176:AddToggle({
        Name = 'Auto Summon Rip_Indra',
        Default = false,
        Callback = function(p565)
            _G.AutoSpawnRip = p565

            StopTween(_G.AutoSpawnRip)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoSpawnRip then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('activateColor', 'Winter Sky')
                    wait(0.3)
                    topos(CFrame.new(-5420.16602, 1084.9657, -2666.8208))
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-5420.16602, 1084.9657, -2666.8208)).Magnitude > 3 then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-5414.41357, 309.865753, -2212.45776)).Magnitude > 3 then
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-4971.47559, 331.565765, -3720.02954)).Magnitude <= 3 then
                            wait(1)
                            EquipWeapon("God's Chalice")
                            topos(game:GetService('Workspace').Map['Boat Castle'].Summoner.Detection.CFrame)
                        end
                    else
                        wait(1)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('activateColor', 'Snow White')
                        wait(0.3)
                        topos(CFrame.new(-4971.47559, 331.565765, -3720.02954))
                    end
                else
                    wait(1)
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('activateColor', 'Pure Red')
                    wait(0.3)
                    topos(CFrame.new(-5414.41357, 309.865753, -2212.45776))
                end
            end
        end
    end)
    v176:AddToggle({
        Name = 'Auto Kill Rip_Indra',
        Default = false,
        Callback = function(p566)
            _G.AutoKillRipIndra = p566

            StopTween(_G.AutoKillRipIndra)
        end,
    })
    CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781)
    spawn(function()
        while wait() do
            if _G.AutoKillRipIndra and World3 and (game:GetService('Workspace').Enemies:FindFirstChild('rip_indra True Form') or game:GetService('Workspace').Enemies:FindFirstChild('rip_indra')) then
                local v567, v568, v569 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                while true do
                    local v570

                    v569, v570 = v567(v568, v569)

                    if v569 == nil then
                        break
                    end
                    if v570.Name == ('rip_indra True Form' or v570.Name == 'rip_indra') and 0 < v570.Humanoid.Health and (v570:IsA('Model') and v570:FindFirstChild('Humanoid')) and v570:FindFirstChild('HumanoidRootPart') then
                        repeat
                            wait()
                            EquipWeapon(_G.SelectWeapon)
                            topos(v570.HumanoidRootPart.CFrame * Pos)
                        until _G.AutoKillRipIndra == false or v570.Humanoid.Health <= 0
                    end
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Darkbeard ~',
    })

    local _DarkbeardStatus = v176:AddParagraph('Darkbeard Status')

    v176:AddToggle({
        Name = 'Auto Summon Darkbeard',
        Default = false,
        Callback = function(p572)
            _G.AutoSpawnDark = p572

            StopTween(_G.AutoSpawnDark)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoSpawnDark and (game.Players.LocalPlayer.Backpack:FindFirstChild('Fist of Darkness') or game.Players.LocalPlayer.Character:FindFirstChild('Fist of Darkness')) then
                if GetDistance(game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection).Magnitude > 5 then
                    topos(game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection.CFrame)
                else
                    EquipWeapon('Fist of Darkness')
                    firetouchinterest(game.Players.LocalPlayer.Character['Fist of Darkness'].Handle, game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character['Fist of Darkness'].Handle, game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection, 1)
                    firetouchinterest(game.Players.LocalPlayer.Character['Fist of Darkness'].Handle, game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character['Fist of Darkness'].Handle, game:GetService('Workspace').Map.DarkbeardArena.Summoner.Detection, 1)
                end
            end
        end
    end)
    v176:AddToggle({
        Name = 'Auto Kill Darkbeard',
        Default = false,
        Callback = function(p573)
            _G.AutoKillDark = p573

            StopTween(_G.AutoKillDark)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoKillDark and World2 and game:GetService('Workspace').Enemies:FindFirstChild('Darkbeard') then
                local v574, v575, v576 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                while true do
                    local v577

                    v576, v577 = v574(v575, v576)

                    if v576 == nil then
                        break
                    end
                    if v577.Name == 'Darkbeard' and 0 < v577.Humanoid.Health and (v577:IsA('Model') and v577:FindFirstChild('Humanoid')) and v577:FindFirstChild('HumanoidRootPart') then
                        repeat
                            wait()
                            EquipWeapon(_G.SelectWeapon)
                            topos(v577.HumanoidRootPart.CFrame * Pos)
                        until _G.AutoKillDark == false or v577.Humanoid.Health <= 0
                    end
                end
            end
        end
    end)
    v176:AddSection({
        Name = '~ Observation Haki ~',
    })

    local _ObservationLevel = v176:AddParagraph('Observation Level')

    v176:AddToggle({
        Name = 'Auto Farm Observation [ Error ]',
        Default = false,
        Callback = function(p579)
            _G.AutoObservation = p579

            StopTween(_G.AutoObservation)
        end,
    })
    spawn(function()
        repeat
            if not wait() then
                return
            end
        until _G.AutoObservation

        wait()

        if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
            game:GetService('VirtualUser'):CaptureController()
            game:GetService('VirtualUser'):SetKeyDown('0x65')
            wait(2)
            game:GetService('VirtualUser'):SetKeyUp('0x65')
        end
        if game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') or not _G.AutoObservation then
        else
        end
    end)
    v176:AddToggle({
        Name = 'Auto Farm Observation [ Hop ]',
        Default = false,
        Callback = function(p580)
            _G.AutoObservation_Hop = p580
        end,
    })
    spawn(function()
        while true do
            repeat
                if not wait() then
                    return
                end
            until _G.AutoObservation

            if game:GetService('Players').LocalPlayer.VisionRadius.Value < 5000 then
                break
            end

            u394:MakeNotification({
                Name = 'Tinh Linh Hub',
                Content = 'You Have Max Points',
                Image = 'rbxassetid://16730867128',
                Time = 5,
            })
            wait(2)
        end

        if not World2 then
        end
        if not game:GetService('Workspace').Enemies:FindFirstChild('Lava Pirate [Lv. 1200]') then
        end
        if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
        end

        wait()

        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Lava Pirate').HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

        if _G.AutoObservation ~= false and game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
        end
        if World1 then
            if game:GetService('Workspace').Enemies:FindFirstChild('Galley Captain') then
                if game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    repeat
                        wait()

                        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Galley Captain').HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)
                    until _G.AutoObservation == false or not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel')
                else
                    wait()

                    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Galley Captain').HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

                    wait(1)

                    if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') and _G.AutoObservation_Hop == true then
                        game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService('Players').LocalPlayer)
                    end
                    if _G.AutoObservation ~= false and not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    end
                end
            else
                topos(CFrame.new(5533.29785, 88.1079102, 4852.3916))
            end
        elseif World3 then
            if game:GetService('Workspace').Enemies:FindFirstChild('Giant Islander') then
                if game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    wait()

                    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Giant Islander').HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

                    if _G.AutoObservation ~= false and game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    end
                else
                    wait()

                    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Giant Islander').HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

                    wait(1)

                    if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') and _G.AutoObservation_Hop == true then
                        game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService('Players').LocalPlayer)
                    end
                    if _G.AutoObservation ~= false and not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    end
                end
            else
                topos(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
            end
        end

        wait()

        game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Enemies:FindFirstChild('Lava Pirate').HumanoidRootPart.CFrame * CFrame.new(0, 50, 0) + wait(1)

        if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') and _G.AutoObservation_Hop == true then
            game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService('Players').LocalPlayer)
        end
        if _G.AutoObservation == false or game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
        else
        end

        topos(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
    end)
    v176:AddToggle({
        Name = 'Auto Upgrade Observation Haki V2',
        Default = false,
        Callback = function(p581)
            _G.AutoObservationv2 = p581

            StopTween(_G.AutoObservationv2)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoObservationv2 then
                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen') ~= 3 then
                    _G.AutoMusketeerHat = true
                else
                    _G.AutoMusketeerHat = false

                    if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Banana') and game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Apple') and game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Pineapple') then
                        repeat
                            topos(CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625))
                            wait()
                        until not _G.AutoObservationv2 or (game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-12444.78515625, 332.40396118164, -7673.1806640625)).Magnitude <= 10

                        wait(0.5)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen')
                    elseif game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Fruit Bowl') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Fruit Bowl') then
                        repeat
                            topos(CFrame.new(-10920.125, 624.20275878906, -10266.995117188))
                            wait()
                        until not _G.AutoObservationv2 or (game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-10920.125, 624.20275878906, -10266.995117188)).Magnitude <= 10

                        wait(0.5)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('KenTalk2', 'Start')
                        wait(1)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('KenTalk2', 'Buy')
                    else
                        local v582, v583, v584 = pairs(game:GetService('Workspace'):GetDescendants())

                        while true do
                            local v585

                            v584, v585 = v582(v583, v584)

                            if v584 == nil then
                                break
                            end
                            if v585.Name == 'Apple' or v585.Name == 'Banana' or v585.Name == 'Pineapple' then
                                v585.Handle.CFrame = game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)

                                wait()
                                firetouchinterest(game:GetService('Players').LocalPlayer.Character.HumanoidRootPart, v585.Handle, 0)
                                wait()
                            end
                        end
                    end
                end
            end
        end
    end)
    v177:AddSection({
        Name = '~ Legendary Sword ~',
    })

    local _LegendarySwordDealer = v177:AddParagraph('Legendary Sword Dealer')

    v177:AddToggle({
        Name = 'Auto Buy Legendary Sword',
        Default = false,
        Callback = function(p587)
            _G.AutoBuyLegendarySword = p587
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyLegendarySword then
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
    v177:AddToggle({
        Name = 'Auto Buy True Triple Katana',
        Default = false,
        Callback = function(p588)
            _G.AutoTrueTriplKatana = p588
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoTrueTriplKatana then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('MysteriousMan', '2')
            end
        end
    end)
    v177:AddSection({
        Name = '~ Haki Colors ~',
    })

    local _HakiDealer = v177:AddParagraph('Haki Dealer')

    v177:AddToggle({
        Name = 'Auto Buy All Haki Colors',
        Default = false,
        Callback = function(p590)
            _G.Auto_Buy_Enchancement = p590
        end,
    })
    v177:AddToggle({
        Name = 'Auto Buy Legendary Haki Colors',
        Default = false,
        Callback = function(p591)
            _G.Auto_Buy_Haki_Legends = p591
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_Buy_Enchancement then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '2')
            elseif _G.Auto_Buy_Haki_Legends then
                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '1') ~= 'Snow White' then
                    if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '1') ~= 'Winter Sky' then
                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '1') == 'Pure Red' then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '2')
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '2')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ColorsDealer', '2')
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Rainbow Haki',
        Default = false,
        Callback = function(p592)
            _G.Auto_Rainbow_Haki = p592

            StopTween(_G.Auto_Rainbow_Haki)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_Rainbow_Haki and World3 then
                if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                    if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= true or not string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Stone') then
                        if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= true or not string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Island Empress') then
                            if string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Kilo Admiral') then
                                if game:GetService('Workspace').Enemies:FindFirstChild('Kilo Admiral') then
                                    local v593, v594, v595 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v596

                                        v595, v596 = v593(v594, v595)

                                        if v595 == nil then
                                            break
                                        end
                                        if v596.Name == 'Kilo Admiral' then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                topos(v596.HumanoidRootPart.CFrame * Pos)

                                                v596.HumanoidRootPart.CFrame = OldCFrameRainbow
                                            until _G.Auto_Rainbow_Haki == false or v596.Humanoid.Health <= 0 or not v596.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        end
                                    end
                                else
                                    topos(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, 0, -0.143904909, 0, 1.00000012, 0, 0.143904924, 0, -0.989591479))
                                end
                            elseif string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Captain Elephant') then
                                if game:GetService('Workspace').Enemies:FindFirstChild('Captain Elephant') then
                                    local v597, v598, v599 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v600

                                        v599, v600 = v597(v598, v599)

                                        if v599 == nil then
                                            break
                                        end
                                        if v600.Name == 'Captain Elephant' then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                topos(v600.HumanoidRootPart.CFrame * Pos)
                                            until _G.Auto_Rainbow_Haki == false or v600.Humanoid.Health <= 0 or not v600.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        end
                                    end
                                else
                                    topos(CFrame.new(-13485.0283, 331.709259, -8012.4873, 0.714521289, 7.98849911e-8, 0.69961375, -1.02065748e-7, 1, -9.943830649999999e-9, -0.69961375, -6.430152410000001e-8, 0.714521289))
                                end
                            elseif string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Beautiful Pirate') then
                                if game:GetService('Workspace').Enemies:FindFirstChild('Beautiful Pirate') then
                                    local v601, v602, v603 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v604

                                        v603, v604 = v601(v602, v603)

                                        if v603 == nil then
                                            break
                                        end
                                        if v604.Name == 'Beautiful Pirate' then
                                            repeat
                                                wait()
                                                EquipWeapon(_G.SelectWeapon)
                                                topos(v604.HumanoidRootPart.CFrame * Pos)
                                            until _G.Auto_Rainbow_Haki == false or v604.Humanoid.Health <= 0 or not v604.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                        end
                                    end
                                else
                                    topos(CFrame.new(5312.3598632813, 20.141201019287, -10.158538818359))
                                end
                            else
                                topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))

                                if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                                    wait(1.5)
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('HornedMan', 'Bet')
                                end
                            end
                        elseif game:GetService('Workspace').Enemies:FindFirstChild('Island Empress') then
                            local v605, v606, v607 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v608

                                v607, v608 = v605(v606, v607)

                                if v607 == nil then
                                    break
                                end
                                if v608.Name == 'Island Empress' then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v608.HumanoidRootPart.CFrame * Pos)
                                    until _G.Auto_Rainbow_Haki == false or v608.Humanoid.Health <= 0 or not v608.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            topos(CFrame.new(5713.98877, 601.922974, 202.751251, -0.101080291, 0, -0.994878292, 0, 1, 0, 0.994878292, 0, -0.101080291))
                        end
                    elseif game:GetService('Workspace').Enemies:FindFirstChild('Stone') then
                        local v609, v610, v611 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v612

                            v611, v612 = v609(v610, v611)

                            if v611 == nil then
                                break
                            end
                            if v612.Name == 'Stone' then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v612.HumanoidRootPart.CFrame * Pos)
                                until _G.Auto_Rainbow_Haki == false or v612.Humanoid.Health <= 0 or not v612.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                            end
                        end
                    else
                        topos(CFrame.new(-1086.11621, 38.8425903, 6768.71436, 0.0231462717, -0.592676699, 0.805107772, 0.0000203251839, 0.805323839, 0.592835128, -0.999732077, -0.0137055516, 0.0186523199))
                    end
                else
                    topos(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))

                    if (Vector3.new(-11892.0703125, 930.57672119141, -8760.1591796875) - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('HornedMan', 'Bet')
                    end
                end
            end
        end
    end)
    v177:AddSection({
        Name = '~ Cursed Dual Katana ~',
    })

    local _EliteProgress = v177:AddParagraph('Elite Progress')

    v177:AddToggle({
        Name = 'Auto Get Yama',
        Default = false,
        Callback = function(p614)
            _G.AutoYama = p614

            if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter', 'Progress') < 30 then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('AbandonQuest')
            end

            StopTween(_G.AutoYama)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoYama and game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter', 'Progress') < 30 then
                if game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter')
                elseif string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Diablo') or string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Deandre') or string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Urban') then
                    if game:GetService('Workspace').Enemies:FindFirstChild('Diablo') or game:GetService('Workspace').Enemies:FindFirstChild('Deandre') or game:GetService('Workspace').Enemies:FindFirstChild('Urban') then
                        local v615, v616, v617 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v618

                            v617, v618 = v615(v616, v617)

                            if v617 == nil then
                                break
                            end
                            if (v618.Name == 'Diablo' or v618.Name == 'Deandre' or v618.Name == 'Urban') and (v618:FindFirstChild('Humanoid') and v618:FindFirstChild('HumanoidRootPart') and v618.Humanoid.Health > 0) then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v618.HumanoidRootPart.CFrame * Pos)
                                until not _G.AutoYama or v618.Humanoid.Health <= 0 or not v618.Parent
                            end
                        end
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Diablo') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Diablo').HumanoidRootPart.CFrame * Pos)
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Deandre') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Deandre').HumanoidRootPart.CFrame * Pos)
                    elseif game:GetService('ReplicatedStorage'):FindFirstChild('Urban') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Urban').HumanoidRootPart.CFrame * Pos)
                    end
                end
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.AutoYama and game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter', 'Progress') >= 30 then
                repeat
                    wait()
                    fireclickdetector(game:GetService('Workspace').Map.Waterfall.SealedKatana.Handle.ClickDetector)
                until game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Yama') or not _G.AutoYama
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Holy Torch',
        Default = false,
        Callback = function(p619)
            _G.AutoHolyTorch = p619

            StopTween(_G.AutoHolyTorch)
        end,
    })

    function CheckTool(p620)
        lol = {
            game.Players.LocalPlayer.Character,
            game.Players.LocalPlayer.Backpack,
        }

        local v621, v622, v623 = pairs(lol)

        while true do
            local v624

            v623, v624 = v621(v622, v623)

            if v623 == nil then
                break
            end
            if v624:FindFirstChild(p620) then
                return v624:FindFirstChild(p620)
            end
        end
    end
    function CheckTorchTushita()
        local v625 = not game:GetService('Workspace').Map.Turtle.QuestTorches.Torch1.Particles.Main.Enabled and '1' or (not game:GetService('Workspace').Map.Turtle.QuestTorches.Torch2.Particles.Main.Enabled and '2' or (not game:GetService('Workspace').Map.Turtle.QuestTorches.Torch3.Particles.Main.Enabled and '3' or (not game:GetService('Workspace').Map.Turtle.QuestTorches.Torch4.Particles.Main.Enabled and '4' or (not game:GetService('Workspace').Map.Turtle.QuestTorches.Torch5.Particles.Main.Enabled and '5' or nil))))
        local v626 = next
        local v627, v628 = game:GetService('Workspace').Map.Turtle.QuestTorches:GetChildren()

        while true do
            local v629

            v628, v629 = v626(v627, v628)

            if v628 == nil then
                break
            end
            if v629:IsA('MeshPart') and string.find(v629.Name, v625) and not v629.Particles.Main.Enabled then
                return v629
            end
        end
    end

    spawn(function()
        while wait() do
            if _G.AutoHolyTorch and CheckMob('rip_indra True Form') then
                if CheckTool('Holy Torch') then
                    EquipWeapon('Holy Torch')

                    if CheckTorchTushita() then
                        topos(CheckTorchTushita().CFrame)
                    end
                else
                    topos(game:GetService('Workspace').Map.Waterfall.SecretRoom.Room.Door.Door.Hitbox.CFrame)
                    wait(1)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Tushita',
        Default = false,
        Callback = function(p630)
            _G.Autotushita = p630

            StopTween(_G.Autotushita)
        end,
    })

    local u631 = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)

    spawn(function()
        while wait() do
            if _G.Autotushita and World3 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Longma') then
                    local v632, v633, v634 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v635

                        v634, v635 = v632(v633, v634)

                        if v634 == nil then
                            break
                        end
                        if v635.Name == 'Longma' and v635:FindFirstChild('Humanoid') and (v635:FindFirstChild('HumanoidRootPart') and 0 < v635.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v635.HumanoidRootPart.CFrame * Pos)
                            until not (_G.Autotushita and v635.Parent) or v635.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u631)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddSection({
        Name = '~ Weapon ~',
    })
    v177:AddToggle({
        Name = 'Auto Get Saber',
        Default = false,
        Callback = function(p636)
            _G.Auto_Saber = p636

            StopTween(_G.Auto_Saber)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_Saber and World1 and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                if game:GetService('Workspace').Map.Jungle.Final.Part.Transparency ~= 0 then
                    if game:GetService('Workspace').Enemies:FindFirstChild('Saber Expert') or game:GetService('ReplicatedStorage'):FindFirstChild('Saber Expert') then
                        local v637, v638, v639 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v640

                            v639, v640 = v637(v638, v639)

                            if v639 == nil then
                                break
                            end
                            if v640:FindFirstChild('Humanoid') and v640:FindFirstChild('HumanoidRootPart') and (v640.Humanoid.Health > 0 and v640.Name == 'Saber Expert') then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v640.HumanoidRootPart.CFrame * Pos)
                                until v640.Humanoid.Health <= 0 or not _G.Auto_Saber

                                if v640.Humanoid.Health <= 0 then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'PlaceRelic')
                                end
                            end
                        end
                    else
                        topos(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-9, 0.481375456, 2.53851997e-8, 1, -5.79995607e-8, -0.481375456, 6.30572643e-8, 0.876514494))
                        UnEquipWeapon(_G.SelectWeapon)
                    end
                elseif game:GetService('Workspace').Map.Jungle.QuestPlates.Door.Transparency ~= 0 then
                    if game:GetService('Workspace').Map.Desert.Burn.Part.Transparency ~= 0 then
                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan') == 0 then
                            if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') ~= nil then
                                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') ~= 0 then
                                    if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon') == 1 then
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'RichSon')
                                        wait(0.5)
                                        EquipWeapon('Relic')
                                        wait(0.5)
                                        topos(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-9, 0.481375456, 2.53851997e-8, 1, -5.79995607e-8, -0.481375456, 6.30572643e-8, 0.876514494))
                                    end
                                elseif game:GetService('Workspace').Enemies:FindFirstChild('Mob Leader') or game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader') then
                                    topos(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))

                                    local v641, v642, v643 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                    while true do
                                        local v644

                                        v643, v644 = v641(v642, v643)

                                        if v643 == nil then
                                            break
                                        end
                                        if v644:FindFirstChild('Humanoid') and v644:FindFirstChild('HumanoidRootPart') and v644.Humanoid.Health > 0 then
                                            if v644.Name == 'Mob Leader' and game:GetService('Workspace').Enemies:FindFirstChild('Mob Leader') then
                                                repeat
                                                    wait()
                                                    EquipWeapon(_G.SelectWeapon)
                                                    topos(v644.HumanoidRootPart.CFrame * Pos)
                                                until v644.Humanoid.Health <= 0 or not _G.Auto_Saber
                                            end
                                            if game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader') then
                                                topos(game:GetService('ReplicatedStorage'):FindFirstChild('Mob Leader').HumanoidRootPart.CFrame * Pos)
                                            end
                                        end
                                    end
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
                            wait()
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ProQuestProgress', 'SickMan')
                        end
                    elseif game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Torch') or game.Players.LocalPlayer.Character:FindFirstChild('Torch') then
                        EquipWeapon('Torch')
                        topos(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-9, 0.761243105, -5.70652914e-10, 1, 1.20584542e-9, -0.761243105, 3.4754488199999996e-10, -0.648466587))
                    else
                        topos(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.0000342372805, -0.258850515, 0.965917408))
                    end
                elseif (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, -0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, -4.39869794e-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 250 then
                    topos(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-9, -0.928667724, 3.97099491e-8, 1, 1.91679348e-8, 0.928667724, -4.39869794e-8, 0.37091279))
                else
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate1.Button.CFrame

                    wait(1)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate2.Button.CFrame

                    wait(1)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate3.Button.CFrame

                    wait(1)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate4.Button.CFrame

                    wait(1)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService('Workspace').Map.Jungle.QuestPlates.Plate5.Button.CFrame
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Waden Sword',
        Default = false,
        Callback = function(p645)
            _G.Autowaden = p645

            StopTween(_G.Autowaden)
        end,
    })

    local u646 = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976563)

    spawn(function()
        while wait() do
            if _G.Autowaden and World1 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Chief Warden') then
                    local v647, v648, v649 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v650

                        v649, v650 = v647(v648, v649)

                        if v649 == nil then
                            break
                        end
                        if v650.Name == 'Chief Warden' and v650:FindFirstChild('Humanoid') and (v650:FindFirstChild('HumanoidRootPart') and 0 < v650.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v650.HumanoidRootPart.CFrame * Pos)
                            until not (_G.Autowaden and v650.Parent) or v650.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u646)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Pole V1',
        Default = false,
        Callback = function(p651)
            _G.Autopole = p651

            StopTween(_G.Autopole)
        end,
    })

    local u652 = CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625)

    spawn(function()
        while wait() do
            if _G.Autopole and World1 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Thunder God') then
                    local v653, v654, v655 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v656

                        v655, v656 = v653(v654, v655)

                        if v655 == nil then
                            break
                        end
                        if v656.Name == 'Thunder God' and v656:FindFirstChild('Humanoid') and (v656:FindFirstChild('HumanoidRootPart') and 0 < v656.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v656.HumanoidRootPart.CFrame * Pos)
                            until not (_G.Autopole and v656.Parent) or v656.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u652)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Shark Saw',
        Default = false,
        Callback = function(p657)
            _G.Autosaw = p657

            StopTween(_G.Autosaw)
        end,
    })

    local u658 = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094)

    spawn(function()
        while wait() do
            if _G.Autosaw and World1 then
                if game:GetService('Workspace').Enemies:FindFirstChild('The Saw') then
                    local v659, v660, v661 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v662

                        v661, v662 = v659(v660, v661)

                        if v661 == nil then
                            break
                        end
                        if v662.Name == 'The Saw' and v662:FindFirstChild('Humanoid') and (v662:FindFirstChild('HumanoidRootPart') and 0 < v662.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v662.HumanoidRootPart.CFrame * Pos)
                            until not (_G.Autosaw and v662.Parent) or v662.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u658)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Rengoku',
        Default = false,
        Callback = function(p663)
            _G.AutoRengoku = p663

            StopTween(_G.AutoRengoku)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoRengoku and World2 then
                if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Hidden Key') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Hidden Key') then
                    EquipWeapon('Hidden Key')
                    topos(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                elseif game:GetService('Workspace').Enemies:FindFirstChild('Snow Lurker') or game:GetService('Workspace').Enemies:FindFirstChild('Arctic Warrior') or game:GetService('Workspace').Enemies:FindFirstChild('Awakened Ice Admiral') then
                    local v664, v665, v666 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v667

                        v666, v667 = v664(v665, v666)

                        if v666 == nil then
                            break
                        end
                        if (v667.Name == 'Snow Lurker' or v667.Name == 'Arctic Warrior' or v667.Name == 'Awakened Ice Admiral') and v667.Humanoid.Health > 0 then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v667.HumanoidRootPart.CFrame * Pos)

                                PosNear = v667.HumanoidRootPart.CFrame
                                MagnetNear = true
                            until game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Hidden Key') or _G.AutoRengoku == false or (not v667.Parent or v667.Humanoid.Health <= 0)

                            MagnetNear = false
                        end
                    end
                else
                    StartRengokuMagnet = false

                    topos(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Dragon Trident',
        Default = false,
        Callback = function(p668)
            _G.Auto_Dragon_Trident = p668

            StopTween(_G.Auto_Dragon_Trident)
        end,
    })

    local u669 = CFrame.new(-3914.830322265625, 123.29389190673828, -11516.8642578125)

    spawn(function()
        while wait() do
            if _G.Auto_Dragon_Trident and World2 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Tide Keeper') then
                    local v670, v671, v672 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v673

                        v672, v673 = v670(v671, v672)

                        if v672 == nil then
                            break
                        end
                        if v673.Name == 'Tide Keeper' and v673:FindFirstChild('Humanoid') and (v673:FindFirstChild('HumanoidRootPart') and 0 < v673.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v673.HumanoidRootPart.CFrame * Pos)
                            until not (_G.Auto_Dragon_Trident and v673.Parent) or v673.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u669)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Carvander',
        Default = false,
        Callback = function(p674)
            _G.AutoCarvender = p674

            StopTween(_G.AutoCarvender)
        end,
    })

    local u675 = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875)

    spawn(function()
        while wait() do
            if _G.AutoCarvender and World3 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Beautiful Pirate') then
                    local v676, v677, v678 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v679

                        v678, v679 = v676(v677, v678)

                        if v678 == nil then
                            break
                        end
                        if v679.Name == 'Beautiful Pirate' and v679:FindFirstChild('Humanoid') and (v679:FindFirstChild('HumanoidRootPart') and 0 < v679.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v679.HumanoidRootPart.CFrame * Pos)
                            until not (_G.AutoCarvender and v679.Parent) or v679.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u675)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Buddy Sword',
        Default = false,
        Callback = function(p680)
            _G.AutoBudySword = p680

            StopTween(_G.AutoBudySword)
        end,
    })

    local u681 = CFrame.new(-731.2034301757813, 381.5658874511719, -11198.4951171875)

    spawn(function()
        while wait() do
            if _G.AutoBudySword and World3 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Cake Queen') then
                    local v682, v683, v684 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v685

                        v684, v685 = v682(v683, v684)

                        if v684 == nil then
                            break
                        end
                        if v685.Name == 'Cake Queen' and v685:FindFirstChild('Humanoid') and (v685:FindFirstChild('HumanoidRootPart') and 0 < v685.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v685.HumanoidRootPart.CFrame * Pos)
                            until not (_G.AutoBudySword and v685.Parent) or v685.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u681)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Twin Hook',
        Default = false,
        Callback = function(p686)
            _G.AutoTwinHook = p686

            StopTween(_G.AutoTwinHook)
        end,
    })

    local u687 = CFrame.new(-13348.0654296875, 405.8904113769531, -8570.62890625)

    spawn(function()
        while wait() do
            if _G.AutoTwinHook and World3 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Captain Elephant') then
                    local v688, v689, v690 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v691

                        v690, v691 = v688(v689, v690)

                        if v690 == nil then
                            break
                        end
                        if v691.Name == 'Captain Elephant' and v691:FindFirstChild('Humanoid') and (v691:FindFirstChild('HumanoidRootPart') and 0 < v691.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v691.HumanoidRootPart.CFrame * Pos)
                            until not (_G.AutoTwinHook and v691.Parent) or v691.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u687)
                    UnEquipWeapon(_G.SelectWeapon)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Hallow Scythe',
        Default = false,
        Callback = function(p692)
            _G.Auto_Soul_Reaper = p692

            StopTween(_G.Auto_Soul_Reaper)
        end,
    })
    v177:AddToggle({
        Name = 'Auto Get Serpent Bow',
        Default = false,
        Callback = function(p693)
            _G.AutoSerpentBow = p693

            StopTween(_G.AutoSerpentBow)
        end,
    })

    local u694 = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)

    spawn(function()
        while wait() do
            if _G.AutoSerpentBow and World3 then
                if game:GetService('Workspace').Enemies:FindFirstChild('Island Empress') then
                    local v695, v696, v697 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v698

                        v697, v698 = v695(v696, v697)

                        if v697 == nil then
                            break
                        end
                        if v698.Name == 'Island Empress' and v698:FindFirstChild('Humanoid') and (v698:FindFirstChild('HumanoidRootPart') and 0 < v698.Humanoid.Health) then
                            repeat
                                wait()
                                EquipWeapon(_G.SelectWeapon)
                                topos(v698.HumanoidRootPart.CFrame * Pos)
                            until not (_G.AutoSerpentBow and v698.Parent) or v698.Humanoid.Health <= 0
                        end
                    end
                else
                    topos(u694)
                    UnEquipWeapon(_G.SelectWeapon)

                    if game:GetService('ReplicatedStorage'):FindFirstChild('Island Empress') then
                        topos(game:GetService('ReplicatedStorage'):FindFirstChild('Island Empress').HumanoidRootPart.CFrame * Pos)
                    end
                end
            end
        end
    end)
    v177:AddSection({
        Name = '~ Other ~',
    })
    v177:AddToggle({
        Name = 'Auto Evo Race V2',
        Default = false,
        Callback = function(p699)
            _G.Auto_EvoRace = p699

            StopTween(_G.Auto_EvoRace)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Auto_EvoRace then
                pcall(function()
                    if not game:GetService('Players').LocalPlayer.Data.Race:FindFirstChild('Evolved') then
                        if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Alchemist', '1') ~= 0 then
                            if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Alchemist', '1') ~= 1 then
                                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Alchemist', '1') == 2 then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Alchemist', '3')
                                end
                            else
                                pcall(function()
                                    if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Flower 1') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Flower 1') then
                                        if game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Flower 2') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Flower 2') then
                                            if not (game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Flower 3') or game:GetService('Players').LocalPlayer.Character:FindFirstChild('Flower 3')) then
                                                if game:GetService('Workspace').Enemies:FindFirstChild('Zombie') then
                                                    local v700, v701, v702 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                                                    while true do
                                                        local v703

                                                        v702, v703 = v700(v701, v702)

                                                        if v702 == nil then
                                                            break
                                                        end
                                                        if v703.Name == 'Zombie' then
                                                            repeat
                                                                wait()
                                                                EquipWeapon(_G.SelectWeapon)
                                                                topos(v703.HumanoidRootPart.CFrame * Pos)

                                                                PosMonEvo = v703.HumanoidRootPart.CFrame
                                                                StartEvoMagnet = true
                                                            until game:GetService('Players').LocalPlayer.Backpack:FindFirstChild('Flower 3') or not v703.Parent or (v703.Humanoid.Health <= 0 or _G.Auto_EvoRace == false)

                                                            StartEvoMagnet = false
                                                        end
                                                    end
                                                else
                                                    StartEvoMagnet = false

                                                    topos(CFrame.new(-5685.9233398438, 48.480125427246, -853.23724365234))
                                                end
                                            end
                                        else
                                            topos(game:GetService('Workspace').Flower2.CFrame)
                                        end
                                    else
                                        topos(game:GetService('Workspace').Flower1.CFrame)
                                    end
                                end)
                            end
                        else
                            topos(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 6.39014104e-8, -0.68292886, 3.5996322399999996e-8, 1, 5.50667032e-8, 0.68292886, 1.56424669e-8, -0.730484903))

                            if (Vector3.new(-2779.83521, 72.9661407, -3574.02002) - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                                wait(1.3)
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Alchemist', '2')
                            end
                        end
                    end
                end)
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Get Musketeer Hat',
        Default = false,
        Callback = function(p704)
            _G.AutoMusketeerHat = p704

            StopTween(_G.AutoMusketeerHat)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoMusketeerHat then
                if game:GetService('Players').LocalPlayer.Data.Level.Value < 1800 or game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress').KilledBandits ~= false then
                    if game:GetService('Players').LocalPlayer.Data.Level.Value < 1800 or game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress').KilledBoss ~= false then
                        if game:GetService('Players').LocalPlayer.Data.Level.Value >= 1800 and game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen') == 2 then
                            topos(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
                        end
                    elseif game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Captain Elephant') and game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Captain Elephant') then
                            local v705, v706, v707 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v708

                                v707, v708 = v705(v706, v707)

                                if v707 == nil then
                                    break
                                end
                                if v708.Name == 'Captain Elephant' then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v708.HumanoidRootPart.CFrame * Pos)

                                        v708.HumanoidRootPart.CFrame = OldCFrameElephant
                                    until _G.AutoMusketeerHat == false or v708.Humanoid.Health <= 0 or not v708.Parent or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            topos(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
                        end
                    else
                        topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

                        if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.5)
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('CitizenQuestProgress', 'Citizen')
                        end
                    end
                elseif string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, 'Forest Pirate') and string.find(game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, '50') and game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    if game:GetService('Workspace').Enemies:FindFirstChild('Forest Pirate') then
                        local v709, v710, v711 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v712

                            v711, v712 = v709(v710, v711)

                            if v711 == nil then
                                break
                            end
                            if v712.Name == 'Forest Pirate' then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v712.HumanoidRootPart.CFrame * Pos)

                                    MusketeerHatMon = v712.HumanoidRootPart.CFrame
                                    StartMagnetMusketeerhat = true
                                until _G.AutoMusketeerHat == false or not v712.Parent or v712.Humanoid.Health <= 0 or game:GetService('Players').LocalPlayer.PlayerGui.Main.Quest.Visible == false

                                StartMagnetMusketeerhat = false
                            end
                        end
                    else
                        StartMagnetMusketeerhat = false

                        topos(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
                    end
                else
                    topos(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

                    if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('StartQuest', 'CitizenQuest', 1)
                    end
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Quest Second Sea',
        Default = false,
        Callback = function(p713)
            _G.AutoSecondSea = p713

            StopTween(_G.AutoSecondSea)
        end,
    })
    spawn(function()
        while true do
            if not wait() then
                return
            end
            if _G.AutoSecondSea and (game:GetService('Players').LocalPlayer.Data.Level.Value >= 700 and World1) then
                if game:GetService('Workspace').Map.Ice.Door.CanCollide ~= false or game:GetService('Workspace').Map.Ice.Door.Transparency ~= 1 then
                    if game:GetService('Workspace').Map.Ice.Door.CanCollide == false and game:GetService('Workspace').Map.Ice.Door.Transparency == 1 then
                        if game:GetService('Workspace').Enemies:FindFirstChild('Ice Admiral') then
                            local v714, v715, v716 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v717

                                v716, v717 = v714(v715, v716)

                                if v716 == nil then
                                    break
                                end
                                if v717.Name == 'Ice Admiral' then
                                    if not v717.Humanoid.Health > 0 then
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelDressrosa')
                                    elseif v717:FindFirstChild('Humanoid') and v717:FindFirstChild('HumanoidRootPart') and v717.Humanoid.Health > 0 then
                                        OldCFrameSecond = v717.HumanoidRootPart.CFrame

                                        wait()
                                        EquipWeapon(_G.SelectWeapon)

                                        v717.HumanoidRootPart.CanCollide = false
                                        v717.Humanoid.WalkSpeed = 0
                                        v717.Head.CanCollide = false
                                        v717.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v717.HumanoidRootPart.CFrame = OldCFrameSecond

                                        topos(v717.HumanoidRootPart.CFrame * Pos)
                                        sethiddenproperty(game:GetService('Players').LocalPlayer, 'SimulationRadius', math.huge)

                                        if _G.AutoSecondSea and v717.Parent and v717.Humanoid.Health > 0 then
                                        end
                                    end
                                end
                            end
                        elseif game:GetService('ReplicatedStorage'):FindFirstChild('Ice Admiral') then
                            topos(game:GetService('ReplicatedStorage'):FindFirstChild('Ice Admiral').HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                        end
                    end
                else
                    local v718 = CFrame.new(4849.29883, 5.65138149, 719.611877)

                    repeat
                        topos(v718)
                        wait()
                    until (v718.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.AutoSecondSea == false

                    wait(1.1)
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('DressrosaQuestProgress', 'Detective')
                    wait(0.5)
                    EquipWeapon('Key')

                    repeat
                        topos(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        wait()
                    until (Vector3.new(1347.7124, 37.3751602, -1325.6488) - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.AutoSecondSea == false

                    wait(0.5)
                end
            end
        end
    end)
    v177:AddToggle({
        Name = 'Auto Quest Third Sea',
        Default = false,
        Callback = function(p719)
            _G.AutoThirdSea = p719

            StopTween(_G.AutoThirdSea)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoThirdSea and (game:GetService('Players').LocalPlayer.Data.Level.Value >= 1500 and World2) then
                _G.AutoFarm = false

                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ZQuestProgress', 'General') == 0 then
                    topos(CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016))

                    if (CFrame.new(-1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        wait(1.5)
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ZQuestProgress', 'Begin')
                    end

                    wait(1.8)

                    if game:GetService('Workspace').Enemies:FindFirstChild('rip_indra') then
                        local v720, v721, v722 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v723

                            v722, v723 = v720(v721, v722)

                            if v722 == nil then
                                break
                            end
                            if v723.Name == 'rip_indra' then
                                OldCFrameThird = v723.HumanoidRootPart.CFrame

                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v723.HumanoidRootPart.CFrame * Pos)

                                    v723.HumanoidRootPart.CFrame = OldCFrameThird
                                    v723.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    v723.HumanoidRootPart.CanCollide = false
                                    v723.Humanoid.WalkSpeed = 0

                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelZou')
                                    sethiddenproperty(game:GetService('Players').LocalPlayer, 'SimulationRadius', math.huge)
                                until _G.AutoThirdSea == false or (v723.Humanoid.Health <= 0 or not v723.Parent)
                            end
                        end
                    elseif not game:GetService('Workspace').Enemies:FindFirstChild('rip_indra') and (CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                        topos(CFrame.new(-26880.93359375, 22.848554611206, 473.18951416016))
                    end
                end
            end
        end
    end)
    v178:AddSection({
        Name = '~ Player ~',
    })
    v178:AddButton({
        Name = 'Join Pirates Team',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Pirates')
        end,
    })
    v178:AddButton({
        Name = 'Join Marines Team',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetTeam', 'Marines')
        end,
    })
    v178:AddToggle({
        Name = 'Auto Set Spawn Point',
        Default = false,
        Callback = function(p724)
            _G.Pos_Spawn = p724
        end,
    })
    spawn(function()
        while wait() do
            if _G.Pos_Spawn and game:GetService('Players').LocalPlayer.Character.Humanoid.Health > 0 then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('SetSpawnPoint')
            end
        end
    end)
    v178:AddToggle({
        Name = 'Auto Ken',
        Default = true,
        Callback = function(p725)
            _G.AutoKen = p725
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoKen == true then
                game:GetService('ReplicatedStorage').Remotes.CommE:FireServer('Ken', true)
            end
        end
    end)
    v178:AddSection({
        Name = '~ Turn On ~',
    })
    v178:AddToggle({
        Name = 'Auto Turn On Buso Haki',
        Default = true,
        Callback = function(p726)
            _G.AutoHaki = p726
        end,
    })

    function AutoHaki()
        if not game:GetService('Players').LocalPlayer.Character:FindFirstChild('HasBuso') then
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Buso')
        end
    end

    spawn(function()
        while wait() do
            if _G.AutoHaki then
                AutoHaki()
            end
        end
    end)
    v178:AddToggle({
        Name = 'Auto Turn On Race V3',
        Default = false,
        Callback = function(p727)
            _G.OnV3 = p727
        end,
    })
    v178:AddToggle({
        Name = 'Auto Turn On Race V4',
        Default = false,
        Callback = function(p728)
            _G.OnV4 = p728
        end,
    })
    spawn(function()
        while wait() do
            if _G.OnV3 then
                game:GetService('VirtualUser'):SetKeyDown('0x74')
                game:GetService('VirtualUser'):SetKeyUp('0x74')
            elseif _G.OnV4 then
                game:GetService('VirtualUser'):SetKeyDown('0x59')
                game:GetService('VirtualUser'):SetKeyUp('0x59')
            end
        end
    end)
    v178:AddToggle({
        Name = 'Auto Turn On Observation',
        Default = false,
        Callback = function(p729)
            _G.OnHaki = p729
        end,
    })
    spawn(function()
        while wait() do
            if _G.OnHaki then
                wait()

                if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    game:GetService('VirtualUser'):SetKeyDown('0x65')
                    wait(0.1)
                    game:GetService('VirtualUser'):SetKeyUp('0x65')
                end
                if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') and _G.OnHaki then
                    break
                end
            end
        end
    end)
    v178:AddSection({
        Name = '~ Haki State ~',
    })
    v178:AddDropdown({
        Name = 'Select Haki State',
        Default = '',
        Options = {
            'State 0',
            'State 1',
            'State 2',
            'State 3',
            'State 4',
            'State 5',
        },
        Callback = function(p730)
            _G.SelectStateHaki = p730
        end,
    })
    v178:AddButton({
        Name = 'Set State Haki',
        Callback = function()
            if _G.SelectStateHaki ~= 'State 0' then
                if _G.SelectStateHaki ~= 'State 1' then
                    if _G.SelectStateHaki ~= 'State 2' then
                        if _G.SelectStateHaki ~= 'State 3' then
                            if _G.SelectStateHaki ~= 'State 4 ' then
                                if _G.SelectStateHaki == 'State 5' then
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 5)
                                end
                            else
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 4)
                            end
                        else
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 3)
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 2)
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 1)
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('ChangeBusoStage', 0)
            end
        end,
    })
    v178:AddSection({
        Name = '~ Open Tab ~',
    })
    v178:AddButton({
        Name = 'Open Devil Fruit Shop [ Normal ]',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('GetFruits')

            game:GetService('Players').LocalPlayer.PlayerGui.Main.FruitShop.Visible = true
        end,
    })
    v178:AddButton({
        Name = 'Open Devil Fruit Shop [ Mirage ]',
        Callback = function()
            StartDialog('FruitShop2')
        end,
    })

    function StartDialog(p731)
        local _ReplicatedStorage = game:GetService('ReplicatedStorage')
        local v733 = require(_ReplicatedStorage.DialogueController)
        local v734 = require(_ReplicatedStorage.DialoguesList)
        local v735, v736, v737 = pairs(v734)

        while true do
            local v738

            v737, v738 = v735(v736, v737)

            if v737 == nil then
                break
            end
            if tostring(v737) == p731 then
                v733:Start(v738)
            end
        end
    end

    v178:AddButton({
        Name = 'Open Title',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                'getTitles',
            }))

            game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
        end,
    })
    v178:AddButton({
        Name = 'Open Haki Colors',
        Callback = function()
            game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
        end,
    })
    v178:AddButton({
        Name = 'Open Awakening',
        Callback = function()
            game:GetService('Players').LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
        end,
    })
    v178:AddButton({
        Name = 'Open Inventory [ Old ]',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventoryWeapons')
            wait()

            game:GetService('Players').LocalPlayer.PlayerGui.Main.Inventory.Visible = true
        end,
    })
    v178:AddSection({
        Name = '~ Abilities ~',
    })
    v178:AddToggle({
        Name = 'Soru No CD',
        Default = false,
        Callback = function(p739)
            getgenv().InfSoru = p739
        end,
    })
    spawn(function()
        while wait() do
            if getgenv().InfSoru and game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart') ~= nil then
                local v740 = next
                local v741, v742 = getgc()

                while true do
                    local v743

                    v742, v743 = v740(v741, v742)

                    if v742 == nil then
                        break
                    end
                    if game:GetService('Players').LocalPlayer.Character.Soru and typeof(v743) == 'function' and getfenv(v743).script == game:GetService('Players').LocalPlayer.Character.Soru then
                        local v744 = next
                        local v745, v746 = getupvalues(v743)

                        while true do
                            local v747

                            v746, v747 = v744(v745, v746)

                            if v746 == nil then
                                break
                            end
                            if typeof(v747) == 'table' then
                                repeat
                                    wait()

                                    v747.LastUse = 0
                                until not getgenv().InfSoru or game:GetService('Players').LocalPlayer.Character.Humanoid.Health <= 0
                            end
                        end
                    end
                end
            end
        end
    end)
    v178:AddToggle({
        Name = 'Walk On Water',
        Default = false,
        Callback = function(p748)
            _G.WalkWater = p748
        end,
    })
    spawn(function()
        while wait() do
            pcall(function()
                if _G.WalkWater then
                    game:GetService('Workspace').Map['WaterBase-Plane'].Size = Vector3.new(1000, 112, 1000)
                else
                    game:GetService('Workspace').Map['WaterBase-Plane'].Size = Vector3.new(1000, 80, 1000)
                end
            end)
        end
    end)
    v178:AddToggle({
        Name = 'No Clip',
        Default = false,
        Callback = function(p749)
            _G.LOf = p749
        end,
    })
    spawn(function()
        game:GetService('RunService').Stepped:Connect(function()
            if _G.LOf then
                local v750, v751, v752 = pairs(game.Players.LocalPlayer.Character:GetDescendants())

                while true do
                    local v753

                    v752, v753 = v750(v751, v752)

                    if v752 == nil then
                        break
                    end
                    if v753:IsA('BasePart') then
                        v753.CanCollide = false
                    end
                end
            end
        end)
    end)
    v178:AddSection({
        Name = '~ Misc ~',
    })
    v178:AddButton({
        Name = 'Show Item',
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/HuyLocDz/ShowItem/main/ShowItem.lua'))()
        end,
    })
    v179:AddSection({
        Name = '~ Player ~',
    })

    local _PlayerInServer = v179:AddParagraph('Player In Server')
    local v755, v756, v757 = pairs(game:GetService('Players'):GetChildren())
    local u758 = {}

    while true do
        local v759

        v757, v759 = v755(v756, v757)

        if v757 == nil then
            break
        end

        table.insert(u758, v759.Name)
    end

    local u761 = v179:AddDropdown({
        Name = 'Select Player',
        Default = '',
        Options = u758,
        Callback = function(p760)
            SelectPly = p760
        end,
    })

    v179:AddButton({
        Name = 'Refresh Player List',
        Callback = function()
            u761:Refresh(u758, true)

            local v762, v763, v764 = pairs(game:GetService('Players'):GetChildren())
            local v765 = {}

            while true do
                local v766

                v764, v766 = v762(v763, v764)

                if v764 == nil then
                    break
                end

                table.insert(Playerlist, v766.Name)
            end

            u761:Refresh(v765)
        end,
    })
    v179:AddToggle({
        Name = 'Teleport To Player',
        Default = false,
        Callback = function(p767)
            _G.Teleport = p767

            StopTween(_G.Teleport)
        end,
    })
    spawn(function()
        while wait() do
            if _G.Teleport and game.Players:FindFirstChild(SelectPly) then
                topos(game.Players[SelectPly].Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))
            end
        end
    end)
    v179:AddToggle({
        Name = 'Spectate Player',
        Default = false,
        Callback = function(p768)
            _G.SpectatePlys = p768
        end,
    })
    spawn(function()
        while wait() do
            if _G.SpectatePlys and game.Players:FindFirstChild(SelectPly) then
                repeat
                    wait()

                    game:GetService('Workspace').Camera.CameraSubject = game:GetService('Players'):FindFirstChild(SelectPly).Character.Humanoid
                until _G.SpectatePlys == false

                game:GetService('Workspace').Camera.CameraSubject = game:GetService('Players').LocalPlayer.Character.Humanoid
            end
        end
    end)
    v179:AddSection({
        Name = '~ Aimbot & PvP ~',
    })
    v179:AddToggle({
        Name = 'Aimbot Skill To Player Nearest',
        Default = false,
        Callback = function(p769)
            _G.AimSkillNearest = p769
        end,
    })
    spawn(function()
        while wait() do
            pcall(function()
                local _huge3 = math.huge
                local v771, v772, v773 = pairs(game:GetService('Players'):GetPlayers())

                while true do
                    local v774

                    v773, v774 = v771(v772, v773)

                    if v773 == nil then
                        break
                    end
                    if v774.Name ~= game.Players.LocalPlayer.Name then
                        local v775 = v774:DistanceFromCharacter(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)

                        if v775 < _huge3 then
                            TargetPlayerAim = v774.Name
                            _huge3 = v775
                        end
                    end
                end
            end)
        end
    end)
    spawn(function()
        pcall(function()
            game:GetService('RunService').RenderStepped:connect(function()
                if _G.AimSkillNearest and TargetPlayerAim ~= nil and (game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool') and game.Players.LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool').Name]:FindFirstChild('MousePos')) then
                    local v776 = {
                        game:GetService('Players'):FindFirstChild(TargetPlayerAim).Character.HumanoidRootPart.Position,
                    }

                    game:GetService('Players').LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass('Tool').Name].RemoteEvent:FireServer(unpack(v776))
                end
            end)
        end)
    end)
    v179:AddToggle({
        Name = 'Enabled PvP',
        Default = false,
        Callback = function(p777)
            _G.EnabledPvP = p777
        end,
    })
    spawn(function()
        while wait() do
            if _G.EnabledPvP and game:GetService('Players').LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EnablePvp')
            end
        end
    end)
    v179:AddSection({
        Name = '~ Bounty / Honor [ Soon ] ~',
    })

    local _YourBountyHonor = v179:AddParagraph('Your Bounty / Honor')

    v180:AddSection({
        Name = '~ Settings Farm Sea Event~',
    })
    v180:AddDropdown({
        Name = 'Select Boats',
        Default = 'Guardian',
        Options = {
            'Guardian',
            'Grand Brigade',
            'Sloop',
            'Lantern',
            'Brigade',
            'Beast Hunter',
        },
        Callback = function(p779)
            _G.Boat = p779

            if _G.Boat ~= 'Grand Brigade' then
                if _G.Boat ~= 'Sloop' then
                    if _G.Boat ~= 'Lantern' then
                        if _G.Boat ~= 'Brigade' then
                            if _G.Boat ~= 'Beast Hunter' then
                                if _G.Boat == 'Guardian' then
                                    SelectedBoat = 'Guardian'
                                end
                            else
                                SelectedBoat = 'BeastHunter'
                            end
                        else
                            SelectedBoat = 'PirateBrigade'
                        end
                    else
                        SelectedBoat = 'Lantern'
                    end
                else
                    SelectedBoat = 'PirateSloop'
                end
            else
                SelectedBoat = 'PirateGrandBrigade'
            end
        end,
    })

    if World3 then
        v180:AddDropdown({
            Name = 'Select Zone Sea',
            Default = 'Zone 5 [ Crazy ]',
            Options = {
                'Zone 0 [ None ]',
                'Zone 1 [ Low ]',
                'Zone 2 [ Medium ]',
                'Zone 3 [ High ]',
                'Zone 4 [ Extreme ]',
                'Zone 5 [ Crazy ]',
                'Zone 6 [ ??? ]',
                'Zone \u{221e} [ ??? ]',
            },
            Callback = function(p780)
                _G.SelectedZone = p780

                if _G.SelectedZone ~= 'Zone 0 [ None ]' then
                    if _G.SelectedZone ~= 'Zone 1 [ Low ]' then
                        if _G.SelectedZone ~= 'Zone 2 [ Medium ]' then
                            if _G.SelectedZone ~= 'Zone 3 [ High ]' then
                                if _G.SelectedZone ~= 'Zone 4 [ Extreme ]' then
                                    if _G.SelectedZone ~= 'Zone 5 [ Crazy ]' then
                                        if _G.SelectedZone ~= 'Zone 6 [ ??? ]' then
                                            if _G.SelectedZone == 'Zone \u{221e} [ ??? ]' then
                                                CFrameSelectedZone = CFrame.new(-148073.359, 8.99999523, 7721.05078, -0.0825930536, -1.54416148e-6, 0.996583343, -0.000018696026, 1, -3.91858095e-13, -0.996583343, -0.0000186321486, -0.0825930536)
                                            end
                                        else
                                            CFrameSelectedZone = CFrame.new(-44541.7617, 30.0003204, -1244.8584, -0.0844199061, -0.00553312758, 0.9964149, -0.0654025897, 0.997858942, 2.02319411e-10, -0.99428153, -0.0651681125, -0.0846010372)
                                        end
                                    else
                                        CFrameSelectedZone = CFrame.new(-38887.5547, 30.0004578, -2162.99023, -0.188895494, -0.00704088295, 0.981971979, -0.0372481011, 0.999306023, -1.39882339e-9, -0.981290519, -0.0365765914, -0.189026669)
                                    end
                                else
                                    CFrameSelectedZone = CFrame.new(-34054.6875, 30.2187767, -2560.12012, 0.0935864747, -0.00122954219, 0.995610416, 0.0624034069, 0.998040259, -0.00463332096, -0.993653536, 0.062563099, 0.0934797972)
                                end
                            else
                                CFrameSelectedZone = CFrame.new(-31171.957, 30.0001011, -2256.93774, 0.37637493, 0.0150483791, 0.926345229, -0.0399504974, 0.999201655, 2.70896673e-11, -0.925605655, -0.0370079502, 0.376675636)
                            end
                        else
                            CFrameSelectedZone = CFrame.new(-26779.5215, 30.0005474, -822.858032, 0.307457417, 0.019647358, 0.951358974, -0.0637726262, 0.997964442, -4.15334017e-10, -0.949422479, -0.0606706589, 0.308084518)
                        end
                    else
                        CFrameSelectedZone = CFrame.new(-21998.375, 30.0006084, -682.309143, 0.120013528, 0.00690158736, 0.99274826, -0.0574118942, 0.998350561, -2.3650920099999997e-10, -0.991110802, -0.0569955558, 0.120211802)
                    end
                else
                    CFrameSelectedZone = CFrame.new(-19118.041015625, 24.44040298461914, 858.4185791015625)
                end
            end,
        })
    end
    if World2 then
        v180:AddDropdown({
            Name = 'Select Zone Sea',
            Default = 'Sea [ Normal ]',
            Options = {
                'Sea [ Normal ]',
            },
            Callback = function(p781)
                _G.SelectedZone = p781

                if _G.SelectedZone == 'Sea [ Normal ]' then
                    CFrameSelectedZone = CFrame.new(210.99585, 12.9606171, 4158.57959, -0.917689145, 7.58163254e-11, -0.39729917, 1.20923558e-11, 1, 1.62898153e-10, 0.39729917, 1.44685583e-10, -0.917689145)
                end
            end,
        })
    end
    if World1 then
        v180:AddDropdown({
            Name = 'Select Zone Sea',
            Default = 'No Zone Sea',
            Options = {
                'No Zone Sea',
            },
            Callback = function() end,
        })
    end

    v180:AddToggle({
        Name = 'Auto Sail Boats',
        Default = false,
        Callback = function(p782)
            _G.SailBoat = p782

            StopTween(_G.SailBoat)
        end,
    })

    function CheckBoat()
        local v783, v784, v785 = pairs(game:GetService('Workspace').Boats:GetChildren())

        while true do
            local v786

            v785, v786 = v783(v784, v785)

            if v785 == nil then
                break
            end
            if v786.Name == SelectedBoat then
                local v787, v788, v789 = pairs(v786:GetChildren())

                while true do
                    local v790

                    v789, v790 = v787(v788, v789)

                    if v789 == nil then
                        break
                    end
                    if v790.Name == 'MyBoatEsp' then
                        return v786
                    end
                end
            end
        end

        return false
    end
    function CheckShark()
        local v791, v792, v793 = pairs(game:GetService('Workspace').Enemies:GetChildren())

        while true do
            local v794

            v793, v794 = v791(v792, v793)

            if v793 == nil then
                break
            end
            if v794.Name == 'Shark' and v794:FindFirstChild('Humanoid') and (v794:FindFirstChild('HumanoidRootPart') and 0 < v794.Humanoid.Health) and (v794.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
                return true
            end
        end

        return false
    end
    function CheckPiranha()
        local v795, v796, v797 = pairs(game:GetService('Workspace').Enemies:GetChildren())

        while true do
            local v798

            v797, v798 = v795(v796, v797)

            if v797 == nil then
                break
            end
            if v798.Name == 'Piranha' and v798:FindFirstChild('Humanoid') and (v798:FindFirstChild('HumanoidRootPart') and 0 < v798.Humanoid.Health) and (v798.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
                return true
            end
        end

        return false
    end
    function CheckFishCrewMember()
        local v799, v800, v801 = pairs(game:GetService('Workspace').Enemies:GetChildren())

        while true do
            local v802

            v801, v802 = v799(v800, v801)

            if v801 == nil then
                break
            end
            if v802.Name == 'Fish Crew Member' and v802:FindFirstChild('Humanoid') and (v802:FindFirstChild('HumanoidRootPart') and 0 < v802.Humanoid.Health) and (v802.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
                return true
            end
        end

        return false
    end
    function CheckTerrorshark()
        local v803, v804, v805 = pairs(game:GetService('Workspace').Enemies:GetChildren())

        while true do
            local v806

            v805, v806 = v803(v804, v805)

            if v805 == nil then
                break
            end
            if v806.Name == 'Terrorshark' and v806:FindFirstChild('Humanoid') and (v806:FindFirstChild('HumanoidRootPart') and 0 < v806.Humanoid.Health) and (v806.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 300 then
                return true
            end
        end

        return false
    end
    function CheckSeaBeast()
        if game:GetService('Workspace'):FindFirstChild('SeaBeasts') then
            local v807, v808, v809 = pairs(game:GetService('Workspace').SeaBeasts:GetChildren())

            while true do
                local v810

                v809, v810 = v807(v808, v809)

                if v809 == nil then
                    break
                end
                if v810:FindFirstChild('Humanoid') or v810:FindFirstChild('HumanoidRootPart') or v810.Humanoid.Health < 0 then
                    return true
                end
            end
        end

        return false
    end
    function TeleportSeabeast(p811)
        if (Vector3.new(0, p811:FindFirstChild('HumanoidRootPart').Position.Y, 0) - Vector3.new(0, game:GetService('Workspace').Map['WaterBase-Plane'].Position.Y, 0)).Magnitude > 300 then
            topos(CFrame.new(p811.HumanoidRootPart.Position.X, game:GetService('Workspace').Map['WaterBase-Plane'].Position.Y + 200, p811.HumanoidRootPart.Position.Z))
        else
            topos(p811.HumanoidRootPart.CFrame * PosSea)
        end
    end
    function AddEsp(p812, p813)
        local _BillboardGui6 = Instance.new('BillboardGui')
        local _TextLabel6 = Instance.new('TextLabel')

        _BillboardGui6.Parent = p813
        _BillboardGui6.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        _BillboardGui6.Active = true
        _BillboardGui6.Name = p812
        _BillboardGui6.AlwaysOnTop = true
        _BillboardGui6.LightInfluence = 1
        _BillboardGui6.Size = UDim2.new(0, 200, 0, 50)
        _BillboardGui6.StudsOffset = Vector3.new(0, 2.5, 0)
        _TextLabel6.Parent = _BillboardGui6
        _TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        _TextLabel6.BackgroundTransparency = 1
        _TextLabel6.Size = UDim2.new(1, 0, 1, 0)
        _TextLabel6.Font = Enum.Font.GothamBold
        _TextLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
        _TextLabel6.TextSize = 13
        _TextLabel6.Text = ''
    end

    local u816 = {}

    function TPB(p817, p818)
        Tween = game:service('TweenService'):Create(p818, TweenInfo.new((p818.CFrame.Position - p817.Position).Magnitude / _G.SpeedBoat, Enum.EasingStyle.Linear), {CFrame = p817})

        if (p818.CFrame.Position - p817.Position).Magnitude > 25 then
            Tween:Play()
        else
            Tween:Cancel()
        end

        function u816.Stop(_)
            Tween:Cancel()
        end

        return u816
    end

    spawn(function()
        while wait() do
            if _G.SailBoat then
                pcall(function()
                    if CheckBoat() then
                        if CheckBoat() then
                            local v819, v820, v821 = pairs(game:GetService('Workspace').Boats:GetChildren())

                            while true do
                                local v822

                                v821, v822 = v819(v820, v821)

                                if v821 == nil then
                                    break
                                end
                                if v822.Name == SelectedBoat and v822:FindFirstChild('MyBoatEsp') then
                                    if game.Players.LocalPlayer.Character:WaitForChild('Humanoid').Sit ~= false then
                                        repeat
                                            wait()
                                            TPB(CFrameSelectedZone, v822.VehicleSeat)
                                        until CheckShark() and _G.AutoKillShark or CheckTerrorshark() and _G.AutoTerrorshark or (CheckPiranha() and _G.AutoKillPiranha or CheckFishCrewMember() and _G.AutoKillFishCrew) or (game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') and _G.RelzFishBoat or game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') and _G.RelzPirateBrigade or (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') and _G.RelzPirateGrandBrigade or CheckSeaBeast() and _G.AutoSeaBest)) or (game.Players.LocalPlayer.Character:WaitForChild('Humanoid').Sit == false or _G.SailBoat == false)

                                        if u816 then
                                            u816:Stop()
                                        end

                                        game:GetService('VirtualInputManager'):SendKeyEvent(true, 32, false, game)
                                        wait()
                                        game:GetService('VirtualInputManager'):SendKeyEvent(false, 32, false, game)
                                    elseif CheckShark() and _G.AutoKillShark or CheckTerrorshark() and _G.AutoTerrorshark or (CheckPiranha() and _G.AutoKillPiranha or CheckFishCrewMember() and _G.AutoKillFishCrew) or (game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') and _G.RelzFishBoat or game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') and _G.RelzPirateBrigade or (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') and _G.RelzPirateGrandBrigade or CheckSeaBeast() and _G.AutoSeaBest)) then
                                        if stoppos then
                                            stoppos:Stop()
                                        end
                                    else
                                        topos(v822.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                                    end
                                end
                            end
                        end
                    else
                        if World3 then
                            BuyBoatCFrame = CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781)
                        elseif World2 then
                            BuyBoatCFrame = CFrame.new(90.4880542755127, 10.311711311340332, 2950.69287109375)
                        end

                        buyb = topos(BuyBoatCFrame)

                        if (BuyBoatCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            if buyb then
                                buyb:Stop()
                            end

                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyBoat', SelectedBoat)

                            local v823, v824, v825 = pairs(game:GetService('Workspace').Boats:GetChildren())

                            while true do
                                local v826

                                v825, v826 = v823(v824, v825)

                                if v825 == nil then
                                    break
                                end
                                if v826.Name == SelectedBoat and (v826.VehicleSeat.CFrame.Position - game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
                                    AddEsp('MyBoatEsp', v826)
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.SailBoat then
                if CheckShark() and _G.AutoKillShark or CheckTerrorshark() and _G.AutoTerrorshark or (CheckPiranha() and _G.AutoKillPiranha or CheckFishCrewMember() and _G.AutoKillFishCrew) or (game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') and _G.RelzFishBoat or game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') and _G.RelzPirateBrigade or (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') and _G.RelzPirateGrandBrigade or CheckSeaBeast() and _G.AutoSeaBest)) then
                    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    end
                elseif _G.DogeRoughSea == true and (game:GetService('Workspace')._WorldOrigin.Locations:FindFirstChild('Rough Sea') and checkboat()) then
                    if game.Players.LocalPlayer.Character.Humanoid.Sit then
                        game.Players.LocalPlayer.Character.Humanoid.Sit = false
                    end
                    if (checkboat().VehicleSeat.Position - Vector3.new(-16207.501953125, 9.0863618850708, 475.1490783691406)).Magnitude > 100 then
                        checkboat().VehicleSeat.CFrame = CFrame.new(-28464.876953125, 12.553319931030273, 6896.8076171875)
                    end
                    if game:GetService('Players').LocalPlayer.Character.Humanoid.Sit then
                        _G.Clip = false
                    else
                        _G.Clip = true

                        topos(checkboat().VehicleSeat.CFrame)
                    end
                end
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.SailBoat then
                pcall(function()
                    if CheckFishCrewMember() and _G.AutoKillFishCrew then
                        local v827, v828, v829 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                        while true do
                            local v830

                            v829, v830 = v827(v828, v829)

                            if v829 == nil then
                                break
                            end
                            if game:GetService('Workspace').Enemies:FindFirstChild('Fish Crew Member') then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    topos(v830.HumanoidRootPart.CFrame * Pos)

                                    MagnetNear = true
                                    SeaSkill = false
                                until not (_G.AutoKillFishCrew and v830.Parent) or v830.Humanoid.Health <= 0

                                MagnetNear = false
                            end
                        end
                    end
                    if not (game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') and _G.RelzFishBoat) then
                    end

                    local v831, v832, v833 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    while true do
                        local v834

                        v833, v834 = v831(v832, v833)

                        if v833 == nil then
                        end
                        if game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') then
                            repeat
                                if true then
                                    wait()

                                    local _CFrame = v834.Engine.CFrame

                                    if (_CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                                        SeaSkill = false
                                    else
                                        SeaSkill = true
                                    end
                                end

                                topos(_CFrame)

                                Skillaimbot = true
                                AimSkill = v834.Engine.CFrame * CFrame.new(0, -15, 0)
                                AimBotSkillPosition = AimSkill.Position
                            until not v834.Parent or v834.Health < 0 or not (game:GetService('Workspace').Enemies:FindFirstChild('FishBoat') and v834:FindFirstChild('Engine')) or not _G.RelzFishBoat

                            Skillaimbot = false
                            SeaSkill = false
                        end
                    end

                    if not (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') and _G.RelzPirateGrandBrigade) then
                    end

                    local v836, v837, v838 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    if not (game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') and _G.RelzPirateBrigade) then
                    end

                    local v839, v840, v841 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                    if not (CheckSeaBeast() and _G.AutoSeaBest) then
                        if CheckTerrorshark() and _G.AutoTerrorshark then
                            local v842, v843, v844 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v845

                                v844, v845 = v842(v843, v844)

                                if v844 == nil then
                                    break
                                end
                                if game:GetService('Workspace').Enemies:FindFirstChild('Terrorshark') then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v845.HumanoidRootPart.CFrame * PosCaMap)

                                        MagnetNear = true
                                        SeaSkill = false
                                    until not (_G.AutoTerrorshark and v845.Parent) or v845.Humanoid.Health <= 0

                                    MagnetNear = false
                                end
                            end
                        elseif CheckPiranha() and _G.AutoKillPiranha then
                            local v846, v847, v848 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v849

                                v848, v849 = v846(v847, v848)

                                if v848 == nil then
                                    break
                                end
                                if game:GetService('Workspace').Enemies:FindFirstChild('Piranha') then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v849.HumanoidRootPart.CFrame * Pos)

                                        MagnetNear = true
                                        SeaSkill = false
                                    until not (_G.AutoKillPiranha and v849.Parent) or v849.Humanoid.Health <= 0

                                    MagnetNear = false
                                end
                            end
                        elseif CheckShark() and _G.AutoKillShark then
                            local v850, v851, v852 = pairs(game:GetService('Workspace').Enemies:GetChildren())

                            while true do
                                local v853

                                v852, v853 = v850(v851, v852)

                                if v852 == nil then
                                    break
                                end
                                if game:GetService('Workspace').Enemies:FindFirstChild('Shark') then
                                    repeat
                                        wait()
                                        EquipWeapon(_G.SelectWeapon)
                                        topos(v853.HumanoidRootPart.CFrame * Pos)

                                        MagnetNear = true
                                        SeaSkill = false
                                    until not (_G.AutoKillShark and v853.Parent) or v853.Humanoid.Health <= 0

                                    MagnetNear = false
                                end
                            end
                        else
                            Skillaimbot = false
                            SeaSkill = false
                            MagnetNear = false
                        end

                        return
                    end
                    if not game:GetService('Workspace'):FindFirstChild('SeaBeasts') then
                    end

                    local v854, v855, v856 = pairs(game:GetService('Workspace').SeaBeasts:GetChildren())

                    if true then
                        wait()

                        local _CFrame2 = v858.Engine.CFrame

                        if (_CFrame2.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                            SeaSkill = false
                        else
                            SeaSkill = true
                        end
                    end

                    topos(_CFrame2)

                    Skillaimbot = true
                    AimSkill = v858.Engine.CFrame * CFrame.new(0, -15, 0)
                    AimBotSkillPosition = AimSkill.Position

                    if v858.Parent and v858.Health.Value >= 0 and (game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') and v858:FindFirstChild('Engine')) and _G.RelzPirateBrigade then
                    else
                    end

                    Skillaimbot = false
                    SeaSkill = false

                    local v858

                    v841, v858 = v839(v840, v841)

                    if v841 == nil then
                    end
                    if game:GetService('Workspace').Enemies:FindFirstChild('PirateBrigade') then
                    else
                    end

                    Skillaimbot = false
                    SeaSkill = false

                    local v859

                    v838, v859 = v836(v837, v838)

                    if v838 == nil then
                    end
                    if not game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') then
                    end
                    if true then
                        wait()

                        local _CFrame3 = v859.Engine.CFrame

                        if (_CFrame3.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 50 then
                            SeaSkill = false
                        else
                            SeaSkill = true
                        end
                    end

                    topos(_CFrame3)

                    Skillaimbot = true
                    AimSkill = v859.Engine.CFrame * CFrame.new(0, -15, 0)
                    AimBotSkillPosition = AimSkill.Position

                    if v859.Parent and v859.Health.Value >= 0 and (game:GetService('Workspace').Enemies:FindFirstChild('PirateGrandBrigade') and v859:FindFirstChild('Engine')) and _G.RelzPirateGrandBrigade then
                    else
                    end
                    if true then
                        wait()

                        CFrameSeaBeast = v861.HumanoidRootPart.CFrame * CFrame.new(0, 200, 0)

                        if (CFrameSeaBeast.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude > 200 then
                            SeaSkill = false
                        else
                            SeaSkill = true
                        end
                    end

                    Skillaimbot = true
                    AimBotSkillPosition = v861.HumanoidRootPart.CFrame.Position

                    spawn(TeleportSeabeast(v861), 1)

                    if _G.AutoSeaBest and CheckSeaBeast() ~= false and (v861:FindFirstChild('Humanoid') and v861:FindFirstChild('HumanoidRootPart')) and (v861.Humanoid.Health >= 0 and v861.Parent) then
                    else
                    end

                    Skillaimbot = false
                    SeaSkill = false

                    while true do
                        local v861

                        v856, v861 = v854(v855, v856)

                        if v856 == nil then
                        end
                        if CheckSeaBeast() then
                            break
                        end

                        Skillaimbot = false
                        SeaSkill = false
                    end
                end)
            end
        end
    end)
    v180:AddToggle({
        Name = 'Auto Dodge Rough Sea [ Test ]',
        Default = false,
        Callback = function(p862)
            _G.DogeRoughSea = p862
        end,
    })
    v180:AddToggle({
        Name = 'No Clip Rock',
        Default = false,
        Callback = function(p863)
            _G.NoClipRock = p863
        end,
    })
    spawn(function()
        while wait() do
            if _G.NoClipRock or _G.SailBoat then
                pcall(function()
                    if game.Players.LocalPlayer.Character.Humanoid.Sit ~= true then
                        if game.Players.LocalPlayer.Character.Humanoid.Sit == false then
                            local v864, v865, v866 = pairs(game.Workspace.Boats:GetDescendants())

                            while true do
                                local v867

                                v866, v867 = v864(v865, v866)

                                if v866 == nil then
                                    break
                                end
                                if v867:IsA('BasePart') and v867.CanCollide == false then
                                    v867.CanCollide = true
                                end
                            end

                            local v868, v869, v870 = pairs(game.Players.LocalPlayer.Character:GetDescendants())

                            while true do
                                local v871

                                v870, v871 = v868(v869, v870)

                                if v870 == nil then
                                    break
                                end
                                if v871:IsA('BasePart') and v871.CanCollide == false then
                                    v871.CanCollide = true
                                end
                            end
                        end
                    else
                        local v872, v873, v874 = pairs(game.Workspace.Boats:GetDescendants())

                        while true do
                            local v875

                            v874, v875 = v872(v873, v874)

                            if v874 == nil then
                                break
                            end
                            if v875:IsA('BasePart') and v875.CanCollide == true then
                                v875.CanCollide = false
                            end
                        end

                        local v876, v877, v878 = pairs(game.Players.LocalPlayer.Character:GetDescendants())

                        while true do
                            local v879

                            v878, v879 = v876(v877, v878)

                            if v878 == nil then
                                break
                            end
                            if v879:IsA('BasePart') and v879.CanCollide == true then
                                v879.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    v180:AddSlider({
        Name = 'Speed Boats',
        Min = 120,
        Max = 600,
        Default = 300,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '',
        Callback = function(p880)
            _G.SpeedBoat = p880
        end,
    })
    v180:AddSection({
        Name = '~ Use Weapon Skill ~',
    })
    v180:AddToggle({
        Name = 'Auto Spam Skill Devil Fruit',
        Default = false,
        Callback = function(p881)
            _G.UseSeaFruitSkill = p881
        end,
    })
    v180:AddToggle({
        Name = 'Auto Spam Skill Melee',
        Default = false,
        Callback = function(p882)
            _G.UseSeaMeleeSkill = p882
        end,
    })
    v180:AddToggle({
        Name = 'Auto Spam Skill Sword',
        Default = false,
        Callback = function(p883)
            _G.UseSeaSwordSkill = p883
        end,
    })
    v180:AddToggle({
        Name = 'Auto Spam Skill Gun',
        Default = false,
        Callback = function(p884)
            _G.UseSeaGunSkill = p884
        end,
    })
    v180:AddSection({
        Name = '~ Aimbot Skill To Ship & Sea Beast ~',
    })
    v180:AddLabel('Select Use Skill Devil Fruit')
    v180:AddToggle({
        Name = 'Use Skill Z',
        Default = false,
        Callback = function(p885)
            _G.SkillFruitZ = p885
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill X',
        Default = false,
        Callback = function(p886)
            _G.SkillFruitX = p886
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill C',
        Default = false,
        Callback = function(p887)
            _G.SkillFruitC = p887
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill V',
        Default = false,
        Callback = function(p888)
            _G.SkillFruitV = p888
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill F',
        Default = false,
        Callback = function(p889)
            _G.SkillFruitF = p889
        end,
    })
    v180:AddLabel('Select Use Skill Melee')
    v180:AddToggle({
        Name = 'Use Skill Z',
        Default = false,
        Callback = function(p890)
            _G.SkillMeleeZ = p890
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill X',
        Default = false,
        Callback = function(p891)
            _G.SkillMeleeX = p891
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill C',
        Default = false,
        Callback = function(p892)
            _G.SkillMeleeC = p892
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill V',
        Default = false,
        Callback = function(p893)
            _G.SkillMeleeV = p893
        end,
    })
    v180:AddLabel('Select Use Skill Sword')
    v180:AddToggle({
        Name = 'Use Skill Z',
        Default = false,
        Callback = function(p894)
            _G.SkillSwordZ = p894
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill X',
        Default = false,
        Callback = function(p895)
            _G.SkillSwordX = p895
        end,
    })
    v180:AddLabel('Select Use Skill Gun')
    v180:AddToggle({
        Name = 'Use Skill Z',
        Default = false,
        Callback = function(p896)
            _G.SkillGunZ = p896
        end,
    })
    v180:AddToggle({
        Name = 'Use Skill X',
        Default = false,
        Callback = function(p897)
            _G.SkillGunX = p897
        end,
    })
    v180:AddSection({
        Name = '~ Mobs Sea Event ~',
    })
    v180:AddToggle({
        Name = 'Auto Kill Shark',
        Default = false,
        Callback = function(p898)
            _G.AutoKillShark = p898

            StopTween(_G.AutoKillShark)
        end,
    })
    v180:AddToggle({
        Name = 'Auto Kill Piranha',
        Default = false,
        Callback = function(p899)
            _G.AutoKillPiranha = p899

            StopTween(_G.AutoKillPiranha)
        end,
    })
    v180:AddToggle({
        Name = 'Auto Kill Fish Crew Member',
        Default = false,
        Callback = function(p900)
            _G.AutoKillFishCrew = p900

            StopTween(_G.AutoKillFishCrew)
        end,
    })
    v180:AddToggle({
        Name = 'Auto Kill Ship',
        Default = false,
        Callback = function(p901)
            _G.RelzFishBoat = p901
            _G.RelzPirateBrigade = p901
            _G.RelzPirateGrandBrigade = p901

            StopTween(p901)

            if not _G.RelzFishBoat then
                SeaSkill = false
                Skillaimbot = false
            end
        end,
    })
    v180:AddToggle({
        Name = 'Auto Kill Terrorshark',
        Default = false,
        Callback = function(p902)
            _G.AutoTerrorshark = p902

            StopTween(_G.AutoTerrorshark)
        end,
    })
    v180:AddToggle({
        Name = 'Auto Kill Sea Beast',
        Default = false,
        Callback = function(p903)
            _G.AutoSeaBest = p903

            StopTween(_G.AutoSeaBest)

            if not _G.AutoSeaBest then
                SeaSkill = false
                Skillaimbot = false
            end
        end,
    })

    DoneSkillGun = false
    DoneSkillSword = false
    DoneSkillFruit = false
    DoneSkillMelee = false

    spawn(function()
        while wait() do
            if SeaSkill then
                if _G.UseSeaFruitSkill and DoneSkillFruit == false then
                    local v904, v905, v906 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                    while true do
                        local v907

                        v906, v907 = v904(v905, v906)

                        if v906 == nil then
                            break
                        end
                        if v907:IsA('Tool') and v907.ToolTip == 'Blox Fruit' then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v907)
                        end
                    end

                    if _G.SkillFruitZ then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                        wait(_G.HoldSKillFruitZ)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                    end
                    if _G.SkillFruitX then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                        wait(_G.HoldSKillFruitX)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                    end
                    if _G.SkillFruitC then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                        wait(_G.HoldSKillFruitC)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                    end
                    if _G.SkillFruitV then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                        wait(_G.HoldSKillFruitV)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                    end
                    if _G.SkillFruitF then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'F', false, game)
                        wait(_G.HoldSKillFruitF)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'F', false, game)
                    end

                    DoneSkillFruit = true
                end
                if _G.UseSeaMeleeSkill and DoneSkillMelee == false then
                    local v908, v909, v910 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                    while true do
                        local v911

                        v910, v911 = v908(v909, v910)

                        if v910 == nil then
                            break
                        end
                        if v911:IsA('Tool') and v911.ToolTip == 'Melee' then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v911)
                        end
                    end

                    if _G.SkillMeleeZ then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                        wait(_G.HoldSKillMeleeZ)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                    end
                    if _G.SkillMeleeX then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                        wait(_G.HoldSKillMeleeX)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                    end
                    if _G.SkillMeleeC then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                        wait(_G.HoldSKillMeleeC)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                    end
                    if _G.SkillMeleeV then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                        wait(_G.HoldSKillMeleeV)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                    end

                    DoneSkillMelee = true
                end
                if _G.UseSeaSwordSkill and DoneSkillSword == false then
                    local v912, v913, v914 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                    while true do
                        local v915

                        v914, v915 = v912(v913, v914)

                        if v914 == nil then
                            break
                        end
                        if v915:IsA('Tool') and v915.ToolTip == 'Sword' then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v915)
                        end
                    end

                    if _G.SkillSwordZ then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                        wait(_G.HoldSKillSwordX)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                    end
                    if _G.SkillSwordX then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                        wait(_G.HoldSKillSwordX)
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                    end

                    DoneSkillSword = true
                end
                if _G.UseSeaGunSkill and DoneSkillGun == false then
                    local v916, v917, v918 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                    while true do
                        local v919

                        v918, v919 = v916(v917, v918)

                        if v918 == nil then
                            break
                        end
                        if v919:IsA('Tool') and v919.ToolTip == 'Gun' then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v919)
                        end
                    end

                    if _G.SkillGunZ then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                        wait()
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                    end
                    if _G.SkillGunX then
                        game:service('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                        wait()
                        game:service('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                    end

                    DoneSkillGun = true
                end

                DoneSkillGun = false
                DoneSkillSword = false
                DoneSkillFruit = false
                DoneSkillMelee = false
            end
        end
    end)
    v180:AddSection({
        Name = '~ Kitsune Island ~',
    })

    local _KitsuneIsland = v180:AddParagraph('Kitsune Island')

    v180:AddToggle({
        Name = 'Teleport To Kitsune Island',
        Default = false,
        Callback = function(p921)
            _G.TeleportKitsune = p921

            StopTween(_G.TeleportKitsune)
        end,
    })
    spawn(function()
        while wait() do
            if _G.TeleportKitsune and game:GetService('Workspace').Map:FindFirstChild('KitsuneIsland') then
                topos(game.Workspace.Map.KitsuneIsland.ShrineActive.NeonShrinePart.CFrame * CFrame.new(0, 0, 10))
            end
        end
    end)
    v180:AddToggle({
        Name = 'Auto Collect Azure',
        Default = false,
        Callback = function(p922)
            _G.CollectAzure = p922

            StopTween(_G.CollectAzure)
        end,
    })
    spawn(function()
        while wait() do
            if _G.CollectAzure then
                pcall(function()
                    if game:GetService('Workspace'):FindFirstChild('AttachedAzureEmber') then
                        topos(game:GetService('Workspace'):WaitForChild('EmberTemplate'):FindFirstChild('Part').CFrame)
                    end
                end)
            end
        end
    end)
    v180:AddSlider({
        Name = 'Set Azure Ember',
        Min = 10,
        Max = 25,
        Default = 20,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '',
        Callback = function(p923)
            _G.SetToTradeAureEmber = p923
        end,
    })
    v180:AddToggle({
        Name = 'Auto Trade Azure Ember',
        Default = false,
        Callback = function(p924)
            _G.TradeAureEmber = p924
        end,
    })

    function GetCountMaterials(p925)
        local v926, v927, v928 = pairs(game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('getInventory'))

        while true do
            local v929

            v928, v929 = v926(v927, v928)

            if v928 == nil then
                break
            end
            if v929.Name == p925 then
                return v929.Count
            end
        end
    end

    spawn(function()
        while wait() do
            if _G.TradeAureEmber then
                pcall(function()
                    if GetCountMaterials('Azure Ember') >= _G.SetToTradeAureEmber then
                        game:GetService('ReplicatedStorage').Modules.Net:FindFirstChild('RF/KitsuneStatuePray'):InvokeServer()
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('KitsuneStatuePray')
                    end
                end)
            end
        end
    end)
    v181:AddSection({
        Name = '~ Templete Of Time ~',
    })

    local _YourRace = v181:AddParagraph('Your Race')

    v181:AddButton({
        Name = 'Teleport To Temple Of Time',
        Callback = function()
            Templeteleport()
        end,
    })
    v181:AddButton({
        Name = 'Pull Lever',
        Callback = function()
            PullLever()
            u394:MakeNotification({
                Name = 'Tinh Linh Hub',
                Content = 'Pull Lever Complete!',
                Image = 'rbxassetid://16730867128',
                Time = 5,
            })
        end,
    })

    function PullLever()
        CFrame.new(28576.4688, 14939.2832, 76.5164413, -1, 0, 0, 0, 0.707134247, -0.707079291, 0, -0.707079291, -0.707134247)

        local v931 = CFrame.new(28576.4688, 14935.9512, 75.469101, -1, -4.22219593e-8, 1.1313339599999999e-8, 0, -0.258819044, -0.965925813, 4.3711388300000005e-8, -0.965925813, 0.258819044)
        local v932 = 0.2

        if game:GetService('Workspace').Map['Temple of Time'].Lever.Lever.CFrame.Z > v931.Z + v932 or game:GetService('Workspace').Map['Temple of Time'].Lever.Lever.CFrame.Z < v931.Z - v932 then
            CheckAndTweenTemple()
            Tween(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734))
            wait(0.01)
            topos(game:GetService('Workspace').Map['Temple of Time'].Lever.Part.CFrame)

            local v933, v934, v935 = pairs(game:GetService('Workspace').Map['Temple of Time'].Lever:GetDescendants())

            while true do
                local v936

                v935, v936 = v933(v934, v935)

                if v935 == nil then
                    break
                end
                if v936.Name == 'ProximityPrompt' then
                    fireproximityprompt(v936)
                end
            end
        end
    end

    v181:AddButton({
        Name = 'Teleport To Clock',
        Callback = function()
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude <= 1000 then
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude < 1000 then
                    wait(0.1)
                    Tween(CFrame.new(29551.9941, 15069.002, -85.5179291))
                end
            else
                Templeteleport()
                wait(0.3)
                Tween(CFrame.new(29551.9941, 15069.002, -85.5179291))
            end
        end,
    })
    v181:AddButton({
        Name = 'Teleport To Anclient One',
        Callback = function()
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude <= 1000 then
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude < 1000 then
                    wait(0.1)
                    Tween(CFrame.new(28973.0879, 14889.9756, -120.298691))
                end
            else
                Templeteleport()
                wait(0.3)
                Tween(CFrame.new(28973.0879, 14889.9756, -120.298691))
            end
        end,
    })

    function RaceDoors()
        if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Fishman' then
            if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Human' then
                if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Cyborg' then
                    if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Skypiea' then
                        if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Ghoul' then
                            if game:GetService('Players').LocalPlayer.Data.Race.Value == 'Mink' then
                                Tween(CFrame.new(29020.66015625, 14889.4267578125, -379.2682800292969))
                            end
                        else
                            Tween(CFrame.new(28672.720703125, 14889.1279296875, 454.5961608886719))
                        end
                    else
                        Tween(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
                    end
                else
                    Tween(CFrame.new(28492.4140625, 14894.4267578125, -422.1100158691406))
                end
            else
                Tween(CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938))
            end
        else
            Tween(CFrame.new(28224.056640625, 14889.4267578125, -210.5872039794922))
        end
    end

    v181:AddButton({
        Name = 'Teleport To Race Doors',
        Callback = function()
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude <= 1000 then
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - u393.Position).Magnitude < 1000 then
                    wait(0.1)
                    RaceDoors()
                end
            else
                Templeteleport()
                wait(0.3)
                RaceDoors()
            end
        end,
    })
    v181:AddSection({
        Name = '~ Mirage Island ~',
    })

    local _MirageIsland = v181:AddParagraph('Mirage Island')

    v181:AddToggle({
        Name = 'Teleport To Mirage Island',
        Default = false,
        Callback = function(p938)
            _G.AutoMysticIsland = p938

            StopTween(_G.AutoMysticIsland)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoMysticIsland then
                local v939, v940, v941 = pairs(game.Workspace.Map.MysticIsland:GetChildren())

                while true do
                    local v942

                    v941, v942 = v939(v940, v941)

                    if v941 == nil then
                        break
                    end
                    if game:GetService('Workspace').Map:FindFirstChild('MysticIsland') then
                        topos(CFrame.new(game.Workspace.Map.MysticIsland.BiggTree.Part.Position))
                    end
                end
            end
        end
    end)
    v181:AddToggle({
        Name = 'Tween Blue Gear',
        Default = false,
        Callback = function(p943)
            _G.TweenMGear = p943

            StopTween(_G.TweenMGear)
        end,
    })
    spawn(function()
        while wait() do
            if _G.TweenMGear and game:GetService('Workspace').Map:FindFirstChild('MysticIsland') then
                local v944, v945, v946 = pairs(game:GetService('Workspace').Map.MysticIsland:GetChildren())

                while true do
                    local v947

                    v946, v947 = v944(v945, v946)

                    if v946 == nil then
                        break
                    end
                    if v947:IsA('MeshPart') and v947.Material == Enum.Material.Neon then
                        topos(v947.CFrame)
                    end
                end
            end
        end
    end)
    v181:AddToggle({
        Name = 'Lock Cam To Moon',
        Default = false,
        Callback = function(p948)
            _G.LockCamToMoon = p948
        end,
    })
    spawn(function()
        while wait() do
            if _G.LockCamToMoon then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, game:GetService('Lighting'):GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
            end
        end
    end)
    v181:AddToggle({
        Name = 'Teleport To Advanced Fruit Dealer',
        Default = false,
        Callback = function(p949)
            _G.MirageNpc = p949

            StopTween(_G.MirageNpc)
        end,
    })
    spawn(function()
        while wait() do
            if _G.MirageNpc and game:GetService('Workspace').NPCs:FindFirstChild('Advanced Fruit Dealer') then
                topos(CFrame.new(game:GetService('Workspace').NPCs['Advanced Fruit Dealer'].HumanoidRootPart.Position))
            end
        end
    end)
    v181:AddSection({
        Name = '~ Trials Race ~',
    })

    local _Moon = v181:AddParagraph('Moon')

    v181:AddToggle({
        Name = 'Auto Complete Trials',
        Default = false,
        Callback = function(p951)
            _G.AutoQuestRace = p951

            StopTween(_G.AutoQuestRace)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoQuestRace then
                if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Human' then
                    if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Skypiea' then
                        if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Fishman' then
                            if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Cyborg' then
                                if game:GetService('Players').LocalPlayer.Data.Race.Value ~= 'Ghoul' then
                                    if game:GetService('Players').LocalPlayer.Data.Race.Value == 'Mink' then
                                        local v952, v953, v954 = pairs(game:GetService('Workspace'):GetDescendants())

                                        while true do
                                            local v955

                                            v954, v955 = v952(v953, v954)

                                            if v954 == nil then
                                                break
                                            end
                                            if v955.Name == 'StartPoint' then
                                                topos(v955.CFrame * CFrame.new(0, 10, 0))
                                            end
                                        end
                                    end
                                else
                                    local v956, v957, v958 = pairs(game.Workspace.Enemies:GetDescendants())

                                    while true do
                                        local v959

                                        v958, v959 = v956(v957, v958)

                                        if v958 == nil then
                                            break
                                        end
                                        if v959:FindFirstChild('Humanoid') and v959:FindFirstChild('HumanoidRootPart') and v959.Humanoid.Health > 0 then
                                            repeat
                                                wait()

                                                v959.Humanoid.Health = 0
                                                v959.HumanoidRootPart.CanCollide = false

                                                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                                            until not (_G.AutoQuestRace and v959.Parent) or v959.Humanoid.Health <= 0
                                        end
                                    end
                                end
                            else
                                topos(CFrame.new(28654, 14898.7832, -30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                            end
                        else
                            local v960, v961, v962 = pairs(game:GetService('Workspace').SeaBeasts.SeaBeast1:GetDescendants())

                            while true do
                                local v963

                                v962, v963 = v960(v961, v962)

                                if v962 == nil then
                                    break
                                end
                                if v963.Name == 'HumanoidRootPart' then
                                    topos(v963.CFrame * PosSea)

                                    Skillaimbot = true
                                    AimBotSkillPosition = v963.HumanoidRootPart.CFrame.Position

                                    local v964, v965, v966 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                                    while true do
                                        local v967

                                        v966, v967 = v964(v965, v966)

                                        if v966 == nil then
                                            break
                                        end
                                        if v967:IsA('Tool') and v967.ToolTip == 'Melee' then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v967)
                                        end
                                    end

                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)

                                    local v968, v969, v970 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                                    while true do
                                        local v971

                                        v970, v971 = v968(v969, v970)

                                        if v970 == nil then
                                            break
                                        end
                                        if v971:IsA('Tool') and v971.ToolTip == 'Blox Fruit' then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v971)
                                        end
                                    end

                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.5)

                                    local v972, v973, v974 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                                    while true do
                                        local v975

                                        v974, v975 = v972(v973, v974)

                                        if v974 == nil then
                                            break
                                        end
                                        if v975:IsA('Tool') and v975.ToolTip == 'Sword' then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v975)
                                        end
                                    end

                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.5)

                                    local v976, v977, v978 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                                    while true do
                                        local v979

                                        v978, v979 = v976(v977, v978)

                                        if v978 == nil then
                                            break
                                        end
                                        if v979:IsA('Tool') and v979.ToolTip == 'Gun' then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v979)
                                        end
                                    end

                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                end
                            end
                        end
                    else
                        local v980, v981, v982 = pairs(game:GetService('Workspace').Map.SkyTrial.Model:GetDescendants())

                        while true do
                            local v983

                            v982, v983 = v980(v981, v982)

                            if v982 == nil then
                                break
                            end
                            if v983.Name == 'snowisland_Cylinder.081' then
                                topos(v983.CFrame * CFrame.new(0, 0, 0))
                            end
                        end
                    end
                else
                    local v984, v985, v986 = pairs(game.Workspace.Enemies:GetDescendants())

                    while true do
                        local v987

                        v986, v987 = v984(v985, v986)

                        if v986 == nil then
                            break
                        end
                        if v987:FindFirstChild('Humanoid') and v987:FindFirstChild('HumanoidRootPart') and v987.Humanoid.Health > 0 then
                            repeat
                                wait()

                                v987.Humanoid.Health = 0
                                v987.HumanoidRootPart.CanCollide = false

                                sethiddenproperty(game.Players.LocalPlayer, 'SimulationRadius', math.huge)
                            until not (_G.AutoQuestRace and v987.Parent) or v987.Humanoid.Health <= 0
                        end
                    end
                end
            end
        end
    end)
    v181:AddDropdown({
        Name = 'Select Weapon Kill Players Trials',
        Default = 'Melee',
        Options = {
            'Melee',
            'Sword',
            'Gun',
            'Blox Fruit',
        },
        Callback = function(p988)
            _G.SelectTrialWeapon = p988
        end,
    })
    spawn(function()
        while wait() do
            if _G.SelectTrialWeapon == _G.SelectTrialWeapon then
                local v989, v990, v991 = pairs(game.Players.LocalPlayer.Backpack:GetChildren())

                while true do
                    local v992

                    v991, v992 = v989(v990, v991)

                    if v991 == nil then
                        break
                    end
                    if v992.ToolTip == _G.SelectTrialWeapon and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v992.Name)) then
                        _G.SelectTrialsWeapon = v992.Name
                    end
                end
            end
        end
    end)
    v181:AddToggle({
        Name = 'Auto Kill Players After Trials',
        Default = false,
        Callback = function(p993)
            _G.KillAfterTrials = p993

            StopTween(_G.KillAfterTrials)
        end,
    })
    spawn(function()
        while wait() do
            if _G.KillAfterTrials then
                pcall(function()
                    TempleCFrame = CFrame.new(28730.0645, 14887.5371, -91.0957718, 0.557085216, -4.57713725e-8, 0.830455363, 9.81919115e-8, 1, -1.07530047e-8, -0.830455363, 8.75343389e-8, 0.557085216)

                    if game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible and GetDistance(TempleCFrame) <= 380 then
                        local v994, v995, v996 = pairs(game.Players:GetChildren())

                        while true do
                            local v997

                            v996, v997 = v994(v995, v996)

                            if v996 == nil then
                                break
                            end
                            if v997.Name ~= game.Players.LocalPlayer.Name and GetDistance(TempleCFrame, v997.Character.HumanoidRootPart) <= 300 and v997.Character.Humanoid.Health > 0 then
                                repeat
                                    wait()
                                    EquipWeapon(_G.SelectTrialsWeapon)
                                    topos(v997.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 0))

                                    UseSkillTrial = true
                                    SpamOnRace = true
                                    AimBotSkillPosition = v997.Character.HumanoidRootPart.CFrame.Position
                                    Skillaimbot = true
                                    KillPlayerAttack = true
                                until _G.KillAfterTrials == false or v997.Humanoid.Health <= 0 or not (v997.Parent and v997:FindFirstChild('HumanoidRootPart')) or not v997:FindFirstChild('Humanoid')

                                UseSkillTrial = false
                                SpamOnRace = false
                                Skillaimbot = false
                                KillPlayerAttack = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if SpamOnRace then
                game:GetService('VirtualInputManager'):SendKeyEvent(true, 'T', false, game)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, 'T', false, game)
                wait()
                game:GetService('VirtualInputManager'):SendKeyEvent(true, 'Y', false, game)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, 'Y', false, game)
            end
        end
    end)
    spawn(function()
        while wait() do
            if SpamOnRace then
                wait()

                if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') then
                    game:GetService('VirtualUser'):SetKeyDown('0x65')
                    wait(0.1)
                    game:GetService('VirtualUser'):SetKeyUp('0x65')
                end
                if not game:GetService('Players').LocalPlayer.PlayerGui.ScreenGui:FindFirstChild('ImageLabel') and SpamOnRace then
                    break
                end
            end
        end
    end)
    v181:AddToggle({
        Name = 'Use Skill Z',
        Default = true,
        Callback = function(p998)
            _G.Z = p998
        end,
    })
    v181:AddToggle({
        Name = 'Use Skill X',
        Default = true,
        Callback = function(p999)
            _G.X = p999
        end,
    })
    v181:AddToggle({
        Name = 'Use Skill C',
        Default = true,
        Callback = function(p1000)
            _G.C = p1000
        end,
    })
    v181:AddToggle({
        Name = 'Use Skill V',
        Default = false,
        Callback = function(p1001)
            _G.V = p1001
        end,
    })
    spawn(function()
        while task.wait() do
            if UseSkillTrial then
                if _G.Z then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'Z', false, game)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'Z', false, game)
                end
                if _G.X then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'X', false, game)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'X', false, game)
                end
                if _G.C then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'C', false, game)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'C', false, game)
                end
                if _G.V then
                    game:GetService('VirtualInputManager'):SendKeyEvent(true, 'V', false, game)
                    game:GetService('VirtualInputManager'):SendKeyEvent(false, 'V', false, game)
                end
            end
        end
    end)
    v181:AddSection({
        Name = '~ Train Race ~',
    })

    local _AncientOne = v181:AddParagraph('Ancient One')

    v181:AddToggle({
        Name = 'Auto Buy Gear',
        Default = false,
        Callback = function(p1003)
            _G.AutoBuyGear = p1003
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoBuyGear then
                ({})[1] = true

                game:GetService('ReplicatedStorage'):WaitForChild('Remotes'):WaitForChild('CommF_'):InvokeServer(unpack({
                    'UpgradeRace',
                    'Buy',
                }))
            end
        end
    end)
    v181:AddToggle({
        Name = 'Auto Ancient One Quest',
        Default = false,
        Callback = function(p1004)
            _G.AutoRace = p1004
            _G.Auto_Bone = p1004

            StopTween(_G.AutoRace)
        end,
    })
    spawn(function()
        while wait() do
            if _G.AutoRace and game.Players.LocalPlayer.Character.RaceTransformed.Value == true then
                _G.Auto_Bone = false

                topos(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.AutoRace and game.Players.LocalPlayer.Character.RaceTransformed.Value == false then
                _G.Auto_Bone = true
            end
        end
    end)
    spawn(function()
        while wait() do
            if _G.AutoRace then
                game:GetService('VirtualInputManager'):SendKeyEvent(true, 'Y', false, game)
                wait(0.1)
                game:GetService('VirtualInputManager'):SendKeyEvent(false, 'Y', false, game)
            end
        end
    end)
    v182:AddSection({
        Name = '~ Up Stats ~',
    })
    v182:AddSlider({
        Name = 'Point',
        Min = 1,
        Max = 100,
        Default = 3,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = '',
        Callback = function(p1005)
            PointStats = p1005
        end,
    })
    v182:AddToggle({
        Name = 'Auto + Melee',
        Default = false,
        Callback = function(p1006)
            Melee = p1006
        end,
    })
    v182:AddToggle({
        Name = 'Auto + Defense',
        Default = false,
        Callback = function(p1007)
            Defense = p1007
        end,
    })
    v182:AddToggle({
        Name = 'Auto + Sword',
        Default = false,
        Callback = function(p1008)
            Sword = p1008
        end,
    })
    v182:AddToggle({
        Name = 'Auto + Gun',
        Default = false,
        Callback = function(p1009)
            Gun = p1009
        end,
    })
    v182:AddToggle({
        Name = 'Auto + Devil Fruit',
        Default = false,
        Callback = function(p1010)
            DemonFruit = p1010
        end,
    })
    spawn(function()
        while wait() do
            if game.Players.localPlayer.Data.Points.Value >= PointStats then
                if Melee then
                    local v1011 = {
                        'AddPoint',
                        'Melee',
                        PointStats,
                    }

                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v1011))
                end
                if Defense then
                    local v1012 = {
                        'AddPoint',
                        'Defense',
                        PointStats,
                    }

                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v1012))
                end
                if Sword then
                    local v1013 = {
                        'AddPoint',
                        'Sword',
                        PointStats,
                    }

                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v1013))
                end
                if Gun then
                    local v1014 = {
                        'AddPoint',
                        'Gun',
                        PointStats,
                    }

                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v1014))
                end
                if DemonFruit then
                    local v1015 = {
                        'AddPoint',
                        'Demon Fruit',
                        PointStats,
                    }

                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack(v1015))
                end
            end
        end
    end)
    v182:AddSection({
        Name = '~ Esp ~',
    })
    v182:AddToggle({
        Name = 'Esp Player',
        Default = false,
        Callback = function(p1016)
            _G.ESPPlayer = p1016

            UpdatePlayerChams()
        end,
    })
    v182:AddToggle({
        Name = 'Esp Island',
        Default = false,
        Callback = function(p1017)
            _G.IslandESP = p1017

            UpdateIslandESP()
        end,
    })
    v182:AddToggle({
        Name = 'Esp Devil Fruit',
        Default = false,
        Callback = function(p1018)
            _G.DevilFruitESP = p1018

            UpdateDevilChams()
        end,
    })
    v182:AddToggle({
        Name = 'Esp Flower',
        Default = false,
        Callback = function(p1019)
            _G.FlowerESP = p1019

            UpdateFlowerChams()
        end,
    })
    v182:AddToggle({
        Name = 'Esp Chest',
        Default = false,
        Callback = function(p1020)
            _G.ChestESP = p1020

            UpdateChestChams()
        end,
    })
    spawn(function()
        while task.wait() do
            if _G.FlowerESP then
                UpdateFlowerChams()
            end
            if _G.ChestESP then
                UpdateChestChams()
            end
            if _G.ESPPlayer then
                UpdatePlayerChams()
            end
            if _G.IslandESP then
                UpdateIslandESP()
            end
            if _G.DevilFruitESP then
                UpdateDevilChams()
            end
        end
    end)
    u183:AddSection({
        Name = '~ Sea ~',
    })

    local _CheckSea = u183:AddParagraph('Check Sea')

    if World1 then
        _CheckSea:Set('First Sea')
    elseif World2 then
        _CheckSea:Set('Second Sea')
    elseif World3 then
        _CheckSea:Set('Third Sea')
    end

    u183:AddDropdown({
        Name = 'Select Sea',
        Default = '',
        Options = {
            'First Sea',
            'Second Sea',
            'Third Sea',
        },
        Callback = function(p1022)
            SelectSea = p1022
        end,
    })
    u183:AddButton({
        Name = 'Teleport To Sea',
        Callback = function()
            if SelectSea ~= 'First Sea' then
                if SelectSea ~= 'Second Sea' then
                    if SelectSea == 'Third Sea' then
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelZou')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelDressrosa')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('TravelMain')
            end
        end,
    })
    u183:AddSection({
        Name = '~ Island ~',
    })

    if World1 then
        ChonDao = {
            'Wind Mill',
            'Marine',
            'Middle Town',
            'Jungle',
            'Pirate Village',
            'Desert',
            'Snow Island',
            'MarineFord',
            'Colosseum',
            'Sky Island 1',
            'Sky Island 2',
            'Sky Island 3',
            'Prison',
            'Magma Village',
            'Under Water Island',
            'Fountain City',
            'Shank Room',
            'Mob Island',
        }
    elseif Word2 then
        ChonDao = {
            'The Cafe',
            'Frist Spot',
            'Dark Area',
            'Flamingo Mansion',
            'Flamingo Room',
            'Green Zone',
            'Factory',
            'Colossuim',
            'Zombie Island',
            'Raid Lab',
            'Two Snow Mountains',
            'Punk Hazard',
            'Cursed Ship',
            'Ice Castle',
            'Forgotten Island',
            'Ussop Island',
            'Mini Sky Island',
        }
    elseif World3 then
        ChonDao = {
            'Mansion',
            'Port Town',
            'Great Tree',
            'Castle On The Sea',
            'Raid Lab',
            'MiniSky',
            'Hydra Island',
            'Beautiful Pirate',
            'Floating Turtle',
            'Haunted Castle',
            'Ice Cream Island',
            'Peanut Island',
            'Cake Island',
            'Cocoa Island',
            'Candy Island',
            'Tiki Outpost',
        }
    end

    u183:AddDropdown({
        Name = 'Select Island',
        Default = '',
        Options = ChonDao,
        Callback = function(p1023)
            SelectIsland = p1023
        end,
    })
    u183:AddToggle({
        Name = 'Teleport To Island',
        Default = false,
        Callback = function(p1024)
            _G.TeleportIsland = p1024

            if _G.TeleportIsland ~= true then
                StopTween(_G.TeleportIsland)

                return
            else
                while true do
                    if true then
                        wait()

                        if SelectIsland ~= 'Wind Mill' then
                            if SelectIsland ~= 'Marine' then
                                if SelectIsland ~= 'Middle Town' then
                                    if SelectIsland ~= 'Jungle' then
                                        if SelectIsland ~= 'Pirate Village' then
                                            if SelectIsland ~= 'Desert' then
                                                if SelectIsland ~= 'Snow Island' then
                                                    if SelectIsland ~= 'MarineFord' then
                                                        if SelectIsland ~= 'Colosseum' then
                                                            if SelectIsland ~= 'Sky Island 1' then
                                                                if SelectIsland ~= 'Sky Island 2' then
                                                                    if SelectIsland ~= 'Sky Island 3' then
                                                                        if SelectIsland ~= 'Prison' then
                                                                            if SelectIsland ~= 'Magma Village' then
                                                                                if SelectIsland ~= 'Under Water Island' then
                                                                                    if SelectIsland ~= 'Fountain City' then
                                                                                        if SelectIsland ~= 'Shank Room' then
                                                                                            if SelectIsland ~= 'Mob Island' then
                                                                                                if SelectIsland ~= 'Raid Lab' then
                                                                                                    if SelectIsland ~= 'The Cafe' then
                                                                                                        if SelectIsland ~= 'Frist Spot' then
                                                                                                            if SelectIsland ~= 'Dark Area' then
                                                                                                                if SelectIsland ~= 'Flamingo Mansion' then
                                                                                                                    if SelectIsland ~= 'Flamingo Room' then
                                                                                                                        if SelectIsland ~= 'Green Zone' then
                                                                                                                            if SelectIsland ~= 'Factory' then
                                                                                                                                if SelectIsland ~= 'Colossuim' then
                                                                                                                                    if SelectIsland ~= 'Zombie Island' then
                                                                                                                                        if SelectIsland ~= 'Two Snow Mountain' then
                                                                                                                                            if SelectIsland ~= 'Punk Hazard' then
                                                                                                                                                if SelectIsland ~= 'Cursed Ship' then
                                                                                                                                                    if SelectIsland ~= 'Ice Castle' then
                                                                                                                                                        if SelectIsland ~= 'Forgotten Island' then
                                                                                                                                                            if SelectIsland ~= 'Ussop Island' then
                                                                                                                                                                if SelectIsland ~= 'Mini Sky Island' then
                                                                                                                                                                    if SelectIsland ~= 'Great Tree' then
                                                                                                                                                                        if SelectIsland ~= 'Castle On The Sea' then
                                                                                                                                                                            if SelectIsland ~= 'MiniSky' then
                                                                                                                                                                                if SelectIsland ~= 'Port Town' then
                                                                                                                                                                                    if SelectIsland ~= 'Hydra Island' then
                                                                                                                                                                                        if SelectIsland ~= 'Beautiful Pirate' then
                                                                                                                                                                                            if SelectIsland ~= 'Floating Turtle' then
                                                                                                                                                                                                if SelectIsland ~= 'Mansion' then
                                                                                                                                                                                                    if SelectIsland ~= 'Haunted Castle' then
                                                                                                                                                                                                        if SelectIsland ~= 'Ice Cream Island' then
                                                                                                                                                                                                            if SelectIsland ~= 'Peanut Island' then
                                                                                                                                                                                                                if SelectIsland ~= 'Cake Island' then
                                                                                                                                                                                                                    if SelectIsland ~= 'Cocoa Island' then
                                                                                                                                                                                                                        if SelectIsland ~= 'Candy Island' then
                                                                                                                                                                                                                            if SelectIsland == 'Tiki Outpost' then
                                                                                                                                                                                                                                topos(CFrame.new(-16101.1885, 12.8422165, 380.942291))
                                                                                                                                                                                                                            end
                                                                                                                                                                                                                        else
                                                                                                                                                                                                                            topos(CFrame.new(-1014.4241943359375, 149.11068725585938, -14555.962890625))
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                    else
                                                                                                                                                                                                                        topos(CFrame.new(87.94276428222656, 73.55451202392578, -12319.46484375))
                                                                                                                                                                                                                    end
                                                                                                                                                                                                                else
                                                                                                                                                                                                                    topos(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
                                                                                                                                                                                                                end
                                                                                                                                                                                                            else
                                                                                                                                                                                                                topos(CFrame.new(-2062.7475585938, 50.473892211914, -10232.568359375))
                                                                                                                                                                                                            end
                                                                                                                                                                                                        else
                                                                                                                                                                                                            topos(CFrame.new(-902.56817626953, 79.93204498291, -10988.84765625))
                                                                                                                                                                                                        end
                                                                                                                                                                                                    else
                                                                                                                                                                                                        topos(CFrame.new(-9515.3720703125, 164.00624084473, 5786.0610351562))
                                                                                                                                                                                                    end
                                                                                                                                                                                                else
                                                                                                                                                                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
                                                                                                                                                                                                end
                                                                                                                                                                                            else
                                                                                                                                                                                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-12001, 332, -8861))
                                                                                                                                                                                            end
                                                                                                                                                                                        else
                                                                                                                                                                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(5319, 23, -93))
                                                                                                                                                                                        end
                                                                                                                                                                                    else
                                                                                                                                                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(5756, 610, -282))
                                                                                                                                                                                    end
                                                                                                                                                                                else
                                                                                                                                                                                    topos(CFrame.new(-290.7376708984375, 6.729952812194824, 5343.5537109375))
                                                                                                                                                                                end
                                                                                                                                                                            else
                                                                                                                                                                                topos(CFrame.new(-260.65557861328, 49325.8046875, -35253.5703125))
                                                                                                                                                                            end
                                                                                                                                                                        else
                                                                                                                                                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-5071.82324, 314.858734, -3150.69922))
                                                                                                                                                                        end
                                                                                                                                                                    else
                                                                                                                                                                        topos(CFrame.new(2681.2736816406, 1682.8092041016, -7190.9853515625))
                                                                                                                                                                    end
                                                                                                                                                                else
                                                                                                                                                                    topos(CFrame.new(-288.74060058594, 49326.31640625, -35248.59375))
                                                                                                                                                                end
                                                                                                                                                            else
                                                                                                                                                                topos(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
                                                                                                                                                            end
                                                                                                                                                        else
                                                                                                                                                            topos(CFrame.new(-3032.7641601563, 317.89672851563, -10075.373046875))
                                                                                                                                                        end
                                                                                                                                                    else
                                                                                                                                                        topos(CFrame.new(6148.4116210938, 294.38687133789, -6741.1166992188))
                                                                                                                                                    end
                                                                                                                                                else
                                                                                                                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(923.40197753906, 125.05712890625, 32885.875))
                                                                                                                                                end
                                                                                                                                            else
                                                                                                                                                topos(CFrame.new(-6127.654296875, 15.951762199402, -5040.2861328125))
                                                                                                                                            end
                                                                                                                                        else
                                                                                                                                            topos(CFrame.new(753.14288330078, 408.23559570313, -5274.6147460938))
                                                                                                                                        end
                                                                                                                                    else
                                                                                                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-6509, 83, -133))
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    topos(CFrame.new(-1503.6224365234, 219.7956237793, 1369.3101806641))
                                                                                                                                end
                                                                                                                            else
                                                                                                                                topos(CFrame.new(424.12698364258, 211.16171264648, -427.54049682617))
                                                                                                                            end
                                                                                                                        else
                                                                                                                            topos(CFrame.new(-2448.5300292969, 73.016105651855, -3210.6306152344))
                                                                                                                        end
                                                                                                                    else
                                                                                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(2283, 15, 867))
                                                                                                                    end
                                                                                                                else
                                                                                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-281.93707275390625, 306.130615234375, 609.280029296875))
                                                                                                                end
                                                                                                            else
                                                                                                                topos(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
                                                                                                            end
                                                                                                        else
                                                                                                            topos(CFrame.new(-11.311455726624, 29.276733398438, 2771.5224609375))
                                                                                                        end
                                                                                                    else
                                                                                                        topos(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                                                                                                    end
                                                                                                elseif World3 then
                                                                                                    topos(CFrame.new(-5017.40869, 314.844055, -2823.0127, -0.925743818, 4.48217499e-8, -0.378151238, 4.55503146e-9, 1, 1.07377559e-7, 0.378151238, 9.7681621e-8, -0.925743818))
                                                                                                elseif World2 then
                                                                                                    topos(CFrame.new(-6438.73535, 250.645355, -4501.50684))
                                                                                                end
                                                                                            else
                                                                                                topos(CFrame.new(-2850.20068, 7.39224768, 5354.99268))
                                                                                            end
                                                                                        else
                                                                                            topos(CFrame.new(-1442.16553, 29.8788261, -28.3547478))
                                                                                        end
                                                                                    else
                                                                                        topos(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
                                                                                    end
                                                                                else
                                                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(61163.8515625, 5.6796875, 1819.7841796875))
                                                                                end
                                                                            else
                                                                                topos(CFrame.new(-5247.7163085938, 12.883934020996, 8504.96875))
                                                                            end
                                                                        else
                                                                            topos(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
                                                                        end
                                                                    else
                                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
                                                                    end
                                                                else
                                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('requestEntrance', Vector3.new(-4607.82275, 872.54248, -1667.55688))
                                                                end
                                                            else
                                                                topos(CFrame.new(-4869.1025390625, 733.46051025391, -2667.0180664063))
                                                            end
                                                        else
                                                            topos(CFrame.new(-1427.6203613281, 7.2881078720093, -2792.7722167969))
                                                        end
                                                    else
                                                        topos(CFrame.new(-4914.8212890625, 50.963626861572, 4281.0278320313))
                                                    end
                                                else
                                                    topos(CFrame.new(1347.8067626953, 104.66806030273, -1319.7370605469))
                                                end
                                            else
                                                topos(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
                                            end
                                        else
                                            topos(CFrame.new(-1181.3093261719, 4.7514905929565, 3803.5456542969))
                                        end
                                    else
                                        topos(CFrame.new(-1612.7957763672, 36.852081298828, 149.12843322754))
                                    end
                                else
                                    topos(CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094))
                                end
                            else
                                topos(CFrame.new(-2566.4296875, 6.8556680679321, 2045.2561035156))
                            end
                        else
                            topos(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
                        end
                    end
                    if not _G.TeleportIsland then
                    end
                end
            end
        end,
    })
    v184:AddSection({
        Name = '~ Status Server ~',
    })

    local _TimePlayed = v184:AddParagraph('Time Played')

    function UpdateTime()
        local v1026 = math.floor(workspace.DistributedGameTime + 0.5)

        _TimePlayed:Set(math.floor(v1026 / 3600) % 24 .. ' Hour | ' .. math.floor(v1026 / 60) % 60 .. ' Minute | ' .. math.floor(v1026 / 1) % 60 .. ' Seconds')
    end

    spawn(function()
        while task.wait() do
            UpdateTime()
        end
    end)

    local _Moon2 = v184:AddParagraph('Moon')
    local _CakePrince2 = v184:AddParagraph('Cake Prince')
    local _LegendarySwordDealer2 = v184:AddParagraph('Legendary Sword Dealer')
    local _HakiDealer2 = v184:AddParagraph('Haki Dealer')
    local _Elite2 = v184:AddParagraph('Elite')
    local _MirageIsland2 = v184:AddParagraph('Mirage Island')
    local _KitsuneIsland2 = v184:AddParagraph('Kitsune Island')
    local _FrozenDimension = v184:AddParagraph('Frozen Dimension')

    spawn(function()
        while task.wait() do
            pcall(function()
                _YourLevel:Set('Level: ' .. game:GetService('Players').LocalPlayer.Data.Level.Value .. '/2550')
                _Moon2:Set(CheckMoon() .. ' | ' .. function7() .. ' | ' .. function8())
                _CakePrince2:Set(CheckCakeSpawn())
                _LegendarySwordDealer2:Set(CheckSword())
                _HakiDealer2:Set(CheckHaki())
                _Elite2:Set(CheckElite())
                _AncientOne:Set(CheckAncientOneStatus())
                _MirageIsland2:Set(CheckMirage())
                _KitsuneIsland2:Set(CheckKitsune())
                _FrozenDimension:Set(CheckFrozen())
            end)
        end
    end)
    spawn(function()
        while task.wait() do
            pcall(function()
                _CakePrince:Set(CheckCakeSpawn())
                _LegendarySwordDealer:Set(CheckSword())
                _HakiDealer:Set(CheckHaki())
                _KitsuneIsland:Set(CheckKitsune())
                _MirageIsland:Set(CheckMirage())
                _YourRace:Set('Race: ' .. CheckRace())
                _Elite:Set(CheckElite())
                _Moon:Set(CheckMoon() .. ' | ' .. function7() .. ' | ' .. function8())
                _EliteProgress:Set('Progress: ' .. game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('EliteHunter', 'Progress'))

                if game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Bones', 'Check') and World3 then
                    _YourBone:Set('Bone: ' .. game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Bones', 'Check') .. '/5000')
                elseif World1 or World2 then
                    _YourBone:Set('Only Third Sea')
                end
            end)
        end
    end)
    spawn(function()
        while task.wait() do
            pcall(function()
                _Rip_IndraStatus:Set(GodChalice() .. ' | ' .. CheckTrumAd())
                _DarkbeardStatus:Set(CDarkness() .. ' | ' .. CheckRauDen())
                _ObservationLevel:Set('Level: ' .. math.floor(game:GetService('Players').LocalPlayer.VisionRadius.Value))

                local v1035, v1036, v1037 = pairs(game:GetService('Players'):GetPlayers())

                while true do
                    local v1038

                    v1037, v1038 = v1035(v1036, v1037)

                    if v1037 == nil then
                        break
                    end
                    if v1037 == 12 then
                        _PlayerInServer:Set('Player: ' .. v1037 .. '/12')
                    elseif v1037 == 1 then
                        _PlayerInServer:Set('Player: ' .. v1037 .. '/12')
                    else
                        _PlayerInServer:Set('Player: ' .. v1037 .. '/12')
                    end
                end

                if game:GetService('Players').LocalPlayer.Team.Name ~= 'Pirates' then
                    if game:GetService('Players').LocalPlayer.Team.Name == 'Marines' then
                        _YourBountyHonor:Set('Honor: ' .. tostring(game:GetService('Players').LocalPlayer.leaderstats['Bounty/Honor'].Value))
                    end
                else
                    _YourBountyHonor:Set('Bounty: ' .. tostring(game:GetService('Players').LocalPlayer.leaderstats['Bounty/Honor'].Value))
                end
            end)
        end
    end)
    v184:AddSection({
        Name = '~ Server ~',
    })
    v184:AddParagraph('Server Job-Id', game.JobId)
    v184:AddTextbox({
        Name = 'Input Job-Id',
        Default = '',
        TextDisappear = true,
        Callback = function(p1039)
            _G.Job = p1039
        end,
    })
    v184:AddButton({
        Name = 'Join Server',
        Callback = function()
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer)
        end,
    })
    v184:AddToggle({
        Name = 'Spam Join Server',
        Default = false,
        Callback = function(p1040)
            _G.Join = p1040
        end,
    })
    spawn(function()
        while wait() do
            if _G.Join then
                game:GetService('TeleportService'):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer)
            end
        end
    end)
    v184:AddButton({
        Name = 'Copy Server Job-Id',
        Callback = function()
            setclipboard(tostring(game.JobId))
            u394:MakeNotification({
                Name = 'Tinh Linh Hub',
                Content = 'Copied Server Job-Id!',
                Image = 'rbxassetid://16730867128',
                Time = 5,
            })
        end,
    })
    v184:AddButton({
        Name = 'Rejoin Server',
        Callback = function()
            game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService('Players').LocalPlayer)
        end,
    })
    v184:AddButton({
        Name = 'Hop Server',
        Callback = function()
            Hop()
        end,
    })

    function Hop()
        local _PlaceId3 = game.PlaceId
        local u1042 = {}
        local u1043 = ''
        local _hour = os.date('!*t').hour

        function TPReturner()
            local v1045

            if u1043 ~= '' then
                v1045 = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. _PlaceId3 .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. u1043))
            else
                v1045 = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. _PlaceId3 .. '/servers/Public?sortOrder=Asc&limit=100'))
            end
            if v1045.nextPageCursor and v1045.nextPageCursor ~= 'null' and v1045.nextPageCursor ~= nil then
                u1043 = v1045.nextPageCursor
            end

            local v1046, v1047, v1048 = pairs(v1045.data)
            local v1049 = 0

            while true do
                local v1050

                v1048, v1050 = v1046(v1047, v1048)

                if v1048 == nil then
                    break
                end

                local v1051 = true
                local u1052 = tostring(v1050.id)

                if tonumber(v1050.maxPlayers) > tonumber(v1050.playing) then
                    local v1053, v1054, v1055 = pairs(u1042)

                    while true do
                        local v1056

                        v1055, v1056 = v1053(v1054, v1055)

                        if v1055 == nil then
                            break
                        end
                        if v1049 == 0 then
                            if tonumber(_hour) ~= tonumber(v1056) then
                                pcall(function()
                                    u1042 = {}

                                    table.insert(u1042, _hour)
                                end)
                            end
                        elseif u1052 == tostring(v1056) then
                            v1051 = false
                        end

                        v1049 = v1049 + 1
                    end

                    if v1051 == true then
                        table.insert(u1042, u1052)
                        wait()
                        pcall(function()
                            wait()
                            game:GetService('TeleportService'):TeleportToPlaceInstance(_PlaceId3, u1052, game.Players.LocalPlayer)
                        end)
                        wait(4)
                    end
                end
            end
        end

        u183 = function()
            while wait() do
                TPReturner()

                if u1043 ~= '' then
                    TPReturner()
                end
            end
        end

        u183()
    end

    v185:AddSection({
        Name = '~ Code ~',
    })

    CodeA = {
        'TantaiGaming',
        'Axiore',
        'SUB2DAIGROCK',
        'Sub2UncleKizaru',
        'SUB2NOOBMASTER123',
        'StrawHatMaine',
        'Sub2OfficialNoobie',
        'SUB2GAMERROBOT_EXP1',
        'THEGREATACE',
        'BIGNEWS',
        'FUDD10',
        'fudd10_v2',
        'Bluxxy',
        'StarcodeHEO',
        'JCWK',
        'Magicbus',
        'Enyu_is_Pro',
        'Sub2Fer999',
        'KittGaming',
        'SUB2GAMERROBOT_RESET1',
        'Sub2CaptainMaui',
    }

    v185:AddDropdown({
        Name = 'Select Code',
        Default = '',
        Options = CodeA,
        Callback = function(p1057)
            CodeRd = p1057
        end,
    })
    v185:AddButton({
        Name = 'Redeem Code',
        Callback = function()
            game:GetService('ReplicatedStorage').Remotes.Redeem:InvokeServer(CodeRd)
        end,
    })
    v185:AddButton({
        Name = 'Redeem All Code',
        Callback = function()
            function RedeemCode(p1058)
                game:GetService('ReplicatedStorage').Remotes.Redeem:InvokeServer(p1058)
            end

            local v1059, v1060, v1061 = pairs(CodeA)

            while true do
                local v1062

                v1061, v1062 = v1059(v1060, v1061)

                if v1061 == nil then
                    break
                end

                RedeemCode(v1062)
            end
        end,
    })
    v185:AddSection({
        Name = '~ Fighting Style ~',
    })
    v185:AddDropdown({
        Name = 'Select Fighting Style',
        Default = '',
        Options = {
            'Black Leg',
            'Electro',
            'Fishman Karate',
            'Dragon Claw',
            'SuperHuman',
            'Death Step',
            'Sharkman Karate',
            'Electric Claw',
            'Dragon Talon',
            'GodHuman',
            'Sanguine Art',
        },
        Callback = function(p1063)
            SelectMelee = p1063
        end,
    })
    v185:AddButton({
        Name = 'Buy Fighting Style',
        Callback = function()
            if SelectMelee ~= 'Black Leg' then
                if SelectMelee ~= 'Electro' then
                    if SelectMelee ~= 'Fishman Karate' then
                        if SelectMelee ~= 'Dragon Claw' then
                            if SelectMelee ~= 'SuperHuman' then
                                if SelectMelee ~= 'Death Step' then
                                    if SelectMelee ~= 'Sharkman Karate' then
                                        if SelectMelee ~= 'Electric Claw' then
                                            if SelectMelee ~= 'Dragon Talon' then
                                                if SelectMelee ~= 'GodHuman' then
                                                    if SelectMelee == 'Sanguine Art' then
                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuySanguineArt', true)
                                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuySanguineArt')
                                                    end
                                                else
                                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyGodhuman')
                                                end
                                            else
                                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyDragonTalon')
                                            end
                                        else
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyElectricClaw')
                                        end
                                    else
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuySharkmanKarate', true)
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuySharkmanKarate')
                                    end
                                else
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyDeathStep')
                                end
                            else
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuySuperhuman')
                            end
                        else
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'DragonClaw', '1')
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'DragonClaw', '2')
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyFishmanKarate')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyElectro')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyBlackLeg')
            end
        end,
    })
    v185:AddSection({
        Name = '~ Abilities ~',
    })
    v185:AddDropdown({
        Name = 'Select Abilities',
        Default = '',
        Options = {
            'Sky Jump [ Geppo ]',
            'Buso Haki',
            'Soru',
            'Observation Haki',
        },
        Callback = function(p1064)
            SelectAbilities = p1064
        end,
    })
    v185:AddButton({
        Name = 'Buy Abilities',
        Callback = function()
            if SelectAbilities ~= 'Sky Jump [ Geppo ]' then
                if SelectAbilities ~= 'Buso Haki' then
                    if SelectAbilities ~= 'Soru' then
                        if SelectAbilities == 'Observation Haki' then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('KenTalk', 'Buy')
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyHaki', 'Soru')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyHaki', 'Buso')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyHaki', 'Geppo')
            end
        end,
    })
    v185:AddSection({
        Name = '~ Sword ~',
    })
    v185:AddDropdown({
        Name = 'Select Sword',
        Default = '',
        Options = {
            'Cutlass',
            'Katana',
            'Iron Mace',
            'Dual Katana',
            'Triple Katana',
            'Pipe',
            'Dual-Headed Blade',
            'Bisento',
            'Soul Cane',
            'Pole V2',
        },
        Callback = function(p1065)
            SelectSword = p1065
        end,
    })
    v185:AddButton({
        Name = 'Buy Sword',
        Callback = function()
            if SelectSword ~= 'Cutlass' then
                if SelectSword ~= 'Katana' then
                    if SelectSword ~= 'Iron Mace' then
                        if SelectSword ~= 'Dual Katana' then
                            if SelectSword ~= 'Triple Katana' then
                                if SelectSword ~= 'Pipe' then
                                    if SelectSword ~= 'Dual-Headed Blade' then
                                        if SelectSword ~= 'Bisento' then
                                            if SelectSword ~= 'Soul Cane' then
                                                if SelectSword == 'Pole V2' then
                                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer('ThunderGodTalk')
                                                end
                                            else
                                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Soul Cane')
                                            end
                                        else
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Bisento')
                                        end
                                    else
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Dual-Headed Blade')
                                    end
                                else
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Pipe')
                                end
                            else
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Triple Katana')
                            end
                        else
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Duel Katana')
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Iron Mace')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Katana')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Cutlass')
            end
        end,
    })
    v185:AddSection({
        Name = '~ Gun ~',
    })
    v185:AddDropdown({
        Name = 'Select Gun',
        Default = '',
        Options = {
            'Slingshot',
            'Flintlock',
            'Musket',
            'Cannon',
            'Refined Flintlock',
            'Refined Slingshot',
            'Bizarre Rifle',
            'Kabucha',
        },
        Callback = function(p1066)
            SelectGun = p1066
        end,
    })
    v185:AddButton({
        Name = 'Buy Gun',
        Callback = function()
            if SelectGun ~= 'Slingshot' then
                if SelectGun ~= 'Flintlock' then
                    if SelectGun ~= 'Musket' then
                        if SelectGun ~= 'Cannon' then
                            if SelectGun ~= 'Refined Flintlock' then
                                if SelectGun ~= 'Refined Slingshot' then
                                    if SelectGun ~= 'Kabucha' then
                                        if SelectGun == 'Bizarre Rifle' then
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Ectoplasm', 'Buy', 1)
                                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('Ectoplasm', 'Buy', 1)
                                        end
                                    else
                                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Kabucha')
                                    end
                                else
                                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Refined Slingshot')
                                end
                            else
                                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Refined Flintlock')
                            end
                        else
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Cannon')
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Musket')
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Flintlock')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BuyItem', 'Slingshot')
            end
        end,
    })
    v185:AddSection({
        Name = '~ Other ~',
    })
    v185:AddDropdown({
        Name = 'Select Other Things',
        Default = '',
        Options = {
            'Reroll Race',
            'Reset Stats',
            'Cyborg Race',
            'Ghoul Race',
        },
        Callback = function(p1067)
            SelectOther = p1067
        end,
    })
    v185:AddButton({
        Name = 'Buy Other Things Selected',
        Callback = function()
            if SelectOther ~= 'Reroll Race' then
                if SelectOther ~= 'Reset Stats' then
                    if SelectOther ~= 'Cyborg Race' then
                        if SelectOther == 'Ghoul Race' then
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                                'Ectoplasm',
                                'BuyCheck',
                                4,
                            }))
                            game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                                'Ectoplasm',
                                'Change',
                                4,
                            }))
                        end
                    else
                        game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer(unpack({
                            'CyborgTrainer',
                            'Buy',
                        }))
                    end
                else
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'Refund', '1')
                    game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'Refund', '2')
                end
            else
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'Reroll', '1')
                game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer('BlackbeardReward', 'Reroll', '2')
            end
        end,
    })
    u394:MakeNotification({
        Name = 'Tinh Linh Hub',
        Content = 'Script Loaded Successfully!',
        Image = 'rbxassetid://16730867128',
        Time = 5,
    })

    return
end
