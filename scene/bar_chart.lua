bar_chart = {}

function bar_chart.load()
    local margin = 50
    --!!!!!!!!! remeber to update the xaxis var !!!!!!!!!
    display = {x = margin, y = margin, width = width - margin*2, height = height - margin*2, margin = margin, xaxis_input = 0, yaxis_input = 10}
    x_step_size = display.margin+(display.width/display.xaxis_input)
    --or enter the number with the keyboard
    bars = {}

    input_button = {x = display.x + display.width + 5, y = display.y + display.height - 10, value = "0", margin = 4}
    --must be outside bc the button variables are only defined after the line is finished
    input_button.width = love.graphics.getFont():getWidth(input_button.value) + input_button.margin
    input_button.height = love.graphics.getFont():getHeight() + input_button.margin

    bar_num_input_mode = false
end

function bar_chart.update(dt)
    
end

function bar_chart.mousepressed(mouse_x, mouse_y, mouseID)
    --inputing the number of bars
    if mouseID == 1 then
        if mouse_x >= input_button.x and mouse_x <= input_button.x + input_button.width and mouse_y >= input_button.y and mouse_y <= input_button.y + input_button.height then
            love.graphics.setColor(1,1,1)
            --enable typing mode, it will show a text saying ti enter a number
            bar_num_input_mode = true
        end
    end
end

function bar_chart.keypressed(key)
    --end typing mode
    if key == "return" then
        if bar_num_input_mode and user_input ~= "" then
            bar_num_input_mode = false
            local num = tonumber(user_input)
            display.xaxis_input = num
            input_button.value = tostring(num)
            user_input = "" --empty it
            input_button.width = love.graphics.getFont():getWidth(input_button.value) + input_button.margin --update the width
        end
        
    end
end

function bar_chart.textinput(t)
    if bar_num_input_mode then
        user_input = user_input .. t
    end
end

function bar_chart.draw()
    --title?
    love.graphics.print("Bar_Chart", 1,1)
    --the borders
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line",display.x, display.x, display.width, display.height)
    --lines
    love.graphics.setColor(0,0,1)
    --always 10 on the y axis(?)
    for i = 1, 10 do
        love.graphics.line(display.margin, (display.height + display.margin)-(display.height/10)*i, display.margin + display.width, (display.height+display.margin)-(display.height/10)*i)
    end
    --changes according to x axis value/variables
    for i = 1, display.xaxis_input do
        love.graphics.line(display.margin+(display.width/display.xaxis_input)*i, display.margin+display.height, display.margin+(display.width/display.xaxis_input)*i, display.margin)
    end

    --bars number input button
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("line", input_button.x, input_button.y, input_button.width, input_button.height)
    love.graphics.print(input_button.value, input_button.x+input_button.margin/2, input_button.y+input_button.margin/2)

    --input mode
    if bar_num_input_mode then
        love.graphics.print("Enter a number: ", width/2-40, display.margin/2)
        love.graphics.print("Typing: " .. user_input, 80, 200)
    end
    
end

return bar_chart