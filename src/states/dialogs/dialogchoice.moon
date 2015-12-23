export ^

require "states/menus/ingamemenu"

class DialogChoice extends GameState
    new: (@question, @choicesText, @functionChoices, @currentIndex=1, @dialogstate = nil) =>
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 36

    previousState: =>
        statestack\peek(1)

    update: (dt) =>
        if(@currentindex == 0)
            @nextText()


    draw: =>
        @previousState()\draw()

        question_h = hScr() * 0.2
        each_block_h = hScr() * 0.7 / #@choicesText
        each_block_w = wScr() * 0.7

        global_margin_x = wScr() * 0.15
        global_margin_y = hScr() * 0.01
        global_padding = each_block_h * 0.1

        love.graphics.setFont(@font)
        lineWidth, linesTable = @font\getWrap(@question .. ' ', each_block_w)
        textHeight = @font\getHeight() * #linesTable

        love.graphics.translate(global_margin_x, global_margin_y)
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle("fill", 0, 0, each_block_w, question_h)

        love.graphics.setColor(150, 150, 150)
        love.graphics.printf(@question, global_padding, global_padding, each_block_w - global_padding*2, "center")

        for i=1, #@choicesText
            current_y = global_margin_y * 2 * i + question_h * i
            love.graphics.reset()
            love.graphics.translate(global_margin_x, current_y)
            if @currentIndex == i
                love.graphics.setColor(150, 150, 150)
            else
                love.graphics.setColor(255, 255, 255)
            love.graphics.rectangle("fill", 0, 0, each_block_w, question_h)

            if @currentIndex == i
                love.graphics.setColor(255, 255, 255)
            else
                love.graphics.setColor(150, 150, 150)

            love.graphics.printf(@choicesText[i], global_padding, global_padding, each_block_w - global_padding*2, "center")

    keypressed: (key) =>
        if key == "down"
            @currentIndex = lua_mod(@currentIndex + 1, #@choicesText)
        else if key == "up"
            @currentIndex = lua_mod(@currentIndex - 1, #@choicesText)
        else if key == "escape" or key == "return"
            @select()


    select:()=>
        @functionChoices[@currentIndex](@dialogstate)
        statestack\pop()
