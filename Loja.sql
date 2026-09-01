CREATE DATABASE loja
GO
USE loja

CREATE TABLE Marca (
    id_marca INT CONSTRAINT pk_idMarca PRIMARY KEY IDENTITY(1,1)
    nome VARCHAR(80) NOT NULL CONSTRAINT uq_nomeMarca UNIQUE
)
 
CREATE TABLE Produto (
    -- 1. O nome_produto é de preenchimento obrigatório.
    nome_produto VARCHAR(80) NOT NULL

    -- 2. Todos os valores da marca na relação Produto existem na relação Marca em id_marca.
    id_marca INT CONSTRAINT fk_idMarca REFERENCES Marca(id_marca)
    estoque INT NOT NULL CONSTRAINT chk_estoque CHECK(estoque > 0)
    preco MONEY NOT NULL
 
    -- 3. O id_pro é um inteiro com 4 dígitos.
    id_pro INT CONSTRAINT pk_idPro PRIMARY KEY
           CONSTRAINT chk_idPro CHECK(id_pro BETWEEN 1000 AND 9999)
 
    -- 7. O valor total do Estoque de cada Produto não pode exceder os 250.000
    --    (considerando o preço de venda), ou seja: estoque * preço <= 250000
    CONSTRAINT chk_valorEstoque CHECK(estoque * preco <= 250000)
)

CREATE TABLE Pedido (
    id_pedido INT CONSTRAINT pk_idPedido PRIMARY KEY
    valor_desc MONEY NOT NULL CONSTRAINT chk_valorDesc CHECK(valor_desc >= 0),
    valor_total MONEY NOT NULL CONSTRAINT chk_valorTotal CHECK(valor_total >= 0)
 
    -- 4. A data do pedido é por padrão a data atual.
    data DATETIME NOT NULL CONSTRAINT df_dataPedido DEFAULT(GETDATE())
)

CREATE TABLE ItemPedido (
    id_pedido INT CONSTRAINT fk_idPedido REFERENCES Pedido(id_pedido)
    id_pro INT CONSTRAINT fk_idProItem REFERENCES Produto(id_pro)
    qtde INT NOT NULL CONSTRAINT chk_qtde CHECK(qtde > 0)
    vl_unit MONEY NOT NULL
 
    -- 5. No mesmo pedido, não pode haver mais de uma venda do mesmo produto.
    CONSTRAINT pk_itemPedido PRIMARY KEY (id_pedido, id_pro)
 
    -- 6. Se o preço de um item vendido é superior a 1000, então a quantidade vendida tem de ser menor que 100.
    CONSTRAINT chk_precoQtde CHECK(vl_unit <= 1000 OR qtde < 100)

    -- create table itemPedido (
        -- id_pedido int CONSTRAINT fk_item_ped
        --  foreign key REFERENCES Pedido(id_pedido),
        -- id_pro int CONSTRAINT fk_item_pro
        --    foreign key REFERENCES produto(id_pro),
        -- qntde int,
        -- vl_unit money,
        -- CONSTRAINT pk_itemPedido PRIMARY key (id_pedido, id_pro), --> PK composta
        -- Constraint CH_preco_qtde check (vl_unit > 100 and qtde < 100) OR (vl_unit <= 100)
-- )