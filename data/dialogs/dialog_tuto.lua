require "dialog"
require "character"
require "states/dialogs/dialogchoice"

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
--  OPTIONS DIALOGS
--*******************

onImAlone = function(state)
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nHmmpf, I was expecting this. Well, maybe you can try it, and if you like it you will find someone. For this demo I doubt you will, but... well", 20))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nLet's pretend you are two people. So you start with the describing thing.", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nYou will only describe 3 of the items in the room, and you have about one minute to describe each of them. Avoid too obvious description. They would be censored anyways. For this first example, we didn't push too much on the censorship, but still.", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nThat's like Pyramid and some point & click at the same time!", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nAt first I will write a lot of stuff, to motivate you, to give you an idea. Then, when nothing else happens, it's your turn! Let's go.", 20, "left"))
    state:nextText()
end
onIFoundSomeone = function(state) 
    table.insert(dialog.dialogBits,DialogBit(2, VicHatshade_Character, "Detective:\nMarvellous! Well, no reason to stop you.", 20))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nOkay, so now player 2, leave us alone. We have a scene to describe...", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "[function:WAIT(5)]Detective:\nHe is gone? I trust you on that. I can't control your webcam to check if you are all alone. Yet.", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nYou will only describe 3 of the items in the room, and you have about one minute to describe each of them. Avoid too obvious description. They would be censored anyways. For this first example, we didn't push too much on the censorship, but still.", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nThat's like Pyramid and some point & click at the same time!", 20, "left"))
    table.insert(dialog.dialogBits, DialogBit(2, VicHatshade_Character, "Detective:\nAt first I will write a lot of stuff, to motivate you, to give you an idea. Then, when nothing else happens, it's your turn! Let's go.", 20, "left"))
    state:nextText()
end

choice = DialogChoice("Are you playing alone?", {"Yup, sorry guys, I can't really play it your way.", "I found someone, give us the real thing."}, {onImAlone, onIFoundSomeone})

--*******************
--  TEXT 
--*******************
-- the textes and the character name are defined by in a DialogBit
dialog.dialogBits = {
    DialogBit(1, nil, "[function:WAIT(1)]", 20, "left", "quietPlace", true),
    DialogBit(1, nil, "[function:WAIT(1)]Jim:\nWow. What a mess.", 20),    
    DialogBit(2, VicHatshade_Character, "Detective:\nYeah... Well I kind of planned on cleaning that. And kind of gave up.", 20),
    DialogBit(1, VicHatshade_Character, "Jim:\nI see... What are we doing here anyways?", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nThat's your training place, champion.", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nSome kind of... tutorial, if I may.", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nSo here is how it works. It's a two players job. First one will look around and take notes. He will see some items highlighted, and he will have to describe them.", 20),
    DialogBit(1, VicHatshade_Character, "Jim:\nAnd in the meantime, what is the player 2 doing?", 20),
    DialogBit(2, VicHatshade_Character, "[function:SLAPSCREEN]Detective:\nNOTHING! He leaves the room, he goes and watches Game of Thrones or something.", 20),
    DialogBit(1, VicHatshade_Character, "Jim:\nWhat's that?", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nAn anachronism. But focus now.", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nWhen player 1 is done with describing the scene, player 2 comes in. He has to click on the items the player 1 described.", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nThe timer system is simple : the more the player 1 wrote about the item, the more time the player 2 will get.", 20),
    DialogBit(2, VicHatshade_Character, "Detective:\nThe question is... Do we have two players here?", 20, "left"),
    choice
}


return dialog
