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

class MatchTimer extends Timer
    new:()=>
        super()
        @matchstate1 = love.graphics.newImage("res/ui/edited/match1.png")
        @matchstate2 = love.graphics.newImage("res/ui/edited/match22.png")
        @matchstate3 = love.graphics.newImage("res/ui/edited/match3.png")
        
        @fireanim = {
            love.graphics.newImage("res/ui/edited/centerfire.png")
            love.graphics.newImage("res/ui/edited/leftfire.png")
            love.graphics.newImage("res/ui/edited/rightfire.png")
        }
        
        @currentanimindex = 1
        
        -- animation speed : 
        @fireanimspeed = 30
        
    update:(dt) =>
        super(dt)
        if @currentanimindex == #@fireanim
            @currentanimindex = 1
        else
            @currentanimindex += 1
        
    draw: (posx, posy, scale) =>
        if @started or @fadeOut
        
        
            desired_width = wScr() * 0.05
            scale = desired_width / @matchstate1\getWidth()
            
            ratio = @elapsedTime / @duration
            -- ratio = 0
            img_width = @matchstate1\getWidth()-- * scale
            img_height = @matchstate1\getHeight()-- * scale
            
            fire_height = @fireanim[1]\getHeight()
            fire_center_y = 20
            max_y_fire = img_height - fire_height - fire_center_y
            
            
            love.graphics.translate(posx - (img_width* scale), posy)
            love.graphics.scale(scale)
            love.graphics.setColor(255, 255, 255, @fadinglvl)
            
            if not @fadeOut
            
                a = @matchstate1\getWidth()
                b = @matchstate1\getHeight()
                quadTop = love.graphics.newQuad(0, 0, a, max_y_fire * ratio + fire_height - fire_center_y, a, b)
                quadBottom = love.graphics.newQuad(0, max_y_fire * ratio + fire_height - fire_center_y, a, b, a, b)
                
                -- love.graphics.draw(@matchstate1, 0, 0)
                love.graphics.draw(@matchstate2, quadTop, 0, 0)
                love.graphics.draw(@matchstate1, quadBottom, 0, max_y_fire * ratio + fire_height - fire_center_y)
            else
                love.graphics.draw(@matchstate3, 0, 0)
            
            love.graphics.draw(@fireanim[@currentanimindex], 0, max_y_fire * ratio)
            -- if(ratio <= 0.5)
                -- love.graphics.draw(@matchstate1, 0, 0)
                -- love.graphics.draw(@fireanim[@currentanimindex], 0, 0)
            -- else if (ratio <= 0.8)
                -- love.graphics.draw(@matchstate2, 0, 0)
                -- love.graphics.draw(@fireanim[@currentanimindex], 0, img_height * 0.5)
            -- else
                -- love.graphics.draw(@matchstate3, 0, 0)
                -- love.graphics.draw(@fireanim[@currentanimindex], 0, img_height * 0.99)
                
            
            
            love.graphics.reset()
            

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
