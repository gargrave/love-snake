local Globals = require('src.snake.globals')
local Input = require('src.input')

local GameOverState = {
    machine = nil
}
GameOverState.__index = GameOverState

function GameOverState.new()
    local new = setmetatable({}, GameOverState)
    new:init()
    return new
end

function GameOverState:init()
end

function GameOverState:enter(machine)
    self.machine = machine
end

function GameOverState:update(dt)
    -- if not player then
    --     player = Globals.player
    -- end
    -- if not food then
    --     food = Globals.food
    -- end

    -- if Input.wasPressed('escape') then
    --     self.machine:setNextState(__Game.State.Game)
    -- end

    Input.lateUpdate(dt)
end

function GameOverState:draw()
    -- TODO: draw a grid
    Globals.food:draw()
    Globals.player:draw()

    -- TODO: draw a pause-screen overlay
    -- TODO: build a better "paused" GUI
    love.graphics.setColor({1, 1, 1})
    love.graphics.print('Game Over')
end

return GameOverState
