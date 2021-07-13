local StateMachine = {
    currentState = nil,
    nextState = nil
}
StateMachine.__index = StateMachine

function StateMachine.new(stateMap)
    local new = setmetatable({}, StateMachine)
    new:init(stateMap)
    return new
end

function StateMachine:init(stateMap)
    self.stateMap = stateMap
end

function StateMachine:update(dt)
    self:processStateChanges()

    if self.currentState then
        self.currentState:update(dt)
    end
end

function StateMachine:draw()
    if self.currentState then
        self.currentState:draw()
    end
end

function StateMachine:processStateChanges()
    if self.currentState and self.currentState.exit then
        self.currentState:exit()
    end

    if self.nextState then
        self.nextState:enter(self, self.currentState)
        self.currentState = self.nextState
        self.nextState = nil
    end

end

function StateMachine:setNextState(stateKey)
    self.nextState = self.stateMap[stateKey]
end

return StateMachine
