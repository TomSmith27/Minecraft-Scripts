function DigGoodItems()
    local success, data = turtle.inspect()
    if success then
        if data.name == "minecraft:stone"
            or data.name == "minecraft:dirt"
            or data.name == "minecraft:grass"
            or data.name == "minecraft:gravel" then
        else
            print("Found : ", data.name)
            turtle.dig()
        end
    end
end