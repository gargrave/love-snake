local GameObject = {
    id = nil
}
GameObject.__index = GameObject

function GameObject.new()
    local new = setmetatable({}, GameObject)
    new:init()
    return new
end

function GameObject:init()
    self.id = lume.uuid()
end

function GameObject:destroy()
end

function GameObject:update(dt)
end

function GameObject:draw()
end

return GameObject
