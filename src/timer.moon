export ^

class CigTimer
    new:() =>
        @started = false
        @finished = false
    
    start:(nbsecs) =>
        @seconds = nbsecs
        @originalTime = love.timer.getTime( )
        @started = true
        @finished = false
        
    update:(dt) =>
        -- TODO : take delta into consideration?
        if @started
            currentTime = love.timer.getTime( )
            @elapsedTime = (currentTime - @originalTime)

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
            cigh = (150 * scale) * (1.0 - percent)
            
            love.graphics.setColor(128, 128, 128)
            step = math.floor(ashesh * 1.5)
            for i = 0, max_cigh - ashesh, step
                love.graphics.rectangle("fill", posx, posy + i, cigw, ashesh)
            -- if percent > 0.7
                -- love.graphics.setColor(255, 0, 0)
            -- else
            love.graphics.setColor(255, 255, 255)
            love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, cigh)
            love.graphics.setColor(255, 0, 0)
            love.graphics.rectangle("fill", posx, max_cigh - cigh + posy, cigw, burningh)
            love.graphics.setColor(50, 50, 50)
            love.graphics.rectangle("fill", posx, max_cigh + posy, cigw, butth)
            
