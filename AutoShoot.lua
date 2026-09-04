local cd = 1        

local function GetBladeHits()
    local targets = {}
    local function GetDistance(v)
        return (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end
    
    for _, part in pairs({game.Workspace.Enemies, game.Workspace.Characters}) do
        for _, v in pairs(part:GetChildren()) do
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") then
                if game.Players:GetPlayerFromCharacter(v) and IsFriendly(game.Players:GetPlayerFromCharacter(v)) then
                    continue
                end
                
                if GetDistance(v.HumanoidRootPart) < 60 then
                    table.insert(targets, v)
                end
            end
        end
    end

    return targets
end

local function AttackAll()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then return end

    local equippedWeapon = character:FindFirstChildOfClass("Tool")
    if not equippedWeapon then return end


    local enemies = GetBladeHits()

    if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") and enemies[1] then
        local direction = (enemies[1].HumanoidRootPart.Position - character:GetPivot().Position).Unit
        equippedWeapon:FindFirstChild("LeftClickRemote"):FireServer(direction, cd)
    end

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

task.spawn(function()
    while task.wait
end)