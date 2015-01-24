export ^

class TypewriterTextBox
    new: () =>
        @text = ""
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 18
        @autoText = ""  -- text here will be automatically added to @text
        @autoTypeSpeed = 5  -- letter / s
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
            @autoTypeCounter += dt
            if @autoTypeCounter > (1 / @autoTypeSpeed)
                @autoTypeCounter -= (1 / @autoTypeSpeed)
                @addLetter(@autoText\sub(1,1))
                @autoText = @autoText\sub(2, -1)
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
                    @autoTypeSpeed *= 5

    textinput: (char) =>
        if #@autoText == 0
            @addLetter(char)
