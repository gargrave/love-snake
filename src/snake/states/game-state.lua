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
    sn.Globals.player:update(dt)

    if gg.Input.wasPressed(sn.InputMap.Pause) then
        self.machine:setNextState(sn.State.Paused)
    end

    gg.Input.lateUpdate(dt)
end

function GameState:draw()
    sn.Globals.food:draw()
    sn.Globals.player:draw()
    sn.Globals.grid:draw()
end

return GameState
