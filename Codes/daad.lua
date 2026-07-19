-- Script Path: game:GetService("ReplicatedStorage").Controllers.UI.FruitShop
-- Took 0.67s to decompile.
-- Executor: Xeno (v1.3.55)

-- https://lua.expert/
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local React = require(game.ReplicatedStorage.Packages.React)
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)
local Signal = require(game.ReplicatedStorage.Packages.Signal)
local ServiceProxy = require(game.ReplicatedStorage.Packages.ServiceProxy)
local Data = require(script.Data)
local SkippedFruits = require(script.Data.SkippedFruits)
local GiftWindow = require(game.ReplicatedStorage.Controllers.UI.GiftWindow)
local ShopService = require(game.ReplicatedStorage.ShopService)

while not ShopService:GetIfInitialized() do
    task.wait()
end

local PriceService = require(game.ReplicatedStorage.PriceService)
local HookService = require(game.ReplicatedStorage.React.Services.HookService)

while not HookService:GetIfInitialized() do
    task.wait()
end

local AnalyticsClient = require(game.ReplicatedStorage.Controllers.AnalyticsClient)
local StateUtil = require(script.StateUtil)
local LastInput = require(game.ReplicatedStorage.Modules.LastInput)

require(game.ReplicatedStorage.Modules.Util.Trove)

