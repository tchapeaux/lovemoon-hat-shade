export ^

require "typewriter_textbox"
require "timer"

class SceneState extends GameState
    -- TODO: create two child state: PlayerOneSceneState and PlayerTwoSceneState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()
        @textBox.autoText = scene.startupAutoText
        @timer = CigTimer()

    update: (dt) =>
        @textBox\update(dt)
        if not @timer.started and #@textBox.autoText == 0 and not @timer.finished 
            @timer\start(10)
        
        if not @timer.finished 
            @timer\update(dt)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        -- draw scene
        -- calculate modifiers
        scale = math.min(wScr() / @scene.spriteImg\getWidth(), hScr() / @scene.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@scene.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @scene.spriteImg\getHeight() * scale
        -- apply modifiers to draw system
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
        
        -- draw timer
        marginxcig = (20 * scale) + (5 * scale)
        marginycig = 5 * scale
        @timer\draw(offset_x + wScr() - marginxcig, offset_y + marginycig, scale)
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
                --love.event.quit()
                statestack\pop!
                statestack\pop!
        -- @textBox\keyreleased(key)
