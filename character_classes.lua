Character_classes = Object:extend()

function Character_classes:new()
    self.all_characters = {
        {
            name = "Strength Character",
            health = 100,
            strength = 30,
            skill = 0,
            arcane = 0,
            holy = 0,
            agility = 10
        }, {
            name = "Skill Character",
            health = 90,
            strength = 0,
            skill = 30,
            arcane = 0,
            holy = 0,
            agility = 99
        }, {
            name = "Arcane Character",
            health = 110,
            strength = 0,
            skill = 0,
            arcane = 30,
            holy = 0,
            agility = 12
        }, {
            name = "Holy Character",
            health = 110,
            strength = 0,
            skill = 0,
            arcane = 00,
            holy = 30,
            agility = 8
        }, {
            name = "Hybrid Character",
            health = 110,
            strength = 30,
            skill = 30,
            arcane = 0,
            holy = 0,
            agility = 11
        },
    }
end