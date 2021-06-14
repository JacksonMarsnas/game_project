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

    self.movement_direction = "none"
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
end

function Character:draw()
    love.graphics.draw(character_sheet, character_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 20, 930, self.health / self.max_health * 256, 32)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.health .. " HP", 20, 930)
end

function Character:update(dt, current_enemies)
    self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
    if self.current_frame > #self.animations[self.animation_state] then
        self.current_frame = 1
    end
    if self.movement_animation ~= "none" then
        self:movement_animation(dt, current_enemies)
    end
end

function Character:move(key)
    if key == "w" and self.current_y_tile > 1 and self:check_occupation(0, -1) == true then
        self:change_movement_animation(key, current_enemies)
        self.next_y_tile = self.current_y_tile - 1
        self.movement_direction = "up"
    elseif key == "s" and self.current_y_tile < 14 and self:check_occupation(0, 1) == true then
        self:change_movement_animation(key)
        self.next_y_tile = self.current_y_tile + 1
        self.movement_direction = "down"
    elseif key == "a" and self.current_x_tile > 1 and self:check_occupation(-1, 0) == true then
        self:change_movement_animation(key)
        self.next_x_tile = self.current_x_tile - 1
        self.movement_direction = "left"
    elseif key == "d" and self.current_x_tile < 15 and self:check_occupation(1, 0) == true then
        self:change_movement_animation(key)
        self.next_x_tile = self.current_x_tile + 1
        self.movement_direction = "right"
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
    end
end

function Character:movement_animation(dt, current_enemies)
    if self.movement_direction == "up" and self.y >= (self.next_y_tile - 1) * 64 then
        self.y = self.y - 100 * dt
        if self.y <= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.movement_direction = "none"
            self.current_frame = 1
            self.animation_state = "idle_up"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.movement_direction == "down" and self.y <= (self.next_y_tile - 1) * 64 then
        self.y = self.y + 100 * dt
        if self.y >= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.movement_direction = "none"
            self.current_frame = 1
            self.animation_state = "idle_down"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.movement_direction == "left" and self.x >= (self.next_x_tile - 1) * 64 then
        self.x = self.x - 100 * dt
        if self.x <= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.movement_direction = "none"
            self.current_frame = 1
            self.animation_state = "idle_left"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
            end
        end
    elseif self.movement_direction == "right" and self.x <= (self.next_x_tile - 1) * 64 then
        self.x = self.x + 100 * dt
        if self.x >= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.movement_direction = "none"
            self.current_frame = 1
            self.animation_state = "idle_right"

            for index, enemy in ipairs(current_enemies) do
                enemy:begin_turn(self.current_x_tile, self.current_y_tile)
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
        walking_right = {144, 145, 146, 147, 148, 149, 150, 151, 152}
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