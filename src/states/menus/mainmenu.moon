export ^

require "states/game"
require "states/menus/optionsmenu"
require "states/dialogs/dialogchoice"

class MainMenu extends GameState
    new: =>
        @fontBig = love.graphics.newFont "res/font/abril-fatface/AbrilFatface-Regular.otf", 100
        @fontMed = love.graphics.newFont "res/font/abril-fatface/AbrilFatface-Regular.otf", 40
        @title = "Hat Shade"
        @selected = 1
        @text = {
            "Play"
            "Options"
            "Quit"
        }

    update: =>

    draw: =>
        love.graphics.setBackgroundColor {0, 0, 0}
        love.graphics.setFont @fontBig
        love.graphics.setColor {255, 255, 255}
        love.graphics.printf @title, 0, hScr! / 8 - @fontBig\getHeight()/2, wScr!, "center"
        love.graphics.setFont @fontMed
        for i, text in ipairs @text
            if i == @selected
                love.graphics.setColor {255, 255, 255}
            else
                love.graphics.setColor {100, 100, 100}
            love.graphics.printf text,
                (i-1) * wScr! / 3, 3 * hScr! / 4 - 25, wScr! / 3, "center"
        love.graphics.setColor {100, 100, 100}
        love.graphics.printf "Press escape to quit",
            0, hScr! - 1.5 * @fontMed\getHeight(), wScr!, "center"
        love.graphics.printf "Use arrows to select mode",
            0, hScr! / 2 - 0.5 * @fontMed\getHeight(), wScr!, "center"

    keypressed: (key) =>
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
                statestack\push(OptionsMenu())
            when 3
                onYes = () =>
                    love.event.quit()
                onNo = () =>
                    return
                statestack\push(DialogChoice("Are you sure?", {"Yes", "No"}, {onYes, onNo}, 2))
