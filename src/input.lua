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
    for key, value in pairs(keys) do
        prevKeys[key] = value
    end
end

-- TODO: allow multiple keys
function Input.isHeld(key)
    return keys[key]
end

-- TODO: allow multiple keys
function Input.wasPressed(key)
    return keys[key] and not prevKeys[key]
end

return Input
