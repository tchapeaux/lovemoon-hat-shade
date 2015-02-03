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
        @autopass = false

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
    
    processFunction: (functionCode) =>
        if functionCode == "[function:SLAPSCREEN]"
            statestack\push SlapScreen(1)
        -- else if functionCode == "[function:WAIT]"
            -- statestack\push Waiting(2)
        else if startsWith(functionCode, "[function:WAIT(")
            indexarg = functionCode\sub(string.len("[function:WAIT(") + 1, string.find(functionCode, ")]") - 1)
            statestack\push Waiting(tonumber(indexarg))
        else if functionCode == "[function:HARDSLAPSCREEN]"
            statestack\push SlapScreen(2)
        else if startsWith(functionCode, "[function:TEXTSPEED(")
            indexarg = functionCode\sub(string.len("[function:TEXTSPEED(") + 1, string.find(functionCode, ")]") - 1)
            @autoTypeSpeed = tonumber(indexarg)
    
    update: (dt) =>
        if #@autoText > 0
            wordFrequency = 1 / @autoTypeSpeed
            @autoTypeCounter += dt
            while @autoTypeCounter > wordFrequency
                @autoTypeCounter -= wordFrequency
                letter = @autoText\sub(1,1)
                if letter == "["
                    -- might be a function
                    if startsWith(@autoText, "[function:")
                        -- definitely a function
                        indexend = string.find(@autoText, "]")
                        functionCode = @autoText\sub(1, indexend)
                        @processFunction(functionCode)
                        -- remove the function from the auto text
                        @autoText = @autoText\sub(indexend + 1, -1)
                        return
                    -- else, it was just some bracket, why not
                
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
