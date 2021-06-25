Character_classes = Object:extend()

function Character_classes:new()
    self.all_characters = {
        {
            name = "Strength Character",
            vitality = 10,
            strength = 30,
            skill = 0,
            arcane = 0,
            holy = 0,
            agility = 10,
            resilience = 15,
            level = 1
        }, {
            name = "Skill Character",
            vitality = 10,
            strength = 0,
            skill = 30,
            arcane = 0,
            holy = 0,
            agility = 99,
            resilience = 15,
            level = 1
        }, {
            name = "Arcane Character",
            vitality = 10,
            strength = 0,
            skill = 0,
            arcane = 30,
            holy = 0,
            agility = 12,
            resilience = 15,
            level = 1
        }, {
            name = "Holy Character",
            vitality = 10,
            strength = 0,
            skill = 0,
            arcane = 0,
            holy = 30,
            agility = 8,
            resilience = 15,
            level = 1
        }, {
            name = "Hybrid Character",
            vitality = 10,
            strength = 30,
            skill = 30,
            arcane = 0,
            holy = 0,
            agility = 11,
            resilience = 15,
            level = 1
        },
    }
end