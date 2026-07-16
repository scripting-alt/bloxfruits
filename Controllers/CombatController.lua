local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Net = require(ReplicatedStorage.Modules.Net)
local CombatUtil = require(ReplicatedStorage.Modules.CombatUtil)

require(ReplicatedStorage.Modules.WeaponData)

local Main = require(ReplicatedStorage.Util.CameraShaker.Main)
local CameraShaker = require(ReplicatedStorage.Util.CameraShaker)
local PlayAnimationSequence = require(ReplicatedStorage.Modules.PlayAnimationSequence)
local MobileUIController = require(game.ReplicatedStorage.Controllers.UI.MobileUIController)
local CustomCursor = require(game.ReplicatedStorage.Controllers.UI.CustomCursor)
local LastInput = require(game.ReplicatedStorage.Modules.LastInput)
local Trove = require(ReplicatedStorage.Modules.Util.Trove)

require(ReplicatedStorage.Modules.Flags)

local LocalPlayer = game.Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v1 = LocalPlayer:GetMouse()

CombatUtil:GetComboPaddingTime()
CombatUtil:GetHitDetectionParams()

local v2 = CombatUtil:GetAttackCancelMultiplier()

Random.new()

local Cache2 = game.ReplicatedStorage:WaitForChild("Cache2")
local v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 = Cache2, 0, false, {}, false, nil, 0, {}, {}, nil, nil, nil, 0, 0, false, nil, nil, nil

for i = 1, #Cache2:GetChildren() + 27 do
    if math.random(1, 2) == 1 then
        pcall(game.Destroy, v3.GetChildren(v3, 10717372)[1])
    end

    shared("")
end

local v21 = 727595
local v22 = 798405
local v23 = 1048576 + shared("")
local v24 = 1099511627776
local v25 = 0
local v26 = 1
local v27 = 0

local function cancelEquipAnim(p1) --[[ cancelEquipAnim | Line: 55 | Upvalues: v10 (copy) ]]
    local v1 = v10[p1]

    if not v1 then
        return
    end

    v1:cancel()
    v10[p1] = nil
end

local function attackStart(p1) --[[ attackStart | Line: 63 | Upvalues: CombatUtil (copy), v15 (ref) ]]
    CombatUtil:AttackStart(p1, v15)
end

local function setFocusTimer(p1) --[[ setFocusTimer | Line: 67 | Upvalues: v4 (ref), v16 (ref) ]]
    v4 = p1
    v16 = os.clock()
end

local function playEquipAnimation(p1) --[[ playEquipAnimation | Line: 72 | Upvalues: CombatUtil (copy), PlayAnimationSequence (copy), v10 (copy), LocalPlayer (copy), v11 (copy) ]]
    while p1.Parent and not p1:FindFirstChildWhichIsA("BasePart", true) do
        task.wait()
    end

    local EquipAnimation = CombatUtil:GetWeaponData((CombatUtil:GetWeaponName(p1))).EquipAnimation

    if not (EquipAnimation and EquipAnimation.Equip) then
        return
    end

    local v1 = p1.Parent
    local v2 = PlayAnimationSequence(p1, EquipAnimation.Equip)

    v10[p1] = v2
    v2:andThen(function() --[[ Line: 84 | Upvalues: v1 (copy), LocalPlayer (ref), v11 (ref), v10 (ref), p1 (copy) ]]
        if v1 == LocalPlayer.Character then
            v11.EquipAnimApplyEndStateEvent:FireServer()
        end

        v10[p1] = nil
    end)

    if not v1 or (v1 == LocalPlayer.Character or not p1:IsDescendantOf(workspace)) then
        return
    end

    local v3 = nil

    v3 = p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 95 | Upvalues: v3 (ref), p1 (copy), v10 (ref) ]]
        if p2 and p2:IsDescendantOf(workspace) then
            return
        end

        v3:Disconnect()
        v3 = nil

        local v1 = p1
        local v2 = v10[v1]

        if not v2 then
            return
        end

        v2:cancel()
        v10[v1] = nil
    end)
end

local function playUnequipAnimation(p1) --[[ playUnequipAnimation | Line: 106 | Upvalues: CombatUtil (copy), PlayAnimationSequence (copy) ]]
    while p1.Parent and not p1:FindFirstChildWhichIsA("BasePart", true) do
        task.wait()
    end

    local EquipAnimation = CombatUtil:GetWeaponData((CombatUtil:GetWeaponName(p1))).EquipAnimation

    if not (EquipAnimation and EquipAnimation.Unequip) then
        return
    end

    PlayAnimationSequence(p1, EquipAnimation.Unequip)
end

local function runHitDetection(p1) --[[ runHitDetection | Line: 123 | Upvalues: CombatUtil (copy), v15 (ref), v12 (ref) ]]
    CombatUtil:RunHitDetection(p1, v15, v12)
end

local function isWeaponOfNameEquipped(p1, p2) --[[ isWeaponOfNameEquipped | Line: 134 | Upvalues: CombatUtil (copy) ]]
    local EquippedWeapon = p1:FindFirstChild("EquippedWeapon")

    return if EquippedWeapon then CombatUtil:GetWeaponName(EquippedWeapon) == p2 else EquippedWeapon
end

local function getTrueLength(p1) --[[ getTrueLength | Line: 139 ]]
    return p1.Length / (p1:GetAttribute("SpeedMult") or 1)
end

