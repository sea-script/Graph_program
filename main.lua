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
    --dimensions, global
    width, height = love.graphics.getDimensions()
    current_scn.load()
end

function love.update(dt)
    --mouse position, global
    mouse_x, mouse_y = love.mouse.getPosition()
    current_scn.update(dt)

    --return to the menu
    if(love.keyboard.isDown("escape")) then
        current_scn = menu
        current_scn.load()
    end
end

function love.mousepressed(x,y,mouseID)
    current_scn.mousepressed(mouse_x,mouse_y,mouseID)
end

function love.draw()
    current_scn.draw()
end