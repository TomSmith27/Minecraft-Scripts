local args = { ... }
local lvls = tonumber(args[1] or 1)

os.loadAPI("Minecraft-Scripts/turtleApi")

function MineLevel()
    turtle.digDown()
    turtle.down()
    for i = 0, 3 do
        turtle.turnLeft()
        turtleApi.DigGoodItems()
    end
end

function MineToBottom()
    for i = 1, lvls do
        MineLevel()
    end
    for i = 1, lvls do
        turtle.up()
    end
end
if(turtle.getFuelLevel() < lvls * 2) then
    print("Not enough fuel for mining")
    print("Need ", lvls * 2)
    print("Have " , turtle.getFuelLevel())
else
    MineToBottom()
    turtle.placeDown(1)
end
