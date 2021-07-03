Bullet = Object:extend()

function Bullet:new(x, y, direction, range)
    self.starting_x = x
    self.starting_y = y
    self.x = x
    self.y = y
    self.direction = direction
    self.range = range
end

function Bullet:update(dt, current_enemies)
    self:collision(current_enemies)
    self:range_limit_check(dt, current_enemies)
end

function Bullet:draw()
    love.graphics.draw(projectiles_sheet, projectile_frames[1], self.x, self.y)
end

function Bullet:range_limit_check(dt, current_enemies)
    if self.direction == "up" and self.y >= self.starting_y - (self.range * 64) then
        self.y = self.y - 100 * dt
        if self.y <= self.starting_y - (self.range * 64) then
            player.bullet_is_present = false
            self:start_enemy_turn(current_enemies)
        end
    elseif self.direction == "down" and self.y <= self.starting_y + (self.range * 64) then
        self.y = self.y + 100 * dt
        if self.y >= self.starting_y + (self.range * 64) then
            player.bullet_is_present = false
            self:start_enemy_turn(current_enemies)
        end
    elseif self.direction == "left" and self.x >= self.starting_x - (self.range * 64) then
            self.x = self.x - 100 * dt
            if self.x <= self.starting_x - (self.range * 64) then
                player.bullet_is_present = false
                self:start_enemy_turn(current_enemies)
            end
    elseif self.direction == "right" and self.x <= self.starting_x + (self.range * 64) then
        self.x = self.x + 100 * dt
        if self.x >= self.starting_x + (self.range * 64) then
            player.bullet_is_present = false
            self:start_enemy_turn(current_enemies)
        end
    end
end

function Bullet:collision(current_enemies)
    local x_tile = math.floor(self.x / 64 + 0.5) + 1
    local y_tile = math.floor(self.y / 64 + 0.5) + 1

    self:tile_collision(x_tile, y_tile, current_enemies)
    self:enemy_collision(x_tile, y_tile, current_enemies)
end

function Bullet:tile_collision(x_tile, y_tile, current_enemies)
    if all_maps[player.current_map].tilemap[y_tile][x_tile] ~= 1 and all_maps[player.current_map].tilemap[y_tile][x_tile] ~= 2 and all_maps[player.current_map].tilemap[y_tile][x_tile] ~= 4 and all_maps[player.current_map].tilemap[y_tile][x_tile] ~= 5 then
        player.bullet_is_present = false
        self:start_enemy_turn(current_enemies)
    end
end

function Bullet:enemy_collision(x_tile, y_tile, current_enemies)
    for index, enemy in ipairs(current_enemies) do
        if x_tile == enemy.current_x and y_tile == enemy.current_y and enemy.health > 0 then
            player.bullet_is_present = false
            attack_action = Attack_Sequence(enemy, player.attacks[player.current_weapon]["multipliers"])
            game_state = "attacking"
            if enemy.health <= 0 then
                enemy.animation_state = "dead"
                enemy.health = 0
                occupation_map[enemy.current_y][enemy.current_x] = false
            end
            self:start_enemy_turn(current_enemies)
        end
    end
end

function Bullet:start_enemy_turn(current_enemies)
    for index, enemy in ipairs(current_enemies) do
        enemy:begin_turn(player.current_x_tile, player.current_y_tile)
    end
end