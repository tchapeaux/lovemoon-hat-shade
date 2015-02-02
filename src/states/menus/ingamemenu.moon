export ^

class InGameMenu extends GameState
    new: =>
        @font = love.graphics.newFont("res/font/special-elite/SpecialElite.ttf", 100)


    draw: =>
        @previousState()\draw()

        love.graphics.reset()

        love.graphics.setColor(0, 0, 0, 220)
        love.graphics.rectangle("fill", 0, 0, wScr(), hScr())

        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(@font)
        love.graphics.printf("PAUSED", 0, hScr() / 4 - @font\getHeight() / 2, wScr(), "center")
        love.graphics.setColor(255, 255, 255, 200)
        love.graphics.printf("Press enter to resume\nPress escape to go back to the menu", 0, hScr() / 2, wScr(), "center")

    previousState: =>
        statestack\peek(1)

    keypressed: (key) =>
        switch key
            when "return"
                statestack\pop()
            when "escape"
                while statestack\peek().__class != MainMenu
                    statestack\pop()
