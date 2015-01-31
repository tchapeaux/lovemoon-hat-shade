export ^

require "typewriter_textbox"
require "states/transitions/fadetoblack"

class SceneState extends GameState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()

    update: (dt) =>
        @textBox\update(dt)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        scale, offset_x, offset_y = @getOffsetAndScale()
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)

        -- blank rectangle
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 0, 0, @scene.spriteImg\getWidth(), @scene.spriteImg\getHeight())

        -- clue highlight
        for name, clue in pairs(@scene.clues)
            clue\draw()

        -- scene sprite
        love.graphics.draw(@scene.spriteImg, 0, 0)

        love.graphics.reset()

        -- draw text box
        @textBox\draw(wScr(), hScr() - @scene.spriteImg\getHeight() * scale)

    getOffsetAndScale: =>
        -- based on scene sprite size
        scale = math.min(wScr() / @scene.spriteImg\getWidth(), hScr() / @scene.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@scene.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @scene.spriteImg\getHeight() * scale
        return scale, offset_x, offset_y

    mousepressed: (x, y, button) =>
        -- TODO: handle player 2 clicking on hitboxes or not

    textinput: (char) =>
        @textBox\textinput(char)

    keypressed: (key) =>
        @textBox\keypressed(key)
        -- temporary clue highlighting detection (for DEBUG)
        if DEBUG
            for name, clue in pairs(@scene.clues)
                if string.find(@textBox.text, name) != nil
                    clue.isHighlighted = true

    keyreleased: (key) =>
        -- TODO: handle player 1 writing
        switch key
            when "escape"
                statestack\push FadeToBlack(1) -- TODO replace this with menu
        -- @textBox\keyreleased(key)

