local Rect = require('src.gg.math.rect')
local Vector = require('src.gg.math.vector')

local Entity = {
    bounds = Rect.new(),
    pos = Vector.new()
}
Entity.__index = Entity

function Entity.new()
    local new = setmetatable({}, Entity)
    new:init()
    return new
end

function Entity:init()
end

function Entity:update(dt)
end

function Entity:draw()
end

return Entity
