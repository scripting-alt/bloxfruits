local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = ReplicatedStorage.Modules.Net

local Realm = {}
local Cache = {}

local GetRealmHasTag
local GetRealmDifficulty

if RunService:IsRunning() then
    GetRealmHasTag = game:GetService("ReplicatedStorage").Modules.Net["RF/GetRealmHasTag"]:InvokeServer()
    GetRealmDifficulty = game:GetService("ReplicatedStorage").Modules.Net["RF/GetRealmDifficulty"]:InvokeServer()
end

Realm._Remotes = {
    GetHasTag = GetRealmHasTag,
    GetDifficulty = GetRealmDifficulty
}