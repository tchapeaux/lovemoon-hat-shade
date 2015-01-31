export ^

require "states/scenes/scenestate"
require "timer"

class TyperSceneState extends SceneState
    new: (scene) =>
        super(scene)
        @timer = CigTimer()
        @textBox.autoText = scene.startupAutoText
        @highlighted_clues = {}
        @highlighted_textLengthStart = {} -- length at which corresponding clue was highlighted
        @highlighted_textLengthStop = {} -- length at which corresponding clue was de-highlighted
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
        @timer\update(dt)
        if not @timer.started
            assert @currentHighlight >= 0 and @currentHighlight <= #@highlighted_clues, "Invalid @currentHighlight state #{@currentHighlight} our of #{#@highlighted_clues}"

            if @currentHighlight == #@highlighted_clues
                statestack\push FadeToBlack(1) -- exit afterwards

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

    draw: =>
        super()
        scale, offset_x, offset_y = @getOffsetAndScale()
        -- draw timer
        marginxcig = (20 * scale) + (5 * scale)
        marginycig = 5 * scale
        @timer\draw(offset_x + wScr() - marginxcig, offset_y + marginycig, scale)

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
