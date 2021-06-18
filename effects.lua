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
            effect_function = function() end
        }, {
            name = "Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + 30 end
        }, {
            name = "Super Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + 300 end
        }
    }
end