local Vector = require('src.vector')

-- TODO: get this from "grid" settings
local size = 32

local Food = {
    pos = Vector.new(10, 10)
}
Food.__index = Food

function Food.new()
    local new = setmetatable({}, Food)
    new:init()
    return new
end

function Food:init()
end

function Food:update()
end

function Food:draw()
    local drawPos = self.pos * size
    love.graphics.setColor({.8, 0, 0})
    love.graphics.rectangle('fill', drawPos.x, drawPos.y, size, size)
end

return Food
