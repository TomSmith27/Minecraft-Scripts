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

function Farm()
    for i = 0, x do
        for j = 0, y do
            turtle.forward()
            turtle.left()
            CheckIfGrown()
            turtle.right()
            turtle.right()
            CheckIfGrown()
            turtle.left()
    end