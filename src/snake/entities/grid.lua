local alphaTweenConfig = {
    min = .175,
    max = .4,
    delay = .15,
    time = .55
}

local Grid = {
    alpha = alphaTweenConfig.min,
    alphaTween = nil,
    gridSize = 32,
    size = gg.Vector.new(8, 8)
}
Grid.__index = Grid
setmetatable(Grid, {
    __index = gg.GameObject
})

function Grid.new(gridSize, width, height)
    local new = setmetatable({}, Grid)
    new:init(gridSize, width, height)
    return new
end

function Grid:init(gridSize, width, height)
    gg.GameObject.init(self)

    self.gridSize = gridsize
    self.size = gg.Vector.new(width, height)

    gg.Messages.sub(sn.Message.FoodPickedUp, self)

    gg.debug(string.format('Grid:init() with id: "%s"', self.id))
end

function Grid:destroy()
    gg.Messages.unsub(sn.Message.FoodPickedUp, self)
end

function Grid:onMessage(msg)
    if msg == sn.Message.FoodPickedUp then
        self:pulse()
    end
end

function Grid:getDimensions()
    return self.gridSize, self.size.x, self.size.y
end

function Grid:update(dt)
end

function Grid:pulse()
    if self.alphaTween then
        self.alphaTween:stop()
    end

    self.alpha = alphaTweenConfig.max
    self.alphaTween = flux.to(self, alphaTweenConfig.time, {
        alpha = alphaTweenConfig.min
    }):ease('quadin'):delay(alphaTweenConfig.delay)
end

function Grid:draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    love.graphics.setColor(lume.concat(sn.Color.White, {self.alpha}))

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
