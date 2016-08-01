local startblock = "IronChest:BlockIronChest"
local pathblock = "minecraft:stonebrick"
local waitTime = 300

function HarvestTree()
    turtle.dig()
    turtle.forward()
    local treeHeight = 0
    repeat
        local success, data = turtle.inspectUp()
        --Dig up until there is nothing above the turtle
        if success then
            --Try and get leaves
            turtle.dig()
            turtle.digUp()
            turtle.up()
            treeHeight = treeHeight + 1
        end
    until(turtle.inspectUp() == false)
    --When coming back down switch around to get leaves
    turtle.turnLeft()
    turtle.turnLeft()
    --Go back down to the stump
    for i = 1, treeHeight do
        turtle.digDown()
        turtle.dig()
        turtle.down()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.back()
    turtle.select(1)
    turtle.place()
    --Done harvesting
    print("Harvested Tree with height of ", treeHeight)
end

function CheckIfGrown()
    turtle.suck()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:log" then
        HarvestTree()
    elseif success == false then
        turtle.select(1)
        if turtle.getItemCount(1) > 10 then
            turtle.place()
        end
    end
end

function Farm()
    while FollowPath() == true do
        if turtle.getFuelLevel() < 100 then
            turtle.select(2)
            turtle.refuel(5)
        end
        if turtle.getItemDetail(1).name == "minecraft:sapling" then
            turtle.suck()
            turtle.turnLeft()
            CheckIfGrown()
            turtle.turnRight()
            turtle.turnRight()
            CheckIfGrown()
            turtle.turnLeft()
        end
    end
end


function FollowPath()
    turtle.dig()
    turtle.forward()
    local success, data = turtle.inspectDown()
    if success and data.name == pathblock then
        return true
    elseif success and data.name == startblock then
        print("Done loop now waiting for ", waitTime)
        for i = 3, 16 do
            turtle.select(i)
            turtle.dropDown()
        end
        sleep(waitTime)
        return true
    else
        turtle.back()
        turtle.turnRight()
        turtle.forward()
        local success, data = turtle.inspectDown()
        if success and data.name == pathblock then
            return true
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
