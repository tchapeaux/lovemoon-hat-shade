export ^
require "states/transitions/fadefrom"

class SlapScreen extends GameState
    new: (@slapLevel, @updatePrevious=false) =>
        @slapped = false
        
    previousState: =>
        statestack\peek(1)

    update: (dt) =>
        if @updatePrevious
            @previousState()\update(dt)
        if not @slapped
            soundmanager\playSlap(@slapLevel)
                
            statestack\pop()
            -- statestack\push FadeToBlack(10)
            statestack\push FadeFrom({255, 255, 255}, 0.5)
            @slapped = true

    draw: =>
        @previousState()\draw()
