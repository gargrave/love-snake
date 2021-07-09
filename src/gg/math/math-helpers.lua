local Math = {}

function Math.wrapNum(min, max, val)
    if val > max then
        return min
    elseif val < min then
        return max
    end
    return val
end

return Math
