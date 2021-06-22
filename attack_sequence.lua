Attack_Sequence = Object:extend()

function Attack_Sequence:new(enemy)
    self.x = 480
    self.y = 700
    self.width = 300
    self.height = 64
    self.crit = 64
    self.normal_attack = 160
    self.weak_attack = 256
    self.selector = self.x - (self.width / 2)
    self.enemy = enemy
end

function Attack_Sequence:update(dt)
    self.selector = self.selector + 200 * dt
    if self.selector >= self.x - (self.width / 2) + self.width then
        game_state = "play"
    end
end

function Attack_Sequence:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", self.x - (self.width / 2), self.y, self.width, self.height)
    love.graphics.setColor(0.78, 0, 0)
    love.graphics.rectangle("fill", self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2), self.y, self.weak_attack, self.height)
    love.graphics.setColor(1, 0.95, 0)
    love.graphics.rectangle("fill", self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2), self.y, self.normal_attack, self.height)
    love.graphics.setColor(0, 0.78, 0.039)
    love.graphics.rectangle("fill", self.x - (self.width / 2) + ((self.width - self.crit) / 2), self.y, self.crit, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x - (self.width / 2), self.y, self.width, self.height)
    love.graphics.rectangle("line", self.selector, self.y, 2, self.height)
end

function Attack_Sequence:damage()
    if self.selector >= self.x - (self.width / 2) + ((self.width - self.crit) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.crit) / 2) + self.crit then
        local damage = player:calculate_damage(enemy)
        self.enemy.health = self.enemy.health - ((damage - (damage * self.enemy.defense)) * 1.2)
        player:execute_effects()
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) + self.normal_attack then
        local damage = player:calculate_damage(enemy)
        self.enemy.health = self.enemy.health - (damage - (damage * self.enemy.defense))
        player:execute_effects()
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) + self.weak_attack then
        local damage = player:calculate_damage(enemy)
        self.enemy.health = self.enemy.health - ((damage - (damage * self.enemy.defense)) * 0.75)
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
        end
    end
    game_state = "play"
end