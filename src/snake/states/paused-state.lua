local PausedState = {
    menu = nil
}
PausedState.__index = PausedState
setmetatable(PausedState, {
    __index = gg.GameState
})

function PausedState.new()
    local new = setmetatable({}, PausedState)
    new:init()
    return new
end

function PausedState:init()
    gg.GameState.init(self, sn.State.Paused)

    local menuConfig = {
        activeColor = sn.Color.Yellow,
        activeFont = sn.Assets.fonts.main__24,
        idleColor = sn.Color.White,
        idleFont = sn.Assets.fonts.main__24,
        items = {{
            action = function()
                self.machine:setNextState(sn.State.Main)
            end,
            text = 'Return to Game'
        }, {
            action = function()
                self.machine:setNextState(sn.State.Title)
            end,
            text = 'Main Menu'
        }, {
            action = love.event.quit,
            text = 'Quit'
        }},
        title = {
            color = sn.Color.White,
            font = sn.Assets.fonts.main__64,
            text = 'Paused'
        },
        overlay = {
            color = sn.Color.MenuOverlay
        }
    }

    self.menu = gg.TextMenu.new(menuConfig)
end

function PausedState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    self.menu:reset()
    self.drawQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid}
    self.drawUiQueue = {self.menu}
    self.updateQueue = {self.menu}
end

function PausedState:lateUpdate(dt)
    if gg.Input.wasPressed(sn.InputMap.Pause) then
        self.machine:setNextState(sn.State.Main)
    end
    gg.GameState.lateUpdate(self, dt)
end

return PausedState
