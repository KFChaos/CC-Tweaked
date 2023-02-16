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
    else
        turtle.dig()
    end
end

function moveUp()
    if turtle.up() then -- can move
        yCoord = yCoord + 1
    else
        turtle.digUp()
    end
end

function moveDown()
    if turtle.down() then -- can move
        yCoord = yCoord - 1
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

function fullInv()
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if not item then return false end
    end
    return true
end

function clearInv()
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            if item.name == "minecraft:cobblestone" or item.name ==
                "minecraft:stone" or item.name == "minecraft:sandstone" or
                item.name == "minecraft:sand" or item.name == "minecraft:gravel" or
                item.name == "minecraft:flint" or item.name ==
                "minecraft:wheat_seeds" or item.name == "minecraft:granite" or
                item.name == "minecraft:diorite" or item.name ==
                "minecraft:deepslate" or item.name ==
                "minecraft:cobbled_deepslate" or item.name ==
                "minecraft:calcite" or item.name == "minecraft:tuff" or
                item.name == "minecraft:smooth_basalt" or item.name ==
                "minecraft:dirt" or item.name == "minecraft:netherrack" or
                item.name == "minecraft:soul_sand" or item.name ==
                "minecraft:soul_soil" or item.name == "minecraft:basalt" or
                item.name == "minecraft:polished_basalt" or item.name ==
                "minecraft:blackstone" or item.name ==
                "minecraft:nether_wart_block" then
                turtle.select(i)
                turtle.dropDown()
            elseif item.name == "minecraft:coal" or item.name ==
                "minecraft:charcoal" then
                turtle.select(i)
                turtle.refuel(all)
            else
                -- print("item not blacklisted")
            end
        end
    end
    turtle.select(1)
end

function stillFull(limit)
    local itemCount = 0

    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then itemCount = itemCount + 1 end
    end

    return itemCount > limit
end

function depositUp()
    pathTo(homeX, 70, homeZ, homeOrientation)
    pathTo(homeX, homeY, homeZ, homeOrientation)
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            turtle.select(i)
            turtle.dropUp(all)
        end
    end

    pathTo(xProgress, 70, zProgress, dirProgress)
    pathTo(xProgress, yProgress, zProgress, dirProgress)
end

function depositItems()
    pathTo(homeX, homeY + 10, homeZ, homeOrientation)
    pathTo(homeX, homeY, homeZ, homeOrientation)
    rotateLeft()
    rotateLeft()
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            turtle.select(i)
            turtle.drop(all)
        end
    end

    pathTo(xProgress, homeY + 10, zProgress, dirProgress)
    pathTo(xProgress, yProgress, zProgress, dirProgress)
end

function layer(size)
    size = tonumber(size)
    depositMode = "UP"
    local alternator = 0
    local Q1 = math.floor((size / 2) / 2)

    for row = 1, size - 1 do
        if row % 2 == 1 and size > 20 then
            digUp()
            clearInv()
            if stillFull(6) then
                xProgress = xCoord
                yProgress = yCoord
                zProgress = zCoord
                dirProgress = orientation
                if depositMode == "UP" then
                    depositUp()
                else
                    depositItems()
                end
            end
        elseif row % 2 == 1 and size > 10 then
            digUp()
            clearInv()
            if stillFull(10) then
                xProgress = xCoord
                yProgress = yCoord
                zProgress = zCoord
                dirProgress = orientation
                if depositMode == "UP" then
                    depositUp()
                else
                    depositItems()
                end
            end
        end

        for column = 1, size - 1 do
            digUp()
            turtle.digDown()
            dig()
            moveForward()
        end
        if alternator % 2 == 0 then
            rotateRight()
            digUp()
            turtle.digDown()
            dig()
            moveForward()
            rotateRight()
            alternator = alternator + 1
        elseif alternator % 2 == 1 then
            rotateLeft()
            digUp()
            turtle.digDown()
            dig()
            moveForward()
            rotateLeft()
            alternator = alternator + 1
        end
    end
    for row = 1, size - 1 do
        digUp()
        turtle.digDown()
        dig()
        moveForward()
    end
    digUp()
    turtle.digDown()

    if size % 2 == 0 then
        rotateRight()
        moveDown()
    elseif size % 2 == 1 then
        rotateLeft()
        rotateLeft()
        moveDown()
    end

    digUp()
    clearInv()
    if stillFull(5) then
        xProgress = xCoord
        yProgress = yCoord
        zProgress = zCoord
        dirProgress = orientation
        if depositMode == "UP" then
            depositUp()
        else
            depositItems()
        end
    end
end

function quarry(size, depth)
    local layerNum = math.abs(depth) + yCoord
    local depthGroup = layerNum % 3

    if depthGroup == 0 then
        for a = 1, (layerNum / 3) do
            turtle.digDown()
            moveDown()
            turtle.digDown()
            moveDown()
            layer(size)
        end
    elseif depthGroup == 1 then
        layer(size)
        for a = 1, ((layerNum - 1) / 3) do
            turtle.digDown()
            moveDown()
            turtle.digDown()
            moveDown()
            layer(size)
        end
    elseif depthGroup == 2 then
        turtle.digDown()
        moveDown()
        layer(size)
        for a = 1, ((layerNum - 2) / 3) do
            turtle.digDown()
            moveDown()
            turtle.digDown()
            moveDown()
            layer(size)
        end
    end
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

    print("How wide should the hole be? ")
    local width = read()
    print("What Y-Level should we dig to? ")
    local depth = read()

    print("Return elsewhere? T/F")
    local differentStart = read()
    if differentStart == "T" then
        print("Return X coord: ")
        homeX = tonumber(read())
        print("Return Y coord: ")
        homeY = tonumber(read())
        print("Return Z coord: ")
        homeZ = tonumber(read())
        print("Return orientation: ")
        print("North = 1, East = 2, South = 3, West = 4")
        homeOrientation = tonumber(read())
    elseif differentStart == "F" then
        homeX = xCoord
        homeY = yCoord
        homeZ = zCoord
        homeOrientation = orientation
    else
        print("Invalid response, defaulting return to process origin")
        homeX = xCoord
        homeY = yCoord
        homeZ = zCoord
        homeOrientation = orientation
    end

    print("Begin elsewhere? T/F")
    local differentStart = read()
    if differentStart == "T" then
        print("Desired X coord: ")
        xDest = tonumber(read())
        print("Desired Y coord: ")
        yDest = tonumber(read())
        print("Desired Z coord: ")
        zDest = tonumber(read())
        print("Desired orientation: ")
        print("North = 1, East = 2, South = 3, West = 4")
        dirDest = tonumber(read())

        pathTo(homeX, 70, homeZ, homeOrientation)
        pathTo(xDest, 70, zDest, dirDest)
        pathTo(xDest, yDest, zDest, dirDest)
        quarry(width, depth)
    elseif differentStart == "F" then
        quarry(width, depth)
    else
        print("Invalid response, cancelling request")
        return false
    end
end

function main()
    init()

    pathTo(homeX, 70, homeZ, homeOrientation)
    pathTo(homeX, homeY, homeZ, homeOrientation)
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            turtle.select(i)
            if depositMode == "UP" then
                turtle.dropUp(all)
            else
                turtle.drop(all)
            end
        end
    end

    print("Quarry Complete")
end

main()
