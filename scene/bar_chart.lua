bar_chart = {}

function bar_chart.load()
    local margin = 50
    display = {x = margin, y = margin, width = width - margin*2, height = height - margin*2, margin = margin}

    --the idea is to a 2 buttons to increase of decrease the max value of every axis
    --or enter the number with the keyboard

    yaxis_input = {}
    yaxis_input.x = margin
    yaxis_input.y = margin-10
    yaxis_input.value = 0
end

function bar_chart.update(dt)
    
end

function bar_chart.mousepressed(mouse_x, mouse_y, mouseID)
    
end

function bar_chart.draw()
    --title
    love.graphics.print("Bar_Chart", 1,1)
    --lines
    love.graphics.setColor(0,0,1)
    for i = 1, 10 do
        love.graphics.line(display.margin, (display.height + display.margin)-(display.height/10)*i, display.margin + display.width, (display.height+display.margin)-(display.height/10)*i)
    end
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",display.x, display.x, display.width, display.height)
    
end

return bar_chart