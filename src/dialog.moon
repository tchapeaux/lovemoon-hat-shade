export ^

class DialogBit
    new:(charName, text) =>
        @characterName = charName
        @text = text
        

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