local function playAnim(p1, p2, p3, p4) --[[ playAnim | Line: 143 ]]
    local v1 = p1[p2]

    if not v1 then
        return
    end

    v1:Play(p3 or 0.100000001, p4 or 1, 1 * (v1:GetAttribute("SpeedMult") or 1))

    for v2, v3 in p1 do
        if v3 ~= v1 and v3.Looped then
            v3:Stop(p3)
        end
    end
end

local v28 = nil

local function destroyRelaxedTrove() --[[ destroyRelaxedTrove | Line: 162 | Upvalues: v28 (ref) ]]
    if not v28 then
        return
    end

    v28:Destroy()
    v28 = nil
end

local function startRelaxTimer(p1, p2, p3) --[[ startRelaxTimer | Line: 169 | Upvalues: v28 (ref), Trove (copy), playAnim (copy), v9 (ref), ReplicatedStorage (copy), v13 (ref) ]]
    local v1 = p3 or 2

    if v28 then
        v28:Destroy()
        v28 = nil
    end

    local LocalEquippedWeaponPointer = p1.LocalEquippedWeaponPointer.Value

    if LocalEquippedWeaponPointer then
        v28 = Trove.new()

        local function relax(p1) --[[ relax | Line: 178 | Upvalues: v28 (ref), playAnim (ref) ]]
            if not v28 then
                playAnim(p1, "RelaxedIdle")

                return
            end

            v28:Destroy()
            v28 = nil
            playAnim(p1, "RelaxedIdle")
        end

        local v2 = false
        local v3 = v9

        task.delay(v1, function() --[[ Line: 186 | Upvalues: v9 (ref), v3 (copy), LocalEquippedWeaponPointer (copy), v2 (ref), p2 (copy), v28 (ref), playAnim (ref) ]]
            if not (if LocalEquippedWeaponPointer.Parent == nil then false else true) or (v9 ~= v3 or v2) then
                return
            end

            if v28 then
                v28:Destroy()
                v28 = nil
            end

            playAnim(p2, "RelaxedIdle")
        end)
        v28:Add(LocalEquippedWeaponPointer.AncestryChanged:Connect(function(p1, p2) --[[ Line: 195 | Upvalues: v28 (ref) ]]
            if p2 then
                return
            end

            v28:Destroy()
        end))
        v28:Add(ReplicatedStorage.PlayerDodged.Event:Connect(function() --[[ Line: 201 | Upvalues: v2 (ref), p2 (copy), v28 (ref), playAnim (ref) ]]
            if v2 then
                return
            end

            v2 = true

            if v28 then
                v28:Destroy()
                v28 = nil
            end

            playAnim(p2, "RelaxedIdle")
        end))
        v28:Add(v13:GetPropertyChangedSignal("Jump"):Connect(function() --[[ Line: 208 | Upvalues: v13 (ref), v2 (ref), p2 (copy), v28 (ref), playAnim (ref) ]]
            if not v13.Jump or v2 then
                return
            end

            v2 = true

            if v28 then
                v28:Destroy()
                v28 = nil
            end

            playAnim(p2, "RelaxedIdle")
        end))
    end
end

