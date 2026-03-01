-- Selecionar tabela produto, ordenando por preço
SELECT * FROM produtos
ORDER BY Preco_Unit; -- ascendente
SELECT * FROM produtos
ORDER BY Preco_Unit DESC; -- decrescente

-- Total de produtos por marca
SELECT
	Marca_Produto,
    COUNT(*) as 'Total de Produtos'
FROM produtos GROUP BY Marca_Produto;

-- Consulta na tabela pedidos da Receita total e Custo por Loja
SELECT 
	ID_Loja,
    SUM(Receita_Venda) as 'Receita Total',
    SUM(Custo_Venda) as 'Custo Total'
FROM Pedidos GROUP BY ID_Loja;

-- Pedidos feitos em 03/01/2019
SELECT * FROM pedidos WHERE Data_Venda = '2019-01-03';

-- Tabela pedidos com a Marca, Preço e Categoria

SELECT
	pedidos.*,
    produtos.Marca_Produto,
    produtos.Preco_Unit,
    categorias.Categoria
FROM pedidos
INNER JOIN produtos
	ON pedidos.ID_Produto = produtos.ID_Produto
INNER JOIN categorias
	ON produtos.ID_Categoria = categorias.ID_Categoria;