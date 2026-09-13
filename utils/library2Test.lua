-- ==========================================================
-- REDZ LIBRARY V5 - FULL EXPANDED EDITION (PARTICLES & ANIMS)
-- ==========================================================

local cloneref = cloneref or (function(...) return ... end)
local delfolder = delfolder or deletefolder
local delfile = delfile or deletefile
local makefolder = makefolder
local writefile = writefile
local readfile = readfile

local Services = setmetatable({}, {
    __index = function(self, serviceName)
        local service = cloneref(game:GetService(serviceName))
        rawset(self, serviceName, service)
        return service
    end
})

local MarketplaceService = Services.MarketplaceService
local UserInputService   = Services.UserInputService
local TweenService       = Services.TweenService
local HttpService        = Services.HttpService
local RunService         = Services.RunService
local Players            = Services.Players

local Heartbeat = RunService.Heartbeat
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CoreGui = (gethui or function() return Services.CoreGui end)()

-- ==========================================================
-- TEMAS & CORES DA INTERFACE
-- ==========================================================
local ThemesList = {
    Darker = {
        Colors = {
            Background = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(18, 18, 22)),
                ColorSequenceKeypoint.new(0.50, Color3.fromRGB(26, 26, 32)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(18, 18, 22))
            },
            Primary = Color3.fromRGB(255, 35, 65),
            OnPrimary = Color3.fromRGB(90, 20, 30),
            ScrollBar = Color3.fromRGB(255, 35, 65),
            Stroke = Color3.fromRGB(48, 48, 56),

            Error = Color3.fromRGB(255, 80, 80),
            Icons = Color3.fromRGB(235, 235, 240),

            JoinButton = Color3.fromRGB(37, 128, 69),
            Link = Color3.fromRGB(40, 150, 255),

            Dialog = {
                Background = Color3.fromRGB(22, 22, 26)
            },
            Buttons = {
                Holding = Color3.fromRGB(36, 36, 44),
                Default = Color3.fromRGB(26, 26, 30)
            },
            Border = {
                Holding = Color3.fromRGB(65, 65, 75),
                Default = Color3.fromRGB(38, 38, 44),
            },
            Text = {
                Default = Color3.fromRGB(255, 255, 255),
                Dark = Color3.fromRGB(195, 195, 205),
                Darker = Color3.fromRGB(145, 145, 155),
            },
            Slider = {
                SliderBar = Color3.fromRGB(255, 35, 65),
                SliderNumber = Color3.fromRGB(240, 240, 245),
            },
            Dropdown = {
                Holder = Color3.fromRGB(24, 24, 28),
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
        BackgroundTransparency = 0.04
    }
}

for themeName, themeData in ThemesList do
    themeData.Name = themeName
    table.freeze(themeData)
end

local Library = {
    Information = {
        Version = "v2.2.0",
        GitHubOwner = "tlredz"
    },
    Default = {
        Theme = "Darker",
        UISize = UDim2.fromOffset(560, 390),
        TabSize = 160
    },

    Themes = ThemesList,
    Connections = {},
    Options = {},
    Tabs = {},

    FarmStatusColors = {
        Running = "#5CB85C",
        Waiting = "#F0AD4E",
        Need = "#D9534F"
    }
}

-- ==========================================================
-- SISTEMA DE LOCALIZAÇÃO / TRADUÇÃO
-- ==========================================================
local function Localize(text)
    if type(text) ~= "string" or text == "" then
        return text
    end
    local pack = Library.Translations[Library.Locale]
    return (pack and pack[text]) or text
end

Library.Locale = "en"
Library.Translations = {}
Library.LocalizedLabels = {}

function Library:AddTranslations(locale, tbl)
    assert(type(locale) == "string", "Library.AddTranslations: locale precisa ser string")
    assert(type(tbl) == "table", "Library.AddTranslations: translations precisa ser uma table")

    self.Translations[locale] = self.Translations[locale] or {}
    for k, v in tbl do
        self.Translations[locale][k] = v
    end
end

function Library:UpdateTranslate(locale)
    if locale then
        self.Locale = locale
    end
    for i = #self.LocalizedLabels, 1, -1 do
        local entry = self.LocalizedLabels[i]
        if entry.Instance and entry.Instance.Parent then
            entry.Instance.Text = Localize(entry.Original)
        else
            table.remove(self.LocalizedLabels, i)
        end
    end
end

Library.SetLocale = Library.UpdateTranslate

function Library:Translate(template, ...)
    assert(type(template) == "string", "Library.Translate: template precisa ser string")
    local translated = Localize(template)
    if select("#", ...) > 0 then
        local ok, res = pcall(string.format, translated, ...)
        if ok then return res end
        local ok2, res2 = pcall(string.format, template, ...)
        return ok2 and res2 or translated
    end
    return translated
end

Library.Info = Library.Information
Library.Save = Library.Default

function Library:SetFarmStatusColor(name, hex)
    assert(type(name) == "string", "Library.SetFarmStatusColor: 'name' precisa ser string")
    assert(type(hex) == "string", "Library.SetFarmStatusColor: 'hex' precisa ser string")
    self.FarmStatusColors[name] = hex
end

local ViewportSize = workspace.CurrentCamera.ViewportSize

local ConnectEvent = function(inst, callback, eventName)
    table.insert(Library.Connections, inst[eventName or "Connect"](inst, callback))
end

local ThemeManager = {}
ThemeManager.__index = ThemeManager

local ResolveThemePath = function(themeTbl, pathStr)
    for seg in pathStr:gmatch"[^%.]+" do
        themeTbl = themeTbl[seg]
    end
    return themeTbl
end

local ApplyThemeProp = function(inst, propName, themeKey, targetTheme)
    if not targetTheme then
        targetTheme = Library.CurrentTheme
    end
    inst[propName] = ResolveThemePath(targetTheme, if type(themeKey) == "function" then themeKey() else themeKey)
end

local ApplyThemeProps = function(targetTheme, inst, props)
    for propName, themeKey in props do
        ApplyThemeProp(inst, propName, themeKey, targetTheme)
    end
end

