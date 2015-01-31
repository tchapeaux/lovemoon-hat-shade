require "dialog"

local dialog = Dialog()

--*******************
--       IMAGES
--*******************

local imgFolder = "res/scenes/scene02_se7enGreed/"
dialog.spriteImg = love.graphics.newImage(imgFolder .. "se7en-greed_bw.png")


--*******************
--  TEXT & CHARACTER
--*******************
-- the textes and the character name are defined by in a DialogBit
dialog.dialogBits = {
    DialogBit(nil, "It's my first day as the assistant of the famous detective Vic Hatshade! I wonder what will be my first case..."),
    DialogBit(nil, "Voice :\nThs administrative bullshit is the reason why I didn't sign up as a cop!"),
    DialogBit(nil, "Woman :\nWell, I'm sorry detective but we like to treat our cases the proper way. You helped us a lot, of course, but we need that report."),
    DialogBit(nil, "Detective:\n*hic* yeah yeah, I will send you your fuck*hic* report. Now you go."),
    DialogBit(nil, "A woman just passed me by... wow, she looked pissed."),
    DialogBit("Vic Shade", "Vic Shade:\nOh hey buddy. Can I help you?")
}


return dialog
