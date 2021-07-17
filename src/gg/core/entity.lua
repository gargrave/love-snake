local GameObject = require('src.gg.core.game-object')

local Rect = require('src.gg.math.rect')
local Vector = require('src.gg.math.vector')

local Entity = {
    active = true,
    dead = false,
    bounds = Rect.new(),
    pos = Vector.new()
}
Entity.__index = Entity
setmetatable(Entity, {
    __index = GameObject
})

function Entity.new()
    local new = setmetatable({}, Entity)
    new:init()
    return new
end

function Entity:init()
    gg.GameObject.init(self)
end

function Entity:destroy()
end

function Entity:update(dt)
end

function Entity:draw()
end

return Entity
