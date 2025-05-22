local utils = require("lib.utils")
local constants = require("lib.constants")
local technology = require("lib.technology")
local science = require("lib.science_pack")

local Public = {}

---Add all the sciences required at this stage
---@param tech data.TechnologyPrototype
---@return boolean
function Public.add_required_sciences(tech)
    -- Check if the autoadd is enabled
    if tech.nobelium_science == nil or tech.nobelium_science.add_minimum == nil then
        return false
    end

    local sciences = science.get_all_science_packs();
    local tech_stage = tech.nobelium_science.add_minimum;
    local output = false

    -- Add all the sciences missing
    for _, science in pairs(sciences) do
        -- Check if the science pack cannot be auto added
        if science.nobelium_science ~= nil and science.nobelium_science.ignore_autoadd then
            goto continue
        end

        --log(tech.name .. '    ' .. science.name)

        local science_stage

        if science.nobelium_science == nil or science.nobelium_science.progress_stage == nil then
            science_stage = constants.science_stages.pre_nobelium
        else
            science_stage = science.nobelium_science.progress_stage
        end
        --log(science.name .. " is " .. science_stage)

        -- Is the tech post promethium and the science pre promethium? Also, it it's promethium, add it
        if tech_stage == constants.science_stages.post_promethium and (science_stage == constants.science_stages.pre_promethium or science.name == "promethium-science-pack") then
            -- Then we add
            if technology.add_science_to_tech_if_not_set(tech, science.name, 1) then
                log("[nobelium-science] Added 1 `" .. science.name .. "` to `" .. tech.name .. "`")
                output = true
            end
            goto continue
        end

        -- Is the tech post nobelium and the science pre-nobelium or pre-promethium?
        if tech_stage == constants.science_stages.post_nobelium
            and (
                science_stage == constants.science_stages.pre_promethium or
                science_stage == constants.science_stages.pre_nobelium
            ) then
            -- Then we add
            if technology.add_science_to_tech_if_not_set(tech, science.name, 1) then
                log("[nobelium-science] Added 1 `" .. science.name .. "` to `" .. tech.name .. "`")
                output = true
            end
            goto continue
        end

        ::continue::
    end

    return output
end

function Public.add_all_required_sciences()
    for _, tech in pairs(data.raw["technology"]) do
        Public.add_required_sciences(tech)
    end
end

---Set the technology to use nobelium if needed
---@param tech data.TechnologyPrototype
---@return boolean
function Public.set_nobelium_requirement(tech)
    -- Does it require promethium?
    if not technology.requires_promethium_science(tech) then
        return false
    end

    -- Recipe require promethium. Does it actually require nobelium?
    if not technology.require_pre_nobelium_pack(tech) then
        return false
    end

    -- Ok! So let's fix it.
    log("[nobelium-science] Fixing tech `" .. tech.name .. "`")

    -- Add Nobelium science to the cost. This should be the same as promethium.
    technology.add_science_to_tech(tech, "nobelium-science-pack", technology.get_promethium_cost(tech) or 0)

    -- Replace "promethium-science-pack" requirement for nobelium...
    util.remove_from_list(tech.prerequisites, "promethium-science-pack")
    table.insert(tech.prerequisites, "nobelium-science-pack")


    return true
end

function Public.reset_promethium_science()
    promethium_tech = data.raw["technology"]["promethium-science-pack"]
    if promethium_tech then
        promethium_tech.prerequisites = { "biter-egg-handling", "fusion-reactor" }
        promethium_tech.unit = {
            count_formula = "2000",
            ingredients =
            {
                { "automation-science-pack",      1 },
                { "logistic-science-pack",        1 },
                { "chemical-science-pack",        1 },
                { "production-science-pack",      1 },
                { "utility-science-pack",         1 },
                { "space-science-pack",           1 },
                { "metallurgic-science-pack",     1 },
                { "agricultural-science-pack",    1 },
                { "electromagnetic-science-pack", 1 },
                { "cryogenic-science-pack",       1 }
            },
            time = 60
        }
    end
end

return Public
