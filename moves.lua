Moves = Object:extend()

function Moves:new()
    self:create_buffs()
    self:create_debuffs()

    self.all_moves = {
        {
            name = "Plow Through",
            type = "Attack",
            base_damage = 20,
            stamina = 50,
            slots = 2,
            scaling = {
                strength = 1.5,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 0.5,
                normal_multiplier = 1,
                weak_multiplier = 1.5,
                speed_multiplier = 0.8
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {effects.permanent_effects[2]},
            description = "A technique that uses the full weight of the body to smash into the target. Exceptionally powerful indeed, yet it often injures the user and leaves them completely exhausted.\nScaling: High strength"
        }, {
            name = "Skill Move",
            type = "Attack",
            base_damage = 10,
            stamina = 30,
            slots = 1,
            scaling = {
                strength = 0,
                skill = 0.5,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {},
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
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {
                effects.all_effects[1],
                effects.all_effects[1]
            },
            permanent_effects = {},
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
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
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
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
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
            permanent_effects = {},
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
            permanent_effects = {},
            description = "A passive technique that heals the user moderately based on their holyness"
        }, {
            name = "Inner Arcanum",
            type = "Ranged",
            base_damage = 30,
            stamina = 50,
            slots = 1,
            range = 2,
            scaling = {
                strength = 0,
                skill = 0.2,
                arcane = 1.5,
                holy = 0.5
            },
            multipliers = {
                crit_multiplier = 1.2,
                normal_multiplier = 1.3,
                weak_multiplier = 1,
                speed_multiplier = 1.2
            },
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {
                effects.permanent_effects[1]
            },
            description = "Discover the latent arcane power within oneself, directing it outward. This technique is extremely powerful, but has harmful effects for the user.\nScaling: High Arcane. Low holy, skill"
        }, {
            name = "Debuff",
            type = "Debuff",
            base_buff = self.debuffs["debuff"],
            range = 2,
            stamina = 20,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            description = "A passive technique that heals the user moderately based on their holyness"
        }, {
            name = "Burn",
            type = "Debuff",
            base_buff = self.debuffs["burn"],
            range = 2,
            stamina = 20,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            description = "A spell that does no immediate harm to the target, instead leaving them with a harsh burn to the skin. The target will suffer slight damage over time, as well as a decrease in damage.\nScaling: Low holy, arcane"
        }
    }
end

function Moves:create_buffs()
    self.buffs = {
        bufface = {
            name = "bufface",
            code = "STR",
            duration = 3,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            buff = function()
                player.base_strength = player.strength
                player.strength = player.strength * 2
            end,
            recurring_buff = function() end,
            revert = function()
                player.strength = player.base_strength
            end
        }, skill_buff = {
            name = "skill buff",
            code = "SKL",
            duration = 3,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            buff = function()
                player.base_skill = player.skill
                player.skill = 50
            end,
            recurring_buff = function() end,
            revert = function()
                player.skill = player.base_skill
            end
        }
    }
end

function Moves:create_debuffs()
    self.debuffs = {
        debuff = {
            name = "Debuff",
            duration = 5,
            buff = function(enemy)
                enemy.base_defense = enemy.defense
                enemy.defense = enemy.defense - (0.005 * player.arcane + 0.005 * player.holy)
            end,
            recurring_buff = function() end,
            revert = function(enemy)
                enemy.defense = enemy.base_defense
            end
        }, burn = {
            name = "Burn",
            duration = 2 + math.floor(0.15 * player.holy + 0.15 * player.arcane),
            buff = function(enemy)
                enemy.base_attack_power = enemy.attack_power
                enemy.attack_power = enemy.attack_power - math.floor(0.1 + player.arcane + player.holy)
            end,
            recurring_buff = function(enemy)
                enemy.health = enemy.health - math.floor(2 + (0.05 * player.holy) + (0.05 * player.arcane))
            end,
            revert = function(enemy)
                enemy.attack_power = enemy.base_attack_power
            end
        },
    }
end