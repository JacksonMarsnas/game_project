Map5 = Map:extend()

function Map5:new()
    Map5.super.new(self)
    self.difficulty = 1.1
    self.tilemap = {
        {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 8, 8, 8, 8},
        {3, 6, 7, 6, 3, 3, 7, 6, 7, 5, 3, 8, 8, 8, 8},
        {3, 7, 6, 7, 3, 3, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {3, 9, 4, 6, 7, 6, 7, 6, 7, 6, 3, 8, 8, 8, 8},
        {3, 7, 6, 7, 3, 3, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {3, 6, 7, 6, 3, 3, 7, 6, 7, 6, 3, 8, 8, 8, 8},
        {3, 7, 6, 7, 3, 3, 3, 3, 3, 7, 3, 8, 8, 8, 8},
        {3, 3, 3, 3, 3, 3, 3, 3, 3, 6, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 7, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 6, 7, 6, 7, 6, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 7, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 6, 7, 6, 7, 6, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 7, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 6, 7, 5, 7, 6, 3, 8, 8, 8, 8}
    }

    self.portals = {
        Next_Level(8, 14, 3, 1, "map2", 1, 3),
        Next_Level(10, 2, 9, 13, "map6", 1, 1)
    }

    self.chests = {
        Chest(2, 4)
    }
end

function Map5:update()
    
end

function Map5:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end

function Map5:setup_enemies()
    self.enemies = {
        Enemy1(576, 128),
        Enemy1(320, 512),
        Enemy1(384, 576)
    }
end