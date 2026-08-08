local TweenService = game:GetService("TweenService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = PlayerGui:FindFirstChild("Notifications")

if not ScreenGui then
	ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "Notifications"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 200
	ScreenGui.Parent = PlayerGui
end

local UIPadding = ScreenGui:FindFirstChildOfClass("UIPadding")

if not UIPadding then
	UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = ScreenGui
end

UIPadding:GetPropertyChangedSignal("PaddingTop"):Connect(function()
	script:SetAttribute("Offset", UIPadding.PaddingTop.Offset)
end)

local isDungeonMap = workspace:GetAttribute("MAP") == "Dungeons"

local Config = {
	DEFAULT_MESSAGE = "<EMPTY MESSAGE>",
	DEFAULT_DURATION = 6,
	Y_PADDING = 33,
}

Config.START_POSITION = UDim2.new(0.5, -300, if isDungeonMap then 0.1 else 0, 4)
Config.LABEL_TEMPLATE = script:WaitForChild("NotificationTemplate")
Config.PARENT_GUI = ScreenGui

Config.RICH_TEXT_PROPERTIES = {
	Font = "SourceSansSemibold",
	TextStrokeTransparency = 0.5,
	TextColor3 = "255,255,255",
	TextStrokeColor3 = "0,0,0",
	TextScaled = false,
	TextSize = 32,
	TextYAlignment = "Center",
	ContainerVerticalAlignment = "Center",
	ContainerHorizontalAlignment = "Center",
}

Config.NEW_PROPERTIES = {
	Font = "SourceSansSemibold",
	TextStrokeTransparency = 0.5,
	TextScaled = false,
	TextSize = 32,
	TextYAlignment = "Center",
	TextColor3 = Color3.new(1, 1, 1),
	TextStrokeColor3 = Color3.new(),
}

local extraPaddingOffset = 0
local topHudListLayout: UIListLayout? = nil

local function refreshTopPadding()
	if topHudListLayout and topHudListLayout.AbsoluteContentSize.Y ~= 0 then
		UIPadding.PaddingTop = UDim.new(0, topHudListLayout.AbsoluteContentSize.Y + 5 + extraPaddingOffset)
	else
		UIPadding.PaddingTop = UDim.new(0, extraPaddingOffset)
	end
end

script.ChildAdded:Connect(function(child)
	if not child:IsA("NumberValue") then
		return
	end

	local lastValue = child.Value
	extraPaddingOffset += lastValue

	local changedConn: RBXScriptConnection
	local ancestryConn: RBXScriptConnection

	changedConn = child.Changed:Connect(function()
		extraPaddingOffset -= lastValue
		lastValue = child.Value
		extraPaddingOffset += lastValue
		refreshTopPadding()
	end)

	ancestryConn = child.AncestryChanged:Connect(function(_, newParent)
		if newParent then
			return
		end

		ancestryConn:Disconnect()
		changedConn:Disconnect()
		extraPaddingOffset -= lastValue
		refreshTopPadding()
	end)

	refreshTopPadding()
end)

task.spawn(function()
	local mainScreen = PlayerGui:WaitForChild("Main", 30)
	if not mainScreen then
		return
	end

	local topHudList = mainScreen:WaitForChild("TopHUDList", 30)
	if not topHudList then
		return
	end

	local listLayout = topHudList:WaitForChild("ListLayout", 30)
	if not listLayout or not listLayout:IsA("UIListLayout") then
		return
	end

	topHudListLayout = listLayout
	listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refreshTopPadding)
	refreshTopPadding()
end)

local NotificationStack = {
	Side = 0,
	Messages = {},
}

