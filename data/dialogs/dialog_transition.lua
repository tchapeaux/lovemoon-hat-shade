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
    DialogBit(2, VicHatshade_Character, "Detective:\nGood. Or maybe not, actually I have no idea, for we don't have a scoring system yet.", 20, "left", "none"),
    DialogBit(2, VicHatshade_Character, "Detective:\nThis game doesn't have any end yet either. 48 hours, it's rough!", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nLet's move to one last crimescene. A more serious one. But after that, it's back to the menu, boys.", 20, "left", "poker")
    --DialogBit(2, VicHatshade_Character, "[function:WAIT]", 20, "left", "poker")
}


return dialog
