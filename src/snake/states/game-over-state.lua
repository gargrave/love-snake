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

function GameOverState:drawScore()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    local font = sn.Assets.fonts.main__32
    local text = string.format('Final Score: %i', sn.Globals.score.score)
    local textW = font:getWidth(text)
    local textH = font:getHeight(text)
    local tx, ty = (sw / 2) - (textW / 2), sh - textH - 8

    love.graphics.setFont(font)
    love.graphics.setColor(sn.Color.Black)
    love.graphics.print(text, tx - 1, ty + 1)
    love.graphics.setColor(sn.Color.White)
    love.graphics.print(text, tx, ty)
end

function GameOverState:drawUI()
    gg.GameState.drawUI(self)
    self:drawScore()
end

return GameOverState
