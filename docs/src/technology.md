# Technology

To change properties of your technology, you can add a table on your technology declaration

```lua
{
    type = "technology",
    name = "rocket-booster",
    -- Technology stuff ... 

    nobelium_science = {
        -- Nobelium stuff ...
    }
}
```

# Fields

## `add_minimum: string?`

This automatically add missing science packs for the stage of your technology. This takes in a specific string value:
- `"post-promethium"`: This will add all the vanilla space age science packs + all the science packs that are set as `"pre-promethium"`.
- `"post-nobelium"`: This will add the science packs from `"post-promethium"` + all the science packs that are set as `"pre-nobelium"` (This include the ones with `nobelium_override` not set).

Sadly, the standard factorio API doesn't have a clear way to say "This is a science pack". So modded science packs cannot be easily recognized. 

This means only science packs that either:
- Have `nobelium_science.progress_stage` set
- Are able to be put in the base vanilla lab

... can be autoadded