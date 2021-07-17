local GameOverState = {
    menu = nil
}
GameOverState.__index = GameOverState
setmetatable(GameOverState, {
    __index = gg.GameState
})

function GameOverState.new()
    local new = setmetatable({}, GameOverState)
    new:init()
    return new
end

function GameOverState:init()
    gg.GameState.init(self, sn.State.GameOver)

    local menuConfig = {
        activeColor = sn.Color.Yellow,
        activeFont = sn.Assets.fonts.main__24,
        idleColor = sn.Color.White,
        idleFont = sn.Assets.fonts.main__24,
        items = {{
            action = function()
                self.machine:setNextState(sn.State.Main)
            end,
            text = 'New Game'
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
            text = 'Game Over'
        },
        overlay = {
            color = sn.Color.MenuOverlay
        }

    }

    self.menu = gg.TextMenu.new(menuConfig)
end

function GameOverState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    self.menu:reset()
    self.drawQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid}
    self.drawUiQueue = {self.menu}
    self.updateQueue = {self.menu}
end

return GameOverState
