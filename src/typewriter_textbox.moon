export ^

class TypewriterTextBox
    new: () =>
        @text = ""
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 36
        @autoText = ""  -- text here will be automatically added to @text
        @autoTypeSpeed = 10  -- letter / s
        @autoTypeSpeedup = if not DEBUG then 3 else 10
        assert(@autoTypeSpeed > 0)
        @autoTypeCounter = 0
        @mute = false

    addLetter: (c) =>
        @text ..= c
        if not @mute
            soundmanager\playAnyType()
        -- @@playType()

    pullback: () =>
        @text ..= "\n> "
        if not @mute
            soundmanager\playAnyPullBack()
        -- @@playPullBack()

    removeLetter: =>
        if #@text > 0
            @text = @text\sub(0, -2)

    draw: (w, h) =>
        love.graphics.setFont(@font)
        lineWidth, linesTable = @font\getWrap(@text .. ' ', w)
        textHeight = @font\getHeight() * #linesTable
        love.graphics.setColor(150, 150, 150)
        love.graphics.printf(@text, 0, h - textHeight, w, "left")

    update: (dt) =>
        if #@autoText > 0
            wordFrequency = 1 / @autoTypeSpeed
            @autoTypeCounter += dt
            while @autoTypeCounter > wordFrequency
                @autoTypeCounter -= wordFrequency
                letter = @autoText\sub(1,1)
                @autoText = @autoText\sub(2, -1)
                if letter == "\n"
                    @pullback()
                else
                    @addLetter(letter)
        else
            @autoTypeCounter = 0

    keypressed: (key) =>
        switch key
            when "backspace"
                if #@autoText == 0
                    @removeLetter()
                    if not @mute
                        soundmanager\playAnyType()
                    -- @@playType()
            when "return"
                if #@autoText == 0
                    @pullback()
                else
                    @autoTypeSpeed *= @autoTypeSpeedup

    keyreleased: (key) =>
        switch key
            when "return"
                @autoTypeSpeed /= @autoTypeSpeedup

    textinput: (char) =>
        if #@autoText == 0
            @addLetter(char)
