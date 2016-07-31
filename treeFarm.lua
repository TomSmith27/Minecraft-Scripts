local startblock = "IronChest:BlockIronChest"
local pathblock = "minecraft:stonebrick"

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
    for i = 1, treeHeight do
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
    if success and data.name == pathblock then
        return true
    elseif
        turtle.back()
        turtle.turnRight()
        turtle.forward()
        local success, data = turtle.inspectDown()
        if success and data.name == pathblock then
            return true
        elseif success and data.name == startblock
            print("Done loop")
            for i = 2, 15 do
                turtle.select(i)
                turtle.dropDown()
            end
            sleep(120)
        else
            turtle.turnLeft()
            turtle.turnLeft()
            turtle.forward()
            turtle.forward()
            local success, data = turtle.inspectDown()
            if success and data.name == pathblock then
                return true
            else
                turtle.back()
                turtle.turnRight()
                print("No Valid path now stopping")
                return false
            end

        end
    end
end


Farm()
