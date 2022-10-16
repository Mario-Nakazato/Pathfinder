--[[
    Classe pathfinder
]]
local function novo(o_i, o_j, d_i, d_j, grafo)
    local aberta = {}
    local caminho = {}

    local classe = {
        o_i = o_i, o_j = o_j, d_i = d_i, d_j = d_j,
        grafo = grafo
    }

    if grafo.vertices[o_i] and grafo.vertices[o_i][o_j] then
        grafo.vertices[o_i][o_j].cor_vertice = { love.math.colorFromBytes(0, 0, 255) }
        if grafo.vertices[d_i] and grafo.vertices[d_i][d_j] then
            grafo.vertices[o_i][o_j].g = 0
            aberta = { grafo.vertices[o_i][o_j] }
        end
    end

    function classe:mapear()
        if #aberta > 0 then
            caminho = { aberta[1] }
            ponteiro = aberta[1].p
        end
        while ponteiro ~= nil and self.grafo.vertices[self.o_i] and ponteiro ~= self.grafo.vertices[self.o_i][self.o_j] do
            ponteiro.cor_vertice = { love.math.colorFromBytes(0, 255, 0) }
            table.insert(caminho, ponteiro)
            ponteiro = ponteiro.p
        end
        if self.grafo.vertices[self.d_i] and self.grafo.vertices[self.d_i][self.d_j] then
            self.grafo.vertices[self.d_i][self.d_j].cor_vertice = { love.math.colorFromBytes(255, 0, 0) }
        end
        return caminho
    end

    function classe:pathfinder()
        if #aberta > 0 then
            if self.grafo.vertices[self.d_i] and aberta[1] == self.grafo.vertices[self.d_i][self.d_j] then
                self:mapear()
                return true
            end
            for k, v in pairs(caminho) do
                v.cor_vertice = { love.math.colorFromBytes(58, 146, 94) }
            end
            for k, v in pairs(aberta[1].arestas) do
                for l, w in pairs(v) do
                    local g = (aberta[1].g or 0) + w.g
                    if w.vertice and (w.vertice.g == nil or g < w.vertice.g) then
                        w.vertice.cor_vertice = { love.math.colorFromBytes(255, 255, 0) }
                        w.vertice.g = g
                        w.vertice.h = math.sqrt((self.d_i - w.vertice.i) ^ 2 + (self.d_j - w.vertice.j) ^ 2)
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
            return nil
        else
            return false
        end
    end

    return classe
end

astar = {
    novo = novo
}

print("astar.lua")

return astar
