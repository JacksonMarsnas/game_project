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

    self.movement_direction = "none"
    self.x = 128
    self.y = 128
    self.current_x_tile = self.x / 64 + 1
    self.current_y_tile = self.y / 64 + 1
end

function Character:draw()
    love.graphics.draw(character_sheet, character_frames[1], self.x, self.y)
end

function Character:update(dt)
    if self.movement_animation ~= "none" then
        self:movement_animation(dt)
    end
end

function Character:move(key)
    if key == "w" and self.current_y_tile > 1 and (tilemap[self.current_y_tile - 1][self.current_x_tile] == 1 or tilemap[self.current_y_tile - 1][self.current_x_tile] == 2) then
        self.next_y_tile = self.current_y_tile - 1
        self.movement_direction = "up"
    elseif key == "s" and self.current_y_tile < 15 and (tilemap[self.current_y_tile + 1][self.current_x_tile] == 1 or tilemap[self.current_y_tile + 1][self.current_x_tile] == 2) then
        self.next_y_tile = self.current_y_tile + 1
        self.movement_direction = "down"
    elseif key == "a" and self.current_x_tile > 1 and (tilemap[self.current_y_tile][self.current_x_tile - 1] == 1 or tilemap[self.current_y_tile][self.current_x_tile - 1] == 2) then
        self.next_x_tile = self.current_x_tile - 1
        self.movement_direction = "left"
    elseif key == "d" and self.current_x_tile < 15 and (tilemap[self.current_y_tile][self.current_x_tile + 1] == 1 or tilemap[self.current_y_tile][self.current_x_tile + 1] == 2) then
        self.next_x_tile = self.current_x_tile + 1
        self.movement_direction = "right"
    end
end

function Character:movement_animation(dt)
    if self.movement_direction == "up" and self.y >= (self.next_y_tile - 1) * 64 then
        self.y = self.y - 100 * dt
        if self.y <= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.movement_direction = "none"
        end
    elseif self.movement_direction == "down" and self.y <= (self.next_y_tile - 1) * 64 then
        self.y = self.y + 100 * dt
        if self.y >= (self.next_y_tile - 1) * 64 then
            self.y = (self.next_y_tile - 1) * 64
            self.current_y_tile = self.y / 64 + 1
            self.movement_direction = "none"
        end
    elseif self.movement_direction == "left" and self.x >= (self.next_x_tile - 1) * 64 then
        self.x = self.x - 100 * dt
        if self.x <= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.movement_direction = "none"
        end
    elseif self.movement_direction == "right" and self.x <= (self.next_x_tile - 1) * 64 then
        self.x = self.x + 100 * dt
        if self.x >= (self.next_x_tile - 1) * 64 then
            self.x = (self.next_x_tile - 1) * 64
            self.current_x_tile = self.x / 64 + 1
            self.movement_direction = "none"
        end
    end
end