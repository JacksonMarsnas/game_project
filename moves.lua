Moves = Object:extend()

function Moves:new()
    self.all_moves = {
        {
            name = "Strength Move",
            type = "Attack",
            scaling = {
                strength = 1,
                skill = 0,
                arcane = 0,
                holy = 0
            }
        }, {
            name = "Skill Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 1,
                arcane = 0,
                holy = 0
            }
        }, {
            name = "Arcane Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 1,
                holy = 0
            }
        }, {
            name = "Holy Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            }
        }, {
            name = "Hybrid Move",
            type = "Attack",
            scaling = {
                strength = 1,
                skill = 1,
                arcane = 0,
                holy = 0
            }
        },
    }
end