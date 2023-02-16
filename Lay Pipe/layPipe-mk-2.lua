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

function firstHandFull()
    -- increment hand counter until find items or 16 and empty
    -- return false and save progress coords if empty turtle,
    --        true if turtle has items

    if empty then return false end

    while not empty and turtle.getItemCount(currentHand) == 0 and currentHand ~=
        16 do
        currentHand = currentHand + 1
        turtle.select(currentHand)
    end

    if (turtle.getItemCount(currentHand) == 0 and currentHand == 16) then
        empty = true

        xProgress = xCoord
        yProgress = yCoord
        zProgress = zCoord
        dirProgress = orientation
        return false
    end

    return true
end

function moveBack()
    if turtle.back() then -- can move
        if orientation == 1 then
            zCoord = zCoord + 1
        elseif orientation == 2 then
            xCoord = xCoord - 1
        elseif orientation == 3 then
            zCoord = zCoord - 1
        elseif orientation == 4 then
            xCoord = xCoord + 1
        end
    end

end

function moveUp()
    if turtle.up() then -- can move
        yCoord = yCoord + 1
    end

end

function moveDown()
    if turtle.down() then -- can move
        yCoord = yCoord - 1
    end

end

function moveBackPlace()
    if turtle.back() then -- can move
        if orientation == 1 then
            zCoord = zCoord + 1
        elseif orientation == 2 then
            xCoord = xCoord - 1
        elseif orientation == 3 then
            zCoord = zCoord - 1
        elseif orientation == 4 then
            xCoord = xCoord + 1
        end
        turtle.place()
    end
end

function moveUpPlace()
    if turtle.up() then -- can move
        yCoord = yCoord + 1
        turtle.placeDown()
    end

end

function moveDownPlace()
    if turtle.down() then -- can move
        yCoord = yCoord - 1
        turtle.placeUp()
    end

end

function faceDir(direction) while orientation ~= direction do rotateLeft() end end

function pathTo(xPath, yPath, zPath, dirPath)
    --[[while not at coordinates
if firstHandFull() (meaning items and in hand)
  place behind
else (empty turtle)
  go to destination
]]
    -- get to Y
    while yCoord ~= yPath do
        if firstHandFull() then
            if yCoord < yPath then
                moveUpPlace()
            elseif yCoord > yPath then
                moveDownPlace()
            end
        else
            if yCoord < yPath then
                moveUp()
            elseif yCoord > yPath then
                moveDown()
            end
        end
    end

    -- get to X
    while xCoord ~= xPath do
        if firstHandFull() then
            if xCoord < xPath and orientation ~= 4 then
                faceDir(4)
                moveBackPlace()
            elseif xCoord < xPath then
                moveBackPlace()
            elseif xCoord > xPath and orientation ~= 2 then
                faceDir(2)
                moveBackPlace()
            elseif xCoord > xPath then
                moveBackPlace()
            end
        else
            if xCoord < xPath and orientation ~= 4 then
                faceDir(4)
                moveBack()
            elseif xCoord < xPath then
                moveBack()
            elseif xCoord > xPath and orientation ~= 2 then
                faceDir(2)
                moveBack()
            elseif xCoord > xPath then
                moveBack()
            end
        end
    end

    -- get to Z
    while zCoord ~= zPath do
        if firstHandFull() then
            if zCoord < zPath and orientation ~= 1 then
                faceDir(1)
                moveBackPlace()
            elseif zCoord < zPath then
                moveBackPlace()
            elseif zCoord > zPath and orientation ~= 3 then
                faceDir(3)
                moveBackPlace()
            elseif zCoord > zPath then
                moveBackPlace()
            end
        else
            if zCoord < zPath and orientation ~= 1 then
                faceDir(1)
                moveBack()
            elseif zCoord < zPath then
                moveBack()
            elseif zCoord > zPath and orientation ~= 3 then
                faceDir(3)
                moveBack()
            elseif zCoord > zPath then
                moveBack()
            end
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
    currentHand = 1
    turtle.select(currentHand)
    empty = false
    xProgress = 0
    yProgress = 0
    zProgress = 0
    dirProgress = 1

    init()

    pathTo(xCoord, -59, zCoord, orientation)
    pathTo(xDest, -59, zDest, dirDest)
    pathTo(xDest, yDest, zDest, dirDest)

    print("Tunnel Complete")
    if empty then
        print("Placement stopped at x=" .. xProgress .. " y=" .. yProgress ..
                  " z=" .. zProgress .. " with orientation: " .. dirProgress)
    end

    turtle.select(1)
end

main()
