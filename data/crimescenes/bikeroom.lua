require "scene"
require "clue"

local scene = Scene()

--*******************
--       IMAGES
--*******************

local sceneFolder = "res/scenes/inside_bike/"
scene.spriteImg = love.graphics.newImage(sceneFolder .. "bikeroom_black.png")


--*******************
--       TEXT
--*******************

scene.startupAutoText = [[This room was the room of a man without order.
This reminded me of ]]

--*******************
--       CLUES
--*******************

local clue

clue = Clue()
clue.name = "books"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_books.png")
clue.forbiddenWords = {"books"}
scene:addClue(clue)

clue = Clue()
clue.name = "bike"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_bike.png")
clue.forbiddenWords = {"bike"}
scene:addClue(clue)

clue = Clue()
clue.name = "cables"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_cables.png")
clue.forbiddenWords = {"cables"}
scene:addClue(clue)

clue = Clue()
clue.name = "coffee"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_coffee.png")
clue.forbiddenWords = {"coffee"}
scene:addClue(clue)

clue = Clue()
clue.name = "france_map"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_france_map.png")
clue.forbiddenWords = {"france", "map"}
scene:addClue(clue)

clue = Clue()
clue.name = "journals"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_journals.png")
clue.forbiddenWords = {"journals"}
scene:addClue(clue)

clue = Clue()
clue.name = "lamp"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_lamp.png")
clue.forbiddenWords = {"lamp"}
scene:addClue(clue)

clue = Clue()
clue.name = "mirror"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_mirror.png")
clue.forbiddenWords = {"mirror"}
scene:addClue(clue)

clue = Clue()
clue.name = "old_mac"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_old_mac.png")
clue.forbiddenWords = {"mac", "computer"}
scene:addClue(clue)

clue = Clue()
clue.name = "painting"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_painting.png")
clue.forbiddenWords = {"painting"}
scene:addClue(clue)

clue = Clue()
clue.name = "trash"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_trash.png")
clue.forbiddenWords = {"trash", "bag"}
scene:addClue(clue)

clue = Clue()
clue.name = "typewriter"
clue.highlightImg = love.graphics.newImage(sceneFolder .. "bikeroom_typewriter.png")
clue.forbiddenWords = {"typewriter"}
scene:addClue(clue)

return scene
