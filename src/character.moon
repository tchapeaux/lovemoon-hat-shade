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
    next: () =>
        @charsprite = nil
        @designation = "Mr."
        @firstName = "No"
        @lastName = "Name"

    completeName: () =>
        return "#{@designation} #{@lastName} #{@firstName}"


    draw:(maxHeight) =>
        assert @charsprite != null, "Character #{@completeName!} : no sprite"
        assert @charsprite.spriteImg != null, "Character : no sprite"
        scale =  maxHeight / @charsprite.spriteImg\getHeight()

        offset_x = wScr() / 2 - @charsprite.spriteImg\getWidth() * scale / 2
        offset_y = hScr() - @charsprite.spriteImg\getHeight() * scale
        love.graphics.translate(offset_x, offset_y)
        love.graphics.scale(scale)
        
        
        love.graphics.draw(@charsprite.spriteImg, 0, 0)
