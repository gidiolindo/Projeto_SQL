CREATE DATABASE WF;
USE WF;

-- Criação da tabela

CREATE TABLE Loja (
ID_Loja INT,
Nome_Loja VARCHAR(100),
Regiao VARCHAR(100),
Qtd_Vendida FLOAT);

INSERT INTO Loja (ID_Loja, Nome_Loja, Regiao, Qtd_Vendida)
VALUES
	(1, 'Botafogo Praia&Mar', 'Sudeste', 1800),
	(2, 'Lojas Vitoria', 'Sudeste', 800),
	(3, 'Emporio Mineirinho', 'Sudeste', 2300),
	(4, 'Central Paulista', 'Sudeste', 1800),
	(5, 'Rio 90 graus', 'Sudeste', 700),
	(6, 'Casa Flor & Anópolis', 'Sul', 2100),
	(7, 'Pampas & Co', 'Sul', 990),
	(8, 'Paraná Papéis', 'Sul', 2800),
	(9, 'Amazonas Prime', 'Norte', 4200),
	(10, 'Pará Bens', 'Norte', 3200),
	(11, 'Tintas Rio Branco', 'Norte', 1500),
	(12, 'Nordestemido Hall', 'Nordeste', 1910),
	(13, 'Cachoerinha Loft', 'Nordeste', 2380);

CREATE TABLE Resultado(
Data_Fechamento DATE,
FaturamentoMM FLOAT
);

INSERT INTO Resultado (Data_Fechamento, FaturamentoMM)
VALUES
	('2020-01-01', 8),
	('2020-02-01', 10),
	('2020-03-01', 6),
	('2020-04-01', 9),
	('2020-05-01', 5),
	('2020-06-01', 4),
	('2020-07-01', 7),
	('2020-08-01', 11),
	('2020-09-01', 9),
	('2020-10-01', 12),
	('2020-11-01', 11),
	('2020-12-01', 10);


-- Visualização da tabela  Loja  
SELECT * FROM Loja;

-- Total de vendas
SELECT
	SUM(Qtd_Vendida) as 'Total Vendido'
FROM Loja;

-- Total de vendas por região
SELECT
	Regiao as 'Região',
	SUM(Qtd_Vendida) as 'Valor Vendido'
FROM Loja 
GROUP BY Regiao;

-- Percentual de participação de cada loja em relação ao total de vendas de todas as lojas
SELECT 
	*,
    SUM(Qtd_Vendida) OVER() as 'Total Vendido',
    100 * (Qtd_Vendida / SUM(Qtd_Vendida) OVER()) AS 'Participação de Vendas'
FROM Loja;

-- Percentual de participação de cada loja em relação as vendas de sua região

SELECT 
	*,
    SUM(Qtd_Vendida) OVER (PARTITION BY Regiao) as 'Total Vendido Região',
    100 * (Qtd_Vendida/SUM(Qtd_Vendida) OVER (PARTITION BY Regiao)) as 'Participação por Região'
FROM Loja
ORDER BY ID_Loja;

-- Ranking de vendas das lojas da região Sudeste
SELECT 
	* ,
    DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) as 'Ranking'
FROM Loja 
WHERE Regiao = 'Sudeste'; 

-- Ranking de todas as lojas

SELECT 
	* ,
	DENSE_RANK() OVER (ORDER BY Qtd_Vendida DESC) as 'Ranking'
FROM Loja;

-- Ranking de lojas pela região

SELECT
	*,
    DENSE_RANK() OVER (PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) as 'Ranking'
FROM Loja;

-- Visualizar tabela resultado
SELECT * FROM Resultado;

-- Média Móvel Faturamento
SELECT 
	*,
    AVG(FaturamentoMM) OVER (ORDER BY Data_Fechamento ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Faturamento'
FROM Resultado;

-- Acumulado de Faturamento
SELECT
	*,
    SUM(FaturamentoMM) OVER (ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Faturamento Acumulado'
FROM Resultado;

-- Month over Month
SELECT
	*,
    LAG(FaturamentoMM,1, FaturamentoMM) OVER(ORDER BY Data_Fechamento) AS 'Fat. mês anterior',
    ((FaturamentoMM / LAG(FaturamentoMM, 1, FaturamentoMM) OVER(ORDER BY Data_Fechamento)) - 1) * 100  as 'MoM'
FROM Resultado;





