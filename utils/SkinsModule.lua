local FruitSkins = {
    Pain = {
        Default = {
        Default_Color1 = Color3.fromRGB(255, 55, 58),
        Default_Color2 = Color3.fromRGB(95, 14, 14),
        Default_Color3 = Color3.fromRGB(255, 114, 112),

        Shifted_Color1 = Color3.fromRGB(255, 55, 58),
        Shifted_Color2 = Color3.fromRGB(95, 14, 14),
        Shifted_Color3 = Color3.fromRGB(255, 114, 112),
        GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
        GrayscaleToColorStrength = 0,
        },
        DeepBlue = {
            Default_Color1 = Color3.fromRGB(255, 55, 58),
            Default_Color2 = Color3.fromRGB(95, 14, 14),
            Default_Color3 = Color3.fromRGB(255, 114, 112),

            Shifted_Color1 = Color3.fromRGB(55, 58, 255),
            Shifted_Color2 = Color3.fromRGB(14, 14, 95),
            Shifted_Color3 = Color3.fromRGB(112, 138, 255),
            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
            GrayscaleToColorStrength = 0,
        },
        Red = {
            Default_Color1 = Color3.fromRGB(255, 55, 58),
            Default_Color2 = Color3.fromRGB(95, 14, 14),
            Default_Color3 = Color3.fromRGB(255, 114, 112),

            Shifted_Color1 = Color3.fromRGB(84, 0, 0),
            Shifted_Color2 = Color3.fromRGB(43, 0, 0),
            Shifted_Color3 = Color3.fromRGB(0, 0, 0),
            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
            GrayscaleToColorStrength = 1,
        },
        Orange = {
            Default_Color1 = Color3.fromRGB(255, 55, 58),
            Default_Color2 = Color3.fromRGB(95, 14, 14),
            Default_Color3 = Color3.fromRGB(255, 114, 112),

            Shifted_Color1 = Color3.fromRGB(255, 95, 55),
            Shifted_Color2 = Color3.fromRGB(95, 41, 14),
            Shifted_Color3 = Color3.fromRGB(255, 131, 112),
            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
            GrayscaleToColorStrength = 0,
        },
        Celestial = {
            Default_Color1 = Color3.fromRGB(255, 55, 58),
            Default_Color2 = Color3.fromRGB(95, 14, 14),
            Default_Color3 = Color3.fromRGB(255, 114, 112),

            Shifted_Color1 = Color3.fromRGB(82, 55, 255),
            Shifted_Color2 = Color3.fromRGB(28, 14, 95),
            Shifted_Color3 = Color3.fromRGB(112, 117, 255),
            GrayscaleToColorSequence = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            GrayscaleToColorStrength = 1,
        },
        SuperSpirit = {
            Default_Color1 = Color3.fromRGB(255, 55, 58),
            Default_Color2 = Color3.fromRGB(95, 14, 14),
            Default_Color3 = Color3.fromRGB(255, 114, 112),

            Shifted_Color1 = Color3.fromRGB(255, 252, 55),
            Shifted_Color2 = Color3.fromRGB(95, 95, 14),
            Shifted_Color3 = Color3.fromRGB(255, 255, 112),
            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(60, 128, 255)),
            GrayscaleToColorStrength = 1,
        },
    },

    Portal = {
        Default = {
            Default_Color1 = Color3.fromRGB(120, 0, 255),
            Default_Color2 = Color3.fromRGB(40, 0, 100),
            Default_Color3 = Color3.fromRGB(200, 100, 255),

            Shifted_Color1 = Color3.fromRGB(120, 0, 255),
            Shifted_Color2 = Color3.fromRGB(40, 0, 100),
            Shifted_Color3 = Color3.fromRGB(200, 100, 255),

            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
            GrayscaleToColorStrength = 0,
        },

        Divine = {
            GrayscaleToColorStrength = 0.2,
            Default_Color1 = Color3.fromRGB(176, 255, 246),
            Default_Color2 = Color3.fromRGB(84, 189, 255),
            Default_Color3 = Color3.fromRGB(74, 131, 255),
            Default_Color4 = Color3.fromRGB(0, 60, 255),
            Default_Color5 = Color3.fromRGB(102, 118, 255),
            Default_Color6 = Color3.fromRGB(0, 0, 255),
            Default_Color7 = Color3.fromRGB(110, 63, 248),
            Shifted_Color1 = Color3.fromRGB(255, 229, 97),
            Shifted_Color2 = Color3.fromRGB(255, 225, 30),
            Shifted_Color3 = Color3.fromRGB(255, 199, 16),
            Shifted_Color4 = Color3.fromRGB(255, 158, 21),
            Shifted_Color5 = Color3.fromRGB(141, 118, 0),
            Shifted_Color6 = Color3.fromRGB(83, 69, 0),
            Shifted_Color7 = Color3.fromRGB(248, 158, 41),
            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 255, 255))
        },
    },

    Yeti = {
        Default = {
            Default_Color1 = Color3.fromRGB(255, 255, 255),
            Default_Color2 = Color3.fromRGB(100, 180, 255),
            Default_Color3 = Color3.fromRGB(180, 230, 255),

            Shifted_Color1 = Color3.fromRGB(255, 255, 255),
            Shifted_Color2 = Color3.fromRGB(100, 180, 255),
            Shifted_Color3 = Color3.fromRGB(180, 230, 255),

            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(255, 255, 255)),
            GrayscaleToColorStrength = 0,
        },

        Frozen = {
            Default_Color1 = Color3.fromRGB(255, 255, 255),
            Default_Color2 = Color3.fromRGB(100, 180, 255),
            Default_Color3 = Color3.fromRGB(180, 230, 255),

            Shifted_Color1 = Color3.fromRGB(0, 100, 255),
            Shifted_Color2 = Color3.fromRGB(0, 30, 100),
            Shifted_Color3 = Color3.fromRGB(100, 200, 255),

            GrayscaleToColorSequence = ColorSequence.new(Color3.fromRGB(100, 200, 255)),
            GrayscaleToColorStrength = 1,
        },
    },
}

function FruitSkins.GetSkinData(Fruit, Skin)
    return FruitSkins[Fruit] and FruitSkins[Fruit][Skin]
        or FruitSkins[Fruit] and FruitSkins[Fruit].Default
end

return FruitSkins