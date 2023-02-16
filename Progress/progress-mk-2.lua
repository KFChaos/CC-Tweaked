function main()
    local monitor = peripheral.find("monitor")
    rednet.open("top")
    local id, message, protocol
    local turtleNum = 0
    id, message, protocol = rednet.receive("progress")
    local formatted = string.format("%.2f", message)

    if id == 18 then
        turtleNum = 1
        monitor.setCursorPos(1, 1)
        monitor.clearLine()
    elseif id == 9 then
        turtleNum = 2
        monitor.setCursorPos(1, 2)
        monitor.clearLine()
    elseif id == 23 then
        turtleNum = 3
        monitor.setCursorPos(1, 3)
        monitor.clearLine()
    elseif id == 22 then
        turtleNum = 4
        monitor.setCursorPos(1, 4)
        monitor.clearLine()
    end

    monitor.write("Turtle #" .. turtleNum .. "'s Current Progress: " ..
                      formatted .. "%")

    main()
end

main()
