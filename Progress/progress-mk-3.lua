function clear()
    mon.setBackgroundColor(colors.black)
    mon.clear()
    mon.setCursorPos(1, 1)
end

function drawText(x, y, text, textColor, BGColor)
    mon.setBackgroundColor(BGColor)
    mon.setTextColor(textColor)
    mon.setCursorPos(x, y)
    mon.write(text)
end

function drawLine(x, y, length, size, lineColor)
    for yPos = y, y + size - 1 do
        mon.setBackgroundColor(lineColor)
        mon.setCursorPos(x, yPos)
        mon.write(string.rep(" ", length))
    end
end

function drawProg(x, y, name, length, size, minVal, maxVal, lineColor, BGColor)
    local barSize = math.floor((minVal / maxVal) * length)
    local text = name .. " " .. math.floor((minVal / maxVal) * 100) .. "%"
    drawLine(x, y, length, size, BGColor)
    drawLine(x, y, barSize, size, lineColor)

    if (barSize > (monX / 2 + #text / 2)) then
        drawText(monX / 2 - #text / 2 + 2, y + size / 2, text, colors.black,
                 lineColor)
    elseif barSize > #text then
        drawText(x + barSize - #text, y + size / 2, text, colors.black,
                 lineColor)
    else
        drawText(monX / 2 - #text / 2 + 2, y + size / 2, text, colors.black,
                 BGColor)
    end
end

function init()
    mon = peripheral.wrap("left")
    monX, monY = mon.getSize()
    turtle1height = 2
    turtle2height = 6
    turtle3height = 10
    turtle4height = 14
    prog1 = 0
    prog2 = 0
    prog3 = 0
    prog4 = 0
    rednet.open("top")

    drawProg(2, turtle1height, "Turtle1", monX - 2, 3, prog1, 100, colors.green,
             colors.gray)
    drawProg(2, turtle2height, "Turtle2", monX - 2, 3, prog2, 100, colors.green,
             colors.gray)
    drawProg(2, turtle3height, "Turtle3", monX - 2, 3, prog3, 100, colors.green,
             colors.gray)
    drawProg(2, turtle4height, "Turtle4", monX - 2, 3, prog4, 100, colors.green,
             colors.gray)
end

function update()
    local id, message, protocol
    local turtleNum = 0
    local id, message, protocol = rednet.receive("progress")
    local formatted = string.format("%.2f", message)

    if id == 18 then
        turtleNum = 1
        prog1 = tonumber(message)
        drawProg(2, turtle1height, "Turtle1", monX - 2, 3, prog1, 100,
                 colors.green, colors.gray)
    elseif id == 9 then
        turtleNum = 2
        prog2 = tonumber(message)
        drawProg(2, turtle2height, "Turtle2", monX - 2, 3, prog2, 100,
                 colors.green, colors.gray)
    elseif id == 23 then
        turtleNum = 3
        prog3 = tonumber(message)
        drawProg(2, turtle3height, "Turtle3", monX - 2, 3, prog3, 100,
                 colors.green, colors.gray)
    elseif id == 22 then
        turtleNum = 4
        prog4 = tonumber(message)
        drawProg(2, turtle4height, "Turtle4", monX - 2, 3, prog4, 100,
                 colors.green, colors.gray)
    end

    update()
end

function main()
    init()
    update()
end

main()