local SafeWriteFile = function(filePath, content)
    if makefolder then
        local parts = filePath:split"/"
        parts[#parts] = nil
        local dir = table.concat(parts, "/")
        if dir ~= "" and (isfolder == nil or not isfolder(dir)) then
            makefolder(dir)
        end
    end
    writefile(filePath, content)
end

local InputBlocked = false

local ConfigConstants = {
    MAX_SCALE = 1.6,
    MIN_SCALE = 0.6,
    TEXTBOX = {
        PLACEHOLDER_TEXT = "Input"
    }
}

function ThemeManager:add(inst, props)
    self.Descendants[props] = inst
    if self.IS_RENDERING then
        ApplyThemeProps(Library.CurrentTheme, inst, props)
    end
end

function ThemeManager:update()
    if self.IS_RENDERING and not self.UPDATED_OBJECTS then
        local currentTheme = Library.CurrentTheme
        self.UPDATED_OBJECTS = true
        for props, inst in self.Descendants do
            if typeof(inst) == "table" then
                inst:update()
                continue
            end
            ApplyThemeProps(currentTheme, inst, props)
        end
    end
end

function ThemeManager:destroy()
    local idx = self.Parent and table.find(self.Parent.Descendants, self)
    if idx then
        table.remove(self.Parent.Descendants, idx)
    end
    table.clear(self.Descendants)
    setmetatable(self, nil)
end

function ThemeManager:changeRendering(state)
    if self.IS_RENDERING ~= state then
        self.IS_RENDERING = state
        self.UPDATED_OBJECTS = false
    end
end

function ThemeManager:new()
    local obj = setmetatable({
        IS_RENDERING = true,
        UPDATED_OBJECTS = false,
        Descendants = {},
        Parent = self.Descendants ~= nil and self or nil
    }, ThemeManager)

    if self.Descendants then
        table.insert(self.Descendants, obj)
    end
    return obj
end

local GlobalThemeManager = ThemeManager:new()

local InstanceBuilder, CreateInstance = {}
do
    local Factory = {}
    Factory.ElementsTable = {
        Corner = function(radius)
            return CreateInstance("UICorner", { CornerRadius = radius or UDim.new(0, 8) })
        end,
        Stroke = function(color, thick)
            return CreateInstance("UIStroke", { Color = color or Color3.fromRGB(60, 60, 60), Thickness = thick or 1 })
        end,
        Image = function(asset)
            return CreateInstance("ImageLabel", { Image = asset or "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1) })
        end,
        Button = function()
            return CreateInstance("TextButton", { Text = "", Size = UDim2.fromScale(1, 1), AutoButtonColor = false })
        end,
        Padding = function(left, right, top, bottom)
            return CreateInstance("UIPadding", {
                PaddingLeft = left or UDim.new(0, 10),
                PaddingRight = right or UDim.new(0, 10),
                PaddingTop = top or UDim.new(0, 10),
                PaddingBottom = bottom or UDim.new(0, 10)
            })
        end,
        ListLayout = function(padding)
            return CreateInstance("UIListLayout", { Padding = padding or UDim.new(0, 5) })
        end,
        Text = function(str)
            return CreateInstance("TextLabel", { BackgroundTransparency = 1, Text = str or "" })
        end,
        Gradient = function(colorSeq)
            return CreateInstance("UIGradient", { Color = colorSeq })
        end
    }

    function Factory:Create(parent, elemType, ...)
        local creator = self.ElementsTable[elemType]
        if creator then
            local elem = creator(...)
            elem.Parent = parent
            return elem
        end
    end

    local ElementHelper = {}
    function ElementHelper:Childs(children)
        for i = 1, #children do
            children[i].Parent = self
        end
    end

    function ElementHelper:Elements(elements)
        for elemType, props in pairs(elements) do
            if type(props) == "table" then
                InstanceBuilder.SetProperties(Factory:Create(self, elemType), props)
            else
                Factory:Create(self, elemType, props)
            end
        end
    end

    function ElementHelper:ThemeTag(themeProps)
        local target = themeProps.OBJECTS
        themeProps.OBJECTS = nil
        return (target or GlobalThemeManager):add(self, themeProps)
    end

    function InstanceBuilder:SetProperties(properties)
        for key, val in pairs(properties) do
            if ElementHelper[key] then
                ElementHelper[key](self, val)
            else
                self[key] = val
            end
        end
    end

    function InstanceBuilder:SetValues(...)
        local inst = self
        for _, val in {...} do
            local t = typeof(val)
            if t == "table" then
                InstanceBuilder.SetProperties(inst, val)
            else
                inst[if t == "string" then "Name" else "Parent"] = val
            end
        end
        return inst
    end

    local CurrentDraggingObject
    function InstanceBuilder:Draggable(uiScale, lerpSpeed, clampFunc)
        local dragStart, startPos
        local smoothFactor = lerpSpeed or 0.28
        local lastTick = 0
        local StopDrag

        local UpdateDrag = function(input)
            local delta = input.Position - dragStart
            lastTick = tick()
            local targetPos
            if clampFunc then
                targetPos = clampFunc(
                    startPos.X.Scale, startPos.X.Offset + delta.X / uiScale.Scale,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y / uiScale.Scale
                )
            else
                targetPos = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X / uiScale.Scale,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y / uiScale.Scale
                )
            end
            self.Position = self.Position:Lerp(targetPos, smoothFactor)
        end

        local CheckActive = function()
            while CurrentDraggingObject == self do
                if (tick() - lastTick) >= 1 then
                    StopDrag()
                    break
                end
                task.wait()
            end
        end

        local ValidInputTypes = {
            [Enum.UserInputType.MouseButton1] = true,
            [Enum.UserInputType.Touch] = true
        }

        local ValidMoveTypes = {
            [Enum.UserInputType.MouseMovement] = true,
            [Enum.UserInputType.Touch] = true
        }

        ConnectEvent(self.InputBegan, function(input)
            if InputBlocked == false and CurrentDraggingObject == nil and ValidInputTypes[input.UserInputType] then
                dragStart = input.Position
                startPos = self.Position
                CurrentDraggingObject = self
                lastTick = tick()
                InputBlocked = true

                local conn
                function StopDrag()
                    InputBlocked = false
                    CurrentDraggingObject = nil
                    if conn then conn:Disconnect() end
                end

                task.spawn(CheckActive)

                conn = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        StopDrag()
                    end
                end)
            end
        end)

        ConnectEvent(UserInputService.InputChanged, function(input)
            if CurrentDraggingObject == self and ValidMoveTypes[input.UserInputType] then
                UpdateDrag(input)
            end
        end)
    end

    function InstanceBuilder.new(className, ...)
        return InstanceBuilder.SetValues(Instance.new(className), ...)
    end

    CreateInstance = InstanceBuilder.new
end

local ParseCallback = function(cb)
    if cb == nil then return {} end
    if type(cb) ~= "function" and type(cb) ~= "table" then
        error(`Failed to get Callback: 'function', or 'table' expected, got {typeof(cb)}`, 2)
    end
    if type(cb) ~= "function" then
        local tbl = cb[1]
        local key = cb[2]
        cb = function(val) tbl[key] = val end
    end
    return table.pack(cb)
end

local ExecuteCallbacks = function(cbList, ...)
    for i = 1, #cbList do
        task.spawn(cbList[i], ...)
    end
end

local ScreenGuiTag = "redz-library-v5"
local MainScreenGui = CoreGui:FindFirstChild(ScreenGuiTag)
if not MainScreenGui then
    MainScreenGui = CreateInstance("ScreenGui", ScreenGuiTag, CoreGui, {
        IgnoreGuiInset = true
    })
end

local CreateTween = function(inst, propName, targetVal, duration, style, dir)
    local info = TweenInfo.new(duration, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out)
    return TweenService:Create(inst, info, { [propName] = targetVal })
end

local SetLookup = function(tbl)
    local lookup = {}
    for i = 1, #tbl do
        rawset(lookup, tbl[i], true)
    end
    return lookup
end

local CharBlacklist = SetLookup(string.split("\n\t,_:;()[]#&=!. \"'*^<>$", ""))
local CleanSearchString = function(str)
    return string.gsub(str:lower(), ".", function(c)
        return CharBlacklist[c] and "" or c
    end)
end

local FormatNumberSeparators = function(num)
    local str, formatted, count = tostring(num), "", 0
    for i = #str, 1, -1 do
        formatted = str:sub(i, i) .. formatted
        count += 1
        if i > 1 and count % 3 == 0 then
            formatted = "," .. formatted
        end
    end
    return formatted
end

local IsAssetId = function(str)
    return str:sub(1, 13) == "rbxassetid://"
end

local CalculateUIScale = function(val)
    return (ViewportSize.Y / 450) * val
end

local FormatTimeDisplay = function(seconds)
    local mins = math.floor(seconds / 60)
    local hours = math.floor(seconds / 3600)
    seconds = math.floor((seconds - (mins * 60)) * 10) / 10
    mins = mins - (hours * 60)

    if hours > 0 then
        return `{hours}h {mins}m {math.floor(seconds)}s`
    elseif mins > 0 then
        return `{mins}m {math.floor(seconds)}s`
    else
        return tostring(seconds)
    end
end

-- ==========================================================
-- ESTRUTURA DOS COMPONENTES VISUAIS
-- ==========================================================
local WindowEngine = {}
do
    local TabsRegistry = {}
    local TabContainers = {}
    local TabSelectionHooks = {}
    local TabThemes = {}

    local NotificationFrame, GlobalDropdownMenu, DialogOverlay, ActiveDialog
    local CurrentActiveButton, DropdownSearchContext, RootMainFrame, RootUIScale, StoredScriptFlags
    local DefaultNotifyIcon = ""

    local WindowClass = { SelectedTab = 1, Minimized = false }
    WindowClass.__index = WindowClass

    local TabClass = {}
    TabClass.__index = TabClass

    local OptionClass = {}
    OptionClass.__index = OptionClass

    local MinimizerClass = {}
    MinimizerClass.__index = MinimizerClass

    local WidgetRegistry = {}
    do
        local CreateInheritedClass = function()
            local cls = {}
            cls.__index = function(tbl, key)
                return cls[key] or rawget(OptionClass, key)
            end
            return cls
        end

        WidgetRegistry.TextBox  = CreateInheritedClass()
        WidgetRegistry.Toggle   = CreateInheritedClass()
        WidgetRegistry.Slider   = CreateInheritedClass()
        WidgetRegistry.Dropdown = CreateInheritedClass()
        WidgetRegistry.Keybind  = CreateInheritedClass()
        WidgetRegistry.Dialog   = CreateInheritedClass()

        local CleanupActiveDialog = function()
            ActiveDialog.Closed = true
            ActiveDialog.Closing = false
            setmetatable(ActiveDialog, nil)
            ActiveDialog = nil
            DialogOverlay.Parent = nil
        end

        local CloseDialogInstant = function()
            if ActiveDialog ~= nil then
                ActiveDialog:Close()
            end
        end

        function WidgetRegistry.Dialog:NewOption(optData)
            local title = optData[1] or optData.Name or optData.Title
            local callbacks = ParseCallback(optData[2] or optData.Callback)
            table.insert(callbacks, CloseDialogInstant)

            assert(type(title) == "string", `"Dialog.NewOption.Name". 'string' expected, got {typeof(title)}`)

            local btn = CreateInstance("TextButton", {
                AutoButtonColor = false,
                Size = UDim2.fromScale(0.24, 1),
                BackgroundTransparency = 1,
                TextSize = 11,
                Text = title,
                Elements = { Corner = UDim.new(1, 0) },
                ThemeTag = {
                    BackgroundColor3 = "Colors.Buttons.Default",
                    TextColor3 = "Colors.Text.Dark",
                    Font = "Font.Bold"
                }
            })

            local hoverIn = CreateTween(btn, "BackgroundTransparency", 0, 0.25)
            local hoverOut = CreateTween(btn, "BackgroundTransparency", 1, 0.25)

            ConnectEvent(btn.MouseLeave, function() hoverOut:Play() end)
            ConnectEvent(btn.MouseEnter, function() hoverIn:Play() end)
            ConnectEvent(btn.Activated, function() ExecuteCallbacks(callbacks) end)

            btn.Parent = DialogOverlay.Template.Options
        end

        function WidgetRegistry.Dialog:Close(immediate)
            if self.Closed or self.Closing or ActiveDialog ~= self then
                return nil
            end
            self.Closing = true
            local tw = CreateTween(self.TEMPLATE, "Size", self.NEW_SIZE, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            tw:Play()

            if immediate then
                tw.Completed:Wait()
                CleanupActiveDialog()
            else
                ConnectEvent(tw.Completed, CleanupActiveDialog)
            end
        end

        function WidgetRegistry.Dialog.new(descLabel, titleLabel)
            return setmetatable({
                TITLE_LABEL = descLabel,
                DESCRIPTION_LABEL = descLabel,
                Content = descLabel.Text,
                Title = titleLabel.Text,
                Closed = false,
                Closing = false,
                Kind = "Dialog"
            }, WidgetRegistry.Dialog)
        end

        function WidgetRegistry.Dropdown:SetEnabled(tbl)
            assert(type(tbl) == "table", `"Dropdown.SetEnabled[param 1]". 'table' expected, got {typeof(tbl)}`)
            self.SET_ENABLED_OPTIONS(tbl)
        end

        function WidgetRegistry.Dropdown:Clear()
            self.CLEAR_DROPDOWN()
        end

        function WidgetRegistry.Dropdown:NewOptions(...)
            self:Clear()
            self:Add(...)
        end

        function WidgetRegistry.Dropdown:GetOptionsCount()
            return #self.DROPDOWN_OPTIONS
        end

        function WidgetRegistry.Dropdown:Remove(...)
            local args = {...}
            assert(#args > 0, "'Dropdown.Remove' requires one or more options.")
            for _, opt in args do
                self.REMOVE_DROPDOWN_OPTION(opt)
            end
        end

        function WidgetRegistry.Dropdown:Add(...)
            local args = {...}
            assert(#args > 0, "'Dropdown.Add' requires one or more options.")
            for _, opt in args do
                self.ADD_DROPDOWN_OPTION(opt)
            end
        end

        function WidgetRegistry.Dropdown.new(parent, element, titleLabel, descLabel, callbacks)
            return setmetatable({
                CALLBACKS = callbacks,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = titleLabel,
                DESCRIPTION_LABEL = descLabel,
                Description = descLabel.Text,
                Title = titleLabel.Text,
                Parent = parent,
                Kind = "Dropdown"
            }, WidgetRegistry.Dropdown)
        end

        function WidgetRegistry.Slider:SetValue(val)
            assert(type(val) == "number", `"Slider.SetValue". 'number' expected, got {typeof(val)}`)
            if self.Value ~= val then
                self.WHEN_VALUE_CHANGED(val)
            end
        end

        function WidgetRegistry.Slider.new(parent, element, titleLabel, descLabel, callbacks)
            return setmetatable({
                CALLBACKS = callbacks,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = titleLabel,
                DESCRIPTION_LABEL = descLabel,
                Description = descLabel.Text,
                Title = titleLabel.Text,
                Parent = parent,
                Kind = "Slider"
            }, WidgetRegistry.Slider)
        end

        function WidgetRegistry.Toggle:SetValue(val)
            assert(type(val) == "boolean", `"Toggle.SetValue". 'boolean' expected, got {typeof(val)}`)
            if self.Value ~= val then
                self.Value = val
                self.WHEN_VALUE_CHANGED(val)
            end
        end

        function WidgetRegistry.Toggle.new(parent, element, titleLabel, descLabel, onValChanged, callbacks)
            return setmetatable({
                CALLBACKS = callbacks,
                WHEN_VALUE_CHANGED = onValChanged,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TITLE_LABEL = titleLabel,
                DESCRIPTION_LABEL = descLabel,
                Description = descLabel.Text,
                Title = titleLabel.Text,
                Parent = parent,
                Kind = "Toggle"
            }, WidgetRegistry.Toggle)
        end

        function WidgetRegistry.TextBox:SetText(val)
            assert(type(val) == "string", `"TextBox.SetText". 'string' expected, got {typeof(val)}`)
            self.TEXTBOX.Text = val
            return self
        end

        function WidgetRegistry.TextBox:SetPlaceholder(val)
            assert(type(val) == "string", `"TextBox.SetPlaceholder". 'string' expected, got {typeof(val)}`)
            self.TEXTBOX.PlaceholderText = val
            return self
        end

        function WidgetRegistry.TextBox:CaptureFocus()
            self.TEXTBOX:CaptureFocus()
            return self
        end

        function WidgetRegistry.TextBox:Clear()
            self.TEXTBOX.Text = ""
            return self
        end

        function WidgetRegistry.TextBox:SetTextFilter(filterFunc)
            if filterFunc ~= nil then
                assert(type(filterFunc) == "function", `"TextBox.SetTextFilter". 'function' or 'nil' expected, got {typeof(filterFunc)}`)
            end
            self.TEXTBOX_TEXT_FILTER = filterFunc
            return self
        end

        function WidgetRegistry.TextBox.new(parent, titleLabel, descLabel, element, textBoxInst, callbacks)
            return setmetatable({
                Title = titleLabel.Text,
                Description = descLabel.Text,
                DESCRIPTION_LABEL = descLabel,
                TITLE_LABEL = titleLabel,
                CALLBACKS = callbacks,
                DESTROY_ELEMENT = element,
                VISIBLE_ELEMENT = element,
                TEXTBOX = textBoxInst,
                BUTTON = element,
                Parent = parent,
                Kind = "TextBox"
            }, WidgetRegistry.TextBox)
        end

        WidgetRegistry.TextBox.Set = WidgetRegistry.TextBox.SetText
        WidgetRegistry.Toggle.Set  = WidgetRegistry.Toggle.SetValue
        WidgetRegistry.Slider.Set  = WidgetRegistry.Slider.SetValue
    end

    local ConstructTabUI = function(window, tabData, tabsContainer)
        local btn = CreateInstance("TextButton", "Button", tabsContainer, {
            Size = UDim2.new(1, 0, 0, 28),
            AutoButtonColor = false,
            Text = "",
            Elements = { Corner = UDim.new(0, 6) },
            ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
            Childs = {
                CreateInstance("TextLabel", "Title", {
                    BackgroundTransparency = 1,
                    Font = Enum.Font.GothamMedium,
                    Text = Localize(tabData.Title),
                    TextSize = 11,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTransparency = 0.35,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    ThemeTag = { TextColor3 = "Colors.Text.Default" }
                })
            }
        })

        table.insert(Library.LocalizedLabels, { Instance = btn.Title, Original = tabData.Title })

        local indicator = CreateInstance("Frame", btn, {
            Position = UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.fromOffset(4, 4),
            BackgroundTransparency = 1,
            ThemeTag = { BackgroundColor3 = "Colors.Primary" },
            Elements = { Corner = UDim.new(1, 0) }
        })

        local container = CreateInstance("ScrollingFrame", "Container", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 1),
            AnchorPoint = Vector2.new(0, 1),
            ScrollBarThickness = 2,
            BackgroundTransparency = 1,
            ScrollBarImageTransparency = 0.2,
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(),
            ThemeTag = { ScrollBarImageColor3 = "Colors.ScrollBar" },
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

        local icon = CreateInstance("ImageLabel", btn, {
            Position = UDim2.new(0, 10, 0.5),
            Size = UDim2.new(0, 14, 0, 14),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            ImageTransparency = 0.35,
            Image = tabData.Icon or ""
        })

        local AdjustLayout = function()
            local hasIcon = string.sub(icon.Image, 1, 13) == "rbxassetid://"
            icon.Visible = hasIcon
            btn.Title.Size = UDim2.new(1, hasIcon and -30 or -15, 1)
            btn.Title.Position = UDim2.fromOffset(hasIcon and 30 or 12)
        end

        ConnectEvent(icon:GetPropertyChangedSignal"Image", AdjustLayout)
        AdjustLayout()

        return btn, container, indicator, icon
    end

    local ConstructOptionBase = function(tab, title, desc, holderSize)
        local titleLabel = CreateInstance("TextLabel", {
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, -20),
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            TextSize = 12,
            ThemeTag = { OBJECTS = GlobalThemeManager, TextColor3 = "Colors.Text.Default", Font = "Font.Medium" }
        })

        local tabTheme = TabThemes[tab]
        local container = TabContainers[tab].Container

        local descLabel = CreateInstance("TextLabel", {
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, -20),
            Position = UDim2.new(0, 12, 0, 15),
            BackgroundTransparency = 1,
            TextWrapped = true,
            TextSize = 9,
            RichText = true,
            ThemeTag = { OBJECTS = tabTheme, TextColor3 = "Colors.Text.Dark", Font = "Font.Normal" }
        })

        local tagData = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Buttons.Default" }

        local optionBtn = CreateInstance("TextButton", "Option", {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.new(1, 0, 0, 30),
            AutoButtonColor = false,
            Text = "",
            ThemeTag = tagData,
            Elements = { Corner = UDim.new(0, 6) },
            Childs = {
                CreateInstance("Frame", "Holder", {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    Size = holderSize,
                    Elements = {
                        ListLayout = {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            VerticalAlignment = Enum.VerticalAlignment.Center,
                            Padding = UDim.new(0, 2)
                        },
                        Padding = { PaddingBottom = UDim.new(0, 6), PaddingTop = UDim.new(0, 6) }
                    },
                    Childs = { titleLabel, descLabel }
                })
            }
        })

        local holder = optionBtn.Holder
        local UpdateHover = function(colorKey, isHovering)
            if isHovering then
                if CurrentActiveButton then
                    local defaultCol = ResolveThemePath(Library.CurrentTheme, "Colors.Buttons.Default")
                    CurrentActiveButton.Theme.BackgroundColor3 = "Colors.Buttons.Default"
                    CreateTween(CurrentActiveButton.Button, "BackgroundColor3", defaultCol, 0.2):Play()
                end
                CurrentActiveButton = { Button = optionBtn, Theme = tagData }
            end
            tagData.BackgroundColor3 = colorKey
            CreateTween(optionBtn, "BackgroundColor3", ResolveThemePath(Library.CurrentTheme, colorKey), 0.2):Play()
        end

        ConnectEvent(optionBtn.MouseLeave, function() UpdateHover("Colors.Buttons.Default", false) end)
        ConnectEvent(optionBtn.MouseEnter, function() UpdateHover("Colors.Buttons.Holding", true) end)

        ConnectEvent(descLabel:GetPropertyChangedSignal"Text", function()
            local hasText = #descLabel.Text > 0
            if descLabel.Visible ~= hasText then
                local yAnchor = hasText and 0 or 0.5
                descLabel.Visible = hasText
                holder.Position = UDim2.fromScale(0, yAnchor)
                holder.AnchorPoint = Vector2.new(0, yAnchor)
            end
        end)

        titleLabel.Text = Localize(title)
        descLabel.Text = Localize(desc or "")

        table.insert(Library.LocalizedLabels, { Instance = titleLabel, Original = title })
        table.insert(Library.LocalizedLabels, { Instance = descLabel, Original = desc or "" })

        optionBtn.Parent = container
        return optionBtn, titleLabel, descLabel
    end

    local ParseConfigTuple = function(widgetName, cfg)
        if type(cfg) ~= "table" then
            error(`"Tab.Add{widgetName}[Configs]". 'table' expected, got {typeof(cfg)}`, 2)
        end
        local title = cfg[1] or cfg.Name or cfg.Title
        local desc = cfg.Desc or cfg.Description
        assert(type(title) == "string", `"Tab.Add{widgetName}.Title". 'string' expected, got {typeof(title)}`)
        return title, desc or ""
    end

    local ValidateFlag = function(widgetName, flag)
        return flag
    end

    -- ==========================================================
    -- SISTEMA DE DROPDOWN FLUTUANTE
    -- ==========================================================
    local CreateFloatingDropdownEngine = function()
        local width = 160
        local baseStyle = {
            Corner = UDim.new(0, 6),
            Stroke = { ThemeTag = { Color = "Colors.Stroke" } },
            Gradient = { Rotation = 45, ThemeTag = { Color = "Colors.Background" } }
        }

        local overlayBtn = CreateInstance("TextButton", OutBox, {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Active = true,
            Text = ""
        })

        local dropdownFrame = CreateInstance("Frame", "Dropdown", overlayBtn, {
            Size = UDim2.fromOffset(width, 100),
            Position = UDim2.fromOffset(50, 50),
            Elements = baseStyle,
            Active = true,
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" }
        })

        local searchBtn = CreateInstance("TextButton", "Search", dropdownFrame, {
            Position = UDim2.new(1, 5, 0, 5),
            Size = UDim2.new(0, 25, 0, 25),
            AutomaticSize = Enum.AutomaticSize.X,
            Active = true,
            Elements = baseStyle,
            Text = "",
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
            Childs = {
                CreateInstance("UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5), PaddingTop = UDim.new(0, 5) }),
                CreateInstance("UIListLayout", { Padding = UDim.new(0, 5), FillDirection = Enum.FillDirection.Horizontal }),
                CreateInstance("TextBox", "SearchBox", {
                    Size = UDim2.fromScale(0, 1),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Visible = false,
                    PlaceholderText = "Search...",
                    ClearTextOnFocus = false,
                    Text = "",
                    Elements = { Corner = UDim.new(0, 6) },
                    ThemeTag = { BackgroundColor3 = "Colors.Stroke", TextColor3 = "Colors.Text.Default", Font = "Font.ExtraBold" }
                }),
                CreateInstance("ImageLabel", "SearchIcon", {
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = Enum.SizeConstraint.RelativeYY,
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    ThemeTag = { BackgroundColor3 = "Colors.Stroke", ImageColor3 = "Colors.Icons", Image = "Icons.Search" }
                })
            }
        })

        local optionsScroll = CreateInstance("ScrollingFrame", dropdownFrame, {
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
            ThemeTag = { OBJECTS = GlobalThemeManager, ScrollBarImageColor3 = "Colors.ScrollBar" },
            Elements = {
                Padding = { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5) },
                ListLayout = { Padding = UDim.new(0, 4) }
            }
        })

        local searchBox = searchBtn.SearchBox
        local searchExpandWidth = 130

        local closeTween = CreateTween(dropdownFrame, "Size", UDim2.fromOffset(width, 0), 0.2)
        local expandSearchTween = CreateTween(searchBox, "Size", UDim2.new(0, searchExpandWidth - 30, 1, 0), 0.25)
        local shrinkSearchTween = CreateTween(searchBox, "Size", UDim2.new(0, 0, 1, 0), 0.2)

        local activeInstanceMap = {}
        local isClosing = false
        local isSearchOpen = false
        local onDropdownClosedCallback, onOptionClickedCallback, activeOptionList, isMultiSelectMode, holderFrameInstance
        local lastFocusTick = 0
        local itemHeight = 25
        local maxHeight = (itemHeight * 12) + 10
        local paddingOffset = 5

        local CalculateHeight = function(count)
            local viewportLimit = MainScreenGui.AbsoluteSize.Y / RootUIScale.Scale
            return math.min((itemHeight * math.max(count, 0.5)) + 10, maxHeight, viewportLimit / 1.75)
        end

        local IsMouseOverDropdown = function()
            local pos = dropdownFrame.AbsolutePosition
            local size = dropdownFrame.AbsoluteSize
            local mPos = Vector2.new(Mouse.X, Mouse.Y)
            return mPos.X >= pos.X and mPos.X <= (pos.X + size.X) and mPos.Y >= pos.Y and mPos.Y <= (pos.Y + size.Y)
        end

        local CalculatePosition = function(count)
            local hPos = holderFrameInstance.AbsolutePosition
            local hSize = holderFrameInstance.AbsoluteSize
            local scrSize = MainScreenGui.AbsoluteSize
            local scale = RootUIScale.Scale
            local dynHeight = CalculateHeight(count)

            local screenW = scrSize.X / scale
            local screenH = scrSize.Y / scale
            local targetX = hPos.X / scale
            local targetY = hPos.Y / scale
            local hSizeY = hSize.Y / scale

            local centerY = targetY + (hSizeY / 2)
            local startY = centerY - (dynHeight / 2)
            local clampedY = math.clamp(startY, paddingOffset, screenH - dynHeight - paddingOffset)
            local anchor = Vector2.new(0, 0)

            if clampedY > (screenH * 0.7) then
                anchor = Vector2.new(0, 1)
                clampedY = math.min(centerY + (dynHeight / 2), screenH - paddingOffset)
            end

            local clampedX = math.clamp(targetX, paddingOffset, screenW - dropdownFrame.Size.X.Offset - (paddingOffset * 2) - (searchBtn.AbsoluteSize.X / scale))
            return Vector2.new(clampedX, clampedY), anchor
        end

        local ApplyDropdownPlacement = function(...)
            local pos, anchor = CalculatePosition(...)
            dropdownFrame.AnchorPoint = anchor
            dropdownFrame.Position = UDim2.fromOffset(pos.X, pos.Y)
        end

        local CloseSearch = function()
            if not isSearchOpen then return end
            isSearchOpen = false
            searchBox.Text = ""
            shrinkSearchTween:Play()
            shrinkSearchTween.Completed:Wait()
            searchBox.Visible = false
        end

        local OpenSearch = function()
            if isSearchOpen then return end
            isSearchOpen = true
            searchBox.Visible = true
            expandSearchTween:Play()
            searchBox:CaptureFocus()

            local dSize = dropdownFrame.AbsoluteSize
            local scrSize = MainScreenGui.AbsoluteSize
            local scale = RootUIScale.Scale
            local expandedW = searchExpandWidth * scale
            local posX = dropdownFrame.AbsolutePosition.X
            local rightEdge = posX + dSize.X + 5 + expandedW

            if rightEdge > scrSize.X - (paddingOffset * scale) then
                local adjX = (scrSize.X - dSize.X - expandedW - 5 - (paddingOffset * scale)) / scale
                adjX = math.max(adjX, paddingOffset)
                CreateTween(dropdownFrame, "Position", UDim2.fromOffset(adjX, dropdownFrame.Position.Y.Offset), 0.3):Play()
            end
        end

        local OpenMenu = function(closeCb)
            if not isClosing then
                onDropdownClosedCallback = closeCb
                overlayBtn.Parent = DropdownSearchContext
                return true
            end
        end

        local CloseMenu = function()
            if isClosing then return end
            if onDropdownClosedCallback then
                onDropdownClosedCallback()
                onDropdownClosedCallback = nil
            end
            task.spawn(CloseSearch)
            isClosing = true
            closeTween:Play()
            closeTween.Completed:Wait()
            overlayBtn.Parent = nil
            isClosing = false
        end

        local CheckFocusLoss = function()
            if searchBox:IsFocused() then
                lastFocusTick = tick()
                return nil
            end
            if (tick() - lastFocusTick) >= 0.3 and not IsMouseOverDropdown() then
                CloseMenu()
            end
        end

        local ClearOptions = function()
            for optInst in activeInstanceMap do
                optInst.Parent = nil
                activeInstanceMap[optInst] = nil
            end
        end

        local SetOptionVisualState = function(optData, isSelected)
            optData.Selected = isSelected
            if optData.Instance then
                local inst = optData.Instance
                local label = inst.TextLabel
                local ind = inst.Frame
                local bgTrans = isSelected and 0 or (isMultiSelectMode and 0.8 or 1)
                local txtTrans = isSelected and 0 or 0.4
                local indSize = UDim2.fromOffset(4, isSelected and 14 or 4)

                if inst.Parent then
                    CreateTween(ind, "BackgroundTransparency", bgTrans, 0.3):Play()
                    CreateTween(label, "TextTransparency", txtTrans, 0.3):Play()
                    CreateTween(ind, "Size", indSize, 0.3):Play()
                else
                    label.TextTransparency = txtTrans
                    ind.BackgroundTransparency = bgTrans
                    ind.Size = indSize
                end
            end
        end

        local FilterOptionVisibility = function(optData)
            if searchBox.Visible == false or not optData then
                local total = activeOptionList and #activeOptionList or 0
                dropdownFrame.Size = UDim2.fromOffset(width, CalculateHeight(total))
                return nil
            end
            if optData then
                local inst = optData.Instance
                local filterText = CleanSearchString(searchBox.Text)
                inst.Visible = #filterText == 0 or optData.SearchText:find(filterText) ~= nil
                if inst.Visible then
                    SEARCH_RESULT_COUNT += 1
                    dropdownFrame.Size = UDim2.fromOffset(width, CalculateHeight(SEARCH_RESULT_COUNT))
                end
            end
        end

        local MatchesFilter = function(optData, prefix, query, searchSource)
            local matches = true
            if prefix == "+" or prefix == "-" then
                matches = optData.Selected == (prefix == "+")
                query = query:sub(2, -1)
            end
            return matches and searchSource:find(query, 1, true) ~= nil
        end

        local BuildOptionItem = function(optData, autoAttach)
            local itemBtn = CreateInstance("TextButton", {
                Size = UDim2.new(1, 0, 0, 22),
                AutoButtonColor = false,
                Text = "",
                Elements = { Corner = UDim.new(0, 4) },
                ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
                Childs = {
                    CreateInstance("Frame", {
                        Position = UDim2.new(0, 1, 0.5),
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
                        TextTransparency = 0.4,
                        Text = optData.DisplayName,
                        TextSize = 10,
                        ThemeTag = { Font = "Font.Bold", TextColor3 = "Colors.Text.Default" }
                    })
                }
            })

            local debounceTick = 0
            ConnectEvent(itemBtn.Activated, function()
                if (tick() - debounceTick) < 0 then return end
                if overlayBtn.Parent and not isClosing then
                    debounceTick = tick() + 0.2
                    onOptionClickedCallback(optData)
                end
            end)

            optData.SearchText = CleanSearchString(optData.DisplayName)
            optData.Instance = itemBtn

            if autoAttach then
                local txt = searchBox.Text
                if #txt > 0 then
                    local pfx = string.sub(txt, 1, 1)
                    local clean = CleanSearchString(txt)
                    itemBtn.Visible = MatchesFilter(optData, pfx, clean, optData.SearchText)
                end
                itemBtn.Parent = optionsScroll
                FilterOptionVisibility(optData)
            end
            SetOptionVisualState(optData, optData.Selected)
        end

        local PopulateOptions = function(list)
            ClearOptions()
            activeOptionList = list
            for i = 1, #list do
                local opt = list[i]
                if opt.Instance == nil then
                    BuildOptionItem(opt)
                end
                opt.Instance.Parent = optionsScroll
                activeInstanceMap[opt.Instance] = true
            end
            ApplyDropdownPlacement(#list)
            CreateTween(dropdownFrame, "Size", UDim2.fromOffset(width, CalculateHeight(#list)), 0.3):Play()
        end

        local UpdateSearchFilter = function()
            local txt = searchBox.Text
            local pfx = string.sub(txt, 1, 1)
            local clean = CleanSearchString(txt)
            local isEmpty = #clean == 0
            local count = 0

            for i = 1, #activeOptionList do
                local opt = activeOptionList[i]
                local isVisible = isEmpty or MatchesFilter(opt, pfx, clean, opt.SearchText)
                opt.Instance.Visible = isVisible
                if isVisible then count += 1 end
            end
            SEARCH_RESULT_COUNT = count
            dropdownFrame.Size = UDim2.fromOffset(width, CalculateHeight(count))
        end

        ConnectEvent(RootMainFrame:GetPropertyChangedSignal"Visible", CheckFocusLoss)
        ConnectEvent(RootMainFrame:GetPropertyChangedSignal"Size", CheckFocusLoss)
        ConnectEvent(overlayBtn.MouseButton1Down, CheckFocusLoss)
        ConnectEvent(overlayBtn.Activated, CheckFocusLoss)
        ConnectEvent(searchBtn.Activated, OpenSearch)
        ConnectEvent(searchBox:GetPropertyChangedSignal"Text", UpdateSearchFilter)

        return table.freeze{
            CreateOptionTemplate = BuildOptionItem,
            SetOptionValue = SetOptionVisualState,
            CloseDropdown = CloseMenu,
            OpenDropdown = OpenMenu,
            SetOptions = PopulateOptions,
            Clear = ClearOptions,
            SetOnClicked = function(cb) onOptionClickedCallback = cb end,
            SetMultiSelect = function(mode) isMultiSelectMode = mode end,
            SetHolder = function(holder) holderFrameInstance = holder end
        }
    end

    -- ==========================================================
    -- MÉTODOS DA ABA (TAB)
    -- ==========================================================
    function TabClass:AddSection(title)
        title = title or ""
        local tabTheme = TabThemes[self]
        local sectionFrame = CreateInstance("Frame", "Option", TabContainers[self].Container, {
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
            Text = Localize(title),
            ThemeTag = { OBJECTS = tabTheme, TextColor3 = "Colors.Primary", Font = "Font.Bold" }
        })

        table.insert(Library.LocalizedLabels, { Instance = sectionLabel, Original = title })

        return setmetatable({
            Title = title,
            DESTROY_ELEMENT = sectionFrame,
            VISIBLE_ELEMENT = sectionFrame,
            TITLE_LABEL = sectionLabel,
            Kind = "Section",
            Parent = self
        }, OptionClass)
    end

    function TabClass:AddToggle(cfg)
        local title, desc = ParseConfigTuple("Toggle", cfg)
        local flag = ValidateFlag("Toggle", cfg[4] or cfg.Flag)
        local defaultVal = cfg[2] or cfg.Default or false
        local callbacks = ParseCallback(cfg[3] or cfg.Callback)

        if flag ~= nil and type(StoredScriptFlags[flag]) == "number" then
            defaultVal = StoredScriptFlags[flag] == 0
        end

        local tabTheme = TabThemes[self]
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(1, -45, 0, 0))

        local toggleFrame = CreateInstance("Frame", optionBtn, {
            Size = UDim2.new(0, 38, 0, 20),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            Elements = { Corner = UDim.new(0.5, 0) },
            ThemeTag = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Stroke" }
        })

        local innerHolder = CreateInstance("Frame", toggleFrame, {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.82, 0, 0.82, 0),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5)
        })

        local indicatorTheme = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.OnPrimary" }
        local toggleCircle = CreateInstance("Frame", innerHolder, {
            Size = UDim2.new(0, 14, 0, 14),
            Position = UDim2.new(0, 0, 0.5),
            AnchorPoint = Vector2.new(0, 0.5),
            Elements = { Corner = UDim.new(1, 0) },
            ThemeTag = indicatorTheme
        })

        local SetState = function(state)
            if flag ~= nil then StoredScriptFlags[flag] = state and 0 or 1 end
            ExecuteCallbacks(callbacks, state)

            local targetPos = UDim2.new(state and 1 or 0, 0, 0.5, 0)
            local targetAnchor = Vector2.new(state and 1 or 0, 0.5)
            local colorKey = state and "Colors.Primary" or "Colors.OnPrimary"
            local targetCol = ResolveThemePath(Library.CurrentTheme, colorKey)

            indicatorTheme.BackgroundColor3 = colorKey

            if self.Selected then
                TweenService:Create(toggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Position = targetPos,
                    AnchorPoint = targetAnchor,
                    BackgroundColor3 = targetCol
                }):Play()
            else
                toggleCircle.Position = targetPos
                toggleCircle.AnchorPoint = targetAnchor
                toggleCircle.BackgroundColor3 = targetCol
            end
        end

        local toggleWidget = WidgetRegistry.Toggle.new(self, optionBtn, titleLabel, descLabel, SetState, callbacks)
        toggleWidget:SetValue(defaultVal)

        local debounce = 0
        ConnectEvent(optionBtn.Activated, function()
            if (tick() - debounce) >= 0.2 then
                debounce = tick()
                toggleWidget:SetValue(not toggleWidget.Value)
            end
        end)

        return toggleWidget
    end

    function TabClass:AddButton(cfg)
        local title, desc = ParseConfigTuple("Button", cfg)
        local callbacks = ParseCallback(cfg[2] or cfg.Callback)
        local cooldown = cfg.Debounce or cfg.Cooldown

        local tabTheme = TabThemes[self]
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(1, -25, 0, 0))

        local btnIcon = CreateInstance("ImageLabel", optionBtn, {
            Size = UDim2.new(0, 15, 0, 15),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = { OBJECTS = tabTheme, Image = "Icons.Button" }
        })

        local nextClick = 0
        ConnectEvent(optionBtn.Activated, function()
            if cooldown ~= nil and (tick() - nextClick) < 0 then return end
            if cooldown ~= nil then nextClick = tick() + cooldown end

            local pulse = CreateTween(btnIcon, "Size", UDim2.new(0, 18, 0, 18), 0.1)
            pulse:Play()
            pulse.Completed:Connect(function()
                CreateTween(btnIcon, "Size", UDim2.new(0, 15, 0, 15), 0.15):Play()
            end)

            ExecuteCallbacks(callbacks)
        end)

        return setmetatable({
            CALLBACKS = callbacks,
            DESTROY_ELEMENT = optionBtn,
            VISIBLE_ELEMENT = optionBtn,
            TITLE_LABEL = titleLabel,
            DESCRIPTION_LABEL = descLabel,
            Title = title,
            Description = desc,
            Parent = self,
            Kind = "Button"
        }, OptionClass)
    end

    function TabClass:AddTextBox(cfg)
        local title, desc = ParseConfigTuple("TextBox", cfg)
        local flag = ValidateFlag("TextBox", cfg[4] or cfg.Flag)
        local defaultText = cfg[2] or cfg.Default
        local callbacks = ParseCallback(cfg[3] or cfg.Callback)
        local placeholder = cfg.Placeholder or cfg.PlaceholderText
        local clearFocus = cfg.ClearOnFocus or cfg.ClearTextOnFocus

        if flag and type(StoredScriptFlags[flag]) == "string" then
            defaultText = StoredScriptFlags[flag]
        end

        local tabTheme = TabThemes[self]
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(1, -150, 0, 0))

        local boxFrame = CreateInstance("Frame", optionBtn, {
            Size = UDim2.new(0, 140, 0, 20),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            ThemeTag = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Stroke" },
            Elements = { Corner = UDim.new(0, 5) }
        })

        local textBoxInst = CreateInstance("TextBox", boxFrame, {
            Size = UDim2.new(0.85, 0, 0.85, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            TextScaled = true,
            Active = true,
            Text = "",
            PlaceholderText = ConfigConstants.TEXTBOX.PLACEHOLDER_TEXT,
            ThemeTag = { OBJECTS = tabTheme, TextColor3 = "Colors.Text.Default", Font = "Font.Bold" }
        })

        local iconTheme = { OBJECTS = tabTheme, Image = "Icons.TextBox", ImageColor3 = "Colors.Icons" }
        local inputIcon = CreateInstance("ImageLabel", boxFrame, {
            Size = UDim2.new(0, 12, 0, 12),
            Position = UDim2.new(0, -5, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = iconTheme
        })

        if defaultText ~= nil then textBoxInst.Text = defaultText end
        if clearFocus ~= nil then textBoxInst.ClearTextOnFocus = clearFocus end
        if placeholder ~= nil then textBoxInst.PlaceholderText = placeholder end

        local textBoxWidget = WidgetRegistry.TextBox.new(self, titleLabel, descLabel, optionBtn, textBoxInst, callbacks)
        local SetIconTint = function(colKey)
            iconTheme.ImageColor3 = colKey
            CreateTween(inputIcon, "ImageColor3", ResolveThemePath(Library.CurrentTheme, colKey), 0.3):Play()
        end

        if flag ~= nil then
            ConnectEvent(textBoxInst:GetPropertyChangedSignal"Text", function()
                StoredScriptFlags[flag] = textBoxInst.Text
            end)
        end

        ConnectEvent(textBoxInst.Focused, function() SetIconTint("Colors.Primary") end)
        ConnectEvent(textBoxInst.FocusLost, function()
            SetIconTint("Colors.Icons")
            local filter = textBoxWidget.TEXTBOX_TEXT_FILTER
            if filter then
                local filtered = filter(textBoxInst.Text)
                if type(filtered) == "string" then textBoxInst.Text = filtered end
            end
            ExecuteCallbacks(callbacks, textBoxInst.Text)
        end)

        ConnectEvent(optionBtn.Activated, function() textBoxInst:CaptureFocus() end)
        return textBoxWidget
    end

    function TabClass:AddSlider(cfg)
        local title, desc = ParseConfigTuple("Slider", cfg)
        local flag = ValidateFlag("Slider", cfg[7] or cfg.Flag)
        local minVal = cfg[2] or cfg.Min
        local maxVal = cfg[3] or cfg.Max
        local step = cfg[4] or cfg.Increment or 1
        local defaultVal = cfg[5] or cfg.Default or minVal
        local callbacks = ParseCallback(cfg[6] or cfg.Callback)

        if flag ~= nil and type(StoredScriptFlags[flag]) == "number" then
            defaultVal = StoredScriptFlags[flag]
        end

        local tabTheme = TabThemes[self]
        local container = TabContainers[self].Container
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(0.55, 0, 0, 0))

        local sliderInteractive = CreateInstance("TextButton", optionBtn, {
            Size = UDim2.new(0.45, 0, 1, 0),
            Position = UDim2.new(1, 0, 0, 0),
            AnchorPoint = Vector2.new(1, 0),
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Text = ""
        })

        local barBg = CreateInstance("Frame", sliderInteractive, {
            Size = UDim2.new(1, -20, 0, 6),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ThemeTag = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Stroke" },
            Elements = { Corner = UDim.new(0.5, 0) }
        })

        local barFill = CreateInstance("Frame", barBg, {
            Size = UDim2.fromScale(0, 1),
            BorderSizePixel = 0,
            ThemeTag = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Primary" },
            Elements = { Corner = UDim.new(0.5, 0) }
        })

        local sliderHandle = CreateInstance("Frame", barBg, {
            Size = UDim2.new(0, 8, 0, 14),
            BackgroundColor3 = Color3.fromRGB(240, 240, 240),
            Position = UDim2.fromScale(0, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 0.1,
            Elements = { Corner = UDim.new(0, 4) }
        })

        local valLabel = CreateInstance("TextLabel", sliderInteractive, {
            Size = UDim2.new(0, 50, 0, 14),
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(0, -1, 0.5, 0),
            BackgroundTransparency = 1,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Right,
            ThemeTag = { OBJECTS = tabTheme, TextColor3 = "Colors.Text.Default", Font = "Font.SliderValue" }
        })

        local sliderWidget = WidgetRegistry.Slider.new(self, optionBtn, titleLabel, descLabel, callbacks)
        sliderWidget.Min = minVal
        sliderWidget.Max = maxVal
        sliderWidget.Increment = step

        local ScaleToAlpha = function(val) return (val - minVal) / (maxVal - minVal) end
        local AlphaToValue = function(alpha) return (alpha * (maxVal - minVal)) + minVal end
        local RoundStep    = function(val) return math.round(val / step) * step end

        local UpdateSliderValues = function(rawVal, alpha)
            if rawVal == sliderWidget.Value then return end
            if flag ~= nil then StoredScriptFlags[flag] = rawVal end

            task.defer(ExecuteCallbacks, callbacks, rawVal)
            sliderWidget.Value = rawVal

            local posTarget = UDim2.fromScale(alpha, 0.5)
            local sizeTarget = UDim2.fromScale(alpha, 1)

            valLabel.Text = tostring(math.floor(rawVal * 1000) / 1000)

            if self.Selected then
                CreateTween(sliderHandle, "Position", posTarget, 0.2):Play()
                CreateTween(barFill, "Size", sizeTarget, 0.2):Play()
            else
                sliderHandle.Position = posTarget
                barFill.Size = sizeTarget
            end
        end

        local ApplyNewValue = function(v)
            local clamped = math.clamp(RoundStep(v), minVal, maxVal)
            UpdateSliderValues(clamped, ScaleToAlpha(clamped))
        end

        sliderWidget.WHEN_VALUE_CHANGED = ApplyNewValue

        local CalculateDragAlpha = function(pos, size)
            local relX = (Mouse.X - pos.X) / size.X
            local alpha = math.clamp(relX, 0, 1)
            local calcVal = AlphaToValue(alpha)
            local stepped = math.clamp(RoundStep(calcVal), minVal, maxVal)
            UpdateSliderValues(stepped, ScaleToAlpha(stepped))
        end

        ApplyNewValue(defaultVal)

        ConnectEvent(sliderInteractive.MouseButton1Down, function()
            if InputBlocked ~= false then return end
            CreateTween(sliderHandle, "BackgroundTransparency", 0, 0.2):Play()
            container.ScrollingEnabled = false
            InputBlocked = true

            local bPos = barBg.AbsolutePosition
            local bSize = barBg.AbsoluteSize

            while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                CalculateDragAlpha(bPos, bSize)
                task.wait()
            end

            InputBlocked = false
            CreateTween(sliderHandle, "BackgroundTransparency", 0.1, 0.2):Play()
            container.ScrollingEnabled = true
        end)

        return sliderWidget
    end

    function TabClass:AddDropdown(cfg)
        local title, desc = ParseConfigTuple("Dropdown", cfg)
        local flag = ValidateFlag("Dropdown", cfg[5] or cfg.Flag)
        local options = cfg[2] or cfg.Options
        local defaultOpt = cfg[3] or cfg.Default
        local callbacks = ParseCallback(cfg[4] or cfg.Callback)
        local isMulti = cfg.MultiSelect

        if flag and type(StoredScriptFlags[flag]) == (isMulti and "table" or "string") then
            defaultOpt = StoredScriptFlags[flag]
        end

        local tabTheme = TabThemes[self]
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(1, -150, 0, 0))

        local dropFrame = CreateInstance("Frame", optionBtn, {
            Size = UDim2.new(0, 140, 0, 20),
            Position = UDim2.new(1, -10, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            Elements = { Corner = UDim.new(0, 4) },
            ThemeTag = { OBJECTS = tabTheme, BackgroundColor3 = "Colors.Stroke" }
        })

        local displayLabel = CreateInstance("TextLabel", dropFrame, {
            Size = UDim2.new(0.85, 0, 0.85, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            TextScaled = true,
            Text = "...",
            ThemeTag = { OBJECTS = tabTheme, TextColor3 = "Colors.Text.Default", Font = "Font.Bold" }
        })

        local iconTheme = { OBJECTS = tabTheme, Image = "Icons.Dropdown.Open", ImageColor3 = "Colors.Icons" }
        local arrowIcon = CreateInstance("ImageLabel", dropFrame, {
            Size = UDim2.new(0, 15, 0, 15),
            Position = UDim2.new(0, -5, 0.5),
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            ThemeTag = iconTheme
        })

        local dropWidget = WidgetRegistry.Dropdown.new(self, optionBtn, titleLabel, descLabel, callbacks)
        local selectedSingle, isQueued, isMenuOpen = nil, false, false
        local rawOptList, multiSelectedMap, stringCache = {}, {}, {}

        dropWidget.DROPDOWN_OPTIONS = rawOptList
        dropWidget.Opened = isMenuOpen

        local SetVisualState = function(colKey, iconKey)
            iconTheme.ImageColor3 = colKey
            iconTheme.Image = iconKey
            CreateTween(arrowIcon, "ImageColor3", ResolveThemePath(Library.CurrentTheme, colKey), 0.3):Play()
            arrowIcon.Image = ResolveThemePath(Library.CurrentTheme, iconKey)
        end

        local ToggleOpenVisuals = function(opened)
            isMenuOpen = opened
            dropWidget.Opened = opened
            local col = opened and "Colors.Primary" or "Colors.Icons"
            local icn = opened and "Icons.Dropdown.Close" or "Icons.Dropdown.Open"
            SetVisualState(col, icn)
        end

        local GetSelectedMultiKeys = function()
            local res = {}
            for k, v in multiSelectedMap do
                if v then res[#res + 1] = k end
            end
            return res
        end

        local UpdateDisplayText = function(val)
            local str = type(val) == "table" and table.concat(val, ", ") or (val or "")
            if #str >= 100 then str = str:sub(1, 97) .. "..." end
            displayLabel.Text = #str ~= 0 and str or "..."
        end

        local DispatchDropdownChange = function()
            isQueued = false
            local result = isMulti and GetSelectedMultiKeys() or (selectedSingle and selectedSingle.Name)
            ExecuteCallbacks(callbacks, isMulti and multiSelectedMap or result)
            UpdateDisplayText(result)
            if flag ~= nil then StoredScriptFlags[flag] = result end
        end

        local QueueDispatch = function()
            if not isQueued then
                isQueued = true
                task.delay(0.1, DispatchDropdownChange)
            end
        end

        local OnOptionSelected = function(optData)
            if isMulti then
                local nextState = not optData.Selected
                GlobalDropdownMenu.SetOptionValue(optData, nextState)
                multiSelectedMap[optData.Name] = nextState
            else
                if selectedSingle == optData then return nil end
                if selectedSingle ~= nil then
                    GlobalDropdownMenu.SetOptionValue(selectedSingle, false)
                end
                selectedSingle = optData
                GlobalDropdownMenu.SetOptionValue(optData, true)
            end
            QueueDispatch()
        end

        local RegisterRawOption = function(rawName)
            rawName = tostring(rawName)
            if stringCache[rawName] then return end
            local optData = { Name = rawName, DisplayName = rawName, Selected = false }
            if isMulti and multiSelectedMap[rawName] == nil then
                multiSelectedMap[rawName] = false
            end
            stringCache[rawName] = optData
            rawOptList[#rawOptList + 1] = optData
            return optData
        end

        local TriggerDropdownMenu = function(targetState)
            if isMenuOpen == targetState then return end
            if not GlobalDropdownMenu then
                GlobalDropdownMenu = CreateFloatingDropdownEngine()
            end
            if targetState then
                if not GlobalDropdownMenu.OpenDropdown(function() ToggleOpenVisuals(false) end) then return end
                GlobalDropdownMenu.SetHolder(dropFrame)
                GlobalDropdownMenu.SetMultiSelect(isMulti)
                GlobalDropdownMenu.SetOnClicked(OnOptionSelected)
                GlobalDropdownMenu.SetOptions(rawOptList)
            else
                GlobalDropdownMenu.CloseDropdown()
            end
            ToggleOpenVisuals(targetState)
        end

        dropWidget.ADD_DROPDOWN_OPTION = function(entry)
            if type(entry) == "table" then
                for i = 1, #entry do dropWidget:Add(entry[i]) end
                return nil
            end
            local opt = RegisterRawOption(entry)
            if opt then
                if dropWidget.Opened then GlobalDropdownMenu.CreateOptionTemplate(opt, true) end
                QueueDispatch()
            end
        end

        dropWidget.CLEAR_DROPDOWN = function()
            for i = #rawOptList, 1, -1 do
                local opt = rawOptList[i]
                if opt.Instance then opt.Instance:Destroy() end
                stringCache[opt.Name] = nil
                rawOptList[i] = nil
            end
            if dropWidget.Opened then GlobalDropdownMenu.Clear() end
        end

        if options then
            for i = 1, #options do RegisterRawOption(options[i]) end
        end

        ConnectEvent(optionBtn.Activated, function() TriggerDropdownMenu(not isMenuOpen) end)
        return dropWidget
    end

    function TabClass:AddParagraph(title, desc)
        local tabTheme = TabThemes[self]
        local optionBtn, titleLabel, descLabel = ConstructOptionBase(self, title, desc, UDim2.new(1, 0, 0, 0))
        return setmetatable({
            DESTROY_ELEMENT = optionBtn,
            VISIBLE_ELEMENT = optionBtn,
            TITLE_LABEL = titleLabel,
            DESCRIPTION_LABEL = descLabel,
            Title = title,
            Description = desc,
            Parent = self,
            Kind = "Paragraph"
        }, OptionClass)
    end

    function TabClass:SetFarmDetail(cfg)
        local priority = cfg[1] or cfg.Priority or cfg.ID
        local name = cfg[2] or cfg.Name or cfg.Title
        local status = cfg[3] or cfg.Status
        local info = cfg[4] or cfg.Info or cfg.Description

        self.FARM_DETAILS = self.FARM_DETAILS or {}
        local tag = `#{priority} {name}`
        local colHex = Library.FarmStatusColors[status]
        local statusTag = colHex and `<font color="{colHex}"><b><font size="13">{status}</font></b></font>` or `<b><font size="13">{status}</font></b>`
        local finalDesc = info and `{statusTag} <font size="11">{info}</font>` or statusTag

        local existing = self.FARM_DETAILS[priority]
        if existing then
            existing:SetTitle(tag)
            existing:SetDescription(finalDesc)
            existing.Priority = priority
            existing.Status = status
            existing.Info = info
        else
            existing = self:AddParagraph(tag, finalDesc)
            existing.DESTROY_ELEMENT.LayoutOrder = priority
            existing.Priority = priority
            existing.Status = status
            existing.Info = info
            self.FARM_DETAILS[priority] = existing
        end
        return existing
    end

    function TabClass:RemoveFarmDetail(priority)
        local target = self.FARM_DETAILS and self.FARM_DETAILS[priority]
        if target then
            target:Destroy()
            self.FARM_DETAILS[priority] = nil
        end
    end

    function TabClass:ClearFarmDetails()
        if not self.FARM_DETAILS then return end
        for _, item in self.FARM_DETAILS do item:Destroy() end
        table.clear(self.FARM_DETAILS)
    end

    TabClass.AddFarmDetail = TabClass.SetFarmDetail

    function TabClass:Select()
        if DropdownSearchContext == self then return nil end
        if DropdownSearchContext then
            TabSelectionHooks[DropdownSearchContext].Unselect()
        end
        DropdownSearchContext = self
        TabSelectionHooks[DropdownSearchContext].Select()
    end

    function OptionClass:SetTitle(str)
        self.TITLE_LABEL.Text = Localize(str)
        self.Title = str
        return self
    end

    function OptionClass:SetDescription(str)
        self.DESCRIPTION_LABEL.Text = Localize(str)
        self.Description = str
        return self
    end

    function OptionClass:Destroy()
        if self.DESTROY_ELEMENT then self.DESTROY_ELEMENT:Destroy() end
        setmetatable(self, nil)
        self.Destroyed = true
    end

    function WindowClass:Minimize()
        RootMainFrame.Visible = not RootMainFrame.Visible
    end

    function WindowClass:MakeTab(tabConfig)
        local title = tabConfig[1] or tabConfig.Name or tabConfig.Title
        local icon = tabConfig[2] or tabConfig.Icon or tabConfig.Image

        local tabObj = setmetatable({
            Selected = self.SelectedTab == #TabsRegistry + 1,
            Icon = Library:GetIconByName(icon),
            Title = title,
            Parent = self,
            IS_A_TAB = true
        }, TabClass)

        local elements = self:GetElements()
        local tabBtn, container, indicator = ConstructTabUI(self, tabObj, elements.TabsContainer)
        tabObj.TITLE_LABEL = tabBtn.Title

        local animDuration = 0.35
        local selectTweens = {
            CreateTween(indicator, "BackgroundTransparency", 0, animDuration),
            CreateTween(indicator, "Size", UDim2.fromOffset(4, 15), animDuration)
        }
        local unselectTweens = {
            CreateTween(indicator, "BackgroundTransparency", 1, animDuration),
            CreateTween(indicator, "Size", UDim2.fromOffset(4, 4), animDuration)
        }

        local localThemeManager = GlobalThemeManager:new()
        TabThemes[tabObj] = localThemeManager

        local RunTweens = function(tbl)
            for i = 1, #tbl do tbl[i]:Play() end
        end

        local OnSelect = function()
            RunTweens(selectTweens)
            tabObj.Selected = true
            localThemeManager:changeRendering(true)
            localThemeManager:update()
            container.Parent = elements.ContainerHolder
            container.Position = UDim2.new(0, 20, 1, 0)
            container.Size = UDim2.new(1, 0, 1, 0)
            CreateTween(container, "Position", UDim2.new(0, 0, 1, 0), 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()
        end

        local OnUnselect = function()
            RunTweens(unselectTweens)
            tabObj.Selected = false
            container.Parent = nil
            localThemeManager:changeRendering(false)
        end

        TabSelectionHooks[tabObj] = table.freeze{ Unselect = OnUnselect, Select = OnSelect }
        TabContainers[tabObj] = table.freeze{ SelectTabButton = tabBtn, Container = container }

        table.insert(TabsRegistry, tabObj)

        ConnectEvent(tabBtn.Activated, function() tabObj:Select() end)
        if tabObj.Selected then tabObj:Select() end

        return tabObj
    end

    function WindowClass:StartWindow(cfg)
        local minBtn = cfg.MinimizeButton
        local mainFrame = cfg.MainFrame
        local resizers = cfg.Resizers
        local topBar = cfg.TopBar
        local subTitleLabel = cfg.SubTitle
        local titleLabel = cfg.Title

        GlobalDropdownMenu = cfg.Dropdowns
        RootMainFrame = cfg.MainFrame
        RootUIScale = cfg.UIScale
        StoredScriptFlags = cfg.Flags

        local originalSize = mainFrame.Size
        local minDebounce = 0

        function WindowClass:MinimizeButton()
            if (tick() - minDebounce) < 0 then return false end
            if self.Minimized then
                minBtn.Image = "rbxassetid://10734896206"
                CreateTween(mainFrame, "Size", originalSize, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
            else
                originalSize = mainFrame.Size
                minBtn.Image = "rbxassetid://10734924532"
                CreateTween(mainFrame, "Size", UDim2.fromOffset(mainFrame.Size.X.Offset, topBar.Size.Y.Offset), 0.25):Play()
            end
            for _, r in resizers do r.Visible = self.Minimized end
            self.Minimized = not self.Minimized
            minDebounce = tick() + 0.5
            return true
        end

        NotificationFrame = CreateInstance("Frame", MainScreenGui, {
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
                    Padding = UDim.new(0, 10)
                }
            }
        })

        DialogOverlay = CreateInstance("TextButton", "OutBox", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 0.3,
            AutoButtonColor = false,
            Text = "",
            ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
            Childs = {
                mainFrame:FindFirstChildOfClass"UICorner":Clone(),
                CreateInstance("Frame", "Template", {
                    Size = UDim2.new(0.35, 60, 0.20, 80),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Active = true,
                    Elements = {
                        Corner = UDim.new(0, 8),
                        Gradient = { Rotation = 45, ThemeTag = { Color = "Colors.Background" } }
                    },
                    Childs = {
                        CreateInstance("TextLabel", "Title", {
                            Size = UDim2.new(1, -20, 0, 20),
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            TextSize = 15,
                            Position = UDim2.new(0.5, 0, 0, 25),
                            AnchorPoint = Vector2.new(0.5, 0),
                            BackgroundTransparency = 1,
                            ThemeTag = { Font = "Font.ExtraBold", TextColor3 = "Colors.Text.Default" }
                        }),
                        CreateInstance("TextLabel", "Description", {
                            Position = UDim2.new(0.5, 0, 0, 48),
                            Size = UDim2.new(1, -20, 0, 0),
                            AnchorPoint = Vector2.new(0.5, 0),
                            TextWrapped = true,
                            TextSize = 11,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundTransparency = 1,
                            ThemeTag = { TextColor3 = "Colors.Text.Darker", Font = "Font.Medium" }
                        }),
                        CreateInstance("Frame", "Options", {
                            Size = UDim2.new(1, -20, 0.2, 20),
                            Position = UDim2.new(0.5, 0, 1, -10),
                            AnchorPoint = Vector2.new(0.5, 1),
                            BackgroundTransparency = 1,
                            Elements = {
                                Padding = { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingTop = UDim.new(0, 10) },
                                ListLayout = { HorizontalAlignment = Enum.HorizontalAlignment.Right, VerticalAlignment = Enum.VerticalAlignment.Center, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8) }
                            }
                        })
                    }
                })
            }
        })

        DialogOverlay.Template:SetAttribute("OriginalSize", DialogOverlay.Template.Size)
        ConnectEvent(DialogOverlay.Activated, function()
            if ActiveDialog ~= nil and not ActiveDialog.Closing and not ActiveDialog.Closed then
                ActiveDialog:Close()
            end
        end)
    end

    function WindowClass:Dialog(dialogConfig)
        if self.Minimized then
            while not self:MinimizeButton() do task.wait() end
        end
        if ActiveDialog then ActiveDialog:Close(true) end

        local title = dialogConfig.Title or dialogConfig.Name
        local desc = dialogConfig.Content or dialogConfig.Description
        local options = dialogConfig.Options

        local tmpl = DialogOverlay.Template
        local descLabel = tmpl.Description
        local titleLabel = tmpl.Title
        local origSize = tmpl:GetAttribute"OriginalSize"
        local animStartSize = UDim2.new(origSize.X.Scale * 1.15, origSize.X.Offset, origSize.Y.Scale * 1.15, origSize.Y.Offset)

        tmpl.Size = animStartSize
        DialogOverlay.Parent = RootMainFrame
        descLabel.Text = desc
        titleLabel.Text = title

        CreateTween(tmpl, "Size", origSize, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()

        local dialogObj = WidgetRegistry.Dialog.new(descLabel, titleLabel)
        dialogObj.NEW_SIZE = animStartSize
        dialogObj.TEMPLATE = tmpl

        for _, item in tmpl.Options:GetChildren() do
            if item:IsA"GuiObject" then item:Destroy() end
        end

        for i = #options, 1, -1 do
            dialogObj:NewOption(options[i])
        end

        ActiveDialog = dialogObj
        return ActiveDialog
    end

    function WindowClass:Notify(notifyConfig)
        if type(notifyConfig) ~= "table" then notifyConfig = {} end
        local title = notifyConfig[1] or notifyConfig.Name or notifyConfig.Title or "Notification"
        local content = notifyConfig[2] or notifyConfig.Content or ""
        local duration = notifyConfig[4] or notifyConfig.Duration or 5

        local notifHolder = CreateInstance("Frame", "Notification", NotificationFrame, {
            Size = UDim2.new(0.9, 0, 0, 55),
            BackgroundTransparency = 1,
            AutomaticSize = Enum.AutomaticSize.Y
        })

        local notifBtn = CreateInstance("TextButton", notifHolder, {
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = UDim2.fromScale(1, 1),
            AutoButtonColor = false,
            Text = "",
            Position = UDim2.fromScale(2, 0),
            ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
            Elements = {
                Corner = UDim.new(0, 8),
                Stroke = { ThemeTag = { Color = "Colors.Primary" }, Thickness = 1.2 },
                Gradient = { Rotation = 45, ThemeTag = { Color = "Colors.Background" } }
            }
        })

        local contentContainer = CreateInstance("Frame", "Holder", notifBtn, {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Elements = {
                ListLayout = { SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 2) },
                Padding = { PaddingBottom = UDim.new(0, 8), PaddingTop = UDim.new(0, 8), PaddingLeft = UDim.new(0, 35), PaddingRight = UDim.new(0, 10) }
            }
        })

        CreateInstance("TextLabel", contentContainer, {
            Size = UDim2.new(1, 0, 0, 18),
            TextTruncate = Enum.TextTruncate.AtEnd,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            TextSize = 13,
            Text = title,
            ThemeTag = { TextColor3 = "Colors.Text.Default", Font = "Font.Bold" }
        })

        CreateInstance("TextLabel", contentContainer, {
            Size = UDim2.new(1, 0, 0, 16),
            TextXAlignment = Enum.TextXAlignment.Left,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            TextWrapped = true,
            TextSize = 11,
            Text = content,
            ThemeTag = { TextColor3 = "Colors.Text.Dark", Font = "Font.Normal" }
        })

        local notifHandle = { Closed = false }
        function notifHandle:Close()
            if self.Closed then return end
            self.Closed = true
            local tw = CreateTween(notifBtn, "Position", UDim2.fromScale(2, 0), 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            tw:Play()
            tw.Completed:Wait()
            notifHolder:Destroy()
        end

        CreateTween(notifBtn, "Position", UDim2.fromScale(0, 0), 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
        task.delay(duration, function() notifHandle:Close() end)

        return notifHandle
    end

    WindowEngine.Window = WindowClass
end

local ConstructBaseTabsFrame = function(cfg, topBar)
    local topOffset = topBar.Size.Y.Offset
    local scrollSize = UDim2.new(0, cfg.TabSize or Library.Default.TabSize, 1, -topOffset)
    local containerSize = UDim2.new(1, -scrollSize.X.Offset, 1, -topOffset)

    local tabsScroll = CreateInstance("ScrollingFrame", "TabsScroll", {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Position = UDim2.new(0, 0, 1, 0),
        AnchorPoint = Vector2.new(0, 1),
        ScrollBarThickness = 2,
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 0.2,
        CanvasSize = UDim2.new(),
        BorderSizePixel = 0,
        Size = scrollSize,
        ThemeTag = { ScrollBarImageColor3 = "Colors.ScrollBar" },
        Elements = {
            Padding = { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10) },
            ListLayout = { Padding = UDim.new(0, 4) }
        }
    })

    local containersHolder = CreateInstance("Frame", "Containers", {
        Size = containerSize,
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })

    return tabsScroll, containersHolder
end

function Library:GetIconByName(name)
    if name == nil then return end
    if IsAssetId(name) or #name == 0 then return name end
    local clean = CleanSearchString(name)
    if self.Icons and self.Icons[clean] then
        return "rbxassetid://" .. self.Icons[clean]
    end
    return name
end

function Library:IsValidTheme(themeName)
    return self.Themes[themeName] ~= nil
end

function Library:SetTheme(themeName)
    local theme = self.Themes[themeName]
    if theme then
        self.CurrentTheme = theme
        GlobalThemeManager:update()
    end
end

function Library:SetUIScale(scaleVal)
    MainScreenGui.Scale.Scale = CalculateUIScale(scaleVal)
end

function Library:Destroy()
    for _, conn in self.Connections do conn:Disconnect() end
    if MainScreenGui then pcall(MainScreenGui.Destroy, MainScreenGui) end
end

-- ==========================================================
-- INICIALIZAÇÃO DA JANELA COM MOTOR DE PARTÍCULAS
-- ==========================================================
function Library:MakeWindow(windowConfig)
    if self.LOADED_UI_LIBRARY then
        return error("you can create only 1 Window", 2)
    end

    local uid = math.random()
    MainScreenGui:SetAttribute("UID", uid)
    self.SCREENGUI_UID = uid
    MainScreenGui:ClearAllChildren()

    local uiScale = CreateInstance("UIScale", "Scale", MainScreenGui, { Scale = CalculateUIScale(1) })
    local config = {
        Title = windowConfig[1] or windowConfig.Name or windowConfig.Title or "Redz Hub",
        SubTitle = windowConfig[2] or windowConfig.SubName or windowConfig.SubTitle or "Car Dealership Tycoon",
        ScriptFolder = windowConfig[3] or windowConfig.ScriptFolder or windowConfig.FolderName
    }

    self.CurrentTheme = self.Themes[self.Default.Theme]
    self.LOADED_UI_LIBRARY = true

    local defaultSize = self.Default.UISize
    local mainWindow = CreateInstance("Frame", "Window", MainScreenGui, {
        Position = UDim2.new(0.5, -defaultSize.X.Offset / 2, 0.5, -defaultSize.Y.Offset / 2),
        Active = true,
        Size = UDim2.fromOffset(0, 0),
        ClipsDescendants = true,
        ThemeTag = { BackgroundTransparency = "BackgroundTransparency" },
        Elements = {
            Corner = UDim.new(0, 10),
            Stroke = { ThemeTag = { Color = "Colors.Stroke" }, Thickness = 1.2 },
            Gradient = { Rotation = 45, ThemeTag = { Color = "Colors.Background" } }
        }
    })

    -- Animação Suave de Entrada (Scale Back Out)
    CreateTween(mainWindow, "Size", defaultSize, 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()

    -- ==========================================================
    -- SISTEMA DE PARTÍCULAS E LINHAS DE DADOS NO FUNDO
    -- ==========================================================
    local particleContainer = CreateInstance("Frame", "ParticleContainer", mainWindow, {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 0
    })

    local particlesActive = true

    local function SpawnParticle()
        if not mainWindow or not mainWindow.Parent or not particlesActive then return end
        local pSize = math.random(2, 5)
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, pSize, 0, pSize)
        p.Position = UDim2.new(math.random(0, 100) / 100, 0, 1.05, 0)
        p.BackgroundColor3 = ResolveThemePath(Library.CurrentTheme, "Colors.Primary") or Color3.fromRGB(255, 35, 65)
        p.BackgroundTransparency = 0.3
        p.BorderSizePixel = 0
        p.ZIndex = 0
        p.Parent = particleContainer

        local c = Instance.new("UICorner")
        c.CornerRadius = UDim.new(1, 0)
        c.Parent = p

        local duration = math.random(3, 6)
        local tw = TweenService:Create(p, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            Position = UDim2.new(p.Position.X.Scale + (math.random(-5, 5) / 100), 0, -0.1, 0),
            BackgroundTransparency = 1
        })
        tw:Play()
        tw.Completed:Connect(function()
            if p then p:Destroy() end
        end)
    end

    local function SpawnDataLine()
        if not mainWindow or not mainWindow.Parent or not particlesActive then return end
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, 1, math.random(6, 14) / 100, 0)
        line.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.15, 0)
        line.BackgroundColor3 = ResolveThemePath(Library.CurrentTheme, "Colors.Primary") or Color3.fromRGB(200, 0, 30)
        line.BackgroundTransparency = 0.6
        line.BorderSizePixel = 0
        line.ZIndex = 0
        line.Parent = particleContainer

        local duration = math.random(2, 4)
        local tw = TweenService:Create(line, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            Position = UDim2.new(line.Position.X.Scale, 0, 1.15, 0)
        })
        tw:Play()
        tw.Completed:Connect(function()
            if line then line:Destroy() end
        end)
    end

    task.spawn(function()
        while particlesActive and mainWindow and mainWindow.Parent do
            if mainWindow.Visible then
                if math.random(1, 2) == 1 then
                    SpawnParticle()
                else
                    SpawnDataLine()
                end
            end
            task.wait(math.random(15, 30) / 100)
        end
    end)

    ConnectEvent(mainWindow.Destroying, function()
        particlesActive = false
        self:Destroy()
    end)

    InstanceBuilder.Draggable(mainWindow, uiScale, 0.5)

    local components = CreateInstance("Folder", "Components", mainWindow)
    local dropdownsFolder = CreateInstance("Folder", "Dropdowns", MainScreenGui)

    local topBar = CreateInstance("Frame", "TopBar", components, {
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        ZIndex = 2
    })

    local titleLabel = CreateInstance("TextLabel", "Title", topBar, {
        TextXAlignment = Enum.TextXAlignment.Left,
        AutomaticSize = Enum.AutomaticSize.XY,
        Position = UDim2.new(0, 15, 0.5, 0),
        AnchorPoint = Vector2.new(0, 0.5),
        Text = Localize(config.Title),
        TextSize = 13,
        BackgroundTransparency = 1,
        ThemeTag = { TextColor3 = "Colors.Text.Default", Font = "Font.Bold" },
        Childs = {
            CreateInstance("TextLabel", "SubTitle", {
                Size = UDim2.fromScale(0, 1),
                AutomaticSize = "X",
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(1, 6, 0.85),
                Text = Localize(config.SubTitle),
                BackgroundTransparency = 1,
                TextXAlignment = "Left",
                TextYAlignment = "Bottom",
                TextSize = 9,
                ThemeTag = { TextColor3 = "Colors.Text.Dark", Font = "Font.Normal" }
            })
        }
    })

    table.insert(Library.LocalizedLabels, { Instance = titleLabel, Original = config.Title })
    table.insert(Library.LocalizedLabels, { Instance = titleLabel.SubTitle, Original = config.SubTitle })

    local topButtons = CreateInstance("Folder", "Buttons", topBar, {
        Childs = {
            CreateInstance("ImageButton", "Close", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -10, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(255, 45, 45),
                AutoButtonColor = false,
                ThemeTag = { Image = "Icons.Close" },
                Elements = { Corner = UDim.new(0.3, 0) }
            }),
            CreateInstance("ImageButton", "Minimize", {
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -35, 0.5),
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(45, 45, 55),
                Image = "rbxassetid://10734896206",
                AutoButtonColor = false,
                Elements = { Corner = UDim.new(0.3, 0) }
            })
        }
    })

    local minBtn = topButtons.Minimize
    local closeBtn = topButtons.Close

    local windowObj = setmetatable(config, { __index = WindowEngine.Window })
    local tabsContainer, containerHolder = ConstructBaseTabsFrame({ TabSize = Library.Default.TabSize }, topBar)

    tabsContainer.Parent = components
    containerHolder.Parent = components

    local elements = table.freeze{
        ContainerHolder = containerHolder,
        TabsContainer = tabsContainer,
        Components = components,
        MainFrame = mainWindow
    }

    function windowObj:GetElements() return elements end

    local resizeWindow = CreateInstance("Frame", "ControlWindowSize", mainWindow, {
        Size = UDim2.new(0, 30, 0, 30),
        Position = mainWindow.Size,
        AnchorPoint = Vector2.new(0.8, 0.8),
        BackgroundTransparency = 1,
        Active = true,
        Elements = { Corner = UDim.new(0, 6) },
        ThemeTag = { BackgroundColor3 = "Colors.OnPrimary" }
    })

    local resizeTabs = CreateInstance("Frame", "ControlTabsSize", mainWindow, {
        Size = UDim2.new(0, 14, 0.75, -30),
        Position = UDim2.new(0, tabsContainer.Size.X.Offset, 0.5, 15),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Active = true,
        Elements = { Corner = UDim.new(0, 6) },
        ThemeTag = { BackgroundColor3 = "Colors.OnPrimary" }
    })

    InstanceBuilder.Draggable(resizeWindow, uiScale, 0.68, function(sx, ox, sy, oy)
        return UDim2.fromOffset(math.clamp(ox, 430, 1000), math.clamp(oy, 200, 500))
    end)

    InstanceBuilder.Draggable(resizeTabs, uiScale, 0.68, function(sx, ox)
        return UDim2.new(0, math.clamp(ox, 135, 210), 0.5, 15)
    end)

    ConnectEvent(minBtn.MouseEnter, function() CreateTween(minBtn, "BackgroundTransparency", 0.5, 0.2):Play() end)
    ConnectEvent(minBtn.MouseLeave, function() CreateTween(minBtn, "BackgroundTransparency", 1.0, 0.2):Play() end)
    ConnectEvent(closeBtn.MouseEnter, function() CreateTween(closeBtn, "BackgroundTransparency", 0.5, 0.2):Play() end)
    ConnectEvent(closeBtn.MouseLeave, function() CreateTween(closeBtn, "BackgroundTransparency", 1.0, 0.2):Play() end)

    windowObj.SetUIScale = self.SetUIScale
    windowObj.SUBTITLE_LABEL = titleLabel.SubTitle
    windowObj.TITLE_LABEL = titleLabel

    windowObj:StartWindow{
        Resizers = { resizeWindow, resizeTabs },
        MinimizeButton = minBtn,
        Dropdowns = dropdownsFolder,
        MainFrame = mainWindow,
        TopBar = topBar,
        SubTitle = titleLabel.SubTitle,
        Title = titleLabel,
        UIScale = uiScale,
        Flags = {}
    }

    ConnectEvent(minBtn.Activated, function() windowObj:MinimizeButton() end)
    ConnectEvent(closeBtn.Activated, function()
        windowObj:Dialog{
            Title = "Fechar Interface",
            Content = "Deseja realmente fechar o menu?",
            Options = {
                { Title = "Sim", Callback = function() self:Destroy() end },
                { Title = "Não" }
            }
        }
    end)

    return windowObj
end

return Library