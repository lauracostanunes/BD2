CREATE DATABASE ClinicaVet

USE ClinicaVet

CREATE TABLE Veterinario(
    codMed INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(80),
    dataNasc DATE
)

CREATE TABLE Animal(
    codPac INT PRIMARY KEY IDENTITY(1,1),
    nomeAnimal VARCHAR(50),
    especie VARCHAR(30)
)

CREATE TABLE Consulta(
    codCons INT PRIMARY KEY IDENTITY(1,1),
    dataCons DATE,
    valor MONEY,
    codPac INT FOREIGN KEY REFERENCES Animal(codPac) NOT NULL,
    codMed INT FOREIGN KEY REFERENCES Veterinário(codMed) NOT NULL
)


-- 1. CADASTRAR 5 MÉDICOS (VETERINÁRIOS)
INSERT INTO Veterinario (nome, dataNasc) VALUES 
    ('DRA. GISELE', '1985-03-15'),
    ('DR. FELIPE', '1990-07-22'),
    ('DRA. CAMILA', '1988-11-05'),
    ('DR. RICARDO', '1982-09-30'),
    ('DRA. BEATRIZ', '1995-01-18')

-- 2. CADASTRAR 10 PACIENTES DE PELO MENOS 3 ESPÉCIES
INSERT INTO Animal (nomeAnimal, especie) VALUES
    ('TOTO', 'CACHORRO'),
    ('MIMI', 'GATO'),
    ('BOLINHA', 'CACHORRO'),
    ('PIPOCA', 'CALOPSITA'),
    ('NINA', 'GATO'),
    ('MAX', 'CACHORRO'),
    ('LOLA', 'COELHO'),
    ('FRED', 'PAPAGAIO'),
    ('LUNA', 'CACHORRO'),
    ('BISCOITO', 'COELHO')

-- 3. CADASTRAR 20 CONSULTAS COM DATAS E VALORES DIFERENTES
INSERT INTO Consulta (dataCons, valor, codPac, codMed) VALUES
    ('2026-01-05', 150.00, 1, 1),
    ('2026-01-12', 180.00, 2, 2),
    ('2026-01-20', 120.00, 3, 3),
    ('2026-01-28', 200.00, 4, 4),
    ('2026-02-03', 160.00, 5, 5),
    ('2026-02-10', 140.00, 6, 1),
    ('2026-02-18', 220.00, 7, 2),
    ('2026-02-25', 130.00, 8, 3),
    ('2026-03-05', 190.00, 9, 4),
    ('2026-03-12', 170.00, 10, 5),
    ('2026-03-20', 210.00, 1, 1),
    ('2026-03-28', 110.00, 2, 2),
    ('2026-04-05', 230.00, 3, 3),
    ('2026-04-12', 155.00, 4, 4),
    ('2026-04-20', 175.00, 5, 5),
    ('2026-05-05', 200.00, 6, 1),
    ('2026-05-15', 185.00, 7, 2),
    ('2026-05-25', 125.00, 8, 3),
    ('2026-06-05', 240.00, 9, 4),
    ('2026-06-15', 195.00, 10, 5)

-- 4. MAIOR VALOR PAGO POR UMA CONSULTA
SELECT MAX(valor) AS maiorValor FROM Consulta

-- 5. VALOR MÉDIO, MAIOR E MENOR DAS CONSULTAS DO MÊS PASSADO
SELECT 
    AVG(valor) AS valorMedio,
    MAX(valor) AS maiorValor,
    MIN(valor) AS menorValor
FROM Consulta
WHERE dataCons BETWEEN '2026-07-01' AND '2026-07-31'

-- 6. CADASTRAR NOVA CONSULTA PARA PACIENTE JÁ CADASTRADO
INSERT INTO Consulta (dataCons, valor, codPac, codMed) VALUES
    ('2026-08-15', 250.00, 3, 1)

-- 7. ATUALIZAR NOME DO MÉDICO CÓDIGO 3
UPDATE Veterinario SET nome = 'DRA. LAURA'
WHERE codMed = 3

-- 8. ESPÉCIES DE PACIENTES CADASTRADOS
SELECT especie FROM Animal

-- 9. CONSULTAS REALIZADAS POR VOCÊ
SELECT COUNT() AS consultasRealizadas FROM 
    Veterinario AS V INNER JOIN Consulta AS C
    ON V.codMed = C.codMed
        WHERE V.nome = 'LAURA'

-- 10. QUANTAS CONSULTAS FORAM REALIZADAS (TOTAL)
SELECT COUNT() AS totalConsultas FROM Consulta

-- 11. ESPÉCIES DE PACIENTES (SEM REPETIÇÃO)
SELECT DISTINCT (espécie) FROM Animal

-- 12. NOMES DOS PACIENTES EM ORDEM ALFABÉTICA
SELECT nomeAnimal FROM Animal
ORDER BY nomeAnimal ASC

-- 13. VALOR TOTAL DAS CONSULTAS FEITAS POR VOCÊ
SELECT SUM(valor) AS totalConsultasLaura
FROM Consulta C
INNER JOIN Veterinario V ON C.codMed = V.codMed
WHERE V.nome = 'DRA. LAURA'

-- 14. QUANTIDADE DE MÉDICOS DA CLÍNICA
SELECT COUNT() AS qntMedicos FROM Veterinario

-- 15. TOTAL DAS CONSULTAS DA LAURA COM AUMENTO DE 10%
SELECT SUM(valor  1.10) AS totalComAumento
FROM Consulta C
INNER JOIN Veterinario V ON C.codMed = V.codMed
WHERE V.nome = 'DRA. LAURA'

-- 16. CONSULTAS DA LAURA ENTRE 01012026 E 31032026
SELECT COUNT() AS consultasTrimestre
FROM Consulta C
INNER JOIN Veterinario V ON C.codMed = V.codMed
WHERE V.nome = 'DRA. LAURA' 
AND C.dataCons BETWEEN '2026-01-01' AND '2026-03-31'