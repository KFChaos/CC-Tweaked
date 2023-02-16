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
  
  function main()
    rednet.open("left")
    local id, message, protocol
    local tableSize = 0
    print("Waiting for orders")
  
    id, message, protocol = rednet.receive("quarry")
    print(message)
  
    quarryCall = split(message, " ")
  
    for _ in pairs(quarryCall) do tableSize = tableSize + 1 end
    print("input has: " .. tableSize .. " entries")
  
    for i = 1, tableSize do print(quarryCall[i]) end
  
    print("Quarry Complete")
    main()
  end
  
  main()