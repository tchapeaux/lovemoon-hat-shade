export ^

require "states/scenestate"

class Game extends GameState
    new: =>
        super()
        @scenes = {}
        @loadData()

    loadData: =>
        -- Load the scenes in the right order
        table.insert(@scenes, require "data/crimescenes/scene01")

    update: (dt) =>
        if #@scenes > 0
            nextScene = table.remove @scenes
            statestack\push SceneState(nextScene)

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.draw(@current_scene.spriteImg, 0, 0)
