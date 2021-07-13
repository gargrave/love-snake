local GameOverState = {
    machine = nil
}
GameOverState.__index = GameOverState

-- TODO: menu options: main menu, restart, quit
function GameOverState.new()
    local new = setmetatable({}, GameOverState)
    new:init()
    return new
end

function GameOverState:init()
end

function GameOverState:enter(machine, prevState)
    self.machine = machine
end

function GameOverState:update(dt)
    gg.Input.lateUpdate(dt)
end

function GameOverState:draw()
    sn.Globals.food:draw()
    sn.Globals.player:draw()
    sn.Globals.grid:draw()

    -- TODO: draw a gameover-screen overlay
    -- TODO: build a better "game over" GUI
    love.graphics.setColor({1, 1, 1})
    love.graphics.print('Game Over')
end

function GameOverState:is(name)
    return name == sn.State.GameOver
end

return GameOverState
