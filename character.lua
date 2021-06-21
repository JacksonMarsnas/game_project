Character = Object:extend()

function Character:new(new_health, new_strength, new_skill, new_arcane, new_holy)
    require "bullet"
    require "debuff"

    self:create_sprites()

    nav_font = love.graphics.newFont( "ARCADECLASSIC.TTF", 24)
    nav_font:setFilter( "nearest", "nearest" )
    effect_font = love.graphics.newFont( "ARCADECLASSIC.TTF", 20)
    effect_font:setFilter( "nearest", "nearest" )

    self.current_action = "none"
    self.x = 128
    self.y = 128
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
    self.animations = self:create_animations()
    self.current_frame = 1
    self.speed_multiplier = 10
    self.animation_state = "idle_down"
    self.current_map = "map_1"
    self.stop_drawing = false
    self.current_weapon = 1
    self.stamina = 0
    self.bullet_is_present = false
    self.regen_check = true
    self.active_buffs = {}

    self.max_health = new_health
    self.health = self.max_health
    self.attacks = {}
    self.defense = 0.1
    self.strength = new_strength
    self.base_strength = self.strength
    self.skill = new_skill
    self.base_skill = self.skill
    self.arcane = new_arcane
    self.base_arcane = self.arcane
    self.holy = new_holy
    self.base_holy = self.holy 
end

function Character:draw()
    if self.stop_drawing ~= true then
        love.graphics.setFont(nav_font)
        love.graphics.draw(character_sheet, character_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
        self:draw_navbar()
        self:draw_effects()
        if self.bullet_is_present == true then
            bullet:draw()
        end
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
end

function Character:draw_effects()
    love.graphics.setFont(effect_font)
    for index, effect in ipairs(self.attacks[self.current_weapon]["effect"]) do
        if index <= 2 then
            love.graphics.print(effect["description"], 540, 910 + index * 48 - 48)
        else
            love.graphics.print(effect["description"], 740, 910 + index * 48 - 144)
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
end

function Character:draw_navbar()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 20, 930, self.health / self.max_health * 256, 24)
    love.graphics.setColor(0, 0.082, 0.56)
    love.graphics.rectangle("fill", 20, 930, self.stamina / self.max_health * 256, 24)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.health - self.stamina .. " HP", 20, 930)
    love.graphics.print(self.attacks[self.current_weapon]["name"], 300, 910)
    love.graphics.print(self.attacks[self.current_weapon]["type"], 300, 940)
    love.graphics.setFont(effect_font)
    for index, buff in ipairs(self.active_buffs) do
        love.graphics.print(buff["code"] .. ":" .. buff["duration"], (index - 1) * 72 + 20, 960)
    end
end

function Character:setup_stats()
    self.current_action = "none"
    self.x = 128
    self.y = 128
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
    self.animations = self:create_animations()
    self.current_frame = 1
    self.speed_multiplier = 10
    self.animation_state = "idle_down"
    self.current_map = "map_1"
    self.stop_drawing = false
    self.current_weapon = 1
    self.stamina = 0
    self.bullet_is_present = false
    self.regen_check = true
    self.active_buffs = {}

    self.max_health = new_health
    self.health = self.max_health
    self.attacks = {}
    self.defense = 0.1
    self.strength = new_strength
    self.base_strength = self.strength
    self.skill = new_skill
    self.base_skill = self.skill
    self.arcane = new_arcane
    self.base_arcane = self.arcane
    self.holy = new_holy
    self.base_holy = self.holy
end

function Character:cycle_frames(dt, current_enemies)
    self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
    if self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == true then
        self.current_frame = 1
    elseif self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == false then
        self:change_to_idle_animations()
        self.current_frame = 1
        self.current_action = "none"
        self:attack_buff_begin_enemy_turn(current_enemies)
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

function Character:attack_buff_begin_enemy_turn(current_enemies)
    if self.attacks[self.current_weapon]["type"] == "Attack" then
        for index, enemy in ipairs(current_enemies) do
            enemy:begin_turn(self.current_x_tile, self.current_y_tile)
        end
    elseif self.attacks[self.current_weapon]["type"] == "Buff" then
        for index, enemy in ipairs(current_enemies) do
            enemy:begin_turn(self.current_x_tile, self.current_y_tile)
        end
    end
end

