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
        idleFont = sn.Assets.fonts.main__24
    }

    local menuItems = {{
        action = function()
            self.machine:setNextState(sn.State.Main)
        end,
        text = 'Start Game'
    }, {
        action = love.event.quit,
        text = 'Quit'
    }}

    self.menu = gg.TextMenu.new(menuConfig, menuItems)
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
    -- TODO: move to TextMenu as an optional
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    -- TODO: move to TextMenu as an optional
    local titleFont = sn.Assets.fonts.main__64
    local titleText = 'Snake!'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setColor({1, 1, 1})
    love.graphics.setFont(titleFont)
    love.graphics.print(titleText, sw / 2 - titleW / 2, sh / 2 - titleH)

    -- TODO: render a simple copyright notice
    gg.GameState.drawUI(self)
end

return TitleState
