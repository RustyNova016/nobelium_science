A space age compatibility layer, dealing with science pack requirements between mods

## Do I need it?
If you have a mod that add a science pack you probably need it.

## What does it do?
This force promethium science to require only science packs from the vanilla space age, and add a new science, Nobelium, that requires science from all modded planets

## But why?
PlanetLib deprecated their compatibility util that makes all the science packs capable to be put in the vanilla labs required for technologies requiring promethium.
For exemple, it would make Maraxis's science pack required for the infinite science productivity tech

However, it came at a conflict for mods that adds post promethium science, where it would add their science as requirement for promethium science, deadlocking them. Even more that those mods are tuned for after vanilla planets, not for after all the planets in the mod browser.

So a solution is to split both concerns in two science packs. Classic promethium and the new Nobelium. Nobelium is given for free alongside promethium, making them completly identical gameplay wise (just need more cargo space)

## As a modder, what should I do?

By default, your science will automatically be setup to be ignored for promethium tech. However you may want to tweak your settings, and autogenerate recipe requirements 

You can read more in the [docs](https://rustynova016.github.io/nobelium_science/)