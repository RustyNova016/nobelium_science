# Rocket science pack

In this exemple, a new science pack is added before space science. 

```lua
data::extend({
    {
        type = "tool",
        name = "rocketry-science-pack",
        icon = "some-icon.png

        nobelium_science = {
            -- The player is required to use this science pack before even getting to space, 
            --so it's definitly not optional for promethium
            progress_stage = "pre-promethium"

            -- We want other mod to force our science pack too, so we don't block the autoadd. 
            -- This is actually the default value, but being explicit helps convey the intent!
            ignore_autoadd = false
        }
    },

    -- Let's create a technology that require promethium 
    {
        type = "technology",
        name = "rocket-booster-fuel-productivity",

        -- Technology data... 

        nobelium_science = {
            -- Our tech doesn't need external science packs, so we can just unlock it with prometheum
            add_minimum = "post-promethium"
        }
    },
})
```