function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "character"
    require "enemy"
    require "enemy1"
    require "death"
    require "moves"

    window_width = 960
    window_height = 1000
    love.window.setMode(window_width, window_height)

    myFont = love.graphics.newFont( "ARCADECLASSIC.TTF", 32)
    myFont:setFilter( "nearest", "nearest" )
    love.graphics.setFont(myFont)

    player = Character()
    map1 = Map1()
    death = Death()
    moves = Moves()

    all_maps = {
        death_screen = death,
        map_1 = map1
    }
    current_map = all_maps[map1]
    game_state = "play"
end

function love.update(dt)
    player:update(dt, map1.enemies)
    for index, enemy in ipairs(map1.enemies) do
        enemy:update(dt)
    end
end

function love.draw()
    if game_state == "play" then
        love.graphics.setFont(myFont)
        all_maps[player.current_map]:draw()
        player:draw()
    else
        pause_screen()
    end
end

function love.keypressed(key)
    if player.health > 0 and player.current_action == "none" then
        local allow_player_action = true
        for index, enemy in ipairs(map1.enemies) do
            if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
                allow_player_action = false
            end
        end

        if allow_player_action == true then
            if (key == "w" or key == "a" or key == "s" or key == "d") and game_state == "play" then
                player:move(key)
            elseif (key == "up" or key == "down" or key == "left" or key == "right") and game_state == "play" then
                if key == "up" then
                    player:attack(key, 0, -1, map1.enemies)
                elseif key == "down" then
                    player:attack(key, 0, 1, map1.enemies)
                elseif key == "left" then
                    player:attack(key, -1, 0, map1.enemies)
                elseif key == "right" then
                    player:attack(key, 1, 0, map1.enemies)
                end
            elseif key == "q" and game_state == "play" then
                player:swap_weapons()
            elseif key == "escape" then
                if game_state == "play" then
                    game_state = "pause"
                else
                    game_state = "play"
                end
            end
        end
    end
end

function pause_screen()
    local pause_font = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    pause_font:setFilter( "nearest", "nearest" )
    love.graphics.setFont(pause_font)
    love.graphics.printf("PAUSED", 0, window_height / 2 - pause_font:getHeight() / 2, 960, "center")
end