Moves = Object:extend()

function Moves:new()
    self:create_buffs()
    self:create_debuffs()

    self.all_moves = {
        {
            name = "Slam",
            type = "Attack",
            base_damage = 10,
            stamina = 20,
            slots = 2,
            scaling = {
                strength = 0.4,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "Slam the target with a blunt weapon. Simple, yet effective.\nScalng: Medium strength"
        }, {
            name = "Slash",
            type = "Attack",
            base_damage = 10,
            stamina = 20,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0.4,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "Slash the target with a small blade. Despite its simplicity, this technique is in the arsenal of all skilled warriors who use a blade.\nScaling: Medium skill"
        }, {
            name = "Arcane Weapon",
            type = "Attack",
            base_damage = 10,
            stamina = 20,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0.4,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "A technique which conjures a hammer made from magic compounds. Such weapons gain strength from the bearer's arcane knowledge rather than their physical ability.\nScaling: Medium arcane"
        }, {
            name = "Blessed Hammer",
            type = "Attack",
            base_damage = 10,
            stamina = 20,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0.4
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "Swing at the foe with a hammer blessed in holy ritual. Such a weapon improves in effectiveness if its wielder has a high holy devotion; a sign of god's blessing.\nScaling: Medium holy"
        }, {
            name = "Plow Through",
            type = "Attack",
            base_damage = 20,
            stamina = 50,
            slots = 1,
            scaling = {
                strength = 1.5,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 0.5,
                normal_multiplier = 1,
                weak_multiplier = 1.25,
                speed_multiplier = 0.8
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {effects.permanent_effects[2]},
            locked = false,
            description = "A technique that uses the full weight of the body to smash into the target. Exceptionally powerful indeed, yet it often injures the user and leaves them completely exhausted.\nScaling: High strength"
        }, {
            name = "Full Moon Sword",
            type = "Attack",
            base_damage = 15,
            stamina = 40,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0.35,
                holy = 0.15
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1.1,
                weak_multiplier = 1.1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {effects.permanent_effects[5]},
            locked = false,
            description = "Conjure a blade of holy moonlight. This technique draws from both the holy faith of the user as well as their arcane knowledge of the elements. Has a chance to inflict an HP draining effect on the target.\nScaling: Medium arcane, low holy"
        }, {
            name = "Vital Stab",
            type = "Attack",
            base_damage = 10,
            stamina = 20,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0.35,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1.5,
                normal_multiplier = 1,
                weak_multiplier = 0.5,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "A very simple technique. Stab the target with a blade. While this technique does not deal very much damage on its own, it has a much larger window for critical hits compared to most techniques.\nScaling: Medium skill"
        }, {
            name = "Hidden Dagger",
            type = "Attack",
            base_damage = 5,
            stamina = 15,
            slots = 2,
            scaling = {
                strength = 0,
                skill = 0.1,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1.1,
                normal_multiplier = 0.75,
                weak_multiplier = 0.5,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1], effects.all_effects[1]},
            permanent_effects = {effects.permanent_effects[6]},
            locked = false,
            description = "Pull a hidden dagger coated with deadly toxins from your armour. While it does poor damage, the target is left poisoned for a very long time, dealing great damage. Techniques like this are prized by criminals.\nScaling: Low skill"
        }, {
            name = "Ice Ray",
            type = "Ranged",
            base_damage = 5,
            stamina = 20,
            slots = 2,
            range = 2,
            scaling = {
                strength = 0,
                skill = 0.2,
                arcane = 0.35,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1.2,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {
                effects.all_effects[1], effects.all_effects[1]
            },
            permanent_effects = {
                effects.permanent_effects[3]
            },
            locked = false,
            description = "A spell used by northern territories. Most lands do not experience freezing, so a weapon of ice can catch many off guard. While rather weak, it temporarily makes it easier to land attacks on the target and to dodge theirs as well.\nScaling: medium arcane, low skill"
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
            locked = true,
            description = "Discover the latent arcane power within oneself, directing it outward. This technique is extremely powerful, but has harmful effects for the user.\nScaling: High Arcane. Low holy, skill"
        }, {
            name = "Struggle",
            type = "Ranged",
            base_damage = 0,
            stamina = 0,
            slots = 0,
            range = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 0.5,
                normal_multiplier = 0.75,
                weak_multiplier = 0.75,
                speed_multiplier = 1
            },
            effect = {},
            permanent_effects = {
                effects.permanent_effects[4]
            },
            locked = true,
            description = "An extremely powerful yet dangerous spell. The damage of this spell is equal to half of the player's remaining health. However, this spell is exhausting to use, using enough stamina to leave the caster on the brink of death.\nScaling: none"
        }, {
            name = "Shortbow",
            type = "Ranged",
            base_damage = 10,
            stamina = 35,
            slots = 1,
            range = 2,
            scaling = {
                strength = 0,
                skill = 0.25,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 1.1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 0.95
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "Use a shortbow to shoot the enemy. Not spectacular, but still effective.\nScaling: Medium skill"
        }, {
            name = "Greatbow",
            type = "Ranged",
            base_damage = 15,
            stamina = 50,
            slots = 1,
            range = 2,
            scaling = {
                strength = 0.3,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            multipliers = {
                crit_multiplier = 0.9,
                normal_multiplier = 1,
                weak_multiplier = 1.1,
                speed_multiplier = 1.05
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {},
            locked = false,
            description = "Shoot the enemy with a greatbow using massive arrows. Such a large bow requires great strength to use, but is effective if used properly.\nScaling: Medium strength"
        }, {
            name = "Holy Lightning",
            type = "Ranged",
            base_damage = 10,
            stamina = 40,
            slots = 1,
            range = 2,
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0.3
            },
            multipliers = {
                crit_multiplier = 1,
                normal_multiplier = 1,
                weak_multiplier = 1,
                speed_multiplier = 1
            },
            effect = {effects.all_effects[1]},
            permanent_effects = {effects.permanent_effects[7]},
            locked = false,
            description = "Call on god to strike the foe with holy lightning. This spell has a chance to stun the target for a short time, making them easier to block and land attacks on.\nScaling: Medium holy"
        }, {
            name = "Fast Reflexes",
            type = "Buff",
            base_buff = self.buffs["fast_reflexes"],
            stamina = 40,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = true,
            description = "A simple spell that quickens the reflexes. Makes attacking and dodging easier for a short time.\nScaling: low strength, skill, arcane, holy"
        }, {
            name = "Rock Steady Stance",
            type = "Buff",
            base_buff = self.buffs["rock_steady_stance"],
            stamina = 50,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = true,
            description = "Assume a stance to gain stone-like poise and posture. Such a stance drastically improves the defense and stamina recovery of the user, but can only be held for a very short time.\nScaling: low holy, strength"
        }, {
            name = "Bolster",
            type = "Buff",
            base_buff = self.buffs["bolster"],
            stamina = 40,
            slots = 2,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = false,
            description = "A simple spell that bolsters defenses. While not very exciting, it has low cost and a long duration, making it quite a favourable spell.\nScaling: Low holy"
        }, {
            name = "Combat Stance",
            type = "Buff",
            base_buff = self.buffs["combat_stance"],
            stamina = 40,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = false,
            description = "Assume a combat stance to greatly increase combat related stats for one turn. Stance uses a large amount of stamina, but is offset with a drastic boost in defense.\nScaling: High skill, low strength"
        }, {
            name = "Enchant Weapon",
            type = "Buff",
            base_buff = self.buffs["enchant_weapon"],
            stamina = 30,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = false,
            description = "Cast a spell to reinforce your techniques with arcane power for a short time. The duration and effectiveness is based on the caster's knowledge of the arcane.\nScaling: Medium arcane"
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
            locked = true,
            description = "A spell that does no immediate harm to the target, instead leaving them with a harsh burn to the skin. The target will suffer slight damage over time, as well as a decrease in damage.\nScaling: Low holy, arcane"
        }, {
            name = "Stun Seed",
            type = "Debuff",
            base_buff = self.debuffs["stun_seed"],
            range = 2,
            stamina = 25,
            slots = 1,
            effect = {
                effects.all_effects[1]
            },
            permanent_effects = {},
            locked = false,
            description = "Throw a handful of harmful plant seeds in the face of the opponent. Stun seeds leave the target shocked, greatly hindering their ability to attack and block. Such techniques are disrespectful, yet fun to use.\nScaling: Medium holy, arcane"
        }
    }
end

function Moves:create_buffs()
    self.buffs = {
        bufface = {
            code = "STR",
            duration = function()
                return 3
            end,
            slots = 1,
            buff = function()
                player.strength = player.strength * 2
            end,
            recurring_buff = function() end,
            revert = function()
                player.strength = player.base_strength
            end
        }, fast_reflexes = {
            code = "FRL",
            duration = function()
                return (0.1 * player.strength) + (0.1 * player.skill) + (0.1 * player.arcane) + (0.1 * player.holy)
            end,
            buff = function()
                player.agility = player.agility + (0.2 * player.strength) + (0.2 * player.skill) + (0.2 * player.arcane) + (0.2 * player.holy)
                player.stamina_recovery_speed = player.stamina_recovery_speed + (0.1 * player.strength) + (0.1 * player.skill) + (0.1 * player.arcane) + (0.1 * player.holy)
            end,
            recurring_buff = function() end,
            revert = function()
                player.agility = player.base_agility
                player.stamina_recovery_speed = player.base_stamina_recovery_speed
            end
        }, rock_steady_stance = {
            code = "RSS",
            duration = function()
                return 3 + (0.1 * player.holy) + (0.1 * player.strength)
            end,
            buff = function()
                player.resilience = player.resilience + ((0.075 * player.strength) * player.resilience) + ((0.075 * player.holy) * player.resilience)
                player.stamina_recovery_speed = player.stamina_recovery_speed + (0.5 * player.strength) + (0.5 * player.holy)
            end,
            recurring_buff = function() end,
            revert = function()
                player.resilience = player.base_resilience
                player.stamina_recovery_speed = player.base_stamina_recovery_speed
            end
        }, bolster = {
            code = "DEF",
            duration = function()
                return 3 + (0.2 * player.holy)
            end,
            buff = function()
                player.resilience = player.resilience + (0.5 * player.holy)
            end,
            recurring_buff = function() end,
            revert = function()
                player.resilience = player.base_resilience
            end
        }, combat_stance = {
            code = "STN",
            duration = function()
                return 2
            end,
            buff = function()
                player.resilience = player.resilience + (0.4 * player.skill) + (0.2 * player.strength)
                player.arcane = player.arcane + (0.4 * player.skill) + (0.2 * player.strength)
                player.holy = player.holy + (0.4 * player.skill) + (0.2 * player.strength)
                player.agility = player.agility + (0.4 * player.skill) + (0.2 * player.strength)
                player.strength = player.strength + (0.4 * player.skill) + (0.2 * player.strength)
                player.skill = player.skill + (0.4 * player.skill) + (0.2 * player.strength)
            end,
            recurring_buff = function() end,
            revert = function()
                player.resilience = player.base_resilience
                player.strength = player.base_strength
                player.skill = player.base_skill
                player.arcane = player.base_arcane
                player.holy = player.base_holy
                player.agility = player.base_agility
            end
        }, enchant_weapon = {
            code = "ENC",
            duration = function()
                return 3 + math.floor(0.1 * player.arcane)
            end,
            buff = function()
                player.holy = player.holy + (0.3 * player.arcane)
                player.strength = player.strength + (0.3 * player.arcane)
                player.skill = player.skill + (0.3 * player.arcane)
                player.arcane = player.arcane + (0.3 * player.arcane)
            end,
            recurring_buff = function() end,
            revert = function()
                player.holy = player.base_holy
                player.strength = player.base_strength
                player.skill = player.base_skill
                player.arcane = player.base_arcane
            end
        }
    }
end

function Moves:create_debuffs()
    self.debuffs = {
        debuff = {
            name = "Debuff",
            duration = function()
                return 5
            end,
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
            duration = function()
                return 2 + math.floor(0.15 * player.holy + 0.15 * player.arcane)
            end,
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
        }, stun_seed = {
            name = "Stun Seed",
            duration = function()
                return 3 + math.floor(0.1 * player.holy + 0.1 * player.arcane)
            end,
            buff = function(enemy)
                enemy.base_blocking = enemy.blocking
                enemy.blocking = enemy.blocking - (0.2 * player.arcane + 0.05 * player.holy)
                enemy.base_agility = enemy.agility
                enemy.agility = enemy.agility - (0.2 * player.holy + 0.05 * player.arcane)
            end,
            recurring_buff = function(enemy) end,
            revert = function(enemy)
                enemy.blocking = enemy.base_blocking
                enemy.agility = enemy.base_agility
            end
        }
    }
end