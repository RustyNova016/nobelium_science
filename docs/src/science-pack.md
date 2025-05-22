# Science pack

To change properties of your science pack, you can add a table on your science pack declaration

```lua
{
    type = "tool",
    name = "rocketry-science-pack",
    -- Science pack stuff ... 

    nobelium_science = {
        -- Nobelium stuff ...
    }
}
```

# Fields

## `progress_stage: string`

default: `"pre-nobelium"`

This govern when your science packs comes into play. This takes specific values

- `"pre-promethium"`: Your science pack is **required** for promethium science. Use this if you gate the vanilla science packs with it.
- `"pre-nobelium"`: Your science pack is **not required** for promethium science. It's the default behaviour
- `"post-promethium"`: Your science pack **require** promethium science. If you need to expend deeper in the promethium science pack, this is what you need

## `ignore_autoadd: boolean`

default: `false`

Prevent this science pack to be auto added to technologies requesting all science packs of a stage