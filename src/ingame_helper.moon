export ^

class InGameHelper

    new:(@text, @maxwidth=100, @align = "left")=>
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 15
        
            
        
    draw:(x, y, scale)=>
        marginbox = 10 * scale
        help_w = @maxwidth * scale + marginbox
        
        lineWidth, numberOfLines = @font\getWrap(@text, help_w)
        textHeight = @font\getHeight() * numberOfLines
    
        love.graphics.translate(x - help_w, y)
        love.graphics.setFont(@font)
        love.graphics.setColor(255, 255, 255)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", 0, 0, help_w + marginbox, textHeight * scale + marginbox*2)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, help_w + marginbox, textHeight * scale + marginbox*2)
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf(@text, marginbox, marginbox, help_w - marginbox, @align)
        love.graphics.reset()


