require "character"

local csprite = new CharSprite()
csprite.age = 28
csprite.sex = 1
csprite.imgPath = "res/characters/cop.png"
csprite.spriteImg = love.graphics.newImage(csprite.imgPath)
csprite.spritename = "COP"

return csprite