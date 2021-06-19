function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "character"
    require "enemy"
    require "enemy1"
    require "death"
    require "moves"
    require "character_classes"
    require "character_select_screen"
    require "pause_screen"
    require "equipped_attacks"
    require "select_attacks_screen"
    require "effects"
    require "augmentation_screen"

    current_attack_slot = 1
    window_width = 960
    window_height = 1000
    love.window.setMode(window_width, window_height)

    myFont = love.graphics.newFont( "ARCADECLASSIC.TTF", 32)
    myFont:setFilter( "nearest", "nearest" )
    love.graphics.setFont(myFont)

    map1 = Map1()
    death = Death()
    player = Character(0, 0, 0, 0, 0)
    effects = Effects()
    moves = Moves()
    character_classes = Character_classes()
    character_select_screen = Character_Select_Screen()
    pause_screen = Pause_Screen()
    equipped_attacks = Equipped_Attacks()
    select_attacks_screen = Select_Attacks_Screen()
    augmentation_screen = Augmentation_Screen()

    all_maps = {
        death_screen = death,
        map_1 = map1
    }

    current_map = all_maps[map1]
    game_state = "character_select"
end

function love.update(dt)
    if game_state == "play" then
        player:update(dt, map1.enemies)
        for index, enemy in ipairs(map1.enemies) do
            enemy:update(dt)
        end
    end

    
end

function love.draw()
    if game_state == "character_select" then
        character_select_screen:draw()
    elseif game_state == "play" then
        love.graphics.setFont(myFont)
        all_maps[player.current_map]:draw()
        player:draw()
    elseif game_state == "pause" then
        pause_screen:draw()
    elseif game_state == "equipped_attacks" then
        equipped_attacks:draw()
    elseif game_state == "select_attacks" then
        select_attacks_screen:draw()
    elseif game_state == "augmentation_screen" then
        augmentation_screen:draw()
    end
end

function love.keypressed(key)
    if game_state ~= "character_select" then
        if player.health > 0 and player.current_action == "none" then
            local allow_player_action = true
            for index, enemy in ipairs(map1.enemies) do
                if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
                    allow_player_action = false
                end
            end

            if allow_player_action == true and player.bullet_is_present == false then
                player.regen_check = false
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
                elseif key == "e" and game_state == "play" and tilemap[player.current_y_tile][player.current_x_tile] == 4 then
                    game_state = "equipped_attacks"
                elseif key == "escape" then
                    if game_state == "play" then
                        game_state = "pause"
                    elseif game_state == "pause" then
                        game_state = "play"
                    end
                end
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if game_state == "select_attacks" then
        select_attacks_screen:mouseClicked(x, y, button)
    elseif game_state == "equipped_attacks" then
        equipped_attacks:mouseClicked(x, y, button)
    elseif game_state == "character_select" then
        character_select_screen:mouseClicked(x, y, button)
    elseif game_state == "augmentation_screen" then
        augmentation_screen:mouseClicked(x, y, button)
    end
end

function love.wheelmoved(x, y)
    if game_state == "select_attacks" then
        select_attacks_screen:scroll(x, y)
    end
end