local science = require("lib.science_pack")

science.set_vanilla_packs_nobelium_data()

-- === Testing data ===
-- require("testing.rocketry")
-- require("testing.dinosaur")

-- local tech = table.deepcopy(data.raw["technology"]["automation"])
-- tech.name = "pre-promethium"
-- tech.nobelium_science = {
--     add_minimum = "pre-promethium"
-- }
-- data:extend({ tech })

-- local tech = table.deepcopy(data.raw["technology"]["automation"])
-- tech.name = "post-promethium"
-- tech.nobelium_science = {
--     add_minimum = "post-promethium"
-- }
-- data:extend({tech})


-- local tech = table.deepcopy(data.raw["technology"]["automation"])
-- tech.name = "post-nobelium"
-- tech.nobelium_science = {
--     add_minimum = "post-nobelium"
-- }
-- data:extend({ tech })
