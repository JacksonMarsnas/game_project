Effects = Object:extend()

function Effects:new()
    self.all_effects = {
        {
            name = "Heal",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect_function = function() player.health = player.health + 30 end
        }
    }
end