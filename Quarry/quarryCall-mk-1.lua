function send()
    print("width depth DIFRET? ~ ~ ~ dir DIFSTRT? ~ ~ ~ dir :")
    local message = read()

    return message
end

function main()
    local turtleID
    print("turtleNum: ")
    local turtleNum = read()
    local currentLoc = ""

    if turtleNum == "1" then
        turtleID = 18
        currentLoc = "-865 78 736 3 "
    elseif turtleNum == "2" then
        turtleID = 9
        currentLoc = "-863 78 736 3 "
    elseif turtleNum == "3" then
        turtleID = 23
        currentLoc = "-865 78 734 3 "
    elseif turtleNum == "4" then
        turtleID = 22
        currentLoc = "-863 78 734 3 "
    end

    local message = send()
    rednet.open("top")
    rednet.send(turtleID, currentLoc .. message, "quarry")

    rednet.close("top")
end

main()
