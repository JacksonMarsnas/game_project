Map1 = Map:extend()

function Map1:new()
    Map1.super.new(self)
    tilemap = {
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
        Enemy1(640, 640),
        Enemy1(128, 192)
    }
end

function Map1:update()

end

function Map1:draw()
    for row_number, row_info in ipairs(tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end