function NotificationStack:Add(notification)
	local enterFrom = Config.START_POSITION
		- UDim2.new(0, 0, 0, Config.START_POSITION.Y.Offset + Config.Y_PADDING * 1.5)
	local restingPosition = Config.START_POSITION + UDim2.new(0, 0, 0, #self.Messages * Config.Y_PADDING)

	if not notification.FirstTime then
		notification.FirstTime = true
		notification.Label.Position = enterFrom
	end

	TweenService:Create(notification.Label, TweenInfo.new(0.3), {
		Position = restingPosition,
	}):Play()

	table.insert(self.Messages, notification)
end

function NotificationStack:Update()
	for index, notification in next, self.Messages do
		if notification:Dead() then
			table.remove(self.Messages, index)
			self.Side = if self.Side == 1 then -1 else 1

			local exitPosition = notification.Label.Position + UDim2.new(0.5 * self.Side, 300 * self.Side, 0, 0)
			local exitTween = TweenService:Create(notification.Label, TweenInfo.new(0.5), {
				Position = exitPosition,
			})

			exitTween.Completed:Once(function()
				notification.Label:Destroy()
			end)
			exitTween:Play()

			local remaining = {}
			for _, message in next, self.Messages do
				table.insert(remaining, message)
			end

			self.Messages = {}
			for _, message in next, remaining do
				self:Add(message)
			end

			self:Update()
			return
		end
	end
end

task.spawn(function()
	while wait(0.25) do
		NotificationStack:Update()
	end
end)

local ColorShortcuts = {
	White = Color3.new(255 / 255, 255 / 255, 255 / 255),
	Black = Color3.new(0 / 255, 0 / 255, 0 / 255),
	Red = Color3.new(255 / 255, 102 / 255, 102 / 255),
	Green = Color3.new(102 / 255, 255 / 255, 102 / 255),
	Lime = Color3.new(0 / 255, 255 / 255, 0 / 255),
	Robux = Color3.new(0.109804, 0.745098, 0),
	Purple = Color3.new(255 / 255, 0 / 255, 255 / 255),
	Blue = Color3.new(0.55, 0.6, 1),
	Cyan = Color3.new(0.4, 0.85, 1),
	Orange = Color3.new(1, 0.5, 0.2),
	Yellow = Color3.new(1, 0.9, 0.2),
	Mythical = Color3.fromRGB(238, 47, 50),
	Premium = Color3.fromRGB(221, 188, 0),
	Legendary = Color3.fromRGB(213, 43, 228),
	Rare = Color3.fromRGB(140, 82, 255),
	Uncommon = Color3.fromRGB(92, 140, 211),
	Common = Color3.fromRGB(179, 179, 179),
	Maroon = Color3.fromRGB(141, 7, 7),
	BrightPurple = Color3.new(0.866667, 0.756863, 1),
	ValorCyan = Color3.fromRGB(85, 255, 255),
}

local HtmlEscapes = {
	["<"] = "&lt;",
	[">"] = "&gt;",
}

local function toByte(component: number): number
	return math.floor(component * 255 + 0.499)
end

local function Pretranslate(text: string)
	local tagCounts = {}
	local extractedTags = {}

	local result = text
		:gsub("<Color=([^%s>]+)>", function(colorName)
			tagCounts[colorName] = (tagCounts[colorName] or 0) + 1
			return ("{color%s_%s}"):format(tagCounts[colorName], colorName)
		end)
		:gsub("<AnimateYield=([0-9%.]+)>", function(seconds)
			tagCounts[seconds] = (tagCounts[seconds] or 0) + 1
			return ("{yield%s_%s}"):format(tagCounts[seconds], math.floor(tonumber(seconds) * 1000))
		end)
		:gsub("%b<>", function(tag)
			if tag:match("AnimateStyle") or tag:match("AnimateStepFrequency") or tag:match("AnimateStepTime") then
				return ""
			end

			local inner = tag:sub(2, #tag - 1)
			tagCounts.Items = (tagCounts.Items or 0) + 1
			extractedTags[tagCounts.Items] = inner

			return "{item" .. tagCounts.Items .. "}"
		end)

	return result, extractedTags
end

local function PostTranslate(text: string, extractedTags: { [number]: string })
	return text
		:gsub("{color%d+_([^}]+)}", function(colorName)
			return "<Color=" .. colorName:gsub(" ", "") .. ">"
		end)
		:gsub("{yield%d+_(%d+)}", function(ms)
			return "<AnimateYield=" .. tonumber(ms) / 1000 .. ">"
		end)
		:gsub("{item(%d+)}", function(itemIndex)
			return "<" .. extractedTags[tonumber(itemIndex)] .. ">"
		end)
end

local function TranslateText(parent: Instance, text: string): string
	local translator = nil
	local ok, err = pcall(function()
		translator = LocalizationService:GetTranslatorForPlayer(LocalPlayer)
	end)

	if not translator then
		warn("NO TRANSLATOR BRO", err)
		return text
	end

	local translateMe = Instance.new("TextLabel")
	translateMe.Name = "TranslateMe"
	translateMe.TextTransparency = 1
	translateMe.BackgroundTransparency = 1
	translateMe.Size = UDim2.new(0, 0, 0, 0)

	local pretranslated, extractedTags = Pretranslate(text)
	translateMe.Text = pretranslated
	translateMe.Parent = parent

	local translated = pretranslated
	pcall(function()
		translated = translator:Translate(translateMe, pretranslated)
	end)

	for key, tagBody in pairs(extractedTags) do
		pcall(function()
			extractedTags[key] = translator:Translate(workspace, tagBody)
		end)
	end

	return PostTranslate(translated, extractedTags)
end

local Notification = {}
Notification.__index = Notification

function Notification.new(message: string?, duration: number?)
	local text = if message then message else Config.DEFAULT_MESSAGE
	local displayDuration = if duration then duration else Config.DEFAULT_DURATION

	local label = Config.LABEL_TEMPLATE:Clone()
	label.AutoLocalize = false
	label.RichText = true

	for property, value in pairs(Config.NEW_PROPERTIES) do
		label[property] = value
	end

	label.Text = ""
	label.Parent = Config.PARENT_GUI

	local richText = TranslateText(label, "" .. text):gsub("<Color=/>", "\14/font\15")

	for name, color in pairs(ColorShortcuts) do
		local r, g = toByte(color.R), toByte(color.G)
		richText = richText:gsub(
			"<Color=" .. name .. ">",
			"\14font color=\"rgb(" .. r .. "," .. g .. "," .. toByte(color.B) .. ")\"\15"
		)
	end

	for char, escaped in pairs(HtmlEscapes) do
		richText = richText:gsub(char, escaped)
	end

	label.Text = richText:gsub("\14", "<"):gsub("\15", ">")

	return setmetatable({
		CreationTime = 0,
		Displayed = false,
		Label = label,
		Duration = displayDuration,
	}, Notification)
end

function Notification:Dead(): boolean
	return tick() - self.CreationTime > self.Duration
end

function Notification:Display(): boolean
	if self.Displayed then
		return false
	end

	self.Displayed = true
	self.CreationTime = tick()
	self.Label.Visible = true
	NotificationStack:Add(self)

	return true
end

return Notification