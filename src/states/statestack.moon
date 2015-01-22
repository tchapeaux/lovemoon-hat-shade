export ^

class StateStack
    -- General purpose class to handle multiple state in LOVE games
    new: =>
        @stack = {}

    push: (state) =>
        table.insert @stack, state

    pop: =>
        table.remove @stack

    peek: =>
        @stack[#@stack]

class GameState
    -- Interface-like abstract class for game states to push on a StateStace
    new: =>

    update: (dt) =>

    draw: =>

    keypressed: (key) =>

    keyreleased: (key) =>

    mousepressed: (x, y, button) =>

    mousereleased: (x, y, button) =>