local function shootGun(p1, p2) --[[ shootGun | Line: 216 | Upvalues: LocalPlayer (copy), CombatUtil (copy), v14 (ref), v1 (copy), CustomCursor (copy), v4 (ref), v16 (ref), v9 (ref), v13 (ref), playAnim (copy), ReplicatedStorage (copy), v26 (ref), v22 (ref), v25 (ref), v21 (ref), v23 (ref), v24 (ref), v27 (ref), startRelaxTimer (copy), MobileUIController (copy) ]]
    local Character = LocalPlayer.Character
    local v12 = CombatUtil:GetWeaponName(p1)
    local v2 = CombatUtil:GetWeaponData(v12)
    local Moveset = v2.Moveset

    if not CombatUtil:CanAttack(Character, v2.WeaponType) then
        return
    end

    local v3 = p1 and p1.Parent and p1.Parent:GetAttribute("AttackSpeedMultiplier") or 1
    local LocalEquippedWeaponPointer = p1.LocalEquippedWeaponPointer.Value
    local v42

    if p2.UserInputType == Enum.UserInputType.Touch then
        local v5, _ = game.GuiService:GetGuiInset()

        v42 = p2.Position + Vector3.new(v5.X, v5.Y, 0)
    else
        v42 = nil
    end

    local v6 = if v42 then CFrame.new(v14.GetMousePoint(v42.X, v42.Y)) else v1.Hit
    local v8 = p1:GetAttribute("IsAutoShooting")
    local v92 = p1:GetAttribute("LocalShotsLeft")

    if v92 < 1 then
        return
    end

    local v10 = v92 - 1
    local v11 = p1:GetAttribute("LocalTotalShots") + 1

    p1:SetAttribute("LocalTotalShots", v11)

    local v122

    if v2.ShootStyle == "Gatling" or v8 then
        v122 = nil
    else
        v122 = (v10 > 0 and v2.ShootInterval or v2.Cooldown) / v3
        v2.ReloadReticle.ReloadTime = v122
        p1.Enabled = false
        p1:SetAttribute("IsReloading_Client", true)
        CustomCursor:PlayReloadAnimation(v2.ReloadReticle)
    end

    v4 = 2
    v16 = os.clock()
    v9 = v9 + 1

    local v142 = v9
    local v15 = CombatUtil:GetLoadedAnimsFor(v12, v13)

    if v15.OffensiveIdle and not p1:GetAttribute("IsAutoShooting") then
        local _Object = v15.OffensiveIdle._Object

        _Object:Play(0)
        _Object.TimePosition = v15.OffensiveIdle.Length / 2
    end

    if if v2.ShootStyle == "Gatling" then true else false then
        if v15.Shoot and not v8 then
            playAnim(v15, "Shoot")
        end
    elseif v15.Shoot then
        playAnim(v15, "Shoot")
    end

    local HitType = v2.HitType
    local v17 = string.gsub(p1.Name, "%s", "")

    if v2.EffectModuleName then
        v17 = v2.EffectModuleName
    end

    local ShootType = v2.ShootType
    local v18 = require(ReplicatedStorage.Modules.CombatUtil.ShootTypes[ShootType])
    local HumanoidRootPart = Character.HumanoidRootPart
    local t = {
        ProjectileSpeed = 1500,
        Type = v17,
        TargetPosition = CombatUtil:GetTargetPosition(HumanoidRootPart.Position, v6.Position, v2.Range),
        HRP = HumanoidRootPart
    }

    t.Seed = math.random((math.floor((workspace:GetServerTimeNow()))))
    t.WeaponModel = LocalEquippedWeaponPointer:GetAttribute("WeaponName")
    t.TapPosition = v42
    t.FireSound = v2.FireSound

    if ShootType ~= "Custom" then
        local v20 = LocalEquippedWeaponPointer:FindFirstChild(LocalEquippedWeaponPointer:GetAttribute("CurrentShootAttachment") or "ShootAttachment", true) or LocalEquippedWeaponPointer:FindFirstChild("ShootAttachment1", true)

        if not v20 then
            p1.Enabled = true
            p1:SetAttribute("IsReloading_Client", nil)

            return
        end

        t.ShootAttachment = v20.Name
        t.origin = v20.WorldPosition
    end

    if v2.BulletSpreadDegree then
        local t2 = {
            Range = v2.Range,
            BulletSpreadCount = v2.BulletSpreadCount or 1,
            BulletSpreadDegree = v2.BulletSpreadDegree,
            Origin = t.origin,
            TargetPosition = t.TargetPosition,
            Seed = t.Seed
        }

        t2.NoSpread = v2.SkipSpreadInterval and (if v11 % v2.SkipSpreadInterval == 0 then true else false)
        t.Angles = CombatUtil:CreateShootAngles(t2)
    end

    if v2.ShootType == "Projectile" then
        t.Stage = 1
        t.Start = CFrame.lookAt(t.origin, t.TargetPosition)
        t.Velocity = t.Start.LookVector * v2.Speed
        t.Shooter = LocalPlayer
    end

    local DamageOverTime = v2.DamageOverTime

    if DamageOverTime then
        t.EffectDuration = DamageOverTime.Interval * DamageOverTime.Iterations
    end

    local v232 = v26 * v22
    local v242 = (v25 * v22 + v26 * v21) % v23

    local function calc() --[[ calc | Line: 356 | Upvalues: v242 (ref), v23 (ref), v232 (copy), v24 (ref), v25 (ref), v26 (ref) ]]
        v242 = (v242 * v23 + v232) % v24
        v25 = math.floor(v242 / v23)
        v26 = v242 - v25 * v23
    end

    v242 = (v242 * v23 + v232) % v24

    local v252 = v242 / v23

    v25 = math.floor(v252)
    v26 = v242 - v25 * v23
    v27 = v27 + 1

    local v262 = v242 / v24 * 16777215

    game.ReplicatedStorage.Remotes.Validator2:FireServer(math.floor(v262), v27)
    v18(t, v2)

    local function idleAfterShoot() --[[ idleAfterShoot | Line: 370 | Upvalues: v9 (ref), v142 (copy), LocalEquippedWeaponPointer (copy), v4 (ref), v16 (ref), playAnim (ref), v15 (copy), startRelaxTimer (ref), p1 (copy) ]]
        if v9 ~= v142 then
            return
        end

        if LocalEquippedWeaponPointer.Parent ~= nil then
            v4 = 2
            v16 = os.clock()
            playAnim(v15, "OffensiveIdle")
            startRelaxTimer(p1, v15)
        end
    end

    if v15.Reload or v15.SmallReload then
        local v272 = task.delay
        local Shoot = v15.Shoot

        v272((Shoot.Length / (Shoot:GetAttribute("SpeedMult") or 1) - 0.05) / v3, function() --[[ Line: 384 | Upvalues: v9 (ref), v142 (copy), LocalEquippedWeaponPointer (copy), v10 (ref), v2 (copy), playAnim (ref), v15 (copy), v14 (ref), t (copy), v4 (ref), v16 (ref), idleAfterShoot (copy) ]]
            if v9 ~= v142 then
                return
            end

            local isNotParent = LocalEquippedWeaponPointer.Parent ~= nil

            if not isNotParent then
                return
            end

            local v1 = "ReloadSound"
            local v22

            if v10 > 0 then
                v22 = "SmallReload"

                if v2.SmallReloadSound then
                    v1 = "SmallReloadSound"
                end
            else
                v22 = "Reload"
            end

            playAnim(v15, v22)

            local v3, v42

            if v2[v1] then
                task.delay(v2.ReloadSoundDelay, function() --[[ Line: 409 | Upvalues: LocalEquippedWeaponPointer (ref), v14 (ref), v2 (ref), v1 (ref), t (ref) ]]
                    if not (LocalEquippedWeaponPointer.Parent ~= nil) then
                        return
                    end

                    v14.Sound:Play(v2[v1], t.HRP)
                end)
            end

            v3 = v15[v22]
            v42 = v3.Length / (v3:GetAttribute("SpeedMult") or 1) - 0.05
            v4 = v42
            v16 = os.clock()
            task.delay(v42, idleAfterShoot)
        end)
    else
        local v28 = task.delay
        local Shoot = v15.Shoot

        v28(Shoot.Length / (Shoot:GetAttribute("SpeedMult") or 1) - 0.05, idleAfterShoot)
    end

    if v2.ShootStyle == "Gatling" or v8 then
        return
    end

    local v29 = nil

    for v30, v31 in LocalPlayer.PlayerGui.Backpack.Hotbar.Container:GetChildren() do
        if v31:GetAttribute("ItemName") == p1.Name then
            v29 = v31

            break
        end
    end

    local v32 = v122 + 0.05

    if v29 then
        task.defer(function() --[[ Line: 440 | Upvalues: MobileUIController (ref), v29 (ref), p1 (copy), v32 (ref) ]]
            MobileUIController:PlayCooldownAnimation(v29, p1.Name, "n/a", v32)
        end)
    end

    task.delay(v32, function() --[[ Line: 445 | Upvalues: v9 (ref), v142 (copy), p1 (copy), v10 (ref), v2 (copy) ]]
        if v9 ~= v142 or not (p1 and p1.Parent) then
            return
        end

        if v10 > 0 then
            p1:SetAttribute("LocalShotsLeft", v10)
        else
            p1:SetAttribute("LocalShotsLeft", v2.MagSize)
        end

        p1.Enabled = true
        p1:SetAttribute("IsReloading_Client", nil)
    end)
