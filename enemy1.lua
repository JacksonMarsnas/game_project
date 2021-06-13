Enemy1 = Enemy:extend()

function Enemy1:new(starting_x, starting_y)
    enemy1_sheet = love.graphics.newImage("enemy_1.png")
    enemy1_frames = {}

    for i = 0, 20 do
        for j = 0, 12 do
            table.insert(enemy1_frames, love.graphics.newQuad(j * sprite_dimensions, i * sprite_dimensions, sprite_dimensions, sprite_dimensions, enemy1_sheet:getWidth(), enemy1_sheet:getHeight()))
        end
    end

    self.x = starting_x
    self.y = starting_y
    self.current_x = self.x / 64 + 1
    self.current_y = self.y / 64 + 1

    occupation_map[self.current_y][self.current_x] = true
end

function Enemy1:draw()
    love.graphics.draw(enemy1_sheet, enemy1_frames[1], self.x, self.y)
end

function Enemy1:move(player_x_tile, player_y_tile)
    local x_difference = self.current_x - player_x_tile
    local y_difference = self.current_y - player_y_tile
    occupation_map[self.current_y][self.current_x] = false

    if (math.abs(x_difference) == 1 and math.abs(y_difference) == 0) or (math.abs(y_difference) == 1 and math.abs(x_difference) == 0) then
        --attack
    elseif math.abs(x_difference) > math.abs(y_difference) then
        if x_difference < 0 then
            if self:check_occupation(1, 0) == true then
                self.x = self.x + 64
                self.current_x = self.current_x + 1
            elseif y_difference < 0 and self:check_occupation(0, 1) == true then
                self.y = self.y + 64
                self.current_y = self.current_y + 1
            elseif y_difference >= 0 and self:check_occupation(0, -1) == true then
                self.y = self.y - 64
                self.current_y = self.current_y - 1
            end
        elseif x_difference >= 0 then
            if self:check_occupation(-1, 0) == true then
                self.x = self.x - 64
                self.current_x = self.current_x - 1
            elseif y_difference < 0 and self:check_occupation(0, 1) == true then
                self.y = self.y + 64
                self.current_y = self.current_y + 1
            elseif y_difference >= 0 and self:check_occupation(0, -1) == true then
                self.y = self.y - 64
                self.current_y = self.current_y - 1
            end
        end
    else
        if y_difference < 0 then
            if self:check_occupation(0, 1) == true then
                self.y = self.y + 64
                self.current_y = self.current_y + 1
            elseif x_difference < 0 and self:check_occupation(1, 0) == true then
                self.x = self.x + 64
                self.current_x = self.current_x + 1
            elseif x_difference >= 0 and self:check_occupation(-1, 0) == true then
                self.x = self.x - 64
                self.current_x = self.current_x - 1
            end
        elseif y_difference >= 0 then
            if self:check_occupation(0, -1) == true then
                self.y = self.y - 64
                self.current_y = self.current_y - 1
            elseif x_difference < 0 and self:check_occupation(1, 0) == true then
                self.x = self.x + 64
                self.current_x = self.current_x + 1
            elseif x_difference >= 0 and self:check_occupation(-1, 0) == true then
                self.x = self.x - 64
                self.current_x = self.current_x - 1
            end
        end
    end
    occupation_map[self.current_y][self.current_x] = true
end

function Enemy1:check_occupation(x_offset, y_offset)
    if tilemap[self.current_y + y_offset][self.current_x + x_offset] ~= 1 and tilemap[self.current_y + y_offset][self.current_x + x_offset] ~= 2 then
        return false
    elseif occupation_map[self.current_y + y_offset][self.current_x + x_offset] == true then
        return false
    end
    return true
end