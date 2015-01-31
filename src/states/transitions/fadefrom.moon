export ^

class FadeFrom extends GameState
    new: (@color, @duration, @updatePrevious=false) =>
        @elapsedTime = 0

    previousState: =>
        statestack\peek(1)

    update: (dt) =>
        @elapsedTime += dt
        if @elapsedTime > @duration
            statestack\pop()
        if @updatePrevious
            -- this is dangerous as previousState could trigger another state push
            -- which would cause an invalid state of the statestack
            @previousState()\update(dt)

    draw: =>
        @previousState()\draw()
        love.graphics.reset()
        {r, g, b} = @color
        ratio = math.min(@elapsedTime / @duration, 1)
        alphaValue = math.floor((1 - ratio) * 255)
        love.graphics.setColor(r, g, b, alphaValue)
        love.graphics.rectangle("fill", 0, 0, wScr(), hScr())
