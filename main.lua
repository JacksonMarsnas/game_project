function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "character"
    require "enemy"
    require "enemy1"
    window_width = 960
    window_height = 1024
    love.window.setMode(window_width, window_height)

    player = Character()
    map1 = Map1()
end

function love.update(dt)
    player:update(dt, map1.enemies)
end

function love.draw()
    map1:draw()
    player:draw()
end

function love.keypressed(key)
    if (key == "w" or key == "a" or key == "s" or key == "d") and player.movement_direction == "none" then
        player:move(key)
    end
end