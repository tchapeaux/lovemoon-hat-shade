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
        

    @playOneOf: (soundArray) =>
        index = math.random(#soundArray)
        if soundArray[index]\isPlaying()
            soundArray[index]\rewind()
        else
            soundArray[index]\play()
    

    playAnyType:()=>
        @@playOneOf(@@typeSounds)
        
        
    playAnyBell:()=>
        @@playOneOf(@bellSounds)
        
    playAnyPullBack:()=>
        @@playOneOf(@pullbackSounds)