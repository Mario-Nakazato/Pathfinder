--[[
    Classe grafo
]]

-- Dependência de vértice. Identificação e arestas
require "/src/vertice"

local function novo()
    local classe = {
        vertices = {}
    }

    function classe:vertice(i, j)
        if not self.vertices[i] then
            self.vertices[i] = {}
        end
        self.vertices[i][j] = vertice.novo(i, j)
    end

    -- Cria o conjunto de arestas de vértices para o grafo em 2D. Regra.
    function classe:aresta()
        for k, v in pairs(self.vertices) do
            for l, w in pairs(v) do
                if self.vertices[w.i - 1] then
                    w:aresta(self.vertices[w.i - 1][w.j - 1],
                        math.sqrt((w.i - w.i - 1) ^ 2 + (w.j - w.j - 1) ^ 2))
                    w:aresta(self.vertices[w.i - 1][w.j],
                        math.sqrt((w.i - w.i - 1) ^ 2 + (w.j - w.j) ^ 2))
                    w:aresta(self.vertices[w.i - 1][w.j + 1],
                        math.sqrt((w.i - w.i - 1) ^ 2 + (w.j - w.j + 1) ^ 2))
                end
                if self.vertices[w.i] then
                    w:aresta(self.vertices[w.i][w.j - 1],
                        math.sqrt((w.i - w.i) ^ 2 + (w.j - w.j - 1) ^ 2))
                    w:aresta(self.vertices[w.i][w.j + 1],
                        math.sqrt((w.i - w.i) ^ 2 + (w.j - w.j + 1) ^ 2))
                end
                if self.vertices[w.i + 1] then
                    w:aresta(self.vertices[w.i + 1][w.j - 1],
                        math.sqrt((w.i - w.i + 1) ^ 2 + (w.j - w.j - 1) ^ 2))
                    w:aresta(self.vertices[w.i + 1][w.j],
                        math.sqrt((w.i - w.i + 1) ^ 2 + (w.j - w.j) ^ 2))
                    w:aresta(self.vertices[w.i + 1][w.j + 1],
                        math.sqrt((w.i - w.i + 1) ^ 2 + (w.j - w.j + 1) ^ 2))
                end
            end
        end
    end

    function classe:draw()
        for k, v in pairs(self.vertices) do
            for l, w in pairs(v) do
                w:draw()
            end
        end
        for k, v in pairs(self.vertices) do
            for l, w in pairs(v) do
                w:draw_arestas()
            end
        end
        for k, v in pairs(self.vertices) do
            for l, w in pairs(v) do
                w.draw_aresta = true
            end
        end
    end

    return classe
end

grafo = {
    novo = novo,
}

print("grafo.lua")

return grafo
