local Messages = {}
Messages.__index = Messages

local subs = {}

function Messages.send(msg, sender)
    local targets = subs[msg]
    if targets then
        gg.debug(string.format('gg.Messages :: Sending msg "%s" to %i subs.', msg, #targets))
        for _, sub in ipairs(subs[msg]) do
            sub:onMessage(msg)
        end
    end
end

function Messages.sub(msg, subscriber)
    assert(type(subscriber.onMessage) == 'function', "'subscriber must have an 'onMessage' handler fn.")

    if not subs[msg] then
        subs[msg] = {}
    end

    gg.debug(string.format('gg.Messages :: Adding sub for %s ', msg))
    table.insert(subs[msg], subscriber)
end

function Messages.unsub(msg, subscriber)
    if subs[msg] then
        gg.utils.ritr(subs[msg], function(sub, idx)
            if sub == subscriber then
                gg.debug(string.format('gg.Messages :: Removing sub for %s ', msg))
                table.remove(subs[msg], idx)
            end
        end)
    end
end

function Messages.clear()
    gg.debug('gg.Messages :: Clearing all subs')
    subs = {}
end

return Messages
