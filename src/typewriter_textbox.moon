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
        @text ..= c
        @@playType()

    pullback: () =>
        @text ..= "\n> "
        @@playPullBack()

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
                    @@playType()
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

    -- the following are class methods and attribute to play sounds

    @playOneOf: (soundArray) =>
        index = math.random(#soundArray)
        soundArray[index]\play()


    @typeSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/type01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type02.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type03.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type04.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type05.ogg", "static")
    }

    @playType: =>
        @playOneOf(@typeSounds)

    @pullbackSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/pullback01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/pullback02.ogg", "static")
    }

    @playPullBack: =>
        @playOneOf(@pullbackSounds)

    @bellSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/bell01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/bell02.ogg", "static")
    }

    @playBell: =>
        @playOneOf(@bellSounds)
