export ^
require "states/transitions/fadefrom"

class Waiting extends GameState
    new: (@nbsec) =>
        @elapsedTime = 0
        
    previousState: =>
        statestack\peek(1)

    update: (dt) =>
        @elapsedTime += dt
        if @elapsedTime >= @nbsec
            statestack\pop()

    draw: =>
        @previousState()\draw()
