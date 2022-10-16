--[[
    Classe pathfinder
]]

local function pathfinder(o_i, o_j, d_i, d_j, grafo)
    local aberta = {}

    local function mapear()
        grafo.vertices[d_i][d_j].cor_vertice = { love.math.colorFromBytes(255, 0, 0) }
        local caminho = { grafo.vertices[d_i][d_j] }
        local ponteiro = grafo.vertices[d_i][d_j].p
        while ponteiro ~= nil and ponteiro ~= grafo.vertices[o_i][o_j] do
            ponteiro.cor_vertice = { love.math.colorFromBytes(0, 255, 0) }
            table.insert(caminho, ponteiro)
            ponteiro = ponteiro.p
        end

        return caminho
    end

    if grafo.vertices[o_i] and grafo.vertices[o_i][o_j] then
        grafo.vertices[o_i][o_j].g = 0
        grafo.vertices[o_i][o_j].cor_vertice = { love.math.colorFromBytes(0, 0, 255) }
        aberta = { grafo.vertices[o_i][o_j] }
    end

    while #aberta > 0 do
        if grafo.vertices[d_i] and aberta[1] == grafo.vertices[d_i][d_j] then

            return mapear()
        end
        for k, v in pairs(aberta[1].arestas) do
            for l, w in pairs(v) do
                local g = (aberta[1].g or 0) + w.g
                if w.vertice and (w.vertice.g == nil or g < w.vertice.g) then
                    w.vertice.cor_vertice = { love.math.colorFromBytes(255, 0, 255) }
                    w.vertice.g = g
                    w.vertice.h = math.sqrt((d_i - w.vertice.i) ^ 2 + (d_j - w.vertice.j) ^ 2)
                    w.vertice.f = w.vertice.g + w.vertice.h
                    w.vertice.p = aberta[1]
                    for m, x in pairs(aberta) do
                        existe = false
                        if w.vertice == x then
                            existe = true
                            break
                        end
                    end
                    if not existe then
                        table.insert(aberta, w.vertice)
                    end
                end
            end
        end
        table.remove(aberta, 1)
        table.sort(aberta, function(i, j) return i.f < j.f end)
    end

    return false
end

astar = {
    pathfinder = pathfinder
}

print("astar.lua")

return astar
