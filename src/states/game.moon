export ^

require "states/dialogs/dialogstate"
require "states/scenes/typerscenestate"
require "states/scenes/finderscenestate"
require "states/transitions/fadefromblack"
require "scenario"

class Game extends GameState
    new: =>
        super()
        @scenario = Scenario.getDefaultScenario()
        @currentSceneState = nil

    update: (dt) =>
        if @currentSceneState and @currentSceneState.__class == TyperSceneState
            prevScene = @currentSceneState
            text = prevScene.textBox.text
            clues = prevScene.highlighted_clues
            start = prevScene.highlighted_textLengthStart
            stop = prevScene.highlighted_textLengthStop
            @currentSceneState = FinderSceneState(@currentSceneState.scene, text, clues, start, stop)
            statestack\push @currentSceneState
            statestack\push FadeFromBlack(1)
        else
            nextScene = @scenario\nextScene()
            if nextScene -- nextScene is nil if no more scene
                if(nextScene.__class == Dialog)
                    @currentSceneState = DialogState(nextScene)
                else if(nextScene.__class == Scene)
                    @currentSceneState = TyperSceneState(nextScene)
                statestack\push @currentSceneState
                statestack\push FadeFromBlack(1)
            else
                -- no more scene => exit game
                statestack\pop()

    draw: =>
        love.graphics.setBackgroundColor(0, 0, 0)
