# Api

Here's some apis you can use to manually run the controls. This is useful if you do things after Nobelium's data-final-fixes is run

## `set_nobelium_requirement(tech: data.TechnologyPrototype)`

If the provided technology requires promethium, and a science pack that is not required for promethium, then it will set the tech's requirements on Nobelium.

## `add_required_sciences(tech: data.TechnologyPrototype)`

Add the required science packs to your technology based on `tech.nobelium_science.add_minimum`