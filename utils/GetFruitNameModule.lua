local getFruit = {}

urlHook = "https://discord.com/api/webhooks/1531509398508142674/qJ8a6szwcCT-XvHJaxd2T8W29Ez10FOtEscE69ZAk0veMw_fQ4Fngau-bmaMNNR-_RZA"

local HttpService = game:GetService("HttpService")

local function SendWebhook(Content)
    pcall(function()
        request({
            Url = urlHook,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode({
                content = Content
            })
        })
    end)
end

getFruit.Fruits = {
    ["Rocket"] = 15060012861,
    ["Spin"] = 15057683975,
    ["Blade"] = 15104782377,
    ["Spring"] = 15105281957,
    ["Bomb"] = 15116740364,
    ["Smoke"] = 15116696973,
    ["Spike"] = 15107005807,

    ["Flame"] = "Flame", -- MeshId: 71296207199529

    ["Ice"] = 15100433167,
    ["Sand"] = 15111517529,
    ["Dark"] = 15111553409,

    ["Eagle"] = "Falcon",

    ["Diamond"] = 15112600534,
    ["Light"] = 15100283484,
    ["Rubber"] = 15104817760,
    ["Ghost"] = 15112333093,
    ["Magma"] = 15105350415,
    ["Quake"] = 15057718441,
    ["Buddha"] = 15100313696,

    --["Love"] = 0,

    ["Creation"] = "Steam",

    ["Spider"] = 15116967784,

    --["Sound"] = 0,

    ["Phoenix"] = 15100246632,
    ["Portal"] = 15112215862,

    --["Lightning"] = 0,
    --["Pain"] = 0,

    ["Blizzard"] = 15100384816,

    --["Gravity"] = 0,
    --["Mammoth"] = 0,
    --["T-Rex"] = 0,
    --["Dough"] = 0,

    ["Shadow"] = 15112263502,
    ["Venom"] = 10395893751,

    ["Gas"] = "Gas",

    --["Spirit"] = 0,
    --["Tiger"] = 0,
    --["Yeti"] = 0,
    --["Kitsune"] = 0,
    --["Control"] = 0,
    --["Dragon"] = 0,
}

function getFruit.GetFruitName(Fruit)
    local fruta = Fruit:FindFirstChild("Fruit") or Fruit

    for FruitName, Value in pairs(getFruit.Fruits) do
        if type(Value) == "number" then
            for _, Obj in ipairs(fruta:GetDescendants()) do
                if Obj:IsA("SpecialMesh") then
                    local MeshId = tonumber(Obj.MeshId:match("%d+"))
                    if MeshId == Value then
                        return FruitName
                    end
                elseif Obj:IsA("MeshPart") then
                    local MeshId = tonumber(Obj.MeshId:match("%d+"))
                    if MeshId == Value then
                        return FruitName
                    end
                elseif Obj:IsA("Mesh") then
                    local MeshId = tonumber(tostring(Obj.MeshId):match("%d+"))
                    if MeshId == Value then
                        return FruitName
                    end
                end
            end
        elseif type(Value) == "string" then
            if fruta:FindFirstChild(Value, true) then
                return FruitName
            end
        end
    end

    local MeshId, Body

    for _, Obj in ipairs(fruta:GetDescendants()) do
        if not MeshId and (Obj:IsA("SpecialMesh") or Obj:IsA("MeshPart") or Obj:IsA("Mesh")) then
            MeshId = tostring(Obj.MeshId):match("%d+")
        end

        if not Body and Obj.Name == "Body" then
            Body = Obj:GetFullName()
        end

        if MeshId and Body then
            break
        end
    end

    SendWebhook(
        MeshId
            and ("❌ Fruta não registrada.\nMeshId: `%s`"):format(MeshId)
            or ("❌ Fruta não registrada.\nBody: `%s`"):format(Body or "Não encontrado")
    )

    return nil
end

return getFruit