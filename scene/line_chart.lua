line_chart = {}

function line_chart.load()
    --restart the values
    local margin = 50
    --!!!!!!!!! remeber to update the xaxis var !!!!!!!!!
    --this will be used over all other files
    display = { x = margin, y = margin, width = width - margin * 2, height = height - margin * 2, margin = margin, xaxis_input = 0, yaxis_input = 10 }
    x_step_size = display.width / display.xaxis_input
    y_step_size = display.height / 10
    -- to store the dots pos, they all have a constent x position that only changes according to the x axis num
    dots = {}
    -- +1 bc a line needs 2 points
    for i = 1, display.xaxis_input + 1 do
        dots[i] = { x = display.margin + x_step_size * (i - 1), y = display.y + display.height, width = 4 }
    end

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
end

function line_chart.update(dt)
    --while clicking
    for i = 1, display.xaxis_input + 1 do
        if (love.mouse.isDown(1)) then
            if (mouse_x >= dots[i].x and mouse_x <= dots[i].x + dots[i].width and mouse_y >= display.y and mouse_y <= display.y + display.height) then
                dots[i].y = mouse_y
            end
        end
    end
end

function line_chart.mousepressed(mouse_x, mouse_y, mouseID)
    --inputing
    if mouseID == 1 then
        --first button
        if mouse_x >= input_button_x.x and mouse_x <= input_button_x.x + input_button_x.width and mouse_y >= input_button_x.y and mouse_y <= input_button_x.y + input_button_x.height then
            --enable typing mode, it will show a text saying t enter a number
            x_num_input_mode = true
            y_num_input_mode = false
            user_input = ""
        end
        --second one
        if mouse_x >= input_button_y.x and mouse_x <= input_button_y.x + input_button_y.width and mouse_y >= input_button_y.y and mouse_y <= input_button_y.y + input_button_y.height then
            y_num_input_mode = true
            x_num_input_mode = false
            user_input = ""
        end
    end
end

function line_chart.update_dots()
    --recalcuate everything
    x_step_size = display.width / display.xaxis_input
    dots = {}
    for i = 1, display.xaxis_input + 1 do
        dots[i] = {
            x = display.margin + x_step_size * (i - 1),
            y = display.y + display.height,
            width = 4
        }
    end
end

function line_chart.keypressed(key)
    if key == "return" then
        if x_num_input_mode and user_input ~= "" then
            x_num_input_mode = false                                                                             --de-activate input mode
            local num = tonumber(user_input)                                                                     --convert to number
            display.xaxis_input =
                num                                                                                              --store the number on the display var
            input_button_x.value = tostring(num)                                                                 --to print the value
            user_input = ""                                                                                      --empty it
            input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) +
            input_button_x.margin                                                                                --update the width

            line_chart.update_dots()                                                                             --update dimensions here
        elseif y_num_input_mode and user_input ~= "" then
            --no need to update the dimensions here
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

function line_chart.textinput(t)
    if x_num_input_mode then
        user_input = user_input .. t
    elseif y_num_input_mode then
        user_input = user_input .. t
    end
end

function line_chart.draw()
    --title
    love.graphics.print("line_chart")
    --the display
    display_func()

    love.graphics.setColor(white)
    --dots
    for i = 1, display.xaxis_input + 1 do
        love.graphics.circle("fill", dots[i].x, dots[i].y, dots[i].width)
    end
    --lines
    for i = 1, display.xaxis_input do
        love.graphics.line(dots[i].x, dots[i].y, dots[i + 1].x, dots[i + 1].y)
    end

    --button
    love.graphics.setColor(white)
    love.graphics.rectangle("line", input_button_x.x, input_button_x.y, input_button_x.width, input_button_x.height)
    love.graphics.print(input_button_x.value, input_button_x.x + input_button_x.margin / 2,
        input_button_x.y + input_button_x.margin / 2)
    --other button
    love.graphics.rectangle("line", input_button_y.x, input_button_y.y, input_button_y.width, input_button_y.height)
    love.graphics.print(input_button_y.value, input_button_y.x + input_button_y.margin / 2,
        input_button_y.y + input_button_y.margin / 2)

    --input mode
    if x_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
    end
    if y_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
    end

    --draw the values
    for i = 1, display.yaxis_input do
        love.graphics.print(y_values[i], 20, display.y + y_step_size * (i) - 10)
    end
end

return line_chart
