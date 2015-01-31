export ^

class Clue
    new: =>
        @highlightImg = nil
        @hitBox = {} -- list of polygon vertices
        @name = nil
        @isHighlighted = false
        @forbiddenWords = {} -- words that can't be used to describe this object

    draw: =>
        if @isHighlighted
            love.graphics.draw(@highlightImg, 0, 0)
