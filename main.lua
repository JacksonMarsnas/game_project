function love.load()
    window_width = 960
    window_height = 960
    love.window.setMode(window_width, window_height)

    grass = love.graphics.newImage("grass.png")
    grass_frames = {}
    tile_dimensions = 64
    for i = 0, 1 do
        table.insert(grass_frames, love.graphics.newQuad(i * tile_dimensions, 0, tile_dimensions, tile_dimensions, grass:getWidth(), grass:getHeight()))
    end

    tilemap = {{1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
        {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
        {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1}
    }
end

function love.update()

end

function love.draw()
    for column = 0, window_width / tile_dimensions do
        for row = 0, window_height / tile_dimensions do
            if (column % 2 == 0 and row % 2 == 1) or (column % 2 == 1 and row % 2 == 0) then
                love.graphics.draw(grass, grass_frames[1], column * 64 - 64, row * 64 - 64)
            elseif (column % 2 == 0 and row % 2 == 0) or (column % 2 == 1 and row % 2 == 1) then
                love.graphics.draw(grass, grass_frames[2], column * 64 - 64, row * 64 - 64)
            end
        end
    end
end
