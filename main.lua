function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "map2"
    require "character"
    require "enemy"
    require "enemy1"
    require "enemy2"
    require "death"
    require "moves"
    require "character_classes"
    require "character_select_screen"
    require "pause_screen"
    require "equipped_attacks"
    require "select_attacks_screen"
    require "effects"
    require "augmentation_screen"
    require "attack_sequence"
    require "dodge_sequence"
    require "character_modification"
    require "level_up"
    require "next_level"

    current_attack_slot = 1
    window_width = 960
    window_height = 1000
    love.window.setMode(window_width, window_height)

    myFont = love.graphics.newFont( "ARCADECLASSIC.TTF", 32)
    myFont:setFilter( "nearest", "nearest" )
    love.graphics.setFont(myFont)

    occupation_map = {}
    for i = 0, 13 do
        local new_line = {}
        for j = 0, 14 do
            table.insert(new_line, false)
        end
        table.insert(occupation_map, new_line)
    end

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
    character_modification = Character_Modification()

    all_maps = {
        death_screen = death,
        map1 = Map1(),
        map2 = Map2()
    }

    all_maps["map1"]:setup_enemies()
    current_map = all_maps[map1]
    game_state = "character_select"
end

function love.update(dt)
    if player.current_map ~= "death_screen" then
        if game_state == "play" then
            verify_player_movement()
            player:update(dt, all_maps[player.current_map]["enemies"])
            for index, enemy in ipairs(all_maps[player.current_map]["enemies"]) do
                enemy:update(dt)
            end
        elseif game_state == "attacking" then
            attack_action:update(dt)
        elseif game_state == "dodging" then
            dodge_action:update(dt)
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
    elseif game_state == "attacking" then
        love.graphics.setFont(myFont)
        all_maps[player.current_map]:draw()
        player:draw()
        attack_action:draw()
    elseif game_state == "dodging" then
        love.graphics.setFont(myFont)
        all_maps[player.current_map]:draw()
        player:draw()
        dodge_action:draw()
    elseif game_state == "pause" then
        pause_screen:draw()
    elseif game_state == "equipped_attacks" then
        equipped_attacks:draw()
    elseif game_state == "select_attacks" then
        select_attacks_screen:draw()
    elseif game_state == "augmentation_screen" then
        augmentation_screen:draw()
    elseif game_state == "character_modification" then
        character_modification:draw()
    elseif game_state == "level_up" then
        level_up:draw()
    end
end

function verify_player_movement()
    if game_state ~= "character_select" then
        if player.health > 0 and player.current_action == "none" then
            local allow_player_action = true
            for index, enemy in ipairs(all_maps[player.current_map]["enemies"]) do
                if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
                    allow_player_action = false
                end
            end

            if allow_player_action == true and player.bullet_is_present == false and player.regen_check == true then
                if love.keyboard.isDown("w", "a", "s", "d") then
                    player.regen_check = false
                end
                if love.keyboard.isDown("w") then
                    player:move("w")
                elseif love.keyboard.isDown("a") then
                    player:move("a")
                elseif love.keyboard.isDown("s") then
                    player:move("s")
                elseif love.keyboard.isDown("d") then
                    player:move("d")
                end
            end
        end
    end
end

function love.keypressed(key)
    if key == "space" and game_state == "attacking" then
        attack_action:damage()
    elseif key == "space" and game_state == "dodging" then
        dodge_action:damage()
    end

    if game_state ~= "character_select" then
        if player.health > 0 and player.current_action == "none" then
            local allow_player_action = true
            for index, enemy in ipairs(all_maps[player.current_map]["enemies"]) do
                if enemy.animation_state ~= "idle_up" and enemy.animation_state ~= "idle_down" and enemy.animation_state ~= "idle_left" and enemy.animation_state ~= "idle_right" and enemy.animation_state ~= "dead" then
                    allow_player_action = false
                end
            end

            if allow_player_action == true and player.bullet_is_present == false and player.regen_check == true then
                if (key == "up" or key == "down" or key == "left" or key == "right") and game_state == "play" then
                    player.regen_check = false
                end
                if (key == "up" or key == "down" or key == "left" or key == "right") and game_state == "play" then
                    if key == "up" then
                        player:attack(key, 0, -1, all_maps[player.current_map]["enemies"])
                    elseif key == "down" then
                        player:attack(key, 0, 1, all_maps[player.current_map]["enemies"])
                    elseif key == "left" then
                        player:attack(key, -1, 0, all_maps[player.current_map]["enemies"])
                    elseif key == "right" then
                        player:attack(key, 1, 0, all_maps[player.current_map]["enemies"])
                    end
                elseif key == "q" and game_state == "play" then
                    player:swap_weapons()
                elseif key == "e" and game_state == "play" then
                    if all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] == 4 then
                        game_state = "character_modification"
                    elseif all_maps[player.current_map].tilemap[player.current_y_tile][player.current_x_tile] == 5 then
                        all_maps[player.current_map]:transport()
                    end
                elseif key == "escape" then
                    if game_state == "play" then
                        game_state = "pause"
                    elseif game_state == "pause" or game_state == "character_modification" then
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
    elseif game_state == "character_modification" then
        character_modification:mouseClicked(x, y, button)
    elseif game_state == "level_up" then
        level_up:mouseClicked(x, y, button)
    end
end

function love.wheelmoved(x, y)
    if game_state == "select_attacks" then
        select_attacks_screen:scroll(x, y)
    end
end