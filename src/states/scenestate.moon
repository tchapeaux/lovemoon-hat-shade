export ^

class SceneState extends GameState
    -- TODO: create two child state: PlayerOneSceneState and PlayerTwoSceneState
    new: (scene) =>
        @scene = scene

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.draw(@scene.spriteImg, 0, 0)

    mousepressed: (x, y, button) =>
        -- TODO: handle player 2 clicking on hitboxes or not

    keyreleased: (key) =>
        -- TODO: handle player 1 writing
        switch key
            when "escape"
                love.event.quit()
