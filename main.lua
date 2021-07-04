local Food = require('src.food')
local Input = require('src.input')
local Player = require('src.player')
local world = require('src.world')

local player = nil
local food = nil

function love.load()
    player = Player.new()
    food = Food.new()
end

function love.focus(focused)
    -- TODO: toggle pause state
end

function love.update(dt)
    player:update(dt)
    -- TODO: check collisions
    -- TODO: update game state if necessary
    Input.lateUpdate(dt)
end

function love.draw()
    food:draw()
    player:draw()
    -- TODO: draw all the things
end
