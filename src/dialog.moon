export ^

class DialogBit
    new:(@character, @text, @speed, @align="left") =>

class Dialog
    new:() =>
        @spriteImg = nil -- background scene
        @dialogBits = {}
        @index = 0

    getNextBit:()=>
        if @index >= #@dialogBits
            return nil
        @index += 1
        return @dialogBits[@index]
