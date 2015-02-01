export ^
-- plays sounds
class SoundManager
    -- type writter sounds
    @typeSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/type01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type02.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type03.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type04.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/type05.ogg", "static")
    }
    @pullbackSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/pullback01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/pullback02.ogg", "static")
    }
    @bellSounds: {
        love.audio.newSource("res/sfx/typewriter/edited/bell01.ogg", "static")
        love.audio.newSource("res/sfx/typewriter/edited/bell02.ogg", "static")
    }


    -- generic slap sound
    @slapSounds = {
        love.audio.newSource("res/sfx/slap/Slap.ogg", "static")
        love.audio.newSource("res/sfx/slap/door-shut.ogg", "static")
    }

    -- censored word sound
    @bubbleSounds: {
        love.audio.newSource("res/sfx/bubbles/192501__murraysortz__bubbles-quick.ogg", "static")
        love.audio.newSource("res/sfx/bubbles/261597__kwahmah-02__bubbles2.ogg", "static")
        love.audio.newSource("res/sfx/bubbles/104946__glaneur-de-sons__bubble-7.ogg", "static")
    }
    
    @popSounds = {
        love.audio.newSource("res/sfx/dialog/pop.ogg", "static")
        love.audio.newSource("res/sfx/dialog/pop2.ogg", "static")
    }

    @playOneOf: (soundArray) =>
        index = math.random(#soundArray)
        if soundArray[index]\isPlaying()
            soundArray[index]\rewind()
        else
            soundArray[index]\play()
    
    playPop:(index)=>
        -- for pop only : no rewind
        if not @@popSounds[index]\isPlaying()
            @@popSounds[index]\play()

    playSlap:(index)=>
        if @@slapSounds[index]\isPlaying()
            @@slapSounds[index]\rewind()
        else
            @@slapSounds[index]\play()

    playAnyType:()=>
        @@playOneOf(@@typeSounds)
        
        
    playAnyBell:()=>
        @@playOneOf(@@bellSounds)
        
    playAnyPullBack:()=>
        @@playOneOf(@@pullbackSounds)
    
    playAnyBubble:()=>
        @@playOneOf(@@bubbleSounds)