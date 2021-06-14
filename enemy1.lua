Enemy1 = Enemy:extend()

function Enemy1:new(starting_x, starting_y)
    Enemy1.super.new(self, starting_x, starting_y)
    enemy1_sheet = love.graphics.newImage("enemy_1.png")
    enemy1_frames = {}

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(enemy1_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, enemy1_sheet:getWidth(), enemy1_sheet:getHeight()))
        end
    end
end

function Enemy1:draw()
    love.graphics.draw(enemy1_sheet, enemy1_frames[1], self.x, self.y)
end