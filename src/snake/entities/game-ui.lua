local GameUi = {
    addQueue = {},
    drawQueue = {},
    updateQueue = {}
}
GameUi.__index = GameUi
setmetatable(GameUi, {
    __index = gg.GameObject
})

function GameUi.new()
    local new = setmetatable({}, GameUi)
    new:init()
    return new
end

function GameUi:init()
end

function GameUi:spawnDriftyText(config)
    table.insert(self.addQueue, config)
end

function GameUi:update(dt)
    -- add any enqueue new DriftyTexts to the update/draw queues
    for _, config in ipairs(self.addQueue) do
        local dt = sn.DriftyText.new(config)
        table.insert(self.drawQueue, dt)
        table.insert(self.updateQueue, dt)
    end
    self.addQueue = {}

    for _, item in ipairs(self.updateQueue) do
        if item.update and item.active then
            item:update(dt)
        end
    end
end

function GameUi:lateUpdate(dt)
    -- destroy any objects that are ready to go
    gg.utils.ritr(self.updateQueue, function(item, idx)
        if item.dead then
            if item.destroy then
                item:destroy()
            end

            table.remove(self.drawQueue, idx)
            table.remove(self.updateQueue, idx)
        end
    end)
end

function GameUi:draw()
    for _, item in ipairs(self.drawQueue) do
        if item.draw and item.active then
            item:draw()
        end
    end
end

return GameUi
