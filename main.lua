_G.love = require("love")

--load the possible scenes
--bar chart, line chart, Scatter Plot, area chart
local menu = require("scene.menu")
local bar_chart = require("scene.bar_chart")
local line_chart = require("scene.line_chart")
local scatter_plot = require("scene.scatter_plot")
local area_chart = require("scene.area_chart")

--pointer
current_scn = menu

function love.load()
    --color
    red = { 1, 0, 0 }
    green = { 0, 1, 0 }
    blue = { 0, 0, 1 }
    white = { 1, 1, 1 }
    --dimensions, global
    width, height = love.graphics.getDimensions()
    --input buffer, global
    user_input = ""
    local margin = 50
    --!!!!!!!!! remeber to update the xaxis var !!!!!!!!!
    --this will be used over all other files
    display = { x = margin, y = margin, width = width - margin * 2, height = height - margin * 2, margin = margin, xaxis_input = 0, yaxis_input = 10 }
    x_step_size = display.width / display.xaxis_input
    y_step_size = display.height / 10

    current_scn.load()
end

function displaying_usr_input()
    --input mode
    if x_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
    end
    if y_num_input_mode then
        love.graphics.print("Enter a number: " .. user_input, width / 2 - 40, (3 * display.margin / 2) + display.height)
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

function love.update(dt)
    --mouse position, global
    mouse_x, mouse_y = love.mouse.getPosition()
    current_scn.update(dt)
end

function love.mousepressed(x, y, mouseID)
    current_scn.mousepressed(mouse_x, mouse_y, mouseID)
end

function love.keypressed(key)
    if (key == "escape" and current_scn ~= menu) then
        current_scn = menu
    end
    current_scn.keypressed(key)
end

function love.textinput(t)
    if current_scn.textinput then
        current_scn.textinput(t)
    end
end

function love.draw()
    current_scn.draw()
end
