local constants = require("lib.constants")
local utils = require("lib.utils")
local science = require("lib.science_pack")
local Public = {}

---Does the tech require this science pack?
---@param tech data.TechnologyPrototype
---@param science string
---@return boolean
function Public.requires_science(tech, science)
    if tech.unit == nil then return false end
    for _, value in pairs(tech.unit.ingredients) do
        if value[1] == science then
            return true
        end
    end

    return false
end

---Does the tech require promethium?
---@param tech data.TechnologyPrototype
---@return boolean
function Public.requires_promethium_science(tech)
    return Public.requires_science(tech, "promethium-science-pack")
end

---Does the tech require non vanilla science packs?
---@param tech data.TechnologyPrototype
---@return boolean
function Public.require_pre_nobelium_pack(tech)
    for _, value in pairs(tech.unit.ingredients) do

        local science_pack = data.raw["tool"][value[1]];

        if science_pack == nil then
            error("Couldn't find sciencepack: " .. value)
        end

        if value[1] ~= "promethium-science-pack" and science.is_pre_nobelium(science_pack) then
            return true
        end
    end
    return false
end

---Return the promethium science cost of the technology
---@param tech data.TechnologyPrototype
---@return integer?
function Public.get_promethium_cost(tech)
    for _, value in pairs(tech.unit.ingredients) do
        if value[1] == "promethium-science-pack" then
            return value[2]
        end
    end

    return nil
end

---Add a science to a technology
---@param tech data.TechnologyPrototype
---@param science string
---@param count integer
function Public.add_science_to_tech(tech, science, count)
    tech.unit.ingredients = utils.merge_arrays(tech.unit.ingredients, {{ science, count }})
end

---Add a science to a technology if it's not already set. Return true if set
---@param tech data.TechnologyPrototype
---@param science string
---@param count integer
---@return boolean
function Public.add_science_to_tech_if_not_set(tech, science, count)
    if not Public.requires_science(tech, science) then
        Public.add_science_to_tech(tech, science, count)
        return true
    end

    return false
end

return Public
