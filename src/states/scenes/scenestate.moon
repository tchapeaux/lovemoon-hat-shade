export ^

require "ingame_helper"
require "typewriter_textbox"
require "timer"

class SceneState extends GameState
    new: (scene) =>
        @scene = scene
        @textBox = TypewriterTextBox()
        @timer = Timer()
        @helperbox = nil
        @portraitplayer = nil
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

        -- portrait picture
        -- the portrait is a square, so we try to define the max height available and scale the portrait
        max_height_textbox = hScr() - @scene.spriteImg\getHeight() * scale
        max_width_textbox = wScr()
        
        if @portraitplayer
            -- get portrait scale according to the actuel height of the picture
            scaleportrait = max_height_textbox / @portraitplayer\getHeight()
            max_width_textbox -= @portraitplayer\getWidth() * scaleportrait
            -- apply scale and draw
            love.graphics.translate(max_width_textbox, 0)
            love.graphics.scale(scaleportrait)
            -- we place it right after the textbox
            love.graphics.draw(@portraitplayer, 0, 0)
            love.graphics.reset()
        
        
        -- draw text box
        @textBox\draw(max_width_textbox, max_height_textbox)

        -- draw timer
        marginxcig = (0.02 * hScr()) + (0.05 * hScr())
        marginycig = hScr() * 0.05
        @timer\draw(offset_x + wScr() - marginxcig, offset_y + marginycig, scale)
        
        
        if(@timer.started and @helperbox)
            @helperbox\draw(offset_x + wScr() - marginxcig*2, offset_y + marginycig)

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
