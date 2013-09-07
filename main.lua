function love.load ()
    speed = 1
    step  = 0.001
    clock = 0
    paused = false

    drawing = false
    currentlifeform = 1
    lifeforms = {}

    X, Y = 80, 55

    Matrix1, Matrix2 = {}, {}
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

    local f = loadfile("lifeforms.lua")
    f()
    loadLifeforms(lifeforms)
end

function love.update (dt)
    if     love.keyboard.isDown("up")   then speed = speed + step
    elseif love.keyboard.isDown("down") then speed = speed - step end

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

    love.graphics.print("draw [d],  clear [c],  random [r],  quit [q],  pause [ ]: " .. tostring(paused), 10, 570)
    if drawing then
        love.graphics.print("lifeform [left|right]: " .. lifeforms.lf[currentlifeform][1] .. " " .. tostring(currentlifeform) .. "/" .. tostring(lifeforms.count), 400, 570)
    else
        love.graphics.print("speed [up|down]: " .. tostring(speed), 400, 570)
    end
    love.graphics.print("by A. Decimo", 700, 570)
end

function love.keypressed (key)
    if key == ' ' then
        if paused then if drawing then drawing = false end paused = false else paused = true end
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
    elseif key == 'd' then
        paused = true
        if drawing then drawing = false; paused = false return end
        drawing = true
    elseif key == 'right' and drawing then
        currentlifeform = currentlifeform + 1
        if currentlifeform > #lifeforms.lf then currentlifeform = 1 end
    elseif key == 'left' and drawing then
        currentlifeform = currentlifeform - 1
        if currentlifeform < 1 then currentlifeform = #lifeforms.lf end
    elseif key == 'q' then
        love.event.quit()
    end
end

function love.mousepressed (x, y, button)
    if button == "l" then
        x = math.floor((x + 9) / 10)
        y = math.floor((y + 9) / 10)

        if drawing then
            local dx, dy = x, y
            local c = ''
            local life = lifeforms.lf[currentlifeform][2]
            local operande = 0
            pause = true
            readFirst = (not readFirst)

            for i = 1, #life do
                c = life:sub(i, i)
                if c:match("%d") then
                    if operande == 0 then
                        operande = tonumber(c)
                    else
                        operande = operande * 10 + tonumber(c)
                    end
                elseif c == lifeforms.char.dead then
                    if operande == 0 then operande = 1 end
                    for j = 1, operande do
                        setCell(dx, dy, 0)
                        dx = dx + 1
                    end
                    operande = 0
                elseif c == lifeforms.char.alive then
                    if operande == 0 then operande = 1 end
                    for j = 1, operande do
                        setCell(dx, dy, 1)
                        dx = dx + 1
                    end
                    operande = 0
                elseif c == lifeforms.char.newline then
                    if operande == 0 then operande = 1 end
                    dy = dy + operande
                    operande = 0
                    dx = x
                end
            end

            readFirst = (not readFirst)
            pause = false
        else
            if readFirst then
                if getCell(x, y) == 1 then Matrix1[(x - 1) * Y + y] = 0 else Matrix1[(x - 1) * Y + y] = 1 end
            else
                if getCell(x, y) == 1 then Matrix2[(x - 1) * Y + y] = 0 else Matrix2[(x - 1) * Y + y] = 1 end
            end
        end
    end
end
