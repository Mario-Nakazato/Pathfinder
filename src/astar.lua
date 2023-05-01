--[[
    Classe pathfinder
]]
local function novo(origem, destino, grafo)
    local aberta = {}

    local classe = {
        origem = origem, destino = destino,
        grafo = grafo
    }

    function classe:iniciar()
        self.grafo:anular()
        self.origem.g = 0
        aberta = { self.origem }
    end

    function classe:pathfinder()
        if self.origem and self.destino then
            self.grafo:mapear(self.origem, aberta[1], self.destino)
            if #aberta > 0 then
                if aberta[1] == self.destino then
                    self.origem = nil
                    self.destino = nil
                    return true
                end
                if aberta[1].arestas then
                    for k, v in pairs(aberta[1].arestas) do
                        for l, w in pairs(v) do
                            local g = (aberta[1].g or 0) + w.g
                            if w.vertice.i and (w.vertice.g == nil or g < w.vertice.g) then
                                w.vertice.g = g
                                w.vertice.h = math.sqrt((self.destino.i - w.vertice.i) ^ 2 +
                                    (self.destino.j - w.vertice.j) ^ 2)
                                w.vertice.f = w.vertice.g + w.vertice.h
                                w.vertice.p = aberta[1]
                                existe = false
                                for m, x in pairs(aberta) do
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
                end
                table.remove(aberta, 1)
                table.sort(aberta, function(i, j) if not i.f or not j.f then return false end return i.f < j.f end)
            else
                self.origem = nil
                self.destino = nil
                return false
            end
        end
        return nil
    end

    return classe
end

astar = {
    novo = novo
}

print("astar.lua")

return astar
