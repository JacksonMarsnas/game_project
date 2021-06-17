Character_classes = Object:extend()

function Character_classes:new()
    self.all_characters = {
        {
            name = "Character 1",
            health = 100,
            strength = 50,
            skill = 50,
            arcane = 50,
            holy = 50
        }, {
            name = "Character 2",
            health = 90,
            strength = 40,
            skill = 40,
            arcane = 60,
            holy = 60
        }, {
            name = "Character 3",
            health = 110,
            strength = 60,
            skill = 60,
            arcane = 40,
            holy = 40
        }, 
    }
end