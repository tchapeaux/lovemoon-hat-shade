export ^

require "typewriter_textbox"

class DialogState extends GameState
    new: (dialog) =>
        @dialog = dialog
        @textBox = TypewriterTextBox()
        print #@dialog.dialogBits
        @currentTextLenght = #@dialog.dialogBits[1].text
        @textBox.autoText = @dialog.dialogBits[1].text
        @currentindex = 1

    update: (dt) =>
        if #@textBox.autoText == 0
            @currentindex += 1
            @textBox.autoText = "\n" .. @dialog.dialogBits[@currentindex].text
    
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

    getOffsetAndScale: =>
        -- based on scene sprite size
        scale = math.min(wScr() / @dialog.spriteImg\getWidth(), hScr() / @dialog.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@dialog.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @dialog.spriteImg\getHeight() * scale
        return scale, offset_x, offset_y

    textinput: (char) =>
        --@textBox\textinput(char)

    keypressed: (key) =>
        --@textBox\keypressed(key)

    keyreleased: (key) =>
        -- TODO: pass complete dialog
