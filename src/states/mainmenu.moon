export ^

require "states/game"

class MainMenu extends GameState
    new: =>
        @fontBig = love.graphics.newFont "res/font/abril-fatface/AbrilFatface-Regular.otf", 100
        @fontMed = love.graphics.newFont "res/font/abril-fatface/AbrilFatface-Regular.otf", 20
        @title = "Hat Shade"
        @selected = 1
        @text = {
            "Play"
            "Options"
            "Quit"
        }

    update: =>

    draw: =>
        love.graphics.setBackgroundColor 255, 255, 255
        love.graphics.setFont @fontBig
        love.graphics.setColor {0, 0, 0}
        love.graphics.printf @title, 0, hScr! / 8, wScr!, "center"
        love.graphics.setFont @fontMed
        for i, text in ipairs @text
            if i == @selected
                love.graphics.setColor {0, 0, 0}
            else
                love.graphics.setColor {100, 100, 100}
            love.graphics.printf text,
                (i-1) * wScr! / 3, 3 * hScr! / 4 - 25, wScr! / 3, "center"
        love.graphics.setColor {100, 100, 100}
        love.graphics.printf "Press escape to quit",
            0, hScr! - 50, wScr!, "center"
        love.graphics.printf "Use arrows to select mode",
            0, hScr! / 2, wScr!, "center"

    keyreleased: (key) =>
        switch key
            when "right"
                @selected += 1
                @selected = lua_mod @selected, #@text
            when "left"
                @selected -= 1
                @selected = lua_mod @selected, #@text
            when "return"
                @select()
            when "escape"
                love.event.quit()

    select: =>
        switch @selected
            when 1
                statestack\push(Game())
            when 2
                print "TODO -- Options"
            when 3
                love.event.quit()
