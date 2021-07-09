require('src.assets')
require('src.constants')

local Globals = require('src.globals')

local Food = require('src.food')
local Input = require('src.input')
local Player = require('src.player')

local GameState = require('src.states.game')
local GameOverState = require('src.states.game-over')
local PausedState = require('src.states.paused')
local StateMachine = require('src.states.machine')

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

    stateMachine = StateMachine.new({
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
