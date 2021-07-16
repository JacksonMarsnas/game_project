Effects = Object:extend()

function Effects:new()
    self.all_effects = {
        {
            name = "None",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect_function = function() end,
            description = "Effect: None",
            heavy_description = "Has no effect"
        }
    }

    self:permanent_effects()
end

function Effects:melee_only_effects()
    self.all_effects = {
        {
            name = "None",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect_function = function() end,
            description = "Effect: None",
            heavy_description = "Has no effect"
        }, {
            name = "Regenerating",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() 
                player.health = player.health + math.floor(player.holy / 100 * 20)
                if player.health > player.vitality * 10 then
                    player.health = player.vitality * 10
                end
            end,
            description = "Effect: HP+",
            heavy_description = "Grant your weapon weak healing\nproperties. While this blessing is small, it is\nstill a gift in battle. Scaling: low holy"
        }, {
            name = "Inverted",
            effect_function = function(enemy) 
                if self:insert_debuff(2, function(enemy) enemy.defense = enemy.base_defense end, "Inverted", enemy, function() end) == false then
                    enemy.base_defense = enemy.defense
                    enemy.defense = -1 * enemy.defense
                end
            end,
            description = "Effect: -DEF",
            heavy_description = "An obscure finish used on the blade of\na weapon of unknown origin. Inverts the defenses\nof the target for one turn."
        }, {
            name = "Paralyzing",
            effect_function = function(enemy) 
                if self:insert_debuff(3, function(enemy) 
                    enemy.agility = enemy.base_agility
                    enemy.blocking = enemy.base_blocking
                end, "Paralyzed", enemy, function() end) == false then
                    enemy.base_agility = enemy.agility
                    enemy.base_blocking = enemy.blocking
                    enemy.blocking = enemy.blocking / 2
                    enemy.agility = enemy.agility / 2
                end
            end,
            description = "Effect: -DEF",
            heavy_description = "Adds a slight electric power to your\nweapon, discharging on impact. Causes the\nattacking and blocking of foes to be lowered for\ntwo turns. Particularly effective against foes who\nare difficult to dodge or attack."
        }
    }
end

function Effects:ranged_only_effects()
    self.all_effects = {
        {
            name = "None",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect_function = function() end,
            description = "Effect: None",
            heavy_description = "Has no effect"
        }, {
            name = "Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() 
                player.health = player.health + math.floor(player.holy / 100 * 20)
                if player.health > player.vitality * 10 then
                    player.health = player.vitality * 10
                end
            end,
            description = "Effect: HP+",
            heavy_description = "Heal HP equal to 20% of the user's holyness"
        }, {
            name = "Damage Boost",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function(enemy) 
                enemy.health = 0
            end,
            description = "Effect: Slightly heal HP",
            heavy_description = "Heal HP equal to 20% of the user's holyness"
        }
    }
end

function Effects:buff_only_effects()
    self.all_effects = {
        {
            name = "None",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect_function = function() end,
            description = "Effect: None",
            heavy_description = "Has no effect"
        }, {
            name = "Great Strength",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function()
                player.base_strength = player.strength
                player.strength = 500
                self:insert_buff(3, function() player.strength = player.base_strength end, "Greate Strength", "STR")
            end,
            description = "Effect: Increase strength",
            heavy_description = "Increase the wielder's strength by 50"
        }, {
            name = "Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() 
                player.health = player.health + math.floor(player.holy / 100 * 20)
                if player.health > player.vitality * 10 then
                    player.health = player.vitality * 10
                end
            end,
            description = "Effect: HP+",
            heavy_description = "Heal HP equal to 20% of the user's holyness"
        }
    }
end

function Effects:debuff_only_effects()
    self.all_effects = {
        {
            name = "None",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 0
            },
            effect_function = function() end,
            description = "Effect: None",
            heavy_description = "Has no effect"
        }, {
            name = "Wither",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 1,
                holy = 1
            },
            effect_function = function(enemy) 
                if self:insert_debuff(3, function(enemy) enemy.defense = enemy.base_defense end, "Wither", enemy, function() end) == false then
                    enemy.base_defense = enemy.defense
                    enemy.defense = -100
                end
            end,
            description = "Effect: Increase strength",
            heavy_description = "Increase the wielder's strength by 50"
        }
    }
end

