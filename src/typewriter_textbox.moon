export ^

class TypewriterTextBox
    new: () =>
        @text = ""
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 18
        @autoText = ""  -- text here will be automatically added to @text
        @autoTypeSpeed = 10  -- letter / s
        @autoTypeSpeedup = if not DEBUG then 3 else 10
        assert(@autoTypeSpeed > 0)
        @autoTypeCounter = 0

    addLetter: (c) =>
        -- TODO: play typewriter sound
        @text ..= c

    removeLetter: =>
        if #@text > 0
            @text = @text\sub(0, -2)

    draw: (w, h) =>
        love.graphics.setFont(@font)
        lineWidth, numberOfLines = @font\getWrap(@text .. ' ', w)
        textHeight = @font\getHeight() * numberOfLines
        love.graphics.setColor(150, 150, 150)
        love.graphics.printf(@text, 0, h - textHeight, w, "left")

    update: (dt) =>
        if #@autoText > 0
            wordFrequency = 1 / @autoTypeSpeed
            @autoTypeCounter += dt
            while @autoTypeCounter > wordFrequency
                @autoTypeCounter -= wordFrequency
                @addLetter(@autoText\sub(1,1))  -- add first letter of autoText to Textbox
                @autoText = @autoText\sub(2, -1) -- remove first letter from autoText
        else
            @autoTypeCounter = 0

    keypressed: (key) =>
        switch key
            when "backspace"
                if #@autoText == 0
                    @removeLetter()
            when "return"
                if #@autoText == 0
                    @addLetter('\n')
                    @addLetter('>')
                    @addLetter(' ')
                else
                    @autoTypeSpeed *= @autoTypeSpeedup

    keyreleased: (key) =>
        switch key
            when "return"
                @autoTypeSpeed /= @autoTypeSpeedup


    textinput: (char) =>
        if #@autoText == 0
            @addLetter(char)
