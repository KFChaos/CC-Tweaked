function layer(size)
    local alternator = 0

    for row = 1, size - 1 do
        for column = 1, size - 1 do
            turtle.digUp()
            turtle.digDown()
            turtle.dig()
            turtle.forward()
        end
        if alternator % 2 == 0 then
            turtle.turnRight()
            turtle.digUp()
            turtle.digDown()
            turtle.dig()
            turtle.forward()
            turtle.turnRight()
            alternator = alternator + 1
        elseif alternator % 2 == 1 then
            turtle.turnLeft()
            turtle.digUp()
            turtle.digDown()
            turtle.dig()
            turtle.forward()
            turtle.turnLeft()
            alternator = alternator + 1
        end
    end
    for row = 1, size - 1 do
        turtle.digUp()
        turtle.digDown()
        turtle.dig()
        turtle.forward()
    end
    turtle.digUp()
    turtle.digDown()

    if size % 2 == 0 then
        turtle.turnRight()
        turtle.down()
    elseif size % 2 == 1 then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.down()
    end
end

function quarry(size, depth)
    local depthGroup = depth % 3
    print(depthGroup)

    if depthGroup == 0 then
        for a = 1, (depth / 3) do
            turtle.digDown()
            turtle.down()
            turtle.digDown()
            turtle.down()
            layer(size)
        end
    elseif depthGroup == 1 then
        layer(size)
        for a = 0, (depth-1 / 3) do
            turtle.digDown()
            turtle.down()
            turtle.digDown()
            turtle.down()
            layer(size)
        end
    elseif depthGroup == 2 then
        turtle.digDown()
        turtle.down()
        layer(size)
        for a = 0, depth-2 / 3 do
            turtle.digDown()
            turtle.down()
            turtle.digDown()
            turtle.down()
            layer(size)
        end
    end

end

function main()
    print("How wide should the hole be? ")
    local width = read()
    print("And the depth? ")
    local depth = read()
    -- layer(width)
    quarry(width,depth)
end

main()
