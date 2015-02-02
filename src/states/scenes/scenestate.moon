export ^

require "ingame_helper"
require "typewriter_textbox"
require "timer"

class SceneState extends GameState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()
        @timer = Timer()
        @helperbox = InGameHelper("Describe the highlithed item.\nHurry, but don't use too precise words!")

    update: (dt) =>
        @textBox\update(dt)
        @timer\update(dt)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        scale, offset_x, offset_y = @getOffsetAndScale()
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)

        -- blank rectangle
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 0, 0, @scene.spriteImg\getWidth(), @scene.spriteImg\getHeight())

        @draw_below() -- for subclasses

        -- clue highlight
        for name, clue in pairs(@scene.clues)
            clue\draw()

        @draw_clue_layer() -- for subclasses

        -- scene sprite
        love.graphics.draw(@scene.spriteImg, 0, 0)

        @draw_sprite_layer() -- for subclasses

        love.graphics.reset()

        -- draw text box
        @textBox\draw(wScr(), hScr() - @scene.spriteImg\getHeight() * scale)

        -- draw timer
        marginxcig = (20 * scale) + (5 * scale)
        marginycig = 5 * scale
        @timer\draw(offset_x + wScr() - marginxcig, offset_y + marginycig, scale)
        
        
        if(@timer.started)
            @helperbox\draw(offset_x + wScr() - marginxcig*2, offset_y + marginycig, scale)

    -- for subclasses
    draw_below: =>
    draw_clue_layer: =>
    draw_sprite_layer: =>

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

    keyreleased: (key) =>
        switch key
            when "escape"
                statestack\push InGameMenu()
