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

function PausedState:enter(machine, prevState)
    self.machine = machine
    self.menu:reset()
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

    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Paused'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setColor({1, 1, 1})
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, sw / 2 - titleW / 2, sh / 2 - titleH)

    self.menu:draw()
end

function PausedState:is(name)
    return name == sn.State.Paused
end

return PausedState
