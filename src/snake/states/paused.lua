local Globals = require('src.snake.globals')

local player = Globals.player
local food = Globals.food

local PausedState = {
    machine = nil,
    menu = nil
}
PausedState.__index = PausedState

function PausedState.new()
    local new = setmetatable({}, PausedState)
    new:init()
    return new
end

function PausedState:init()
    local menuConfig = {
        activeColor = __Color.Yellow,
        activeFont = Assets.fonts.main__24,
        idleColor = __Color.White,
        idleFont = Assets.fonts.main__24
    }

    local menuItems = {{
        action = function()
            self:unpause()
        end,
        text = 'Return to Game'
    }, {
        -- TODO: wire up when main menu is implemented
        text = 'Main Menu'
    }, {
        action = love.event.quit,
        text = 'Quit'
    }}

    self.menu = gg.TextMenu.new(menuConfig, menuItems)
end

function PausedState:enter(machine)
    self.machine = machine
end

function PausedState:unpause()
    self.machine:setNextState(__Game.State.Game)
end

function PausedState:update(dt)
    if not player then
        player = Globals.player
    end
    if not food then
        food = Globals.food
    end

    if gg.Input.wasPressed(InputAction.Pause) then
        self:unpause()
    else
        self.menu:update(dt)
    end

    gg.Input.lateUpdate(dt)
end

function PausedState:draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()

    -- TODO: build a better "paused" GUI
    local sw, sh = love.window.getMode()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor({1, 1, 1})
    local titleFont = Assets.fonts.main__64
    local titleText = 'Paused'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setFont(titleFont)
    love.graphics.print('Paused', sw / 2 - titleW / 2, sh / 2 - titleH)

    self.menu:draw()
end

return PausedState
