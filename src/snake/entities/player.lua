local Move = {
    Right = gg.Vector.right(),
    Left = gg.Vector.left(),
    Up = gg.Vector.up(),
    Down = gg.Vector.down()
}

local Colors = {
    Head = {0, 1, 0},
    Tail = {.075, .55, .075}
}

local moveIncrement = .1

local Player = {
    head = gg.Vector.new(3, 0),
    lastMoveTime = 0,
    lastMoveDir = Move.Right,
    moveDir = Move.Right,
    nextMoveDir = Move.Right,
    size = 0,
    tail = {}
}
Player.__index = Player
setmetatable(Player, {
    __index = gg.Entity
})

function Player.new()
    local new = setmetatable({}, Player)
    new:init()
    return new
end

function Player:init()
    gg.Entity.init(self)

    self.size = sn.Globals.gridSize
    self.bounds = gg.Rect.new(32 * 3, 0, self.size, self.size)
    self.tail = {gg.Vector.new(2, 0), gg.Vector.new(1, 0), gg.Vector.new(0, 0)}

    print(string.format('Player:init() with id: "%s"', self.id))
end

function Player:update(dt)
    -- check if head and tail have collided
    local tailRect = gg.Rect.new()
    for _, tail in ipairs(self.tail) do
        tailRect:set(tail.x * self.size, tail.y * self.size, self.size, self.size)
        if self.bounds:overlaps(tailRect) then
            sn.Globals.stateMachine:setNextState(sn.State.GameOver)
        end
    end

    -- change the next move direction based on input,
    -- but prevent moving in the opposite of the current direction
    if gg.Input.wasPressed(sn.InputMap.MoveLeft) then
        self.nextMoveDir = Move.Left
    end
    if gg.Input.wasPressed(sn.InputMap.MoveRight) then
        self.nextMoveDir = Move.Right
    end
    if gg.Input.wasPressed(sn.InputMap.MoveUp) then
        self.nextMoveDir = Move.Up
    end
    if gg.Input.wasPressed(sn.InputMap.MoveDown) then
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
        self.bounds:set(self.head.x * self.size, self.head.y * self.size, self.size, self.size)

        local food = sn.Globals.food
        if self.bounds:overlaps(food.bounds) then
            -- TODO: increase speed
            -- TODO: add a "fade in" effect for the new segment
            local lastTail = self.tail[#self.tail]
            table.insert(self.tail, #self.tail, gg.Vector.clone(lastTail))
            food:onPlayerCollision(self)

            local points = sn.Globals.score:increment()
            sn.Globals.gameUi:spawnDriftyText({
                text = string.format('+%i', points),
                x = self.bounds.x,
                y = self.bounds.y
            })

            gg.Messages.send(sn.Message.FoodPickedUp, self)
        end
    end
end

function Player:draw()
    -- draw head
    love.graphics.setColor(Colors.Head)
    self.bounds:draw()

    -- draw tail
    love.graphics.setColor(Colors.Tail)
    for _, seg in ipairs(self.tail) do
        local tailDrawPos = seg * self.size
        -- TODO: maybe make each subsequent tail section a little more faded than the previous
        love.graphics.rectangle('fill', tailDrawPos.x + 1, tailDrawPos.y + 1, self.size - 2, self.size - 2)
    end
end

return Player
