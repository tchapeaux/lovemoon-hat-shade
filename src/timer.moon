export ^

class Timer
    new:() =>
        @started = false
        @fadeOut = false
        @fadinglvl = 0
        @elapsedTime = 0
        @duration = nil

    start:(nbsecs) =>
        @duration = nbsecs
        @elapsedTime = 0
        @started = true
        @fadeOut = false

    update:(dt) =>
        if @started
            @elapsedTime += dt
            if @elapsedTime > @duration
                @fadeOut = true

            fadingspeed = 300
            if not @fadeOut
                -- fade in
                @fadinglvl += dt * fadingspeed
                if @fadinglvl >= 255
                    @fadinglvl = 255
            else
                @fadinglvl -= dt * fadingspeed
                if @fadinglvl <= 0
                    @fadinglvl = 0
                    @fadeOut = false
                    @started = false

    draw: (posx, posy, scale) =>

class CigTimer extends Timer
    draw: (posx, posy, scale) =>
        if @started or @fadeOut
            ratio = @elapsedTime / @duration

            max_cigh = (150 * scale)
            cigw = 20 * scale
            butth = max_cigh * 0.2
            ashesh = 5 * scale
            burningh = max_cigh * 0.03

            -- current height
            cigh = max_cigh * (1.0 - ratio)

            love.graphics.setColor(128, 128, 128, @fadinglvl)
            step = math.floor(ashesh * 1.5)

            -- ashes
            --for i = 0, max_cigh - ashesh, step
            for i = 0, max_cigh - cigh, step
                love.graphics.rectangle("fill", posx, posy + i, cigw, ashesh)

            -- cigarette and burning tip
            if(ratio != 1.0)
                love.graphics.setColor(255, 255, 255, @fadinglvl)
                love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, cigh)
                love.graphics.setColor(255, 0, 0, @fadinglvl)
                love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, burningh)
            -- butt (such comment wow)
            love.graphics.setColor(50, 50, 50, @fadinglvl)
            love.graphics.rectangle("fill", posx, max_cigh + posy, cigw, butth)

