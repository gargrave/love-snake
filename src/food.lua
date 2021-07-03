local Food = {}
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
end

return Food
