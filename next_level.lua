Next_Level = Object:extend()

function Next_Level:new(x, y, next_x, next_y, next_map, next_mega_map_x, next_mega_map_y)
    self.x = x * 64 - 64
    self.y = y * 64 - 64
    self.next_x = next_x * 64 - 64
    self.next_y = next_y * 64 - 64
    self.next_map = next_map
    self.next_mega_map_x = next_mega_map_x
    self.next_mega_map_y = next_mega_map_y
end

function Next_Level:draw()
    
end

function Next_Level:update(dt)

end