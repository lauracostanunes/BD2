-- Criar novo BD
CREATE DATABASE hotel
USE hotel

-- Criar tabelas
CREATE TABLE Quarto(
    codQuarto INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(30),
    numero INT,
    andar INT
)

CREATE TABLE Hospede(
    codHospede INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(80),
    idade INT,
    sexo CHAR(1)
);

CREATE TABLE Reserva(
    codReserva INT PRIMARY KEY IDENTITY(1,1),
    dtEntrada DATE,
    dtSaida DATE,
    codHospede INT FOREIGN KEY REFERENCES Hospede(codHospede) NOT NULL,
    codQuarto INT FOREIGN KEY REFERENCES Quarto(codQuarto) NOT NULL
);

CREATE TABLE Pagamento(
    codPagto INT PRIMARY KEY IDENTITY(1,1),
    valor MONEY,
    dtPagto DATE,
    codReserva INT FOREIGN KEY REFERENCES Reserva(codReserva) NOT NULL
);

CREATE TABLE Refeicao(
    codConsumo INT PRIMARY KEY IDENTITY(1,1),
    descRefeicao VARCHAR(30),
    valor MONEY,
    codReserva INT FOREIGN KEY REFERENCES Reserva(codReserva) NOT NULL
);

-- Questão 2: Cadastrar dados
-- Cadastrar 5 quartos
INSERT INTO Quarto VALUES
    ('Superior Master',1050, 10),
    ('Superior Master', 1051, 10),
    ('Superior Master', 1154, 11),
    ('Standard', 854, 8),
    ('Standard', 855, 8);

-- Cadastrar 8 hóspedes
INSERT INTO Hospede VALUES
    ('LAURA', 20, 'F'),
    ('LEONARDO', 19, 'M'),
    ('LÍVIA', 22, 'F'),
    ('LORENZA', 26, 'F'),
    ('LUCAS', 18, 'M'),
    ('LUCCA', 19, 'M'),
    ('LARISSA', 27, 'F'),
    ('LEANDRO', 20, 'M')

-- Cadastrar 4 reservas
INSERT INTO Reserva VALUES
    ('2026-09-03', '2026-09-08', 1, 2),
    ('2026-09-27', '2026-09-39', 3, 3),
    ('2026-10-17', '2026-10-22', 2, 5),
    ('2026-11-22', '2026-11-27', 3, 4);

-- Cadastrar 6 refeições
INSERT INTO Refeicao VALUES
    ('CHURROS', 15.0, 1),
    ('PICOLÉ', 10.0, 2),
    ('VINHO', 80.0, 3),
    ('LIMONADA SUÍÇA', 18.0, 4),
    ('BATATA FRITA', 50.0, 2),
    ('CAIPIRINHA', 30.0, 3);

-- Questão 3: Quantidade de quartos do tipo 'Superior Master'
SELECT COUNT(*) AS qtdSuperiorMaster
FROM Quarto
WHERE tipo = 'Superior Master';

-- Questão 4: Valor médio pago por uma refeição
SELECT ROUND(AVG(valor), 2) AS valorMedioRefeicao
FROM Refeicao;

-- Questão 5: Excluir campo Idade e criar campo DataNascimento
ALTER TABLE Hospede DROP COLUMN idade
ALTER TABLE Hospede ADD dataNascimento DATE;

-- Questão 6: Quantos hóspedes fizeram reserva
SELECT COUNT(DISTINCT(H.codHospede)) AS hospedesComReserva FROM
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede;

-- Questão 7: Nomes dos hóspedes e datas de entrada das reservas
SELECT H.nome AS nomeHospede, R.dtEntrada AS dataEntrada, R.dtSaida AS dataSaida
FROM Hospede AS H INNER JOIN Reserva AS R
ON H.codHospede = R.codHospede

-- Questão 8: Atualizar datas de nascimento
UPDATE Hospede SET dataNascimento = '1989-05-15' WHERE codHospede = 1;
UPDATE Hospede SET dataNascimento = '1996-08-22' WHERE codHospede = 2;
UPDATE Hospede SET dataNascimento = '1982-11-30' WHERE codHospede = 3;
UPDATE Hospede SET dataNascimento = '1993-04-10' WHERE codHospede = 4;
UPDATE Hospede SET dataNascimento = '1969-07-25' WHERE codHospede = 5;
UPDATE Hospede SET dataNascimento = '1998-12-01' WHERE codHospede = 6;
UPDATE Hospede SET dataNascimento = '1976-09-18' WHERE codHospede = 7;
UPDATE Hospede SET dataNascimento = '1991-03-07' WHERE codHospede = 8;

-- Questão 9: Hóspedes com entradas antes de 01/01/2025 (ordem alfabética)
SELECT h.nome, r.dataEntrada
FROM Hospede h
JOIN Reserva r ON h.codHospede = r.codHospede
WHERE r.dataEntrada < '2025-01-01'
ORDER BY h.nome ASC;

-- Questão 10: Nomes das mulheres que se hospedaram no 4º andar
SELECT DISTINCT(H.nome) AS hospedes FROM 
    Hospede AS H INNER JOIN Reserva AS R
    ON H.codHospede = R.codHospede
    INNER JOIN Quarto AS Q
    ON R.codQuarto = Q.codQuarto
    WHERE H.sexo = 'F' AND Q.andar = 4;

-- Questão 11: Quartos sem reservas
SELECT q.numQuarto, q.tipo
FROM Quarto q
LEFT JOIN Reserva r ON q.numQuarto = r.numQuarto
WHERE r.numQuarto IS NULL;

-- Questão 12: Quanto 'João da Silva' pagou por suas hospedagens
SELECT h.nome, SUM(r.valorTotal) AS totalPago
FROM Hospede h
JOIN Reserva r ON h.codHospede = r.codHospede
WHERE h.nome = 'João da Silva'
GROUP BY h.nome;

-- Questão 13: Hóspedes hospedados mais de 5 dias em fevereiro/2026
SELECT COUNT(DISTINCT r.codHospede) AS qtdHospedes
FROM Reserva r
WHERE r.dataEntrada BETWEEN '2026-02-01' AND '2026-02-28'
AND DATEDIFF(DAY, r.dataEntrada, r.dataSaida) > 5;