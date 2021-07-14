local GameOverState = {
    machine = nil,
    menu = nil
}
GameOverState.__index = GameOverState

function GameOverState.new()
    local new = setmetatable({}, GameOverState)
    new:init()
    return new
end

function GameOverState:init()
    local menuConfig = {
        activeColor = sn.Color.Yellow,
        activeFont = sn.Assets.fonts.main__24,
        idleColor = sn.Color.White,
        idleFont = sn.Assets.fonts.main__24
    }

    local menuItems = {{
        action = function()
            self.machine:setNextState(sn.State.Game)
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
    self.machine = machine
    self.menu:reset()
end

function GameOverState:update(dt)
    self.menu:update(dt)
    gg.Input.lateUpdate(dt)
end

function GameOverState:draw()
    sn.Globals.food:draw()
    sn.Globals.player:draw()
    sn.Globals.grid:draw()

    local sw, sh = love.window.getMode()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Game Over'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setColor({1, 1, 1})
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, sw / 2 - titleW / 2, sh / 2 - titleH)

    self.menu:draw()
end

function GameOverState:is(name)
    return name == sn.State.GameOver
end

return GameOverState
