function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    window_width = 960
    window_height = 960
    love.window.setMode(window_width, window_height)

    map1 = Map1()
end

function love.update()

end

function love.draw()
    map1:draw()
end
