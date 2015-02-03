require "dialog"
require "character"


local dialog = Dialog()

--*******************
--       Sprites
--*******************

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

local imgFolder = "res/scenes/inside_bar/"
dialog.spriteImg = love.graphics.newImage(imgFolder .. "bar01.png")

--*******************
--  TEXT & CHARACTER
--*******************
-- the textes and the character name are defined by in a DialogBit
dialog.dialogBits = {
    DialogBit(0, nil, "\n11:35 PM\nIn some bar.[function:WAIT(2)][function:TEXTSPEED(50)] We picked film noir remember.[function:WAIT(1)][function:TEXTSPEED(30)]\nSo obviously our main character is a drunkar.", 5, "center"),
    DialogBit(0, nil, "\nThe gameplay itself isn't very deep so far, so instead we thought 'let's show them our dialog system, wow, much interest, very original, such good job guys'.", 30, "center"),
    DialogBit(2, nil, "[function:WAIT(2)]Detective:\nBarman... Another round.", 20, "left", "barAmbiance"),
    DialogBit(1, nil, "Barman:\nWe will be closing soon. You should go home now.", 20, "left"),
    DialogBit(2, nil, "Detective:\nOne last round, man. And off I go.", 20, "left"),
    DialogBit(2, nil, "Detective:\nI can't really afford more anyways...", 20, "left"),
    DialogBit(1, nil, "[function:SLAPSCREEN]Familiar voice:\nHey, come on detective, this is no time for alcoholic coma", 35, "left"),
    DialogBit(2, cop_Character, "[function:WAIT(1)]Detective:\nHmmf, Smith, you here...", 10, "left"),
    DialogBit(1, cop_Character, "Bobby Smith:\nI thought I'd keep an eye on you.", 35, "left"),
    DialogBit(1, cop_Character, "Bobby Smith:\nYou should go home, the case won't work on itself.", 35, "left"),
    DialogBit(2, cop_Character, "Detective:\nBobby, Bobby, sweet little Bobby", 10, "left"),
    DialogBit(2, cop_Character, "[function:HARDSLAPSCREEN]Detective:\nThey dropped the case! I'm done. We will never find the bastard who... who...", 50, "left"),
    DialogBit(1, cop_Character, "Bobby Smith:\nCalm down, Detective. We will figure that out. Tomorrow is another day", 35, "left")
    
}


return dialog