end

function attackMelee(p1) --[[ attackMelee | Line: 459 | Upvalues: v13 (ref), v17 (ref), CombatUtil (copy), v10 (copy), v5 (ref), v12 (ref), v4 (ref), v16 (ref), v15 (ref), v11 (copy), v2 (copy), attackStart (copy), runHitDetection (copy), CameraShaker (copy), Main (copy) ]]
    local v1 = v13 and v13.RootPart
    local v22 = if v1 then v1.Parent else v1

    if v17 or _G.mobileSelectionFrame then
        return
    end

    local v3 = CombatUtil:GetMovesetAnimCache(v13)

    if not v3 then
        return
    end

    local v42 = CombatUtil:GetWeaponName(p1)
    local v52 = CombatUtil:GetWeaponData(v42)
    local Moveset = v52.Moveset

    if not CombatUtil:CanAttack(v22, v52.WeaponType) then
        return
    end

    task.defer(function() --[[ Line: 477 | Upvalues: CombatUtil (ref), p1 (copy), v10 (ref) ]]
        CombatUtil:GetWeaponName(p1)

        local LocalEquippedWeaponPointer = p1.LocalEquippedWeaponPointer.Value

        if not LocalEquippedWeaponPointer then
            return
        end

        local v1 = v10[LocalEquippedWeaponPointer]

        if not v1 then
            return
        end

        v1:cancel()
        v10[LocalEquippedWeaponPointer] = nil
    end)

    if v5 and v12 then
        v12:Stop()
    end

    v5 = true
    v4 = 5
    v16 = os.clock()
    v15 = v15 + 1

    if v15 > #Moveset.Basic then
        v15 = 1
    end

    local v6 = v3[CombatUtil:GetPureWeaponName(v42) .. "-basic" .. v15]

    v11.RegisterAttackEvent:FireServer(v6.Length / (v6:GetAttribute("SpeedMult") or 1))

    local v7 = p1 and p1.Parent and p1.Parent:GetAttribute("AttackSpeedMultiplier") or 1

    v6:Play(0.100000001, 1, 1 * (v6:GetAttribute("SpeedMult") or 1) * v7)
    v17 = true
    task.delay(v6.Length / (v6:GetAttribute("SpeedMult") or 1) * v2 / v7, function() --[[ Line: 510 | Upvalues: v17 (ref) ]]
        v17 = false
    end)
    v12 = v6
    task.spawn(attackStart, p1, v15)
    task.spawn(runHitDetection, p1, v52)
    CameraShaker:Shake(Main.Presets.CombatBump)

    local v8 = false

    local function disableTrails() --[[ disableTrails | Line: 521 | Upvalues: v8 (ref), p1 (copy) ]]
        if v8 then
            return
        end

        v8 = true

        local LocalEquippedWeaponPointer = p1.LocalEquippedWeaponPointer.Value

        if not LocalEquippedWeaponPointer then
            return
        end

        for v1, v2 in LocalEquippedWeaponPointer:GetDescendants() do
            if v2:IsA("Trail") then
                v2.Enabled = false
            end
        end
    end

    local v9 = v15
    local v102 = true
    local v112 = nil

    v112 = p1.AncestryChanged:Connect(function() --[[ Line: 542 | Upvalues: v112 (ref), v102 (ref) ]]
        v112:Disconnect()
        v112 = nil
        v102 = false
    end)
    task.delay(0.75, function() --[[ Line: 549 | Upvalues: v102 (ref), v15 (ref), v9 (copy), disableTrails (copy), v12 (ref), v5 (ref), v112 (ref) ]]
        if not v102 or v15 ~= v9 then
            return
        end

        disableTrails()
        v12 = nil
        v5 = false
        v15 = 0

        if not (v112 and v112.Connected) then
            return
        end

        v112:Disconnect()
        v112 = nil
    end)

    if v15 == #Moveset.Basic then
        task.delay(v6.Length / (v6:GetAttribute("SpeedMult") or 1) * 0.7, function() --[[ Line: 563 | Upvalues: v15 (ref), v9 (copy), disableTrails (copy) ]]
            if v15 ~= v9 then
                return
            end

            disableTrails()
        end)
    end
