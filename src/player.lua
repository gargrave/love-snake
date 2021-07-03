local Player = {}
Player.__index = Player

function Player.new()
    local new = setmetatable({}, Player)
    new:init()
    return new
end

function Player:init()
end

function Player:update()
end

function Player:draw()
end

return Player
