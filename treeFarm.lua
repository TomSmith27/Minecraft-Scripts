local x = 1
local y = 3

function HarvestTree()
    turtle.dig()
    turtle.forward()
    local treeHeight = 0
    repeat
        local success, data = turtle.inspectUp()
        --Dig up until there is nothing above the turtle
        if success then
            turtle.digUp()
            turtle.up()
            treeHeight = treeHeight + 1
        end
    until(turtle.inspectUp() == false)
    --Go back down to the stump
    for i = 0, treeHeight do
        turtle.digDown()
        turtle.down()
    end
    turtle.back()
    turtle.select(1)
    turtle.place()
    --Done harvesting
    print("Harvested Tree with height of ", treeHeight)
end

function CheckIfGrown()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:log" then
        HarvestTree()
    end
end

function Farm()
    while FollowPath() == true do
        turtle.turnLeft()
        CheckIfGrown()
        turtle.turnRight()
        turtle.turnRight()
        CheckIfGrown()
        turtle.turnLeft()
    end
end


function FollowPath()
    turtle.dig()
    turtle.forward()
    local success, data = turtle.inspectDown()
    if success and data.name == "minecraft:stonebrick" then
        return true
    else
        turtle.back()
        turtle.turnRight()
        turtle.forward()
        local success, data = turtle.inspectDown()
        if success and data.name == "minecraft:stonebrick" then
            return true
        else
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
            turtle.forward()
            local success, data = turtle.inspectDown()
            if success and data.name == "minecraft:stonebrick" then
                return true
            else
                print("No Valid path now stopping")
                return false
            end

        end
    end
end


while(true) do
    if FollowPath() == false then
        return
    end
end

--Farm()
