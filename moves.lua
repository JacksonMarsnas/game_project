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
            },
            effect = {
                function() end
            }
        }, {
            name = "Skill Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 1,
                arcane = 0,
                holy = 0
            },
            effect = {
                function() end
            }
        }, {
            name = "Arcane Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 1,
                holy = 0
            },
            effect = {
                function() end
            }
        }, {
            name = "Holy Move",
            type = "Attack",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                function() end
            }
        }, {
            name = "Hybrid Move",
            type = "Attack",
            scaling = {
                strength = 1,
                skill = 1,
                arcane = 0,
                holy = 0
            },
            effect = {
                function() end
            }
        }, {
            name = "Heal",
            type = "Buff",
            scaling = {
                strength = 0,
                skill = 0,
                arcane = 0,
                holy = 1
            },
            effect = {
                function() end
            }
        }
    }
end