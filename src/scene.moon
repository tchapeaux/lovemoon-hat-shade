export ^

class Scene
    new: =>
        @spriteImg = nil
        @clues = {}
        @startupAutoText = nil

    setSprite: (path) =>
        @spriteImg = love.graphics.newImage(path)

    addClue: (clue) =>
        assert clue.name != nil, "Attempt to add clue with nil name"
        if @clues[clue.name] == nil
            @clues[clue.name] = clue
        else
            error "Attempt to add clue '#{clue.name}' which already exists"

    getClueAt: (x, y) =>
        for clue in *@clues
            imgdata = @highlightImg\getData()
            r, g, b, a = imgdata\getPixel(x, y)
            if r + g + b + a > 0
                return clue
        return nil
