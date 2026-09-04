-- changelog module for scripting-alt/bloxfruits
-- Adds a ChangeLog(tab):ChangeLog({...}) method to a tab/container
-- Usage:
-- local CL = require(path.to.this.module)
-- CL.PatchTab(tabContainer, LocalizeFunction)
-- After patching you can call: tabContainer:ChangeLog({ add = "Added Aimbot", remove = "Removed Old Aimbot", update = "Updated Aimbot" })

local M = {}

-- Default localizer (no-op)
local function defaultLocalize(t)
	return t
end

-- color constants
local COLOR_ADD = Color3.fromRGB(76, 175, 80)   -- green
local COLOR_REMOVE = Color3.fromRGB(217, 83, 79) -- red
local COLOR_UPDATE = Color3.fromRGB(240, 173, 78) -- yellow
local COLOR_TEXT = Color3.fromRGB(232,233,235)
local COLOR_SUBTEXT = Color3.fromRGB(200,200,200)

local function isInstance(x)
	local ok, ty = pcall(function() return typeof(x) end)
	if not ok then return false end
	return ty == "Instance"
end

local function ensureParentIsScrollingFrame(container)
	-- if the tab wrapper returns multiple values (button, container, ...) allow passing a table
	if type(container) == "table" then
		-- try to find a ScrollingFrame in values
		for _,v in pairs(container) do
			if isInstance(v) and v.ClassName == "ScrollingFrame" then
				return v
			end
		end
		-- fall back to first Instance-like value
		for _,v in pairs(container) do
			if isInstance(v) then return v end
		end
		return nil
	end

	if isInstance(container) and container.ClassName == "ScrollingFrame" then
		return container
	end

	-- if user passed a Frame which is a container, accept it too
	if isInstance(container) and container:IsA("Frame") then
		return container
	end

	return nil
end

local function createTextLabel(props)
	local lbl = Instance.new("TextLabel")
	for k,v in pairs(props) do
		if k ~= "Parent" then
			pcall(function() lbl[k] = v end)
		end
	end
	if props.Parent then lbl.Parent = props.Parent end
	return lbl
end

local function createSpacer(parent, height)
	height = height or 6
	local sp = Instance.new("Frame")
	sp.BackgroundTransparency = 1
	sp.Size = UDim2.new(1,0,0,height)
	sp.Parent = parent
	return sp
end

-- changes: table with keys add/remove/update. Each key may be string or array of strings.
-- LocalizeFn: function to translate text (optional)
local function attachChangeLogMethod(container, LocalizeFn)
	LocalizeFn = LocalizeFn or defaultLocalize

	function container:ChangeLog(changes)
		assert(type(changes) == "table", "ChangeLog: expected table")

		-- create a header
		local header = createTextLabel({
			Parent = container,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextSize = 16,
			Text = tostring(LocalizeFn("ChangeLog")),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			AutomaticSize = Enum.AutomaticSize.Y,
			TextColor3 = COLOR_TEXT
		})

		createSpacer(container, 6)

		local function createLine(symbol, color, text)
			local line = Instance.new("Frame")
			line.BackgroundTransparency = 1
			line.Size = UDim2.new(1,0,0,20)
			line.Parent = container

			local sym = createTextLabel({
				Parent = line,
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextSize = 14,
				Text = symbol,
				TextColor3 = color,
				Size = UDim2.new(0,28,1,0),
				TextXAlignment = Enum.TextXAlignment.Left
			})

			local lbl = createTextLabel({
				Parent = line,
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				Text = " " .. tostring(LocalizeFn(text)),
				TextColor3 = COLOR_SUBTEXT,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				Position = UDim2.new(0,28,0,0),
				Size = UDim2.new(1,-28,1,0),
				TextXAlignment = Enum.TextXAlignment.Left
			})

			return line
		end

		-- helper to process field which may be string or table
		local function processField(field, symbol, color)
			local v = changes[field]
			if v == nil then return end
			if type(v) == "string" then
				createLine(symbol, color, v)
			elseif type(v) == "table" then
				for _,item in ipairs(v) do
					if type(item) == "string" then createLine(symbol, color, item) end
				end
			end
		end

		processField("add", "[+]", COLOR_ADD)
		processField("remove", "[-]", COLOR_REMOVE)
		processField("update", "[/]", COLOR_UPDATE)
	end
end

-- Public patch function
-- tabContainer: either the ScrollingFrame instance or the table returned by the library tab creation (button, container, ...)
-- LocalizeFn (optional): function to translate strings (same signature as library's Localize)
function M.PatchTab(tabContainer, LocalizeFn)
	local container = ensureParentIsScrollingFrame(tabContainer)
	assert(container, "PatchTab: failed to find a suitable container (ScrollingFrame or Frame) in provided tab")
	attachChangeLogMethod(container, LocalizeFn)
	return container
end

return M
