Debuff = Object:extend()

function Debuff:new(x, y, direction, range)
    self.starting_x = x
    self.starting_y = y
    self.x = x
    self.y = y
    self.direction = direction
    self.range = range
end

function Debuff:update(dt, current_enemies)
    self:collision(current_enemies)
    if self.direction == "up" and self.y >= self.starting_y - (self.range * 64) then
        self.y = self.y - 100 * dt
        if self.y <= self.starting_y - (self.range * 64) then
            self:begin_enemy_turn(current_enemies)
        end
    elseif self.direction == "down" and self.y <= self.starting_y + (self.range * 64) then
        self.y = self.y + 100 * dt
        if self.y >= self.starting_y + (self.range * 64) then
            self:begin_enemy_turn(current_enemies)
        end
    elseif self.direction == "left" and self.x >= self.starting_x - (self.range * 64) then
            self.x = self.x - 100 * dt
            if self.x <= self.starting_x - (self.range * 64) then
                self:begin_enemy_turn(current_enemies)
            end
    elseif self.direction == "right" and self.x <= self.starting_x + (self.range * 64) then
        self.x = self.x + 100 * dt
        if self.x >= self.starting_x + (self.range * 64) then
            self:begin_enemy_turn(current_enemies)
        end
    end
end

function Debuff:draw()
    love.graphics.draw(projectiles_sheet, projectile_frames[2], self.x, self.y)
end

function Debuff:begin_enemy_turn(current_enemies)
    player.bullet_is_present = false
    for index, enemy in ipairs(current_enemies) do
        enemy:begin_turn(player.current_x_tile, player.current_y_tile)
    end
end

function Debuff:collision(current_enemies)
    local x_tile = math.floor(self.x / 64 + 0.5) + 1
    local y_tile = math.floor(self.y / 64 + 0.5) + 1

    if all_maps[player.current_map].tilemap[y_tile][x_tile] == 3 then
        self:begin_enemy_turn(current_enemies)
    end

    for index, enemy in ipairs(current_enemies) do
        if x_tile == enemy.current_x and y_tile == enemy.current_y and enemy.health > 0 then
            self:apply_debuff(enemy, x_tile, y_tile)
            player:execute_effects(enemy)
            self:begin_enemy_turn(current_enemies)
        end
    end
end

function Debuff:apply_debuff(enemy, x_tile, y_tile)
    local buff_used = self:check_if_debuff_already_active(enemy)
    
    if buff_used == false then
        player.attacks[player.current_weapon]["base_buff"]["buff"](enemy)
        table.insert(enemy.active_buffs, {
            duration = player.attacks[player.current_weapon]["base_buff"]["duration"](),
            revert = player.attacks[player.current_weapon]["base_buff"]["revert"],
            recurring_buff = player.attacks[player.current_weapon]["base_buff"]["recurring_buff"]
        })
    end
end

function Debuff:check_if_debuff_already_active(enemy)
    local buff_used = false
    for index, buff in ipairs(enemy.active_buffs) do
        if player.attacks[player.current_weapon]["base_buff"]["name"] == buff["name"] then
            buff_used = true
        end
    end
    return buff_used
end