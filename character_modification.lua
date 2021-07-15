Character_Modification = Map:extend()

function Character_Modification:new()
    Character_Modification.super.new(self)

    mod_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    mod_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    mod_description = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    mod_description:setFilter( "nearest", "nearest" )
    mod_header:setFilter( "nearest", "nearest" )
    mod_text:setFilter( "nearest", "nearest" )

    self.attacks_option = {
        text = love.graphics.newText(mod_text, "Change Attacks and Effects"),
        x = window_width / 2,
        y = 192
    }

    self.level_option = {
        text = love.graphics.newText(mod_text, "Level Up"),
        x = window_width / 2,
        y = 256
    }
end

function Character_Modification:update(dt)

end

function Character_Modification:draw()
    love.graphics.setFont(mod_header)
    love.graphics.printf("Choose an option", 0, 64, window_width, "center")
    love.graphics.draw(self.attacks_option.text, self.attacks_option.x - self.attacks_option.text:getWidth() / 2, self.attacks_option.y)
    love.graphics.draw(self.level_option.text, self.level_option.x - self.level_option.text:getWidth() / 2, self.level_option.y)
end

function Character_Modification:mouseClicked(x, y, button)
    if love.mouse.getX() >= self.attacks_option.x - self.attacks_option.text:getWidth() / 2 and love.mouse.getX() <= self.attacks_option.x + self.attacks_option.text:getWidth() / 2 and love.mouse.getY() >= self.attacks_option.y and love.mouse.getY() <= self.attacks_option.y + self.attacks_option.text:getHeight() then
        game_state = "equipped_attacks"
    elseif love.mouse.getX() >= self.level_option.x - self.level_option.text:getWidth() / 2 and love.mouse.getX() <= self.level_option.x + self.level_option.text:getWidth() / 2 and love.mouse.getY() >= self.level_option.y and love.mouse.getY() <= self.level_option.y + self.level_option.text:getHeight() then
        level_up = Level_Up()
        game_state = "level_up"
    end
end