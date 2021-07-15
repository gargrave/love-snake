local Input = require('src.gg.core.input')

local GameState = {
    drawQueue = {},
    drawUiQueue = {},
    machine = nil,
    name = 'unknown',
    updateQueue = {}
}
GameState.__index = GameState

function GameState:init(name)
    self.name = name
end

function GameState:enter(machine, prevState)
    self.machine = machine
end

function GameState:exit(nextState)
end

function GameState:update(dt)
    for _, item in ipairs(self.updateQueue) do
        if item.update then
            item:update(dt)
        end
    end
    self:lateUpdate(dt)
end

function GameState:lateUpdate(dt)
    Input.lateUpdate(dt)
end

function GameState:draw()
    self:drawEntities()
    self:drawUI()
end

function GameState:drawEntities()
    for _, item in ipairs(self.drawQueue) do
        if item.draw then
            item:draw()
        end
    end
end

function GameState:drawUI()
    for _, item in ipairs(self.drawUiQueue) do
        if item.draw then
            item:draw()
        end
    end
end

function GameState:is(name)
    return name == self.name
end

return GameState
