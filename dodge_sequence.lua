Dodge_Sequence = Object:extend()

function Dodge_Sequence:new(damage_taken)
    self.x = 480
    self.y = 700
    self.width = 300
    self.height = 64
    self.crit = 64
    self.normal_attack = 160
    self.weak_attack = 256
    self.selector = self.x - (self.width / 2)
    self.damage_taken = damage_taken
end

function Dodge_Sequence:update(dt)
    self.selector = self.selector + 200 * dt
    if self.selector >= self.x - (self.width / 2) + self.width then
        player.health = player.health - math.floor((self.damage_taken - (self.damage_taken * player.defense)) * 1.5)
        if player.health - player.stamina <= 0 then
            player.health = 0
            player.current_action = "dying"
            player.animation_state = "dying"
        end
        game_state = "play"
    end
end

function Dodge_Sequence:draw()
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

function Dodge_Sequence:damage()
    if self.selector >= self.x - (self.width / 2) + ((self.width - self.crit) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.crit) / 2) + self.crit then
        player.health = player.health - math.floor((self.damage_taken - (self.damage_taken * player.defense)) * 0.5)
        if player.health - player.stamina <= 0 then
            player.health = 0
            player.current_action = "dying"
            player.animation_state = "dying"
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.normal_attack) / 2) + self.normal_attack then
        player.health = player.health - math.floor((self.damage_taken - (self.damage_taken * player.defense)) * 1)
        if player.health - player.stamina <= 0 then
            player.health = 0
            player.current_action = "dying"
            player.animation_state = "dying"
        end
    elseif self.selector >= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) and self.selector <= self.x - (self.width / 2) + ((self.width - self.weak_attack) / 2) + self.weak_attack then
        player.health = player.health - math.floor((self.damage_taken - (self.damage_taken * player.defense)) * 1.2)
        if player.health - player.stamina <= 0 then
            player.health = 0
            player.current_action = "dying"
            player.animation_state = "dying"
        end
    end
    game_state = "play"
end