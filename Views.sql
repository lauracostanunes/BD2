-- 1. CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE views;
GO
USE views;
GO

CREATE TABLE Fabricante (
    CodFabr      INT IDENTITY(1,1) PRIMARY KEY,
    RazaoSocial  VARCHAR(100) NOT NULL,
    Cidade       VARCHAR(50)  NOT NULL DEFAULT 'FRANCA',
    UF           CHAR(2)      NOT NULL,
    CONSTRAINT CK_Fabricante_UF CHECK (UF IN ('SP', 'MG', 'RJ'))
);

CREATE TABLE Categoria (
    CodCat     INT          PRIMARY KEY,
    Descricao  VARCHAR(100) NOT NULL,
    Status     VARCHAR(7)   NOT NULL,
    CONSTRAINT CK_Categoria_CodCat CHECK (CodCat BETWEEN 100 AND 999),
    CONSTRAINT CK_Categoria_Status CHECK (Status IN ('ATIVO', 'INATIVO'))
);

CREATE TABLE Marca (
    CodMarca   INT IDENTITY(5000,1) PRIMARY KEY,
    NomeMarca  VARCHAR(100) NOT NULL,
    CONSTRAINT UQ_Marca_Nome UNIQUE (NomeMarca)
);

CREATE TABLE Produto (
    CodPro      INT IDENTITY(1,1) PRIMARY KEY,
    Descricao   VARCHAR(150) NOT NULL,
    Preco       DECIMAL(10,2) NOT NULL,
    Estoque     INT NOT NULL,
    CodFabr     INT NOT NULL,
    CodCat      INT NOT NULL,
    CodMarca    INT NOT NULL,
    CONSTRAINT CK_Produto_Preco   CHECK (Preco > 0),
    CONSTRAINT CK_Produto_Estoque CHECK (Estoque > 0),
    CONSTRAINT FK_Produto_Fabricante FOREIGN KEY (CodFabr) REFERENCES Fabricante(CodFabr),
    CONSTRAINT FK_Produto_Categoria  FOREIGN KEY (CodCat)  REFERENCES Categoria(CodCat),
    CONSTRAINT FK_Produto_Marca      FOREIGN KEY (CodMarca) REFERENCES Marca(CodMarca)
);

INSERT INTO Marca (NomeMarca) VALUES
('Marca Alpha'),
('Marca Beta'),
('Marca Gama'),
('Marca Delta'),
('Marca Épsilon');

INSERT INTO Fabricante (RazaoSocial, Cidade, UF) VALUES
('Fabricante SP Ltda', 'FRANCA', 'SP'),
('Fabricante RJ S.A.', 'Rio de Janeiro', 'RJ'),
('Fabricante MG Comercio', 'Uberlandia', 'MG');

INSERT INTO Categoria (CodCat, Descricao, Status) VALUES
(101, 'Eletronicos', 'ATIVO'),
(102, 'Ferramentas', 'INATIVO'),
(103, 'Moveis', 'INATIVO');

INSERT INTO Produto (Descricao, Preco, Estoque, CodFabr, CodCat, CodMarca) VALUES
('Furadeira 500W', 250.00, 10, 1, 102, 5000),
('Notebook X1',   3500.00, 5,  1, 101, 5001),
('Cadeira Office',  450.00, 20, 3, 103, 5002),
('Parafusadeira',   180.00, 15, 2, 102, 5003);

CREATE VIEW vw_ProdutoCompleto AS
SELECT
    p.CodPro,
    p.Descricao AS DescricaoProduto,
    p.Preco,
    c.Descricao AS Categoria,
    f.RazaoSocial AS NomeFabricante,
    f.Cidade AS CidadeFabricante
FROM Produto p
JOIN Categoria c  ON p.CodCat  = c.CodCat
JOIN Fabricante f ON p.CodFabr = f.CodFabr;

CREATE VIEW vw_ProdutosFabricanteRJ AS
SELECT
    p.CodPro,
    p.Descricao,
    p.Preco,
    f.RazaoSocial AS Fabricante,
    f.UF
FROM Produto p
JOIN Fabricante f ON p.CodFabr = f.CodFabr
WHERE f.UF = 'RJ';

CREATE VIEW vw_CategoriasInativasComProdutoSP AS
SELECT DISTINCT
    c.CodCat,
    c.Descricao,
    c.Status
FROM Categoria c
JOIN Produto p    ON c.CodCat  = p.CodCat
JOIN Fabricante f ON p.CodFabr = f.CodFabr
WHERE f.UF = 'SP'
  AND c.Status = 'INATIVO';

CREATE VIEW vw_ValorEstoqueProdutoSP AS
SELECT
    p.Descricao AS Produto,
    (p.Preco * p.Estoque) AS ValorTotalEstoque,
    c.Descricao AS Categoria
FROM Produto p
JOIN Categoria c  ON p.CodCat  = c.CodCat
JOIN Fabricante f ON p.CodFabr = f.CodFabr
WHERE f.UF = 'SP';

CREATE VIEW vw_FabricanteMarcaCategoriaInativa AS
SELECT DISTINCT
    f.RazaoSocial AS Fabricante,
    m.NomeMarca   AS Marca
FROM Produto p
JOIN Fabricante f ON p.CodFabr = f.CodFabr
JOIN Categoria c  ON p.CodCat  = c.CodCat
LEFT JOIN Marca m ON p.CodMarca = m.CodMarca
WHERE c.Status = 'INATIVO';

CREATE VIEW vw_ProdutoMarcaOrdenado AS
SELECT TOP 100 PERCENT
    p.Descricao AS Produto,
    p.Preco,
    m.NomeMarca AS Marca
FROM Produto p
LEFT JOIN Marca m ON p.CodMarca = m.CodMarca

SELECT * FROM vw_ProdutoCompleto;
SELECT * FROM vw_ProdutosFabricanteRJ;
SELECT * FROM vw_CategoriasInativasComProdutoSP;
SELECT * FROM vw_ValorEstoqueProdutoSP;
SELECT * FROM vw_FabricanteMarcaCategoriaInativa;
SELECT * FROM vw_ProdutoMarcaOrdenado ORDER BY Produto;