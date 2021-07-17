local MainState = {}
MainState.__index = MainState
setmetatable(MainState, {
    __index = gg.GameState
})

function MainState.new()
    local new = setmetatable({}, MainState)
    new:init()
    return new
end

function MainState:init(machine)
    gg.GameState.init(self, sn.State.Main)
end

function MainState:enter(machine, prevState)
    gg.GameState.enter(self, machine, prevState)

    if prevState and prevState:is(sn.State.Paused) then
        return
    end

    -- TODO: destroy all previous instances
    gg.Messages.clear()

    sn.Globals.grid = sn.Grid.new(32, 29, 16)
    sn.Globals.player = sn.Player.new()
    sn.Globals.food = sn.Food.new()
    sn.Globals.score = sn.Score.new()
    sn.Globals.score = sn.Score.new()
    sn.Globals.gameUi = sn.GameUi.new()

    self.drawQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid, sn.Globals.gameUi}
    self.updateQueue = {sn.Globals.food, sn.Globals.player, sn.Globals.grid, sn.Globals.gameUi}
end

function MainState:lateUpdate(dt)
    if gg.Input.wasPressed(sn.InputMap.Pause) then
        self.machine:setNextState(sn.State.Paused)
    end

    gg.GameState.lateUpdate(self, dt)
end

function MainState:drawScore()
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    local font = sn.Assets.fonts.main__28
    local text = string.format('Score: %i', sn.Globals.score.score)
    local textW = font:getWidth(text)
    local textH = font:getHeight(text)
    local tx, ty = sw - textW - (textW * .1), 4

    love.graphics.setFont(font)
    love.graphics.setColor(sn.Color.Black)
    love.graphics.print(text, tx - 1, ty + 1)
    love.graphics.setColor(sn.Color.White)
    love.graphics.print(text, tx, ty)
end

function MainState:drawUI()
    self:drawScore()
    gg.GameState.drawUI(self)
end

return MainState
