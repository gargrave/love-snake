local keys = {}
local prevKeys = {}

local Input = {}
Input.__index = Input

function love.keypressed(key)
    keys[key] = true
end

function love.keyreleased(key)
    keys[key] = false
end

function Input.lateUpdate(dt)
    for key, value in ipairs(keys) do
        prevKeys[key] = true
    end
end

function Input.isHeld(key)
    return keys[key]
end

function Input.wasPressed(key)
    return keys[key] and not prevKeys[key]
end

return Input
