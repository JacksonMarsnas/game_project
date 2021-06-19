Moves = Object:extend()

function Moves:new()
    self:create_buffs()

    self.all_moves = {
        {
            name = "Strength Move",
            type = "Attack",
            base_damage = 20,
            stamina = 10,
            slots = 1,
            scaling = {
                strength = 0.5,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect = {effects.all_effects[1]},
            description = "An attack that scales well with the wielder's strength"
        }, {
            name = "Skill Move",
            type = "Attack",
            base_damage = 20,
            stamina = 30,
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0.5,
                arcane = 0,
                holy = 0
            },
            effect = {effects.all_effects[1]},
            description = "An attack that scales well with the wielder's skill"
        }, {
            name = "Arcane Move",
            type = "Attack",
            base_damage = 20,
            stamina = 30,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0.5,
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
            base_damage = 20,
            stamina = 30,
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0.5
            },
            effect = {
                effects.all_effects[1]
            },
            description = "An attack that scales well with the wielder's holyness"
        }, {
            name = "Hybrid Move",
            type = "Attack",
            base_damage = 15,
            stamina = 30,
            slots = 1,
            scaling = {
                strength = 0.3,
                skill = 0.3,
                arcane = 0,
                holy = 0
            },
            effect = {
                effects.all_effects[1]
            },
            description = "An attack that scales somewhat with the wielder's strength and skill"
        }, {
            name = "Buffy McBuffFace",
            type = "Buff",
            base_buff = self.buffs["bufface"],
            stamina = 300,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately based on their holyness"
        }, {
            name = "Skill Buff",
            type = "Buff",
            base_buff = self.buffs["skill_buff"],
            stamina = 0,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            description = "A passive technique that heals the user moderately based on their holyness"
        }, {
            name = "Ranged Move",
            type = "Ranged",
            base_damage = 15,
            stamina = 30,
            slots = 1,
            range = 2,
            scaling = {
                strength = 0.3,
                skill = 0.3,
                arcane = 0,
                holy = 0
            },
            effect = {
                effects.all_effects[1]
            },
            description = "An attack that scales somewhat with the wielder's strength and skill"
        },
    }
end

function Moves:create_buffs()
    self.buffs = {
        bufface = {
            name = "bufface",
            code = "STR",
            duration = 3,
            buff = function()
                player.base_strength = player.strength
                player.strength = player.strength * 2
            end,
            revert = function()
                player.strength = player.base_strength
            end
        }, skill_buff = {
            name = "skill buff",
            code = "SKL",
            duration = 3,
            buff = function()
                player.base_skill = player.skill
                player.skill = 50
            end,
            revert = function()
                player.skill = player.base_skill
            end
        }
    }
end