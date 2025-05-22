local constants = require("lib.constants")
local utils = require("lib.utils")
local Public = {}

--- Return true if the science is set as `"pre-nobelium"`
--- @param science data.ToolPrototype
--- @return boolean
function Public.is_pre_nobelium(science)
    return science.nobelium_science == nil
        or science.nobelium_science.progress_stage == nil
        or science.nobelium_science.progress_stage == constants.science_stages.pre_nobelium
end

---Add `nobelium_override` to the vanilla packs
function Public.set_vanilla_packs_nobelium_data()
    for _, value in pairs(constants.vanilla_science) do
        local pack = data.raw["tool"][value]

        if pack ~= nil and pack.name ~= "promethium-science-pack" then
            ---@diagnostic disable-next-line: inject-field
            pack.nobelium_science = {
                progress_stage = "pre-promethium",
                ignore_autoadd = false
            }
        end
    end
end

---Return an array of all the science packs that exists
---@return data.ToolPrototype[]
function Public.get_all_science_packs()
    local sciences = {}

    -- First try to get all the science that have the `nobelium_science` field
    for _, science in pairs(data.raw["tool"]) do
        ---@diagnostic disable-next-line: undefined-field
        if science.nobelium_science ~= nil then
            table.insert(sciences, science)
        end
    end

    -- Then add the sciences from the lab
    for _, value in pairs(data.raw["lab"]["lab"].inputs) do
        if not utils.array_contain(sciences, data.raw["tool"][value]) then
            table.insert(sciences, data.raw["tool"][value])
        end
    end

    return sciences
end

return Public
