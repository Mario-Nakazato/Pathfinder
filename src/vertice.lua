--[[
    Classe vértice
    Criada para ser utilizada em grafos.

    Fazer:
    Add aresta vértice e g, aresta é uma classe?
]]

H = 16 -- Tamanho
L = 18 -- Espaçamento
C = 32 -- Deslocamento

--[[
    Construtor os parâmetros i e j são identificação única do vértice em 2D.
    Poder ser alteradas para formas diversas identificação única, futura mudança.
]]
local function novo(i, j)
    local classe = {
        i = i, j = j, -- Variáveis que podem mudar para atender diferentes identificadores únicos.
        g, h, f, p, -- g custo até o vértice, h heurística até o objetivo, f = g + h, p aponta vértice pai.
        arestas = {}, -- Conjunto de vértice conectados.
        -- Adicional para visualização gráfica, opcional.
        draw_aresta = false, -- Para não repetir o desenho da aresta. true, desenhar.
        cor_vertice = { love.math.colorFromBytes(255, 255, 255) },
        cor_aresta = { love.math.colorFromBytes(127, 127, 127) }
    }

    -- Cria aresta para este vértice e custo g.
    function classe:aresta(vertice, g)
        if vertice then
            if not self.arestas[vertice.i] then
                self.arestas[vertice.i] = {}
            end
            self.arestas[vertice.i][vertice.j] = { vertice = vertice, g = g }
        end
    end

    -- Adicional para visualização gráfica, opcional.
    function classe:draw() -- Desenha o vértice.
        love.graphics.setColor(self.cor_vertice)
        -- love.graphics.circle("fill", self.j * L + C + H / 2, self.i * L + C + H / 2, H / 2)
        love.graphics.rectangle("fill", self.j * L + C, self.i * L + C, H, H)
    end

    function classe:draw_arestas() -- Desenha as arestas.
        for k, v in pairs(self.arestas) do
            for l, w in pairs(v) do
                if self.draw_aresta and w.vertice and w.vertice.draw_aresta then -- Obs: trocar and por or resulta no em grafos direcionados, testar.
                    love.graphics.setColor(self.cor_aresta)
                    love.graphics.line(self.j * L + C + H / 2, self.i * L + C + H / 2, w.vertice.j * L + C + H / 2,
                        w.vertice.i * L + C + H / 2)
                end
            end
        end
        self.draw_aresta = false
    end

    return classe
end

vertice = {
    novo = novo
}

print("vertice.lua")

return vertice
