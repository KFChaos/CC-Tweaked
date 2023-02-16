function main()
    rednet.open("top")
    local id, message, protocol
    local turtleNum = 0
    id, message, protocol = rednet.receive("progress")

    if id == 18 then
        turtleNum = 1
    elseif id == 9 then
        turtleNum = 2
    elseif id == 23 then
        turtleNum = 3
    elseif id == 22 then
        turtleNum = 4
    end

    print("Turtle #" .. turtleNum .. "'s Current Progress: " .. message .. "%")

    main()
end

main()
