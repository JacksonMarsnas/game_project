Character = Object:extend()

function Character:new(new_vitality, new_strength, new_skill, new_arcane, new_holy, new_agility, new_level, new_resilience)
    require "bullet"
    require "debuff"

    self:create_sprites()

    nav_font = love.graphics.newFont( "ARCADECLASSIC.TTF", 24)
    nav_font:setFilter( "nearest", "nearest" )
    effect_font = love.graphics.newFont( "ARCADECLASSIC.TTF", 20)
    effect_font:setFilter( "nearest", "nearest" )

    self.current_action = "none"
    self.x = 448
    self.y = 448
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
    self.animations = self:create_animations()
    self.current_frame = 1
    self.speed_multiplier = 10
    self.animation_state = "idle_down"
    self.current_map = "map1"
    self.stop_drawing = false
    self.current_weapon = 1
    self.stamina = 0
    self.bullet_is_present = false
    self.regen_check = true
    self.active_buffs = {}
    self.damage_multiplier = 1
    self.has_looted = false
    self.mega_map_x = 1
    self.mega_map_y = 4

    self.base_vitality = new_vitality
    self.vitality = self.base_vitality
    self.health = self.vitality * 10
    self.attacks = {}
    self.base_resilience = new_resilience
    self.resilience = self.base_resilience
    self.strength = new_strength
    self.base_strength = self.strength
    self.skill = new_skill
    self.base_skill = self.skill
    self.arcane = new_arcane
    self.base_arcane = self.arcane
    self.holy = new_holy
    self.base_holy = self.holy 
    self.agility = new_agility
    self.base_agility = self.agility
    self.base_stamina_recovery_speed = 25
    self.stamina_recovery_speed = self.base_stamina_recovery_speed
    self.level = new_level
    self.experience = 500
end

function Character:draw()
    if self.stop_drawing ~= true then
        for index, row in ipairs(all_maps[player.current_map].vision_map) do
            for row_number, spot in ipairs(row) do
                if spot == 0 then
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("fill", row_number * 64 - 64, index * 64 - 64, 64, 64 )
                end
            end
        end
        love.graphics.setColor(1, 1, 1)

        if (self.animation_state == "casting_up" or self.animation_state == "casting_down" or self.animation_state == "casting_left" or self.animation_state == "casting_right") and self.attacks[self.current_weapon]["type"] == "Buff" then
            love.graphics.draw(projectiles_sheet, projectile_frames[3], self.x, self.y)
        end
        love.graphics.setFont(nav_font)
        love.graphics.draw(character_sheet, character_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
        self:draw_navbar()
        self:draw_effects()
        if self.bullet_is_present == true then
            bullet:draw()
        end

        if self.has_looted == true then
            love.graphics.print(self.loot_text, 64, 64)
        end

        self:draw_map()
    end
end

function Character:update(dt, current_enemies)
    if self.bullet_is_present == true then
        bullet:update(dt, current_enemies)
        self:cycle_frames(dt, current_enemies)
    else
        self:stamina_regen()
        self:cycle_frames(dt, current_enemies)
        if self.movement_animation ~= "none" then
            self:movement_animation(dt, current_enemies)
        end
    end
    if self.has_looted == true then
        self.loot_text_timeout = self.loot_text_timeout + dt
        if self.loot_text_timeout >= 5 then
            self.has_looted = false
        end
    end
end

function Character:draw_map()
    love.graphics.print("MAP", 976, 64)
    for row_number, row in ipairs(mega_map) do
        for column_number, room in ipairs(row) do
            if row_number == self.mega_map_y and column_number == self.mega_map_x then
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", 976 + ((column_number - 1) * 16), 96 + ((row_number - 1) * 16), 16, 16)
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.rectangle("line", 976 + ((column_number - 1) * 16), 96 + ((row_number - 1) * 16), 16, 16)
                love.graphics.setColor(1, 1, 1)
            elseif room == 0 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("line", 976 + ((column_number - 1) * 16), 96 + ((row_number - 1) * 16), 16, 16)
            elseif room == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle("fill", 976 + ((column_number - 1) * 16), 96 + ((row_number - 1) * 16), 16, 16)
                love.graphics.setColor(0.5, 0.5, 0.5)
                love.graphics.rectangle("line", 976 + ((column_number - 1) * 16), 96 + ((row_number - 1) * 16), 16, 16)
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
end

function Character:draw_effects()
    love.graphics.setFont(effect_font)
    for index, effect in ipairs(self.attacks[self.current_weapon]["permanent_effects"]) do
        if index <= 2 then
            love.graphics.print(effect["description"], 540, 910 + index * 48 - 48)
        else
            love.graphics.print(effect["description"], 775, 910 + index * 48 - 144)
        end
    end

    local permanent_effects_length = #self.attacks[self.current_weapon]["permanent_effects"]
    for index, effect in ipairs(self.attacks[self.current_weapon]["effect"]) do
        if index + permanent_effects_length <= 2 then
            love.graphics.print(effect["description"], 540, 910 + (index + permanent_effects_length) * 48 - 48)
        else
            love.graphics.print(effect["description"], 775, 910 + (index + permanent_effects_length) * 48 - 144)
        end
    end
end

function Character:create_sprites()
    character_sheet = love.graphics.newImage("base_character.png")
    character_frames = {}
    sprite_dimensions = 64

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(character_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, character_sheet:getWidth(), character_sheet:getHeight()))
        end
    end

    projectiles_sheet = love.graphics.newImage("projectiles.png")
    projectile_frames = {}
    for i = 0, 2 do
        table.insert(projectile_frames, love.graphics.newQuad(i * 64, 0, 64, 64, projectiles_sheet:getWidth(), projectiles_sheet:getHeight()))
    end