function Character:move(key)
    if key == "w" and self.current_y_tile > 1 and self:check_occupation(0, -1) == true then
        self:change_movement_animation(key)
        self.next_y_tile = self.current_y_tile - 1
        self.current_action = "walking_up"
    elseif key == "s" and self.current_y_tile < 14 and self:check_occupation(0, 1) == true then
        self:change_movement_animation(key)
        self.next_y_tile = self.current_y_tile + 1
        self.current_action = "walking_down"
    elseif key == "a" and self.current_x_tile > 1 and self:check_occupation(-1, 0) == true then
        self:change_movement_animation(key)
        self.next_x_tile = self.current_x_tile - 1
        self.current_action = "walking_left"
    elseif key == "d" and self.current_x_tile < 15 and self:check_occupation(1, 0) == true then
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
        self.y = self.y - 100 * dt
        if self.y <= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_up"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_down" and self.y <= (self.next_y_tile - 1) * 64 then
        self.y = self.y + 100 * dt
        if self.y >= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_down"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_left" and self.x >= (self.next_x_tile - 1) * 64 then
        self.x = self.x - 100 * dt
        if self.x <= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_left"

            self:begin_enemy_turn(current_enemies)
        end
    elseif self.current_action == "walking_right" and self.x <= (self.next_x_tile - 1) * 64 then
        self.x = self.x + 100 * dt
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
    for index, enemy in ipairs(map1.enemies) do
        if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
            allow_player_action = false
        end
    end
    if allow_player_action == true and self.regen_check == false and self.current_action == "none" then
        self.stamina = self.stamina - 30
        self.regen_check = true
        if self.stamina < 0 then
            self.stamina = 0
        end
        self:decrement_buffs()
    end
end

function Character:decrement_buffs()
    for index, buff in ipairs(self.active_buffs) do
        buff.duration = buff.duration - 1
        if buff.duration <= 0 then
            buff["revert"]()
            table.remove(self.active_buffs, index)
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
    elseif self.attacks[self.current_weapon]["type"] == "Ranged" then
        self:execute_effects()
    elseif self.attacks[self.current_weapon]["type"] == "Buff" then
        self:buff_used()
    elseif self.attacks[self.current_weapon]["type"] == "Debuff" then
        self:execute_effects()
    end
end

function Character:melee_attack(x_offset, y_offset, current_enemies)
    for index, enemy in ipairs(current_enemies) do
        if enemy.current_x - self.current_x_tile - x_offset == 0 and enemy.current_y - self.current_y_tile - y_offset == 0 and self:check_occupation(x_offset, y_offset) == false then
            local damage = self:calculate_damage(enemy)
            enemy.health = enemy.health - (damage - (damage * enemy.defense))
            if enemy.health <= 0 then
                enemy.animation_state = "dead"
                enemy.health = 0
                occupation_map[enemy.current_y][enemy.current_x] = false
            end
            self:execute_effects()
        end
    end
end

function Character:buff_used()
    local buff_used = false
    for index, buff in ipairs(self.active_buffs) do
        if self.attacks[self.current_weapon]["base_buff"]["name"] == buff["name"] then
            buff_used = true
        end
    end
    if buff_used == false then
        self.attacks[self.current_weapon]["base_buff"]["buff"]()
        table.insert(self.active_buffs, {
            duration = self.attacks[self.current_weapon]["base_buff"]["duration"],
            revert = self.attacks[self.current_weapon]["base_buff"]["revert"],
            name = self.attacks[self.current_weapon]["base_buff"]["name"],
            code = self.attacks[self.current_weapon]["base_buff"]["code"]
        })
        self:execute_effects()
    end
end

function Character:execute_effects()
    for index, effect in ipairs(self.attacks[self.current_weapon]["effect"]) do
        effect["effect_function"]()
    end
end

function Character:calculate_damage(enemy)
    local damage = self.attacks[self.current_weapon]["base_damage"]
    damage = damage + self.attacks[self.current_weapon]["scaling"]["strength"] * self.strength
    damage = damage + self.attacks[self.current_weapon]["scaling"]["skill"] * self.skill
    damage = damage + self.attacks[self.current_weapon]["scaling"]["arcane"] * self.arcane
    damage = damage + self.attacks[self.current_weapon]["scaling"]["holy"] * self.holy    

    return damage
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
    if tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] ~= 1 and tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] ~= 2 and tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] ~= 4 then
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

function Character:take_damage(damage_taken)
    self.health = self.health - (damage_taken - (damage_taken * self.defense))
    if self.health - self.stamina <= 0 then
        self.health = 0
        self.current_action = "dying"
        self.animation_state = "dying"
    end
end

function Character:swap_weapons()
    self.current_weapon = self.current_weapon + 1
    if self.current_weapon > 3 then
        self.current_weapon = 1
    end
end