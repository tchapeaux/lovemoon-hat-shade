export ^

require "simple_textbox"
require "states/transitions/slapscreen"
require "states/transitions/waiting"
require "states/menus/ingamemenu"

class DialogState extends GameState
    new: (dialog) =>
        @dialog = dialog
        @textBox = SimpleTextBox()
        @currentindex = 0
        @currentcharacter = nil
        @previouscharacter = nil

    update: (dt) =>
        if(@currentindex == 0)
            @nextText()
            
        -- for fading in and out character
        if(@currentcharacter)
            @currentcharacter\update(dt)
        if(@previouscharacter)
            @previouscharacter\update(dt)
            if not @previouscharacter\visible()
                @previouscharacter = nil
            
        -- check autopass of the current text
        @textBox\update(dt)
        if @textBox.autopass and #@textBox.autoText == 0
            @nextText()

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        scale, offset_x, offset_y = @getOffsetAndScale()
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)

        -- blank rectangle
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 0, 0, @dialog.spriteImg\getWidth(), @dialog.spriteImg\getHeight())

        -- scene sprite
        love.graphics.draw(@dialog.spriteImg, 0, 0)

        love.graphics.reset()

        -- draw text box
        @textBox\draw(wScr(), hScr() - @dialog.spriteImg\getHeight() * scale)

        -- draw  character if exists
        if(@currentcharacter)
            @currentcharacter\draw(@dialog.spriteImg\getHeight() * scale)
        if(@previouscharacter)
            @previouscharacter\draw(@dialog.spriteImg\getHeight() * scale)


    getOffsetAndScale: =>
        -- based on scene sprite size
        scale = math.min(wScr() / @dialog.spriteImg\getWidth(), hScr() / @dialog.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@dialog.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @dialog.spriteImg\getHeight() * scale
        return scale, offset_x, offset_y

    keypressed: (key) =>
        if key == "escape"
            statestack\push(InGameMenu())
        if key == "return"
            if #@textBox.autoText == 0
                @nextText()
                return
        else if key == "escape"
            @currentindex == #@dialog.dialogBits

        @textBox\keyreleased(key)

    -- attempt to get the next dialog, if none exit scene
    nextText:() =>
        if(@currentindex >= #@dialog.dialogBits)
            statestack\push FadeToBlack(1)
            return
        
        @currentindex += 1
        nextBit = @dialog.dialogBits[@currentindex]
        
        print nextBit.__class
        if nextBit.__class == DialogChoice
            nextBit.dialogstate = self
            statestack\push(nextBit)
            return

        @textBox.text = ""
        @textBox.autoText = nextBit.text
        if nextBit.music
            soundmanager\playMusic(nextBit.music)
            
        @previouscharacter = @currentcharacter
        @currentcharacter = nextBit.character
        
        if @currentcharacter != @previouscharacter
            if @previouscharacter
                @previouscharacter\hide() 
            if @currentcharacter
                @currentcharacter\show()
        else
            @previouscharacter = nil
        
        -- check some dialog functions
        -- if @textBox.autoText == "[function:SLAPSCREEN]"
            -- statestack\push SlapScreen(1)
            -- @textBox.autoText = ""
            -- @nextText()
            -- return
        -- if @textBox.autoText == "[function:WAIT]"
            -- statestack\push Waiting(2)
            -- @textBox.autoText = ""
            -- @nextText()
            -- return
        -- if @textBox.autoText == "[function:HARDSLAPSCREEN]"
            -- statestack\push SlapScreen(2)
            -- @textBox.autoText = ""
            -- @nextText()
            -- return
        

        
        @textBox.popIndex = nextBit.popType
        @textBox.autoTypeSpeed = nextBit.speed
        @textBox.autopass = nextBit.autopass
        if(nextBit.align)
            @textBox.align = nextBit.align