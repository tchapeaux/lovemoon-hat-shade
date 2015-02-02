export ^

class DialogBit
    new:(poptype, char, text, speed) =>
        @character = char
        @text = text
        @speed = speed
        @popType = poptype

    new:(poptype, char, text, speed, align) =>
        @character = char
        @text = text
        @speed = speed
        @align = align
        @popType = poptype

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
