Level_Up = Map:extend()

function Level_Up:new()
    Level_Up.super.new(self)

    level_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    level_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    level_description = love.graphics.newFont("ARCADECLASSIC.TTF", 24)
    level_description:setFilter( "nearest", "nearest" )
    level_header:setFilter( "nearest", "nearest" )
    level_text:setFilter( "nearest", "nearest" )

    self.cost = 200 + (player.level * 5)

    self.base_stats = {
        {
            stat = player.base_vitality,
            name = "Vitality",
            real_name = "vitality",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_resilience,
            name = "Resilience",
            real_name = "resilience",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_strength,
            name = "Strength",
            real_name = "strength",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_skill,
            name = "Skill",
            real_name = "skill",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_arcane,
            name = "Arcane",
            real_name = "arcane",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_holy,
            name = "Holy",
            real_name = "holy",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }, {
            stat = player.base_agility,
            name = "Agility",
            real_name = "agility",
            button = {
                text = love.graphics.newText(level_text, "+"),
                x = 384,
                y = 0
            }
         }
    }

    self.start_button = {
        x = window_width / 2,
        y = 900,
        text = love.graphics.newText(level_text, "START")
    }
end

function Level_Up:update(dt)

end

function Level_Up:draw()
    love.graphics.setFont(level_header)
    love.graphics.printf("Select which stats to level up", 0, 64, window_width, "center")
    love.graphics.setFont(level_description)
    love.graphics.printf("Click on the plus button to level up a stat. Levels cannot be undone once clicked, so be careful what you choose. Click START once finished.", 0, 192, window_width, "center")
    love.graphics.setFont(level_text)
    for index, stat in ipairs(self.base_stats) do
        stat["button"]["y"] = index * 64 + 256
        love.graphics.print(stat["name"] .. ": " .. stat["stat"], 64, stat["button"]["y"])
        love.graphics.draw(stat["button"]["text"], stat["button"]["x"], stat["button"]["y"])
    end
    love.graphics.print("Experience: " .. player.experience, 64, 832)
    love.graphics.print("Cost: " .. self.cost, 64, 896)
    love.graphics.draw(self.start_button.text, self.start_button.x - self.start_button.text:getWidth() / 2, self.start_button.y)
end

function Level_Up:mouseClicked(x, y, button)
    for index, option in ipairs(self.base_stats) do
        if love.mouse.getX() >= option["button"]["x"] and love.mouse.getX() <= option["button"]["x"] + option.button.text:getWidth() and love.mouse.getY() >= option["button"]["y"] and love.mouse.getY() <= option["button"]["y"] + option.button.text:getHeight() and player.experience >= self.cost then
            player["base_" .. option["real_name"]] = player["base_" .. option["real_name"]] + 1
            player[option["real_name"]] = player[option["real_name"]] + 1
            player["level"] = player["level"] + 1
            option["stat"] = player["base_" .. option["real_name"]]
            player.experience = player.experience - self.cost
            self.cost = 200 + (player.level * 5)
        end
    end
    if love.mouse.getX() >= self.start_button.x - self.start_button.text:getWidth() / 2 and love.mouse.getX() <= self.start_button.x + self.start_button.text:getWidth() / 2 and love.mouse.getY() >= self.start_button.y and love.mouse.getY() <= self.start_button.y + self.start_button.text:getHeight() then
        game_state = "play"
    end
end