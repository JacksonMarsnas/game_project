Select_Attacks_Screen = Map:extend()

function Select_Attacks_Screen:new()
    Select_Attacks_Screen.super.new(self)
end

function Select_Attacks_Screen:update()

end

function Select_Attacks_Screen:draw()
    local attacks_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    local attacks_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    attacks_header:setFilter( "nearest", "nearest" )
    attacks_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(attacks_header)
    love.graphics.printf("SELECT YOUR MOVES", 0, 128, 960, "center")
    love.graphics.setFont(attacks_text)

    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
        x = 480,
        y = 192 + index * 64,
        id = index,
        all_info = attack
    })
    end

    for index, attack in ipairs(moves_list) do
        love.graphics.draw(attack.text, attack.x - attack.text:getWidth() / 2, attack.y)
    end
end

function Select_Attacks_Screen:mouseClicked(x, y, button)
    for index, attack in ipairs(moves_list) do
        if love.mouse.getX() >= attack.x - attack.text:getWidth() / 2 and love.mouse.getX() <= attack.x + attack.text:getWidth() / 2 and love.mouse.getY() >= attack.y and love.mouse.getY() <= attack.y + attack.text:getHeight() then
            player.attacks[current_attack_slot] = attack["all_info"]
            game_state = "augmentation_screen"
        end
    end
end