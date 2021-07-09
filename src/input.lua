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

function Input.isHeld(key)
    if type(key) == 'string' then
        return keys[val]
    else
        for _, val in ipairs(key) do
            if keys[val] then
                return true
            end
        end
        return false
    end
end

function Input.wasPressed(key)
    if type(key) == 'string' then
        return keys[key] and not prevKeys[key]
    else
        for _, val in ipairs(key) do
            if keys[val] and not prevKeys[val] then
                return true
            end
        end
        return false
    end
end

return Input
