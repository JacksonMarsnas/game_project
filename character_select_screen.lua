Character_Select_Screen = Map:extend()

function Character_Select_Screen:new()
    Character_Select_Screen.super.new(self)

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

function Character_Select_Screen:update()

end

function Character_Select_Screen:draw()
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

function Character_Select_Screen:mouseClicked(x, y, button)
    if love.mouse.getX() >= start_button["x"] and love.mouse.getX() <= start_button["x"] + start_button.text:getWidth() and love.mouse.getY() >= start_button["y"] and love.mouse.getY() <= start_button["y"] + start_button.text:getHeight() then
        for index, current_character in ipairs(character_list) do
            if current_character["selected"] == true then
                player = Character(current_character.health, current_character.strength, current_character.skill, current_character.arcane, current_character.holy)
                player.attacks = {moves.all_moves[6], moves.all_moves[7], moves.all_moves[2]}
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