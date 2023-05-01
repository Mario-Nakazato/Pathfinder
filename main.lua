require "/src/vertice"
require "/src/grafo"
require "/src/astar"

function love.load(arg, unfilteredArg)
    update = true
    ticks = 0
    love.math.setRandomSeed(love.timer.getTime() * 10 ^ 7)
    resolveu = 0
    TIMER = false
    -- c, l = 110, 62
    c, l = 72, 40
    o_i, o_j, d_i, d_j = love.math.random(1, l), love.math.random(1, c), love.math.random(1, l), love.math.random(1, c)
    mapa = grafo.novo()
    for i = 1, l do
        for j = 1, c do
            mapa:vertice(i, j)
            if love.math.random() <= 0.56 then
                if (o_i ~= i or o_j ~= j) and (d_i ~= i or d_j ~= j) then
                    mapa:excluir_vertice(i, j)
                end
            end
        end
    end
    mapa:aresta()
    caminho = astar.novo(mapa.vertices[o_i][o_j], mapa.vertices[d_i][d_j], mapa)
    caminho:iniciar()
    -- while caminho:pathfinder() == nil and true do
    -- end
end

function love.update(dt)
    if not update then
        return
    end

    tick = dt
    ticks = ticks + tick

    b_caminho = caminho:pathfinder()
    if b_caminho ~= nil and not TIMER then
        resolveu = resolveu + 1
        print(b_caminho, "pathfinder", resolveu)
        repeat
            o_i, o_j = love.math.random(1, l), love.math.random(1, c)
            if mapa.vertices[o_i] then
                orig = mapa.vertices[o_i][o_j]
            end
        until orig
        repeat
            d_i, d_j = love.math.random(1, l), love.math.random(1, c)
            if mapa.vertices[d_i] then
                dest = mapa.vertices[d_i][d_j]
            end
        until dest
        TIMER = true
        ticks = 0
    end
    if TIMER and ticks > 2 then
        TIMER           = false
        caminho.origem  = orig
        caminho.destino = dest
        caminho:iniciar()
    end
    if love.math.random() <= 0.01 and false then
        for i = 1, love.math.random(c * l) do
            repeat
                x_i, x_j = love.math.random(1, l), love.math.random(1, c)
                if mapa.vertices[x_i] then
                    vX = mapa.vertices[x_i][x_j]
                end
            until (o_i ~= x_i or o_j ~= x_j) and (d_i ~= x_i or d_j ~= x_j)
            if love.math.random() <= 0.01 then
                if vX then
                    mapa:excluir_vertice(x_i, x_j)
                else
                    mapa:vertice(x_i, x_j)
                end
            end
        end
        mapa:aresta()
    end
end

function love.draw()
    mapa:draw()
    love.graphics.setColor({ love.math.colorFromBytes(255, 255, 255) })
    love.graphics.print(tick, 4, 4)
    love.graphics.print(ticks, 4, 4 + 16)
    love.graphics.print(1 / tick, 4, 4 + 16 * 2)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "f1" then
        update = not update
    end
    if key == 'f5' then
        love.load(arg, unfilteredArg)
    end
    if key == 'f2' then
        repeat
            o_i, o_j = love.math.random(1, l), love.math.random(1, c)
            if mapa.vertices[o_i] then
                orig = mapa.vertices[o_i][o_j]
            end
        until orig
        repeat
            d_i, d_j = love.math.random(1, l), love.math.random(1, c)
            if mapa.vertices[d_i] then
                dest = mapa.vertices[d_i][d_j]
            end
        until dest
        update = true
        caminho.origem = orig
        caminho.destino = dest
        caminho:iniciar()
    end
end

--[[
function love.keyreleased(key, scancode)
end

function love.mousepressed(x, y, button, istouch, presses)
end

function love.mousereleased(x, y, button, istouch, presses)
end

function love.mousemoved(x, y, dx, dy, istouch)
end

function love.wheelmoved(x, y)
end

function love.mousefocus(focus)
end

function love.resize(w, h)
end

function love.focus(focus)
end

function love.quit()
end

function love.touchpressed(id, x, y, dx, dy, pressure)
end

function love.touchreleased(id, x, y, dx, dy, pressure)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
end

function love.displayrotated(index, orientation)
end

function love.textedited(text, start, length)
end

function love.textinput(text)
end

function love.directorydropped(path)
end

function love.filedropped(file)
end

function love.errorhandler(msg)
end

function love.lowmemory()
end

function love.threaderror(thread, errorstr)
end

function love.visible(visible)-- Esta funcao CallBack não funciona, utilize visivel = love.window.isMinimized()
end

--love.physics world callbacks
function beginContact(a, b, coll)
end

function endContact(a, b, coll)
end

function preSolve(a, b, coll)
end

--postSolve(fixture1, fixture2, contact, normal_impulse1, tangent_impulse1, normal_impulse2, tangent_impulse2)
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
--love.physics world callbacks
--]]
