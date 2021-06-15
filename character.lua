Character = Object:extend()

function Character:new()
    character_sheet = love.graphics.newImage("base_character.png")
    character_frames = {}
    sprite_dimensions = 64

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(character_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, character_sheet:getWidth(), character_sheet:getHeight()))
        end
    end

    self.current_action = "none"
    self.x = 128
    self.y = 128
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
    self.animations = self:create_animations()
    self.current_frame = 1
    self.speed_multiplier = 10
    self.animation_state = "idle_down"
    self.max_health = 100
    self.health = 100
    self.current_map = "map_1"
    self.stop_drawing = false
end

function Character:draw()
    if self.stop_drawing ~= true then
        love.graphics.draw(character_sheet, character_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", 20, 930, self.health / self.max_health * 256, 32)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.health .. " HP", 20, 930)
    end
end

function Character:update(dt, current_enemies)
    self:cycle_frames(dt, current_enemies)
    if self.movement_animation ~= "none" then
        self:movement_animation(dt, current_enemies)
    end
end

function Character:cycle_frames(dt, current_enemies)
    self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
    if self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == true then
        self.current_frame = 1
    elseif self.current_frame > #self.animations[self.animation_state] and self:animation_loop() == false then
        if self.current_action == "attacking_up" then
            self.animation_state = "idle_up"
        elseif self.current_action == "attacking_down" then
            self.animation_state = "idle_down"
        elseif self.current_action == "attacking_left" then
            self.animation_state = "idle_left"
        elseif self.current_action == "attacking_right" then
            self.animation_state = "idle_right"
        elseif self.current_action == "dying" then
            self.stop_drawing = true
            self.current_map = "death_screen"
        end
        self.current_frame = 1
        self.current_action = "none"
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
    if key == "w" then
        self.animation_state = "walking_up"
    elseif key == "s" then
        self.animation_state = "walking_down"
    elseif key == "a" then
        self.animation_state = "walking_left"
    elseif key == "d" then
        self.animation_state = "walking_right"
    elseif key == "up" then
        self.animation_state = "attacking_up"
    elseif key == "down" then
        self.animation_state = "attacking_down"
    elseif key == "left" then
        self.animation_state = "attacking_left"
    elseif key == "right" then
        self.animation_state = "attacking_right"
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

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.current_action == "walking_down" and self.y <= (self.next_y_tile - 1) * 64 then
        self.y = self.y + 100 * dt
        if self.y >= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_down"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.current_action == "walking_left" and self.x >= (self.next_x_tile - 1) * 64 then
        self.x = self.x - 100 * dt
        if self.x <= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_left"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.current_action == "walking_right" and self.x <= (self.next_x_tile - 1) * 64 then
        self.x = self.x + 100 * dt
        if self.x >= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.current_action = "none"
            self.current_frame = 1
            self.animation_state = "idle_right"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    end
end

function Character:attack(key, x_offset, y_offset, current_enemies)
    self:change_movement_animation(key)
    self.current_action = "attacking_" .. key

    for index, enemy in ipairs(current_enemies) do
        if enemy.current_x - self.current_x_tile - x_offset == 0 and enemy.current_y - self.current_y_tile - y_offset == 0 then
            enemy.health = enemy.health - 50
            if enemy.health <= 0 then
                enemy.animation_state = "dead"
                enemy.health = 0
                occupation_map[enemy.current_y][enemy.current_x] = false
            end
        end
    end
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
        dying = {261, 262, 263, 264, 265, 266}
    }
end

function Character:check_occupation(x_offset, y_offset)
    if tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] ~= 1 and tilemap[self.current_y_tile + y_offset][self.current_x_tile + x_offset] ~= 2 then
        return false
    elseif occupation_map[self.current_y_tile + y_offset][self.current_x_tile + x_offset] == true then
        return false
    else
        return true
    end
end

function Character:animation_loop()
    if self.current_action == "attacking_up" or self.current_action == "attacking_down" or self.current_action == "attacking_left" or self.current_action == "attacking_right" or self.current_action == "dying" then
        return false
    end
    return true 
end

function Character:take_damage()
    self.health = self.health - 20
    if self.health <= 0 then
        self.health = 0
        self.current_action = "dying"
        self.animation_state = "dying"
    end
end