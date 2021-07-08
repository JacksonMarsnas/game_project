Map3 = Map:extend()

function Map3:new()
    Map3.super.new(self)
    self.difficulty = 1.1
    self.tilemap = {
        {3, 3, 3, 3, 3, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 5, 6, 7, 6, 3, 3, 3, 3, 3, 3, 8, 8, 8, 8},
        {3, 6, 7, 6, 7, 6, 7, 6, 7, 6, 3, 8, 8, 8, 8},
        {3, 7, 6, 7, 6, 3, 3, 3, 3, 7, 3, 8, 8, 8, 8},
        {3, 6, 7, 6, 7, 3, 8, 8, 3, 6, 3, 8, 8, 8, 8},
        {3, 7, 6, 7, 6, 3, 8, 3, 3, 7, 3, 3, 3, 8, 8},
        {3, 6, 7, 6, 7, 3, 8, 3, 7, 6, 7, 6, 3, 8, 8},
        {3, 3, 3, 3, 3, 3, 8, 3, 6, 7, 6, 7, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 7, 6, 7, 6, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 6, 7, 6, 7, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 7, 6, 7, 6, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 6, 7, 6, 7, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 7, 6, 7, 5, 3, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 3, 3, 3, 3, 3, 3, 8, 8}
    }

    self.portals = {
        Next_Level(2, 2, 11, 3, "map2"),
        Next_Level(12, 13, 8, 2, "map4")
    }
end

function Map3:update()

end

function Map3:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end

function Map3:setup_enemies()
    self.enemies = {
        Enemy1(384, 128),
        Enemy1(512, 640),
        Enemy1(704, 640)
    }
end