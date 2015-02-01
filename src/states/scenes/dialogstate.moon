export ^

require "simple_textbox"
require "states/menus/ingamemenu"

class DialogState extends GameState
    new: (dialog) =>
        @dialog = dialog
        @textBox = SimpleTextBox()
        @currentindex = 0
        @currentcharacter = nil

    update: (dt) =>
        if(@currentindex == 0)
            @nextText()
        @textBox\update(dt)

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

        @textBox\keyreleased(key)

    -- attempt to get the next dialog, if none exit scene
    nextText:() =>
        nextBit = @dialog\getNextBit()
        if nextBit == nil
            statestack\push FadeToBlack(1)
            return

        @currentindex += 1

        @textBox.text = ""
        @textBox.autoText = nextBit.text
        @textBox.autoTypeSpeed = nextBit.speed
        @currentcharacter = nextBit.character
        @textBox.align = nextBit.align
