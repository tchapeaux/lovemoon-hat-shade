export ^

class DialogBit

    new:(@popType, @character, @text, @speed, @align="left", @music=nil) =>


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
