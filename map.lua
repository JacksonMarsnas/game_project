Map = Object:extend()

function Map:new()
    grass = love.graphics.newImage("grass.png")
    grass_frames = {}
    local tile_dimensions = 64
    for i = 0, 9 do
        table.insert(grass_frames, love.graphics.newQuad(i * tile_dimensions, 0, tile_dimensions, tile_dimensions, grass:getWidth(), grass:getHeight()))
    end
    self.tilemap = {}
    self.vision_map = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    }
end

function Map:update()

end

function Map:draw()

end

function Map:transport()
    occupation_map = {}
    for i = 0, 13 do
        local new_line = {}
        for j = 0, 14 do
            table.insert(new_line, false)
        end
        table.insert(occupation_map, new_line)
    end
    
    for index, portal in ipairs(self.portals) do
        if player.x == portal.x and player.y == portal.y then
            player.current_map = portal.next_map
            player.x = portal.next_x
            player.y = portal.next_y
            player.current_x_tile = player.x / 64 + 1
            player.current_y_tile = player.y / 64 + 1
            all_maps[portal.next_map]:setup_enemies()
            player:line_of_sight(player.current_x_tile, player.current_y_tile, 0)
            player.mega_map_x = portal.next_mega_map_x
            player.mega_map_y = portal.next_mega_map_y
        end
    end
end

function Map:loot_chest()
    for index, chest in ipairs(self.chests) do
        if player.x == chest.x and player.y == chest.y then
            chest:loot()
        end
    end
end