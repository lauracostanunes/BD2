CREATE DATABASE Cliente
GO
USE Cliente

-- 1. Criar uma tabela com o nome TB_CLIENTE.
CREATE TABLE TB_CLIENTE (
    -- a. Um atributo código do tipo inteiro;
    -- 2.a. O atributo código representa a chave primária da tabela;
    codigo INT NOT NULL CONSTRAINT pk_codigo PRIMARY KEY IDENTITY(1,1)
    -- No SQLServer, não pode cusar identity se for com alter table
    -- O professor criou a tabela e fez com alter table
    -- alter table tb_cliente
    --    add
    --        constraint pk_cliente primary key (cod)

    -- b. Um atributo nome do tipo cadeia de caracteres de tamanho 50;
    nome VARCHAR(50) NOT NULL

    -- c. Um atributo telefone do tipo cadeia de caracteres de tamanho 20;
    telefone VARCHAR(20) NOT NULL

    -- d. Um atributo tipo_cliente do tipo cadeia de caracteres de tamanho 20;
    -- 2.c. O atributo tipo_cliente deve ser "Titular" ou "Dependente";
    tipo_cliente VARCHAR(20) NOT NULL CONSTRAINT chk_tipoCliente CHECK(tipo_cliente IN('Titular', 'Dependente'))
    -- alter table tb_cliente
    --    add
    --    constraint chk_Cliente check ((tipo_cliente = 'Titular') OR (tipo_cliente = 'De3pendente'))

    -- e. Um atributo dt_cadastro do tipo data e hora;
    -- 2.b. O atributo dt_cadastro deve ter como valor padrão (default) a data e hora atual do sistema;
    dt_cadastro DATETIME NOT NULL CONSTRAINT df_dtCadastro DEFAULT(GETDATE())
    -- alter table tb_cliente
    --  add
    --  constraint df_data default (getdate()) for dt_cadastro

    -- f. Um atributo nr_dependentes do tipo inteiro.
    -- 2.d. O atributo nr_dependentes deve ser um inteiro maior ou igual a 0 e menor ou igual a 3.
    nr_dependentes INT NOT NULL CONSTRAINT chk_nrDependentes CHECK(nr_dependentes BETWEEN 0 AND 3)
    -- Aqui dava para fazer com or
    -- alter table tb_cliente
    --  add
    --  constraint chk_nrDependentes check ((nr_dependentes >= 0) OR (nr_dependentes <= 3))
)


-- 3. Utilizar comandos SQL de inserção e atualização que tentem verificar e violar as restrições acima.
-- INSERT válido (respeita todas as regras)
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Maria Silva', '(16) 99999-1234', 'Titular', 2)

-- INSERT válido, informando a data de cadastro manualmente
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, dt_cadastro, nr_dependentes)
VALUES ('João Souza', '(16) 98888-5678', 'Dependente', '2024-05-10', 1)

-- Testando o DEFAULT, não informa dt_cadastro, o sistema preenche com a data/hora atual
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Carlos Lima', '(16) 97777-4321', 'Titular', 0)

-- Tentando violar o CHECK de tipo_cliente -> deve dar erro
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Ana Paula', '(16) 96666-1111', 'Funcionario', 1)

-- Tentando violar o CHECK de nr_dependentes, valor acima do limite -> deve dar erro
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Pedro Alves', '(16) 95555-2222', 'Titular', 5)

-- Tentando violar o CHECK de nr_dependentes, valor negativo -> deve dar erro
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Fernanda Costa', '(16) 94444-3333', 'Dependente', -1)

-- Tentando violar a obrigatoriedade do telefone -> deve dar erro
INSERT INTO TB_CLIENTE(nome, telefone, tipo_cliente, nr_dependentes)
VALUES ('Lucas Martins', NULL, 'Titular', 1)

-- UPDATE válido
UPDATE TB_CLIENTE
SET nr_dependentes = 3
WHERE nome = 'Maria Silva'

-- Tentando violar o CHECK de tipo_cliente via UPDATE -> deve dar erro
UPDATE TB_CLIENTE
SET tipo_cliente = 'VIP'
WHERE nome = 'Carlos Lima'

-- Tentando colocar NULL via UPDATE em campo obrigatório -> deve dar erro
UPDATE TB_CLIENTE
SET telefone = NULL
WHERE nome = 'João Souza'