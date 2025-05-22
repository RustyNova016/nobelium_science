local utils = require("lib.utils")

local Public = {}

function Public.add_test_data(name)
    data:extend({
        {
            type = "tool",
            name = name .. "-science-pack",
            localised_description = { "item-description.science-pack" },
            icon = "__nobelium-science__/graphics/nobelium-science-pack_64.png",
            subgroup = "science-pack",
            color_hint = { text = "I" },
            order = "M",

            stack_size = 200,
            default_import_location = "aquilo",
            weight = 1 * kg,
            durability = 1,
            durability_description_key = "description.science-pack-remaining-amount-key",
            factoriopedia_durability_description_key = "description.factoriopedia-science-pack-remaining-amount-key",
            durability_description_value = "description.science-pack-remaining-amount-value",

            nobelium_science = {
                -- The player is required to use this science pack before even getting to space,
                --so it's definitly not optional for promethium
                progress_stage = "pre-promethium",

                -- We want other mod to force our science pack too, so we don't block the autoadd.
                -- This is actually the default value, but being explicit helps convey the intent!
                ignore_autoadd = false
            }
        },

        {
            type = "technology",
            name = name .. "-science-pack",
            icon = "__nobelium-science__/graphics/nobelium-science-pack_256.png",
            icon_size = 256,
            essential = true,
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = name .. "-science-pack"
                },
            },
            prerequisites = { "automation-science-pack" },
            research_trigger =
            {
                type = "craft-item",
                item = "automation-science-pack"
            }
        },
    })

    local recipe = table.deepcopy(data.raw["recipe"]["automation-science-pack"])
    recipe.name = name .. "-science-pack"
    recipe.results = { { type = "item", name = name .. "-science-pack", amount = 1 } }
    data:extend({ recipe })

    table.insert(data.raw["lab"]["lab"].inputs, name .. "-science-pack")
end

return Public