local ColorPalette = require(game.ReplicatedStorage.Util.RichText.ColorPalette)
local Notification = require(game.ReplicatedStorage.Notification)
local SkinUtil = require(game.ReplicatedStorage.Modules.SkinUtil)
local Skins = require(game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Main", (1 / 0)):WaitForChild("UIController"):WaitForChild("Skins"))
local FruitShop = require(game.ReplicatedStorage.React.Components.FruitShop)

require(game.ReplicatedStorage.React.Components.FruitShop.Types)

local LegacyDragonSelectionMenu = require(game.ReplicatedStorage.React.Components.LegacyDragonSelectionMenu)
local LegacyConfirmationDialog = require(game.ReplicatedStorage.React.Components.LegacyConfirmationDialog)
local useLastInput = require(game.ReplicatedStorage.React.Hooks.useLastInput)

local function f1() --[[ Line: 132 | Upvalues: ShopService (copy) ]]
    local t = {}

    for k, v in pairs(ShopService:GetLegacyRobuxItems()) do
        if v.subtype == "Fruit" then
            t[k] = v
        end
    end

    table.freeze(t)

    return t
end

local v2 = f1()
local v3 = ShopService:GetItem("Discounted Permanent Dragon"):unwrap()
local v4 = nil
local CommRemoteFunc = StateUtil.CommRemoteFunc
local DevilFruit = Players.LocalPlayer:WaitForChild("Data"):WaitForChild("DevilFruit")
local v5 = if RunService:IsRunning() then game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") else game:GetService("CoreGui")
local createElement = React.createElement

function getRestockDatetime(p1) --[[ getRestockDatetime | Line: 158 ]]
    local v1 = if p1 == "AdvancedFruitDealer" then 7200 else 14400
    local UnixTimestamp = DateTime.now().UnixTimestamp

    return DateTime.fromUnixTimestamp(UnixTimestamp - UnixTimestamp % v1 + v1)
end
function getFruitsAsync(p1) --[[ getFruitsAsync | Line: 164 | Upvalues: CommRemoteFunc (copy) ]]
    local v4 = CommRemoteFunc:InvokeServer("GetFruits", p1 == "AdvancedFruitDealer")

    assert(typeof(v4) == "table", (("bad result: %*"):format(v4)))

    return v4
end
function getEquippedFruit() --[[ getEquippedFruit | Line: 171 | Upvalues: DevilFruit (copy), SkippedFruits (copy), Data (copy) ]]
    local v1 = DevilFruit.Value

    if table.find(SkippedFruits, v1) then
        return nil
    end

    for k, v in pairs(Data) do
        if k == v1 then
            return v
        end
    end

    if v1:len() == 0 or v1 == " " then
        return nil
    end

    warn((("Unsupported fruit name: \"%*\""):format(v1)))
end
function getOwnedFruitAsync(p1) --[[ getOwnedFruitAsync | Line: 192 | Upvalues: Data (copy) ]]
    local t = {}

    for i, v in ipairs(getFruitsAsync(p1)) do
        if v.HasPermanent then
            local v1 = Data[v.Name]

            if v1 then
                table.insert(t, v1)
            end
        end
    end

    table.freeze(t)

    return t
end
function getLockedFruitAsync(p1) --[[ getLockedFruitAsync | Line: 208 | Upvalues: Data (copy) ]]
    local t = {}

    for i, v in ipairs(getFruitsAsync(p1)) do
        if not v.OnSale then
            local v1 = Data[v.Name]

            if v1 then
                table.insert(t, v1)
            end
        end
    end

    table.freeze(t)

    return t
end
function getBeli() --[[ getBeli | Line: 226 | Upvalues: Players (copy) ]]
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        return 0
    end

    local Data = LocalPlayer:FindFirstChild("Data")

    if not Data then
        return 0
    end

    local Beli = Data:FindFirstChild("Beli")

    if Beli then
        assert(Beli:IsA("IntValue"), "Invalid beli value")

        return Beli.Value
    end

    return 0
end
function promptInvokePermanentPurchaseAsync(p1, p2, p3) --[[ promptInvokePermanentPurchaseAsync | Line: 240 | Upvalues: CommRemoteFunc (copy) ]]
    if p3 and p1.Name == "Dragon-Dragon" then
        CommRemoteFunc:InvokeServer("ClassicDragonGui1", nil)

        return
    end

    local t = {
        StorageName = "Permanent " .. p1.Name
    }

    t.PurchaseLocation = if p2 == "ShopGui" then "FruitShop" else "FruitDealer"
    t.FunnelId = if p2 == "ShopGui" then "Shop" else nil
    CommRemoteFunc:InvokeServer("buyRobuxShop", t)
end
function newDebounce(p1) --[[ newDebounce | Line: 258 ]]
    local v1 = 0

    return function() --[[ Line: 260 | Upvalues: v1 (ref), p1 (copy) ]]
        local v12 = tick()

        if p1 < v12 - v1 then
            v1 = v12

            return true
        end

        return false
    end
end

local t = {}

t.__index = t
function t.Destroy(p1) --[[ Destroy | Line: 274 | Upvalues: v4 (ref) ]]
    if not p1._IsAlive then
        return
    end

    p1._IsAlive = false

    if v4 ~= p1 then
        p1._OnContextChange:Destroy()
        p1._OnOpen:Destroy()
        p1._OnOpenAtFruitChange:Destroy()
        p1.OnClose:Destroy()
        p1._Root:Destroy()
        setmetatable(p1, nil)
        table.clear(p1)

        return
    end

    v4 = nil
    p1._OnContextChange:Destroy()
    p1._OnOpen:Destroy()
    p1._OnOpenAtFruitChange:Destroy()
    p1.OnClose:Destroy()
    p1._Root:Destroy()
    setmetatable(p1, nil)
    table.clear(p1)
end
function t.GetIfInitialized(p1) --[[ GetIfInitialized | Line: 290 | Upvalues: v4 (ref) ]]
    if v4 then
        return v4._IsAlive
    end

    return false
end
function t.Open(p1, p2, p3) --[[ Open | Line: 294 ]]
    if p1.IsOpen then
        return
    end

    local v1 = if p1.ShopContext == p2 then false else true

    p1.ShopContext = p2

    if v1 then
        p1._OnContextChange:Fire(p2)
    end

    p1._OnOpenAtFruitChange:Fire(p3)
    p1.IsOpen = true
    p1._OnOpen:Fire()

    if p1._UID then
        return
    end

    p1:_Open()
end
function t._Open(p1) --[[ _Open | Line: 311 | Upvalues: HookService (copy), t (copy), HttpService (copy), ReactRoblox (copy), React (copy), Players (copy), useLastInput (copy), PriceService (copy), v3 (copy), CollectionService (copy), SkippedFruits (copy), Data (copy), StateUtil (copy), GuiService (copy), LastInput (copy), RunService (copy), DevilFruit (copy), createElement (copy), LegacyConfirmationDialog (copy), ColorPalette (copy), LegacyDragonSelectionMenu (copy), FruitShop (copy), AnalyticsClient (copy), Notification (copy), Skins (copy), SkinUtil (copy), v2 (copy), GiftWindow (copy) ]]
    while not HookService:GetIfInitialized() do
        task.wait()
    end

    assert(t:GetIfInitialized(), "FruitShop not initialized")

    local v22 = HttpService:GenerateGUID(false)

    p1._UID = v22

    local v32 = ReactRoblox.createRoot(p1._Root)
    local v4 = nil
    local v5 = true

    local function cleanUp() --[[ cleanUp | Line: 324 | Upvalues: v5 (ref), p1 (copy), v22 (copy), v4 (ref), v32 (copy) ]]
        if not v5 then
            return
        end

        v5 = false
        p1.OnClose:Fire(p1.ShopContext)

        if v22 == p1._UID then
            p1.IsOpen = false
            p1._UID = nil
            p1._CleanUp = nil
        end

        if not v4 then
            v32:unmount()

            return
        end

        v4:Destroy()
        v32:unmount()
    end

    local v6 = newDebounce(1)

    v32:render(createElement(function(p12) --[[ shopComponent | Line: 343 | Upvalues: React (ref), p1 (copy), Players (ref), useLastInput (ref), PriceService (ref), v3 (ref), CollectionService (ref), SkippedFruits (ref), Data (ref), StateUtil (ref), GuiService (ref), LastInput (ref), RunService (ref), DevilFruit (ref), createElement (ref), LegacyConfirmationDialog (ref), ColorPalette (ref), LegacyDragonSelectionMenu (ref), FruitShop (ref), AnalyticsClient (ref), v5 (ref), v22 (copy), v4 (ref), v32 (copy), v6 (copy), Notification (ref), Skins (ref), SkinUtil (ref), v2 (ref), GiftWindow (ref) ]]
        local v1, v23 = React.useState({})
        local v33, v42 = React.useState(p1.IsOpen)
        local v52, v62 = React.useState(p1.ShopContext)
        local v7, v8 = React.useState(false)
        local v9, v10 = React.useState(getEquippedFruit())
        local v11, v12 = React.useState(table.freeze({}))
        local v13, v14 = React.useState(table.freeze({}))
        local v15, v16 = React.useState(getRestockDatetime(v52))
        local v17, v18 = React.useState(false)
        local v19, v20 = React.useState(false)
        local v21, v222 = React.useState(false)
        local v232, v24 = React.useState(nil)
        local v25, v26 = React.useState(false)
        local v27, v28 = React.useState(false)
        local v29, v30 = React.useState(nil)
        local v31, v322 = React.useState("West")
        local v332, v34 = React.useState(nil)
        local v35, v36 = React.useState(Players.LocalPlayer:HasTag("DiscountedDragonEnabled"))
        local v37, v38 = React.useState(nil)
        local v39 = useLastInput()

        React.useEffect(function() --[[ Line: 367 | Upvalues: p1 (ref), v29 (copy), v30 (copy) ]]
            if p1._IsAlive then
                local v1 = p1._OnOpenAtFruitChange:Connect(function(p1) --[[ Line: 371 | Upvalues: v29 (ref), v30 (ref) ]]
                    if v29 == p1 then
                        return
                    end

                    v30(p1)
                end)

                return function() --[[ Line: 376 | Upvalues: v1 (copy) ]]
                    v1:Disconnect()
                end
            end

            return function() --[[ Line: 369 ]] end
        end, { v29, p1._IsAlive })
        React.useEffect(function() --[[ Line: 381 | Upvalues: PriceService (ref), v3 (ref), v37 (copy), v38 (copy) ]]
            local v1 = PriceService.getPrice(v3.ItemId)

            if v1 == v37 then
                return function() --[[ Line: 386 ]] end
            end

            v38(v1)

            return function() --[[ Line: 386 ]] end
        end, { PriceService:GetIfInitialized() })

        local v40 = React.useMemo(function() --[[ Line: 389 | Upvalues: v1 (copy), v35 (copy), v37 (copy) ]]
            local t = {}

            for k, v in pairs(v1) do
                if v.Name == "Dragon-Dragon" and v35 then
                    local v12 = table.clone(v)

                    if v37 then
                        v12.PermanentRobuxPrice = v37
                    end

                    table.freeze(v12)
                    table.insert(t, v12)

                    continue
                end

                table.insert(t, v)
            end

            return t
        end, { v35, v1, v37 })
        local t = { v13, v40 }

        v13 = React.useMemo(function() --[[ Line: 406 | Upvalues: v40 (copy), v13 (ref) ]]
            local v1 = nil

            for i, v in ipairs(v40) do
                if v.Name == "Dragon-Dragon" then
                    v1 = v

                    break
                end
            end

            v13 = table.clone(v13)

            if not v1 then
                table.freeze(v13)

                return v13
            end

            for i, v in ipairs(v13) do
                if v.Name == "Dragon-Dragon" then
                    v13[i] = v1

                    break
                end
            end

            table.freeze(v13)

            return v13
        end, t)

        local t2 = { v11, v40 }

        v11 = React.useMemo(function() --[[ Line: 427 | Upvalues: v40 (copy), v11 (ref) ]]
            local v1 = nil

            for i, v in ipairs(v40) do
                if v.Name == "Dragon-Dragon" then
                    v1 = v

                    break
                end
            end

            v11 = table.clone(v11)

            if not v1 then
                table.freeze(v11)

                return v11
            end

            for i, v in ipairs(v11) do
                if v.Name == "Dragon-Dragon" then
                    v11[i] = v1

                    break
                end
            end

            table.freeze(v11)

            return v11
        end, t2)

        local t3 = { v9, v13 }

        v9 = React.useMemo(function() --[[ Line: 448 | Upvalues: v9 (ref), v13 (ref) ]]
            if not v9 then
                return
            end

            for i, v in ipairs(v13) do
                if v.Name == v9.Name then
                    return v
                end
            end

            return v9
        end, t3)

        local v41 = if v9 then table.find(v13, v9) == nil else false

        React.useEffect(function() --[[ Line: 470 | Upvalues: CollectionService (ref), Players (ref), v36 (copy) ]]
            local v1 = CollectionService:GetInstanceAddedSignal("DiscountedDragonEnabled"):Connect(function(p1) --[[ Line: 472 | Upvalues: Players (ref), v36 (ref) ]]
                if p1 ~= Players.LocalPlayer then
                    return
                end

                v36(Players.LocalPlayer:HasTag("DiscountedDragonEnabled"))
            end)

            v36(Players.LocalPlayer:HasTag("DiscountedDragonEnabled"))

            return function() --[[ Line: 478 | Upvalues: v1 (copy) ]]
                v1:Disconnect()
            end
        end, {})
        React.useEffect(function() --[[ Line: 483 | Upvalues: p1 (ref), v62 (copy) ]]
            if p1._IsAlive then
                local v1 = p1._OnContextChange:Connect(function(p1) --[[ Line: 487 | Upvalues: v62 (ref) ]]
                    v62(p1)
                end)

                return function() --[[ Line: 490 | Upvalues: v1 (copy) ]]
                    v1:Disconnect()
                end
            end

            return function() --[[ Line: 485 ]] end
        end, { p1._IsAlive })
        React.useEffect(function() --[[ Line: 495 | Upvalues: p1 (ref), v42 (copy) ]]
            if p1._IsAlive then
                local v1 = p1._OnOpen:Connect(function() --[[ Line: 499 | Upvalues: v42 (ref) ]]
                    v42(true)
                end)

                return function() --[[ Line: 502 | Upvalues: v1 (copy) ]]
                    v1:Disconnect()
                end
            end

            return function() --[[ Line: 497 ]] end
        end, { p1._IsAlive })
        React.useEffect(function() --[[ Line: 507 | Upvalues: p1 (ref), v42 (copy) ]]
            if p1._IsAlive then
                local v1 = p1.OnClose:Connect(function() --[[ Line: 511 | Upvalues: v42 (ref) ]]
                    v42(false)
                end)

                return function() --[[ Line: 514 | Upvalues: v1 (copy) ]]
                    v1:Disconnect()
                end
            end

            return function() --[[ Line: 509 ]] end
        end, { p1._IsAlive })
        React.useEffect(function() --[[ Line: 519 | Upvalues: v33 (copy), v52 (copy), SkippedFruits (ref), Data (ref), p1 (ref), v12 (copy), v14 (copy), v23 (copy), StateUtil (ref), v322 (copy) ]]
            local v1 = task.spawn(function() --[[ Line: 520 | Upvalues: v33 (ref), v52 (ref), SkippedFruits (ref), Data (ref), p1 (ref), v12 (ref), v14 (ref), v23 (ref), StateUtil (ref), v322 (ref) ]]
                if not v33 then
                    return
                end

                local v1 = getFruitsAsync(v52)
                local t = {}

                for k, v in pairs(v1) do
                    if not table.find(SkippedFruits, v.Name) then
                        for k2, v2 in pairs(Data) do
                            if k2 == v.Name then
                                table.insert(t, v2)

                                break
                            end
                        end
                    end
                end

                task.spawn(function() --[[ Line: 540 | Upvalues: v52 (ref), p1 (ref), v12 (ref) ]]
                    local v1 = getLockedFruitAsync(v52)

                    if not p1._IsAlive then
                        return
                    end

                    v12(v1)
                end)
                task.spawn(function() --[[ Line: 546 | Upvalues: v52 (ref), p1 (ref), v14 (ref) ]]
                    local v1 = getOwnedFruitAsync(v52)

                    if not p1._IsAlive then
                        return
                    end

                    v14(v1)
                end)
                task.spawn(function() --[[ Line: 552 | Upvalues: p1 (ref), v23 (ref), t (copy) ]]
                    if not p1._IsAlive then
                        return
                    end

                    v23(t)
                end)
                task.spawn(function() --[[ Line: 557 | Upvalues: StateUtil (ref), p1 (ref), v322 (ref) ]]
                    local v1 = StateUtil.getDragonTypeAsync()

                    if not p1._IsAlive then
                        return
                    end

                    v322(v1)
                end)
            end)

            return function() --[[ Line: 566 | Upvalues: v1 (copy) ]]
                task.cancel(v1)
            end
        end, { v33, v52 })
        React.useEffect(function() --[[ Line: 571 | Upvalues: GuiService (ref), LastInput (ref), v33 (copy), p1 (ref) ]]
            local v1 = nil
            local v2 = task.spawn(function() --[[ Line: 573 | Upvalues: GuiService (ref), LastInput (ref), v33 (ref), v1 (ref), p1 (ref) ]]
                local v12 = GuiService

                v12.TouchControlsEnabled = if LastInput:Get() == "Touch" then not v33 else false

                if not v33 then
                    return
                end

                v1 = p1.OnClose:Connect(function() --[[ Line: 577 | Upvalues: GuiService (ref), LastInput (ref) ]]
                    GuiService.TouchControlsEnabled = LastInput:Get() == "Touch"
                end)
            end)

            return function() --[[ Line: 583 | Upvalues: v1 (ref), v2 (copy) ]]
                if v1 then
                    v1:Disconnect()
                end

                task.cancel(v2)
            end
        end, { v33, v39 })
        React.useEffect(function() --[[ Line: 591 | Upvalues: StateUtil (ref), v14 (copy), v52 (copy) ]]
            local v1 = StateUtil.CommRemoteEvent.OnClientEvent:Connect(function(p1, ...) --[[ Line: 592 | Upvalues: v14 (ref), v52 (ref) ]]
                if p1 ~= "ItemChanged" and p1 ~= "ItemRemoved" then
                    return
                end

                v14(getOwnedFruitAsync(v52))
            end)

            return function() --[[ Line: 597 | Upvalues: v1 (copy) ]]
                v1:Disconnect()
            end
        end, {})
        React.useEffect(function() --[[ Line: 603 | Upvalues: RunService (ref), v15 (copy), v12 (copy), v52 (copy), v16 (copy) ]]
            local v1 = RunService.Heartbeat:Connect(function() --[[ Line: 604 | Upvalues: v15 (ref), v12 (ref), v52 (ref), v16 (ref) ]]
                if not (v15.UnixTimestampMillis - DateTime.now().UnixTimestampMillis <= 0) then
                    return
                end

                v12(getLockedFruitAsync(v52))
                v16(getRestockDatetime(v52))
            end)

            return function() --[[ Line: 611 | Upvalues: v1 (copy) ]]
                v1:Disconnect()
            end
        end, { v15 })
        React.useEffect(function() --[[ Line: 616 | Upvalues: DevilFruit (ref), v31 (copy), v322 (copy) ]]
            local function update() --[[ update | Line: 617 | Upvalues: DevilFruit (ref), v31 (ref), v322 (ref) ]]
                local v1 = DevilFruit:GetAttribute("DragonType")

                if v1 ~= "East" and v1 ~= "West" then
                    return
                end

                if v1 == v31 then
                    return
                end

                v322(v1)
            end

            local v1 = DevilFruit:GetAttributeChangedSignal("DragonType"):Connect(update)
            local v2 = DevilFruit:GetAttribute("DragonType")

            if (v2 == "East" or v2 == "West") and v2 ~= v31 then
                v322(v2)
            end

            return function() --[[ Line: 627 | Upvalues: v1 (copy) ]]
                v1:Disconnect()
            end
        end, { DevilFruit:GetAttribute("DragonType") })
        React.useEffect(function() --[[ Line: 632 | Upvalues: v9 (ref), v10 (copy), v52 (copy), v14 (copy), DevilFruit (ref) ]]
            local function update() --[[ update | Line: 633 | Upvalues: v9 (ref), v10 (ref), v52 (ref), v14 (ref) ]]
                local v1 = getEquippedFruit()

                if v9 ~= v1 then
                    v10(v1)
                end

                local v2 = getOwnedFruitAsync(v52)

                if not table.isfrozen(v2) then
                    table.freeze(v2)
                end

                v14(v2)
            end

            local v1 = DevilFruit:GetPropertyChangedSignal("Value"):Connect(update)

            task.spawn(update)

            return function() --[[ Line: 648 | Upvalues: v1 (copy) ]]
                v1:Disconnect()
            end
        end, { DevilFruit.Value })
        require(game.ReplicatedStorage.Controllers.UI.EasterCodex.EasterNetwork).GetData()

        local t5 = {}

        t5.WarningDialog = if v232 then createElement(LegacyConfirmationDialog, {
    Title = "WARNING",
    ConfirmText = "Continue",
    CancelText = "Cancel",
    Body = (function() --[[ Line: 660 | Upvalues: ColorPalette (ref), v232 (copy) ]]
        local v2 = ColorPalette.Red:ToHex():upper()
        local v3 = if v232.Equipped then v232.Equipped else nil
        local v4 = ColorPalette.Green:ToHex():upper()

        return ("This will replace your current <font color=\"#%*\">&lt;%*&gt;</font> Blox Fruit for <font color=\"#%*\">&lt;%*&gt;</font>.\n \nAre you sure you want to continue?"):format(v2, v3, v4, if v232.Selection then v232.Selection else nil)
    end)(),
    OnCloseComplete = function() --[[ OnCloseComplete | Line: 674 | Upvalues: v24 (copy) ]]
        print("complete dialog close")
        v24(nil)
    end,
    OnResponse = function(p1) --[[ OnResponse | Line: 678 | Upvalues: v232 (copy) ]]
        print("responded", p1)

        if not p1 then
            return
        end

        v232.Method()
    end
}) else nil
        t5.DragonSelectionMenu = if v17 or v25 then createElement(LegacyDragonSelectionMenu, {
    IsQuick = false,
    IsEastEnabled = true,
    IsWestEnabled = true,
    IsOpen = v17,
    IsControllerActive = v17 or v25,
    OnSelectionClick = function(p1) --[[ OnSelectionClick | Line: 697 | Upvalues: v27 (copy), StateUtil (ref), v52 (copy), v18 (copy), v26 (copy) ]]
        if p1 then
            print((("click %*"):format(p1)))

            if v27 then
                if not StateUtil.tryInvokeTemporaryPurchaseAsync("Dragon-Dragon", v52) then
                    StateUtil.notifyError("Can\'t afford fruit")
                end
            else
                local v1, v2 = StateUtil.tryEquipFruit("Dragon-Dragon", p1)

                if not v1 then
                    StateUtil.notifyError(v2 or "Failed to equip permanent fruit")
                end
            end
        end

        v18(false)
        v26(true)
    end,
    OnCloseComplete = function() --[[ OnCloseComplete | Line: 714 | Upvalues: v26 (copy) ]]
        print("Closed")
        v26(false)
    end
}) else nil

        local t6 = {
            OnEggClick = nil,
            IsVisible = v33,
            Fruits = v40,
            Owned = v13,
            Equipped = v9,
            Locked = v11,
            OpenAtFruit = v29
        }

        t6.IsControllerActive = not (if v17 then v17 elseif v25 then v25 elseif v232 then v232 elseif v19 then v19 else v21)
        function t6.OnCardClick(p1, p2) --[[ OnCardClick | Line: 738 | Upvalues: v34 (copy), v332 (copy), v7 (copy), v8 (copy), AnalyticsClient (ref) ]]
            if p2 then
                v34(p1)
            elseif v332.Name == p1.Name then
                v34(nil)
            end

            if not p2 or v7 then
                return
            end

            v8(true)
            AnalyticsClient:ReportShoppingStep({
                funnelId = "Shop",
                purchaseLocation = "FruitShop",
                step = 2,
                storageName = p1.Name
            })
        end
        t6.CurrentDragonSwapType = v31
        function t6.OnExitClick() --[[ OnExitClick | Line: 755 | Upvalues: v5 (ref), p1 (ref), v22 (ref), v4 (ref), v32 (ref) ]]
            if not v5 then
                return
            end

            v5 = false
            p1.OnClose:Fire(p1.ShopContext)

            if v22 == p1._UID then
                p1.IsOpen = false
                p1._UID = nil
                p1._CleanUp = nil
            end

            if v4 then
                v4:Destroy()
            end

            v32:unmount()
        end
        function t6.OnPermPurchaseClick(p1) --[[ OnPermPurchaseClick | Line: 758 | Upvalues: v6 (ref), v13 (ref), v52 (copy), v14 (copy), v35 (copy), v41 (copy), v9 (ref), v24 (copy), v28 (copy), v18 (copy), StateUtil (ref) ]]
            if not v6() then
                return
            end

            if table.find(v13, p1) then
                local function equip() --[[ equip | Line: 789 | Upvalues: p1 (copy), v28 (ref), v18 (ref), StateUtil (ref) ]]
                    if p1.Name == "Dragon-Dragon" then
                        v28(false)
                        v18(true)

                        return
                    end

                    local v1, v2 = StateUtil.tryEquipFruit(p1.Name)

                    if v1 then
                        return
                    end

                    StateUtil.notifyError(v2 or "Failed to equip permanent fruit")
                end

                if v41 then
                    local freeze = table.freeze
                    local t = {
                        Method = equip
                    }

                    t.Equipped = if v9 then v9.DisplayName or nil else nil
                    t.Selection = p1.DisplayName
                    v24(freeze(t))
                else
                    if p1.Name == "Dragon-Dragon" then
                        v28(false)
                        v18(true)

                        return
                    end

                    local v3, v4 = StateUtil.tryEquipFruit(p1.Name)

                    if v3 then
                        return
                    end

                    StateUtil.notifyError(v4 or "Failed to equip permanent fruit")
                end
            else
                local function purchase() --[[ purchase | Line: 763 | Upvalues: v52 (ref), v14 (ref), p1 (copy), v35 (ref) ]]
                    local v1 = getOwnedFruitAsync(v52)

                    if not table.isfrozen(v1) then
                        table.freeze(v1)
                    end

                    v14(v1)

                    for i, v in ipairs(v1) do
                        if v.Name == p1.Name then
                            return
                        end
                    end

                    promptInvokePermanentPurchaseAsync(p1, v52, v35)
                end

                if not v41 or v9 and (not v9 or v9.Name == p1.Name) then
                    purchase()

                    return
                end

                local freeze = table.freeze
                local t = {
                    Method = purchase
                }

                t.Equipped = v9 and v9.DisplayName or nil
                t.Selection = p1.DisplayName
                v24(freeze(t))
            end
        end
        t6.OnTempPurchaseClick = if v52 == "ShopGui" then nil else function(p1) --[[ Line: 812 | Upvalues: v6 (ref), StateUtil (ref), v28 (copy), v18 (copy), v52 (copy), v41 (copy), v232 (copy), v24 (copy), v9 (ref) ]]
    if not v6() then
        return
    end

    local function purchase() --[[ purchase | Line: 816 | Upvalues: p1 (copy), StateUtil (ref), v28 (ref), v18 (ref), v52 (ref) ]]
        if p1.Name == "Dragon-Dragon" then
            if p1.Price > getBeli() then
                StateUtil.notifyError("Can\'t afford fruit")
            else
                v28(true)
                v18(true)
            end
        else
            if StateUtil.tryInvokeTemporaryPurchaseAsync(p1.Name, v52) then
                return
            end

            StateUtil.notifyError("Can\'t afford fruit")
        end
    end

    print("setting post dialog callback", v41, v232)

    if not v41 then
        purchase()

        return
    end

    local freeze = table.freeze
    local t = {
        Method = purchase
    }

    t.Equipped = if v9 then v9.DisplayName or nil else nil
    t.Selection = p1.DisplayName
    v24(freeze(t))
end
        function t6.OnDragonSwapClick() --[[ OnDragonSwapClick | Line: 847 | Upvalues: Players (ref), StateUtil (ref), Notification (ref), v6 (ref), v31 (copy), v322 (copy) ]]
            local Character = Players.LocalPlayer.Character

            if Character and StateUtil.getIfTransformed(Character) then
                Notification.new("You can\'t swap fruits while transformed", 5):Display()

                return
            end

            if not v6() then
                return
            end

            local v1 = if StateUtil.getDragonTypeAsync() == "East" then "West" else "East"

            if v1 == v31 or not StateUtil.tryEquipFruit("Dragon-Dragon", v1) then
                return
            end

            v322(v1)
        end
        function t6.OnMutationClick(p1) --[[ OnMutationClick | Line: 869 | Upvalues: v6 (ref), Skins (ref), v222 (copy), SkinUtil (ref), StateUtil (ref) ]]
            if not v6() then
                return
            end

            if Skins:IsOpen() then
                return
            end

            print((("on mutation click purchased %*"):format(p1.Name)))
            v222(true)

            if SkinUtil.FruitMutations.isBaseFruit(p1.Name) then
                Skins:Open({
                    SelectedCategory = "FruitMutation",
                    SelectedFruit = p1.Name
                })
                task.spawn(function() --[[ Line: 885 | Upvalues: Skins (ref), v222 (ref) ]]
                    Skins:WaitForClose()
                    v222(false)
                end)
            else
                StateUtil.notifyError("Invalid mutation")
            end
        end
        function t6.OnGiftClick(p1) --[[ OnGiftClick | Line: 893 | Upvalues: v6 (ref), v20 (copy), v4 (ref), v2 (ref), GiftWindow (ref), v52 (copy), StateUtil (ref) ]]
            if not v6() then
                return
            end

            print((("on gift click purchased %*"):format(p1.Name)))
            v20(true)

            if v4 then
                v4:Destroy()
            end

            local v1 = v2[p1.Name]

            if not v1 then
                StateUtil.notifyError("Invalid gift")

                return
            end

            local t = {
                onClose = function() --[[ onClose | Line: 905 | Upvalues: v20 (ref), v4 (ref) ]]
                    v20(false)

                    if not v4 then
                        return
                    end

                    v4:Destroy()
                end,
                shopData = v1
            }

            t.purchaseLocation = if v52 == "ShopGui" then "FruitShop" else "FruitDealer"
            v4 = GiftWindow:Open(t)
        end
        t6.FruitReleaseDate = if v52 == "ShopGui" then nil else v15
        t5.Shop = createElement(FruitShop, t6, {})

        return createElement(React.Fragment, {}, t5)
    end, {}, {}))
    p1._CleanUp = cleanUp
end
function t._Close(p1) --[[ _Close | Line: 935 ]]
    if not p1._CleanUp then
        return
    end

    p1._CleanUp()
    p1._CleanUp = nil
end
function t.Close(p1) --[[ Close | Line: 942 ]]
    if p1.IsOpen then
        p1.IsOpen = false
        p1.OnClose:Fire(p1.ShopContext)
    end
end
function t.init() --[[ init | Line: 950 | Upvalues: t (copy), v5 (copy), Signal (copy), v4 (ref) ]]
    t:GetIfInitialized()

    local FruitShopAndDealer = Instance.new("ScreenGui")

    FruitShopAndDealer.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    FruitShopAndDealer.ScreenInsets = Enum.ScreenInsets.None
    FruitShopAndDealer.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None
    FruitShopAndDealer.IgnoreGuiInset = true
    FruitShopAndDealer.Name = "FruitShopAndDealer"
    FruitShopAndDealer.Parent = v5
    FruitShopAndDealer.Enabled = false
    FruitShopAndDealer.ResetOnSpawn = false

    local v2 = setmetatable({
        _CleanUp = nil,
        _UID = nil,
        _IsAlive = true,
        IsOpen = false,
        ShopContext = "ShopGui",
        _Root = FruitShopAndDealer,
        _OnOpenAtFruitChange = Signal.new(),
        _OnContextChange = Signal.new(),
        _OnOpen = Signal.new(),
        OnClose = Signal.new()
    }, t)
    local v3 = v4

    v4 = v2

    if not v3 then
        v2:_Open()

        return function() --[[ Line: 987 | Upvalues: v2 (copy) ]]
            v2:Destroy()
        end
    end

    v3:Destroy()
    v2:_Open()

    return function() --[[ Line: 987 | Upvalues: v2 (copy) ]]
        v2:Destroy()
    end
end

return ServiceProxy(function() --[[ Line: 992 | Upvalues: v4 (ref), t (copy) ]]
    return v4 or t
end)
