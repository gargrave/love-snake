local TitleState = {
    menu = nil
}
TitleState.__index = TitleState
setmetatable(TitleState, {
    __index = gg.GameState
})

function TitleState.new()
    local new = setmetatable({}, TitleState)
    new:init()
    return new
end

function TitleState:init()
    gg.GameState.init(self, sn.State.Title)

    local menuConfig = {
        activeColor = sn.Color.Yellow,
        activeFont = sn.Assets.fonts.main__24,
        idleColor = sn.Color.White,
        idleFont = sn.Assets.fonts.main__24,
        items = {{
            action = function()
                self.machine:setNextState(sn.State.Main)
            end,
            text = 'Start Game'
        }, {
            action = love.event.quit,
            text = 'Quit'
        }},
        title = {
            color = sn.Color.White,
            font = sn.Assets.fonts.main__64,
            text = 'Snake!'
        },
        overlay = {
            color = sn.Color.MenuOverlay
        }

    }

    self.menu = gg.TextMenu.new(menuConfig)
end

function TitleState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    sn.Globals.food = nil
    sn.Globals.player = nil
    sn.Globals.grid = nil

    self.menu:reset()
    self.drawUiQueue = {self.menu}
    self.updateQueue = {self.menu}
end

function TitleState:drawUI()
    -- TODO: render a simple copyright notice
    gg.GameState.drawUI(self)
end

return TitleState
