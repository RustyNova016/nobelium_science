local tech_fixer = require("lib.tech_fixer")

log("[nobelium-science] Starting up")

promethium_tech = data.raw["technology"]["promethium-science-pack"]
if promethium_tech == nil then
    log("[nobelium-science] Promethium science pack technology not found. Exiting")
    return
end

-- tech_fixer.reset_promethium_science()

for _, tech in pairs(data.raw["technology"]) do
    tech_fixer.add_required_sciences(tech)

    if tech_fixer.set_nobelium_requirement(tech) then
        -- We have set a tech to use nobelium. Let's create it
        require("prototypes")
    end
end
