local cloneref = cloneref or (function(...) return ... end)

local delfolder = delfolder or deletefolder
local delfile = delfile or deletefile
local makefolder = makefolder
local writefile = writefile
local readfile = readfile

local services = setmetatable({}, {
    __index = function(t, k)
        rawset(t, k, cloneref(game:GetService(k)))
        return rawget(t, k)
    end
})

local MarketplaceService = services.MarketplaceService
local UserInputService = services.UserInputService
local TweenService = services.TweenService
local HttpService = services.HttpService
local RunService = services.RunService
local Players = services.Players

local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CoreGui = (gethui or function() return services.CoreGui end)()

-- ==========================================================
-- TEMA ESTILOSO - DARK & RED CYBERPUNK
-- ==========================================================
local ConfigTheme = {
    Darker = {
        Colors = {
            Background = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(12, 10, 11)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(18, 12, 13)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(12, 10, 11))
            },
            Primary = Color3.fromRGB(255, 30, 60), -- Vermelho Neon Ultra Vibrante
            OnPrimary = Color3.fromRGB(110, 10, 22), -- Vermelho Escuro/Vinho
            ScrollBar = Color3.fromRGB(200, 25, 45),
            Stroke = Color3.fromRGB(45, 18, 20), -- Borda sutil avermelhada escura

            Error = Color3.fromRGB(255, 40, 40),
            Icons = Color3.fromRGB(245, 245, 245),

            JoinButton = Color3.fromRGB(255, 30, 60),
            Link = Color3.fromRGB(255, 75, 100),

            Dialog = {
                Background = Color3.fromRGB(16, 12, 13)
            },
            Buttons = {
                Holding = Color3.fromRGB(38, 18, 20),
                Default = Color3.fromRGB(24, 15, 17)
            },
            Border = {
                Holding = Color3.fromRGB(90, 25, 30),
                Default = Color3.fromRGB(35, 18, 20),
            },
            Text = {
                Default = Color3.fromRGB(255, 255, 255),
                Dark = Color3.fromRGB(210, 200, 200),
                Darker = Color3.fromRGB(165, 150, 150),
            },
            Slider = {
                SliderBar = Color3.fromRGB(255, 30, 60),
                SliderNumber = Color3.fromRGB(255, 255, 255),
            },
            Dropdown = {
                Holder = Color3.fromRGB(20, 12, 13),
            }
        },
        Icons = {
            Error = "rbxassetid://10709752996",
            Button = "rbxassetid://10709791437",
            Close = "rbxassetid://10747384394",
            TextBox = "rbxassetid://15637081879",
            Search = "rbxassetid://10734943674",
            Keybind = "rbxassetid://10734982144",
            Dropdown = {
                Open = "rbxassetid://10709791523",
                Close = "rbxassetid://10709790948"
            }
        },
        Font = {
            Normal = Enum.Font.BuilderSans,
            Medium = Enum.Font.BuilderSansMedium,
            Bold = Enum.Font.BuilderSansBold,
            ExtraBold = Enum.Font.BuilderSansExtraBold,
            SliderValue = Enum.Font.FredokaOne
        },
        BackgroundTransparency = 0.05
    }
}

for s, t in ConfigTheme do
    t.Name = s
    table.freeze(t)
end

local Library = {
    Information = {
        Version = "v2.0.1",
        GitHubOwner = "tlredz"
    },
    Default = {
        Theme = "Darker",
        UISize = UDim2.fromOffset(560, 390),
        TabSize = 165
    },

    Themes = ConfigTheme,
    Connections = {},
    Options = {},
    Tabs = {},

    FarmStatusColors = {
        Running = "#FF1E3C", -- Vermelho Neon para indicar ativo/rodando
        Waiting = "#F0AD4E",
        Need = "#D9534F"
    }
}

-- ==========================================================
-- Sistema de Tradução Interna
-- ==========================================================
local function Localize(aText)
    if type(aText) ~= "string" or aText == "" then
        return aText
    end
    local aPack = Library.Translations[Library.Locale]
    return (aPack and aPack[aText]) or aText
end

Library.Locale = "en"
Library.Translations = {}
Library.LocalizedLabels = {}

function Library:AddTranslations(aLocale, aTable)
    assert(type(aLocale) == "string", "Library.AddTranslations: locale precisa ser string")
    assert(type(aTable) == "table", "Library.AddTranslations: translations precisa ser uma table")
    self.Translations[aLocale] = self.Translations[aLocale] or {}
    for aKey, aValue in aTable do
        self.Translations[aLocale][aKey] = aValue
    end
end

function Library:UpdateTranslate(aLocale)
    if aLocale then
        self.Locale = aLocale
    end
    for aIndex = #self.LocalizedLabels, 1, -1 do
        local aEntry = self.LocalizedLabels[aIndex]
        if aEntry.Instance and aEntry.Instance.Parent then
            aEntry.Instance.Text = Localize(aEntry.Original)
        else
            table.remove(self.LocalizedLabels, aIndex)
        end
    end
end

Library.SetLocale = Library.UpdateTranslate

function Library:Translate(aTemplate, ...)
    assert(type(aTemplate) == "string", "Library.Translate: template precisa ser string")
    local aTranslatedTemplate = Localize(aTemplate)
    if select("#", ...) > 0 then
        local aOk, aResult = pcall(string.format, aTranslatedTemplate, ...)
        if aOk then
            return aResult
        end
        local aOk2, aResult2 = pcall(string.format, aTemplate, ...)
        return aOk2 and aResult2 or aTranslatedTemplate
    end
    return aTranslatedTemplate
end

Library.Info = Library.Information
Library.Save = Library.Default

function Library:SetFarmStatusColor(aName, aHex)
    assert(type(aName) == "string", "Library.SetFarmStatusColor: 'name' precisa ser string")
    assert(type(aHex) == "string", "Library.SetFarmStatusColor: 'hex' precisa ser string (ex: '#FF1E3C')")
    self.FarmStatusColors[aName] = aHex
end

local ViewportSize = workspace.CurrentCamera.ViewportSize
local function ConnectEvent(obj, callback, name)
    table.insert(Library.Connections, obj[name or "Connect"](obj, callback))
end

-- ==========================================================
-- Render Engine
-- ==========================================================
local RenderClass = {}
RenderClass.__index = RenderClass

local function FetchPropertyValue(theme, path)
    for segment in path:gmatch("[^%.]+") do
        theme = theme[segment]
    end
    return theme
end

local function SetPropertyTheme(obj, prop, path, targetTheme)
    if not targetTheme then
        targetTheme = Library.CurrentTheme
    end
    obj[prop] = FetchPropertyValue(targetTheme, if type(path) == "function" then path() else path)
end

local function ApplyThemeProperties(targetTheme, obj, properties)
    for prop, path in properties do
        SetPropertyTheme(obj, prop, path, targetTheme)
    end
end

local IsDraggingAny = false
local ThemeScales = {
    MAX_SCALE = 1.6,
    MIN_SCALE = 0.6,
    TEXTBOX = {
        PLACEHOLDER_TEXT = "Input..."
    }
}

function RenderClass:add(obj, properties)
    self.Descendants[properties] = obj
    if self.IS_RENDERING then
        ApplyThemeProperties(Library.CurrentTheme, obj, properties)
    end
end

function RenderClass:update()
    if self.IS_RENDERING and not self.UPDATED_OBJECTS then
        local current = Library.CurrentTheme
        self.UPDATED_OBJECTS = true
        for obj, properties in self.Descendants do
            local t = typeof(properties)
            if t == "table" then
                properties:update()
                continue
            end
            ApplyThemeProperties(current, obj, properties)
        end
    end
end

function RenderClass:destroy()
    local index = self.Parent and table.find(self.Parent.Descendants, self)
    if index then
        table.remove(self.Parent.Descendants, index)
    end
    table.clear(self.Descendants)
    setmetatable(self, nil)
end

function RenderClass:changeRendering(state)
    if self.IS_RENDERING ~= state then
        self.IS_RENDERING = state
        self.UPDATED_OBJECTS = false
    end
end

function RenderClass:new()
    local instance = setmetatable({
        IS_RENDERING = true,
        UPDATED_OBJECTS = false,
        Descendants = {},
        Parent = self.Descendants ~= nil and self or nil
    }, RenderClass)
    if self.Descendants then
        table.insert(self.Descendants, instance)
    end
    return instance
end

local MasterRender = RenderClass:new()
local UI = {}
local CreateInstance

do
    local Templates = {}
    local Helpers = {}

    Helpers.ElementsTable = {
        Corner = function(rad)
            return CreateInstance("UICorner", {
                CornerRadius = rad or UDim.new(0, 8)
            })
        end,
        Stroke = function(color, thick)
            return CreateInstance("UIStroke", {
                Color = color or Color3.fromRGB(45, 18, 20),
                Thickness = thick or 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })
        end,
        Image = function(id)
            return CreateInstance("ImageLabel", {
                Image = id or "",
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            })
        end,
        Button = function()
            return CreateInstance("TextButton", {
                Text = "",
                Size = UDim2.fromScale(1, 1),
                AutoButtonColor = false
            })
        end,
        Padding = function(left, right, top, bottom)
            return CreateInstance("UIPadding", {
                PaddingLeft = left or UDim.new(0, 10),
                PaddingRight = right or UDim.new(0, 10),
                PaddingTop = top or UDim.new(0, 10),
                PaddingBottom = bottom or UDim.new(0, 10)
            })
        end,
        ListLayout = function(pad)
            return CreateInstance("UIListLayout", {
                Padding = pad or UDim.new(0, 6)
            })
        end,
        Text = function(str)
            return CreateInstance("TextLabel", {
                BackgroundTransparency = 1,
                Text = str or ""
            })
        end,
        Gradient = function(seq)
            return CreateInstance("UIGradient", {
                Color = seq
            })
        end
    }

    function Helpers:Create(parent, elType, ...)
        local creator = self.ElementsTable[elType]
        if creator then
            local obj = creator(...)
            obj.Parent = parent
            return obj
        end
    end

    local CustomProperties = {}

    function CustomProperties:Childs(list)
        for i = 1, #list do
            list[i].Parent = self
        end
    end

    function CustomProperties:Elements(dict)
        for el, config in pairs(dict) do
            if type(config) == "table" then
                UI.SetProperties(Helpers:Create(self, el), config)
            else
                Helpers:Create(self, el, config)
            end
        end
    end

    function CustomProperties:ThemeTag(properties)
        local customRender = properties.OBJECTS
        properties.OBJECTS = nil
        return (customRender or MasterRender):add(self, properties)
    end

    function UI.SetProperties(obj, properties)
        for prop, val in pairs(properties) do
            if CustomProperties[prop] then
                CustomProperties[prop](obj, val)
            else
                obj[prop] = val
            end
        end
    end

    function UI.SetValues(obj, ...)
        local current = obj
        for _, entry in { ... } do
            local t = typeof(entry)
            if t == "table" then
                UI.SetProperties(current, entry)
            else
                current[if t == "string" then "Name" else "Parent"] = entry
            end
        end
        return current
    end

    local ActiveDragWindow
    function UI:Draggable(uiScale, smoothFactor, boundFunc)
        local startPos, dragStart, originalPos, updateConnection
        smoothFactor = smoothFactor or 0.25
        local lastUpdate = 0

        local function UpdateDrag(input)
            local delta = input.Position - dragStart
            lastUpdate = tick()
            local targetPos
            if boundFunc then
                targetPos = boundFunc(
                    originalPos.X.Scale, originalPos.X.Offset + delta.X / uiScale.Scale,
                    originalPos.Y.Scale, originalPos.Y.Offset + delta.Y / uiScale.Scale
                )
            else
                targetPos = UDim2.new(
                    originalPos.X.Scale, originalPos.X.Offset + delta.X / uiScale.Scale,
                    originalPos.Y.Scale, originalPos.Y.Offset + delta.Y / uiScale.Scale
                )
            end
            self.Position = self.Position:Lerp(targetPos, smoothFactor)
        end

        local function StopDrag()
            while ActiveDragWindow == self do
                if (tick() - lastUpdate) >= 1 then
                    IsDraggingAny = false
                    ActiveDragWindow = nil
                    updateConnection:Disconnect()
                    break
                end
                task.wait()
            end
        end

        local ValidInputs = {
            [Enum.UserInputType.MouseButton1] = true,
            [Enum.UserInputType.Touch] = true
        }
        local DragMoveInputs = {
            [Enum.UserInputType.MouseMovement] = true,
            [Enum.UserInputType.Touch] = true
        }

        ConnectEvent(self.InputBegan, function(input)
            if IsDraggingAny == false and ActiveDragWindow == nil and ValidInputs[input.UserInputType] then
                dragStart = input.Position
                originalPos = self.Position
                ActiveDragWindow = self
                lastUpdate = tick()
                IsDraggingAny = true

                local disconnectDrag
                function disconnectDrag()
                    IsDraggingAny = false
                    ActiveDragWindow = nil
                    updateConnection:Disconnect()
                end

                task.spawn(StopDrag)
                updateConnection = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        disconnectDrag()
                    end
                end)
            end
        end)

        ConnectEvent(UserInputService.InputChanged, function(input)
            if ActiveDragWindow == self and DragMoveInputs[input.UserInputType] then
                UpdateDrag(input)
            end
        end)
    end

    function UI:CreateNewTemplate(parent)
        return UI.CloneObject(Templates[self], parent)
    end

    function UI.new(className, ...)
        return UI.SetValues(Instance.new(className), ...)
    end

    CreateInstance = UI.new
end

local function GetCallback(func)
    if func == nil then
        return {}
    end
    if type(func) ~= "function" and type(func) ~= "table" then
        error(`Falha no Callback: esperado 'function' ou 'table', obteve {typeof(func)}`, 2)
    end
    if type(func) ~= "function" then
        local target = func[1]
        local key = func[2]
        func = function(val)
            target[key] = val
        end
    end
    return table.pack(func)
end

local function TriggerCallbacks(list, ...)
    for i = 1, #list do
        task.spawn(list[i], ...)
    end
end

local UI_FolderName = "redz-library-v5"
local TargetScreenGui = CoreGui:FindFirstChild(UI_FolderName)

if not TargetScreenGui then
    TargetScreenGui = CreateInstance("ScreenGui", UI_FolderName, CoreGui, {
        IgnoreGuiInset = true
    })
end

local function Tween(obj, prop, value, dur, style, ...)
    local info = TweenInfo.new(dur, style or Enum.EasingStyle.Quint, ...)
    return TweenService:Create(obj, info, { [prop] = value })
end

local function BuildCharMap(str)
    local map = {}
    local split = string.split(str, "")
    for i = 1, #split do
        rawset(map, split[i], true)
    end
    return map
end

local IgnoredChars = BuildCharMap("\n\t,_:;()[]#&=!. \"'*^<>$")
local function CleanString(str)
    return string.gsub(str:lower(), ".", function(char)
        return IgnoredChars[char] and "" or char
    end)
end

