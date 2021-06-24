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
                if player.health > player.max_health then
                    player.health = player.max_health
                end
            end,
            description = "Effect: HP+",
            heavy_description = "Grant your weapon weak healing properties. While this blessing is small, it is still a gift in battle.\nScaling: low holy"
        }, {
            name = "Inverted",
            effect_function = function(enemy) 
                enemy.base_defense = enemy.defense
                enemy.defense = -1 * enemy.defense
                self:insert_debuff(3, function(enemy) enemy.defense = enemy.base_defense end, "Inverted", enemy, function() end)
            end,
            description = "Effect: -DEF",
            heavy_description = "An obscure finish used on the blade of a weapon of unknown origin. Inverts the defenses of the target for one turn."
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
                if player.health > player.max_health then
                    player.health = player.max_health
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
                if player.health > player.max_health then
                    player.health = player.max_health
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
                enemy.base_defense = enemy.defense
                enemy.defense = -100
                self:insert_debuff(3, function(enemy) enemy.defense = enemy.base_defense end, "Wither", enemy, function() end)
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
                player.damage_multiplier = 0
                player.base_defense = player.defense
                player.defense = player.defense - 0.5
                self:insert_buff(5, 
                function() 
                    player.defense = player.base_defense
                    player.damage_multiplier = 1
                end, "Inner Arcanum", "DMG-")
            end,
            description = "DEF-"
        }, {
            name = "Plow Through",
            effect_function = function()
                math.randomseed(os.time())
                if math.random(1, 3) == 1 then
                    player.health = player.health - (0.1 * player.max_health)
                    if player.health - player.stamina <= 0 then
                        player.health = player.stamina + 1
                    end
                end
            end,
            description = "Effect: HP-"
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
    end
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
            recurring_buff = recurring_buff
        })
    end
end