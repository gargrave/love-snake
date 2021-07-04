local Food = require('src.food')
local Player = require('src.player')
local world = require('src.world')

local player = nil

function love.load()
    player = Player.new()
end

function love.focus(focused)
    -- TODO: toggle pause state
end

function love.update(dt)
    player:update(dt)
    -- TODO: update player
    -- TODO: check collisions
    -- TODO: update game state if necessary
    -- TODO: implement lateUpdate (e.g. Input)
end

function love.draw()
    player:draw()
    -- TODO: draw all the things
end
