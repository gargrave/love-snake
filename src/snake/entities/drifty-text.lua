local font = nil
local Defaults = {
    Distance = 45,
    LifeSpan = 1.75
}

local DriftyText = {
    alpha = 1,
    config = {text, x, y},
    lifeTimer = 0
}
DriftyText.__index = DriftyText
setmetatable(DriftyText, {
    __index = gg.Entity
})

function DriftyText.new(config)
    local new = setmetatable({}, DriftyText)
    new:init(config)
    return new
end

function DriftyText:init(config)
    gg.Entity.init(self)

    font = sn.Assets.fonts.main__24
    self.config = config

    local textW = font:getWidth(config.text)
    local textH = font:getHeight(config.text)
    self.bounds = gg.Rect.new(config.x, config.y, textW, textH)

    -- TODO: move these into a flux group (https://github.com/rxi/flux#groups)
    flux.to(self.bounds, Defaults.LifeSpan, {
        x = self.bounds.x,
        y = self.bounds.y - Defaults.Distance
    })

    flux.to(self, Defaults.LifeSpan, {
        alpha = 0
    }):delay(.5)

    gg.debug(string.format('DriftyText:init() with id: "%s"', self.id))
end

function DriftyText:update(dt)
    -- this is actually moved by 'flux', but calling this with no args
    -- ensures its right/bottom settings stay in sync with flux's movement
    self.bounds:move()

    self.lifeTimer = self.lifeTimer + dt
    if self.lifeTimer > Defaults.LifeSpan then
        self.active = false
        self.dead = true
    end
end

function DriftyText:draw()
    love.graphics.setFont(font)

    local cfg = self.config
    local x, y = self.bounds.x, self.bounds.y
    love.graphics.setColor(lume.concat(sn.Color.Black, {self.alpha}))
    love.graphics.print(cfg.text, x - 1, y + 1)
    love.graphics.setColor(lume.concat(sn.Color.White, {self.alpha}))
    love.graphics.print(cfg.text, x, y)
end

return DriftyText
