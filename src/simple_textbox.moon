export ^

class SimpleTextBox

    new: () =>
        @text = ""
        @font = love.graphics.newFont "res/font/courier-prime/Courier Prime.ttf", 23
        @autoText = ""  -- text here will be automatically added to @text
        @autoTypeSpeed = 15  -- letter / s
        @autoTypeSpeedup = if not DEBUG then 3 else 10
        assert(@autoTypeSpeed > 0)
        @autoTypeCounter = 0
        @align = "left"
        @popIndex = 1

    addLetter: (c) =>
        @text ..= c
        if @popIndex == 0
            soundmanager\playAnyType()
        else
            soundmanager\playPop(@popIndex)

    pullback: () =>
        @text ..= "\n"
        --soundmanager\playAnyPullBack()

    draw: (w, h) =>
        love.graphics.setFont(@font)
        lineWidth, numberOfLines = @font\getWrap(@text, w)
        textHeight = @font\getHeight() * numberOfLines
        love.graphics.setColor(150, 150, 150)
        love.graphics.printf(@text, 0, 0, w, @align)

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

    keyreleased: (key) =>
        switch key
            when "return"
                @autoTypeSpeed *= @autoTypeSpeedup

    textinput: (char) =>
        if #@autoText == 0
            @addLetter(char)
