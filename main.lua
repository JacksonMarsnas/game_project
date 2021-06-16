function love.load()
    Object = require "classic"
    require "map"
    require "map1"
    require "character"
    require "enemy"
    require "enemy1"
    require "death"
    require "moves"

    current_attack_slot = 1
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
    if game_state == "play" then
        player:update(dt, map1.enemies)
        for index, enemy in ipairs(map1.enemies) do
            enemy:update(dt)
        end
    end
end

function love.draw()
    if game_state == "play" then
        love.graphics.setFont(myFont)
        all_maps[player.current_map]:draw()
        player:draw()
    elseif game_state == "pause" then
        pause_screen()
    elseif game_state == "player_attacks_info" then
        player_attacks_info()
    elseif game_state == "select_attacks" then
        select_attacks_screen()
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
            elseif key == "e" and game_state == "play" and tilemap[player.current_y_tile][player.current_x_tile] == 4 then
                game_state = "player_attacks_info"
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

function pause_screen()
    local pause_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    local pause_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    pause_header:setFilter( "nearest", "nearest" )
    pause_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(pause_header)
    love.graphics.printf("PAUSED", 0, 128, 960, "center")
    love.graphics.setFont(pause_text)
    change_moves_text = {text = love.graphics.newText(pause_text, "CHANGE ATTACKS"), x = 480, y = 192}
    love.graphics.draw(change_moves_text.text, change_moves_text.x - change_moves_text.text:getWidth() / 2, change_moves_text.y)
    if love.mouse.isDown(1) and love.mouse.getX() >= change_moves_text.x - change_moves_text.text:getWidth() / 2 and love.mouse.getX() <= change_moves_text.x + change_moves_text.text:getWidth() / 2 and love.mouse.getY() >= change_moves_text.y and love.mouse.getY() <= change_moves_text.y + change_moves_text.text:getHeight() then
        game_state = "select_attacks"
    end
end

function player_attacks_info()
    local attacks_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    local attacks_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    attacks_header:setFilter( "nearest", "nearest" )
    attacks_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(attacks_header)
    love.graphics.printf("EQUIPPED ATTACKS", 0, 128, 960, "center")
    love.graphics.setFont(attacks_text)
    love.graphics.printf("Click on one of them to change it.", 0, 216, 960, "center")

    moves_list = {}
    for index, attack in ipairs(player.attacks) do
        table.insert(moves_list, {text = love.graphics.newText(attacks_text, moves.all_moves[attack]["name"] .. " - Type: " .. moves.all_moves[attack]["type"] .. " - Power: " .. moves.all_moves[attack]["power"]),
        x = 480,
        y = 256 + index * 64,
        id = index})
    end

    for index, attack in ipairs(moves_list) do
        love.graphics.draw(attack.text, attack.x - attack.text:getWidth() / 2, attack.y)
    end
end

function select_attacks_screen()
    local attacks_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    local attacks_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    attacks_header:setFilter( "nearest", "nearest" )
    attacks_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(attacks_header)
    love.graphics.printf("SELECT YOUR MOVES", 0, 128, 960, "center")
    love.graphics.setFont(attacks_text)

    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Power: " .. attack["power"]),
        x = 480,
        y = 192 + index * 64,
        id = index})
    end

    for index, attack in ipairs(moves_list) do
        love.graphics.draw(attack.text, attack.x - attack.text:getWidth() / 2, attack.y)
    end
end

function love.mousepressed(x, y, button)
    if game_state == "select_attacks" then
        for index, attack in ipairs(moves_list) do
            if love.mouse.getX() >= attack.x - attack.text:getWidth() / 2 and love.mouse.getX() <= attack.x + attack.text:getWidth() / 2 and love.mouse.getY() >= attack.y and love.mouse.getY() <= attack.y + attack.text:getHeight() then
                player.attacks[current_attack_slot] = attack["id"]
                game_state = "play"
            end
        end
    elseif game_state == "player_attacks_info" then
        for index, attack in ipairs(moves_list) do
            if love.mouse.getX() >= attack.x - attack.text:getWidth() / 2 and love.mouse.getX() <= attack.x + attack.text:getWidth() / 2 and love.mouse.getY() >= attack.y and love.mouse.getY() <= attack.y + attack.text:getHeight() then
                current_attack_slot = attack["id"]
                game_state = "select_attacks"
            end
        end
    end
end