local player = nil
local food = nil

local GameState = {
    machine = nil
}
GameState.__index = GameState

function GameState.new()
    local new = setmetatable({}, GameState)
    new:init()
    return new
end

function GameState:init(machine)
    -- TODO: consider moving player/food initialization here
end

function GameState:enter(machine)
    self.machine = machine
end

function GameState:update(dt)
    if not player then
        player = sn.Globals.player
    end
    if not food then
        food = sn.Globals.food
    end

    player:update(dt)

    if gg.Input.wasPressed(sn.InputAction.Pause) then
        self.machine:setNextState(sn.State.Paused)
    end

    gg.Input.lateUpdate(dt)
end

function GameState:draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()
end

return GameState
