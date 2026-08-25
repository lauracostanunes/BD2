CREATE DATABASE escola
GO
USE escola

CREATE TABLE Professores (
    codProf int CONSTRAINT pk_codProf PRIMARY key identity(1,1),
    nome VARCHAR(80) NOT NULL,
    RG numeric(12) UNIQUE,
    sexo char(1) check(sexo in('M','F')),
    idade int check(idade between 21 and 80),
    cidade varchar(50) CONSTRAINT DF_Prod_cidade DEFAULT('FRANCA'),
    titulacao varchar(15)CONSTRAINT chk_tit check(titulacao IN('graduado', 'especialista', 'mestre', 'doutor')),
    categoria varchar(15) check(categoria in ('auxiliar', 'assistente', 'adjunto', 'titular')),
    salario money check(salario >= 500)
)

INSERT INTO Professores(nome, RG, sexo, idade, cidade, titulacao, categoria, salario)
VALUES ('Adalto',123456789101, 'M', 47, '', 'mestre', 'assistente', 2000)