end

function Character:draw_navbar()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 20, 930, self.health / (self.vitality * 10) * 256, 24)
    love.graphics.setColor(0, 0.082, 0.56)
    love.graphics.rectangle("fill", 20, 930, self.stamina / (self.vitality * 10) * 256, 24)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.health - self.stamina .. " HP", 20, 930)
    love.graphics.print(self.attacks[self.current_weapon]["name"], 300, 910)
    love.graphics.print(self.attacks[self.current_weapon]["type"], 300, 940)
    love.graphics.setFont(effect_font)
    for index, buff in ipairs(self.active_buffs) do
        love.graphics.print(buff["code"] .. ":" .. buff["duration"], (index - 1) * 72 + 20, 960)
    end
end

function Character:cycle_frames(dt, current_enemies)
    self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
    if self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == true then
        self.current_frame = 1
    elseif self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == false then
        self:change_to_idle_animations()
        self.current_frame = 1
        self.current_action = "none"
        self:buff_begin_enemy_turn(current_enemies)
    end
end

function Character:change_to_idle_animations()
    if self.current_action == "attacking_up" or self.current_action == "casting_up" then
        self.animation_state = "idle_up"
    elseif self.current_action == "attacking_down" or self.current_action == "casting_down" then
        self.animation_state = "idle_down"
    elseif self.current_action == "attacking_left" or self.current_action == "casting_left" then
        self.animation_state = "idle_left"
    elseif self.current_action == "attacking_right" or self.current_action == "casting_right" then
        self.animation_state = "idle_right"
    elseif self.current_action == "dying" then
        self.stop_drawing = true
        self.current_map = "death_screen"
    end
end

function Character:buff_begin_enemy_turn(current_enemies)
    if self.attacks[self.current_weapon]["type"] == "Buff" then
        for index, enemy in ipairs(current_enemies) do
            enemy:begin_turn(self.current_x_tile, self.current_y_tile)
        end
    end
end

