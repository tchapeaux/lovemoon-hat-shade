export ^

class SoundManager
    new:() =>
        @currentMusic = nil
        @bgm= {}
        -- @bgm.barAmbiance = love.audio.newSource("res/bgm/Jazz_Street_Trio_-_caught_sleeping.ogg", "stream")
        -- @bgm.barAmbiance\setLooping(true)
        @bgm.quietPlace = love.audio.newSource("res/bgm/WwoollfF_-_Saxy_Kenny__WwoollfF__cm_.ogg", "stream")
        @bgm.quietPlace\setLooping(true)
        @bgm.poker  = love.audio.newSource("res/bgm/Jahzzar_-_Poker.ogg", "stream")
        @bgm.poker\setLooping(true)
    -- typewriter sounds
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
    @slapSounds: {
        love.audio.newSource("res/sfx/slap/117347__stereostereo__10-slap-real.ogg", "static")
        love.audio.newSource("res/sfx/slap/73535__macinino__door-slamming_slowed_faded.ogg", "static")
    }

    -- censored word sound
    @bubbleSounds: {
        love.audio.newSource("res/sfx/bubbles/192501__murraysortz__bubbles-quick.ogg", "static")
        love.audio.newSource("res/sfx/bubbles/261597__kwahmah-02__bubbles2.ogg", "static")
        love.audio.newSource("res/sfx/bubbles/104946__glaneur-de-sons__bubble-7.ogg", "static")
    }

    @popSounds: {
        love.audio.newSource("res/sfx/dialog/244654__greenvwbeetle__pop-2.ogg", "static")
        love.audio.newSource("res/sfx/dialog/244654__greenvwbeetle__pop-2_slow.ogg", "static")
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




    
    playMusic:(name)=>
        @stopMusic()
        if @bgm[name]
            @currentMusic=@bgm[name]
            @currentMusic\play()
    
    stopMusic:() =>
        if @currentMusic
            @currentMusic\stop()