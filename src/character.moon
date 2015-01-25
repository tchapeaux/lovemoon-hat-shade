-- defines a character with :
-- sprite, sexe, age, name...
-- the charsprite basic info should be in the data folder

class CharSprite
    @@sexenum = {"Man", "Woman"}
    next: () =>
        @age = 30
        @sex = 1
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
        return "#{@designation} #{firstName} #{lastName}"
    
    draw:() =>
        assert @charsprite != null, "Character #{completeName!} : no sprite"
        assert @charsprite.spriteImg != null, "Character : no sprite"
        love.graphics.draw(@charsprite.spriteImg, 0, 0)