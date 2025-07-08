bar_chart = {}

function bar_chart.load()
    local margin = 50
    --!!!!!!!!! remeber to update the xaxis var !!!!!!!!!
    display = {x = margin, y = margin, width = width - margin*2, height = height - margin*2, margin = margin, xaxis_input = 0, yaxis_input = 10}
    x_step_size = display.width / display.xaxis_input
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

function bar_chart.update_bars()
    x_step_size = display.width / display.xaxis_input
    for i = 1, display.xaxis_input do
        bars[i] = {} --delete old value or make a new one
        bars[i].margin = 0.05 * x_step_size --5% of the step size
        bars[i].width = x_step_size - (0.05 * 2 * x_step_size)
        bars[i].height = 2 --change later
        bars[i].x = display.x + x_step_size*(i-1) + bars[i].margin
        bars[i].y = display.y + display.height
    end
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

    --bars
    for i = 1, display.xaxis_input do
        if mouseID == 1 then
            if(mouse_x >= bars[i].x and mouse_x <= bars[i].x + bars[i].width and mouse_y >= display.y and mouse_y < display.y + display.height) then
                bars[i].y = mouse_y
                bars[i].height = (display.y + display.height) - mouse_y
            end
        end
    end
end

function bar_chart.keypressed(key)
    --end typing mode
    if key == "return" then
        if bar_num_input_mode and user_input ~= "" then
            bar_num_input_mode = false --de-activate input mode 
            local num = tonumber(user_input) --convert to number
            display.xaxis_input = num --store the number on the display var
            input_button.value = tostring(num) --to print the value
            user_input = "" --empty it
            input_button.width = love.graphics.getFont():getWidth(input_button.value) + input_button.margin --update the width

            bar_chart.update_bars() --update the bars
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
    love.graphics.setColor(red)
    love.graphics.rectangle("line",display.x, display.x, display.width, display.height)
    --lines
    love.graphics.setColor(blue)
    --always 10 on the y axis(?)
    for i = 1, 10 do
        love.graphics.line(display.margin, (display.height + display.margin)-(display.height/10)*i, display.margin + display.width, (display.height+display.margin)-(display.height/10)*i)
    end
    --changes according to x axis value/variables
    for i = 1, display.xaxis_input do
        love.graphics.line(display.margin+(display.width/display.xaxis_input)*i, display.margin+display.height, display.margin+(display.width/display.xaxis_input)*i, display.margin)
    end

    --bars number input button
    love.graphics.setColor(white)
    love.graphics.rectangle("line", input_button.x, input_button.y, input_button.width, input_button.height)
    love.graphics.print(input_button.value, input_button.x+input_button.margin/2, input_button.y+input_button.margin/2)

    --input mode
    if bar_num_input_mode then
        love.graphics.print("Enter a number: ", width/2-40, display.margin/2)
        love.graphics.print("Typing: " .. user_input, 80, 200)
    end

    --draw the bars
    for i = 1, display.xaxis_input do
        love.graphics.rectangle("fill", bars[i].x, bars[i].y, bars[i].width, bars[i].height)
    end
    
end

return bar_chart