export ^

class FadeToBlack extends GameState
    new: (nseconds, @updatePrevious=false) =>
        @duration = nseconds
        @elapsedTime = 0

    previousState: =>
        statestack\peek(1)

    update: (dt) =>
        @elapsedTime += dt
        if @elapsedTime > @duration
            statestack\pop()
            statestack\pop()
        if @updatePrevious
            -- this is dangerous as previousState could trigger another state push
            -- which would cause an invalid state of the statestack
            @previousState()\update(dt)

    draw: =>
        @previousState()\draw()
        love.graphics.reset()
        ratio = math.min(@elapsedTime / @duration, 1) * 255
        love.graphics.setColor(0, 0, 0, ratio)
        love.graphics.rectangle("fill", 0, 0, wScr(), hScr())
