local Public = {}

---Check if an element is in an array
---@generic T
---@param array T[]
---@param element T
---@return boolean
function Public.array_contain(array, element)
    for _, value in ipairs(array) do
        if value == element then
            return true
        end
    end

    return false
end

---Merge two arrays together
---@generic T
---@param old T[]
---@generic U
---@param new U[]
---@return (T | U)[]
function Public.merge_arrays(old, new)
    -- Deepcopy to prevent reference shenanigans
    old = table.deepcopy(old)
    new = table.deepcopy(new)

    for _, v in pairs(new) do
        table.insert(old, v)
    end

    return old
end


return Public