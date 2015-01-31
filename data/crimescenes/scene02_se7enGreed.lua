require "scene"
require "clue"

local scene = Scene()

--*******************
--       IMAGES
--*******************

local sceneFolder = "res/scenes/scene02_se7enGreed/"
scene.spriteImg = love.graphics.newImage(sceneFolder .. "se7en-greed_bw.png")


--*******************
--       TEXT
--*******************

scene.startupAutoText = [[I never liked the smell of blood on new shoes.
This was clearly the work of a mad man, precise and meticulous. But no one can commit a murder without leaving a trace, and I cannot look at a crime scene long enough without finding a clue.
Looking around the room, I ]]
--scene.startupAutoText = "yolo\n\n\n\n"
--*******************
--       CLUES
--*******************

local clue_balance = Clue()
clue_balance.name = "balance"
clue_balance.highlightImg = love.graphics.newImage(sceneFolder .. "se7en-greed_bw-clue-balance.png")
clue_balance.forbiddenWords = {"balance"}
scene:addClue(clue_balance)

local clue_pile_of_books = Clue()
clue_pile_of_books.name = "pile_of_books"
clue_pile_of_books.highlightImg = love.graphics.newImage(sceneFolder .. "se7en-greed_bw-clue-pile-of-books.png")
scene:addClue(clue_pile_of_books)

local clue_book = Clue()
clue_book.name = "book"
clue_book.highlightImg = love.graphics.newImage(sceneFolder .. "se7en-greed_bw-clue-book.png")
scene:addClue(clue_book)

local clue_greed = Clue()
clue_greed.name = "greed"
clue_greed.highlightImg = love.graphics.newImage(sceneFolder .. "se7en-greed_bw-clue-greed.png")
clue_greed.forbiddenWords = {"greed", "mark", "blood"}
scene:addClue(clue_greed)

return scene
