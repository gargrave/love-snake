local Food = require('src.food')
local Globals = require('src.globals')
local Input = require('src.input')
local Player = require('src.player')

local GameState = require('src.states.game')
local PausedState = require('src.states.paused')
local StateMachine = require('src.states.machine')

local player = nil
local food = nil

local gameState = nil
local pausedState = nil
local stateMachine = nil

function love.load()
    player = Player.new()
    food = Food.new()

    Globals.player = player
    Globals.food = food

    gameState = GameState.new()
    pausedState = PausedState.new()

    -- TODO: move keys to constants
    local stateMap = {
        GAME = gameState,
        PAUSED = pausedState
    }
    stateMachine = StateMachine.new(stateMap)
    stateMachine:setNextState('GAME')
end

function love.focus(focused)
    if not focused then
        stateMachine:setNextState('PAUSED')
    end
end

function love.update(dt)
    stateMachine:update(dt)
end

function love.draw()
    stateMachine:draw()
end
