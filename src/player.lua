local Input = require('src.input')
local Vector = require('src.vector')

local Move = {
    Right = Vector.new(1, 0),
    Left = Vector.new(-1, 0),
    Up = Vector.new(0, -1),
    Down = Vector.new(0, 1)
}

local Colors = {
    Head = {0, 1, 0},
    Tail = {.075, .55, .075}
}

local moveIncrement = .2
-- TODO: get this from "grid" settings
local size = 32

local Player = {
    head = Vector.new(3, 0),
    lastMoveTime = 0,
    lastMoveDir = Move.Right,
    moveDir = Move.Right,
    nextMoveDir = Move.Right,
    segments = {}
}
Player.__index = Player

function Player.new()
    local new = setmetatable({}, Player)
    new:init()
    return new
end

function Player:init()
    self.tail = {Vector.new(2, 0), Vector.new(1, 0), Vector.new(0, 0)}
end

function Player:update(dt)
    -- change the next move direction based on input,
    -- but prevent moving in the opposite of the current direction
    if Input.wasPressed('a') then
        self.nextMoveDir = Move.Left
    end
    if Input.wasPressed('d') then
        self.nextMoveDir = Move.Right
    end
    if Input.wasPressed('w') then
        self.nextMoveDir = Move.Up
    end
    if Input.wasPressed('s') then
        self.nextMoveDir = Move.Down
    end

    if not self.nextMoveDir:opposes(self.lastMoveDir) then
        self.moveDir = self.nextMoveDir
    end

    self.lastMoveTime = self.lastMoveTime + dt
    while self.lastMoveTime >= moveIncrement do
        -- update the tail positions with the previous head position
        table.insert(self.tail, 1, self.head)
        table.remove(self.tail, #self.tail)

        self.lastMoveTime = self.lastMoveTime - moveIncrement
        self.lastMoveDir = self.moveDir
        self.head = self.head + self.moveDir
    end
end

function Player:draw()
    -- draw head
    local headDrawPos = self.head * size
    love.graphics.setColor(Colors.Head)
    love.graphics.rectangle('fill', headDrawPos.x, headDrawPos.y, size, size)

    -- draw tail
    love.graphics.setColor(Colors.Tail)
    for _, seg in ipairs(self.tail) do
        local tailDrawPos = seg * size
        love.graphics.rectangle('fill', tailDrawPos.x + 1, tailDrawPos.y + 1, size - 2, size - 2)
    end
end

return Player
