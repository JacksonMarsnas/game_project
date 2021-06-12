function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "character"
    window_width = 960
    window_height = 960
    love.window.setMode(window_width, window_height)
    tester = false

    map1 = Map1()
    player = Character()
end

function love.update()

end

function love.draw()
    map1:draw()
    player:draw()
    if tester == true then
        love.graphics.rectangle("fill", 128, 192, 64, 64)
    end
end

function love.keypressed(key)
    if key == "w" or key == "a" or key == "s" or key == "d" then
        player:move(key)
    end
end