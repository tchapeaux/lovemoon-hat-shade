export ^

class DialogBit
    new:(char, text, speed) =>
        @character = char
        @text = text
        @speed = speed
        
    new:(char, text, speed, align) =>
        @character = char
        @text = text
        @speed = speed
        @align = align
        
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