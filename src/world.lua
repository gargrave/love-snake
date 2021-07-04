local beginContact = function(fixtureA, fixtureB, contact)
end

local endContact = function(fixtureA, fixtureB, contact)
end

local preSolve = function(fixtureA, fixtureB, contact)
end

local postSolve = function(fixtureA, fixtureB, contact)
end

local world = love.physics.newWorld(0, 0)
world:setCallbacks(beginContact, endContact, preSolve, postSolve)
return world