function Character:move(key)
    if key == "w" and self.current_y_tile > 1 and self:check_occupation(0, -1) == true then
        self.regen_check = false
        self:change_movement_animation(key)
        self.next_y_tile = self.current_y_tile - 1
        self.current_action = "walking_up"
    elseif key == "s" and self.current_y_tile < 14 and self:check_occupation(0, 1) == true then
        self.regen_check = false
        self:change_movement_animation(key)
        self.next_y_tile = self.current_y_tile + 1
        self.current_action = "walking_down"
    elseif key == "a" and self.current_x_tile > 1 and self:check_occupation(-1, 0) == true then
        self.regen_check = false
        self:change_movement_animation(key)
        self.next_x_tile = self.current_x_tile - 1
        self.current_action = "walking_left"
    elseif key == "d" and self.current_x_tile < 15 and self:check_occupation(1, 0) == true then
        self.regen_check = false
        self:change_movement_animation(key)
        self.next_x_tile = self.current_x_tile + 1
        self.current_action = "walking_right"
    end
end

function Character:change_movement_animation(key)
    if key == "w" or key == "a" or key == "s" or key == "d" then
        self:change_animation_state_walking(key)
    elseif key == "up" or key == "down" or key == "left" or key == "right" then
        if self.attacks[self.current_weapon]["type"] == "Attack" then
            self:change_animation_state_melee(key)
        elseif self.attacks[self.current_weapon]["type"] == "Ranged" then
            self:change_animation_state_ranged(key)
        elseif self.attacks[self.current_weapon]["type"] == "Buff" then
            self:change_animation_state_buff(key)
        elseif self.attacks[self.current_weapon]["type"] == "Debuff" then
            self:change_animation_state_debuff(key)
        end
    end
end

function Character:change_animation_state_walking(key)
    if key == "w" then
        self.animation_state = "walking_up"
    elseif key == "s" then
        self.animation_state = "walking_down"
    elseif key == "a" then
        self.animation_state = "walking_left"
    elseif key == "d" then
        self.animation_state = "walking_right"
    end
end

function Character:change_animation_state_melee(key)
    if key == "up" then
        self.animation_state = "attacking_up"
    elseif key == "down" then
        self.animation_state = "attacking_down"
    elseif key == "left" then
        self.animation_state = "attacking_left"
    elseif key == "right" then
        self.animation_state = "attacking_right"
    end
end

function Character:change_animation_state_ranged(key)
    if key == "up" then
        self.animation_state = "casting_up"
        bullet = Bullet(self.x, self.y, "up", 2)
        self.bullet_is_present = true
    elseif key == "down" then
        self.animation_state = "casting_down"
        bullet = Bullet(self.x, self.y, "down", 2)
        self.bullet_is_present = true
    elseif key == "left" then
        self.animation_state = "casting_left"
        bullet = Bullet(self.x, self.y, "left", 2)
        self.bullet_is_present = true
    elseif key == "right" then
        self.animation_state = "casting_right"
        bullet = Bullet(self.x, self.y, "right", 2)
        self.bullet_is_present = true
    end
end

function Character:change_animation_state_buff(key)
    if key == "up" then
        self.animation_state = "casting_up"
    elseif key == "down" then
        self.animation_state = "casting_down"
    elseif key == "left" then
        self.animation_state = "casting_left"
    elseif key == "right" then
        self.animation_state = "casting_right"
    end
end

function Character:change_animation_state_debuff(key)
    if key == "up" then
        self.animation_state = "casting_up"
        bullet = Debuff(self.x, self.y, "up", 2)
        self.bullet_is_present = true
    elseif key == "down" then
        self.animation_state = "casting_down"
        bullet = Debuff(self.x, self.y, "down", 2)
        self.bullet_is_present = true
    elseif key == "left" then
        self.animation_state = "casting_left"
        bullet = Debuff(self.x, self.y, "left", 2)
        self.bullet_is_present = true
    elseif key == "right" then
        self.animation_state = "casting_right"
        bullet = Debuff(self.x, self.y, "right", 2)
        self.bullet_is_present = true
    end
end

