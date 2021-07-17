local TextMenu = {
    activeIdx = 1,
    config = {
        -- activeColor,
        -- activeFont,
        -- idleColor,
        -- idleFont,
        items = {
            -- MenuItem:
            -- -- text
            -- -- action (callback fn)
        },
        -- optional title to display above the menu items
        title = {
            -- color,
            -- font,
            -- text,
        },
        -- optional overlay to render between the text and game entities
        overlay = {
            -- color,
        }
    },
    wrapIdx
}
TextMenu.__index = TextMenu

function TextMenu.new(config)
    local new = setmetatable({}, TextMenu)
    new:init(config)
    return new
end

function TextMenu:init(config)
    self.config = config

    -- curried fn to wrap value for selected idx
    self.wrapIdx = function(val)
        return gg.Math.wrapNum(1, #self.config.items, val)
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

    -- call callback fn on active item when it is "selected"
    if gg.Input.wasPressed(sn.InputMap.Enter) then
        local item = self.config.items[self.activeIdx]
        if item.action then
            item.action()
        end
    end
end

function TextMenu:draw()
    local sw, sh = love.window.getMode()
    -- draw the overlay (when present)
    local overlay = self.config.overlay
    if overlay and overlay.color then
        love.graphics.setColor(overlay.color)
        love.graphics.rectangle('fill', 0, 0, sw, sh)
    end

    -- draw the title (when present)
    local title = self.config.title
    if title and title.text then
        local titleW, titleH = title.font:getWidth(title.text), title.font:getHeight(title.text)
        love.graphics.setColor(title.color)
        love.graphics.setFont(title.font)
        love.graphics.print(title.text, sw / 2 - titleW / 2, sh / 2 - titleH)
    end

    -- draw the interactive menu items, highlighted the selected one
    for idx, item in ipairs(self.config.items) do
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
