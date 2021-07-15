local MainState = {}
MainState.__index = MainState
setmetatable(MainState, {
    __index = gg.GameState
})

function MainState.new()
    local new = setmetatable({}, MainState)
    new:init()
    return new
end

function MainState:init(machine)
    gg.GameState.init(self, sn.State.Main)
end

function MainState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    if prevState and prevState:is(sn.State.Paused) then
        return
    end

    sn.Globals.grid = sn.Grid.new(32, 29, 16)
    sn.Globals.player = sn.Player.new()
    sn.Globals.food = sn.Food.new()

    self.drawQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid}
    self.updateQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid}
end

function MainState:lateUpdate(dt)
    if gg.Input.wasPressed(sn.InputMap.Pause) then
        self.machine:setNextState(sn.State.Paused)
    end

    gg.Input.lateUpdate(dt)
end

return MainState
