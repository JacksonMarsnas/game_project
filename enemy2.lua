Enemy2 = Enemy:extend()

function Enemy2:new(starting_x, starting_y)
    Enemy2.super.new(self, starting_x, starting_y)
    enemy2_sheet = love.graphics.newImage("enemy_2.png")
    enemy2_frames = {}
 
    self.max_health = 50 * all_maps[player.current_map]["difficulty"]
    self.health = self.max_health
    self.defense = 0.5 * all_maps[player.current_map]["difficulty"]
    self.attack_power = 20 * all_maps[player.current_map]["difficulty"]
    self.agility = 2 * all_maps[player.current_map]["difficulty"]
    self.blocking = 15 * all_maps[player.current_map]["difficulty"]
    self.exp_drop = 100 * all_maps[player.current_map]["difficulty"]

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(enemy2_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, enemy2_sheet:getWidth(), enemy2_sheet:getHeight()))
        end
    end  
end

function Enemy2:draw()
    love.graphics.draw(enemy2_sheet, enemy2_frames[self.animations[self.animation_state][math.floor(self.current_frame)]], self.x, self.y)
    love.graphics.setColor(1, 0, 0)
    if #self.active_buffs > 0 then
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.rectangle("fill", self.x, self.y + 64, self.health / self.max_health * 66, 5)
    love.graphics.setColor(1, 1, 1)
end