function rotateLeft()
    turtle.turnLeft()
    orientation = orientation - 1 -- 0-3
    orientation = (orientation - 1) % 4
    orientation = orientation + 1 -- 1-4
end

function rotateRight()
    turtle.turnRight()
    orientation = orientation - 1 -- 0-3
    orientation = (orientation + 1) % 4
    orientation = orientation + 1 -- 1-4
end

function moveForward()
    if turtle.forward() then -- can move
        if orientation == 1 then
            zCoord = zCoord - 1
        elseif orientation == 2 then
            xCoord = xCoord + 1
        elseif orientation == 3 then
            zCoord = zCoord + 1
        elseif orientation == 4 then
            xCoord = xCoord - 1
        end
        dugCount = dugCount + 1
    else
        turtle.dig()
    end
end

function moveUp()
    if turtle.up() then -- can move
        yCoord = yCoord + 1
        dugCount = dugCount + 1
    else
        turtle.digUp()
    end
end

function moveDown()
    if turtle.down() then -- can move
        yCoord = yCoord - 1
        dugCount = dugCount + 1
    else
        turtle.digDown()
    end
end

function digUp() while turtle.detectUp() do turtle.digUp() end end

function dig() while turtle.detect() do turtle.dig() end end

function faceDir(direction) while orientation ~= direction do rotateLeft() end end

function pathTo(xPath, yPath, zPath, dirPath)
    -- get to Y
    while yCoord ~= yPath do
        if yCoord < yPath then
            moveUp()
        elseif yCoord > yPath then
            moveDown()
        end
    end
    -- get to X
    while xCoord ~= xPath do
        if xCoord < xPath and orientation ~= 2 then
            faceDir(2)
            moveForward()
        elseif xCoord < xPath then
            moveForward()
        elseif xCoord > xPath and orientation ~= 4 then
            faceDir(4)
            moveForward()
        elseif xCoord > xPath then
            moveForward()
        end
    end
    -- get to Z
    while zCoord ~= zPath do
        if zCoord < zPath and orientation ~= 3 then
            faceDir(3)
            moveForward()
        elseif zCoord < zPath then
            moveForward()
        elseif zCoord > zPath and orientation ~= 1 then
            faceDir(1)
            moveForward()
        elseif zCoord > zPath then
            moveForward()
        end
    end

    -- rotate to Home
    faceDir(dirPath)
end

function init()
    print("Current X coord: ")
    xCoord = tonumber(read())
    print("Current Y coord: ")
    yCoord = tonumber(read())
    print("Current Z coord: ")
    zCoord = tonumber(read())
    print("Current orientation: ")
    print("North = 1, East = 2, South = 3, West = 4")
    orientation = tonumber(read())

    print("Where to?")
    print("Destination X coord: ")
    xDest = tonumber(read())
    print("Destination Y coord: ")
    yDest = tonumber(read())
    print("Destination Z coord: ")
    zDest = tonumber(read())
    print("Destination orientation: ")
    print("North = 1, East = 2, South = 3, West = 4")
    dirDest = tonumber(read())
end

function main()
    dugCount = 0
    init()

    pathTo(xCoord, -59, zCoord, orientation)
    pathTo(xDest, -59, zDest, dirDest)
    pathTo(xDest, yDest, zDest, dirDest)

    print("Tunnel Complete | " .. dugCount .. " blocks needed to fill")
end

main()
