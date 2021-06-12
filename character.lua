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
end

function Character:draw()
    love.graphics.draw(character_sheet, character_frames[1], self.x, self.y)
end

function Character:update()

end

function Character:move(key)
    if key == "w" then
        self.y = self.y - 64
    elseif key == "s" then
        self.y = self.y + 64
    elseif key == "a" then
        self.x = self.x - 64
    elseif key == "d" then
        self.x = self.x + 64
    end
end