function Effects:permanent_effects()
    self.permanent_effects = {
        {
            name = "Inner Arcanum",
            effect_function = function()
                if self:insert_buff(5, 
                function() 
                    player.resilience = player.base_resilience
                    player.damage_multiplier = 1
                end, "Inner Arcanum", "DMG-") == false then
                    player.damage_multiplier = 0.5
                    player.resilience = player.resilience - 0.5
                end
            end,
            description = "DEF-"
        }, {
            name = "Plow Through",
            effect_function = function()
                if math.random(1, 3) == 1 then
                    player.health = player.health - player.vitality
                    if player.health - player.stamina <= 0 then
                        player.health = player.stamina + 1
                    end
                end
            end,
            description = "Effect: HP-"
        }, {
            name = "Ice Ray",
            effect_function = function(enemy) 
                if self:insert_debuff(3, function(enemy) 
                    enemy.agility = enemy.base_agility
                    enemy.blocking = enemy.base_blocking
                end, "Ice Ray", enemy, function() end) == false then
                    enemy.base_blocking = enemy.blocking
                    enemy.blocking = enemy.blocking - (0.5 * player.arcane) - (0.25 * player.skill)
                    enemy.base_agility = enemy.agility
                    enemy.agility = enemy.agility - (0.5 * player.arcane) - (0.25 * player.skill)
                end
            end,
            description = "Effect: AGL-, BLK-",
        }, {
            name = "Struggle",
            effect_function = function(enemy) 
                enemy.health = enemy.health - ((player.health - player.stamina) / 2)
                player.stamina = player.health - 1
            end,
            description = "Effect: STM+",
        }, {
            name = "Full Moon Sword",
            effect_function = function(enemy) 
                if math.random(5) == 5 then
                    self:insert_debuff(4, function(enemy) end, "Great Blade of Moonlight", enemy, function() 
                        enemy.health = enemy.health - math.floor(enemy.max_health / 10)
                        if enemy.health <= 0 then
                            enemy.animation_state = "dead"
                            enemy.health = 0
                            occupation_map[enemy.current_y][enemy.current_x] = false
                            player.experience = player.experience + enemy["exp_drop"]
                        end
                    end)
                end
            end,
            description = "Effect: %HP-",
        }, {
            name = "Hidden Dagger",
            effect_function = function(enemy) 
                self:insert_debuff(10, function(enemy) end, "Hidden Dagger", enemy, function() 
                    enemy.health = enemy.health - math.floor(enemy.max_health / 15)
                    if enemy.health <= 0 then
                        enemy.animation_state = "dead"
                        enemy.health = 0
                        occupation_map[enemy.current_y][enemy.current_x] = false
                        player.experience = player.experience + enemy["exp_drop"]
                    end
                end)
            end,
            description = "Effect: HP-",
        }, {
            name = "Holy Lightning",
            effect_function = function(enemy) 
                if 3 == 3 then
                    if self:insert_debuff(3 + math.floor(player.holy / 15), 
                    function(enemy) 
                        enemy.agility = enemy.base_agility
                        enemy.blocking = enemy.base_blocking
                    end, 
                    "Holy Lightning", enemy, function() end) == true then
                        enemy.base_agility = enemy.agility
                        enemy.base_blocking = enemy.blocking
                        enemy.agility = enemy.agility - (player.holy * 0.5)
                        enemy.blocking = enemy.blocking - (player.holy * 0.5)
                    end
                end
            end,
            description = "Effect: HP-",
        }
    }
end

function Effects:insert_buff(duration, revert, name, code, recurring_buff)
    local buff_used = false
    for index, buff in ipairs(player.active_buffs) do
        if name == buff["name"] then
            buff_used = true
        end
    end
    if buff_used == false then
        table.insert(player.active_buffs, {
            duration = duration,
            revert = revert,
            name = name,
            code = code,
            recurring_buff = recurring_buff
        })
        return false
    end
    return true
end

function Effects:insert_debuff(duration, revert, name, enemy, recurring_buff)
    local buff_used = false
    for index, buff in ipairs(enemy.active_buffs) do
        if name == buff["name"] then
            buff_used = true
        end
    end
    
    if buff_used == false then
        table.insert(enemy.active_buffs, {
            duration = duration,
            revert = revert,
            recurring_buff = recurring_buff,
            name = name
        })
        return false
    end
    return true
end