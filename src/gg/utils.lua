local function itr(arr, fn)
    for i = 1, #arr, 1 do
        fn(arr[i], i)
    end
end

local function ritr(arr, fn)
    for i = #arr, 1, -1 do
        fn(arr[i], i)
    end
end

local function wrapNum(min, max, val)
    if val > max then
        return min
    elseif val < min then
        return max
    end
    return val
end

return {
    itr = itr,
    ritr = ritr,
    wrapNum = wrapNum
}
