local Globals = require('src.snake.globals')
local Input = require('src.input')

local Move = {
    Right = gg.Vector.new(1, 0),
    Left = gg.Vector.new(-1, 0),
    Up = gg.Vector.new(0, -1),
    Down = gg.Vector.new(0, 1)
}

local Colors = {
    Head = {0, 1, 0},
    Tail = {.075, .55, .075}
}

local moveIncrement = .2
-- TODO: get this from "grid" settings
local size = 32

local Player = {
    bounds = gg.Rect.new(32 * 3, 0, size, size),
    head = gg.Vector.new(3, 0),
    lastMoveTime = 0,
    lastMoveDir = Move.Right,
    moveDir = Move.Right,
    nextMoveDir = Move.Right,
    tail = {}
}
Player.__index = Player

function Player.new()
    local new = setmetatable({}, Player)
    new:init()
    return new
end

function Player:init()
    self.tail = {gg.Vector.new(2, 0), gg.Vector.new(1, 0), gg.Vector.new(0, 0)}
end

function Player:update(dt)
    -- check if head and tail have collided
    local tailRect = gg.Rect.new()
    for _, tail in ipairs(self.tail) do
        tailRect:set(tail.x * size, tail.y * size, size, size)
        if self.bounds:overlaps(tailRect) then
            Globals.stateMachine:setNextState(__Game.State.GameOver)
        end
    end

    -- change the next move direction based on input,
    -- but prevent moving in the opposite of the current direction
    if Input.wasPressed(InputAction.MoveLeft) then
        self.nextMoveDir = Move.Left
    end
    if Input.wasPressed(InputAction.MoveRight) then
        self.nextMoveDir = Move.Right
    end
    if Input.wasPressed(InputAction.MoveUp) then
        self.nextMoveDir = Move.Up
    end
    if Input.wasPressed(InputAction.MoveDown) then
        self.nextMoveDir = Move.Down
    end

    if not self.nextMoveDir:opposes(self.lastMoveDir) then
        self.moveDir = self.nextMoveDir
    end

    self.lastMoveTime = self.lastMoveTime + dt
    while self.lastMoveTime >= moveIncrement do
        -- update the tail positions with the previous head position
        table.insert(self.tail, 1, self.head)
        -- TODO: add a "fade out" effect on the last segment
        table.remove(self.tail, #self.tail)

        self.lastMoveTime = self.lastMoveTime - moveIncrement
        self.lastMoveDir = self.moveDir
        self.head = self.head + self.moveDir
        self.bounds:set(self.head.x * size, self.head.y * size, size, size)

        local food = Globals.food
        if self.bounds:overlaps(food.bounds) then
            -- TODO: increase speed
            -- TODO: add a "fade in effect for the new segment"
            local lastTail = self.tail[#self.tail]
            table.insert(self.tail, #self.tail, gg.Vector.clone(lastTail))
            food:onPlayerCollision(self)
        end
    end
end

function Player:draw()
    -- draw head
    local headDrawPos = self.head * size
    love.graphics.setColor(Colors.Head)
    self.bounds:draw()

    -- draw tail
    love.graphics.setColor(Colors.Tail)
    for _, seg in ipairs(self.tail) do
        local tailDrawPos = seg * size
        -- TODO: maybe make each subsequent tail section a little more faded than the previous
        love.graphics.rectangle('fill', tailDrawPos.x + 1, tailDrawPos.y + 1, size - 2, size - 2)
    end
end

return Player
