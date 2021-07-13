require('src.gg.__init__')
require('src.snake.__init__')

local stateMachine = nil

function love.load()
    stateMachine = gg.StateMachine.new({
        [sn.State.Game] = sn.GameState.new(),
        [sn.State.GameOver] = sn.GameOverState.new(),
        [sn.State.Paused] = sn.PausedState.new()
    })

    stateMachine:setNextState(sn.State.Game)
end

function love.focus(focused)
    if not focused then
        stateMachine:setNextState(sn.State.Paused)
    end
end

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
    stateMachine:draw()
end
