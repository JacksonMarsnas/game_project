Select_Attacks_Screen = Map:extend()

function Select_Attacks_Screen:new()
    Select_Attacks_Screen.super.new(self)
    self.screen_top = 0
    self.filter_state = "All"

    attacks_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    attacks_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    attacks_description = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    attacks_description:setFilter( "nearest", "nearest" )
    attacks_header:setFilter( "nearest", "nearest" )
    attacks_text:setFilter( "nearest", "nearest" )
end

function Select_Attacks_Screen:update()
    
end

function Select_Attacks_Screen:draw()
    love.graphics.translate(0, self.screen_top)
    love.graphics.setFont(attacks_header)
    love.graphics.printf("SELECT YOUR MOVES", 0, 128, 960, "center")
    love.graphics.setFont(attacks_text)

    self:filter()
    self:make_filter_options()

    for index, attack in ipairs(moves_list) do
        love.graphics.draw(attack.text, attack.x - attack.text:getWidth() / 2, attack.y)
        love.graphics.setFont(attacks_description)
        love.graphics.printf(attack.all_info.description, 0, attack.y + 48, 960, "center")
    end
end

function Select_Attacks_Screen:filter()
    if self.filter_state == "All" then
        self:filter_all()
    elseif self.filter_state == "Melee" then
        self:filter_melee()
    elseif self.filter_state == "Ranged" then
        self:filter_ranged()
    elseif self.filter_state == "Buffs" then
        self:filter_buffs()
    elseif self.filter_state == "Debuffs" then
        self:filter_debuffs()
    end
end

function Select_Attacks_Screen:make_filter_options()
    filter_options = {}
    filter_labels = {"All", "Melee", "Ranged", "Buffs", "Debuffs"}
    for index, option in ipairs(filter_labels) do
        table.insert(filter_options, {text = love.graphics.newText(attacks_text, option),
        x = index * 160,
        y = 192,
        label = option})
    end

    for index, option in ipairs(filter_options) do
        love.graphics.draw(option.text, option.x - option.text:getWidth() / 2, option.y)
    end
end

function Select_Attacks_Screen:mouseClicked(x, y, button)
    self:filter_clicked(x, y, button)
    self:attack_clicked(x, y, button)
end

function Select_Attacks_Screen:filter_clicked(x, y, button)
    for index, option in ipairs(filter_options) do
        if love.mouse.getX() >= option.x - option.text:getWidth() / 2 and love.mouse.getX() <= option.x + option.text:getWidth() / 2 and love.mouse.getY() >= option.y + self.screen_top and love.mouse.getY() <= option.y + option.text:getHeight() + self.screen_top then
            self.filter_state = option.label
        end
    end
end

function Select_Attacks_Screen:attack_clicked(x, y, button)
    for index, attack in ipairs(moves_list) do
        if love.mouse.getX() >= attack.x - attack.text:getWidth() / 2 and love.mouse.getX() <= attack.x + attack.text:getWidth() / 2 and love.mouse.getY() >= attack.y + self.screen_top and love.mouse.getY() <= attack.y + attack.text:getHeight() + self.screen_top then
            player.attacks[current_attack_slot] = attack["all_info"]
            self.screen_top = 0
            game_state = "augmentation_screen"
        end
    end
end

function Select_Attacks_Screen:scroll(x, y)
    if game_state == "select_attacks" then
        if y > 0 and self.screen_top < 0 then
            self.screen_top = self.screen_top + 100
        elseif y < 0 and self.screen_top > -128 - #moves_list * 150  then
            self.screen_top = self.screen_top - 100
        end
    end
end

function Select_Attacks_Screen:filter_all()
    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
        x = 480,
        y = 128 + index * 164,
        id = index,
        all_info = attack})
    end
    return moves_list
end

function Select_Attacks_Screen:filter_melee()
    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        if attack.type == "Attack" then
            table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
            x = 480,
            y = 128 + (#moves_list + 1) * 164,
            id = index,
            all_info = attack})
        end
    end
    return moves_list
end

function Select_Attacks_Screen:filter_ranged()
    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        if attack.type == "Ranged" then
            table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
            x = 480,
            y = 128 + (#moves_list + 1) * 164,
            id = index,
            all_info = attack})
        end
    end
    return moves_list
end

function Select_Attacks_Screen:filter_buffs()
    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        if attack.type == "Buff" then
            table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
            x = 480,
            y = 128 + (#moves_list + 1) * 164,
            id = index,
            all_info = attack})
        end
    end
    return moves_list
end

function Select_Attacks_Screen:filter_debuffs()
    moves_list = {}
    for index, attack in ipairs(moves.all_moves) do
        if attack.type == "Debuff" then
            table.insert(moves_list, {text = love.graphics.newText(attacks_text, attack["name"] .. " - Type: " .. attack["type"] .. " - Effects: " .. attack["slots"]),
            x = 480,
            y = 128 + (#moves_list + 1) * 164,
            id = index,
            all_info = attack})
        end
    end
    return moves_list
end