local Vector = {
    x = 0,
    y = 0
}
Vector.__index = Vector

function Vector.new(x, y)
    local new = setmetatable({}, Vector)
    new:init(x or 0, y or 0)
    return new
end

function Vector.clone(other)
    return Vector.new(other.x, other.y)
end

function Vector.zero()
    return Vector.new(0, 0)
end

function Vector.right()
    return Vector.new(1, 0)
end

function Vector.left()
    return Vector.new(-1, 0)
end

function Vector.up()
    return Vector.new(0, -1)
end

function Vector.down()
    return Vector.new(0, 1)
end

function Vector:init(x, y)
    self:set(x, y)
end

function Vector:set(x, y)
    self.x = x
    self.y = y
end

function Vector:add(other)
    self.x = self.x + other.x
    self.y = self.y + other.y
end

function Vector:opposes(other)
    if other.x == 0 and other.y == 0 then
        return false
    end

    local xo, yo = true, true
    if self.x ~= other.x * -1 then
        xo = false
    end
    if self.y ~= other.y * -1 then
        yo = false
    end
    return xo and yo
end

function Vector.__add(a, b)
    return Vector.new(a.x + b.x, a.y + b.y)
end

function Vector.__mul(a, mult)
    return Vector.new(a.x * mult, a.y * mult)
end

function Vector.__eq(a, b)
    return a.x == b.x and a.y == b.y
end

return Vector
