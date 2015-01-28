export ^

require "states/scenestate"
require "states/fadefromblack"
require "scenario"

class Game extends GameState
    new: =>
        super()
        @scenario = Scenario.getDefaultScenario()
        @currentSceneState = nil

    update: (dt) =>
        if @currentSceneState and @currentSceneState.__class == TyperSceneState
            -- TODO: get text and clue info from @currentSceneState
            prevScene = @currentSceneState
            text = prevScene.textBox.text
            clues = prevScene.highlighted_clues
            lengths = prevScene.highlighted_textLengths
            @currentSceneState = FinderSceneState(@currentSceneState.scene, text, clues)
            statestack\push @currentSceneState
            statestack\push FadeFromBlack(1)
        else
            nextScene = @scenario\nextScene()
            if nextScene -- nextScene is nil if no more scene
                @currentSceneState = TyperSceneState(nextScene)
                statestack\push @currentSceneState
                statestack\push FadeFromBlack(1)
            else
                -- no more scene => exit game
                statestack\pop()

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)
