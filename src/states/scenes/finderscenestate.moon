export ^

require "states/scenes/scenestate"

class FinderSceneState extends SceneState
    new: (scene, fulltext, clues_to_find) =>
        super(scene)
        @textBox.autoText = fulltext
        @clues_to_find = clues_to_find -- contains timing info?

    update: (dt) =>
        super(dt)

    draw: =>
        super()