end
function v6.Attack(p1, p2, p3, p4) --[[ Attack | Line: 574 | Upvalues: CombatUtil (copy), LocalPlayer (copy), Trove (copy), v13 (ref), playAnim (copy), startRelaxTimer (copy), CustomCursor (copy), v18 (ref), shootGun (copy) ]]
    local v1 = CombatUtil:GetWeaponName(p2)
    local v2 = CombatUtil:GetWeaponData(v1)
    local WeaponType = v2.WeaponType

    if not CombatUtil:CanAttack(LocalPlayer.Character, WeaponType) then
        return
    end

    if if WeaponType == "Sword" or WeaponType == "Melee" then true elseif WeaponType == "Demon Fruit" then true else false then
        attackMelee(p2)

        return
    end

    if not (if WeaponType == "Gun" then true else false) then
        return
    end

    if CombatUtil:IsGunReloading(p2) or _G.mobileSelection then
        return
    end

    if v2.ShootStyle == "Gatling" then
        local OverheatLimit = v2.OverheatLimit

        if OverheatLimit <= p2:GetAttribute("LocalOverheat") then
            return
        end

        if p2:GetAttribute("IsAutoShooting") then
            return
        end

        local v5 = false
        local v6 = true
        local v7 = Trove.new()

        local function runLowerOverheatLoop() --[[ runLowerOverheatLoop | Line: 609 | Upvalues: p2 (copy), LocalPlayer (ref), CombatUtil (ref), v1 (copy), v13 (ref), playAnim (ref), startRelaxTimer (ref) ]]
            if p2.Parent == LocalPlayer.Character then
                local v12 = CombatUtil:GetLoadedAnimsFor(v1, v13)

                playAnim(v12, "OffensiveIdle")
                startRelaxTimer(p2, v12)
            end

            while true do
                local v2 = task.wait()
                local v3 = p2:GetAttribute("LocalOverheat")

                if not p2.Parent or (v3 <= 0 or p2:GetAttribute("IsAutoShooting")) then
                    break
                end

                p2:SetAttribute("LocalOverheat", (math.max(v3 - v2, 0)))
            end
        end

        local function startOverheat() --[[ startOverheat | Line: 628 | Upvalues: p2 (copy), v2 (copy), CustomCursor (ref), v13 (ref), v18 (ref) ]]
            p2.Enabled = false
            p2:SetAttribute("IsReloading_Client", true)

            local OverheatCooldown = v2.OverheatCooldown
            local v1 = table.clone(v2.ReloadReticle)

            v1.ReloadTime = v2.OverheatCooldown
            CustomCursor:PlayReloadAnimation(v1)
            task.delay(OverheatCooldown, function() --[[ Line: 636 | Upvalues: p2 (ref) ]]
                p2.Enabled = true
                p2:SetAttribute("IsReloading_Client", nil)
            end)

            local v22 = v13 and v13.RootPart

            if not v22 then
                return
            end

            local LocalEquippedWeaponPointer = p2.LocalEquippedWeaponPointer.Value

            if not LocalEquippedWeaponPointer then
                return
            end

            local v3 = LocalEquippedWeaponPointer:FindFirstChild(LocalEquippedWeaponPointer:GetAttribute("CurrentShootAttachment") or "ShootAttachment", true) or LocalEquippedWeaponPointer:FindFirstChild("ShootAttachment1", true)

            if not v3 then
                return
            end

            v18.new("Gun_M1.RequestM1"):play({
                Type = "Dragonstorm",
                OverheatTime = OverheatCooldown,
                origin = v22.Position,
                HRP = v22,
                ShootAttachment = v3.Name
            })
        end

        v7:Add(p3:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 662 | Upvalues: p3 (copy), v6 (ref) ]]
            if p3.UserInputState ~= Enum.UserInputState.End then
                return
            end

            v6 = false
        end))
        v7:Add(p2.AncestryChanged:Connect(function() --[[ Line: 668 | Upvalues: v5 (ref) ]]
            v5 = true
        end))

        local v8 = nil

        v8 = task.spawn(function() --[[ Line: 673 | Upvalues: CombatUtil (ref), LocalPlayer (ref), WeaponType (copy), v5 (ref), v8 (ref) ]]
            repeat
                if not task.wait() then
                    v8 = nil

                    return
                end
            until not CombatUtil:CanAttack(LocalPlayer.Character, WeaponType)

            v5 = true
            v8 = nil
        end)
        v7:Add(function() --[[ Line: 683 | Upvalues: v8 (ref) ]]
            if not v8 then
                return
            end

            task.cancel(v8)
            v8 = nil
        end)
        v7:Add(function() --[[ Line: 690 | Upvalues: p2 (copy), runLowerOverheatLoop (copy) ]]
            p2:SetAttribute("IsAutoShooting", nil)
            task.spawn(runLowerOverheatLoop)
        end)

        local v9 = p2 and p2.Parent and p2.Parent:GetAttribute("AttackSpeedMultiplier") or 1

        task.defer(function() --[[ Line: 701 | Upvalues: p2 (copy), v2 (copy), OverheatLimit (copy), CustomCursor (ref) ]]
            repeat
                task.wait()
            until p2:GetAttribute("IsAutoShooting")

            local BaseCursorRotationSpeed = v2.BaseCursorRotationSpeed

            while p2:GetAttribute("IsAutoShooting") do
                local v1 = game.TweenService:GetValue(p2:GetAttribute("LocalOverheat") / OverheatLimit, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                local BaseCursorRotationSpeed2 = v2.BaseCursorRotationSpeed

                CustomCursor:StepRotate(BaseCursorRotationSpeed2 + (0 - BaseCursorRotationSpeed2) * v1)
                task.wait()
            end

            CustomCursor:ResetRotate()
        end)

        local v10 = v2.Cooldown / v9
        local v11 = false

        for i = 1, 3 do
            shootGun(p2, p3)
            p2:SetAttribute("IsAutoShooting", true)

            local v12 = task.wait(v10)
            local v132 = p2:GetAttribute("LocalOverheat") + v12

            p2:SetAttribute("LocalOverheat", (math.min(v132, OverheatLimit)))

            if OverheatLimit <= v132 then
                v11 = true

                break
            elseif v5 then
                break
            end
        end

        task.spawn(function() --[[ Line: 739 | Upvalues: v11 (ref), v5 (ref), v6 (ref), v7 (copy), startOverheat (copy), v10 (ref), p2 (copy), OverheatLimit (copy), shootGun (ref), p3 (copy) ]]
            if v11 or (v5 or not v6) then
                v7:Destroy()

                if not v11 then
                    return
                end

                startOverheat()

                return
            end

            local v1 = os.clock() - (v10 + 0.00001)
            local v2 = 0

            while true do
                local v3 = p2:GetAttribute("LocalOverheat")
                local v4 = if OverheatLimit <= v3 then true else false

                if v4 or (v5 or not v6) then
                    v7:Destroy()

                    if v4 then
                        startOverheat()
                    end

                    return
                end

                local v52 = os.clock() - v1

                if v10 < v52 then
                    p2:SetAttribute("LocalOverheat", (math.min(v3 + v52, OverheatLimit)))

                    local v72 = v2 + v52
                    local v9 = math.floor(v72 / v10)

                    v2 = v72 % v10

                    local v102 = os.clock()

                    p2:SetAttribute("IsAutoShooting", true)
                    v1 = v102

                    for i = 1, v9 do
                        shootGun(p2, p3)
                    end
                end

                task.wait()
            end
        end)
    else
        shootGun(p2, p3)
    end
end

local function focusAdjust() --[[ focusAdjust | Line: 799 | Upvalues: v13 (ref), v16 (ref), v4 (ref), UserInputService (copy), CurrentCamera (copy), v1 (copy) ]]
    local v12 = v13 and v13.RootPart

    if not v12 or _G.busy then
        return
    end

    local v2 = v13.Parent

    if v4 < os.clock() - v16 or (v13.Sit or (_G.Shiftlock or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)) then
        v13.AutoRotate = true

        return
    end

    v13.AutoRotate = false

    local Position = v12.CFrame.Position

    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        v12.CFrame = CFrame.new(Position, Position + CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1))

        return
    end

    local v42, v5

    if v2:HasTag("TransformedAwakenedBuddha") or v2:HasTag("TransformedBuddha") then
        v42 = 400
        v5 = 25
    else
        v42 = 200
        v5 = 4
    end

    local v6 = CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
    local _, v8 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v6.Origin, v6.Direction * v42), { workspace._WorldOrigin, workspace.Characters, workspace.Enemies })
    local v9 = Vector3.new(v8.X, Position.Y, v8.Z)

    if not ((v9 - Position).Magnitude < v5) then
        v12.CFrame = CFrame.new(Position, v9)
    end
