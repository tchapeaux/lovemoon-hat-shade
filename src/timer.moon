export ^

class CigTimer
    new:() =>
        @started = false
        @finished = false
        @fadinglvl = 0
        @elapsedTime = 0
        @seconds = nil
        @originalTime = nil

    start:(nbsecs) =>
        @seconds = nbsecs
        @originalTime = love.timer.getTime()
        @started = true
        @finished = false

    update:(dt) =>
        -- TODO : take delta into consideration?
        if @started
            currentTime = love.timer.getTime( )
            @elapsedTime = (currentTime - @originalTime)
            fadingspeed = 300
            @fadinglvl += dt * fadingspeed
            if @fadinglvl >= 255
                @fadinglvl = 255
        if @finished
            fadingspeed = 300
            @fadinglvl -= dt * fadingspeed
            if @fadinglvl <= 0
                @fadinglvl = 0
                @finished = false

    draw:(posx, posy, scale) =>
        if @started or @finished
            percent = (@elapsedTime / @seconds)
            if(@finished or percent >= 1.0)
                @started = false
                @finished = true
                percent = 1

            max_cigh = (150 * scale)
            cigw = 20 * scale
            butth = max_cigh * 0.2
            ashesh = 5 * scale
            burningh = max_cigh * 0.03

            -- current height
            cigh = max_cigh * (1.0 - percent)

            love.graphics.setColor(128, 128, 128, @fadinglvl)
            step = math.floor(ashesh * 1.5)

            -- ashes
            --for i = 0, max_cigh - ashesh, step
            for i = 0, max_cigh - cigh, step
                love.graphics.rectangle("fill", posx, posy + i, cigw, ashesh)

            -- cigarette and burning tip
            if(percent != 1.0)
                love.graphics.setColor(255, 255, 255, @fadinglvl)
                love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, cigh)
                love.graphics.setColor(255, 0, 0, @fadinglvl)
                love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, burningh)
            -- butt (such comment wow)
            love.graphics.setColor(50, 50, 50, @fadinglvl)
            love.graphics.rectangle("fill", posx, max_cigh + posy, cigw, butth)

