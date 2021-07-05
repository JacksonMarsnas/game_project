Death = Map:extend()

function Death:new()
    Death.super.new(self)
    self.enemies = {}
end

function Death:update()

end

function Death:draw()
    local font = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    font:setFilter( "nearest", "nearest" )
    love.graphics.setFont(font)
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf("YOU DIED", 0, window_height / 2 - font:getHeight() / 2, 960, "center")
    love.graphics.setColor(1, 1, 1)
end