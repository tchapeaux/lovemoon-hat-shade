export ^

require "states/scenestate"
require "scenario"

class Game extends GameState
    new: =>
        super()
        @scenario = Scenario.getDefaultScenario()

    update: (dt) =>
        nextScene = @scenario\nextScene()
        if(nextScene) -- nextScene is nil if no more scene
            statestack\push TyperSceneState(nextScene)
            @currentScene = nextScene

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)
        love.graphics.draw(@currentScene.spriteImg, 0, 0)
