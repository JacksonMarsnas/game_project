Map1 = Map:extend()

function Map1:new()
    Map1.super.new(self)
    self.difficulty = 1
    self.tilemap = {
        {8, 8, 8, 8, 8, 3, 6, 5, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8}
    }

    self.portals = {
        Next_Level(8, 1, 7, 14, "map2")
    }
end

function Map1:update()

end

function Map1:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end

    for index, portal in ipairs(self.portals) do
        portal:draw()
    end
end

function Map1:setup_enemies()
    self.enemies = {
        Enemy1(448, 832)
    }
end