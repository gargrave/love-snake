local Rect = require('src.rect')
local Vector = require('src.vector')

-- TODO: get this from "grid" settings
local size, maxX, maxY = 32, 29, 16
local offset = 2

local Food = {
    bounds = Rect.new(),
    pos = Vector.new()
}
Food.__index = Food

function Food.new()
    local new = setmetatable({}, Food)
    new:init()
    return new
end

function Food:init()
    self:randomizePosition()
end

function Food:randomizePosition(player)
    local newX = love.math.random(maxX)
    local newY = love.math.random(maxY)
    self.pos:set(newX, newY)
    self.bounds:set(newX * size + offset, newY * size + offset, size - offset * 2, size - offset * 2)
    -- TODO: ensure new position does not collide with player
end

function Food:onPlayerCollision(player)
    self:randomizePosition(player)
end

function Food:draw()
    local drawPos = self.pos * size
    love.graphics.setColor({.8, 0, 0})
    self.bounds:draw()
end

return Food
