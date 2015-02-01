export ^

require "states/menus/optionsentry"

export options = {}

class OptionsMenu extends GameState
    new: =>
        @fontSize = 36
        @font = love.graphics.newFont("res/font/special-elite/SpecialElite.ttf", @fontSize)
        @bigFont = love.graphics.newFont("res/font/special-elite/SpecialElite.ttf", 100)
        @entries = {
            OptionNumberEntry("Text speed", 5, 10, 3)
            OptionBoolEntry("Help mode", true)
            OptionExitEntry()
        }
        @selected = 1

    draw: =>
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, wScr(), hScr())

        margin = 10
        line_h = @font\getHeight() + margin
        firstLine_y = (hScr() / 2) - (#@entries * line_h) / 2

        -- "Options" title with shadow
        love.graphics.setFont(@bigFont)
        shade_offset = 5
        love.graphics.setColor(255, 255, 255, 100)
        love.graphics.printf("Options", shade_offset, firstLine_y / 2 + shade_offset, wScr(), "center")
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.printf("Options", 0, firstLine_y / 2, wScr(), "center")

        -- entries
        for i = 1, #@entries
            entry = @entries[i]
            love.graphics.setColor(255, 255, 255, if i == @selected then 255 else 100)
            love.graphics.setFont(@font)
            love.graphics.printf(entry.name, 0, firstLine_y + (i - 1) * line_h, wScr() / 2, "center")
            love.graphics.printf(entry\getStringValue(), wScr() / 2, firstLine_y + (i - 1) * line_h, wScr() / 2, "center")

    keypressed: (key) =>
        switch key
            when "up"
                @selected -= 1
                @selected = lua_mod(@selected, #@entries)
            when "down"
                @selected += 1
                @selected = lua_mod(@selected, #@entries)
            when "return"
                @entries[@selected]\action()
            when "escape"
                statestack\pop()

