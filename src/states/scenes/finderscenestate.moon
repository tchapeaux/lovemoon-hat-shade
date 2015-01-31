export ^

require "states/scenes/scenestate"
require "timer"
require "states/transitions/fadetoblack"

class FinderSceneState extends SceneState
    new: (scene, fulltext, @clues_to_find, @startIndices, @stopIndices) =>
        super(scene)
        @timer = CigTimer() -- should be another?
        @textBox.autoText = fulltext
        @clueToFind = 1 -- index of @clues_to_find
        @clueAtPointer = nil -- name of the clue
        @clueSelected = nil -- name of the clue

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
                duration = @textBox.autoTypeSpeed * (@stopIndices[@clueToFind] - @startIndices[@clueToFind])
                @timer\start(duration)
            elseif @timer.started and #@textBox.text >= @stopIndices[@clueToFind]
                -- stop timer
                if @clues_to_find[@clueToFind] ~= @clueSelected
                    @lost_clue()
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

    lost_clue: =>
        print "there, there."

    draw_clue_layer: =>
        super()
        if @clueAtPointer
            love.graphics.draw(@scene.clues[@clueAtPointer].highlightImg, 0, 0)

    mousepressed: (x, y, button) =>
        switch button
            when "l"
                print @clueAtPointer
                @clueSelected = @clueAtPointer
