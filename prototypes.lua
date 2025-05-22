local item_sounds = require("__base__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local science = require("lib.science_pack")
local recipe = require("lib.recipes")

local tech_requirements = {}

log("[nobelium-science] Adding nobelium science")

-- Search through all science packs to try and find their technologies
-- TODO: add a field in tech to set it as Prometheum tech
for _, pack in pairs(science.get_all_science_packs()) do
    if data.raw["technology"][pack.name] ~= nil then
        table.insert(tech_requirements, pack.name)
    end
end

data:extend({
    {
        type = "tool",
        name = "nobelium-science-pack",
        localised_description = { "item-description.science-pack" },
        icon = "__nobelium-science__/graphics/nobelium-science-pack_64.png",
        subgroup = "science-pack",
        color_hint = { text = "I" },
        order = "M",
        inventory_move_sound = item_sounds.science_inventory_move,
        pick_sound = item_sounds.science_inventory_pickup,
        drop_sound = item_sounds.science_inventory_move,
        stack_size = 200,
        default_import_location = "aquilo",
        weight = 1 * kg,
        durability = 1,
        durability_description_key = "description.science-pack-remaining-amount-key",
        factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
        durability_description_value = "description.science-pack-remaining-amount-value",
        random_tint_color = item_tints.bluish_science
    },

    {
        type = "technology",
        name = "nobelium-science-pack",
        icon = "__nobelium-science__/graphics/nobelium-science-pack_256.png",
        icon_size = 256,
        essential = true,
        effects =
        {
            {
                type = "unlock-recipe",
                recipe = "nobelium-science-pack"
            },
        },
        prerequisites = tech_requirements,
        research_trigger =
        {
            type = "craft-item",
            item = "promethium-science-pack"
        }
    },
})

table.insert(data.raw["lab"]["lab"].inputs, "nobelium-science-pack")

local science_recipe = table.deepcopy(data.raw["recipe"]["promethium-science-pack"])
science_recipe.name = "nobelium-science-pack"
science_recipe.main_product = "nobelium-science-pack"
recipe.add_result(science_recipe,
    {
        type = "item",
        name = "nobelium-science-pack",
        amount = recipe.get_result(science_recipe, "item", "promethium-science-pack").amount
    })

---@diagnostic disable-next-line: assign-type-mismatch
data:extend({ science_recipe })
