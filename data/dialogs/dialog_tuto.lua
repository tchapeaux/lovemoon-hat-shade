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

local imgFolder = "res/scenes/inside_bike/"
dialog.spriteImg = love.graphics.newImage(imgFolder .. "bikeroom_black.png")

--*******************
--  TEXT & CHARACTER
--*******************
-- the textes and the character name are defined by in a DialogBit
dialog.dialogBits = {
    DialogBit(1, nil, "[function:WAIT]", 0, "left", "quietPlace"),
    DialogBit(1, nil, "Jim:\nWow. What a mess.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nYeah... Well I kind of planned on cleaning that. And kind of gave up.", 20, "left"),
    DialogBit(1, VicHatshade_Character, "Jim:\nI see... What are we doing here anyways?", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nThat's your training place, champion.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nSome kind of... tutorial, if I may.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nSo here is how it works. It's a two players job. First one will look around and take notes. He will see some items highlighted, and he will have to describe them.", 20, "left"),
    DialogBit(1, VicHatshade_Character, "Jim:\nAnd in the meantime, what is the player 2 doing?", 20, "left"),
    DialogBit(0, VicHatshade_Character, "[function:SLAPSCREEN]", 0),
    DialogBit(2, VicHatshade_Character, "Detective:\nNOTHING! He leaves the room, he goes watch Game of Thrones or something.", 20, "left"),
    DialogBit(1, VicHatshade_Character, "Jim:\nWhat's that?", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nAn anachronism. But focus now.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nWhen player 1 is done with describing the scene, player 2 comes in. He has to click on the items the player 1 described.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nThe timer system is simple : the more the player 1 wrote about the item, the more time the player 2 will get.", 20, "left"),
    DialogBit(2, VicHatshade_Character, "Detective:\nOkay, so now player 2, leave me alone. I need to describe this scene...", 20, "left")
    
    
}


return dialog
