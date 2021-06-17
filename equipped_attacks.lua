Equipped_Attacks = Object:extend()

function Equipped_Attacks:new()
    Equipped_Attacks.super.new(self)
end

function Equipped_Attacks:update()

end

function Equipped_Attacks:draw()
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

function Equipped_Attacks:mouseClicked(x, y, button)
    for index, attack in ipairs(moves_list) do
        if love.mouse.getX() >= attack.x - attack.text:getWidth() / 2 and love.mouse.getX() <= attack.x + attack.text:getWidth() / 2 and love.mouse.getY() >= attack.y and love.mouse.getY() <= attack.y + attack.text:getHeight() then
            current_attack_slot = attack["id"]
            game_state = "select_attacks"
        end
    end
end