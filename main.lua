require('src.gg.__init__')
require('src.snake.__init__')

-- TODO: figure out what a better solution for this looks like
gg.debug = function(str)
    print(str)
end

local stateMachine = nil

function love.load()
    stateMachine = gg.StateMachine.new({
        [sn.State.GameOver] = sn.GameOverState.new(),
        [sn.State.Main] = sn.MainState.new(),
        [sn.State.Paused] = sn.PausedState.new(),
        [sn.State.Title] = sn.TitleState.new()
    })
    sn.Globals.stateMachine = stateMachine

    stateMachine:setNextState(sn.State.Title)
end

function love.focus(focused)
    if not focused then
        if stateMachine:currentStateIs(sn.State.Main) then
            stateMachine:setNextState(sn.State.Paused)
        end
    end
end

function love.update(dt)
    require("lovebird").update()
    stateMachine:update(dt)
    flux.update(dt)
end

function love.draw()
    stateMachine:draw()
end
