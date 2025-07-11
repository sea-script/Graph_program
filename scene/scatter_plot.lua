scatter_plot = {}

function scatter_plot.load()
    input_button_x = { x = display.x + display.width + 5, y = display.y + display.height - 10, value = "0", margin = 4 }
    --the var below must be outside bc the button variables are only defined after the line is finished
    input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) + input_button_x.margin
    input_button_x.height = love.graphics.getFont():getHeight() + input_button_x.margin
    --other button
    input_button_y = { x = 20, y = display.y - 10, value = "0", margin = 4 }
    input_button_y.width = love.graphics.getFont():getWidth(input_button_y.value) + input_button_y.margin
    input_button_y.height = love.graphics.getFont():getHeight() + input_button_y.margin

    --to display the numbers on the axis
    y_values = {}
    for i = 1, 10 do
        y_values[i] = 0
    end
    x_values = {}
    for i = 1, 9 do
        x_values[i] = 0
    end

    y_num_input_mode = false
    x_num_input_mode = false
end

function scatter_plot.update_x_axis()
    x_step_value = tonumber(display.xaxis_input) / 10
    for i = 1, 9 do
        local str_value = string.format("%.1f", (x_step_value * i))
        x_values[i] = str_value
    end
end

function scatter_plot.update(dt)

end

function scatter_plot.mousepressed(mouse_x, mouse_y, mouseID)
    --inputing the number of
    if mouseID == 1 then
        --first button
        if mouse_x >= input_button_x.x and mouse_x <= input_button_x.x + input_button_x.width and mouse_y >= input_button_x.y and mouse_y <= input_button_x.y + input_button_x.height then
            --enable typing mode, it will show a text saying ti enter a number
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

function scatter_plot.keypressed(key)
    --end typing mode
    if key == "return" then
        if x_num_input_mode and user_input ~= "" then
            x_num_input_mode = false                                                                              --de-activate input mode
            local num = tonumber(user_input)                                                                      --convert to number
            display.xaxis_input = num                                                                             --store the number on the display var
            input_button_x.value = tostring(num)                                                                  --to print the value
            user_input =
            ""                                                                                                    --empty it
            input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) +
            input_button_x.margin                                                                                 --update the width
            --update all
            scatter_plot.update_x_axis()
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

function scatter_plot.textinput(t)
    if x_num_input_mode then
        user_input = user_input .. t
    elseif y_num_input_mode then
        user_input = user_input .. t
    end
end

function scatter_plot.draw()
    display_func()
    love.graphics.setColor(blue)
    for i = 1, 9 do
        love.graphics.line(display.x + y_step_size*(i), display.y, display.x + y_step_size*(i), display.y + display.height)
    end
    --title
    love.graphics.setColor(white)
    love.graphics.print("scatter_plot")


    --Y values
    love.graphics.setColor(white)
    love.graphics.rectangle("line", input_button_y.x, input_button_y.y, input_button_y.width, input_button_y.height)
    love.graphics.print(input_button_y.value, input_button_y.x + input_button_y.margin / 2,
        input_button_y.y + input_button_y.margin / 2)

    --the pos is handeled in the draw func
    for i = 1, display.yaxis_input do
        love.graphics.print(y_values[i], 20, display.y + y_step_size * (i) - 10)
    end

    --x number input button
    love.graphics.rectangle("line", input_button_x.x, input_button_x.y, input_button_x.width, input_button_x.height)
    love.graphics.print(input_button_x.value, input_button_x.x + input_button_x.margin / 2,
        input_button_x.y + input_button_x.margin / 2)

    --X values
    displaying_usr_input()

    --Y values
    for i = 1, 9 do
        love.graphics.print(x_values[i], (y_step_size * (i+1)) - 20 , display.y+display.height + 5)
    end
end

return scatter_plot
