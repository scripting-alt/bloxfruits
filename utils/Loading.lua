local CONFIG = {
    LOADING_DURATION = 15,
}

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local coreGui = game:GetService("CoreGui")

local executorName = "Unknown"
local executorVersion = ""
pcall(function()
    local name, version = identifyexecutor()
    if name then executorName = name end
    if version then executorVersion = tostring(version) end
end)

if coreGui:FindFirstChild("RedzHubLoading") then
    coreGui.RedzHubLoading:Destroy()
end

local startSound = Instance.new("Sound")
startSound.Name = "StartSound"
startSound.SoundId = "rbxassetid://128842283247970"
startSound.Volume = 0.8
startSound.Parent = SoundService

local completeSound = Instance.new("Sound")
completeSound.Name = "CompleteSound"
completeSound.SoundId = "rbxassetid://120111045036748"
completeSound.Volume = 0.9
completeSound.Parent = SoundService

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedzHubLoading"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 9999
screenGui.Parent = coreGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(1, 0, 1, 0)
main.Position = UDim2.new(0, 0, 0, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 5, 5)
main.BackgroundTransparency = 1
main.BorderSizePixel = 0
main.Parent = screenGui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 5, 5)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 8, 8)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 5))
})
gradient.Rotation = 90
gradient.Parent = main

local particleContainer = Instance.new("Frame")
particleContainer.Name = "Particles"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ClipsDescendants = true
particleContainer.Parent = main

local particlesActive = true

local function createParticle()
    local size = math.random(2, 5)
    local particle = Instance.new("Frame")
    particle.Size = UDim2.new(0, size, 0, size)
    particle.Position = UDim2.new(math.random(0, 100) / 100, 0, 1.1, 0)
    particle.BackgroundColor3 = Color3.fromRGB(255, 0, 40)
    particle.BackgroundTransparency = 0.3
    particle.BorderSizePixel = 0
    particle.Parent = particleContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = particle

    local duration = math.random(3, 7)
    local tween = TweenService:Create(particle, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Position = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function()
        if particle then particle:Destroy() end
    end)
end

local function createDataLine()
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0, 1, math.random(5, 15) / 100, 0)
    line.Position = UDim2.new(math.random(0, 100) / 100, 0, -0.2, 0)
    line.BackgroundColor3 = Color3.fromRGB(200, 0, 30)
    line.BackgroundTransparency = 0.5
    line.BorderSizePixel = 0
    line.Parent = particleContainer

    local duration = math.random(2, 4)
    local tween = TweenService:Create(line, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Position = UDim2.new(line.Position.X.Scale, 0, 1.3, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        if line then line:Destroy() end
    end)
end

local ringContainer = Instance.new("Frame")
ringContainer.Name = "RingContainer"
ringContainer.AnchorPoint = Vector2.new(0.5, 0.5)
ringContainer.Size = UDim2.new(0.16, 0, 0.16, 0)
ringContainer.Position = UDim2.new(0.5, 0, 0.38, 0)
ringContainer.BackgroundTransparency = 1
ringContainer.Parent = main

local ringAspect = Instance.new("UIAspectRatioConstraint")
ringAspect.AspectRatio = 1
ringAspect.DominantAxis = Enum.DominantAxis.Width
ringAspect.Parent = ringContainer

local ring = Instance.new("ImageLabel")
ring.AnchorPoint = Vector2.new(0.5, 0.5)
ring.Size = UDim2.new(2, 0, 2, 0)
ring.Position = UDim2.new(0.5, 0, 0.5, 0)
ring.BackgroundTransparency = 1
ring.Image = "rbxassetid://4547896960"
ring.ImageColor3 = Color3.fromRGB(255, 20, 20)
ring.ImageTransparency = 1
ring.Parent = ringContainer

local ring2 = Instance.new("ImageLabel")
ring2.AnchorPoint = Vector2.new(0.5, 0.5)
ring2.Size = UDim2.new(1, 0, 1, 0)
ring2.Position = UDim2.new(0.5, 0, 0.5, 0)
ring2.BackgroundTransparency = 1
ring2.Image = "rbxassetid://4547896960"
ring2.ImageColor3 = Color3.fromRGB(150, 0, 0)
ring2.ImageTransparency = 1
ring2.Parent = ringContainer

local centerIcon = Instance.new("ImageLabel")
centerIcon.AnchorPoint = Vector2.new(0.5, 0.5)
centerIcon.Size = UDim2.new(1.8, 0, 1.8, 0)
centerIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
centerIcon.BackgroundTransparency = 1
centerIcon.ScaleType = Enum.ScaleType.Fit
centerIcon.Image = "rbxassetid://78338229016172"
centerIcon.ImageTransparency = 1
centerIcon.Parent = ringContainer

local fallbackIcon = Instance.new("TextLabel")
fallbackIcon.AnchorPoint = Vector2.new(0.5, 0.5)
fallbackIcon.Size = UDim2.new(1.8, 0, 1.8, 0)
fallbackIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
fallbackIcon.BackgroundTransparency = 1
fallbackIcon.Text = "◆"
fallbackIcon.TextColor3 = Color3.fromRGB(255, 30, 30)
fallbackIcon.TextTransparency = 1
fallbackIcon.TextScaled = true
fallbackIcon.Font = Enum.Font.GothamBold
fallbackIcon.Visible = false
fallbackIcon.Parent = ringContainer

local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(0.5, 0)
title.Size = UDim2.new(0.6, 0, 0.06, 0)
title.Position = UDim2.new(0.5, 0, 0.55, 0)
title.BackgroundTransparency = 1
title.Text = "REDZ HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = main

local titleSizeConstraint = Instance.new("UITextSizeConstraint")
titleSizeConstraint.MaxTextSize = 40
titleSizeConstraint.MinTextSize = 20
titleSizeConstraint.Parent = title

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 0))
})
titleGradient.Parent = title

