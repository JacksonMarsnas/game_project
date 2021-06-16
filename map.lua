Map = Object:extend()

function Map:new()
    grass = love.graphics.newImage("grass.png")
    grass_frames = {}
    local tile_dimensions = 64
    for i = 0, 3 do
        table.insert(grass_frames, love.graphics.newQuad(i * tile_dimensions, 0, tile_dimensions, tile_dimensions, grass:getWidth(), grass:getHeight()))
    end
    self.tilemap = {}

    occupation_map = {}
    for i = 0, 14 do
        local new_line = {}
        for j = 0, 14 do
            table.insert(new_line, false)
        end
        table.insert(occupation_map, new_line)
    end
end

function Map:update()

end

function Map:draw()

end