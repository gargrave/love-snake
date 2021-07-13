local Grid = {
    gridSize = 32,
    size = gg.Vector.new(8, 8)
}
Grid.__index = Grid

function Grid.new(gridSize, width, height)
    local new = setmetatable({}, Grid)
    new:init(gridSize, width, height)
    return new
end

function Grid:init(gridSize, width, height)
    self.gridSize = gridsize
    self.size = gg.Vector.new(width, height)
end

function Grid:getDimensions()
    return self.gridSize, self.size.x, self.size.y
end

function Grid:update(dt)
end

function Grid:draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor({.15, .15, .15})

    for i = 1, self.size.x do
        local x = i * self.gridSize
        love.graphics.line(x, 0, x, sh)
    end

    for i = 1, self.size.y do
        local y = i * self.gridSize
        love.graphics.line(0, y, sw, y)
    end
end

return Grid
