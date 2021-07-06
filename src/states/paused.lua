local Globals = require('src.globals')
local Input = require('src.input')

local player = Globals.player
local food = Globals.food

local PausedState = {
    machine = nil
}
PausedState.__index = PausedState

function PausedState.new()
    local new = setmetatable({}, PausedState)
    new:init()
    return new
end

function PausedState:init()
end

function PausedState:enter(machine)
    self.machine = machine
end

function PausedState:update(dt)
    if not player then
        player = Globals.player
    end
    if not food then
        food = Globals.food
    end

    if Input.wasPressed('escape') then
        -- TODO: move state keys to constants
        self.machine:setNextState('GAME')
    end

    Input.lateUpdate(dt)
end

function PausedState:draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()

    -- TODO: draw a pause-screen overlay
    -- TODO: build a better "paused" GUI
    love.graphics.setColor({1, 1, 1})
    love.graphics.print('Paused')
end

return PausedState
