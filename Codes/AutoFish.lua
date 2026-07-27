local _ = workspace
local _LocalPlayer9 = game.Players.LocalPlayer
local _FishReplicated = game.ReplicatedStorage:WaitForChild('FishReplicated')
local _FishingRequest = _FishReplicated:WaitForChild('FishingRequest')
local _MaxLaunchDistance = require(_FishReplicated.FishingClient.Config).Rod.MaxLaunchDistance
local u864 = require(loadstring(game:HttpGet("https://raw.githubusercontent.com/scripting-alt/bloxfruits/refs/heads/main/Main.lua"))())

_G.SelectedRod = "Shark (Corrupted)"

task.spawn(function()
    while task.wait() do
        if _G.AutoFishing then
            local _Character7 = _LocalPlayer9.Character
            local v866

            if _Character7 then
                v866 = _Character7:FindFirstChild('HumanoidRootPart')
            else
                v866 = _Character7
            end

            local v867

            if _Character7 then
                v867 = _Character7:FindFirstChildOfClass('Tool')
            else
                v867 = _Character7
            end

            local v868

            if _G.SelectedRod and (not v867 or v867.Name ~= _G.SelectedRod) then
                v868 = _LocalPlayer9.Backpack:FindFirstChild(_G.SelectedRod)

                if v868 then
                    _LocalPlayer9.Character.Humanoid:EquipTool(v868)
                else
                    v868 = v867
                end
            else
                v868 = v867
            end
            if _Character7 and v866 and v868 then
                local v869 = u864(v866.Position)
                local _, v870 = workspace:FindPartOnRayWithIgnoreList(Ray.new(_Character7.Head.Position, v866.CFrame.LookVector * _MaxLaunchDistance), {
                    _Character7,
                    workspace.Characters,
                    workspace.Enemies,
                })

                if v870 then
                    v870 = Vector3.new(v870.X, math.max(v870.Y, v869), v870.Z)
                end

                local _State = v868:GetAttribute('State')
                local _ServerState = v868:GetAttribute('ServerState')

                if (_State == 'ReeledIn' or _ServerState == 'ReeledIn') and v870 then
                    _FishingRequest:InvokeServer('StartCasting')
                    task.wait()
                    _FishingRequest:InvokeServer('CastLineAtLocation', v870, 100, true)
                elseif _ServerState == 'Biting' then
                    _FishingRequest:InvokeServer('Catching', true)
                    task.wait(0.1)
                    _FishingRequest:InvokeServer('Catch', 1)
                end
            end
        end
    end
end)