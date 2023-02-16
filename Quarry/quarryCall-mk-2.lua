function send()
    print("dir width depth DIFRET? ~ ~ ~ dir DIFSTRT? ~ ~ ~ dir :")
    local message = read()
 
    return message
end
 
function main()
    local turtleID
    print("turtleNum: ")
    local turtleNum = read()
 
    if turtleNum == "1" then
        turtleID = 0
    elseif turtleNum == "2" then
        turtleID = 2
    elseif turtleNum == "3" then
        turtleID = 9
    elseif turtleNum == "4" then
        turtleID = 10
    elseif turtleNum == "5" then
        turtleID = 11
    elseif turtleNum == "6" then
        turtleID = 12
    elseif turtleNum == "7" then
        turtleID = 13
    end
 
    local message = send()
    rednet.open("top")
    rednet.send(turtleID, message, "quarry")
 
    rednet.close("top")
end
 
main()