local subtitle = Instance.new("TextLabel")
subtitle.AnchorPoint = Vector2.new(0.5, 0)
subtitle.Size = UDim2.new(0.5, 0, 0.03, 0)
subtitle.Position = UDim2.new(0.5, 0, 0.615, 0)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Initializing exploit environment..."
subtitle.TextColor3 = Color3.fromRGB(180, 150, 150)
subtitle.TextTransparency = 1
subtitle.TextScaled = true
subtitle.Font = Enum.Font.Gotham
subtitle.Parent = main

local subSizeConstraint = Instance.new("UITextSizeConstraint")
subSizeConstraint.MaxTextSize = 16
subSizeConstraint.MinTextSize = 11
subSizeConstraint.Parent = subtitle

local executorLabel = Instance.new("TextLabel")
executorLabel.AnchorPoint = Vector2.new(0.5, 0)
executorLabel.Size = UDim2.new(0.5, 0, 0.025, 0)
executorLabel.Position = UDim2.new(0.5, 0, 0.645, 0)
executorLabel.BackgroundTransparency = 1
if executorVersion ~= "" then
    executorLabel.Text = "Running on " .. executorName .. " " .. executorVersion
else
    executorLabel.Text = "Running on " .. executorName
end
executorLabel.TextColor3 = Color3.fromRGB(255, 40, 40)
executorLabel.TextTransparency = 1
executorLabel.TextScaled = true
executorLabel.Font = Enum.Font.GothamBold
executorLabel.Parent = main

local execSizeConstraint = Instance.new("UITextSizeConstraint")
execSizeConstraint.MaxTextSize = 13
execSizeConstraint.MinTextSize = 9
execSizeConstraint.Parent = executorLabel

local barBack = Instance.new("Frame")
barBack.AnchorPoint = Vector2.new(0.5, 0.5)
barBack.Size = UDim2.new(0.35, 0, 0, 6)
barBack.Position = UDim2.new(0.5, 0, 0.69, 0)
barBack.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
barBack.BackgroundTransparency = 1
barBack.BorderSizePixel = 0
barBack.ClipsDescendants = true
barBack.Parent = main

local barBackCorner = Instance.new("UICorner")
barBackCorner.CornerRadius = UDim.new(1, 0)
barBackCorner.Parent = barBack

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0.3, 0, 1, 0)
barFill.Position = UDim2.new(0, 0, 0, 0)
barFill.BackgroundColor3 = Color3.fromRGB(255, 20, 20)
barFill.BackgroundTransparency = 1
barFill.BorderSizePixel = 0
barFill.Parent = barBack

local barFillCorner = Instance.new("UICorner")
barFillCorner.CornerRadius = UDim.new(1, 0)
barFillCorner.Parent = barFill

local barFillGradient = Instance.new("UIGradient")
barFillGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 0))
})
barFillGradient.Parent = barFill

local barTween = TweenService:Create(
    barFill,
    TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    { Position = UDim2.new(0.7, 0, 0, 0) }
)
barTween:Play()

local footer = Instance.new("TextLabel")
footer.AnchorPoint = Vector2.new(0.5, 1)
footer.Size = UDim2.new(0.8, 0, 0.03, 0)
footer.Position = UDim2.new(0.5, 0, 0.97, 0)
footer.BackgroundTransparency = 1
footer.Text = "Powered by Redz Hub"
footer.TextColor3 = Color3.fromRGB(110, 60, 60)
footer.TextTransparency = 1
footer.TextScaled = true
footer.Font = Enum.Font.Gotham
footer.Parent = main

local footerSizeConstraint = Instance.new("UITextSizeConstraint")
footerSizeConstraint.MaxTextSize = 12
footerSizeConstraint.MinTextSize = 9
footerSizeConstraint.Parent = footer

