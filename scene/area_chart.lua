area_chart = {}

function area_chart.load()
    input_button_x = { x = display.x + display.width + 5, y = display.y + display.height - 10, value = "0", margin = 4 }
    --the var below must be outside bc the button variables are only defined after the line is finished
    input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) + input_button_x.margin
    input_button_x.height = love.graphics.getFont():getHeight() + input_button_x.margin
    --other button
    input_button_y = { x = 20, y = display.y - 10, value = "0", margin = 4 }
    input_button_y.width = love.graphics.getFont():getWidth(input_button_y.value) + input_button_y.margin
    input_button_y.height = love.graphics.getFont():getHeight() + input_button_y.margin

    --the main thing of this file
    areas1 = {}
    areas1[1] = { x = display.x, y = display.y + display.height }
    areas1[2] = { x = display.x + display.width, y = display.y + display.height }

    areas2 = {}
    areas2[1] = { x = display.x, y = display.y + display.height }
    areas2[2] = { x = display.x + display.width, y = display.y + display.height }

    areas3 = {}
    areas3[1] = { x = display.x, y = display.y + display.height }
    areas3[2] = { x = display.x + display.width, y = display.y + display.height }

    --to display the numbers on the axis
    y_values = {}
    for i = 1, 10 do
        y_values[i] = 0
    end
    x_values = {}
    for i = 1, 9 do
        x_values[i] = 0
    end
    --reset all
    y_num_input_mode = false
    x_num_input_mode = false

    mouse_x_display = 0
    mouse_y_display = 0

    display.xaxis_input = 0

    layer1 = { x = display.x + display.width, y = display.y, height = 40, selected = false }
    layer1.margin = 5
    layer1.width = width - layer1.x - 2 * layer1.margin
    layer2 = { x = display.x + display.width, y = display.y + layer1.height + layer1.margin, height = 40, selected = false }
    layer2.margin = 5
    layer2.width = layer1.width
    layer3 = { x = display.x + display.width, y = display.y + (layer2.height + layer2.margin) * 2, height = 40, selected = false }
    layer3.margin = 5
    layer3.width = layer1.width

    layers = { layer1, layer2, layer3 }
end

function area_chart.update(dt)

end

function area_chart.update_x_axis()
    x_step_value = tonumber(display.xaxis_input) / 10
    for i = 1, 9 do
        local str_value = string.format("%.1f", (x_step_value * i))
        x_values[i] = str_value
    end
end

function area_chart.mousepressed(mouse_x, mouse_y, mouseID)
    --HELP ME
    if mouseID == 1 then
        --drawing the area
        if (mouse_x >= display.x and mouse_x <= display.x + display.width and mouse_y >= display.y and mouse_y <= display.y + display.height) then
            if layer1.selected == true then
                for i = 1, #areas1 - 1 do
                    --if x is between 2 points.x
                    if mouse_x > areas1[i].x and mouse_x < areas1[i + 1].x then
                        table.insert(areas1, i + 1, { x = mouse_x, y = mouse_y }) --handles pushing all the elements  ""ILOVE INSERTTTTT!!""
                        break
                    elseif mouse_x == areas1[i].x and mouse_x == areas1[i].x then
                        areas1[i].y = mouse_y
                    end
                end
            elseif layer2.selected == true then
                for i = 1, #areas2 - 1 do
                    --if x is between 2 points.x
                    if mouse_x > areas2[i].x and mouse_x < areas2[i + 1].x then
                        table.insert(areas2, i + 1, { x = mouse_x, y = mouse_y }) --handles pushing all the elements  ""ILOVE INSERTTTTT!!""
                        break
                    elseif mouse_x == areas2[i].x and mouse_x == areas2[i].x then
                        areas2[i].y = mouse_y
                    end
                end
            elseif layer3.selected == true then
                for i = 1, #areas3 - 1 do
                    --if x is between 2 points.x
                    if mouse_x > areas3[i].x and mouse_x < areas3[i + 1].x then
                        table.insert(areas3, i + 1, { x = mouse_x, y = mouse_y }) --handles pushing all the elements  ""ILOVE INSERTTTTT!!""
                        break
                    elseif mouse_x == areas3[i].x and mouse_x == areas3[i].x then
                        areas3[i].y = mouse_y
                    end
                end
            end
        end


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

        --buttons for layers
        for i = 1, #layers do
            if (mouse_x >= layers[i].x and mouse_x <= layers[i].x+layers[i].width and mouse_y >= layers[i].y and mouse_y <= layers[i].y+layers[i].height) then
                for j = 1, #layers do
                    layers[j].selected = false
                end
                layers[i].selected = true
            end
        end
            
    end
end

function area_chart.keypressed(key)
    --end typing mode
    if key == "return" then
        if x_num_input_mode and user_input ~= "" then
            x_num_input_mode = false             --de-activate input mode
            local num = tonumber(user_input)     --convert to number
            display.xaxis_input =
            num                                  --store the number on the display var
            input_button_x.value = tostring(num) --to print the value
            user_input =
            ""                                   --empty it
            input_button_x.width = love.graphics.getFont():getWidth(input_button_x.value) +
                input_button_x.margin            --update the width
            --update all
            area_chart.update_x_axis()
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
        --restart all points
        areas1 = {}
        areas1[1] = { x = display.x, y = display.y + display.height }
        areas1[2] = { x = display.x + display.width, y = display.y + display.height }
    end
end

function area_chart.textinput(t)
    if x_num_input_mode then
        user_input = user_input .. t
    elseif y_num_input_mode then
        user_input = user_input .. t
    end
end

function area_chart.draw()
    display_func()
    love.graphics.setColor(white)
    love.graphics.print("area_chart")


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
        love.graphics.print(x_values[i], (y_step_size * (i + 1)) - 20, display.y + display.height + 5)
    end

    --HELP ME
    if #areas1 >= 3 then
        --must convert to a normal table, with just number
        local points = {}
        for i = 1, #areas1 do
            table.insert(points, areas1[i].x)
            table.insert(points, areas1[i].y)
        end
        love.graphics.setColor(white)
        love.graphics.polygon("line", points)
    end
    if #areas2 >= 3 then
        --must convert to a normal table, with just number
        local points = {}
        for i = 1, #areas2 do
            table.insert(points, areas2[i].x)
            table.insert(points, areas2[i].y)
        end
        love.graphics.setColor(green)
        love.graphics.polygon("line", points)
    end
    if #areas3 >= 3 then
        --must convert to a normal table, with just number
        local points = {}
        for i = 1, #areas3 do
            table.insert(points, areas3[i].x)
            table.insert(points, areas3[i].y)
        end
        love.graphics.setColor(blue)
        love.graphics.polygon("line", points)
    end
    for i = 1, #layers do
        love.graphics.setColor(1 / i, 1 / i, (1 / i) * 2)
        love.graphics.rectangle("fill", layers[i].x, layers[i].y, layers[i].width, layers[i].height)
    end
end

return area_chart

--layers
