export ^

-- defines a character with :
-- sprite, sexe, age, name...
-- the charsprite basic info should be in the data folder

class CharSprite
    -- @@sexenum = {MAN => "Man", WOMAN => "Woman"}
    next: () =>
        @age = 30
        -- @sex = @@sexenum.MAN
        @sex = "Man"
        @imgPath = nil
        @spriteImg = nil
        @spritename = "noname"

class Character
    new:() =>
        @fadinglvl = 0
        @hidden = false
    
        @charsprite = nil
        @designation = "Mr."
        @firstName = "No"
        @lastName = "Name"

    
    visible:() =>
        return @fadinglvl > 0
    
    hide:() =>
        @hidden = true

    show:() =>
        @hidden = false
        @fadinglvl = 0

    completeName: () =>
        return "#{@designation} #{@lastName} #{@firstName}"

    update:(dt) =>
        if not @hidden and @fadinglvl < 255
            -- fade in
            @fadinglvl += dt * 300
            if @fadinglvl >= 255
                @fadinglvl = 255
        if @hidden and @visible()
            -- fade out
            @fadinglvl -= dt * 300
            if @fadinglvl <= 0
                @fadinglvl = 0


    draw:(maxHeight) =>
        if not @visible()
            return
        assert @charsprite != null, "Character #{@completeName!} : no sprite"
        assert @charsprite.spriteImg != null, "Character : no sprite"
        scale =  maxHeight / @charsprite.spriteImg\getHeight()

        offset_x = wScr() / 2 - @charsprite.spriteImg\getWidth() * scale / 2
        offset_y = hScr() - @charsprite.spriteImg\getHeight() * scale
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)
        love.graphics.setColor(255, 255, 255, @fadinglvl)
        love.graphics.draw(@charsprite.spriteImg, 0, 0)
        love.graphics.reset()
