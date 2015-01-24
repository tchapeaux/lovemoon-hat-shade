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
