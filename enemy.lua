Enemy = Object:extend()

function Enemy:new(starting_x, starting_y)
    self.x = starting_x
    self.y = starting_y
    self.current_x = self.x / 64 + 1
    self.current_y = self.y / 64 + 1
    self.current_frame = 1
    self.speed_multiplier = 10
    self.animation_state = "idle_down"

    occupation_map[self.current_y][self.current_x] = true
end

function Enemy:update(dt)
    if self.health > 0 then
        self:animation_cycle(dt)
        if self.animation_state == "walking_up" or self.animation_state == "walking_down" or self.animation_state == "walking_left" or self.animation_state == "walking_right" then
            self:move(dt)
        end
    else
        if self.current_frame < 5 then
            self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
        end
    end
end

function Enemy:animation_cycle(dt)
    self.current_frame = self.current_frame + 1 * dt * self.speed_multiplier
    if self.current_frame > #self.animations[self.animation_state] then
        self.current_frame = 1
        if self.animation_state == "attacking_up" or self.animation_state == "attacking_down" or self.animation_state == "attacking_left" or self.animation_state == "attacking_right" then
            player:take_damage(self.attack_power)
            if self.animation_state == "attacking_up" then
                self.animation_state = "idle_up"
            elseif self.animation_state == "attacking_down" then
                self.animation_state = "idle_down"
            elseif self.animation_state == "attacking_left" then
                self.animation_state = "idle_left"
            elseif self.animation_state == "attacking_right" then
                self.animation_state = "idle_right"
            end
        end
    end
end

function Enemy:move(dt)
    if self.animation_state == "walking_up" then
        self.y = self.y - 100 * dt
        if self.y <= (self.current_y - 1) * 64 then
            self.y = (self.current_y - 1) * 64
            self.current_y = self.y / 64 + 1
            self.current_frame = 1
            self.animation_state = "idle_up"
        end
    elseif self.animation_state == "walking_down" then
        self.y = self.y + 100 * dt
        if self.y >= (self.current_y - 1) * 64 then
            self.y = (self.current_y - 1) * 64
            self.current_y = self.y / 64 + 1
            self.current_frame = 1
            self.animation_state = "idle_down"
        end
    elseif self.animation_state == "walking_left" then
        self.x = self.x - 100 * dt
        if self.x <= (self.current_x - 1) * 64 then
            self.x = (self.current_x - 1) * 64
            self.current_x = self.x / 64 + 1
            self.current_frame = 1
            self.animation_state = "idle_left"
        end
    elseif self.animation_state == "walking_right" then
        self.x = self.x + 100 * dt
        if self.x >= (self.current_x - 1) * 64 then
            self.x = (self.current_x - 1) * 64
            self.current_x = self.x / 64 + 1
            self.current_frame = 1
            self.animation_state = "idle_right"
        end
    end
end

function Enemy:begin_turn(player_x_tile, player_y_tile)
    if self.health > 0 and self:check_aggro_range(player_x_tile, player_y_tile) == true then
        local x_difference = self.current_x - player_x_tile
        local y_difference = self.current_y - player_y_tile
        occupation_map[self.current_y][self.current_x] = false

        if (math.abs(x_difference) == 1 and math.abs(y_difference) == 0) or (math.abs(y_difference) == 1 and math.abs(x_difference) == 0) then
            self:attack(x_difference, y_difference)
        elseif math.abs(x_difference) > math.abs(y_difference) then
            if x_difference < 0 then
                if self:check_occupation(1, 0) == true then
                    self.animation_state = "walking_right"
                    self.current_x = self.current_x + 1
                elseif y_difference < 0 and self:check_occupation(0, 1) == true then
                    self.animation_state = "walking_down"
                    self.current_y = self.current_y + 1
                elseif y_difference >= 0 and self:check_occupation(0, -1) == true then
                    self.animation_state = "walking_up"
                    self.current_y = self.current_y - 1
                end
            elseif x_difference >= 0 then
                if self:check_occupation(-1, 0) == true then
                    self.animation_state = "walking_left"
                    self.current_x = self.current_x - 1
                elseif y_difference < 0 and self:check_occupation(0, 1) == true then
                    self.animation_state = "walking_down"
                    self.current_y = self.current_y + 1
                elseif y_difference >= 0 and self:check_occupation(0, -1) == true then
                    self.animation_state = "walking_up"
                    self.current_y = self.current_y - 1
                end
            end
        else
            if y_difference < 0 then
                if self:check_occupation(0, 1) == true then
                    self.animation_state = "walking_down"
                    self.current_y = self.current_y + 1
                elseif x_difference < 0 and self:check_occupation(1, 0) == true then
                    self.animation_state = "walking_right"
                    self.current_x = self.current_x + 1
                elseif x_difference >= 0 and self:check_occupation(-1, 0) == true then
                    self.animation_state = "walking_left"
                    self.current_x = self.current_x - 1
                end
            elseif y_difference >= 0 then
                if self:check_occupation(0, -1) == true then
                    self.animation_state = "walking_up"
                    self.current_y = self.current_y - 1
                elseif x_difference < 0 and self:check_occupation(1, 0) == true then
                    self.animation_state = "walking_right"
                    self.current_x = self.current_x + 1
                elseif x_difference >= 0 and self:check_occupation(-1, 0) == true then
                    self.animation_state = "walking_left"
                    self.current_x = self.current_x - 1
                end
            end
        end
        occupation_map[self.current_y][self.current_x] = true
    end
end

function Enemy:attack(x_difference, y_difference)
    if y_difference == 1 then
        self.animation_state = "attacking_up"
    elseif y_difference == -1 then
        self.animation_state = "attacking_down"
    elseif x_difference == 1 then
        self.animation_state = "attacking_left"
    elseif x_difference == -1 then
        self.animation_state = "attacking_right"
    end
end    

function Enemy:check_occupation(x_offset, y_offset)
    if self.current_y + y_offset >= 1 and self.current_y + y_offset <= 14 and self.current_x + x_offset >= 1 and self.current_x + x_offset <= 14 and tilemap[self.current_y + y_offset][self.current_x + x_offset] ~= 1 and tilemap[self.current_y + y_offset][self.current_x + x_offset] ~= 2 and tilemap[self.current_y + y_offset][self.current_x + x_offset] ~= 4 then
        return false
    elseif self.current_y + y_offset >= 1 and self.current_y + y_offset <= 14 and self.current_x + x_offset >= 1 and self.current_x + x_offset <= 14 and occupation_map[self.current_y + y_offset][self.current_x + x_offset] == true then
        return false
    elseif self.current_y + y_offset >= 1 and self.current_y + y_offset <= 14 and self.current_x + x_offset >= 1 and self.current_x + x_offset <= 14 then
        return true
    end
    return false
end

function Enemy:create_animations()
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
        dead = {261, 262, 263, 264, 265, 266}
    }
end

function Enemy:check_aggro_range(player_x_tile, player_y_tile)
    if math.abs(self.current_x - player_x_tile) + math.abs(self.current_y - player_y_tile) <= 5 then
        return true
    end
    return false
end