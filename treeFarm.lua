local x = 2
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
    turtle.up()
    --Done harvesting
    print("Harvested Tree with height of ", treeHeight)
end

function CheckIfGrown()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:log" then
        HarvestTree()
    end
end

function HarvestColumn()
    for i = 0, y do
        turtle.forward()
        turtle.turnLeft()
        CheckIfGrown()
        turtle.turnRight()
        turtle.turnRight()
        CheckIfGrown()
        turtle.turnLeft()
    end

end

function Farm()
    for i = 0, x do
        HarvestColumn()
        print("Finished Column #" , x)
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
        turtle.turnRight()
        HarvestColumn()
        print("Finished Column #" , x )
        turtle.turnLeft()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
    end
    turtle.turnLeft()
    for i = 0, x do
        turtle.forward()
        turtle.forward()
    end
    turtle.turnRight()
end

Farm()