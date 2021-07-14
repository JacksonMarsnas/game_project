Chest = Object:extend()

function Chest:new(x, y)
    self.x = x * 64 - 64
    self.y = y * 64 - 64
end

function Chest:loot()
    local what_is_looted = math.random(3)
    if what_is_looted == 1 then
        local move_unlocked = false
        while move_unlocked == false do
            local new_move_index = math.random(#moves.all_moves)
            if moves.all_moves[new_move_index].locked == true then
                all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] = 10
                move_unlocked = true
                moves.all_moves[new_move_index].locked = false
                player.loot_text = "You found a new technique: " .. moves.all_moves[new_move_index].name
                player.has_looted = true
                player.loot_text_timeout = 0
            end
        end
    elseif what_is_looted == 2 then
        all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] = 10
        player.loot_text = "You found a potion in the chest, healing your wounds"
        player.health = player.vitality * 10
        player.has_looted = true
        player.loot_text_timeout = 0
    elseif what_is_looted == 3 then
        all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] = 10
        local exp_gain = math.random(math.floor((200 + (player.level * 5)) / 2), (200 + (player.level * 5)) * 3)
        player.loot_text = "You found " .. exp_gain .. " experience in the chest"
        player.experience = player.experience + exp_gain
        player.has_looted = true
        player.loot_text_timeout = 0
    end
end