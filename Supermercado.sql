-- Criar novo BD
CREATE DATABASE venda
USE venda

-- GO para executar um só se tiver execuado o outro

CREATE TABLE Categoria (
	codCat int PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(100)
);

CREATE TABLE Produto (
	codPro int PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(100),
	quantidade VARCHAR(100),
	codBarras VARCHAR(100),
	Estoque decimal(10,2),
	codCat int FOREIGN KEY REFERENCES Categoria (codCat)
);

INSERT INTO Categoria VALUES
	('CASA'),
	('BANHO'),
	('BEBIDA'),
	('VERDURAS'),
	('FRIOS');

INSERT INTO Produto VALUES
	('COCA-COLA', '100...10', 40.0, 3),
	('SABONETE', '111...01', 30.0, 2),
	('DETERGENTE', '011...10', 100.0, 1),
	('ALFACE', '197...11', 50.0, 4),
	('SALAME', '000...11', 25.0, 5),
	('SABÃO EM PÓ', '010...00', 15.0, 1),
	('CERVEJA', '110...11', 21.0, 3),
	('AMACIANTE', '000...00', 7.0, 1);

UPDATE Produto
SET Estoque = 350.0
WHERE codPro = 4;

SELECT descricao, codbarra, estoque
FROM Produto
WHERE estoque > 500.0;

DELETE * FROM Produto WHERE codcat = 3; -- Ou DELETE Produto WHERE codcat = 3

INSERT INTO Produto (descricao, estoque, codCat) VALUES
	('SHAMPOO', 55.0, 2);

ALTER TABLE Produto DROP COLUMN codbarra;

SELECT descricao, estoque
FROM Produto
ORDER BY estoque DESC;

ALTER TABLE Produto
ADD precoUnitario DECIMAL(10,3);

DELETE * FROM Produto
WHERE codcat = 1
OR codcat = 3
OR codcat = 5;

INSERT INTO Produto (precoUnitario) VALUES
	(8.0),
	(2.0),
	(5.0),
	(12.0),
	(15.0),
	(14.0),
	(25.0),
	(18.0);

SELECT Produto.Descricao, Categoria.Nomecat
FROM Produto
JOIN Categoria
ON Produto.codcat = Categoria.codcat;

SELECT Categoria.codcat, Categoria.Nomecat
FROM Categoria
LEFT JOIN Produto
ON Categoria.codcat = Produto.codcat
WHERE Produto.codpro IS NULL;

UPDATE Produto
SET precoUnit = precoUnit + 1,05
WHERE estoque < 400.0;

-- Update preço
UPDATE produto SET preco = preco * 0.85
WHERE codcat = 1

-- Funções de agregação
-- MAX = retorna valor máximo
SELECT MAX(estoque) AS maiorEstoque
FROM produto

-- MIN = retorna valor mínimp
SELECT MIN(estoque) AS menorEstoque
FROM produto

-- MAX + MIN
SELECT MAX(estoque) AS maiorEstoque MIN(estoque) AS menorEstoque
FROM produto

-- SUM = retona a soma
SELECT SUM(preco) AS precoTotal
FROM produto

SELECT SUM (estoque * preco) AS ValorTotalEstoque
FROM produto

-- CAMPO CALCULADO -> não é uma fução de aggregação
SELECT descricao, preco, estoque * preco
FROM produto -- Retorna o valor em estoque de cada produto

-- AVG = calcula a média
SELECT AVG(preco) as PrecoMedio
FROM produto

-- ROUND = arredonda
SELECT ROUND(12345.6789, 2) -- Usa o ponto como vírgula -> padrão americano
-- Arredondou para dois números depois da vírgula

SELECT ROUND(AVG(preco), 2) AS PrecoMedio
FROM produto

-- COUNT = conta o número de ocorrências
SELECT COUNT (descricao)
FROM produto

SELECT COUNT (codCat) AS contagem
FROM produto

SELECT COUNT(*) AS contagem -- Conta campos não nulos -> PK
FROM produto

-- SUBTRAÇÃO NO SELECT
SELECT COUNT(*) - COUNT(codCat) AS totalSemCategoria
FROM produto

-- MULTIPLICAÇÃO PARA CRIAR CAMPO CALCULADO
-- Qual seria o novo preço se aplicasse 10% de acréscimo?
SELECT descricao, preco, preco * 1.10 AS precoReajustado
FROM produto



-- DISTINCT: Selecionar linhas exclusivas
-- EX: Se quiser o primeiro nome dos alunos, os nomes iguais não ficam repetindo
SELECT DISTINCT (codCat) AS categoriasProdutos
FROM produto