local Food = {}
Food.__index = Food

function Food.new()
    local new = setmetatable({}, Food)
    new:init()
    return new
end

function Food:init()
    self.body = love.physics.newBody(world, x, y, 'static')
    self.shape = love.physics.newRectangleShape(50, 20)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
end

function Food:update()
end

function Food:draw()
end

return Food
