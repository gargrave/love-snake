local scoreInc = 10

local Score = {
    score = 0
}
Score.__index = Score
setmetatable(Score, {
    __index = gg.GameObject
})

function Score.new()
    local new = setmetatable({}, Score)
    new:init()
    return new
end

function Score:init()
    self:reset()
end

function Score:reset()
    self.score = 0
end

function Score:increment()
    self.score = self.score + scoreInc
    return scoreInc
end

return Score
