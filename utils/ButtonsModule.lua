local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local targetGui = (gethui and gethui()) or CoreGui
local Screen = targetGui:FindFirstChild("ProButtonManagerUI")
if not Screen then
    Screen = Instance.new("ScreenGui")
    Screen.Name = "ProButtonManagerUI"
    Screen.ResetOnSpawn = false
    Screen.Parent = targetGui
end

local ButtonManager = {}
ButtonManager.Buttons = {}

local ButtonMethods = {}

function ButtonManager.GetButton(name)
    return ButtonManager.Buttons[name]
end

local ButtonProxy = {
    __index = function(self, key)
        if ButtonMethods[key] then return ButtonMethods[key] end
        if key == "Exist" then return self.Button ~= nil and self.Button.Parent ~= nil end
        return self.Button[key]
    end,
    __newindex = function(self, key, value)
        if key == "Config" or key == "Connections" or key == "Button" or key == "Stroke" then
            rawset(self, key, value)
        else
            self.Button[key] = value
        end
    end
}

function ButtonManager.new(config)
    local self = setmetatable({}, ButtonProxy)
    
    self.Config = {
        Name = config.Name or "ProButton",
        Text = config.Text or "Button",
        Size = config.Size or UDim2.new(0, 140, 0, 45),
        Position = config.Position or UDim2.new(0.5, -70, 0.5, -22),
        BackgroundColor = config.BackgroundColor or Color3.fromRGB(79, 70, 229),
        TextColor = config.TextColor or Color3.fromRGB(255, 255, 255),
        TextSize = config.TextSize or 16,
        Drag = config.Drag ~= nil and config.Drag or true,
        IsToggle = config.IsToggle or false,
        ToggleState = config.DefaultToggle or false,
        StrokeThickness = config.StrokeThickness or 2,
        OnClick = config.OnClick or function() end,
        OnPress = config.OnPress or function() end,
        OnRelease = config.OnRelease or function() end,
        OnToggle = config.OnToggle or function() end,
    }
    
    self.Connections = {}
    
    self.Button = Instance.new("TextButton")
    self.Button.Name = self.Config.Name
    self.Button.Size = self.Config.Size
    self.Button.Position = self.Config.Position
    self.Button.Text = self.Config.Text
    self.Button.TextColor3 = self.Config.TextColor
    self.Button.TextSize = self.Config.TextSize
    self.Button.Font = Enum.Font.GothamBold
    self.Button.AutoButtonColor = false
    self.Button.Parent = Screen

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = self.Button

    self.Stroke = Instance.new("UIStroke")
    self.Stroke.Thickness = self.Config.StrokeThickness
    self.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    self.Stroke.Parent = self.Button

    ButtonManager.Buttons[self.Config.Name] = self

    self:UpdateVisuals(0)
    self:SetupInput()

    return self
end

function ButtonMethods:UpdateVisuals(tweenDuration)
    local dur = tweenDuration or 0.25
    local tweenInfo = TweenInfo.new(dur, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    local goal = {}
    local strokeGoal = {}
    
    if self.Config.IsToggle then
        if self.Config.ToggleState then
            goal.BackgroundTransparency = 0
            goal.BackgroundColor3 = self.Config.BackgroundColor
            goal.TextColor3 = self.Config.TextColor
            strokeGoal.Transparency = 1
        else
            goal.BackgroundTransparency = 0.6
            goal.BackgroundColor3 = self.Config.BackgroundColor
            goal.TextColor3 = Color3.new(0.8, 0.8, 0.8)
            strokeGoal.Transparency = 0
            strokeGoal.Color = self.Config.BackgroundColor
        end
    else
        goal.BackgroundTransparency = 0
        goal.BackgroundColor3 = self.Config.BackgroundColor
        strokeGoal.Transparency = 1
    end
    
    TweenService:Create(self.Button, tweenInfo, goal):Play()
    TweenService:Create(self.Stroke, tweenInfo, strokeGoal):Play()
end

function ButtonMethods:SetupInput()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local isClickValid = false

    table.insert(self.Connections, self.Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Config.OnPress()
            isClickValid = true
            
            TweenService:Create(self.Button, TweenInfo.new(0.1), {Size = UDim2.new(self.Config.Size.X.Scale, self.Config.Size.X.Offset - 4, self.Config.Size.Y.Scale, self.Config.Size.Y.Offset - 2)}):Play()

            if self.Config.Drag then
                dragging = true
                dragStart = input.Position
                startPos = self.Button.Position
            end
        end
    end))

    table.insert(self.Connections, self.Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Config.OnRelease()
            dragging = false
            
            TweenService:Create(self.Button, TweenInfo.new(0.2, Enum.EasingStyle.Bounce), {Size = self.Config.Size}):Play()
            
            if isClickValid then
                self.Config.OnClick()
                if self.Config.IsToggle then
                    self.Config.ToggleState = not self.Config.ToggleState
                    self:UpdateVisuals()
                    self.Config.OnToggle(self.Config.ToggleState)
                end
            end
        end
    end))

    table.insert(self.Connections, UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging and dragStart then
                local delta = input.Position - dragStart
                if delta.Magnitude > 5 then
                    isClickValid = false
                end
                self.Button.Position = UDim2.new(
                    startPos.X.Scale, 
                    startPos.X.Offset + delta.X, 
                    startPos.Y.Scale, 
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end))
end

function ButtonMethods:Show()
    if self.Button then self.Button.Visible = true end
end

function ButtonMethods:Hide()
    if self.Button then self.Button.Visible = false end
end

function ButtonMethods:SetToggle(state)
    if self.Config.IsToggle then
        self.Config.ToggleState = state
        self:UpdateVisuals()
        self.Config.OnToggle(self.Config.ToggleState)
    end
end

function ButtonMethods:Delete()
    for _, connection in ipairs(self.Connections) do
        connection:Disconnect()
    end
    
    ButtonManager.Buttons[self.Config.Name] = nil
    
    local tween = TweenService:Create(self.Button, TweenInfo.new(0.2), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    tween:Play()
    tween.Completed:Wait()
    
    self.Button:Destroy()
end

return ButtonManager