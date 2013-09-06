function love.load ()
    speed = 1
    step  = 0.001
    clock = 0
    paused = false
    mx, my = 0, 0

    Matrix1, Matrix2 = {}, {}
    X, Y = 80, 55
    mt = {__index = function () return 0 end}
    setmetatable(Matrix1, mt)
    setmetatable(Matrix2, mt)

    readFirst = false

    function getCell (x, y)
        if readFirst then
            return Matrix1[(x - 1) * Y + y]
        else
            return Matrix2[(x - 1) * Y + y]
        end
    end
    function setCell (x, y, v)
        if readFirst then
            Matrix2[(x - 1) * Y + y] = v
        else
            Matrix1[(x - 1) * Y + y] = v
        end
    end
    function countNeighboors (x, y)
        return getCell(x - 1, y - 1) + getCell(x, y - 1) + getCell(x + 1, y - 1) +
               getCell(x - 1, y)               +           getCell(x + 1, y)     +
               getCell(x - 1, y + 1) + getCell(x, y + 1) + getCell(x + 1, y + 1)
    end
    function changeMatrix ()
        readFirst = (not readFirst)
        for x = 1, X do
            for y = 1, Y do
                setCell(x, y, 0)
            end
        end
    end
    function randomize ()
        for x = 1, X do
            for y = 1, Y do
                setCell(x, y, math.random(0, 1))
            end
        end
    end

    randomize()
    readFirst = (not readFirst)

    love.graphics.setBackgroundColor({0, 0, 0})
    love.graphics.setColor({255, 255, 255})

end

function love.update (dt)
    if     love.keyboard.isDown("up")   then speed = speed + step
    elseif love.keyboard.isDown("down") then speed = speed - step end

    mx, my = love.mouse.getPosition()
    mx = mx or 0
    my = my or 0

    clock = clock + dt
    if clock < speed or paused then return end

    local neighboors = 0
    for x = 1, X do
        for y = 1, Y do
            neighboors = countNeighboors(x, y)
            if neighboors > 3 or neighboors < 2 then
                setCell(x, y, 0)
            elseif neighboors == 3 or (neighboors == 2 and getCell(x, y) == 1) then
                setCell(x, y, 1)
            end
        end
    end
    changeMatrix()
    clock = 0
end

function love.draw ()
    for x = 1, X do
        for y = 1, Y do
            if getCell(x, y) == 1 then
                love.graphics.rectangle("fill", 10 * x - 9, 10 * y - 9, 8, 8)
            end
        end
    end

    love.graphics.print("clear [c],  random [r],  quit [q],  pause [ ]: " .. tostring(paused), 10, 570)
    love.graphics.print("speed [up|down]: " .. tostring(speed), 350, 570)
    love.graphics.print("by A. Decimo", 700, 570)
    -- love.graphics.print("mouse:  " .. tostring(mx) .. ", " .. tostring(my), 180, 550)
    -- love.graphics.print("neighb: " .. tostring(countNeighboors(math.floor((mx + 9) / 10), math.floor((my + 9) / 10))), 180, 570)
    -- love.graphics.print("matrix: " .. tostring(readFirst), 350, 550)
end

function love.keypressed (key)
    if key == ' ' then
        if paused then paused = false else paused = true end
    elseif key == 'c' then
        paused = true
        changeMatrix()
        changeMatrix()
    elseif key == 'r' then
        paused = true
        changeMatrix()
        randomize()
        readFirst = (not readFirst)
        paused = false
    elseif key == 'q' then
        love.event.quit()
    end
end

function love.mousepressed (x, y, button)
    if button == "l" then
        x = math.floor((x + 9) / 10)
        y = math.floor((y + 9) / 10)

        if readFirst then
            if getCell(x, y) == 1 then Matrix1[(x - 1) * Y + y] = 0 else Matrix1[(x - 1) * Y + y] = 1 end
        else
            if getCell(x, y) == 1 then Matrix2[(x - 1) * Y + y] = 0 else Matrix2[(x - 1) * Y + y] = 1 end
        end
    end
end