end

function v6.Equip(p1, p2) --[[ Equip | Line: 837 | Upvalues: v7 (ref), v6 (copy), v13 (ref), v8 (ref), Trove (copy), CombatUtil (copy), LocalPlayer (copy), v4 (ref), v16 (ref), playAnim (copy), startRelaxTimer (copy), CustomCursor (copy), LastInput (copy), v14 (ref), v9 (ref), RunService (copy), focusAdjust (copy), v19 (ref), v15 (ref), v20 (ref) ]]
    if v7 then
        v6:Unequip()
    end

    if not v13 then
        return
    end

    if v8 then
        v8:Destroy()
        v8 = nil
    end

    v8 = Trove.new()

    local _ = v13.Parent
    local LocalEquippedWeaponPointer = p2.LocalEquippedWeaponPointer.Value
    local v1 = CombatUtil:GetWeaponName(p2)
    local v2 = CombatUtil:GetWeaponData(v1)
    local Moveset = v2.Moveset

    v8:Add(function() --[[ Line: 857 | Upvalues: CombatUtil (ref), v1 (copy), v13 (ref) ]]
        for v12, v2 in CombatUtil:GetLoadedAnimsFor(v1, v13) do
            v2:Stop()
        end
    end)
    v8:Add(p2.AncestryChanged:Connect(function(p1, p2) --[[ Line: 864 | Upvalues: v8 (ref) ]]
        if p2 then
            return
        end

        v8:Destroy()
        v8 = nil
    end))

    local CameraModule = require(LocalPlayer.PlayerScripts.PlayerModule.CameraModule)

    v8:Add(game.ReplicatedStorage.Events.DeactivatedSkill.Event:Connect(function(p1, p22, p3) --[[ Line: 873 | Upvalues: CombatUtil (ref), p2 (copy), v1 (copy), v13 (ref), v4 (ref), v16 (ref), playAnim (ref), startRelaxTimer (ref) ]]
        if p3 ~= "Gun" or CombatUtil:IsGunReloading(p2) then
            return
        end

        task.wait(1 / 60)

        local v12 = CombatUtil:GetLoadedAnimsFor(v1, v13)

        if p2.Parent:IsA("Backpack") then
            return
        end

        v4 = 3
        v16 = os.clock()
        playAnim(v12, "OffensiveIdle")
        startRelaxTimer(p2, v12, 3)
    end))

    if v2.WeaponType == "Gun" then
        local function reflectToolEnabled() --[[ reflectToolEnabled | Line: 886 | Upvalues: CombatUtil (ref), p2 (copy), LocalPlayer (ref), CustomCursor (ref), v2 (copy) ]]
            local v1 = CombatUtil:IsGunReloading(p2)

            if p2.Parent ~= LocalPlayer.Character then
                CustomCursor:ResetCursorImage()

                return
            end

            CustomCursor:SetCursorImage(v1 and v2.ReloadReticle or v2.Reticle)
        end

        local v3 = CombatUtil:IsGunReloading(p2)
        local isCharacter = p2.Parent == LocalPlayer.Character

        if isCharacter then
            CustomCursor:SetCursorImage(v3 and v2.ReloadReticle or v2.Reticle)
        else
            CustomCursor:ResetCursorImage()
        end

        v8:Add(p2:GetPropertyChangedSignal("Enabled"):Connect(reflectToolEnabled))
        v8:Add(p2:GetAttributeChangedSignal("IsReloading_Client"):Connect(function() --[[ Line: 897 | Upvalues: p2 (copy), LastInput (ref), CombatUtil (ref), LocalPlayer (ref), CustomCursor (ref), v2 (copy) ]]
            if p2:GetAttribute("IsReloading_Client") then
                if LastInput:IsMobile() then
                    return
                end

                local v1 = CombatUtil:IsGunReloading(p2)

                if p2.Parent ~= LocalPlayer.Character then
                    CustomCursor:ResetCursorImage()

                    return
                end

                CustomCursor:SetCursorImage(v1 and v2.ReloadReticle or v2.Reticle)

                return
            end

            local v4 = CombatUtil:IsGunReloading(p2)

            if p2.Parent == LocalPlayer.Character then
                CustomCursor:SetCursorImage(v4 and v2.ReloadReticle or v2.Reticle)

                return
            end

            CustomCursor:ResetCursorImage()
        end))
        v8:Add(p2:GetAttributeChangedSignal("UnequipAutoReloading"):Connect(reflectToolEnabled))
        v8:Add(p2.AncestryChanged:Connect(reflectToolEnabled))

        if CameraModule.activeMouseLockController then
            v8:Add(CameraModule.activeMouseLockController:GetBindableToggleEvent():Connect(reflectToolEnabled))
        end
    end

    local v62 = Moveset.Idle or Moveset.Actions and Moveset.Actions.Idle

    if v62 then
        local v72 = v14.Anims:Get(v13.Parent, v62.AnimationId)

        if v72 then
            v72:Play(0.100000001, 1, 1 * (v62.SpeedMult or 1))
        end

        v8:Add(function() --[[ Line: 922 | Upvalues: v72 (ref) ]]
            if not v72 then
                return
            end

            v72:Stop()
            v72.Animation:Destroy()
            v72 = nil
        end)
    else
        local v82 = CombatUtil:GetLoadedAnimsFor(v1, v13)

        if v82.OffensiveIdle then
            startRelaxTimer(p2, v82)
            task.defer(function() --[[ Line: 935 | Upvalues: v9 (ref), v82 (copy), playAnim (ref), LocalEquippedWeaponPointer (copy) ]]
                local v2

                if v82.Equip then
                    playAnim(v82, "Equip")

                    local v3 = task.wait
                    local Equip = v82.Equip

                    v3(Equip.Length / (Equip:GetAttribute("SpeedMult") or 1) - 0.05)
                    v2 = LocalEquippedWeaponPointer.Parent ~= nil
                else
                    v2 = true
                end

                local v4 = if v82.Equip == nil then false else v9 ~= v9

                if not v2 or (v82.RelaxedIdle and v82.RelaxedIdle.IsPlaying or v4) then
                    return
                end

                playAnim(v82, "OffensiveIdle")
            end)
        else
            playAnim(v82, "RelaxedIdle")
        end
    end

    RunService:BindToRenderStep("CombatFocusAdjust", Enum.RenderPriority.Input.Value, focusAdjust)
    v19 = v2
    v15 = 0
    task.defer(function() --[[ Line: 958 | Upvalues: LocalEquippedWeaponPointer (copy) ]]
        for v1, v2 in LocalEquippedWeaponPointer:GetDescendants() do
            if v2:IsA("Trail") then
                v2.Enabled = false
            end
        end
    end)
    v20 = p2
    v7 = true
