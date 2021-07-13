local Food = {
    bounds = gg.Rect.new(),
    pos = gg.Vector.new()
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
    local size, maxX, maxY = sn.Globals.grid:getDimensions()
    local offset = 2

    local newX = love.math.random(maxX)
    local newY = love.math.random(maxY)
    -- TODO: ensure new position does not collide with player
    self.pos:set(newX, newY)
    self.bounds:set(newX * size + offset, newY * size + offset, size - offset * 2, size - offset * 2)
end

function Food:onPlayerCollision(player)
    self:randomizePosition(player)
end

function Food:draw()
    local drawPos = self.pos * sn.Globals.gridSize
    love.graphics.setColor({.8, 0, 0})
    self.bounds:draw()
end

return Food
