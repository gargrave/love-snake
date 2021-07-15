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
        idleFont = sn.Assets.fonts.main__24
    }

    local menuItems = {{
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
    }}

    self.menu = gg.TextMenu.new(menuConfig, menuItems)
end

function GameOverState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    self.menu:reset()
    self.drawQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid}
    self.drawUiQueue = {self.menu}
    self.updateQueue = {self.menu}
end

function GameOverState:drawUI()
    -- TODO: move to TextMenu as an optional
    local sw, sh = love.window.getMode()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    -- TODO: move to TextMenu as an optional
    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Game Over'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setColor({1, 1, 1})
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, sw / 2 - titleW / 2, sh / 2 - titleH)

    gg.GameState.drawUI(self)
end

return GameOverState