function Character:movement_animation(dt, current_enemies)
    if self.current_action == "walking_up" and self.y >= (self.next_y_tile - 1) * 64 then
        self.y = self.y - 140 * dt
        if self.y <= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_up"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_down" and self.y <= (self.next_y_tile - 1) * 64 then
        self.y = self.y + 140 * dt
        if self.y >= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_down"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_left" and self.x >= (self.next_x_tile - 1) * 64 then
        self.x = self.x - 140 * dt
        if self.x <= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_left"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_right" and self.x <= (self.next_x_tile - 1) * 64 then
        self.x = self.x + 140 * dt
        if self.x >= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_right"

            self:begin_enemy_turn(current_enemies)
        end
    end
end

function Character:begin_enemy_turn(current_enemies)
    for index, enemy in ipairs(current_enemies) do
        enemy:begin_turn(self.current_x_tile, self.current_y_tile)
    end
end

function Character:stamina_regen()
    local allow_player_action = true
    for index, enemy in ipairs(all_maps[self.current_map]["enemies"]) do
        if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
            allow_player_action = false
        end
    end
    if allow_player_action == true and self.regen_check == false and self.current_action == "none" then
        self.stamina = self.stamina - self.stamina_recovery_speed
        self.regen_check = true
        if self.stamina < 0 then
            self.stamina = 0
        end
        self:line_of_sight(self.current_x_tile, self.current_y_tile, 0)
        self:decrement_buffs()
    end
end

function Character:decrement_buffs()
    for index, buff in ipairs(self.active_buffs) do
        buff.duration = buff.duration - 1
        if buff.duration <= 0 then
            buff["revert"]()
            table.remove(self.active_buffs, index)
            self:decrement_buffs()
            break
        end
    end
end

function Character:attack(key, x_offset, y_offset, current_enemies)
    self:change_movement_animation(key)
    if self.attacks[self.current_weapon]["type"] == "Attack" then
        self.current_action = "attacking_" .. key
    elseif self.attacks[self.current_weapon]["type"] == "Ranged" or self.attacks[self.current_weapon]["type"] == "Buff" or self.attacks[self.current_weapon]["type"] == "Debuff" then
        self.current_action = "casting_" .. key
    end

    self.stamina = self.stamina + self.attacks[self.current_weapon]["stamina"]
    if self.stamina >= self.health then
        self.stamina = self.health - 1
    end

    if self.attacks[self.current_weapon]["type"] == "Attack" then
        self:melee_attack(x_offset, y_offset, current_enemies)
    elseif self.attacks[self.current_weapon]["type"] == "Buff" then
        self:buff_used()
    end
end

function Character:melee_attack(x_offset, y_offset, current_enemies)
    local enemy_struck = false
    for index, enemy in ipairs(current_enemies) do
        if enemy.current_x - self.current_x_tile - x_offset == 0 and enemy.current_y - self.current_y_tile - y_offset == 0 and self:check_occupation(x_offset, y_offset) == false then
            enemy_struck = true
            attack_action = Attack_Sequence(enemy, self.attacks[self.current_weapon]["multipliers"])
            game_state = "attacking"
        end
    end
    if enemy_struck == false then
        self:begin_enemy_turn(current_enemies)
    end
end

function Character:buff_used()
    local buff_used = false
    for index, buff in ipairs(self.active_buffs) do
        if self.attacks[self.current_weapon]["base_buff"]["name"] == buff["name"] then
            buff_used = true
            love.graphics.setColor(1, 0, 0)
        end
    end
    if buff_used == false then
        self.attacks[self.current_weapon]["base_buff"]["buff"]()
        table.insert(self.active_buffs, {
            duration = self.attacks[self.current_weapon]["base_buff"]["duration"](),
            revert = self.attacks[self.current_weapon]["base_buff"]["revert"],
            name = self.attacks[self.current_weapon]["base_buff"]["name"],
            code = self.attacks[self.current_weapon]["base_buff"]["code"]
        })
        self:execute_effects()
    end
