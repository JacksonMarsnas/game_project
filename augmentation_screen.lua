Augmentation_Screen = Map:extend()

function Augmentation_Screen:new()
    Augmentation_Screen.super.new(self)
    self.current_augment_slot = 0
end

function Augmentation_Screen:draw()
    local augment_header = love.graphics.newFont("ARCADECLASSIC.TTF", 64)
    local augment_text = love.graphics.newFont("ARCADECLASSIC.TTF", 32)
    augment_header:setFilter( "nearest", "nearest" )
    augment_text:setFilter( "nearest", "nearest" )
    love.graphics.setFont(augment_header)
    love.graphics.printf("SELECT YOUR AUGMENTATIONS", 0, 128, window_width, "center")
    love.graphics.setFont(augment_text)

    self:setup_table(augment_text)

    for index, augment in ipairs(augment_list) do
        love.graphics.draw(augment.text, augment.x - augment.text:getWidth() / 2, augment.y)
    end
end

function Augmentation_Screen:setup_table(augment_text)
    augment_list = {}
    for index, augment in ipairs(effects.all_effects) do

        local count = 0
        for word in string.gmatch(augment["heavy_description"], "\n") do
            count = count + 1
        end

        if index == 1 then
            table.insert(augment_list, {text = love.graphics.newText(augment_text, augment["name"] .. " - " .. augment["heavy_description"]),
            x = window_width / 2,
            y = 192 + index * 64,
            id = index,
            all_info = augment,
            height = 32 * (count + 1)
        })
        else
            table.insert(augment_list, {text = love.graphics.newText(augment_text, augment["name"] .. " - " .. augment["heavy_description"]),
            x = window_width / 2,
            y = augment_list[index - 1]["y"] + augment_list[index - 1]["height"] + 32,
            id = index,
            all_info = augment,
            height = 32 * (count + 1)
        }) 
        end
    end
end

function Augmentation_Screen:mouseClicked(x, y, button)
    for index, augment in ipairs(augment_list) do
        if love.mouse.getX() >= augment.x - augment.text:getWidth() / 2 and love.mouse.getX() <= augment.x + augment.text:getWidth() / 2 and love.mouse.getY() >= augment.y and love.mouse.getY() <= augment.y + augment.text:getHeight() then
            player.attacks[current_attack_slot]["effect"][self.current_augment_slot + 1] = augment["all_info"]
            self.current_augment_slot = self.current_augment_slot + 1
            if self.current_augment_slot == player.attacks[current_attack_slot]["slots"] then
                self.current_augment_slot = 0
                game_state = "play"
            end
        end
    end
end