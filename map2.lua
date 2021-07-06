Map2 = Map:extend()

function Map2:new()
    Map2.super.new(self)
    self.difficulty = 2
    self.tilemap = {
        {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 8},
        {3, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 5, 3, 8},
        {3, 7, 6, 7, 6, 7, 6, 3, 3, 7, 6, 7, 6, 3, 8},
        {3, 6, 7, 6, 7, 6, 7, 3, 3, 3, 3, 3, 3, 3, 8},
        {3, 7, 3, 3, 3, 3, 3, 3, 8, 8, 8, 8, 8, 8, 8},
        {3, 6, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 7, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 6, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
        {3, 6, 7, 6, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 7, 6, 7, 7, 3, 7, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 6, 7, 6, 6, 3, 6, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 7, 6, 7, 7, 3, 7, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 3, 3, 3, 3, 3, 5, 3, 3, 3, 3, 3, 3, 3, 3}
    }

    self.portals = {
        Next_Level(7, 14, 8, 1, "map1"),
        Next_Level(13, 2, 8, 1, "map1")
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

function Map2:setup_enemies()
    self.enemies = {
        Enemy1(640, 640),
        Enemy2(64, 0)
    }
end