Equipped_Attacks = Object:extend()

function Equipped_Attacks:new()
    Equipped_Attacks.super.new(self)

    attacks_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    attacks_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    attacks_description = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    attacks_header:setFilter( "nearest", "nearest" )
    attacks_description:setFilter( "nearest", "nearest" )
    attacks_text:setFilter( "nearest", "nearest" )
end

function Equipped_Attacks:update()

end

function Equipped_Attacks:draw()
    love.graphics.setFont(attacks_header)
    love.graphics.printf("EQUIPPED ATTACKS", 0, 128, 960, "center")
    love.graphics.setFont(attacks_text)
    love.graphics.printf("Click on one of them to change it.", 0, 216, 960, "center")

    self:generate_attack_list()

    for index, attack in ipairs(moves_list) do
        love.graphics.draw(attack.text, attack.x - attack.text:getWidth() / 2, attack.y)
        love.graphics.setFont(attacks_description)
        love.graphics.printf(attack.description, 0, attack.y + 48, 960, "center")
    end
end

function Equipped_Attacks:generate_attack_list()
    moves_list = {}
    for index, attack in ipairs(player.attacks) do
        table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
        description = attack["description"],
        x = 480,
        y = 128 + index * 164,
        id = index})
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