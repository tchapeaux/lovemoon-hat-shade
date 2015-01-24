export ^

require "typewriter_textbox"

class SceneState extends GameState
    -- TODO: create two child state: PlayerOneSceneState and PlayerTwoSceneState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()
        @textBox.autoText = scene.startupAutoText

    update: (dt) =>
        @textBox\update(dt)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        -- draw scene sprite
        scale = math.min(wScr() / @scene.spriteImg\getWidth(), hScr() / @scene.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@scene.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @scene.spriteImg\getHeight() * scale
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", offset_x, offset_y, @scene.spriteImg\getWidth() * scale, @scene.spriteImg\getHeight() * scale)
        love.graphics.draw(@scene.spriteImg, offset_x, offset_y, 0, scale, scale)

        -- draw text box
        @textBox\draw(wScr(), hScr() - @scene.spriteImg\getHeight() * scale)

    mousepressed: (x, y, button) =>
        -- TODO: handle player 2 clicking on hitboxes or not

    textinput: (char) =>
        @textBox\textinput(char)

    keypressed: (key) =>
        @textBox\keypressed(key)

    keyreleased: (key) =>
        -- TODO: handle player 1 writing
        switch key
            when "escape"
                love.event.quit()
        @textBox\keyreleased(key)
