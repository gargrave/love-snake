local Rect = {
    x = 0,
    y = 0,
    w = 0,
    h = 0,
    right = 0,
    bottom = 0
}
Rect.__index = Rect

function Rect.new(x, y, w, h)
    local new = setmetatable({}, Rect)
    new:init(x or 0, y or 0, w or 0, h or 0)
    return new
end

function Rect:init(x, y, w, h)
    self:set(x, y, w, h)
end

function Rect:set(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.right = x + w
    self.bottom = y + h
end

function Rect:overlaps(other)
    if self.x >= other.right or self.right <= other.x then
        return false
    end

    if self.y >= other.bottom or self.bottom <= other.y then
        return false
    end

    return true
end

function Rect:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

return Rect