end
function v6.Unequip(p1, p2) --[[ Unequip | Line: 969 | Upvalues: v7 (ref), v20 (ref), v8 (ref), v10 (copy), RunService (copy), v13 (ref), CustomCursor (copy), v5 (ref), v12 (ref) ]]
    if not v7 or p2 and p2 ~= v20 then
        return
    end

    if v8 then
        v8:Destroy()
        v8 = nil
    end

    local v1 = v20
    local v2 = v10[v1]

    if not v2 then
        RunService:UnbindFromRenderStep("CombatFocusAdjust")
        v13.AutoRotate = true
        CustomCursor:ResetCursorImage()
        v20 = nil
        v5 = false
        v12 = nil

        return
    end

    v2:cancel()
    v10[v1] = nil
    RunService:UnbindFromRenderStep("CombatFocusAdjust")
    v13.AutoRotate = true
    CustomCursor:ResetCursorImage()
    v20 = nil
    v5 = false
    v12 = nil
end

local function charAdded(p1) --[[ charAdded | Line: 991 | Upvalues: Trove (copy), LocalPlayer (copy), v13 (ref), playEquipAnimation (copy), playUnequipAnimation (copy), CustomCursor (copy) ]]
    local v1 = Trove.new()

    if p1 == LocalPlayer.Character then
        v13 = p1:WaitForChild("Humanoid")
    end

    local function childAdded(p12) --[[ childAdded | Line: 1000 | Upvalues: p1 (copy), LocalPlayer (ref), playEquipAnimation (ref), playUnequipAnimation (ref) ]]
        if p1 == LocalPlayer.Character and (p12.Name == "EquippedWeapon" or p12.Name == "UnequippedWeapon") and not p12:GetAttribute("IsLocal") then
            task.wait()
            p12:Destroy()

            for v1, v2 in p1:GetDescendants() do
                if v2:IsA("Motor6D") and (v2:GetAttribute("WeaponName") == p12:GetAttribute("WeaponName") and not v2:GetAttribute("IsLocal")) then
                    v2:Destroy()
                end
            end

            return
        end

        if p12.Name == "EquippedWeapon" then
            playEquipAnimation(p12)

            return
        end

        if p12.Name ~= "UnequippedWeapon" then
            return
        end

        playUnequipAnimation(p12)
    end

    for v2, v3 in p1:GetChildren() do
        task.defer(childAdded, v3)
    end

    v1:Add(p1.ChildAdded:Connect(childAdded))

    if p1 == LocalPlayer.Character then
        v1:Add(function() --[[ Line: 1026 | Upvalues: CustomCursor (ref) ]]
            CustomCursor:ResetCursorImage()
        end)
    end

    v1:Add(p1.AncestryChanged:Connect(function(p1, p2) --[[ Line: 1031 | Upvalues: v1 (copy) ]]
        if p2 ~= nil then
            return
        end

        v1:Destroy()
    end))
