## Do I need it?
If you have a mod that add a science pack you probably need it.

## What does it do?
This force promethium science to require only science packs from the vanilla space age, and add a new science, Nobelium, that requires science from all modded planets

## But why?
PlanetLib removed their compatibility util that makes all the science packs capable to be put in the vanilla labs required for technologies requiring promethium.
For exemple, it would make Maraxis's science pack required for the infinite science productivity tech

However, it came at a conflict for mods that adds post promethium science, where it would add their science as requirement for promethium science, deadlocking them. Even more that those mods are tuned for after vanilla planets, not for after all the planets in the mod browser.

So a solution is to split both concerns in two science packs. Classic promethium and the new Nobelium. Nobelium is given for free alongside promethium, making them completly identical gameplay wise (just need more cargo space)

## As a modder, what should I do?

Nothing! Your science will automatically be setup to be ignored for promethium tech. However you can explicitly control how your science is used with some extra values (It's actually recomended to set the values nonetheless so the intent is clear)

### Science pack prototype (`data.ToolPrototype`)

You can add the field `nobelium_override` to customize which stage your science pack is used. This takes in a specific string value:
- `"pre-promethium"`: Your science pack is **required** for promethium science. Use this if you gate the vanilla science packs with it.
- `"pre-nobelium"`: Your science pack is **not required** for promethium science. It's the default behaviour
- `"post-promethium"`: Your science pack **require** promethium science. If you need to expend deeper in the promethium science pack, this is what you need

Exemples:
"Rocketry science pack": This is the precusor to unlock space science. So this must be set to `"pre-promethium"`

"Dinosaur science pack": This is the science pack of the optional dinosaur planet Rexaura. So this must be set to `"pre-nobelium"`

"Intergalatical science pack": This is unlocked after some promethium researches. So this must be set to `"post-promethium"`

### Technology prototype

You can add the field `nobelium_add_minimums` to your technology to automatically add all the science packs that are required at the stage. This takes in a specific string value:
- `"post-promethium"`: This will add all the vanilla space age science packs + all the science packs that are set as `"pre-promethium"`.
- `"post-nobelium"`: This will add the science packs from `"post-promethium"` + all the science packs that are set as `"pre-nobelium"` (This include the ones with `nobelium_override` not set).


Sadly, the standard factorio API doesn't have a clear way to say "This is a science pack". So modded science packs cannot be easily recognized. So modded science packs gets added only when they meet the criteria above **AND**:
- Have `nobelium_override` set
**or**
- Are able to be put in the base vanilla lab (Biolab gets ignored)