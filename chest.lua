Chest = Object:extend()

function Chest:new(x, y)
    self.x = x * 64 - 64
    self.y = y * 64 - 64
end

function Chest:loot()
    local move_unlocked = false
    while move_unlocked == false do
        local new_move_index = math.random(#moves.all_moves)
        if moves.all_moves[new_move_index].locked == true then
            all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] = 10
            move_unlocked = true
            moves.all_moves[new_move_index].locked = false
        end
    end
end