end

function Character:execute_effects(enemy)
    for index, effect in ipairs(self.attacks[self.current_weapon]["effect"]) do
        effect["effect_function"](enemy)
    end
    for index, effect in ipairs(self.attacks[self.current_weapon]["permanent_effects"]) do
        effect["effect_function"](enemy)
    end
end

function Character:calculate_damage(enemy)
    local damage = self.attacks[self.current_weapon]["base_damage"]
    damage = damage + self.attacks[self.current_weapon]["scaling"]["strength"] * self.strength
    damage = damage + self.attacks[self.current_weapon]["scaling"]["skill"] * self.skill
    damage = damage + self.attacks[self.current_weapon]["scaling"]["arcane"] * self.arcane
    damage = damage + self.attacks[self.current_weapon]["scaling"]["holy"] * self.holy    

    return damage * self.damage_multiplier
end

function Character:create_animations()
    return {
        idle_up = {105},
        idle_left = {118},
        idle_down = {131},
        idle_right = {144},
        walking_up = {105, 106, 107, 108, 109, 110, 111, 112, 113},
        walking_left = {118, 119, 120, 121, 122, 123, 124, 125, 126},
        walking_down = {131, 132, 133, 134, 135, 136, 137, 138, 139},
        walking_right = {144, 145, 146, 147, 148, 149, 150, 151, 152},
        attacking_up = {157, 158, 159, 160, 161, 162, 162, 162},
        attacking_left = {170, 171, 172, 173, 174, 175, 175, 175},
        attacking_down = {183, 184, 185, 186, 187, 188, 188, 188},
        attacking_right = {196, 197, 198, 199, 200, 201, 201, 201},
        casting_up = {157, 158, 159, 160, 161, 162, 162, 162},
        casting_left = {170, 171, 172, 173, 174, 175, 175, 175},
        casting_down = {183, 184, 185, 186, 187, 188, 188, 188},
        casting_right = {196, 197, 198, 199, 200, 201, 201, 201},
        dying = {261, 262, 263, 264, 265, 266}
    }
end

function Character:check_occupation(x_offset, y_offset)
    if all_maps[self.current_map].tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] == 3 then
        return false
    elseif occupation_map[self.current_y_tile + y_offset][self.current_x_tile + x_offset] == true then
        return false
    else
        return true
    end
end

function Character:animation_loop()
    if self.current_action == "attacking_up" or self.current_action == "attacking_down" or 
    self.current_action == "attacking_left" or self.current_action == "attacking_right" or 
    self.current_action == "casting_up" or self.current_action == "casting_down" or 
    self.current_action == "casting_left" or self.current_action == "casting_right" or 
    self.current_action == "dying" then
        return false
    end
    return true 
end

function Character:take_damage(damage_taken, enemy_agility)
    table.insert(dodge_sequences, Dodge_Sequence(damage_taken, enemy_agility))
    dodge_action = Dodge_Sequence(damage_taken, enemy_agility)
    game_state = "dodging"
end

function Character:swap_weapons()
    self.current_weapon = self.current_weapon + 1
    if self.current_weapon > 3 then
        self.current_weapon = 1
    end
end

function Character:line_of_sight(next_x, next_y, generation)
    if next_x < 1 or next_x > 15 or next_y < 1 or next_y > 14 then
        return false
    elseif all_maps[self.current_map].tilemap[next_y][next_x] == 3 or all_maps[self.current_map].tilemap[next_y][next_x] == 8 or generation == 6 then
        all_maps[player.current_map].vision_map[next_y][next_x] = 1
        return false
    else
        all_maps[player.current_map].vision_map[next_y][next_x] = 1
        self:line_of_sight(next_x, next_y + 1, generation + 1)
        self:line_of_sight(next_x, next_y - 1, generation + 1)
        self:line_of_sight(next_x + 1, next_y, generation + 1)
        self:line_of_sight(next_x - 1, next_y, generation + 1) 
    end
end