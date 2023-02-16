function send()
    print("~ ~ ~ dir width depth T ~ ~ ~ dir T ~ ~ ~ dir :")
    local message = read()
    -- -863 78 734 3 32 -58 F T -848 72 719 1
    return message
  end
  
  function main()
    local turtleID
    print("turtleNum: ")
    local turtleNum = read()
  
    if turtleNum == "1" then
        turtleID = 18
    elseif turtleNum == "2" then
        turtleID = 9
    elseif turtleNum == "3" then
        turtleID = 23
    elseif turtleNum == "4" then
        turtleID = 22
    end
  
    print("Turtle Num: "..turtleID.. "  Turtle ID: "..turtleNum)
    local message = send()
    print(message)
    print("quarry" .. turtleNum)
  
    rednet.open("top")
    rednet.send(turtleID, message, "quarry")
    print(message)
  
    rednet.close("top")
  end
  
  main()
  