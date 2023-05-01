--[[
    Classe grafo
]]

-- Dependência de vértice. Identificação e arestas
require "/src/vertice"

local function novo()
    local caminho = {}
    local classe = {
        vertices = {}
    }

    function classe:vertice(i, j)
        if not self.vertices[i] then
            self.vertices[i] = {}
        end
        if not self.vertices[i][j] then
            self.vertices[i][j] = vertice.novo(i, j)
        end
    end

    function classe:excluir_vertice(i, j)
        if self.vertices[i] and self.vertices[i][j] then
            for k, v in pairs(self.vertices[i][j]) do
                self.vertices[i][j][k] = nil
            end
            self.vertices[i][j] = nil
        end
    end

    -- Cria o conjunto de arestas de vértices para o grafo em 2D. Regra especifica.
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

    function classe:anular()
        caminho = {}
        for k, v in pairs(self.vertices) do
            for l, w in pairs(v) do
                self.vertices[k][l].cor_vertice = { love.math.colorFromBytes(63, 130, 0) }
                self.vertices[k][l].g = nil
                self.vertices[k][l].p = nil
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
        for k, v in pairs(self.vertices) do -- Para ativar o desenho da aresta, usado para não repetir aresta, opcional.
            for l, w in pairs(v) do
                w.draw_aresta = true
            end
        end
    end

    function classe:mapear(origem, destino, destino_real)
        if origem and destino then
            for k, v in pairs(caminho) do
                v.cor_vertice = { love.math.colorFromBytes(19, 69, 139) }
            end
            caminho = { destino }
            ponteiro = destino.p
            while ponteiro ~= nil and ponteiro ~= origem do
                ponteiro.cor_vertice = { love.math.colorFromBytes(0, 255, 0) }
                table.insert(caminho, ponteiro)
                ponteiro = ponteiro.p
            end
            table.insert(caminho, ponteiro)
            table.insert(caminho, destino_real)
            origem.cor_vertice = { love.math.colorFromBytes(0, 0, 255) }
            destino_real.cor_vertice = { love.math.colorFromBytes(255, 0, 0) }
            if destino ~= destino_real then
                destino.cor_vertice = { love.math.colorFromBytes(255, 255, 0) }
            end
        end
    end

    return classe
end

grafo = {
    novo = novo
}

print("grafo.lua")

return grafo
