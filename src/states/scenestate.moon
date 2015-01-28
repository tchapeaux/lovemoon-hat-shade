export ^

require "typewriter_textbox"
require "timer"
require "states/fadetoblack"

class SceneState extends GameState
    -- TODO: create two child state: PlayerOneSceneState and PlayerTwoSceneState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()
        @timer = CigTimer()

    update: (dt) =>
        @textBox\update(dt)
        @timer\update(dt)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        -- calculate modifiers
        scale = math.min(wScr() / @scene.spriteImg\getWidth(), hScr() / @scene.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@scene.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @scene.spriteImg\getHeight() * scale
        -- apply modifiers to draw system
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)

        -- blank rectangle
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 0, 0, @scene.spriteImg\getWidth(), @scene.spriteImg\getHeight())

        -- clue highlight
        for name, clue in pairs(@scene.clues)
            clue\draw()

        -- scene sprite
        love.graphics.draw(@scene.spriteImg, 0, 0)

        love.graphics.reset()

        -- draw text box
        @textBox\draw(wScr(), hScr() - @scene.spriteImg\getHeight() * scale)

        -- draw timer
        marginxcig = (20 * scale) + (5 * scale)
        marginycig = 5 * scale
        @timer\draw(offset_x + wScr() - marginxcig, offset_y + marginycig, scale)

    mousepressed: (x, y, button) =>
        -- TODO: handle player 2 clicking on hitboxes or not

    textinput: (char) =>
        @textBox\textinput(char)

    keypressed: (key) =>
        @textBox\keypressed(key)
        -- temporary clue highlighting detection (for DEBUG)
        if DEBUG
            for name, clue in pairs(@scene.clues)
                if string.find(@textBox.text, name) != nil
                    clue.isHighlighted = true

    keyreleased: (key) =>
        -- TODO: handle player 1 writing
        switch key
            when "escape"
                statestack\push FadeToBlack(1) -- TODO replace this with menu
        -- @textBox\keyreleased(key)

class FinderSceneState extends SceneState
    new: (scene, fulltext, clues_to_find) =>
        super(scene)
        @textBox.autoText = fulltext
        @clues_to_find = clues_to_find -- contains timing info?

    update: (dt) =>
        super(dt)

    draw: =>
        super()

class TyperSceneState extends SceneState
    new: (scene) =>
        super(scene)
        @textBox.autoText = scene.startupAutoText
        @highlighted_clues = {}
        @highlighted_textLength = {} -- length at which corresponding clue was highlighted
        @currentHighlight = 0 -- index of @highlighted_clues or 0
        @highlightTime = if DEBUG then 5 else 60 -- number of seconds a clue stays highlighted

        @numberOfClues = 3
        -- pick highlighted items
        cluesCopy = {}
        for name, clue in pairs(@scene.clues)
            table.insert cluesCopy, name
        assert #cluesCopy > @numberOfClues, "Need at least #{@numberOfClues} clues"
        for i=1,@numberOfClues
            index = math.random(#cluesCopy)
            table.insert(@highlighted_clues, table.remove(cluesCopy, index))

    update: (dt) =>
        super(dt)
        if not @timer.started
            assert @currentHighlight >= 0 and @currentHighlight <= #@highlighted_clues, "Invalid @currentHighlight state #{@currentHighlight}"

            if @currentHighlight == #@highlighted_clues
                statestack\push FadeToBlack(1)

            if @currentHighlight > 0
                currentClue = @scene.clues[@highlighted_clues[@currentHighlight]]
                if currentClue.isHighlighted
                    currentClue.isHighlighted = false

            if @next_clue_conditions()
                @currentHighlight += 1
                clueName = @highlighted_clues[@currentHighlight]
                @timer\start(@highlightTime)
                @scene.clues[clueName].isHighlighted = true
                @highlighted_textLength[@currentHighlight] = #@textBox.text

    next_clue_conditions: () =>
        -- return the next clue if the condition is met, nil otherwise
        lastTextLength = 0
        if @currentHighlight > 0
            lastTextLength = @highlighted_textLength[@currentHighlight]
        textSinceLastClue = @textBox.text\sub(lastTextLength + 1)

        textLengthSinceLastClue = #textSinceLastClue
        paragraphCountSinceLastClue = 0
        for match in textSinceLastClue\gmatch("\n")
            paragraphCountSinceLastClue += 1
        sentenceCountSinceLastClue = 0
        for match in textSinceLastClue\gmatch("%.")
            sentenceCountSinceLastClue += 1

        textLengthLimit = 200
        paragraphCountLimit = 3
        sentenceCountLimit = 5

        -- print textLengthSinceLastClue, paragraphCountSinceLastClue, sentenceCountSinceLastClue

        return textLengthSinceLastClue > textLengthLimit or paragraphCountSinceLastClue > paragraphCountLimit or sentenceCountSinceLastClue > sentenceCountLimit