local function FormatNumber(num)
    local str, result, count = tostring(num), "", 0
    for i = #str, 1, -1 do
        result = str:sub(i, i) .. result
        count += 1
        if i > 1 and count % 3 == 0 then
            result = "," .. result
        end
    end
    return result
end

local function IsAssetId(str)
    return str:sub(1, 13) == "rbxassetid://"
end

local function ScaleToViewport(val)
    return (ViewportSize.Y / 450) * val
end

local function FormatTime(secs)
    local mins = math.floor(secs / 60)
    local hrs = math.floor(secs / 3600)
    secs = math.floor((secs - (mins * 60)) * 10) / 10
    mins = mins - (hrs * 60)

    if hrs > 0 then
        return `{hrs}h {mins}m {math.floor(secs)}s`
    elseif mins > 0 then
        return `{mins}m {math.floor(secs)}s`
    else
        return tostring(secs)
    end
end

-- ==========================================================
-- INTERFACES & CLASSES INTERNAS (Estilização Moderna)
-- ==========================================================
local LibraryWindow = {}
do
    local TabsList = {}
    local TabConnections = {}
    local TabDropdowns = {}
    local TabFlags = {}

    local DropdownMasterPanel
    local MainFrameObj
    local NotificationArea
    local DialogPanel
    local DialogContainer
    local ScalerObject
    local FlagStorage
    local GlobalNotificationDefaultIcon = ""

    local WindowClass = { SelectedTab = 1, Minimized = false }
    WindowClass.__index = WindowClass

    local MinimizerClass = {}
    MinimizerClass.__index = MinimizerClass

    local ComponentMethods = {}
    ComponentMethods.__index = ComponentMethods

    local TabMethods = {}
    TabMethods.__index = TabMethods

    local ComponentClasses = {}
    do
        local function BuildSubclass()
            local sc = {}
            sc.__index = function(tbl, key)
                return sc[key] or rawget(ComponentMethods, key)
            end
            return sc
        end

        ComponentClasses.TextBox = BuildSubclass()
        ComponentClasses.Toggle = BuildSubclass()
        ComponentClasses.Slider = BuildSubclass()
        ComponentClasses.Dropdown = BuildSubclass()
        ComponentClasses.Keybind = BuildSubclass()
        ComponentClasses.Dialog = BuildSubclass()

        local function ClearDialog()
            DialogPanel.Closed = true
            DialogPanel.Closing = false
            setmetatable(DialogPanel, nil)
            DialogPanel = nil
            DialogContainer.Parent = nil
        end

        local function ForceCloseDialog()
            if DialogPanel ~= nil then
                DialogPanel:Close()
            end
        end

        function ComponentClasses.Dialog:NewOption(config)
            local name = config[1] or config.Name or config.Title
            local cb = GetCallback(config[2] or config.Callback)
            table.insert(cb, ForceCloseDialog)

            assert(type(name) == "string", `"Dialog.NewOption.Name": String esperada, obteve {typeof(name)}`)

            local optBtn = CreateInstance("TextButton", {
                AutoButtonColor = false,
                Size = UDim2.fromScale(0.24, 1),
                BackgroundTransparency = 0,
                TextSize = 11,
                Text = name,
                Elements = {
                    Corner = UDim.new(0, 6),
                    Stroke = { Thickness = 1 }
                },
                ThemeTag = {
                    BackgroundColor3 = "Colors.Buttons.Default",
                    TextColor3 = "Colors.Text.Dark",
                    Font = "Font.Normal",
                    UIStroke = { Color = "Colors.Stroke" }
                }
            })

            local hoverTween = Tween(optBtn, "BackgroundColor3", ConfigTheme.Darker.Colors.OnPrimary, 0.25)
            local leaveTween = Tween(optBtn, "BackgroundColor3", ConfigTheme.Darker.Colors.Buttons.Default, 0.25)

            ConnectEvent(optBtn.MouseEnter, function() hoverTween:Play() end)
            ConnectEvent(optBtn.MouseLeave, function() leaveTween:Play() end)
            ConnectEvent(optBtn.Activated, function() TriggerCallbacks(cb) end)

            optBtn.Parent = DialogContainer.Template.Options
        end

        function ComponentClasses.Dialog:Close(instantly)
            if self.Closed or self.Closing or DialogPanel ~= self then
                return nil
            end
            self.Closing = true
            local tween = Tween(self.TEMPLATE, "Size", self.NEW_SIZE, 0.15)
            tween:Play()
            if instantly then
                tween.Completed:Wait()
                ClearDialog()
            else
                ConnectEvent(tween.Completed, ClearDialog)
            end
        end

        function ComponentClasses.Dialog.new(desc, title)
            return setmetatable({
                TITLE_LABEL = title,
                DESCRIPTION_LABEL = desc,
                Content = desc.Text,
                Title = title.Text,
                Closed = false,
                Closing = false,
                Kind = "Dialog"
            }, ComponentClasses.Dialog)
        end

        -- Dropdown Métodos
        function ComponentClasses.Dropdown:SetEnabled(list)
            assert(type(list) == "table", `"Dropdown.SetEnabled": Tabela esperada, obteve {typeof(list)}`)
            self.SET_ENABLED_OPTIONS(list)
        end

        function ComponentClasses.Dropdown:Clear()
            self.CLEAR_DROPDOWN()
        end

        function ComponentClasses.Dropdown:NewOptions(...)
            self:Clear()
            self:Add(...)
        end

        function ComponentClasses.Dropdown:GetOptionsCount()
            return #self.DROPDOWN_OPTIONS
        end

        function ComponentClasses.Dropdown:Remove(...)
            local args = { ... }
            assert(#args > 0, "Dropdown.Remove requer ao menos um argumento.")
            for _, val in args do
                self.REMOVE_DROPDOWN_OPTION(val)
            end
        end

        function ComponentClasses.Dropdown:Add(...)
            local args = { ... }
            assert(#args > 0, "Dropdown.Add requer ao menos um argumento.")
            for _, val in args do
                self.ADD_DROPDOWN_OPTION(val)
            end
        end

        function ComponentClasses.Dropdown.new(parent, element, title, desc, cb)
            return setmetatable({
                CALLBACKS = cb,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = title,
                DESCRIPTION_LABEL = desc,
                Description = desc.Text,
                Title = title.Text,
                Parent = parent,
                Kind = "Dropdown"
            }, ComponentClasses.Dropdown)
        end

        -- Slider Métodos
        function ComponentClasses.Slider:SetValue(val)
            assert(type(val) == "number", `"Slider.SetValue": número esperado, obteve {typeof(val)}`)
            if self.Value ~= val then
                self.WHEN_VALUE_CHANGED(val)
            end
        end

        function ComponentClasses.Slider.new(parent, element, title, desc, cb)
            return setmetatable({
                CALLBACKS = cb,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = title,
                DESCRIPTION_LABEL = desc,
                Description = desc.Text,
                Title = title.Text,
                Parent = parent,
                Kind = "Slider"
            }, ComponentClasses.Slider)
        end

        -- Toggle Métodos
        function ComponentClasses.Toggle:SetValue(state)
            assert(type(state) == "boolean", `"Toggle.SetValue": booleano esperado, obteve {typeof(state)}`)
            if self.Value ~= state then
                self.Value = state
                self.WHEN_VALUE_CHANGED(state)
            end
        end

        function ComponentClasses.Toggle.new(parent, element, title, desc, internalCallback, listCallbacks)
            return setmetatable({
                CALLBACKS = listCallbacks,
                WHEN_VALUE_CHANGED = internalCallback,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = title,
                DESCRIPTION_LABEL = desc,
                Description = desc.Text,
                Title = title.Text,
                Parent = parent,
                Kind = "Toggle"
            }, ComponentClasses.Toggle)
        end

        -- TextBox Métodos
        function ComponentClasses.TextBox:SetText(txt)
            assert(type(txt) == "string", `"TextBox.SetText": string esperada, obteve {typeof(txt)}`)
            self.TEXTBOX.Text = txt
            return self
        end

        function ComponentClasses.TextBox:SetPlaceholder(txt)
            assert(type(txt) == "string", `"TextBox.SetPlaceholder": string esperada, obteve {typeof(txt)}`)
            self.TEXTBOX.PlaceholderText = txt
            return self
        end

        function ComponentClasses.TextBox:CaptureFocus()
            self.TEXTBOX:CaptureFocus()
            return self
        end

        function ComponentClasses.TextBox:Clear()
            self.TEXTBOX.Text = ""
            return self
        end

        function ComponentClasses.TextBox:SetTextFilter(func)
            if func ~= nil then
                assert(type(func) == "function", `"TextBox.SetTextFilter": 'function' ou 'nil' esperado, obteve {typeof(func)}`)
            end
            self.TEXTBOX_TEXT_FILTER = func
            return self
        end

        function ComponentClasses.TextBox.new(parent, title, desc, element, textBox, cb)
            return setmetatable({
                Title = title.Text,
                Description = desc.Text,
                DESCRIPTION_LABEL = desc,
                TITLE_LABEL = title,
                CALLBACKS = cb,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TEXTBOX = textBox,
                BUTTON = element,
                Parent = parent,
                Kind = "TextBox"
            }, ComponentClasses.TextBox)
        end

        ComponentClasses.TextBox.Set = ComponentClasses.TextBox.SetText
        ComponentClasses.Toggle.Set = ComponentClasses.Toggle.SetValue
        ComponentClasses.Slider.Set = ComponentClasses.Slider.SetValue
    end

    local function CreateTabHeader(tabObj, parentFrame)
        local tabBtn = CreateInstance("TextButton", "Button", parentFrame, {
            Size = UDim2.new(1, 0, 0, 28),
            AutoButtonColor = false,
            Text = "",
            Elements = {
                Corner = UDim.new(0, 6)
            },
            ThemeTag = {
                BackgroundColor3 = "Colors.Buttons.Default"
            },
            Childs = {
                CreateInstance("TextLabel", "Title", {
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamMedium,
                    Text = Localize(tabObj.Title),
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTransparency = (FirstTab and 0.4) or 0.15,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = {
                        TextColor3 = "Colors.Text.Default"
                    }
                })
            }
        })

        table.insert(Library.LocalizedLabels, { Instance = tabBtn.Title, Original = tabObj.Title })

        local glowAccent = CreateInstance("Frame", tabBtn, {
            Position = UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.fromOffset(4, 10),
            BackgroundTransparency = 1,
            ThemeTag = {
                BackgroundColor3 = "Colors.Primary"
            },
            Elements = {
                Corner = UDim.new(0.5, 0)
            }
        })

        local optScroll = CreateInstance("ScrollingFrame", "Container", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            ScrollBarThickness = 2.5,
            BackgroundTransparency = 1,
            ScrollBarImageTransparency = 0.15,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            ThemeTag = {
                ScrollBarImageColor3 = "Colors.ScrollBar"
            },
            Elements = {
                Padding = {
                    PaddingLeft = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 12),
                    PaddingTop = UDim.new(0, 12),
                    PaddingBottom = UDim.new(0, 12)
                },
                ListLayout = {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 6)
                }
            }
        })

        local tabIcon = CreateInstance("ImageLabel", tabBtn, {
            Position = UDim2.new(0, 10, 0.5),
            Size = UDim2.new(0, 14, 0, 14),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            ImageTransparency = 0.25,
            Image = tabObj.Icon or ""
        })

        local function RefreshLayout()
            local hasIcon = string.sub(tabIcon.Image, 1, 13) == "rbxassetid://"
            local label = tabBtn.Title
            tabIcon.Visible = hasIcon
            label.Size = UDim2.new(1, hasIcon and -28 or -18, 1)
            label.Position = UDim2.fromOffset(hasIcon and 28 or 18)
        end

        ConnectEvent(tabIcon:GetPropertyChangedSignal("Image"), RefreshLayout)
        RefreshLayout()

        return tabBtn, optScroll, glowAccent, tabIcon
    end

    local SelectedActiveOption
    local function CreateBaseOption(tab, title, desc, rightObjSize)
        local titleLbl = CreateInstance("TextLabel", {
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, -25),
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            TextSize = 12,
            ThemeTag = {
                OBJECTS = MasterRender,
                TextColor3 = "Colors.Text.Default",
                Font = "Font.Medium"
            }
        })

        local tabRender = TabsList[tab]
        local scrollFrame = TabConnections[tab].Container

        local descLbl = CreateInstance("TextLabel", {
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, -25),
            Position = UDim2.new(0, 12, 0, 16),
            BackgroundTransparency = 1,
            TextWrapped = true,
            TextSize = 9,
            RichText = true,
            ThemeTag = {
                OBJECTS = tabRender,
                TextColor3 = "Colors.Text.Dark",
                Font = "Font.Normal"
            }
        })

        local properties = {
            OBJECTS = tabRender,
            BackgroundColor3 = "Colors.Buttons.Default"
        }

        local itemFrame = CreateInstance("TextButton", "Option", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 28),
            AutoButtonColor = false,
            Text = "",
            ThemeTag = properties,
            Elements = {
                Corner = UDim.new(0, 6),
                Stroke = { Thickness = 1 }
            },
            Childs = {
                CreateInstance("Frame", "Holder", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Size = rightObjSize,
                    Elements = {
                        ListLayout = {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 2)
                        },
                        Padding = {
                            PaddingBottom = UDim.new(0, 6),
                            PaddingTop = UDim.new(0, 6)
                        }
                    },
                    Childs = { titleLbl, descLbl }
                })
            }
        })

        local container = itemFrame.Holder
        local function ApplyVisualHover(themeColor, active)
            if active then
                if SelectedActiveOption then
                    local colorDefault = FetchPropertyValue(Library.CurrentTheme, "Colors.Buttons.Default")
                    SelectedActiveOption.Theme.BackgroundColor3 = "Colors.Buttons.Default"
                    Tween(SelectedActiveOption.Button, "BackgroundColor3", colorDefault, 0.2):Play()
                end
                SelectedActiveOption = {
                    Button = itemFrame,
                    Theme = properties
                }
            end
            properties.BackgroundColor3 = themeColor
            Tween(itemFrame, "BackgroundColor3", FetchPropertyValue(Library.CurrentTheme, themeColor), 0.2):Play()
        end

        ConnectEvent(itemFrame.MouseEnter, function() ApplyVisualHover("Colors.Buttons.Holding", true) end)
        ConnectEvent(itemFrame.MouseLeave, function() ApplyVisualHover("Colors.Buttons.Default", false) end)

        ConnectEvent(descLbl:GetPropertyChangedSignal("Text"), function()
            local activeDesc = #descLbl.Text > 0
            if descLbl.Visible ~= activeDesc then
                local offset = activeDesc and 0 or 0.5
                descLbl.Visible = activeDesc
                container.Position = UDim2.fromScale(0, offset)
                container.AnchorPoint = Vector2.new(0, offset)
            end
        end)

        titleLbl.Text = Localize(title)
        descLbl.Text = Localize(desc or "")

        table.insert(Library.LocalizedLabels, { Instance = titleLbl, Original = title })
        table.insert(Library.LocalizedLabels, { Instance = descLbl, Original = desc or "" })

        itemFrame.Parent = scrollFrame
        return itemFrame, titleLbl, descLbl
    end

    local function ValidateConfig(originName, configTable)
        if type(configTable) ~= "table" then
            error(`"Tab.Add{originName}": Tabela de configuração esperada, obteve {typeof(configTable)}`, 2)
        end
        local title = configTable[1] or configTable.Name or configTable.Title
        local desc = configTable.Desc or configTable.Description
        assert(type(title) == "string", `"Tab.Add{originName}.Title": String esperada, obteve {typeof(title)}`)
        return title, desc or ""
    end

    local function RetrieveFlagName(originName, flagValue)
        if flagValue ~= nil and type(flagValue) ~= "string" then
            error(`"Tab.Add{originName}.Flag": String ou nil esperada, obteve {typeof(flagValue)}`)
        end
        return flagValue
    end

    -- Dropdown de Seleção de Elementos Global
    local function ConstructDropdownController()
        local dropWidth = 170
        local dropConfig = {
            Corner = UDim.new(0, 6),
            Stroke = {
                ThemeTag = { Color = "Colors.Stroke" }
            },
            Gradient = {
                Rotation = 45,
                ThemeTag = { Color = "Colors.Background" }
            }
        }

        local backShield = CreateInstance("TextButton", OutBox, {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Active = true,
            Text = ""
        })

        local dropdownBox = CreateInstance("Frame", "Dropdown", backShield, {
            Size = UDim2.fromOffset(dropWidth, 110),
            Position = UDim2.fromOffset(50, 50),
            Elements = dropConfig,
            Active = true,
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" }
        })

        local searchArea = CreateInstance("TextButton", "Search", dropdownBox, {
            Position = UDim2.new(1, 5, 0, 5),
            Size = UDim2.new(0, 26, 0, 26),
            AutomaticSize = Enum.AutomaticSize.X,
            Active = true,
            Elements = dropConfig,
            Text = "",
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
            Childs = {
                CreateInstance("UIPadding", {
                    PaddingLeft = UDim.new(0, 6),
                    PaddingRight = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6),
                    PaddingTop = UDim.new(0, 6)
                }),
                CreateInstance("UIListLayout", {
                    Padding = UDim.new(0, 6),
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center
                }),
                CreateInstance("TextBox", "SearchBox", {
                    Size = UDim2.fromScale(0, 1),
                    Visible = false,
                    PlaceholderText = "Filtro...",
                    ClearTextOnFocus = false,
                    Text = "",
                    Elements = { Corner = UDim.new(0, 4) },
                    ThemeTag = {
                        BackgroundColor3 = "Colors.Stroke",
                        TextColor3 = "Colors.Text.Default",
                        Font = "Font.ExtraBold"
                    }
                }),
                CreateInstance("ImageLabel", "SearchIcon", {
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = Enum.SizeConstraint.RelativeYY,
                    BackgroundTransparency = 1,
                    ThemeTag = {
                        BackgroundColor3 = "Colors.Stroke",
                        ImageColor3 = "Colors.Icons",
                        Image = "Icons.Search"
                    }
                })
            }
        })

        local scroller = CreateInstance("ScrollingFrame", dropdownBox, {
            Size = UDim2.new(1, -6, 1, -6),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ScrollBarThickness = 3,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Active = true,
            ThemeTag = {
                OBJECTS = MasterRender,
                ScrollBarImageColor3 = "Colors.ScrollBar"
            },
            Elements = {
                Padding = {
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8),
                    PaddingTop = UDim.new(0, 6),
                    PaddingBottom = UDim.new(0, 6)
                },
                ListLayout = { Padding = UDim.new(0, 5) }
            }
        })

        local icon = searchArea.SearchIcon
        local box = searchArea.SearchBox

        local dynamicWidth = 140
        local collapseTween = Tween(dropdownBox, "Size", UDim2.fromOffset(dropWidth, 0), 0.2)
        local expandSearchTween = Tween(box, "Size", UDim2.new(0, dynamicWidth - 30, 1, 0), 0.25)
        local shrinkSearchTween = Tween(box, "Size", UDim2.new(0, 0, 1, 0), 0.2)

        local optionsSet = {}
        local dropdownOpen = false
        local dropdownClosing = false
        local optionActivatedCallback
        local optionMultiMode
        local baseAnchorFrame

        local defaultRowHeight = 22
        local safetyMargin = 5

        local function GetMaxRowsSize(rows)
            local viewportLimit = MainFrameObj.AbsoluteSize.Y / ScalerObject.Scale
            return math.min((defaultRowHeight * math.max(rows, 0.5)) + 10, 260, viewportLimit / 1.7)
        end

        local function CursorIsInsideDrop()
            local pos = dropdownBox.AbsolutePosition
            local size = dropdownBox.AbsoluteSize
            local m = Vector2.new(Mouse.X, Mouse.Y)
            return (m.X >= pos.X and m.X <= pos.X + size.X) and (m.Y >= pos.Y and m.Y <= pos.Y + size.Y)
        end

        local function CalculateOptimalPosition(rowsCount)
            local originPos = baseAnchorFrame.AbsolutePosition
            local originSize = baseAnchorFrame.AbsoluteSize
            local viewport = MainFrameObj.AbsoluteSize
            local scaleVal = ScalerObject.Scale
            local sizeH = GetMaxRowsSize(rowsCount)

            local sW = viewport.X / scaleVal
            local sH = viewport.Y / scaleVal
            local aX = originPos.X / scaleVal
            local aY = originPos.Y / scaleVal
            local width = originSize.X / scaleVal
            local height = originSize.Y / scaleVal

            local anchorMiddle = aY + (height / 2)
            local yPos = anchorMiddle - (sizeH / 2)

            local limitTop = safetyMargin
            local limitBottom = sH - sizeH - safetyMargin
            local optimalY = math.clamp(yPos, limitTop, limitBottom)

            local anchorVec = Vector2.new(0, 0)
            if optimalY > (sH * 0.7) then
                anchorVec = Vector2.new(0, 1)
                optimalY = math.min(anchorMiddle + (sizeH / 2), sH - safetyMargin)
            end

            local optimalX = math.clamp(aX, safetyMargin, sW - dropdownBox.Size.X.Offset - (safetyMargin * 2) - (searchArea.AbsoluteSize.X / scaleVal))
            return Vector2.new(optimalX, optimalY), anchorVec
        end

        local function AdjustOptimalLayout(...)
            local optimalPos, anchor = CalculateOptimalPosition(...)
            dropdownBox.AnchorPoint = anchor
            dropdownBox.Position = UDim2.fromOffset(optimalPos.X, optimalPos.Y)
        end

        local function CollapseSearch()
            if not dropdownClosing then return end
            dropdownClosing = false
            box.Text = ""
            shrinkSearchTween:Play()
            shrinkSearchTween.Completed:Wait()
            box.Visible = false
        end

        local function ExpandSearch()
            if dropdownClosing then return end
            dropdownClosing = true
            box.Visible = true
            expandSearchTween:Play()
            box:CaptureFocus()

            local bounds = dropdownBox.AbsoluteSize
            local viewport = MainFrameObj.AbsoluteSize
            local scaleVal = ScalerObject.Scale
            local targetWidth = dynamicWidth * scaleVal
            local currentX = dropdownBox.AbsolutePosition.X

            if currentX + bounds.X + 5 + targetWidth > viewport.X - (safetyMargin * scaleVal) then
                local finalPos = (viewport.X - bounds.X - targetWidth - 5 - (safetyMargin * scaleVal)) / scaleVal
                Tween(dropdownBox, "Position", UDim2.fromOffset(math.max(finalPos, safetyMargin), dropdownBox.Position.Y.Offset), 0.25):Play()
            end
        end

        local function ToggleFocusCheck(cb)
            if not dropdownOpen then
                ConnectEvent(backShield.Activated, cb)
                backShield.Parent = DropdownMasterPanel
                return true
            end
        end

        local function CloseDropdown()
            if dropdownOpen then return end
            if backShield.Parent then
                backShield.Parent = nil
            end
            task.spawn(CollapseSearch)
            dropdownOpen = true
            collapseTween:Play()
            collapseTween.Completed:Wait()
            backShield.Parent = nil
            dropdownOpen = false
        end

        local function PerformAutoCloseCheck()
            if box:IsFocused() then return end
            if not CursorIsInsideDrop() then
                CloseDropdown()
            end
        end

        local function WipeElements()
            for obj, state in optionsSet do
                obj.Parent = nil
                optionsSet[obj] = nil
            end
        end

        local function UpdateOptionState(item, selected)
            item.Selected = selected
            if item.Instance then
                local frame = item.Instance
                local label = frame.TextLabel
                local sideLine = frame.Frame

                local alpha = selected and 0 or (optionMultiMode and 0.8 or 1)
                local textAlpha = selected and 0 or 0.35
                local size = UDim2.fromOffset(4, selected and 14 or 4)

                if frame.Parent then
                    Tween(sideLine, "BackgroundTransparency", alpha, 0.2):Play()
                    Tween(label, "TextTransparency", textAlpha, 0.2):Play()
                    Tween(sideLine, "Size", size, 0.2):Play()
                else
                    label.TextTransparency = textAlpha
                    sideLine.BackgroundTransparency = alpha
                    sideLine.Size = size
                end
            end
        end

        local SEARCH_RESULT_COUNT = 0
        local function ApplyActiveFilter(row)
            if box.Visible == false or not row then
                dropdownBox.Size = UDim2.fromOffset(dropWidth, GetMaxRowsSize(row and 1 or 0))
                return nil
            end
            if row then
                local frame = row.Instance
                local searchStr = CleanString(box.Text)
                frame.Visible = #searchStr == 0 or row.SearchText:find(searchStr) ~= nil

                if frame.Visible then
                    SEARCH_RESULT_COUNT += 1
                    dropdownBox.Size = UDim2.fromOffset(dropWidth, GetMaxRowsSize(SEARCH_RESULT_COUNT))
                end
            end
        end

        local function MatchQuery(row, mode, query, content)
            local match = true
            if mode == "+" or mode == "-" then
                match = row.Selected == (mode == "+")
                query = query:sub(2, -1)
            end
            return match and content:find(query, 1, true) ~= nil
        end

        local function BuildOptionElement(row, activeLayout)
            local item = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, defaultRowHeight),
                AutoButtonColor = false,
                Text = "",
                Elements = { Corner = UDim.new(0, 4) },
                ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
                Childs = {
                    CreateInstance("Frame", {
                        Position = UDim2.new(0, 2, 0.5),
                        Size = UDim2.new(0, 4, 0, 4),
                        BackgroundTransparency = 1,
                        AnchorPoint = Vector2.new(0, 0.5),
                        Elements = { Corner = UDim.new(0.5, 0) },
                        ThemeTag = { BackgroundColor3 = "Colors.Primary" }
                    }),
                    CreateInstance("TextLabel", {
                        Size = UDim2.fromScale(1, 1),
                        Position = UDim2.fromOffset(12, 0),
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BackgroundTransparency = 1,
                        TextTransparency = 0.35,
                        Text = row.DisplayName,
                        TextSize = 10,
                        ThemeTag = {
                            Font = "Font.Bold",
                            TextColor3 = "Colors.Text.Default"
                        }
                    })
                }
            })

            ConnectEvent(item.Activated, function()
                if dropdownBox.Parent and not dropdownOpen then
                    optionActivatedCallback(row)
                end
            end)

            row.SearchText = CleanString(row.DisplayName)
            row.Instance = item

            if activeLayout then
                local searchStr = box.Text
                if #searchStr > 0 then
                    local prefix = string.sub(searchStr, 1, 1)
                    local query = CleanString(box.Text)
                    item.Visible = MatchQuery(row, prefix, query, row.SearchText)
                end
                item.Parent = scroller
                ApplyActiveFilter(row)
            end
            UpdateOptionState(row, row.Selected)
        end

        local function AssignOptions(list)
            WipeElements()
            for i = 1, #list do
                local row = list[i]
                local inst = row.Instance
                if inst == nil then
                    BuildOptionElement(row)
                    inst = row.Instance
                end
                inst.Parent = scroller
                optionsSet[inst] = true
            end
            AdjustOptimalLayout(#list)
            Tween(dropdownBox, "Size", UDim2.fromOffset(dropWidth, GetMaxRowsSize(#list)), 0.25):Play()
        end

        local function FilterOnType()
            local txt = box.Text
            local prefix = string.sub(txt, 1, 1)
            local query = CleanString(txt)
            local empty = #query == 0
            local matches = 0

            for inst, _ in optionsSet do
                local matchRow
                for _, row in optionsSet do
                    if row.Instance == inst then matchRow = row break end
                end
                local state = empty or MatchQuery(matchRow, prefix, query, matchRow.SearchText)
                inst.Visible = state
                if state then matches += 1 end
            end
            SEARCH_RESULT_COUNT = matches
            dropdownBox.Size = UDim2.fromOffset(dropWidth, GetMaxRowsSize(matches))
        end

        ConnectEvent(MainFrameObj:GetPropertyChangedSignal("Visible"), CloseDropdown)
        ConnectEvent(MainFrameObj:GetPropertyChangedSignal("Size"), CloseDropdown)
        ConnectEvent(backShield.Activated, CloseDropdown)

        ConnectEvent(searchArea.Activated, ExpandSearch)
        ConnectEvent(box:GetPropertyChangedSignal("Text"), FilterOnType)

        return table.freeze({
            CreateOptionTemplate = BuildOptionElement,
            SetOptionValue = UpdateOptionState,
            CloseDropdown = CloseDropdown,
            OpenDropdown = ToggleFocusCheck,
            SetOptions = AssignOptions,
            Clear = WipeElements,
            SetOnClicked = function(cb) optionActivatedCallback = cb end,
            SetMultiSelect = function(state) optionMultiMode = state end,
            SetHolder = function(holder) baseAnchorFrame = holder end
        })
    end

    local KeysWhitelist = BuildCharMap("W\nA\nS\nD\nTab\nSlash\nBackspace\nEscape\nUnknown")
    local FunctionWhitelist = BuildCharMap("MouseButton1\nMouseButton2\nMouseButton3")

    local function IsValidKey(key)
        return typeof(key) == "EnumItem"
    end

    function MinimizerClass:GetNoSelfCall(funcName)
        assert(type(funcName) == "string", `"Tab.GetNoSelfCall": string esperada, obteve {typeof(funcName)}`)
        local target = self[funcName]
        assert(type(target) == "function", `"{target}" não é uma função válida.`)
        return function(...)
            return target(self, ...)
        end
    end

    function TabMethods:AddSection(name)
        assert(name == nil or type(name) == "string", `"Tab.AddSection": string ou nil esperado, obteve {typeof(name)}`)
        name = name or ""

        local tabRender = TabsList[self]
        local sectionFrame = CreateInstance("Frame", "Option", TabConnections[self].Container, {
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1
        })

        local sectionLabel = CreateInstance("TextLabel", sectionFrame, {
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            Size = UDim2.new(1, -25, 1, 0),
            Position = UDim2.new(0, 5),
            BackgroundTransparency = 1,
            TextSize = 13,
            Text = Localize(name),
            ThemeTag = {
                OBJECTS = tabRender,
                TextColor3 = "Colors.Primary",
                Font = "Font.Bold"
            }
        })

        table.insert(Library.LocalizedLabels, { Instance = sectionLabel, Original = name })

        return setmetatable({
            Title = name,
            DESTROY_ELEMENT = sectionFrame,
            VISIBLE_ELEMENT = sectionFrame,
            TITLE_LABEL = sectionLabel,
            Kind = "Section",
            Parent = self
        }, ComponentMethods)
    end

    function TabMethods:AddToggle(config)
        local title, desc = ValidateConfig("Toggle", config)
        local flag = RetrieveFlagName("Toggle", config[4] or config.Flag)

        local defaultState = config[2] or config.Default or false
        local callbackList = GetCallback(config[3] or config.Callback)

        if type(defaultState) ~= "boolean" then
            error(`"Tab.AddToggle.Default": booleano esperado, obteve {typeof(defaultState)}`, 2)
        end

        if flag ~= nil and type(FlagStorage[flag]) == "number" then
            defaultState = FlagStorage[flag] == 0
        end

        local tabRender = TabsList[self]
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(1, -38, 0, 0))

        local container = CreateInstance("Frame", baseFrame, {
            Size = UDim2.new(0, 36, 0, 18),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            Elements = { Corner = UDim.new(0.5, 0) },
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Stroke" }
        })

        local track = CreateInstance("Frame", container, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.8, 0, 0.8, 0),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        })

        local handleProperties = {
            OBJECTS = tabRender,
            BackgroundColor3 = "Colors.OnPrimary"
        }

        local pin = CreateInstance("Frame", track, {
            Size = UDim2.fromOffset(11, 11),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Elements = { Corner = UDim.new(0.5, 0) },
            ThemeTag = handleProperties
        })

        local lastAnimate = tick()
        local activeTweens = {}

        local function CancelActiveTweens()
            for i = #activeTweens, 1, -1 do
                local t = activeTweens[i]
                if t.PlaybackState == Enum.PlaybackState.Playing then
                    t:Cancel()
                end
                activeTweens[i] = nil
            end
        end

        local function ApplyToggleState(state)
            if flag ~= nil then
                FlagStorage[flag] = state and 0 or 1
            end
            TriggerCallbacks(callbackList, state)

            local scaleX = state and 1 or 0
            local anchor = Vector2.new(state and 1 or 0, 0.5)
            local themeKey = state and "Colors.Primary" or "Colors.OnPrimary"
            local colorVal = FetchPropertyValue(Library.CurrentTheme, themeKey)

            handleProperties.BackgroundColor3 = themeKey

            if self.Selected and (tick() - lastAnimate) >= 0.2 then
                CancelActiveTweens()
                activeTweens = {
                    Tween(pin, "Position", UDim2.new(scaleX, 0, 0.5, 0), 0.25),
                    Tween(pin, "AnchorPoint", anchor, 0.25),
                    Tween(pin, "BackgroundColor3", colorVal, 0.25)
                }
                for i = 1, #activeTweens do activeTweens[i]:Play() end
            else
                CancelActiveTweens()
                pin.Position = UDim2.new(scaleX, 0, 0.5, 0)
                pin.AnchorPoint = anchor
                pin.BackgroundColor3 = colorVal
            end
            lastAnimate = tick()
        end

        local toggleInst = ComponentClasses.Toggle.new(self, baseFrame, titleLabel, descLabel, ApplyToggleState, callbackList)
        toggleInst:SetValue(defaultState)

        local clickThrottle = 0
        ConnectEvent(baseFrame.Activated, function()
            if (tick() - clickThrottle) >= 0.2 then
                clickThrottle = tick()
                toggleInst:SetValue(not toggleInst.Value)
            end
        end)

        return toggleInst
    end

    function TabMethods:AddButton(config)
        local title, desc = ValidateConfig("Button", config)
        local cbList = GetCallback(config[2] or config.Callback)
        local cooldown = config.Debounce or config.Cooldown

        local tabRender = TabsList[self]
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(1, -20, 0, 0))

        local btnIcon = CreateInstance("ImageLabel", baseFrame, {
            Size = UDim2.fromOffset(14, 14),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = {
                OBJECTS = tabRender,
                Image = "Icons.Button",
                ImageColor3 = "Colors.Primary"
            }
        })

        local lastClick = 0
        ConnectEvent(baseFrame.Activated, function()
            if cooldown ~= nil and (tick() - lastClick) < cooldown then return end
            if cooldown ~= nil then
                lastClick = tick()
            end
            TriggerCallbacks(cbList)
        end)

        return setmetatable({
            CALLBACKS = cbList,
            DESTROY_ELEMENT = baseFrame,
            VISIBLE_ELEMENT = baseFrame,
            TITLE_LABEL = titleLabel,
            DESCRIPTION_LABEL = descLabel,
            Title = title,
            Description = desc,
            Parent = self,
            Kind = "Button"
        }, ComponentMethods)
    end

    function TabMethods:AddTextBox(config)
        local title, desc = ValidateConfig("TextBox", config)
        local flag = RetrieveFlagName("TextBox", config[4] or config.Flag)

        local defaultText = config[2] or config.Default
        local cbList = GetCallback(config[3] or config.Callback)

        local placeholder = config.Placeholder or config.PlaceholderText
        local clearOnFocus = config.ClearOnFocus or config.ClearTextOnFocus

        if defaultText ~= nil and type(defaultText) ~= "string" then
            error(`"Tab.AddTextBox.Default": string ou nil esperado, obteve {typeof(defaultText)}`, 2)
        end

        if flag and type(FlagStorage[flag]) == "string" then
            defaultText = FlagStorage[flag]
        end

        local tabRender = TabsList[self]
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(1, -150, 0, 0))

        local inputHolder = CreateInstance("Frame", baseFrame, {
            Size = UDim2.new(0, 150, 0, 18),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Stroke" },
            Elements = { Corner = UDim.new(0, 4) }
        })

        local txtBox = CreateInstance("TextBox", inputHolder, {
            Size = UDim2.new(0.85, 0, 0.85, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            TextScaled = true,
            Active = true,
            Text = "",
            PlaceholderText = ThemeScales.TEXTBOX.PLACEHOLDER_TEXT,
            ThemeTag = {
                OBJECTS = tabRender,
                TextColor3 = "Colors.Text.Default",
                Font = "Font.Bold"
            }
        })

        local tagConfig = {
            OBJECTS = tabRender,
            Image = "Icons.TextBox",
            ImageColor3 = "Colors.Icons"
        }

        local miniIcon = CreateInstance("ImageLabel", inputHolder, {
            Size = UDim2.fromOffset(12, 12),
            Position = UDim2.new(0, -6, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = tagConfig
        })

        if defaultText ~= nil then txtBox.Text = defaultText end
        if clearOnFocus ~= nil then txtBox.ClearTextOnFocus = clearOnFocus end
        if placeholder ~= nil then txtBox.PlaceholderText = placeholder end

        local txtBoxInst = ComponentClasses.TextBox.new(self, titleLabel, descLabel, baseFrame, txtBox, cbList)

        local function SetIconHighlight(themeKey)
            tagConfig.ImageColor3 = themeKey
            Tween(miniIcon, "ImageColor3", FetchPropertyValue(Library.CurrentTheme, themeKey), 0.3):Play()
        end

        if flag ~= nil then
            ConnectEvent(txtBox:GetPropertyChangedSignal("Text"), function()
                FlagStorage[flag] = txtBox.Text
            end)
        end

        ConnectEvent(txtBox.Focused, function() SetIconHighlight("Colors.Primary") end)
        ConnectEvent(txtBox.FocusLost, function()
            SetIconHighlight("Colors.Icons")
            local filter = txtBoxInst.TEXTBOX_TEXT_FILTER
            if filter then
                local filtered = filter(txtBox.Text)
                if type(filtered) == "string" then
                    txtBox.Text = filtered
                end
            end
            TriggerCallbacks(cbList, txtBox.Text)
        end)

        ConnectEvent(baseFrame.Activated, function() txtBox:CaptureFocus() end)
        return txtBoxInst
    end

    function TabMethods:AddSlider(config)
        local title, desc = ValidateConfig("Slider", config)
        local flag = RetrieveFlagName("Slider", config[7] or config.Flag)

        local minVal = config[2] or config.Min
        local maxVal = config[3] or config.Max
        local step = config[4] or config.Increment
        local def = config[5] or config.Default
        local callbackList = GetCallback(config[6] or config.Callback)

        assert(type(minVal) == "number", `"Tab.AddSlider.Min": número esperado, obteve {typeof(minVal)}`)
        assert(type(maxVal) == "number", `"Tab.AddSlider.Max": número esperado, obteve {typeof(maxVal)}`)

        local tabRender = TabsList[self]
        local scrollFrame = TabConnections[self].Container
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(0.55, 0, 0, 0))

        def = def or minVal
        step = step or 1

        if flag ~= nil and type(FlagStorage[flag]) == "number" then
            def = FlagStorage[flag]
        end

        local sliderArea = CreateInstance("TextButton", baseFrame, {
            Size = UDim2.new(0.48, 0, 1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Text = ""
        })

        local barTrack = CreateInstance("Frame", sliderArea, {
            Size = UDim2.new(1, -20, 0, 5),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Stroke" },
            Elements = { Corner = UDim.new(0.5, 0) }
        })

        local barFill = CreateInstance("Frame", barTrack, {
            Size = UDim2.fromScale(0, 1),
            BorderSizePixel = 0,
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Primary" },
            Elements = { Corner = UDim.new(0.5, 0) }
        })

        local handle = CreateInstance("Frame", barTrack, {
            Size = UDim2.fromOffset(8, 14),
            BackgroundColor3 = Color3.fromRGB(240, 240, 240),
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 0.15,
            Elements = { Corner = UDim.new(0, 4) }
        })

        local valueLabel = CreateInstance("TextLabel", sliderArea, {
            Size = UDim2.fromOffset(50, 14),
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(0, -2, 0.5, 0),
            BackgroundTransparency = 1,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Right,
            ThemeTag = {
                OBJECTS = tabRender,
                TextColor3 = "Colors.Text.Default",
                Font = "Font.SliderValue"
            }
        })

        local valueScaler = CreateInstance("UIScale", valueLabel)
        local sliderInst = ComponentClasses.Slider.new(self, baseFrame, titleLabel, descLabel, callbackList)

        sliderInst.Min = minVal
        sliderInst.Max = maxVal
        sliderInst.Increment = step

        local function GetRatio(val)
            return (val - minVal) / (maxVal - minVal)
        end

        local function GetValFromRatio(ratio)
            return (ratio * (maxVal - minVal)) + minVal
        end

        local function SnapValue(val)
            return math.round(val / step) * step
        end

        local function SetSliderValue(val, ratio)
            if val == sliderInst.Value then return end
            if flag ~= nil then
                FlagStorage[flag] = val
            end
            task.defer(TriggerCallbacks, callbackList, val)
            sliderInst.Value = val

            local uPos = UDim2.fromScale(ratio, 0.5)
            local uFill = UDim2.fromScale(ratio, 1)

            valueLabel.Text = tostring(math.floor(val * 1000) / 1000)

            if self.Selected then
                Tween(handle, "Position", uPos, 0.25):Play()
                Tween(barFill, "Size", uFill, 0.25):Play()
            else
                handle.Position = uPos
                barFill.Size = uFill
            end
        end

        local function UpdateDraggingPosition(inputPos)
            local ratio = math.clamp((Mouse.X - inputPos.X) / barTrack.AbsoluteSize.X, 0, 1)
            local finalVal = math.clamp(SnapValue(GetValFromRatio(ratio)), minVal, maxVal)
            SetSliderValue(finalVal, GetRatio(finalVal))
        end

        sliderInst.WHEN_VALUE_CHANGED = function(v)
            local snapped = math.clamp(SnapValue(v), minVal, maxVal)
            SetSliderValue(snapped, GetRatio(snapped))
        end

        local randomGen = Random.new()
        sliderInst.WHEN_VALUE_CHANGED(def)

        ConnectEvent(sliderArea.MouseButton1Down, function()
            if IsDraggingAny then return end
            Tween(handle, "BackgroundTransparency", 0, 0.2):Play()
            scrollFrame.ScrollingEnabled = false
            IsDraggingAny = true

            local trackPos = barTrack.AbsolutePosition
            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                UpdateDraggingPosition(trackPos)
                task.wait()
            end

            IsDraggingAny = false
            Tween(handle, "BackgroundTransparency", 0.15, 0.2):Play()
            scrollFrame.ScrollingEnabled = true
        end)

        ConnectEvent(valueLabel:GetPropertyChangedSignal("Text"), function()
            if not self.Selected then return end
            valueScaler.Scale = 0.5
            Tween(valueScaler, "Scale", 1.2, 0.1):Play()
            local spin = Tween(valueLabel, "Rotation", randomGen:NextNumber(-6, 6), 0.15)
            spin:Play()
            spin.Completed:Wait()
            Tween(valueScaler, "Scale", 1, 0.2):Play()
            Tween(valueLabel, "Rotation", 0, 0.15):Play()
        end)

        return sliderInst
    end

    function TabMethods:AddDiscordInvite(config)
        local title, desc = ValidateConfig("DiscordInvite", config)
        local iconId = config.Icon or config.Image or config.Logo
        local bannerVal = config.Banner or config.BannerColor
        local activeOnline = config.Online or config.MembersOnline
        local activeTotal = config.Members or config.TotalMembers
        local linkUrl = config.Invite or config.Link

        assert(type(linkUrl) == "string", `"Tab.AddDiscordInvite.Invite": URL/Link esperado, obteve {typeof(linkUrl)}`)

        if TargetScreenGui.ZIndexBehavior ~= Enum.ZIndexBehavior.Sibling then
            TargetScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        end

        local tabRender = TabsList[self]
        local scrollFrame = TabConnections[self].Container

        local widgetFrame = CreateInstance("Frame", "Option", scrollFrame, {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 150)
        })

        local container = CreateInstance("CanvasGroup", widgetFrame, {
            Size = UDim2.new(0, 185, 1, -15),
            Position = UDim2.new(0, 5, 1, 0),
            AnchorPoint = Vector2.new(0, 1),
            ClipsDescendants = true,
            Elements = {
                Corner = UDim.new(0, 8),
                Stroke = { ThemeTag = { Color = "Colors.Border.Default" } }
            },
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Buttons.Default" }
        })

        local topBanner = CreateInstance("ImageLabel", container, {
            BackgroundColor3 = Color3.new(1, 1, 1),
            Size = UDim2.fromScale(1, 0.28),
            BackgroundTransparency = 1
        })

        local inviteLabel = CreateInstance("TextLabel", widgetFrame, {
            Position = UDim2.fromOffset(5, 0),
            Size = UDim2.new(1, 0, 0, 15),
            BackgroundTransparency = 1,
            TextSize = 9,
            Text = linkUrl,
            ThemeTag = {
                OBJECTS = tabRender,
                TextColor3 = "Colors.Link",
                Font = "Font.Medium"
            }
        })

        local serverIcon = CreateInstance("ImageLabel", container, {
            Size = UDim2.fromOffset(34, 34),
            Position = UDim2.new(0, 10, 0.28, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Image = iconId,
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Buttons.Default" },
            Elements = {
                Corner = UDim.new(0, 8),
                Stroke = {
                    Thickness = 2,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    ThemeTag = { OBJECTS = tabRender, Color = "Colors.Buttons.Default" }
                }
            }
        })

        local serverNameLabel = CreateInstance("TextLabel", container, {
            Size = UDim2.new(1, -10, 0, 10),
            Position = UDim2.new(0, 10, 0.45, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            TextSize = 11,
            Text = Localize(title),
            ThemeTag = { OBJECTS = tabRender, TextColor3 = "Colors.Text.Default", Font = "Font.Bold" }
        })

        table.insert(Library.LocalizedLabels, { Instance = serverNameLabel, Original = title })

        local countBar
        if activeOnline or activeTotal then
            countBar = CreateInstance("Frame", container, {
                Size = UDim2.new(1, -10, 0, 9),
                Position = UDim2.new(0, 0, 0.54, 0),
                BackgroundTransparency = 1,
                Elements = {
                    Padding = { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 10) },
                    ListLayout = {
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        Padding = UDim.new(0, 5)
                    }
                }
            })

            local function SpawnCounter(color, text)
                return CreateInstance("Frame", countBar, {
                    Size = UDim2.fromScale(0, 1),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Childs = {
                        CreateInstance("Frame", {
                            Size = UDim2.fromOffset(3, 3),
                            Position = UDim2.new(0, 5, 0.5, 0),
                            AnchorPoint = Vector2.new(0, 0.5),
                            BackgroundColor3 = color,
                            Elements = { Corner = UDim.new(1, 0) }
                        }),
                        CreateInstance("TextLabel", {
                            Size = UDim2.new(0, 0, 1, 0),
                            Position = UDim2.new(0, 12, 0.5, 0),
                            AnchorPoint = Vector2.new(0, 0.5),
                            AutomaticSize = Enum.AutomaticSize.X,
                            BackgroundTransparency = 1,
                            TextSize = 7.5,
                            Text = text,
                            ThemeTag = { OBJECTS = tabRender, TextColor3 = "Colors.Text.Darker", Font = "Font.Normal" }
                        })
                    }
                })
            end

            if activeOnline ~= nil then
                SpawnCounter(Color3.fromRGB(255, 30, 60), FormatNumber(activeOnline) .. " Ativos")
            end
            if activeTotal ~= nil then
                SpawnCounter(Color3.fromRGB(110, 110, 115), FormatNumber(activeTotal) .. " Membros")
            end
        end

        local inviteDescLabel = CreateInstance("TextLabel", container, {
            Size = UDim2.new(1, -50, 0, 8),
            Position = UDim2.new(0, 10, countBar and 0.63 or 0.58, 0),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            TextSize = 8.5,
            Text = Localize(desc or ""),
            TextWrapped = true,
            ThemeTag = { OBJECTS = tabRender, TextColor3 = "Colors.Text.Darker", Font = "Font.Medium" }
        })

        table.insert(Library.LocalizedLabels, { Instance = inviteDescLabel, Original = desc or "" })

        local footer = CreateInstance("Frame", container, {
            Size = UDim2.new(1, 0, 0.28, 0),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            BorderSizePixel = 0,
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Buttons.Default" }
        })

        if #inviteDescLabel.Text > 0 then
            footer.Size = UDim2.new(1, 0, 0.42, 0)
            CreateInstance("UIGradient", footer, {
                Rotation = -90,
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0.00, 0.00),
                    NumberSequenceKeypoint.new(0.60, 0.00),
                    NumberSequenceKeypoint.new(1.00, 1.00)
                }
            })
        end

        local joinBtn = CreateInstance("TextButton", footer, {
            Position = UDim2.new(0.5, 0, 1, -9),
            Size = UDim2.new(1, -18, 0, 18),
            AnchorPoint = Vector2.new(0.5, 1),
            Text = "Entrar no Servidor",
            Elements = { Corner = UDim.new(0.5, 0) },
            ThemeTag = {
                OBJECTS = tabRender,
                BackgroundColor3 = "Colors.JoinButton",
                TextColor3 = "Colors.Text.Default",
                Font = "Font.Bold"
            }
        })

        local throttleJoin = 0
        ConnectEvent(joinBtn.Activated, function()
            if (tick() - throttleJoin) < 0 then return end
            throttleJoin = tick() + 5
            local defaultText = joinBtn.Text
            joinBtn.Text = "Copiado para o Clipboard!"
            setclipboard(linkUrl)
            task.wait(4)
            joinBtn.Text = defaultText
        end)

        if type(bannerVal) == "string" then
            topBanner.ScaleType = Enum.ScaleType.Crop
            topBanner.Image = bannerVal
        elseif typeof(bannerVal) == "Color3" then
            topBanner.BackgroundTransparency = 0
            CreateInstance("UIGradient", topBanner, {
                Rotation = -15,
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, bannerVal),
                    ColorSequenceKeypoint.new(1, bannerVal:Lerp(Color3.new(1, 1, 1), 0.25))
                }
            })
        end

        return setmetatable({
            DESTROY_ELEMENT = widgetFrame,
            VISIBLE_ELEMENT = widgetFrame,
            Title = title,
            Description = desc,
            DESCRIPTION_LABEL = inviteDescLabel,
            TITLE_LABEL = serverNameLabel,
            Kind = "DiscordInvite",
            Parent = self
        }, ComponentMethods)
    end

    function TabMethods:AddParagraph(title, desc)
        assert(type(title) == "string", `"Tab.AddParagraph": string esperada, obteve {typeof(title)}`)
        if desc ~= nil and type(desc) ~= "string" then
            error(`"Tab.AddParagraph": string ou nil esperada, obteve {typeof(desc)}`, 2)
        end
        local tabRender = TabsList[self]
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(1, 0, 0, 0))

        return setmetatable({
            DESTROY_ELEMENT = baseFrame,
            VISIBLE_ELEMENT = baseFrame,
            TITLE_LABEL = titleLabel,
            DESCRIPTION_LABEL = descLabel,
            Title = title,
            Description = desc,
            Parent = self,
            Kind = "Paragraph"
        }, ComponentMethods)
    end

    function TabMethods:SetFarmDetail(config)
        if type(config) ~= "table" then
            error(`"Tab.SetFarmDetail": Tabela esperada, obteve {typeof(config)}`, 2)
        end
        local priority = config[1] or config.Priority or config.ID
        local title = config[2] or config.Name or config.Title
        local status = config[3] or config.Status
        local desc = config[4] or config.Info or config.Description

        assert(type(priority) == "number", `"Tab.SetFarmDetail.Priority": número esperado, obteve {typeof(priority)}`)
        assert(type(title) == "string", `"Tab.SetFarmDetail.Name": string esperada, obteve {typeof(title)}`)
        assert(type(status) == "string", `"Tab.SetFarmDetail.Status": string esperada, obteve {typeof(status)}`)

        if desc ~= nil and type(desc) ~= "string" then
            error(`"Tab.SetFarmDetail.Info": string ou nil esperada, obteve {typeof(desc)}`, 2)
        end

        self.FARM_DETAILS = self.FARM_DETAILS or {}

        local priorityTag = `#{priority} {title}`
        local hexColor = Library.FarmStatusColors[status]
        local formattedStatus = hexColor and `<font color="{hexColor}"><b><font size="13">{status}</font></b></font>` or `<b><font size="13">{status}</font></b>`
        local finalContent = desc and `{formattedStatus} <font size="11">{desc}</font>` or formattedStatus

        local detailObj = self.FARM_DETAILS[priority]
        if detailObj then
            detailObj:SetTitle(priorityTag)
            detailObj:SetDescription(finalContent)
            detailObj.Priority = priority
            detailObj.Status = status
            detailObj.Info = desc
        else
            detailObj = self:AddParagraph(priorityTag, finalContent)
            detailObj.DESTROY_ELEMENT.LayoutOrder = priority
            detailObj.Priority = priority
            detailObj.Status = status
            detailObj.Info = desc
            self.FARM_DETAILS[priority] = detailObj
        end
        return detailObj
    end

    function TabMethods:RemoveFarmDetail(id)
        assert(type(id) == "number", `"Tab.RemoveFarmDetail": número esperado, obteve {typeof(id)}`)
        local target = self.FARM_DETAILS and self.FARM_DETAILS[id]
        if target then
            target:Destroy()
            self.FARM_DETAILS[id] = nil
        end
    end

    function TabMethods:GetFarmDetail(id)
        assert(type(id) == "number", `"Tab.GetFarmDetail": número esperado, obteve {typeof(id)}`)
        return self.FARM_DETAILS and self.FARM_DETAILS[id]
    end

    function TabMethods:ClearFarmDetails()
        if not self.FARM_DETAILS then return end
        for id, obj in self.FARM_DETAILS do
            obj:Destroy()
        end
        table.clear(self.FARM_DETAILS)
    end

    TabMethods.AddFarmDetail = TabMethods.SetFarmDetail

    function TabMethods:AddDropdown(config)
        local title, desc = ValidateConfig("Dropdown", config)
        local flag = RetrieveFlagName("Dropdown", config[5] or config.Flag)

        local initialOptions = config[2] or config.Options
        local def = config[3] or config.Default
        local activeCallback = GetCallback(config[4] or config.Callback)
        local multiSelect = config.MultiSelect

        if def ~= nil and type(def) ~= "table" and type(def) ~= "string" then
            error(`"Tab.AddDropdown.Default": string, table ou nil esperada, obteve {typeof(def)}`, 2)
        end
        if initialOptions ~= nil and type(initialOptions) ~= "table" then
            error(`"Tab.AddDropdown.Options": tabela ou nil esperada, obteve {typeof(initialOptions)}`, 2)
        end
        if multiSelect ~= nil and type(multiSelect) ~= "boolean" then
            error(`"Tab.AddDropdown.MultiSelect": booleano ou nil esperado, obteve {typeof(multiSelect)}`, 2)
        end

        if flag and type(FlagStorage[flag]) == (multiSelect and "table" or "string") then
            def = FlagStorage[flag]
        end

        local tabRender = TabsList[self]
        local baseFrame, titleLabel, descLabel = CreateBaseOption(self, title, desc, UDim2.new(1, -150, 0, 0))

        local inputHolder = CreateInstance("Frame", baseFrame, {
            Size = UDim2.new(0, 150, 0, 18),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            Elements = { Corner = UDim.new(0, 4) },
            ThemeTag = { OBJECTS = tabRender, BackgroundColor3 = "Colors.Stroke" }
        })

        local previewLabel = CreateInstance("TextLabel", inputHolder, {
            Size = UDim2.new(0.85, 0, 0.85, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            TextScaled = true,
            Text = "...",
            ThemeTag = { OBJECTS = tabRender, TextColor3 = "Colors.Text.Default", Font = "Font.Bold" }
        })

        local arrowConfig = {
            OBJECTS = tabRender,
            Image = "Icons.Dropdown.Open",
            ImageColor3 = "Colors.Icons"
        }

        local arrowIcon = CreateInstance("ImageLabel", inputHolder, {
            Size = UDim2.fromOffset(15, 15),
            Position = UDim2.new(0, -5, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = arrowConfig
        })

        local dropInstance = ComponentClasses.Dropdown.new(self, baseFrame, titleLabel, descLabel, activeCallback)

        local currentSingleSelected
        local isThrottled = false
        local menuOpen = false

        local rawOptions = {}
        local tableSelections = {}
        local selectedRefMapping = {}
        local registryLookup = {}

        dropInstance.DROPDOWN_OPTIONS = selectedRefMapping
        dropInstance.Opened = menuOpen

        local function RefreshDropdownVisual(themeKey, iconPath)
            arrowConfig.ImageColor3 = themeKey
            arrowConfig.Image = iconPath
            Tween(arrowIcon, "ImageColor3", FetchPropertyValue(Library.CurrentTheme, themeKey), 0.3):Play()
            arrowIcon.Image = FetchPropertyValue(Library.CurrentTheme, iconPath)
        end

        local function SyncDropdownArrow(state)
            menuOpen = state
            dropInstance.Opened = state
            local themeKey = state and "Colors.Primary" or "Colors.Icons"
            local iconPath = state and "Icons.Dropdown.Close" or "Icons.Dropdown.Open"
            RefreshDropdownVisual(themeKey, iconPath)
        end

        local function CleanSyncVisual()
            SyncDropdownArrow(false)
        end

        local function FetchMultiChoices()
            local items = {}
            for text, checked in pairs(tableSelections) do
                if checked then items[#items + 1] = text end
            end
            return items
        end

        local function RenderSelectedPreviewText(value)
            local preview = type(value) == "table" and table.concat(value, ", ") or (value or "")
            if #preview >= 100 then
                preview = preview:sub(1, 97) .. "..."
            end
            previewLabel.Text = #preview ~= 0 and preview or "..."
        end

        local function DispatchCallback()
            isThrottled = false
            local data = multiSelect and FetchMultiChoices() or currentSingleSelected and currentSingleSelected.Name
            TriggerCallbacks(activeCallback, multiSelect and tableSelections or data)
            RenderSelectedPreviewText(data)
            if flag ~= nil then
                FlagStorage[flag] = data
            end
        end

        local function QueueCallback()
            if not isThrottled then
                isThrottled = true
                task.delay(0.1, DispatchCallback)
            end
        end

        local function ToggleOptionSelection(row)
            if multiSelect then
                local nextState = not row.Selected
                DropdownMasterPanel.SetOptionValue(row, nextState)
                tableSelections[row.Name] = nextState
            else
                if currentSingleSelected == row then return nil end
                if currentSingleSelected ~= nil then
                    DropdownMasterPanel.SetOptionValue(currentSingleSelected, false)
                end
                currentSingleSelected = row
                DropdownMasterPanel.SetOptionValue(row, true)
            end
            QueueCallback()
        end

        local function AddRawOption(text)
            text = tostring(text)
            if registryLookup[text] then return end

            local record = {
                Name = text,
                DisplayName = text,
                Selected = false
            }

            if multiSelect and tableSelections[text] == nil then
                tableSelections[text] = false
            end

            registryLookup[text] = record
            selectedRefMapping[#selectedRefMapping + 1] = record
            return record
        end

        local function ToggleDropdownWindow(state)
            if menuOpen == state then return end
            if not DropdownMasterPanel then
                DropdownMasterPanel = ConstructDropdownController()
            end

            if state then
                if not DropdownMasterPanel.OpenDropdown(CleanSyncVisual) then return end
                DropdownMasterPanel.SetHolder(inputHolder)
                DropdownMasterPanel.SetMultiSelect(multiSelect)
                DropdownMasterPanel.SetOnClicked(ToggleOptionSelection)
                DropdownMasterPanel.SetOptions(selectedRefMapping)
            else
                DropdownMasterPanel.CloseDropdown()
            end
            SyncDropdownArrow(state)
        end

        local function FetchItemByReference(index, mode)
            if mode and type(index) == "boolean" then
                return index == true and selectedRefMapping[mode]
            end
            return if type(index) == "number" then selectedRefMapping[index] else registryLookup[tostring(index)]
        end

        local function SelectItemRow(row)
            row.Selected = true
            if multiSelect then
                tableSelections[row.Name] = true
            else
                currentSingleSelected = row
            end
        end

        local function ParseDefaultInputs(...)
            local row = FetchItemByReference(...)
            if row then
                SelectItemRow(row)
            elseif multiSelect and type(...) == "string" then
                rawOptions[select(1, ...)] = true
            end
        end

        local function ExecuteOptionSetup()
            if not def then return end
            for i = 1, (multiSelect and #def or 1) do
                ParseDefaultInputs(def[i], i)
            end
        end

        local function OptionIsActive(row)
            if multiSelect then
                local text = row.Name
                return (tableSelections[text] or rawOptions[text]) == true
            else
                return currentSingleSelected and currentSingleSelected.Name == row.Name
            end
        end

        dropInstance.ADD_DROPDOWN_OPTION = function(opt)
            if type(opt) == "table" then
                for i = 1, #opt do
                    dropInstance:Add(opt[i])
                end
                return nil
            end

            local row = AddRawOption(opt)
            if row then
                if dropInstance.Opened then
                    DropdownMasterPanel.CreateOptionTemplate(row, true)
                end
                if OptionIsActive(row) then
                    SelectItemRow(row)
                    if row.Instance then
                        DropdownMasterPanel.SetOptionValue(row, row.Selected)
                    end
                end
                QueueCallback()
            end
        end

        dropInstance.REMOVE_DROPDOWN_OPTION = function(opt)
            local row = registryLookup[tostring(opt)]
            if row then
                local idx = table.find(selectedRefMapping, row)
                if idx then table.remove(selectedRefMapping, idx) end
                if row.Instance then row.Instance:Destroy() end
                registryLookup[row.Name] = nil
            end
        end

        dropInstance.CLEAR_DROPDOWN = function()
            for i = #selectedRefMapping, 1, -1 do
                local row = selectedRefMapping[i]
                if row.Instance then row.Instance:Destroy() end
                registryLookup[row.Name] = nil
                selectedRefMapping[i] = nil
            end
            if dropInstance.Opened then
                DropdownMasterPanel.Clear()
            end
        end

        do
            if initialOptions then
                for i = 1, #initialOptions do AddRawOption(initialOptions[i]) end
            end

            if type(def) == "table" then
                ExecuteOptionSetup()
            elseif type(def) == "string" or type(def) == "number" then
                local row = FetchItemByReference(def)
                if row then SelectItemRow(row) end
            end

            if multiSelect then
                local selectionList = FetchMultiChoices()
                task.defer(TriggerCallbacks, activeCallback, tableSelections)
                RenderSelectedPreviewText(selectionList)
            else
                local selectionText = currentSingleSelected and currentSingleSelected.Name or ""
                task.defer(TriggerCallbacks, activeCallback, selectionText)
                RenderSelectedPreviewText(selectionText)
            end
        end

        ConnectEvent(baseFrame.Activated, function() ToggleDropdownWindow(not menuOpen) end)
        return dropInstance
    end

    function TabMethods:Destroy()
        assert(type(self) == "table" and self.IS_A_TAB, `"Tab.Destroy": Instância de Tab incorreta`)
        if self.IS_DESTROYED then return end
        local idx = table.find(WindowClass, self)
        assert(idx, `"Tab.Destroy": falha ao destruir '{self.Title}'`)

        table.remove(WindowClass, idx)
        for _, el in TabConnections[self] do
            el:Destroy()
        end

        TabsList[self]:destroy()
        TabConnections[self] = nil
        TabsList[self] = nil

        setmetatable(self, nil)
        self.IS_DESTROYED = true
    end

    function TabMethods:SetVisible(state)
        assert(type(state) == "boolean", `"Tab.SetVisible": booleano esperado, obteve {typeof(state)}`)
        for _, el in TabConnections[self] do
            el.Visible = state
        end
    end

    function TabMethods:SetTitle(title)
        assert(type(title) == "string", `"Tab.SetTitle": string esperada, obteve {typeof(title)}`)
        if self.TITLE_LABEL then
            self.TITLE_LABEL.Text = Localize(title)
            for i = 1, #Library.LocalizedLabels do
                local record = Library.LocalizedLabels[i]
                if record.Instance == self.TITLE_LABEL then
                    record.Original = title
                    self.Title = title
                    return self
                end
            end
            table.insert(Library.LocalizedLabels, { Instance = self.TITLE_LABEL, Original = title })
        end
        self.Title = title
        return self
    end

    function TabMethods:Select()
        if DialogPanel == self then return end
        if DialogPanel then
            TabFlags[DialogPanel].Unselect()
        end
        DialogPanel = self
        TabFlags[DialogPanel].Select()
    end

    local function RegisterLocalizedText(lbl, srcText)
        for i = 1, #Library.LocalizedLabels do
            local item = Library.LocalizedLabels[i]
            if item.Instance == lbl then
                item.Original = srcText
                return nil
            end
        end
        table.insert(Library.LocalizedLabels, { Instance = lbl, Original = srcText })
    end

    function ComponentMethods:SetTitle(title)
        assert(type(title) == "string", `"Option.SetTitle": string esperada, obteve {typeof(title)}`)
        assert(self.TITLE_LABEL, `"Option.SetTitle": impossível alterar título deste elemento {self.Kind}`)

        self.TITLE_LABEL.Text = Localize(title)
        self.Title = title
        RegisterLocalizedText(self.TITLE_LABEL, title)
        return self
    end

    function ComponentMethods:SetDescription(desc)
        assert(desc == nil or type(desc) == "string", `"Option.SetDescription": string ou nil esperado, obteve {typeof(desc)}`)
        assert(self.DESCRIPTION_LABEL, `"Option.SetDescription": impossível alterar descrição deste elemento {self.Kind}`)

        self.DESCRIPTION_LABEL.Text = Localize(desc)
        self.Description = desc
        if desc then RegisterLocalizedText(self.DESCRIPTION_LABEL, desc) end
        return self
    end

    function ComponentMethods:SetVisible(state)
        assert(typeof(self.VISIBLE_ELEMENT) == "Instance", `"Option.SetVisible": objeto inválido para manipulação {self.Kind}`)
        assert(type(state) == "boolean", `"Option.SetVisible": booleano esperado, obteve {typeof(state)}`)
        self.VISIBLE_ELEMENT.Visible = state
    end

    function ComponentMethods:Destroy()
        assert(typeof(self.DESTROY_ELEMENT) == "Instance", `"Option.Destroy": elemento inválido para exclusão`)
        self.DESTROY_ELEMENT:Destroy()
        setmetatable(self, nil)
        self.Destroyed = true
    end

    function ComponentMethods:AddCallback(cb)
        assert(self.CALLBACKS, `"Option.AddCallback": callbacks não suportados neste elemento.`)
        assert(type(cb) == "function", `"Option.AddCallback": função esperada, obteve {typeof(cb)}`)
        table.insert(self.CALLBACKS, cb)
        return self
    end

    ComponentMethods.NewCallback = ComponentMethods.AddCallback
    ComponentMethods.SetContent = ComponentMethods.SetDescription
    ComponentMethods.SetDesc = ComponentMethods.SetDescription

    function MinimizerClass:CreateMobileMinimizer(properties)
        local minimizeBtn = CreateInstance("ImageButton", TargetScreenGui, {
            Size = UDim2.fromOffset(36, 36),
            Position = UDim2.fromScale(0.15, 0.25),
            AnchorPoint = Vector2.new(0.5, 0.5),
            AutoButtonColor = false,
            Elements = { Corner = UDim.new(0.5, 0), Stroke = { Thickness = 1.5 } },
            ThemeTag = {
                BackgroundColor3 = "Colors.Buttons.Default",
                ImageColor3 = "Colors.Primary",
                UIStroke = { Color = "Colors.Primary" }
            }
        })

        ConnectEvent(minimizeBtn.Activated, function()
            WindowClass:Minimize()
        end)

        properties.Elements = {}
        if properties.Corner then
            properties.Elements.Corner = properties.Corner
            properties.Corner = nil
        end
        if properties.Stroke then
            properties.Elements.Stroke = properties.Stroke
            properties.Stroke = nil
        end

        UI.Draggable(minimizeBtn, ScalerObject, 0.5)
        UI.SetProperties(minimizeBtn, properties)
        return minimizeBtn
    end

    function MinimizerClass:SetKeyCode(key)
        assert(IsValidKey(key), `"Minimizer.SetKeyCode": KeyCode esperado, obteve {typeof(key)}`)
        self.KeyCode = key
    end

    function WindowClass:SelectTab(val)
        local target = type(val) == "number" and WindowClass[val]
        if type(val) == "table" and val.IS_A_TAB then
            target = val
        end

        if target then
            target:Select()
        else
            assert(type(val) == "number", `"Window.SelectTab": número ou instância de tab esperada, obteve {typeof(val)}`)
            assert(val > 0, `"Window.SelectTab": índice precisa ser maior que 0`)
            assert(val == math.floor(val), `"Window.SelectTab": índice precisa ser inteiro`)
            self.SelectedTab = val
        end
    end

    function WindowClass:Minimize()
        MainFrameObj.Visible = not MainFrameObj.Visible
    end

    function WindowClass:MakeTab(config)
        local title = config[1] or config.Name or config.Title
        local icon = config[2] or config.Icon or config.Image

        assert(type(title) == "string", `"Tab.Title": string esperada, obteve {typeof(title)}`)
        assert(icon == nil or type(icon) == "string", `"Tab.Icon": string ou nil esperada, obteve {typeof(icon)}`)

        local tabInst = setmetatable({
            Selected = self.SelectedTab == #WindowClass + 1,
            Icon = Library:GetIconByName(icon),
            Title = title,
            Parent = self,
            IS_A_TAB = true
        }, TabMethods)

        local subElems = self:GetElements()
        local headersGroup = subElems.TabsContainer
        local viewportsGroup = subElems.ContainerHolder

        local headerButton, scrollContainer, accentGlow = CreateTabHeader(tabInst, headersGroup)
        tabInst.TITLE_LABEL = headerButton.Title

        local syncSizeTween = Tween(scrollContainer, "Size", UDim2.new(1, 0, 1, 0), 0.3)
        local boundsSize = UDim2.new(1, 0, 1, 150)

        local tweenGroupSelected = {
            Tween(accentGlow, "BackgroundTransparency", 0, 0.4),
            Tween(accentGlow, "Size", UDim2.fromOffset(4, 16), 0.4)
        }
        local tweenGroupUnselected = {
            Tween(accentGlow, "BackgroundTransparency", 1, 0.4),
            Tween(accentGlow, "Size", UDim2.fromOffset(4, 4), 0.4)
        }

        local itemRender = MasterRender:new()
        TabsList[tabInst] = itemRender

        local function RunTweens(list)
            for i = 1, #list do list[i]:Play() end
        end

        local function Select()
            RunTweens(tweenGroupSelected)
            tabInst.Selected = true
            itemRender:changeRendering(true)
            itemRender:update()
            scrollContainer.Parent = viewportsGroup
            scrollContainer.Size = boundsSize
            syncSizeTween:Play()
        end

        local function Unselect()
            RunTweens(tweenGroupUnselected)
            tabInst.Selected = false
            scrollContainer.Parent = nil
            itemRender:changeRendering(false)
        end

        TabFlags[tabInst] = table.freeze({
            Unselect = Unselect,
            Select = Select
        })

        TabConnections[tabInst] = table.freeze({
            SelectTabButton = headerButton,
            Container = scrollContainer
        })

        table.insert(WindowClass, tabInst)

        ConnectEvent(headerButton.Activated, function()
            tabInst:Select()
        end)

        if tabInst.Selected then
            tabInst:Select()
        end

        return tabInst
    end

    function WindowClass:StartWindow(config)
        local minimizeBtn = config.MinimizeButton
        local mainFrame = config.MainFrame
        local resizeElems = config.Resizers
        local topBar = config.TopBar

        local subTitleLabel = config.SubTitle
        local titleLabel = config.Title

        DropdownMasterPanel = config.Dropdowns
        MainFrameObj = config.MainFrame
        ScalerObject = config.UIScale
        FlagStorage = config.Flags

        local initSize = mainFrame.Size
        local throttleAction = 0

        function WindowClass:MinimizeButton()
            if (tick() - throttleAction) < 0 then
                return false
            end
            if self.Minimized then
                minimizeBtn.Image = "rbxassetid://10734896206"
                Tween(mainFrame, "Size", initSize, 0.25):Play()
            else
                initSize = mainFrame.Size
                minimizeBtn.Image = "rbxassetid://10734924532"
                Tween(mainFrame, "Size", UDim2.fromOffset(mainFrame.Size.X.Offset, topBar.Size.Y.Offset), 0.25):Play()
            end

            for _, obj in resizeElems do
                obj.Visible = self.Minimized
            end

            self.Minimized = not self.Minimized
            throttleAction = tick() + 0.5
            return true
        end

        function WindowClass:GetTitle()
            return titleLabel.Text
        end

        function WindowClass:GetSubTitle()
            return subTitleLabel.Text
        end

        function WindowClass:SetTitle(text)
            assert(type(text) == "string", `"Window.SetTitle": string esperada, obteve {typeof(text)}`)
            assert(#text > 0, `"Window.SetTitle": o título precisa ser maior que zero caracteres`)
            titleLabel.Text = text
        end

        function WindowClass:SetSubTitle(text)
            assert(type(text) == "string", `"Window.SetSubTitle": string esperada, obteve {typeof(text)}`)
            assert(#text > 0, `"Window.SetSubTitle": o subtítulo precisa ser maior que zero caracteres`)
            subTitleLabel.Text = text
        end

        NotificationArea = CreateInstance("Frame", TargetScreenGui, {
            Size = UDim2.new(0, 280, 1, 0),
            Position = UDim2.fromScale(1, 0),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Elements = {
                Padding = { PaddingBottom = UDim.new(0, 20) },
                ListLayout = {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 15)
                }
            }
        })

        DialogContainer = CreateInstance("TextButton", "OutBox", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 0.45,
            AutoButtonColor = false,
            Text = "",
            ThemeTag = { BackgroundColor3 = "Colors.Background" },
            Childs = {
                mainFrame:FindFirstChildOfClass("UICorner"):Clone(),
                CreateInstance("Frame", "Template", {
                    Size = UDim2.new(0.35, 60, 0.20, 80),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Active = true,
                    Elements = {
                        Corner = UDim.new(0, 8),
                        Stroke = { Thickness = 1.5, ThemeTag = { Color = "Colors.Stroke" } },
                        Gradient = {
                            Rotation = 45,
                            ThemeTag = { Color = "Colors.Background" }
                        }
                    },
                    Childs = {
                        CreateInstance("TextLabel", "Title", {
                            Size = UDim2.new(1, -20, 0, 20),
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            TextSize = 14,
                            Position = UDim2.new(0.5, 0, 0, 22),
                            AnchorPoint = Vector2.new(0.5, 0),
                            BackgroundTransparency = 1,
                            ThemeTag = { Font = "Font.ExtraBold", TextColor3 = "Colors.Text.Default" }
                        }),
                        CreateInstance("TextLabel", "Description", {
                            Position = UDim2.new(0.5, 0, 0, 42),
                            Size = UDim2.new(1, -20, 0, 0),
                            AnchorPoint = Vector2.new(0.5, 0),
                            TextWrapped = true,
                            TextSize = 11,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundTransparency = 1,
                            ThemeTag = { TextColor3 = "Colors.Text.Darker", Font = "Font.Medium" }
                        }),
                        CreateInstance("Frame", "Options", {
                            Size = UDim2.new(1, -20, 0.15, 18),
                            Position = UDim2.new(0.5, 0, 1, -10),
                            AnchorPoint = Vector2.new(0.5, 1),
                            BackgroundTransparency = 1,
                            Elements = {
                                Padding = {
                                    PaddingLeft = UDim.new(0, 10),
                                    PaddingRight = UDim.new(0, 10),
                                    PaddingBottom = UDim.new(0, 24),
                                    PaddingTop = UDim.new(0, 24)
                                },
                                ListLayout = {
                                    HorizontalAlignment = Enum.HorizontalAlignment.Right,
                                    VerticalAlignment = Enum.VerticalAlignment.Center,
                                    FillDirection = Enum.FillDirection.Horizontal,
                                    Padding = UDim.new(0, 8)
                                }
                            }
                        })
                    }
                })
            }
        })

        DialogContainer.Template:SetAttribute("OriginalSize", DialogContainer.Template.Size)

        ConnectEvent(DialogContainer.Activated, function()
            if DialogPanel ~= nil and not DialogPanel.Closing and not DialogPanel.Closed then
                DialogPanel:Close()
            end
        end)

        WindowClass.StartWindow = nil
    end

    function WindowClass:DeleteFlags()
        return FlagStorage()
    end

    function WindowClass:SetFlag(key, val)
        assert(type(key) == "string", `"Window.SetFlag": string esperada, obteve {typeof(key)}`)
        FlagStorage[key] = val
    end

    function WindowClass:GetFlag(key)
        return FlagStorage[key]
    end

    function WindowClass:ReadFile(path)
        assert(type(path) == "string", `"Window.ReadFile": string esperada, obteve {typeof(path)}`)
        path = `{self.ScriptFolder}/{path}`
        if readfile ~= nil and (isfile == nil or isfile(path)) then
            return readfile(path)
        end
    end

    function WindowClass:WriteFile(path, contents)
        assert(type(path) == "string", `"Window.WriteFile": string esperada, obteve {typeof(path)}`)
        path = `{self.ScriptFolder}/{path}`

        if contents ~= nil and type(contents) ~= "string" then
            error(`"Window.WriteFile": string ou nil esperado, obteve {typeof(contents)}`, 2)
        end

        if contents == nil then
            if delfile ~= nil then
                delfile(path)
                return true
            end
        else
            if writefile ~= nil then
                if makefolder then
                    local segments = path:split("/")
                    segments[#segments] = nil
                    local dir = table.concat(segments, "/")
                    if dir ~= "" and (isfolder == nil or not isfolder(dir)) then
                        makefolder(dir)
                    end
                end
                writefile(path, contents)
                return true
            end
        end
        return false
    end

    function WindowClass:NewMinimizer(key)
        local code = type(key) == "table" and (key[1] or key.KeyCode) or key
        if not IsValidKey(code) then
            error(`"Window.NewMinimizer.KeyCode": KeyCode esperado, obteve {typeof(code)}`, 2)
        end

        local inst = setmetatable({ KeyCode = code }, MinimizerClass)
        ConnectEvent(UserInputService.InputBegan, function(input)
            if input.KeyCode == inst.KeyCode then
                WindowClass:Minimize()
            end
        end)
        return inst
    end

    function WindowClass:Dialog(config)
        if self.Minimized then
            while not self:MinimizeButton() do task.wait() end
        end
        if DialogPanel then
            DialogPanel:Close(true)
        end

        local title = config.Title or config.Name
        local desc = config.Content or config.Description
        local options = config.Options

        assert(type(title) == "string", `"Window.Dialog.Title": string esperada, obteve {typeof(title)}`)
        assert(type(desc) == "string", `"Window.Dialog.Content": string esperada, obteve {typeof(desc)}`)
        assert(type(options) == "table", `"Window.Dialog.Options": tabela esperada, obteve {typeof(options)}`)
        assert(#options > 0, `"Window.Dialog.Options" necessita de uma ou mais opções.`)

        local function Build()
            local tmpl = DialogContainer.Template
            local descLabel = tmpl.Description
            local titleLabel = tmpl.Title

            local defaultSize = tmpl:GetAttribute("OriginalSize")
            local targetSize = UDim2.new(defaultSize.X.Scale * 1.15, defaultSize.X.Offset, defaultSize.Y.Scale * 1.15, defaultSize.Y.Offset)

            tmpl.Size = targetSize
            DialogContainer.Parent = MainFrameObj
            descLabel.Text = desc
            titleLabel.Text = title

            Tween(tmpl, "Size", defaultSize, 0.25):Play()

            local inst = ComponentClasses.Dialog.new(descLabel, titleLabel)
            inst.NEW_SIZE = targetSize
            inst.TEMPLATE = tmpl

            for _, child in tmpl.Options:GetChildren() do
                if child:IsA("GuiObject") then child:Destroy() end
            end
            for i = #options, 1, -1 do
                inst:NewOption(options[i])
            end
            return inst
        end

        DialogPanel = Build()
        return DialogPanel
    end

    function WindowClass:SetNotifyDefaultIcon(id)
        assert(type(id) == "string", `"Window.SetNotifyDefaultIcon": string esperada, obteve {typeof(id)}`)
        GlobalNotificationDefaultIcon = id
    end

    function WindowClass:Notify(config)
        if type(config) ~= "table" then config = {} end
        local title = config[1] or config.Name or config.Title
        local content = config[2] or config.Content
        local icon = config[3] or config.Icon or config.Image
        local duration = config[4] or config.Duration or config.Countdown or config.Time

        if self.NOTIFICATION_GROUP then
            duration = duration or self.Duration
            content = content or self.Content
            title = title or self.Title
            icon = icon or self.Icon
        end

        assert(type(title) == "string", `"Window.Notify.Title": string esperada, obteve {typeof(title)}`)
        assert(type(content) == "string", `"Window.Notify.Content": string esperada, obteve {typeof(content)}`)
        assert(icon == nil or type(icon) == "string", `"Window.Notify.Icon": string ou nil esperada, obteve {typeof(icon)}`)

        duration = duration or 5

        local notificationFrame = CreateInstance("Frame", "Notification", NotificationArea, {
            Size = UDim2.new(0.85, 0, 0, 56),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        })

        local widget = CreateInstance("TextButton", notificationFrame, {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 1),
            AutoButtonColor = false,
            Text = "",
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
            Elements = {
                Corner = UDim.new(0, 6),
                Stroke = { Thickness = 1, ThemeTag = { Color = "Colors.Stroke" } },
                Gradient = {
                    Rotation = 45,
                    ThemeTag = { Color = "Colors.Background" }
                }
            }
        })

        local zoomScale = CreateInstance("UIScale", notificationFrame)

        local rightHolder = CreateInstance("Frame", "Holder", widget, {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Elements = {
                ListLayout = {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 4)
                },
                Padding = {
                    PaddingBottom = UDim.new(0, 6),
                    PaddingTop = UDim.new(0, 6),
                    PaddingLeft = UDim.new(0, 40)
                }
            }
        })

        local titleLabel = CreateInstance("TextLabel", rightHolder, {
            Size = UDim2.new(1, 0, 0, 18),
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Bottom,
            BackgroundTransparency = 1,
            TextSize = 13,
            ThemeTag = { TextColor3 = "Colors.Primary", Font = "Font.Bold" }
        })

        local contentLabel = CreateInstance("TextLabel", rightHolder, {
            Size = UDim2.new(1, 0, 0, 18),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            TextWrapped = true,
            TextSize = 10,
            ThemeTag = { TextColor3 = "Colors.Text.Dark", Font = "Font.Normal" }
        })

        local graphicIcon = CreateInstance("ImageLabel", widget, {
            Size = UDim2.fromOffset(22, 22),
            Position = UDim2.new(0, 8, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = { ImageColor3 = "Colors.Primary" }
        })

        local timerLabel = CreateInstance("TextLabel", widget, {
            Size = UDim2.new(0, 40, 0, 16),
            Position = UDim2.new(1, -10, 0, 6),
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            TextSize = 9,
            ThemeTag = { TextColor3 = "Colors.Text.Darker", Font = "Font.Normal" }
        })

        local isHeld = false
        local scaleHover = Tween(zoomScale, "Scale", 1.05, 0.25)
        local scaleLeave = Tween(zoomScale, "Scale", 1.00, 0.25)

        local notifyInst = setmetatable({
            TITLE_LABEL = titleLabel,
            DESCRIPTION_LABEL = contentLabel,
            VISIBLE_ELEMENT = notificationFrame,
            DESTROY_ELEMENT = notificationFrame,
            NOTIFICATION = widget,
            Kind = "Notification",
            Closed = false,
            Parent = self
        }, ComponentMethods)

        function notifyInst:Close()
            if self.Closed then return end
            self.Closed = true
            local slide = Tween(widget, "Position", UDim2.fromScale(2.5, 0), 0.5)
            slide:Play()
            slide.Completed:Wait()
            notificationFrame:Destroy()
        end

        local function Countdown()
            icon = Library:GetIconByName(icon or GlobalNotificationDefaultIcon)
            graphicIcon.Image = icon

            if not IsAssetId(icon) then
                graphicIcon.Visible = false
                rightHolder.UIPadding.PaddingLeft = UDim.new(0, 12)
            end

            widget.Position = UDim2.fromScale(2.5, 0)
            Tween(widget, "Position", UDim2.fromScale(0, 0), 0.35):Play()

            titleLabel.Text = title
            contentLabel.Text = content

            local onLeave = widget.MouseLeave
            while duration > 0 do
                timerLabel.Text = FormatTime(duration)
                if isHeld then onLeave:Wait() end
                duration -= task.wait()
            end
            notifyInst:Close()
        end

        ConnectEvent(widget.MouseButton1Down, function() scaleHover:Play() isHeld = true end)
        ConnectEvent(widget.MouseLeave, function() scaleLeave:Play() isHeld = false end)

        task.defer(Countdown)
        return notifyInst
    end

    function WindowClass:NewNotifyGroup(config)
        local title = config[1] or config.Name or config.Title
        local content = config[2] or config.Content
        local icon = config[3] or config.Icon or config.Image
        local duration = config[4] or config.Duration or config.Countdown or config.Time

        if title ~= nil and type(title) ~= "string" then
            error(`"Window.NewNotifyGroup.Title": string ou nil esperado, obteve {typeof(title)}`, 2)
        end
        if content ~= nil and type(content) ~= "string" then
            error(`"Window.NewNotifyGroup.Content": string ou nil esperado, obteve {typeof(content)}`, 2)
        end
        if icon ~= nil and type(icon) ~= "string" then
            error(`"Window.NewNotifyGroup.Icon": string ou nil esperado, obteve {typeof(icon)}`, 2)
        end
        if duration ~= nil and type(duration) ~= "number" then
            error(`"Window.NewNotifyGroup.Time": número ou nil esperado, obteve {typeof(duration)}`, 2)
        end

        return {
            NOTIFICATION_GROUP = true,
            Notify = WindowClass.Notify,
            Duration = duration,
            Content = content,
            Title = title,
            Icon = icon
        }
    end

    function WindowClass:GetTabByTitle(title)
        assert(type(title) == "string", `"Window.GetTabByTitle": string esperada, obteve {typeof(title)}`)
        for i = 1, #WindowClass do
            if WindowClass[i].Title == title then
                return WindowClass[i]
            end
        end
    end

    WindowClass.NewNotificationGroup = WindowClass.NewNotifyGroup
    WindowClass.SetDefaultNotifyIcon = WindowClass.SetNotifyDefaultIcon
    WindowClass.GetTabByName = WindowClass.GetTabByTitle
    WindowClass.Notificafion = WindowClass.Notify

    LibraryWindow.Window = WindowClass
end

local function ConstructStructureContainers(config, topBar)
    local barOffset = topBar.Size.Y.Offset
    local width = config.TabSize or Library.Default.TabSize

    local sidebar = CreateInstance("ScrollingFrame", "TabsScroll", {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        ScrollBarThickness = 2.2,
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 0.2,
        CanvasSize = UDim2.new(),
        BorderSizePixel = 0,
        Size = UDim2.new(0, width, 1, -barOffset),
        ThemeTag = { ScrollBarImageColor3 = "Colors.ScrollBar" },
        Elements = {
            Padding = { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10) },
            ListLayout = { Padding = UDim.new(0, 5) }
        }
    })

    local containerArea = CreateInstance("Frame", "Containers", {
        Size = UDim2.new(1, -width, 1, -barOffset),
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })

    return sidebar, containerArea
end

function Library:GetIconByName(name)
    if name == nil then return end
    assert(name, `"Library.GetIconByName": String esperada, obteve {typeof(name)}`)

    if IsAssetId(name) or #name == 0 then
        return name
    end

    local norm = CleanString(name)
    if self.Icons[norm] then
        return "rbxassetid://" .. self.Icons[norm]
    end

    for key, id in self.Icons do
        if key:find(norm, 1, true) then
            return "rbxassetid://" .. id
        end
    end
end

function Library:IsValidTheme(name)
    assert(type(name) == "string", `"Library.IsValidTheme": String esperada, obteve {typeof(name)}`)
    return self.Themes[name] ~= nil
end

function Library:GetThemes()
    local names = {}
    for k, _ in self.Themes do
        table.insert(names, k)
    end
    return names
end

function Library:GetTheme(name)
    assert(name == nil or type(name) == "string", `"Library.GetTheme": string ou nil esperado`)
    if name == nil then
        return self.CurrentTheme
    end
    local target = self.Themes[name]
    assert(target ~= nil, `"Library.GetTheme": tema não encontrado: '{name}'`)
    return target
end

function Library:SetTheme(name)
    assert(type(name) == "string", `"Library.SetTheme": string esperada`)
    local target = self.Themes[name]
    assert(target, `"Library.SetTheme": tema não encontrado: '{name}'`)

    self.CurrentTheme = target
    self.WindowSettings.SelectedTheme = target.Name
    MasterRender:update()
end

function Library:SetUIScale(scale)
    local min = ThemeScales.MIN_SCALE
    local max = ThemeScales.MAX_SCALE

    assert(type(scale) == "number", `"Library.SetUIScale": número esperado`)
    assert(scale >= min and scale <= max, `"Library.SetUIScale": Escala fora dos limites. Min: {min}, Max: {max}`)

    TargetScreenGui.Scale.Scale = ScaleToViewport(scale)
end

function Library:GetMaxScale() return ThemeScales.MAX_SCALE end
function Library:GetMinScale() return ThemeScales.MIN_SCALE end

function Library:GetCurrentTheme()
    if not self.LOADED_UI_LIBRARY then
        return error("Falha ao puxar o tema atual: UI não foi carregada", 2)
    end
    return self.CurrentTheme
end

function Library:Destroy()
    for _, conn in self.Connections do
        conn:Disconnect()
    end
    if TargetScreenGui and TargetScreenGui:GetAttribute("UID") == self.SCREENGUI_UID then
        pcall(TargetScreenGui.Destroy, TargetScreenGui)
    end
end

function Library:MakeWindow(config)
    if self.LOADED_UI_LIBRARY then
        return error("Você pode instanciar somente um painel (Window)", 2)
    end

    local uid = math.random()
    TargetScreenGui:SetAttribute("UID", uid)
    self.SCREENGUI_UID = uid
    TargetScreenGui:ClearAllChildren()

    local windowScaler = CreateInstance("UIScale", "Scale", TargetScreenGui, {
        Scale = ScaleToViewport(1)
    })

    local winInfo = {
        Title = config[1] or config.Name or config.Title,
        SubTitle = config[2] or config.SubName or config.SubTitle,
        ScriptFolder = config[3] or config.ScriptFolder or config.FolderName
    }

    assert(type(winInfo.Title) == "string", `"Window.Title": string esperada`)
    assert(type(winInfo.SubTitle) == "string", `"Window.SubTitle": string esperada`)

    if winInfo.ScriptFolder ~= nil and type(winInfo.ScriptFolder) ~= "string" then
        return error(`"Window.ScriptFolder": string ou nil esperado, obteve {typeof(winInfo.ScriptFolder)}`, 2)
    end
    if winInfo.ScriptFolder ~= nil and string.find(winInfo.ScriptFolder, "/") then
        return error(`"Window.ScriptFolder" inválido: caracteres inesperados "/" contidos.`, 2)
    end

    local settingsMeta = (function()
        local folder = winInfo.ScriptFolder
        local queued = false
        local dataTable

        local ok, result = pcall(function()
            return folder and HttpService:JSONDecode(readfile(`{folder}/LibrarySettings.json`))
        end)

        if type(result) ~= "table" then result = {} end

        local function Save()
            queued = false
            return pcall(function()
                return writefile(`{folder}/LibrarySettings.json`, HttpService:JSONEncode(dataTable))
            end)
        end

        local function OnWrite(t, k, v)
            rawset(dataTable, k, v)
            if folder and not queued then
                queued = true
                task.delay(0.5, Save)
            end
        end

        dataTable = result
        return setmetatable({}, {
            __newindex = OnWrite,
            __index = dataTable
        })
    end)()

    local flagsMeta = (function()
        local folder = winInfo.ScriptFolder
        local queued = false
        local dataTable

        local ok, result = pcall(function()
            return folder and HttpService:JSONDecode(readfile(`{folder}/ScriptFlags.json`))
        end)

        if type(result) ~= "table" then result = {} end

        local function Save()
            queued = false
            return pcall(function()
                writefile(`{folder}/ScriptFlags.json`, HttpService:JSONEncode(dataTable))
            end)
        end

        local function OnWrite(t, k, v)
            rawset(dataTable, k, v)
            if folder and not queued then
                queued = true
                task.delay(0.5, Save)
            end
        end

        local function Clear()
            table.clear(dataTable)
            return pcall(function()
                return folder and delfile(`{folder}/ScriptFlags.json`)
            end)
        end

        dataTable = result
        return setmetatable({}, {
            __newindex = OnWrite,
            __call = Clear,
            __index = dataTable
        })
    end)()

    self.ThemesObjects = MasterRender
    self.WindowSettings = settingsMeta
    self.Flags = flagsMeta

    self.Icons = (function()
        local folder = winInfo.ScriptFolder
        local ok, result = pcall(function()
            return loadstring(readfile(`{folder}/Icons.lua`))()
        end)

        if ok and type(result) == "table" then
            return result
        end

        local host = `https://raw.githubusercontent.com/{self.Information.GitHubOwner}`
        local url = `{host}/Library/refs/heads/main/redz-V5-remake/Utils/Icons.lua`
        local code

        local function SaveIcons()
            return writefile(`{folder}/Icons.lua`, code)
        end

        local fetchOk, fetchedResult = pcall(function()
            code = game:HttpGet(url)
            return loadstring(code)()
        end)

        if fetchOk and type(fetchedResult) == "table" then
            if type(code) == "string" then pcall(SaveIcons) end
            return fetchedResult
        end
        return {}
    end)()

    if type(settingsMeta.SelectedTheme) == "string" and self:IsValidTheme(settingsMeta.SelectedTheme) then
        self:SetTheme(settingsMeta.SelectedTheme)
    else
        self:SetTheme(self.Default.Theme)
    end

    self.LOADED_UI_LIBRARY = true
    local uiSize = self.Default.UISize

    if settingsMeta and type(settingsMeta.UISize) == "table" then
        local w, h = unpack(settingsMeta.UISize)
        if type(w) == "number" and type(h) == "number" then
            uiSize = UDim2.fromOffset(math.clamp(w, 430, 1000), math.clamp(h, 200, 500))
        end
    end

    local windowFrame = CreateInstance("Frame", "Window", TargetScreenGui, {
        Position = UDim2.new(0.5, -uiSize.X.Offset / 2, 0.5, -uiSize.Y.Offset / 2),
        Active = true,
        Size = uiSize,
        ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
        Elements = {
            Corner = UDim.new(0, 10),
            Stroke = { Thickness = 1.5, ThemeTag = { Color = "Colors.Stroke" } },
            Gradient = {
                Rotation = 45,
                ThemeTag = { Color = "Colors.Background" }
            }
        }
    })

    -- ==========================================================
    -- SISTEMA DE PARTÍCULAS E FX CYBERPUNK PREMIUM
    -- ==========================================================
    local fxContainer = Instance.new("Frame")
    fxContainer.Name = "VisualFX"
    fxContainer.Size = UDim2.new(1, 0, 1, 0)
    fxContainer.BackgroundTransparency = 1
    fxContainer.ClipsDescendants = true
    fxContainer.Parent = windowFrame

    local fxActive = true

    local function SpawnPixelParticle()
        local size = math.random(2, 4)
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, size, 0, size)
        particle.Position = UDim2.new(math.random(0, 100) / 100, 0, 1.05, 0)
        particle.BackgroundColor3 = Color3.fromRGB(255, 30, 60) -- Glow Vermelho Neon
        particle.BackgroundTransparency = 0.4
        particle.BorderSizePixel = 0
        particle.Parent = fxContainer

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle

        local life = math.random(4, 8)
        local motionTween = TweenService:Create(particle, TweenInfo.new(life, Enum.EasingStyle.Linear), {
            Position = UDim2.new(particle.Position.X.Scale, 0, -0.05, 0),
            BackgroundTransparency = 1
        })
        motionTween:Play()
        motionTween.Completed:Connect(function()
            if particle then particle:Destroy() end
        end)
    end

    local function SpawnMatrixLine()
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, 1, math.random(6, 18) / 100, 0)
        line.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.15, 0)
        line.BackgroundColor3 = Color3.fromRGB(150, 15, 35) -- Rastro Vermelho Sombrio
        line.BackgroundTransparency = 0.65
        line.BorderSizePixel = 0
        line.Parent = fxContainer

        local speed = math.random(3, 5)
        local motionTween = TweenService:Create(line, TweenInfo.new(speed, Enum.EasingStyle.Linear), {
            Position = UDim2.new(line.Position.X.Scale, 0, 1.15, 0)
        })
        motionTween:Play()
        motionTween.Completed:Connect(function()
            if line then line:Destroy() end
        end)
    end

    task.spawn(function()
        while fxActive do
            SpawnPixelParticle()
            task.wait(0.18)
        end
    end)

    task.spawn(function()
        while fxActive do
            SpawnMatrixLine()
            task.wait(0.35)
        end
    end)

    ConnectEvent(windowFrame.Destroying, function()
        fxActive = false
        self:Destroy()
    end)

    ConnectEvent(TargetScreenGui:GetAttributeChangedSignal("UID"), function()
        fxActive = false
        self:Destroy()
        windowFrame:Destroy()
    end)

    UI.Draggable(windowFrame, windowScaler, 0.5)

    local componentsFolder = CreateInstance("Folder", "Components", windowFrame)
    local dropdownsFolder = CreateInstance("Folder", "Dropdowns", TargetScreenGui)

    local topBar = CreateInstance("Frame", "TopBar", componentsFolder, {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1
    })

    local windowTitleLabel = CreateInstance("TextLabel", "Title", topBar, {
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0, 15, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Text = Localize(winInfo.Title),
        TextSize = 13,
        BackgroundTransparency = 1,
        ThemeTag = {
            TextColor3 = "Colors.Primary",
            Font = "Font.Bold"
        },
        Childs = {
            CreateInstance("TextLabel", "SubTitle", {
                Size = UDim2.fromScale(0, 1),
                AutomaticSize = "X",
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(1, 5, 0.85),
                Text = Localize(winInfo.SubTitle),
                BackgroundTransparency = 1,
                TextXAlignment = "Left",
                TextYAlignment = "Bottom",
                TextSize = 8.5,
                ThemeTag = {
                    TextColor3 = "Colors.Text.Dark",
                    Font = "Font.Normal"
                }
            })
        }
    })

    table.insert(Library.LocalizedLabels, { Instance = windowTitleLabel, Original = winInfo.Title })
    table.insert(Library.LocalizedLabels, { Instance = windowTitleLabel.SubTitle, Original = winInfo.SubTitle })

    local topButtons = CreateInstance("Folder", "Buttons", topBar, {
        Childs = {
            CreateInstance("ImageButton", "Close", {
                Size = UDim2.fromOffset(14, 14),
                Position = UDim2.new(1, -12, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                ImageColor3 = Color3.fromRGB(255, 45, 55),
                AutoButtonColor = false,
                ThemeTag = { Image = "Icons.Close" }
            }),
            CreateInstance("ImageButton", "Minimize", {
                Size = UDim2.fromOffset(14, 14),
                Position = UDim2.new(1, -34, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                ImageColor3 = Color3.fromRGB(240, 240, 240),
                Image = "rbxassetid://10734896206",
                AutoButtonColor = false
            })
        }
    })

    local minimizeBtn = topButtons.Minimize
    local closeBtn = topButtons.Close

    local rootContext = setmetatable(winInfo, {
        __index = LibraryWindow.Window
    })

    local sidebarArea, mainContainersHolder = ConstructStructureContainers(settingsMeta, topBar)
    sidebarArea.Parent = componentsFolder
    mainContainersHolder.Parent = componentsFolder

    local elementHierarchy = table.freeze({
        ContainerHolder = mainContainersHolder,
        TabsContainer = sidebarArea,
        Components = componentsFolder,
        MainFrame = windowFrame
    })

    function rootContext:GetElements()
        return elementHierarchy
    end

    local windowResizeHandle = CreateInstance("Frame", "ControlWindowSize", windowFrame, {
        Size = UDim2.fromOffset(16, 16),
        Position = windowFrame.Size,
        AnchorPoint = Vector2.new(0.8, 0.8),
        BackgroundTransparency = 1,
        Active = true
    })

    local sidebarResizeHandle = CreateInstance("Frame", "ControlTabsSize", windowFrame, {
        Size = UDim2.new(0, 16, 0.75, -30),
        Position = UDim2.new(0, sidebarArea.Size.X.Offset, 0.5, 15),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Active = true
    })

    local function TriggerResizeEffect(handle)
        local ongoing = handle:GetAttribute("Resizing")
        handle:SetAttribute("Resizing", tick())
        if ongoing and (tick() - ongoing) <= 0.1 then return end

        handle.BackgroundTransparency = 0.6
        while tick() - handle:GetAttribute("Resizing") <= 0.1 do task.wait() end
        handle.BackgroundTransparency = 1
    end

    ConnectEvent(windowResizeHandle:GetPropertyChangedSignal("Position"), function()
        TriggerResizeEffect(windowResizeHandle)
        local target = windowResizeHandle.Position
        windowFrame.Size = target
        settingsMeta.UISize = { target.X.Offset, target.Y.Offset }
    end)

    ConnectEvent(sidebarResizeHandle:GetPropertyChangedSignal("Position"), function()
        TriggerResizeEffect(sidebarResizeHandle)
        local target = sidebarResizeHandle.Position
        sidebarArea.Size = UDim2.new(0, target.X.Offset, 1, -topBar.Size.Y.Offset)
        mainContainersHolder.Size = UDim2.new(1, -sidebarArea.Size.X.Offset, 1, -topBar.Size.Y.Offset)
        settingsMeta.TabSize = target.X.Offset
    end)

    UI.Draggable(windowResizeHandle, windowScaler, 0.65, function(sx, ox, sy, oy)
        return UDim2.fromOffset(math.clamp(ox, 430, 1000), math.clamp(oy, 200, 500))
    end)

    UI.Draggable(sidebarResizeHandle, windowScaler, 0.65, function(sx, ox)
        return UDim2.new(0, math.clamp(ox, 135, 210), 0.5, 15)
    end)

    local closeConfirmDialog = {
        Title = "Fechar Painel?",
        Content = "Tem certeza de que deseja fechar a interface do script?",
        Options = {
            {
                Title = "Sim",
                Callback = function() self:Destroy() end
            },
            {
                Title = "Não"
            }
        }
    }

    ConnectEvent(minimizeBtn.MouseEnter, function() Tween(minimizeBtn, "ImageTransparency", 0.5, 0.25):Play() end)
    ConnectEvent(minimizeBtn.MouseLeave, function() Tween(minimizeBtn, "ImageTransparency", 0, 0.25):Play() end)

    ConnectEvent(closeBtn.MouseEnter, function() Tween(closeBtn, "ImageTransparency", 0.5, 0.25):Play() end)
    ConnectEvent(closeBtn.MouseLeave, function() Tween(closeBtn, "ImageTransparency", 0, 0.25):Play() end)

    rootContext.SetUIScale = self.SetUIScale
    rootContext.SUBTITLE_LABEL = windowTitleLabel.SubTitle
    rootContext.TITLE_LABEL = windowTitleLabel

    rootContext:StartWindow{
        Resizers = { windowResizeHandle, sidebarResizeHandle },
        MinimizeButton = minimizeBtn,
        Dropdowns = dropdownsFolder,
        MainFrame = windowFrame,
        TopBar = topBar,
        SubTitle = windowTitleLabel.SubTitle,
        Title = windowTitleLabel,
        UIScale = windowScaler,
        Flags = flagsMeta
    }

    ConnectEvent(minimizeBtn.Activated, function()
        rootContext:MinimizeButton()
    end)

    ConnectEvent(closeBtn.Activated, function()
        rootContext:Dialog(closeConfirmDialog)
    end)

    return rootContext
end

return Library