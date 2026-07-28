local getFruit = {}

getFruit.Fruits = {
    ["Rocket"] = 15060012861,
    ["Spin"] = 15057683975,
    ["Blade"] = 15104782377,
    ["Spring"] = 15105281957,
    ["Bomb"] = 15107569005,
    ["Smoke"] = 15116696973,
    ["Spike"] = 15107005807,

    ["Flame"] = "BodyFlame", -- MeshId: 71296207199529

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

    return nil
end

return getFruit