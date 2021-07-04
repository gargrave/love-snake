local Vector = {
    x = 0,
    y = 0
}
Vector.__index = Vector

function Vector.new(x, y)
    local new = setmetatable({}, Vector)
    new:init(x, y)
    return new
end

function Vector:init(x, y)
    self.x = x
    self.y = y
end

function Vector:update()
end

function Vector:draw()
end

function Vector.__add(a, b)
    return Vector.new(a.x + b.x, a.y + b.y)
end

function Vector.__mul(a, mult)
    return Vector.new(a.x * mult, a.y * mult)
end

return Vector
