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
            description = "Effect: Slightly heal HP",
            heavy_description = "Heal HP equal to 20% of the user's holyness"
        }, {
            name = "Super Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + 300 end,
            description = "Effect: Heal 300 HP",
            heavy_description = "Heal a lot of HP"
        }
    }

    self:add_descriptions()
end

function Effects:add_descriptions()
    self.all_effects[2]["description"] = "Effect: Heal " .. self.all_effects[2]["scaling"]["holy"] * player.holy .. " HP"
end