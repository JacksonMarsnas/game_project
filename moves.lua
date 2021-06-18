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
            effect = {effects.all_effects[1]}
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
            }
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
            }
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
            }
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
            }
        }
    }
end