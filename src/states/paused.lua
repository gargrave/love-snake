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
        self.machine:setNextState(__Game.State.Game)
    end

    Input.lateUpdate(dt)
end

function PausedState:draw()
    -- TODO: draw a grid
    food:draw()
    player:draw()

    -- TODO: draw a pause-screen overlay

    -- TODO: build a better "paused" GUI
    local sw, sh = love.window.getMode()
    love.graphics.setColor({0, 0, 0, .8})
    love.graphics.rectangle('fill', 0, 0, sw, sh)

    love.graphics.setColor({1, 1, 1})
    local titleFont = Assets.fonts.main__64
    local titleText = 'Paused'
    local titleW, titleH = titleFont:getWidth(titleText), titleFont:getHeight(titleText)
    love.graphics.setFont(titleFont)
    love.graphics.print('Paused', sw / 2 - titleW / 2, sh / 2 - titleH / 2)
end

return PausedState
