export ^

class Clue
    new: =>
        @highlightImg = nil
        @hitBox = {} -- list of polygon vertices
        @name = nil
        @isHighlighted = false

    draw: =>
        if @isHighlighted
            love.graphics.draw(@highlightImg, 0, 0)
