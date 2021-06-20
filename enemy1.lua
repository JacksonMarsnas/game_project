Enemy1 = Enemy:extend()

function Enemy1:new(starting_x, starting_y)
    Enemy1.super.new(self, starting_x, starting_y)
    enemy1_sheet = love.graphics.newImage("enemy_1.png")
    enemy1_frames = {}

    self.animations = self:create_animations()  
    self.max_health = 50
    self.health = self.max_health
    self.defense = 0.05
    self.attack_power = 20

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(enemy1_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, enemy1_sheet:getWidth(), enemy1_sheet:getHeight()))
        end
    end  
end

function Enemy1:draw()
    love.graphics.draw(enemy1_sheet, enemy1_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
    love.graphics.setColor(1, 0, 0)
    if #self.active_buffs > 0 then
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.rectangle("fill", self.x, self.y + 64, self.health / self.max_health * 66, 5)
    love.graphics.setColor(1, 1, 1)
end