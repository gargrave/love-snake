require('src.gg.__init__')
require('src.snake.__init__')

local grid = nil
local player = nil
local food = nil
local stateMachine = nil

function love.load()
    grid = sn.Grid.new(32, 29, 16)
    sn.Globals.grid = grid

    player = sn.Player.new()
    food = sn.Food.new()

    stateMachine = gg.StateMachine.new({
        [sn.State.Game] = sn.GameState.new(),
        [sn.State.GameOver] = sn.GameOverState.new(),
        [sn.State.Paused] = sn.PausedState.new()
    })

    sn.Globals.player = player
    sn.Globals.food = food
    sn.Globals.stateMachine = stateMachine

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
