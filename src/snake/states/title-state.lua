local TitleState = {
    machine = nil,
    menu = nil
}
TitleState.__index = TitleState

function TitleState.new()
    local new = setmetatable({}, TitleState)
    new:init()
    return new
end

function TitleState:init()
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
        text = 'Start Game'
    }, {
        action = love.event.quit,
        text = 'Quit'
    }}

    self.menu = gg.TextMenu.new(menuConfig, menuItems)
end

function TitleState:enter(machine, prevState)
    self.machine = machine
    self.menu:reset()

    sn.Globals.food = nil
    sn.Globals.player = nil
    sn.Globals.grid = nil
end

function TitleState:update(dt)
    self.menu:update(dt)
    gg.Input.lateUpdate(dt)
end

function TitleState:draw()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Snake!'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setColor({1, 1, 1})
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, sw / 2 - titleW / 2, sh / 2 - titleH)

    self.menu:draw()
end

function TitleState:is(name)
    return name == sn.State.Title
end

return TitleState
