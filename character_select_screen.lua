Character_Select_Screen = Map:extend()

function Character_Select_Screen:new()
    Character_Select_Screen.super.new(self)

    self:setup()
    self:make_character_list()
end

function Character_Select_Screen:update()

end

function Character_Select_Screen:draw()
    love.graphics.setFont(character_select_header)
    love.graphics.printf("SELECT YOUR CHARACTER", 0, 128, 960, "center")
    love.graphics.setFont(character_select_text)
    love.graphics.printf("Click on a character to view more info about them.", 0, 216, 960, "center")

    self:draw_characters()
    self:start_button()
end

function Character_Select_Screen:make_character_list()
    character_list = {}
    for index, current_character in ipairs(character_classes.all_characters) do
        table.insert(character_list, 
        {name = love.graphics.newText(character_select_text, current_character["name"]),
        display_name = current_character["name"],
        vitality = current_character["vitality"],
        strength = current_character["strength"],
        skill = current_character["skill"],
        arcane = current_character["arcane"],
        holy = current_character["holy"],
        agility = current_character["agility"],
        resilience = current_character["resilience"],
        level = current_character["level"],
        x = 20,
        y = 256 + index * 64,
        selected = false})
    end
    character_list[1]["selected"] = true
end

function Character_Select_Screen:setup()
    character_select_text = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    character_select_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    character_select_header:setFilter( "nearest", "nearest" )
    character_select_text:setFilter( "nearest", "nearest" )
end

function Character_Select_Screen:draw_characters()
    for index, current_character in ipairs(character_list) do
        love.graphics.draw(current_character.name, current_character.x, current_character.y)
        if current_character["selected"] == true then
            love.graphics.print("Name: " .. current_character.display_name, 500, 300)
            love.graphics.print("vitality: " .. current_character.vitality, 500, 350)
            love.graphics.print("Strength: " .. current_character.strength, 500, 400)
            love.graphics.print("Skill: " .. current_character.skill, 500, 450)
            love.graphics.print("Arcane: " .. current_character.arcane, 500, 500)
            love.graphics.print("Holy: " .. current_character.holy, 500, 550)
            love.graphics.print("Agility: " .. current_character.agility, 500, 600)
            love.graphics.print("Resilience: " .. current_character.resilience, 500, 650)
        end
    end
end

function Character_Select_Screen:start_button()
    start_button = {
        text = love.graphics.newText(character_select_text, "START"),
        x = 480,
        y = 800
    }
    love.graphics.draw(start_button["text"], start_button["x"] - start_button.text:getWidth() / 2, start_button["y"])
end

function Character_Select_Screen:mouseClicked(x, y, button)
    self:click_start_button(x, y, button)
    self:click_character(x, y, button)
end

function Character_Select_Screen:click_start_button(x, y, button)
    if love.mouse.getX() >= start_button["x"] - start_button.text:getWidth() / 2 and love.mouse.getX() <= start_button["x"] + start_button.text:getWidth() / 2 and love.mouse.getY() >= start_button["y"] and love.mouse.getY() <= start_button["y"] + start_button.text:getHeight() then
        for index, current_character in ipairs(character_list) do
            if current_character["selected"] == true then
                player = Character(current_character.vitality, current_character.strength, current_character.skill, current_character.arcane, current_character.holy, current_character.agility, current_character.level, current_character.resilience)
                player.attacks = {moves.all_moves[1], moves.all_moves[2], moves.all_moves[3]}
                game_state = "play"
            end
        end
    end
end

function Character_Select_Screen:click_character(x, y, button)
    for index, current_character in ipairs(character_list) do
        if love.mouse.getX() >= current_character.x and love.mouse.getX() <= current_character.x + current_character.name:getWidth() and love.mouse.getY() >= current_character.y and love.mouse.getY() <= current_character.y + current_character.name:getHeight() then
            for index, deleted_character in ipairs(character_list) do
                deleted_character["selected"] = false
            end
            current_character["selected"] = true
        end
    end
end