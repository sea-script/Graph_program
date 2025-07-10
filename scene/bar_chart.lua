bar_chart = {}

function bar_chart.load()
    --restart the values
    local margin = 50
    --!!!!!!!!! remeber to update the xaxis var !!!!!!!!!
    --this will be used over all other files
    display = { x = margin, y = margin, width = width - margin * 2, height = height - margin * 2, margin = margin, xaxis_input = 0, yaxis_input = 10 }
    x_step_size = display.width / display.xaxis_input
    y_step_size = display.height / 10
    --or enter the number with the keyboard
    bars = {}

    input_button_x = { x = display.x + display.width + 5, y = display.y + display.height - 10, value = "0", margin = 4 }
    --the var below must be outside bc the button variables are only defined after the line is finished
    input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) + input_button_x.margin
    input_button_x.height = love.graphics.getFont():getHeight() + input_button_x.margin

    --other button
    input_button_y = { x = 20, y = display.y - 10, value = "0", margin = 4 }
    input_button_y.width = love.graphics.getFont():getWidth(input_button_y.value) + input_button_y.margin
    input_button_y.height = love.graphics.getFont():getHeight() + input_button_y.margin

    y_values = {}
    for i = 1, 10 do
        y_values[i] = 0
    end

    x_num_input_mode = false
    y_num_input_mode = false 
end

function bar_chart.update(dt)
    --more accurate changes to the bars
    for i = 1, display.xaxis_input do
        if love.mouse.isDown(1) then
            if (mouse_x >= bars[i].x and mouse_x <= bars[i].x + bars[i].width and mouse_y >= display.y and mouse_y < display.y + display.height) then
                bars[i].y = mouse_y
                bars[i].height = (display.y + display.height) - mouse_y
            end
        end
    end
end

function bar_chart.update_bars()
    x_step_size = display.width / display.xaxis_input
    for i = 1, display.xaxis_input do
        bars[i] = {}                        --delete old value or make a new one
        bars[i].margin = 0.05 * x_step_size --5% of the step size
        bars[i].width = x_step_size - (0.05 * 2 * x_step_size)
        bars[i].height = 1                  --change later
        bars[i].x = display.x + x_step_size * (i - 1) + bars[i].margin
        bars[i].y = display.y + display.height - 1
    end
end

function bar_chart.mousepressed(mouse_x, mouse_y, mouseID)
    --inputing the number of bars
    if mouseID == 1 then
        --first button
        if mouse_x >= input_button_x.x and mouse_x <= input_button_x.x + input_button_x.width and mouse_y >= input_button_x.y and mouse_y <= input_button_x.y + input_button_x.height then
            --enable typing mode, it will show a text saying ti enter a number
            bar_num_input_mode = true
            y_num_input_mode = false
            user_input = ""
        end
        --second one
        if mouse_x >= input_button_y.x and mouse_x <= input_button_y.x + input_button_y.width and mouse_y >= input_button_y.y and mouse_y <= input_button_y.y + input_button_y.height then
            y_num_input_mode = true
            bar_num_input_mode = false
            user_input = ""
        end
    end
end

function bar_chart.keypressed(key)
    --end typing mode
    if key == "return" then
        if bar_num_input_mode and user_input ~= "" then
            bar_num_input_mode = false                                                                            --de-activate input mode
            local num = tonumber(user_input)                                                                      --convert to number
            display.xaxis_input = num                                                                             --store the number on the display var
            input_button_x.value = tostring(num)                                                                  --to print the value
            user_input = ""                                                                                       --empty it
            input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) +
            input_button_x.margin                                                                                 --update the width

            bar_chart.update_bars()                                                                               --update the bars
        elseif y_num_input_mode and user_input ~= "" then
            y_num_input_mode = false
            local num = tonumber(user_input)
            input_button_y.value = user_input
            user_input = ""
            input_button_y.width = love.graphics.getFont():getWidth(input_button_y.value) + input_button_y.margin

            y_values[10] = "0"
            for i = 1, 10 do
                local value = num - ((num / 10) * i)
                local str_value = string.format("%.1f", value)
                y_values[i] = str_value
            end
        end
    end
end

function bar_chart.textinput(t)
    if bar_num_input_mode then
        user_input = user_input .. t
    elseif y_num_input_mode then
        user_input = user_input .. t
    end
end

function display_func()
    --the borders
    love.graphics.setColor(red)
    love.graphics.rectangle("line", display.x, display.x, display.width, display.height)
    --lines
    love.graphics.setColor(blue)
    --always 10 on the y axis(?)
    for i = 1, 10 do
        love.graphics.line(display.margin, (display.height + display.margin) - (display.height / 10) * i,
            display.margin + display.width, (display.height + display.margin) - (display.height / 10) * i)
    end
end

function bar_chart.draw()
    --title?
    love.graphics.print("Bar_Chart", 1, 1)
    display_func()
    --changes according to x axis value/variables
    for i = 1, display.xaxis_input do
        love.graphics.line(display.margin + (display.width / display.xaxis_input) * i, display.margin + display.height,
            display.margin + (display.width / display.xaxis_input) * i, display.margin)
    end

    --bars number input button
    love.graphics.setColor(white)
    love.graphics.rectangle("line", input_button_x.x, input_button_x.y, input_button_x.width, input_button_x.height)
    love.graphics.print(input_button_x.value, input_button_x.x + input_button_x.margin / 2,
        input_button_x.y + input_button_x.margin / 2)
    --other button
    love.graphics.rectangle("line", input_button_y.x, input_button_y.y, input_button_y.width, input_button_y.height)
    love.graphics.print(input_button_y.value, input_button_y.x + input_button_y.margin / 2,
        input_button_y.y + input_button_y.margin / 2)

    --input mode
    if bar_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
    end
    if y_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
    end

    --draw the bars
    for i = 1, display.xaxis_input do
        love.graphics.rectangle("fill", bars[i].x, bars[i].y, bars[i].width, bars[i].height)
    end

    --draw the values
    for i = 1, display.yaxis_input do
        love.graphics.print(y_values[i], 20, display.y + y_step_size * (i) - 10)
    end
end

return bar_chart
