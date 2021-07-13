Map6 = Map:extend()

function Map6:new()
    Map6.super.new(self)
    self.difficulty = 1.1
    self.tilemap = {
        {3, 3, 3, 3, 3, 3, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 6, 7, 6, 7, 3, 3, 8, 8, 8, 8, 8, 8, 8, 8},
        {3, 7, 6, 7, 6, 7, 3, 3, 8, 8, 8, 8, 8, 8, 8},
        {3, 6, 7, 6, 7, 6, 7, 3, 3, 8, 8, 8, 8, 8, 8},
        {3, 7, 6, 7, 6, 7, 6, 7, 3, 3, 3, 3, 3, 3, 3},
        {3, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 3},
        {3, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 7, 6, 3},
        {3, 3, 3, 7, 3, 3, 3, 3, 6, 7, 6, 7, 6, 7, 3},
        {3, 6, 7, 6, 7, 6, 7, 3, 7, 6, 7, 6, 7, 6, 3},
        {3, 7, 6, 7, 6, 7, 6, 3, 6, 7, 6, 7, 6, 7, 3},
        {3, 5, 7, 6, 7, 6, 7, 3, 7, 6, 7, 6, 7, 6, 3},
        {3, 3, 3, 3, 3, 3, 3, 3, 5, 7, 6, 7, 6, 7, 3},
        {8, 8, 8, 8, 8, 8, 8, 3, 3, 3, 3, 3, 3, 3, 3}
    }

    self.portals = {
        Next_Level(2, 12, 12, 13, "map3"),
        Next_Level(9, 13, 10, 2, "map5")
    }
end

function Map6:update()
    
end

function Map6:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end

function Map6:setup_enemies()
    self.enemies = {
        Enemy1(128, 128),
        Enemy1(192, 512),
        Enemy1(512, 384),
        Enemy1(640, 512),
        Enemy1(832, 640)
    }
end