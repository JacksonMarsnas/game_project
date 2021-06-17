Pause_Screen = Map:extend()

function Pause_Screen:new()
    Pause_Screen.super.new(self)
end

function Pause_Screen:update()

end

function Pause_Screen:draw()
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