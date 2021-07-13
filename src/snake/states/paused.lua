-- TODO: rename to paused-state.lua
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
        activeColor = sn.Color.Yellow,
        activeFont = sn.Assets.fonts.main__24,
        idleColor = sn.Color.White,
        idleFont = sn.Assets.fonts.main__24
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
    self.machine:setNextState(sn.State.Game)
end

function PausedState:update(dt)
    if gg.Input.wasPressed(sn.InputMap.Pause) then
        self:unpause()
    else
        self.menu:update(dt)
    end

    gg.Input.lateUpdate(dt)
end

function PausedState:draw()
    sn.Globals.food:draw()
    sn.Globals.player:draw()
    sn.Globals.grid:draw()

    local sw, sh = love.window.getMode()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor({1, 1, 1})
    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Paused'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setFont(titleFont)
    love.graphics.print('Paused', sw / 2 - titleW / 2, sh / 2 - titleH)

    self.menu:draw()
end

return PausedState
