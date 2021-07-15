Map4 = Map:extend()

function Map4:new()
    Map4.super.new(self)
    self.difficulty = 1.1
    self.tilemap = {
        {8, 8, 8, 8, 3, 3, 3, 3, 3, 8, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 6, 7, 5, 3, 8, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 7, 6, 7, 3, 8, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 3, 6, 7, 6, 3, 8, 8, 8, 8, 8, 8},
        {8, 8, 3, 3, 3, 7, 3, 3, 3, 3, 3, 8, 8, 8, 8},
        {8, 8, 3, 6, 7, 6, 3, 8, 3, 5, 3, 8, 8, 8, 8},
        {8, 8, 3, 7, 6, 7, 3, 8, 3, 7, 3, 8, 8, 8, 8},
        {8, 8, 3, 6, 7, 6, 3, 8, 3, 6, 3, 8, 8, 8, 8},
        {8, 8, 3, 7, 6, 7, 3, 8, 3, 7, 3, 8, 8, 8, 8},
        {8, 8, 3, 9, 7, 6, 3, 3, 3, 6, 3, 8, 8, 8, 8},
        {8, 8, 3, 4, 6, 7, 6, 7, 6, 7, 3, 8, 8, 8, 8},
        {8, 8, 3, 3, 3, 3, 3, 3, 3, 3, 3, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
        {8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8}
    }

    self.portals = {
        Next_Level(8, 2, 12, 13, "map3", 2, 3),
        Next_Level(10, 6, 3, 12, "map2", 1, 3)
    }

    self.chests = {
        Chest(4, 10)
    }
end

function Map4:update()
    
end

function Map4:draw()
    for row_number, row_info in ipairs(self.tilemap) do
        for tile_number, tile_info in ipairs(row_info) do
            love.graphics.draw(grass, grass_frames[tile_info], tile_number * 64 - 64, row_number * 64 - 64)
        end
    end

    for index, enemy in ipairs(self.enemies) do
        enemy:draw()
    end
end

function Map4:setup_enemies()
    self.enemies = {
        
    }
end