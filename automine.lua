for i = 0, 5 do
    shell.run("shaftmine", 50)
    for j = 0, 3 do
        turtle.dig()
        turtle.forward()
    end
end