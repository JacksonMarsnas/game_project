Map2 = Map:extend()

function Map2:new()
    Map2.super.new(self)
    self.difficulty = 1
    self.tilemap = {
        {8, 3, 5, 3, 8, 3, 3, 3, 3, 3, 3, 3, 8, 8, 8},
        {8, 3, 6, 3, 3, 3, 6, 7, 6, 7, 6, 3, 8, 8, 8},
        {8, 3, 7, 6, 7, 6, 7, 6, 7, 6, 5, 3, 8, 8, 8},
        {8, 3, 6, 3, 3, 3, 6, 7, 6, 7, 6, 3, 8, 8, 8},
        {3, 3, 7, 3, 3, 3, 3, 3, 3, 3, 3, 3, 8, 8, 8},
        {3, 7, 6, 7, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 6, 7, 6, 3, 8, 3, 3, 3, 3, 3, 3, 3, 3, 3},
        {3, 7, 6, 7, 3, 3, 3, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 3, 6, 3, 3, 3, 3, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 6, 7, 6, 3, 8, 3, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 7, 6, 7, 3, 8, 3, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 6, 7, 6, 3, 8, 3, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 3, 3, 3, 3, 8, 3, 5, 3, 3, 3, 3, 3, 3, 3}
    }

    self.portals = {
        Next_Level(8, 14, 8, 1, "map1"),
        Next_Level(3, 1, 8, 14, "map5"),
        Next_Level(11, 3, 2, 2, "map3")
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
        Enemy1(576, 128),
        Enemy1(128, 320),
        Enemy1(128, 768),
        Enemy1(640, 512),
        Enemy1(832, 512)
    }
end