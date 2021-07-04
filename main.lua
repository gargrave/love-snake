local Food = require('src.food')
local Globals = require('src.globals')
local Input = require('src.input')
local Player = require('src.player')
local world = require('src.world')

local player = nil
local food = nil

function love.load()
    player = Player.new()
    food = Food.new()

    Globals.player = player
    Globals.food = food
end

function love.focus(focused)
    -- TODO: toggle pause state
end

function love.update(dt)
    player:update(dt)
    -- TODO: update game state if necessary
    Input.lateUpdate(dt)
end

function love.draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()
end
