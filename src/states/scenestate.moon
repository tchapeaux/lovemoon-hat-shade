export ^

class SceneState extends GameState
    -- TODO: create two child state: PlayerOneSceneState and PlayerTwoSceneState
    new: (scene) =>
        @scene = scene

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)

        scale = math.min(wScr() / @scene.spriteImg\getWidth(), hScr() / @scene.spriteImg\getHeight())
        offset_x = (wScr() / 2) - (@scene.spriteImg\getWidth() / 2) * scale
        offset_y = hScr() - @scene.spriteImg\getHeight() * scale
        love.graphics.draw(@scene.spriteImg, offset_x, offset_y, 0, scale, scale)

    mousepressed: (x, y, button) =>
        -- TODO: handle player 2 clicking on hitboxes or not

    keyreleased: (key) =>
        -- TODO: handle player 1 writing
        switch key
            when "escape"
                love.event.quit()
