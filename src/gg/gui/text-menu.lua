local TextMenu = {
    activeIdx = 1,
    config = {
        -- activeColor,
        -- activeFont,
        -- idleColor,
        -- idleFont,
    },
    items = {
        -- MenuItem:
        -- -- text
        -- -- action (callback fn)
    },
    wrapIdx
}
TextMenu.__index = TextMenu

function TextMenu.new(config, items)
    local new = setmetatable({}, TextMenu)
    new:init(config, items)
    return new
end

function TextMenu:init(config, items)
    self.config = config
    self.items = items
    -- curried fn to wrap value for selected idx
    self.wrapIdx = function(val)
        return gg.Math.wrapNum(1, #self.items, val)
    end
end

function TextMenu:reset()
    self.activeIdx = 1
end

function TextMenu:update(dt)
    local inc = 0
    if gg.Input.wasPressed(sn.InputMap.MoveUp) then
        inc = inc - 1
    end
    if gg.Input.wasPressed(sn.InputMap.MoveDown) then
        inc = inc + 1
    end
    self.activeIdx = self.wrapIdx(self.activeIdx + inc)

    if gg.Input.wasPressed(sn.InputMap.Enter) then
        local item = self.items[self.activeIdx]
        if item.action then
            item.action()
        end
    end
end

function TextMenu:draw()
    local sw, sh = love.window.getMode()

    for idx, item in ipairs(self.items) do
        local active = idx == self.activeIdx
        local color = active and self.config.activeColor or self.config.idleColor
        local font = active and self.config.activeFont or self.config.idleFont

        local text = item.text
        local textW = font:getWidth(text)
        local textH = font:getHeight(text)
        love.graphics.setColor(color)
        love.graphics.setFont(font)

        local x = sw / 2 - textW / 2
        local y = sh / 2 + textH * (idx - 1)
        love.graphics.print(text, x, y)
    end
end

return TextMenu
