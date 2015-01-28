export ^

class StateStack
    -- General purpose class to handle multiple state in LOVE games
    new: =>
        @stack = {}

    push: (state) =>
        table.insert @stack, state

    pop: =>
        table.remove @stack

    peek: (offset = 0) =>
        assert offset < #@stack, "offset would result in index < 0"
        @stack[#@stack - offset]

class GameState
    -- Interface-like abstract class for game states to push on a StateStace
    new: =>

    update: (dt) =>

    draw: =>

    keypressed: (key) =>

    keyreleased: (key) =>

    textinput: (char) =>

    mousepressed: (x, y, button) =>

    mousereleased: (x, y, button) =>
