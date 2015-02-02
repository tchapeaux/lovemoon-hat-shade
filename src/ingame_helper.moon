export ^

class InGameHelper

    new:(@text, @align = "left")=>
        @font = love.graphics.newFont "res/font/special-elite/SpecialElite.ttf", 15
        
            
        
    draw:(x, y)=>           
        -- if options["Help mode"]
        
        -- max width text : % of screen
        textwidth = wScr() * 0.15
        -- marge of the box 
        marginbox = textwidth * 0.05-- * scale
        
        -- box width : twice the marge plus the texte
        box_w = marginbox * 2 + textwidth --* scale
        
        lineWidth, numberOfLines = @font\getWrap(@text, textwidth)
        textHeight = @font\getHeight() * numberOfLines
    
        box_h = marginbox * 2 + textHeight
        
        
        -- draw the rectangle box at given position minus the box width
        love.graphics.translate(x - box_w, y)
        love.graphics.setFont(@font)
        love.graphics.setColor(255, 255, 255)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", 0, 0, box_w, box_h)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, box_w, box_h)
        
        -- print the text at the rectancle position plus margins
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf(@text, marginbox, marginbox, textwidth, @align)
        love.graphics.reset()


