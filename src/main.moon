io.stdout\setvbuf'no'

export statestack

export wScr, hScr
wScr, hScr = love.window.getWidth, love.window.getHeight

export lua_mod = (x, m) ->
    -- returns a modulo of x usable with 1-based table
    return ((x - 1) % m) + 1

love.load = ->
    require "states/statestack"
    require "states/mainmenu"
    statestack = StateStack()
    statestack\push(MainMenu())

current_state = ->
    statestack\peek()

love.draw = ->
    current_state()\draw()

love.update = (dt) ->
    current_state()\update(dt)

love.keypressed = (key) ->
    current_state()\keypressed(key)

love.keyreleased = (key) ->
    current_state()\keyreleased(key)

love.mousepressed = (x, y, button) ->
    current_state()\mousepressed(x, y, button)

love.mousereleased = (x, y, button) ->
    current_state()\mousereleased(x, y, button)
