Map2 = Map:extend()

function Map2:new()
    Map2.super.new(self)
    self.tilemap = {
        {1, 2, 1, 4, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 3, 3, 3, 3, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 2, 1, 2, 3, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 3, 2, 1, 3, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 3, 3, 3, 3, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2},
        {1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1},
        {2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2}
    }

    self.enemies = {
        Enemy1(640, 640)
    }
end

function Map2:update()

end

function Map2:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end