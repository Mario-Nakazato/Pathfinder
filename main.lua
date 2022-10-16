require "/src/vertice"
require "/src/grafo"
require "/src/astar"

function love.load(arg, unfilteredArg)
    ARESTA = false
    update = true
    ticks = 0
    math.randomseed(os.clock())
    c, l = 72, 40
    mapa = grafo.novo()
    for i = 1, l do
        for j = 1, c do
            if j ~= 8 and i ~= 7 then
                mapa:vertice(i, j)
            end
        end
    end
    mapa.vertices[11][7]:aresta(mapa.vertices[5][9], 1)
    mapa.vertices[5][9]:aresta(mapa.vertices[11][7], 1)
    mapa.vertices[11][7]:aresta(mapa.vertices[4][1], 1)
    mapa.vertices[4][1]:aresta(mapa.vertices[11][7], 1)
    mapa.vertices[4][1]:aresta(mapa.vertices[9][15], 1)
    mapa.vertices[9][15]:aresta(mapa.vertices[4][1], 1)
    mapa.vertices[19][15]:aresta(mapa.vertices[13][49], 1)
    mapa.vertices[13][49]:aresta(mapa.vertices[19][15], 1)
    mapa:aresta()
    caminho = astar.novo(math.random(1, l), math.random(1, c), math.random(1, l), math.random(1, c), mapa)
    -- while caminho:pathfinder() == nil and true do
    -- end
end

function love.update(dt)
    if not update then
        return
    end

    tick = dt
    ticks = ticks + tick
    caminho:pathfinder()
    caminho:mapear()
    mapa.vertices[11][7].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
    mapa.vertices[5][9].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
    mapa.vertices[4][1].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
    mapa.vertices[9][15].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
    mapa.vertices[19][15].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
    mapa.vertices[13][49].cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
end

function love.draw()
    if not ARESTA then
        for k, v in pairs(mapa.vertices) do
            for l, w in pairs(v) do
                w.draw_aresta = false
            end
        end
    end
    mapa:draw()
    love.graphics.setColor({ love.math.colorFromBytes(255, 255, 255) })
    love.graphics.print(tick, 4, 4)
    love.graphics.print(ticks, 4, 4 + 16)
    love.graphics.print(1 / tick, 4, 4 + 16 * 2)
end

function love.keypressed(key, scancode, isrepeat)
    if key == "f5" then
        love.load(arg, unfilteredArg)
    end
    if key == "a" then
        ARESTA = not ARESTA
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
