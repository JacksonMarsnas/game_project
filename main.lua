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

    current_attack_slot = 1
    window_width = 960
    window_height = 1000
    love.window.setMode(window_width, window_height)

    myFont = love.graphics.newFont( "ARCADECLASSIC.TTF", 32)
    myFont:setFilter( "nearest", "nearest" )
    love.graphics.setFont(myFont)

    map1 = Map1()
    death = Death()
    moves = Moves()
    character_classes = Character_classes()

    all_maps = {
        death_screen = death,
        map_1 = map1
    }
    current_map = all_maps[map1]
    game_state = "character_select"
    setup_character_screen()
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
        character_select()
    elseif game_state == "play" then
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

function setup_character_screen()
    local character_select_text = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    character_select_text:setFilter( "nearest", "nearest" )

    character_list = {}
    for index, current_character in ipairs(character_classes.all_characters) do
        table.insert(character_list, 
        {name = love.graphics.newText(character_select_text, current_character["name"]),
        display_name = current_character["name"],
        health = current_character["health"],
        strength = current_character["strength"],
        skill = current_character["skill"],
        arcane = current_character["arcane"],
        holy = current_character["holy"],
        x = 20,
        y = 256 + index * 64,
        selected = false})
    end
    character_list[1]["selected"] = true
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

function character_select()
    local character_select_text = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    local character_select_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    character_select_header:setFilter( "nearest", "nearest" )
    character_select_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(character_select_header)
    love.graphics.printf("SELECT YOUR CHARACTER", 0, 128, 960, "center")
    love.graphics.setFont(character_select_text)
    love.graphics.printf("Click on a character to view more info about them.", 0, 216, 960, "center")
    
    for index, current_character in ipairs(character_list) do
        love.graphics.draw(current_character.name, current_character.x, current_character.y)
        if current_character["selected"] == true then
            love.graphics.print("Name: " .. current_character.display_name, 500, 300)
            love.graphics.print("Health: " .. current_character.health, 500, 350)
            love.graphics.print("Strength: " .. current_character.strength, 500, 400)
            love.graphics.print("Skill: " .. current_character.skill, 500, 450)
            love.graphics.print("Arcane: " .. current_character.arcane, 500, 500)
            love.graphics.print("Holy: " .. current_character.holy, 500, 550)
        end
    end

    start_button = {
        text = love.graphics.newText(character_select_text, "START"),
        x = 500,
        y = 650
    }
    love.graphics.draw(start_button["text"], start_button["x"], start_button["y"])
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
    elseif game_state == "character_select" then
        if love.mouse.getX() >= start_button["x"] and love.mouse.getX() <= start_button["x"] + start_button.text:getWidth() and love.mouse.getY() >= start_button["y"] and love.mouse.getY() <= start_button["y"] + start_button.text:getHeight() then
            for index, current_character in ipairs(character_list) do
                if current_character["selected"] == true then
                    player = Character(current_character.health, current_character.strength, current_character.skill, current_character.arcane, current_character.holy)
                    game_state = "play"
                end
            end
        end
        for index, current_character in ipairs(character_list) do
            if love.mouse.getX() >= current_character.x and love.mouse.getX() <= current_character.x + current_character.name:getWidth() and love.mouse.getY() >= current_character.y and love.mouse.getY() <= current_character.y + current_character.name:getHeight() then
                for index, deleted_character in ipairs(character_list) do
                    deleted_character["selected"] = false
                end
                current_character["selected"] = true
            end
        end
    end
end