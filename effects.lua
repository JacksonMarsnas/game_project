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
            description = "Effect: None"
        }, {
            name = "Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + player.holy end,
            description = "Heal 30 HP"
        }, {
            name = "Super Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + 300 end,
            description = "Effect: Heal 300 HP"
        }
    }

    self:add_descriptions()
end

function Effects:add_descriptions()
    self.all_effects[2]["description"] = "Effect: Heal " .. self.all_effects[2]["scaling"]["holy"] * player.holy .. " HP"
end