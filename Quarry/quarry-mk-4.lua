function split(s, delimiter)
    local result = {};
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match);
    end
    return result;
end

function getID()
    local label = os.getComputerLabel()
    local tableSize = 0
    local splitLabel = split(label, "")
    for _ in pairs(splitLabel) do tableSize = tableSize + 1 end
    return splitLabel[tableSize]
end

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

function moveAround()
    rotateRight()
    moveForward()
    rotateLeft()
    moveForward()
    moveForward()
    rotateLeft()
    moveForward()
    rotateRight()
end

function pathToAvoid(xPath, yPath, zPath, dirPath)
    if (zCoord == pipeZ and xPath == pipeX) and
        (xCoord > pipeX and zPath < pipeZ) then
        pathTo(pipeX + 1, 70, pipeZ, 4)
        rotateRight()
        moveForward()
        rotateLeft()
        moveForward()
        rotateRight()
    elseif (zCoord == pipeZ and xPath == pipeX) and
        (xCoord > pipeX and zPath > pipeZ) then
        pathTo(pipeX + 1, 70, pipeZ, 4)
        rotateLeft()
        moveForward()
        rotateRight()
        moveForward()
        rotateLeft()
    elseif (zCoord == pipeZ and xCoord > pipeX and pipeX > xPath) then
        pathTo(pipeX + 1, 70, pipeZ, 4)
        moveAround()
    elseif (zCoord == pipeZ and xCoord < pipeX and pipeX < xPath) then
        pathTo(pipeX - 1, 70, pipeZ, 2)
        moveAround()
    elseif (zCoord == pipeZ and xPath == pipeX) and
        (xCoord < pipeX and zPath < pipeZ) then
        pathTo(pipeX - 1, 70, pipeZ, 2)
        rotateLeft()
        moveForward()
        rotateRight()
        moveForward()
        rotateLeft()
    elseif (zCoord == pipeZ and xPath == pipeX) and
        (xCoord < pipeX and zPath > pipeZ) then
        pathTo(pipeX - 1, 70, pipeZ, 2)
        rotateRight()
        moveForward()
        rotateLeft()
        moveForward()
        rotateRight()
    elseif (xCoord == pipeX and zCoord > pipeZ and pipeZ > zPath) then
        pathTo(pipeX, 70, pipeZ + 1, 1)
        moveAround()
    elseif (xCoord == pipeX and zCoord < pipeZ and pipeZ < zPath) then
        pathTo(pipeX, 70, pipeZ - 1, 3)
        moveAround()
    elseif xCoord ~= pipeX and xPath == pipeX and zCoord < pipeZ then
        pathTo(pipeX, 70, pipeZ - 1, 3)
        moveAround()
    elseif xCoord ~= pipeX and xPath == pipeX and zCoord > pipeZ then
        pathTo(pipeX, 70, pipeZ + 1, 1)
        moveAround()
    end

    pathTo(xPath, 70, zPath, dirPath)
    pathTo(xPath, yPath, zPath, dirPath)
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
                "minecraft:andesite" or item.name == "minecraft:deepslate" or
                item.name == "minecraft:cobbled_deepslate" or item.name ==
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
    pathToAvoid(homeX, homeY, homeZ, homeOrientation)
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            turtle.select(i)
            turtle.dropUp(all)
        end
    end

    pathToAvoid(xProgress, yProgress, zProgress, dirProgress)
end

function depositItems()
    pathToAvoid(homeX, homeY + 10, homeZ, homeOrientation)
    pathToAvoid(homeX, homeY, homeZ, homeOrientation)
    rotateLeft()
    rotateLeft()
    for i = 1, 16 do
        item = turtle.getItemDetail(i)
        if item then
            turtle.select(i)
            turtle.drop(all)
        end
    end

    pathToAvoid(xProgress, homeY + 10, zProgress, dirProgress)
    pathToAvoid(xProgress, yProgress, zProgress, dirProgress)
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
    local recieverID = 35
    local message

    if depthGroup == 0 then
        for a = 1, (layerNum / 3) do
            turtle.digDown()
            moveDown()
            turtle.digDown()
            moveDown()
            layer(size)

            message = (tostring(a / (layerNum / 3)) * 100)
            rednet.send(recieverID, message, "progress")
        end
    elseif depthGroup == 1 then
        layer(size)
        for a = 1, ((layerNum - 1) / 3) do
            turtle.digDown()
            moveDown()
            turtle.digDown()
            moveDown()
            layer(size)

            message = (tostring(a / ((layerNum - 1) / 3)) * 100)
            rednet.send(recieverID, message, "progress")
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

            message = (tostring(a / ((layerNum - 2) / 3)) * 100)
            rednet.send(recieverID, message, "progress")
        end
    end
end

function main()
    rednet.open("left")
    local id, message, protocol
    local tableSize = 0
    pipeX = -864
    pipeZ = 735

    print("Waiting for orders")
    id, message, protocol = rednet.receive("quarry")

    quarryCall = split(message, " ")

    for _ in pairs(quarryCall) do tableSize = tableSize + 1 end
    print("input has: " .. tableSize .. " entries")
    --[[ ~ ~ ~ dir width depth F F
         ~ ~ ~ dir width depth T ~ ~ ~ dir F
         ~ ~ ~ dir width depth F T ~ ~ ~ dir
         ~ ~ ~ dir width depth T ~ ~ ~ dir T ~ ~ ~ dir
    ]]

    -- for i = 1, tableSize do print(quarryCall[i]) end

    xCoord = tonumber(quarryCall[1])
    yCoord = tonumber(quarryCall[2])
    zCoord = tonumber(quarryCall[3])
    orientation = tonumber(quarryCall[4])
    local width = tonumber(quarryCall[5])
    local depth = tonumber(quarryCall[6])
    if tableSize == 8 and quarryCall[7] == "F" and quarryCall[8] == "F" then
        homeX = xCoord
        homeY = yCoord
        homeZ = zCoord
        homeOrientation = orientation
        quarry(width, depth)
    elseif tableSize == 12 and quarryCall[7] == "T" and quarryCall[12] == "F" then
        homeX = tonumber(quarryCall[8])
        homeY = tonumber(quarryCall[9])
        homeZ = tonumber(quarryCall[10])
        homeOrientation = tonumber(quarryCall[11])
        quarry(width, depth)
    elseif tableSize == 12 and quarryCall[7] == "F" and quarryCall[8] == "T" then
        homeX = xCoord
        homeY = yCoord
        homeZ = zCoord
        homeOrientation = orientation
        xDest = tonumber(quarryCall[9])
        yDest = tonumber(quarryCall[10])
        zDest = tonumber(quarryCall[11])
        dirDest = tonumber(quarryCall[12])
        pathToAvoid(xDest, yDest, zDest, dirDest)
        quarry(width, depth)
    elseif tableSize == 16 and quarryCall[7] == "T" and quarryCall[12] == "T" then
        homeX = tonumber(quarryCall[8])
        homeY = tonumber(quarryCall[9])
        homeZ = tonumber(quarryCall[10])
        homeOrientation = tonumber(quarryCall[11])
        xDest = tonumber(quarryCall[13])
        yDest = tonumber(quarryCall[14])
        zDest = tonumber(quarryCall[15])
        dirDest = tonumber(quarryCall[16])
        pathToAvoid(xDest, yDest, zDest, dirDest)
        quarry(width, depth)
    else
        print("Invalid Quarry Call")
        main()
    end

    pathToAvoid(homeX, homeY, homeZ, homeOrientation)
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
    main()
end

main()
