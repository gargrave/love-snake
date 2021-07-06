local Globals = require('src.globals')
local Input = require('src.input')

local player = Globals.player
local food = Globals.food

local GameState = {
    machine = nil
}
GameState.__index = GameState

function GameState.new()
    local new = setmetatable({}, GameState)
    new:init()
    return new
end

function GameState:init(machine)
    -- TODO: consider moving player/food initialization here
end

function GameState:enter(machine)
    self.machine = machine
end

function GameState:update(dt)
    if not player then
        player = Globals.player
    end
    if not food then
        food = Globals.food
    end

    player:update(dt)

    if Input.wasPressed('escape') then
        -- TODO: move state keys to constants
        self.machine:setNextState('PAUSED')
    end

    Input.lateUpdate(dt)
end

function GameState:draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()
end

return GameState
