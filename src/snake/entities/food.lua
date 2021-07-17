local Food = {}
Food.__index = Food
setmetatable(Food, {
    __index = gg.Entity
})

function Food.new()
    local new = setmetatable({}, Food)
    new:init()
    return new
end

function Food:init()
    gg.Entity.init(self)

    self:randomizePosition()

    print(string.format('Food:init() with id: "%s"', self.id))
end

function Food:randomizePosition(player)
    local size, maxX, maxY = sn.Globals.grid:getDimensions()
    local offset = 2

    local newX = love.math.random(maxX)
    local newY = love.math.random(maxY)
    -- TODO: ensure new position does not collide with player
    -- TODO: add a "grow" animation when it moves
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
