export ^

class DialogBit
    new:(@character, @text, @speed, @align="left") =>

class Dialog
    new:() =>
        @spriteImg = nil -- background scene
        @dialogBits = {}
