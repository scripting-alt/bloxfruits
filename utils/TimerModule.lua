local ServerTime = {}
ServerTime.__index = ServerTime

ServerTime._initialized = false
ServerTime._startTimestamp = nil
ServerTime._tickCallbacks = {}
ServerTime._tickConnection = nil
ServerTime.FormatStyle = "full"

ServerTime.Events = {
    FruitSpawn = { interval = 3600, weekendInterval = 2700, duration = 1200 },
    Factory = { interval = 5400, duration = 300 },
    PirateRaid = { interval = 4500, duration = 0 }
}

local function formatFull(seconds)
    if not seconds or type(seconds) ~= "number" or seconds < 0 then
        return "00h 00m 00s"
    end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    return string.format("%02dh %02dm %02ds", h, m, s)
end

local function formatShort(seconds)
    if not seconds or type(seconds) ~= "number" or seconds < 0 then
        return "0s"
    end
    local h = math.floor(seconds / 3600)
    local m = math.floor((seconds % 3600) / 60)
    local s = math.floor(seconds % 60)
    local parts = {}
    if h > 0 then table.insert(parts, h .. "h") end
    if m > 0 then table.insert(parts, m .. "m") end
    if s > 0 or #parts == 0 then table.insert(parts, s .. "s") end
    return table.concat(parts, " ")
end

local function resolveFormat(value, defaultStyle)
    if value == true then
        return formatSeconds, defaultStyle, true
    elseif type(value) == "string" then
        return formatSeconds, value, true
    end
    return nil, nil, false
end

function formatSeconds(seconds, style)
    style = style or ServerTime.FormatStyle
    if style == "short" then
        return formatShort(seconds)
    end
    return formatFull(seconds)
end

local function findServerStartTimestamp()
    local oldest = nil

    for _, tbl in pairs(getgc(true)) do
        if type(tbl) == "table" then
            local success, launch = pcall(function()
                return rawget(tbl, "LaunchTime") or rawget(tbl, "timeIn")
            end)

            if success and type(launch) == "number" and launch > 1000000000 then
                if not oldest or launch < oldest then
                    oldest = launch
                end
            end
        end
    end

    return oldest
end

function ServerTime:SetFormatStyle(style)
    if style ~= "short" and style ~= "full" then
        return false
    end
    self.FormatStyle = style
    return true
end

function ServerTime:Init()
    if self._initialized then return true end

    local startTs = findServerStartTimestamp()

    if not startTs then
        warn("[ServerTime] Falha ao localizar timestamp.")
        return false
    end

    self._startTimestamp = startTs
    self._initialized = true

    self._tickConnection = task.spawn(function()
        while self._initialized do
            local uptime = self:GetUptime(false)
            for _, callback in pairs(self._tickCallbacks) do
                pcall(callback, uptime, formatSeconds(uptime, self.FormatStyle))
            end
            task.wait(1)
        end
    end)

    return true
end

function ServerTime:IsWeekend()
    local now = workspace:GetServerTimeNow()
    local utc = os.date("!*t", now)
    return utc.wday == 1 or utc.wday == 7 or (utc.wday == 6 and utc.hour >= 18)
end

function ServerTime:GetUptime(formatted)
    if not self._initialized then
        if formatted then
            return formatSeconds(0, type(formatted) == "string" and formatted or self.FormatStyle)
        end
        return 0
    end

    local uptime = workspace:GetServerTimeNow() - self._startTimestamp

    if formatted == true then
        return formatSeconds(uptime, self.FormatStyle)
    elseif type(formatted) == "string" then
        return formatSeconds(uptime, formatted)
    end
    return uptime
end

function ServerTime:_GetEventConfig(eventName)
    if eventName == "Fruit" or eventName == "FruitSpawn" then
        local interval = self:IsWeekend() and self.Events.FruitSpawn.weekendInterval or self.Events.FruitSpawn.interval
        return {
            interval = interval,
            duration = self.Events.FruitSpawn.duration,
            name = "FruitSpawn"
        }
    end

    local config = self.Events[eventName]
    if config then
        return {
            interval = config.interval,
            duration = config.duration,
            name = eventName
        }
    end

    return nil
end

function ServerTime:GetTimeUntil(eventName, formatted)
    if not self._initialized then
        if formatted then
            return formatSeconds(0, type(formatted) == "string" and formatted or self.FormatStyle)
        end
        return 0
    end

    local config = self:_GetEventConfig(eventName)
    if not config then
        if formatted then
            return formatSeconds(0, type(formatted) == "string" and formatted or self.FormatStyle)
        end
        return 0
    end

    local uptime = self:GetUptime(false)
    local timeLeft = config.interval - (uptime % config.interval)

    if formatted == true then
        return formatSeconds(timeLeft, self.FormatStyle)
    elseif type(formatted) == "string" then
        return formatSeconds(timeLeft, formatted)
    end
    return timeLeft
end

function ServerTime:GetEventStatus(eventName, formatted)
    local styleToUse = type(formatted) == "string" and formatted or self.FormatStyle
    local shouldFormat = formatted == true or type(formatted) == "string"

    if not self._initialized then
        return {
            Active = false,
            TimeUntilStart = shouldFormat and formatSeconds(0, styleToUse) or 0,
            TimeLeftActive = shouldFormat and formatSeconds(0, styleToUse) or 0
        }
    end

    local config = self:_GetEventConfig(eventName)
    if not config then
        return {
            Active = false,
            TimeUntilStart = shouldFormat and formatSeconds(0, styleToUse) or 0,
            TimeLeftActive = shouldFormat and formatSeconds(0, styleToUse) or 0
        }
    end

    local uptime = self:GetUptime(false)
    local timeInCycle = uptime % config.interval
    local active = config.duration > 0 and timeInCycle < config.duration
    local timeLeftActive = active and (config.duration - timeInCycle) or 0
    local timeUntilStart = config.interval - timeInCycle

    if shouldFormat then
        return {
            Active = active,
            TimeUntilStart = formatSeconds(timeUntilStart, styleToUse),
            TimeLeftActive = formatSeconds(timeLeftActive, styleToUse)
        }
    end

    return {
        Active = active,
        TimeUntilStart = timeUntilStart,
        TimeLeftActive = timeLeftActive
    }
end

function ServerTime:GetCycleCount(eventName)
    if not self._initialized then return 0 end

    local config = self:_GetEventConfig(eventName)
    if not config then return 0 end

    return math.floor(self:GetUptime(false) / config.interval)
end

function ServerTime:OnTick(callback)
    if type(callback) ~= "function" then return nil end
    local id = tostring(math.random(100000, 999999))
    self._tickCallbacks[id] = callback
    return id
end

function ServerTime:RemoveTick(id)
    if id and self._tickCallbacks[id] then
        self._tickCallbacks[id] = nil
        return true
    end
    return false
end

function ServerTime:GetStartTimestamp()
    return self._startTimestamp
end

function ServerTime:Format(seconds, style)
    return formatSeconds(seconds, style or self.FormatStyle)
end

function ServerTime:Destroy()
    self._initialized = false
    self._tickCallbacks = {}
    self._startTimestamp = nil
    self._tickConnection = nil
end

return ServerTime