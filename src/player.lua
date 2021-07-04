local Vector = require('src.vector')

local Move = {
    Right = Vector.new(1, 0),
    Left = Vector.new(-1, 0),
    Up = Vector.new(0, -1),
    Down = Vector.new(0, 1)
}

local moveIncrement = .25
-- TODO: get this from "grid" settings
local size = 32

local Player = {
    headPos = Vector.new(0, 0),
    lastMove = 0,
    moveDir = Move.Right,
    segments = {}
}
Player.__index = Player

function Player.new()
    local new = setmetatable({}, Player)
    new:init()
    return new
end

function Player:init()
    -- self.segments = {Vector.new(2, 2)}
end

function Player:update(dt)
    -- TODO: watch input for direction changes
    -- TODO: attempt to move in last direction
    self.lastMove = self.lastMove + dt
    while self.lastMove >= moveIncrement do
        self.lastMove = self.lastMove - moveIncrement
        self.headPos = self.headPos + self.moveDir
        -- local head = self.segments[1]
        -- head.x = head.x + 32
    end
end

function Player:draw()
    local head = self.segments[1]
    local drawPos = self.headPos * size
    love.graphics.setColor({0, 1, 0})
    love.graphics.rectangle('fill', drawPos.x, drawPos.y, size, size)
end

return Player
