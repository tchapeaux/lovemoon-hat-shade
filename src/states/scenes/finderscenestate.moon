export ^

require "states/scenes/scenestate"
require "timer"
require "states/transitions/fadetoblack"
require "states/transitions/fadefrom"

class FinderSceneState extends SceneState
    new: (scene, fulltext, @clues_to_find, @startIndices, @stopIndices) =>
        super(scene)
        -- @timer = CigTimer() -- should be another?
        @timer = MatchTimer()
        -- some changes to makes it simpler
        @textBox.font = love.graphics.newFont "res/font/courier-prime/Courier Prime.ttf", 23
        @textBox.autoText = string.gsub(fulltext, "\n>", "\n")
        @textBox.mute = true
        
        @clueToFind = 1 -- index of @clues_to_find
        @clueAtPointer = nil -- name of the clue
        @clueSelected = nil -- name of the clue
        @cluesFound = {}
        @foundHighlights = {}
        
        @portraitplayer = love.graphics.newImage("res/characters/portraits/assistant.png")
        @helperbox = InGameHelper("Try to find the item described by HatShade.\nClick on it before it's too late!")
        
        -- sanity checks
        assert #@clues_to_find == #@startIndices and #@startIndices == #@stopIndices,
            "invalid parameters: #{#@clues_to_find} - #{#@startIndices} - #{#@stopIndices}"
        for name in *@clues_to_find
            assert @scene.clues[name] ~= nil, "Invalid clue name: #{name}"

    update: (dt) =>
        super(dt)
        if @clueToFind <= #@clues_to_find
            if not @timer.started and #@textBox.text >= @startIndices[@clueToFind]
                -- start timer
                duration = (@stopIndices[@clueToFind] - @startIndices[@clueToFind]) / @textBox.autoTypeSpeed
                @timer\start(duration)
            elseif @timer.started and #@textBox.text >= @stopIndices[@clueToFind]
                -- stop timer
                if @clues_to_find[@clueToFind] == @clueSelected
                    @found_clue(@clues_to_find[@clueToFind])
                else
                    @lost_clue(@clues_to_find[@clueToFind])
                @clueSelected = nil
                @clueToFind += 1
            else
                -- highlight clue under cursor
                scale, offset_x, offset_y = @getOffsetAndScale()
                mx, my = love.mouse.getPosition()
                img_x = math.floor((mx - offset_x) / scale)
                img_y = math.floor((my - offset_y) / scale)
                if (img_x >= 0 and img_y >= 0 and img_x <= @scene.spriteImg\getWidth() and img_y <= @scene.spriteImg\getHeight() )
                    clue = @scene\getClueAt(img_x, img_y)
                    if clue
                        @clueAtPointer = clue.name
                    else
                        @clueAtPointer = nil
                else
                    @clueAtPointer = nil
        else
            statestack\push FadeToBlack(1)

    found_clue: (name) =>
        clue = @scene.clues[name]
        table.insert(@cluesFound, name)
        -- draw the found clue in green
        img = clue.highlightImg
        imgdata = img\getData()
        foundImgData = love.image.newImageData(img\getWidth(), img\getHeight())
        foundImgData\paste(imgdata, 0, 0, 0, 0, img\getWidth(), img\getHeight())
        foundImgData\mapPixel( (x, y, r, g, b, a) -> g, r, b, a )
        table.insert @foundHighlights, love.graphics.newImage(foundImgData)

    lost_clue: (clue) =>
        statestack\push FadeFrom {255, 0, 0}, 0.3

    draw_clue_layer: =>
        super()
        for img in *@foundHighlights
            love.graphics.draw(img, 0, 0)

        if @clueAtPointer
            love.graphics.setColor(255, 255, 255, 100)
            love.graphics.draw(@scene.clues[@clueAtPointer].highlightImg, 0, 0)
            love.graphics.setColor(255, 255, 255, 255)

        if @clueSelected
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(@scene.clues[@clueSelected].highlightImg, 0, 0)

    mousepressed: (x, y, button) =>
        switch button
            when "l"
                @clueSelected = @clueAtPointer
