-- initialize gg
require('src.gg.__init__')

require('src.snake.assets')
require('src.snake.config')
require('src.snake.constants')

local Input = require('src.input')

local Food = require('src.snake.entities.food')
local GameOverState = require('src.snake.states.game-over')
local GameState = require('src.snake.states.game')
local Globals = require('src.snake.globals')
local PausedState = require('src.snake.states.paused')
local Player = require('src.snake.entities.player')

local player = nil
local food = nil

local gameState = nil
local gameOverState = nil
local pausedState = nil
local stateMachine = nil

function love.load()
    player = Player.new()
    food = Food.new()

    gameState = GameState.new()
    gameOverState = GameOverState.new()
    pausedState = PausedState.new()

    stateMachine = gg.StateMachine.new({
        [__Game.State.Game] = gameState,
        [__Game.State.GameOver] = gameOverState,
        [__Game.State.Paused] = pausedState
    })

    Globals.player = player
    Globals.food = food
    Globals.stateMachine = stateMachine

    stateMachine:setNextState(__Game.State.Game)
end

function love.focus(focused)
    if not focused then
        stateMachine:setNextState(__Game.State.Paused)
    end
end

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
    stateMachine:draw()
end
