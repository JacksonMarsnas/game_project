Character = Object:extend()

function Character:new()
    character_sheet = love.graphics.newImage("base_character.png")
    character_frames = {}
    sprite_dimensions = 64

    for i = 0, 21 do
        for j = 0, 13 do
            table.insert(character_frames, love.graphics.newQuad(i * sprite_dimensions, j * sprite_dimensions, sprite_dimensions, sprite_dimensions, character_sheet:getWidth(), character_sheet:getHeight()))
        end
    end

    self.x = 128
    self.y = 128
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
end

function Character:draw()
    love.graphics.draw(character_sheet, character_frames[1], self.x, self.y)
end

function Character:update()

end

function Character:move(key)
    if key == "w" and self.current_y_tile > 1 and (map1.tilemap[self.current_y_tile - 1][self.current_x_tile] == 1 or map1.tilemap[self.current_y_tile - 1][self.current_x_tile] == 2) then
        self.y = self.y - 64
        self.current_y_tile = self.y / 64 + 1
    elseif key == "s" and self.current_y_tile < 15 and (map1.tilemap[self.current_y_tile + 1][self.current_x_tile] == 1 or map1.tilemap[self.current_y_tile + 1][self.current_x_tile] == 2) then
        self.y = self.y + 64
        self.current_y_tile = self.y / 64 + 1
    elseif key == "a" and self.current_x_tile > 1 and (map1.tilemap[self.current_y_tile][self.current_x_tile - 1] == 1 or map1.tilemap[self.current_y_tile][self.current_x_tile - 1] == 2) then
        self.x = self.x - 64
        self.current_x_tile = self.x / 64 + 1
    elseif key == "d" and self.current_x_tile < 15 and (map1.tilemap[self.current_y_tile][self.current_x_tile + 1] == 1 or map1.tilemap[self.current_y_tile][self.current_x_tile + 1] == 2) then
        self.x = self.x + 64
        self.current_x_tile = self.x / 64 + 1
    end
end