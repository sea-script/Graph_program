--this file decides which scene is being displayed
_G.love = require("love")

--load the possible scenes
local menu = require("scene/menu")
local scene1 = require("scene/scene1")

local current_scn = menu

function love.load()
    width, height = love.graphics.getDimensions()
    current_scn.load()
end

function love.update(dt)
    --mouse position  
    mouse_x, mouse_y = love.mouse.getPosition()
    current_scn.update(dt)
end

function love.mousepressed(x,y,ID)
    current_scn.mousepressed(mouse_x,mouse_y,ID)
end

function love.draw()
    current_scn.draw()
end