end

function v6.OnStart(p1) --[[ OnStart | Line: 1038 | Upvalues: v14 (ref), v18 (ref), v11 (copy), Net (copy), LocalPlayer (copy), charAdded (copy), v10 (copy), CombatUtil (copy) ]]
    v14 = require(game.ReplicatedStorage.Util)
    v18 = require(game.ReplicatedStorage.Effect)
    v11.RegisterAttackEvent = Net:RemoteEvent("RegisterAttack")
    v11.CancelEquipAnimEvent = Net:RemoteEvent("CancelEquipAnim")
    v11.EquipAnimApplyEndStateEvent = Net:RemoteEvent("EquipAnimApplyEndState")
    v11.VisualEquippedEvent = Net:RemoteEvent("VisualEquipped")
    v11.VisualUnequippedEvent = Net:RemoteEvent("VisualUnequipped")
    v11.ShootGunEvent = Net:RemoteEvent("ShootGunEvent")
    v11.ReceivedHit = Net:RemoteEvent("ReceivedHit")
    v11.PlayAttackStartEffectEvent = Net:RemoteEvent("PlayAttackStartEffect")

    local Character = LocalPlayer.Character

    if Character then
        task.defer(charAdded, Character)
    end

    game.Players.LocalPlayer.CharacterAdded:Connect(charAdded)
    workspace.Characters.ChildAdded:Connect(charAdded)
    workspace.Enemies.ChildAdded:Connect(charAdded)
    v11.CancelEquipAnimEvent.OnClientEvent:Connect(function(p1) --[[ Line: 1064 | Upvalues: v10 (ref) ]]
        local v1 = v10[p1]

        if not v1 then
            return
        end

        v1:cancel()
        v10[p1] = nil
    end)
    v11.ReceivedHit.OnClientEvent:Connect(function(p1, p2, p3, p4, p5) --[[ Line: 1082 | Upvalues: LocalPlayer (ref), CombatUtil (ref) ]]
        if p1 == LocalPlayer.Character then
            CombatUtil:ApplyDamageHighlight(LocalPlayer.Character, p2, p3, p4, p5)

            return
        end

        if p4 ~= "Sword" and p4 ~= "Melee" then
            return
        end

        CombatUtil:PlayMeleeHitParticles(p1, p5, p3)
    end)
    v11.PlayAttackStartEffectEvent.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 1091 | Upvalues: CombatUtil (ref) ]]
        CombatUtil:AttackStart(p2, p3)
    end)
end

return v6