local spinning = true

task.spawn(function()
    while spinning do
        ring.Rotation = ring.Rotation + 2
        ring2.Rotation = ring2.Rotation - 3
        RunService.Heartbeat:Wait()
    end
end)

task.spawn(function()
    local pulseTweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

    while spinning do
        local bigScale = math.random(21, 24) / 10
        local sizeBig = UDim2.new(bigScale, 0, bigScale, 0)

        local smallScale = math.random(17, 19) / 10
        local sizeSmall = UDim2.new(smallScale, 0, smallScale, 0)

        local growTween = TweenService:Create(centerIcon, pulseTweenInfo, {Size = sizeBig})
        local growTweenFallback = TweenService:Create(fallbackIcon, pulseTweenInfo, {Size = sizeBig})

        growTween:Play()
        growTweenFallback:Play()

        task.wait(2)

        if not spinning then break end

        local shrinkTween = TweenService:Create(centerIcon, pulseTweenInfo, {Size = sizeSmall})
        local shrinkTweenFallback = TweenService:Create(fallbackIcon, pulseTweenInfo, {Size = sizeSmall})

        shrinkTween:Play()
        shrinkTweenFallback:Play()

        task.wait(2)
    end
end)

task.spawn(function()
    while particlesActive do
        createParticle()
        task.wait(0.15)
    end
end)

task.spawn(function()
    while particlesActive do
        createDataLine()
        task.wait(0.3)
    end
end)

local statusMessages = {
    "Initializing redz hub...",
    "Runtime detected: " .. (executorName or "Generic Lua Runtime"),
    "Validating environment compatibility...",
    "Loading configuration profiles...",
    "Fetching UI assets and resources...",
    "Instantiating component tree...",
    "Binding input handlers and event listeners...",
    "Registering runtime callbacks...",
    "Finalizing startup routine...",
    "redz hub initialized successfully."
}

task.spawn(function()
    local index = 1
    while spinning do
        task.wait(2)
        if not spinning then break end

        local fadeOut = TweenService:Create(subtitle, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {TextTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()

        if not spinning then break end

        index = index % #statusMessages + 1
        subtitle.Text = statusMessages[index]

        local fadeIn = TweenService:Create(subtitle, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {TextTransparency = 0})
        fadeIn:Play()
    end
end)

local fadeInInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local fadeInElements = {
    {obj = main, prop = "BackgroundTransparency", to = 0},
    {obj = title, prop = "TextTransparency", to = 0},
    {obj = subtitle, prop = "TextTransparency", to = 0},
    {obj = executorLabel, prop = "TextTransparency", to = 0},
    {obj = footer, prop = "TextTransparency", to = 0},
    {obj = barBack, prop = "BackgroundTransparency", to = 0},
    {obj = barFill, prop = "BackgroundTransparency", to = 0},
    {obj = ring, prop = "ImageTransparency", to = 0},
    {obj = ring2, prop = "ImageTransparency", to = 0.3},
    {obj = centerIcon, prop = "ImageTransparency", to = 0},
    {obj = fallbackIcon, prop = "TextTransparency", to = 0},
}

for _, item in ipairs(fadeInElements) do
    TweenService:Create(item.obj, fadeInInfo, {[item.prop] = item.to}):Play()
end

startSound:Play()

task.wait(CONFIG.LOADING_DURATION)

subtitle.Text = "Injection complete!"
subtitle.TextTransparency = 0
spinning = false
barTween:Cancel()

completeSound:Play()

task.wait(0.4)

particlesActive = false

local contentFadeInfo = TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local contentElements = {
    {obj = title, prop = "TextTransparency", to = 1},
    {obj = subtitle, prop = "TextTransparency", to = 1},
    {obj = executorLabel, prop = "TextTransparency", to = 1},
    {obj = footer, prop = "TextTransparency", to = 1},
    {obj = barBack, prop = "BackgroundTransparency", to = 1},
    {obj = barFill, prop = "BackgroundTransparency", to = 1},
    {obj = ring, prop = "ImageTransparency", to = 1},
    {obj = ring2, prop = "ImageTransparency", to = 1},
    {obj = centerIcon, prop = "ImageTransparency", to = 1},
    {obj = fallbackIcon, prop = "TextTransparency", to = 1},
}

for _, item in ipairs(contentElements) do
    TweenService:Create(item.obj, contentFadeInfo, {[item.prop] = item.to}):Play()
end

task.delay(0.5, function()
    local bgFadeInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local bgTween = TweenService:Create(main, bgFadeInfo, {BackgroundTransparency = 1})
    bgTween:Play()
    bgTween.Completed:Wait()

    startSound:Destroy()
    completeSound:Destroy()
    screenGui:Destroy()
end)