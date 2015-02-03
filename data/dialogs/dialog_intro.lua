require "dialog"
require "character"


local dialog = Dialog()


--*******************
--       Sprites
--*******************

local VicHatshade_Sprite = CharSprite()
VicHatshade_Sprite.age = 45
VicHatshade_Sprite.imgPath = "res/characters/detective_small.png"
VicHatshade_Sprite.spriteImg = love.graphics.newImage(VicHatshade_Sprite.imgPath)
VicHatshade_Sprite.spritename = "VicHatshade"

local VicHatshade_Character = Character()
VicHatshade_Character.charsprite = VicHatshade_Sprite
VicHatshade_Character.designation = "Detective"
VicHatshade_Character.firstName = "Hatshade"
VicHatshade_Character.lastName = "Vic"

local cop_Sprite = CharSprite()
cop_Sprite.age = 45
cop_Sprite.imgPath = "res/characters/cop.png"
cop_Sprite.spriteImg = love.graphics.newImage(cop_Sprite.imgPath)
cop_Sprite.spritename = "BobbySmith"

local cop_Character = Character()
cop_Character.charsprite = cop_Sprite
cop_Character.designation = "Mr."
cop_Character.firstName = "Bobby"
cop_Character.lastName = "Smith"
--*******************
--    BACKGROUND
--*******************

local imgFolder = "res/scenes/outside_snow/"
dialog.spriteImg = love.graphics.newImage(imgFolder .. "decor1b.png")


--*******************
--  TEXT & CHARACTER
--*******************
-- the textes and the character name are defined by in a DialogBit
dialog.dialogBits = {
    DialogBit(0, nil, "\n7:56 AM\nEntrance of Vic Hatshade's Office", 5, "center", "none"),
    DialogBit(1, nil, "Jim Norrington :\nIt's my first day as the assistant of the famous detective Vic Hatshade!\nI wonder what will be my first case...", 20),
    DialogBit(1, nil, "[function:HARDSLAPSCREEN]", 5, nil, nil, true),
    DialogBit(2, nil, "Voice :\nThis administrative bullshit is the reason why I will never join your faggot unit!", 30),
    DialogBit(1, nil, "Woman :\nWell, I'm sorry detective but we like to treat our cases the proper way.", 20),
    DialogBit(1, nil, "Woman :\nYou helped us a lot, of course, but we need that report.", 20),
    DialogBit(2, nil, "Detective:\n*hic* yeah yeah, I will send you your fuck*hic* report.[function:WAIT(1)][function:SLAPSCREEN][function:TEXTSPEED(5)] Now you go.", 40),
    DialogBit(1, nil, "A police officer just passed me by... wow, she looked pissed.", 20),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nOh hey buddy. Can I help you?", 15),
    DialogBit(1, VicHatshade_Character, "Jim Norrington:\nH...hi! It's me!", 15),
    DialogBit(2, VicHatshade_Character, ".....", 1),
    DialogBit(1, VicHatshade_Character, "Jim Norrington:\nJ...Jim ! Jim Norrington!", 15),
    DialogBit(2, VicHatshade_Character, ".....", 1),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nThe intern?", 15),
    DialogBit(1, VicHatshade_Character, "Jim Norrington:\nYes! Well, more like assistant, for what I recall from our previous...", 15),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nOh yeah, that's right, I needed someone for the previous case...", 15),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nWell, the police just asked me to drop the case, so I don't really need one anymore. Thanks anyways, buddy.", 15),
    DialogBit(1, VicHatshade_Character, "Jim Norrington:\nMister! We established during my interview that I had the faculties to...", 15),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nHey, Bobby!", 30),
    DialogBit(2, VicHatshade_Character, "???", 5),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nThis boy wants to assists me or something!", 15),
    DialogBit(1, cop_Character, "Bobby:\nGive him a chance, Hatshade! Maybe he can at least help you with this alcohol problem of yours.", 15),
    DialogBit(2, VicHatshade_Character, "Vic Shade:\nHmmf... You know what? Okay. Let's try something. Come in.", 30)
}


return dialog
