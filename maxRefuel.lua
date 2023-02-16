for i = 1,16 do
    item = turtle.getItemDetail(i)
    if item then
      if item.name == "minecraft:coal" or item.name == "minecraft:charcoal" then
        turtle.select(i)
        turtle.refuel(all)
      end
    end
  end
  
  turtle.select(1)