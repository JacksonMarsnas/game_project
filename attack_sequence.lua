Attack_Sequence = Object:extend()

function Attack_Sequence:new(enemy, multipliers)
    self.x = 480
    self.y = 700
    self.width = 300
    self.height = 64
    self.crit = (15 + math.floor(player.agility * 0.75) - math.floor(enemy.blocking * 0.75)) * multipliers.crit_multiplier
    self.normal_attack = (15 + math.floor(player.agility * 1.5) - math.floor(enemy.blocking * 1.5)) * multipliers.normal_multiplier + self.crit
    self.weak_attack = (15 + (player.agility * 2.25) - (enemy.blocking * 2.25)) * multipliers.weak_multiplier + self.normal_attack
    self.selector = self.x - (self.width / 2)
    self.enemy = enemy
    self.speed = (300 - player.agility * 4 + enemy.blocking * 4) * multipliers.speed_multiplier

    if self.crit < 5 then
        self.crit = 5
    elseif self.crit > 300 then
        self.crit = 300
    end
    if self.normal_attack < 10 then
        self.normal_attack = 10
    elseif self.normal_attack > 300 then
        self.normal_attack = 300
    end
    if self.weak_attack < 15 then
        self.weak_attack = 15
    elseif self.weak_attack > 300 then
        self.weak_attack = 300
    end
end

function Attack_Sequence:update(dt)
    self.selector = self.selector + self.speed * dt
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
        local damage = player:calculate_damage(self.enemy)
        self.enemy.health = self.enemy.health - ((damage - (damage * self.enemy.defense)) * 1.2)
        player:execute_effects(self.enemy)
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
            player.experience = player.experience + self.enemy["exp_drop"]
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) + self.normal_attack then
        local damage = player:calculate_damage(self.enemy)
        self.enemy.health = self.enemy.health - (damage - (damage * self.enemy.defense))
        player:execute_effects(self.enemy)
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
            player.experience = player.experience + self.enemy["exp_drop"]
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) + self.weak_attack then
        local damage = player:calculate_damage(self.enemy)
        self.enemy.health = self.enemy.health - ((damage - (damage * self.enemy.defense)) * 0.75)
        if self.enemy.health <= 0 then
            self.enemy.animation_state = "dead"
            self.enemy.health = 0
            occupation_map[self.enemy.current_y][self.enemy.current_x] = false
            player.experience = player.experience + self.enemy["exp_drop"]
        end
    end
    game_state = "play"
end