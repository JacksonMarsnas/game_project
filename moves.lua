Moves = Object:extend()

function Moves:new()
    self.all_moves = {
        {
            name = "Strength Move",
            type = "Attack",
            slots = 1,
            scaling = {
                strength = 1,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect = {effects.all_effects[1]},
            description = "An attack that scales well with the wielder's strength"
        }, {
            name = "Skill Move",
            type = "Attack",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 1,
                arcane = 0,
                holy = 0
            },
            effect = {effects.all_effects[1]},
            description = "An attack that scales well with the wielder's skill"
        }, {
            name = "Arcane Move",
            type = "Attack",
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 1,
                holy = 0
            },
            effect = {
                effects.all_effects[1],
                effects.all_effects[1]
            },
            description = "An attack that scales well with the wielder's arcane"
        }, {
            name = "Holy Move",
            type = "Attack",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "An attack that scales well with the wielder's holyness"
        }, {
            name = "Hybrid Move",
            type = "Attack",
            slots = 1,
            scaling = {
                strength = 1,
                skill = 1,
                arcane = 0,
                holy = 0
            },
            effect = {
                effects.all_effects[1]
            },
            description = "An attack that scales somewhat with the wielder's strength and skill"
        }, {
            name = "Heal",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately based on their holyness"
        }, {
            name = "Filler",
            type = "Attack",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "Filler"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }, {
            name = "Filler",
            type = "Buff",
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately\nbased on their holyness"
        }
    }
end