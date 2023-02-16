function setSlots()
    for i = 1,16 do
      turtle.select(i)
      local heldItem = turtle.getItemDetail()
  
      if heldItem then --slot contains item
        if heldItem.name == "minecraft:torch" and turtle.getSelectedSlot() ~= 16 then --torch is not in slot 16
          turtle.transferTo(16)
        elseif heldItem.name == "minecraft:chest" and turtle.getSelectedSlot() ~= 15 then --chest is not in slot 15
          turtle.transferTo(15)
        elseif heldItem.name == "minecraft:oak_planks" and turtle.getSelectedSlot() ~= 14 then --planks are not in slot 14
          turtle.transferTo(14)
        end
      end
    end
    turtle.select(1)
  end
  
  function upToComplete()
    while turtle.detectUp() do
      turtle.digUp()
    end
  end
  
  function forwardToComplete()
    while turtle.detect() do
      turtle.dig()
    end
  end
  
  function blockDown()
    if not turtle.detectDown() then 
      turtle.select(14)
      local heldItem = turtle.getItemDetail()
      if heldItem and heldItem.name == "minecraft:cobblestone" then
        turtle.placeDown()
      end
    end
  end
  
  function stepDown()
    upToComplete()
    turtle.digDown()
    turtle.down()
    blockDown()
    forwardToComplete()
    turtle.forward()
  end
  
  function clearInv()
    for i = 1,16 do 
      item = turtle.getItemDetail(i)
      if item then
        if item.name == "minecraft:cobblestone" or item.name == "minecraft:stone" or item.name == "minecraft:sandstone" or item.name == "minecraft:sand" or item.name == "minecraft:gravel" or item.name == "minecraft:granite" or item.name == "minecraft:diorite" or item.name == "minecraft:andesite" or item.name == "minecraft:deepslate" or item.name == "minecraft:cobbled_deepslate" or item.name == "minecraft:calcite" or item.name == "minecraft:tuff" or item.name == "minecraft:dirt" then
          turtle.select(i)
          turtle.dropDown()
        else
            print("item not blacklisted")
        end
      end
    end
    turtle.select(1)
  end
  
  function main() 
    setSlots()
    turtle.refuel(all)
    local initFuel, data = turtle.getFuelLevel()
    local firstHalf = initFuel/2
    local stepCount = 0
    local torch = turtle.getItemCount(16)
  
    turtle.select(16)
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.place()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.select(1)
    torch = torch - 1
  
    while (turtle.getFuelLevel() > firstHalf) do
      if ((firstHalf - turtle.getFuelLevel()) <= 2) then 
        if (stepCount == 7 and torch > 0) then
          turtle.select(16)
          turtle.turnLeft()
          turtle.turnLeft()
          turtle.place()
          turtle.turnLeft()
          turtle.turnLeft()
          turtle.select(1)
          torch = torch - 1
          stepCount = 0
          clearInv()
        end
  
        stepDown()
        stepCount = stepCount + 1
      end
    end
  
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.up()
    while turtle.getFuelLevel() >= 0 do    
      turtle.up()
      turtle.forward()
    end
  end
  
  main()