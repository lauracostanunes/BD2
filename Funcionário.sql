create database exerc04
go
use exerc04

create table Func (
         CodFunc int constraint pk_func primary key, 
         PrimeiroNome varchar(50), 
         SegundoNome varchar(50), 
         UltimoNome varchar(50), 
         DataNasci datetime, 
         CPF   varchar(20), 
         RG varchar(20), 
         Endereco varchar(50), 
         CEP varchar(15), 
         Cidade varchar(50), 
         Fone varchar(20), 
         CodDepto int, 
         Funcao varchar(50), 
         Salario money
)

create table Depto (
          CodDepto int constraint pk_deto primary key, 
          Nome varchar(50), 
          Localizacao varchar(50), 
          CodigoFuncionarioGerente int
)

alter table Func
add constraint fk_depto_func foreign key (CodDepto) references Depto(CodDepto)

alter table Depto
add constraint fk_func_gerente foreign key (CodigoFuncionarioGerente) 
      references Func(CodFunc)


INSERT INTO DEPTO 
values
      (1,         'RH',            'SUL',      NULL),
      (2,         'COMPRAS',         'SUL',      NULL),
      (3,         'VENDAS',         NULL,      NULL),
      (4,         'FINANCEIRO',      'NORTE',   NULL),
      (5,         'MARKETING',      'NORTE',   NULL),
      (6,         'DESENVOLVIMENTO',   NULL,      NULL),
      (7,         'CONTABILIDADE',   NULL,      NULL)


INSERT INTO Func (CodFunc, PrimeiroNome, SegundoNome, 
               UltimoNome, DataNasci, Cidade, 
               Funcao, Salario)
values (1, 'JOSE', 'MANOEL', 'DA SILVA', 
            '1980/01/01','FRANCA',
            'CONTADOR', 1200.00)

update func set salario = 1700
where codFunc = 5

-- 7. Liste todos os departamentos com seus respectivos gerentes
select d.Nome as Depto, f.PrimeiroNome as fk_func_gerente
FROM func f INNER JOIN depto d
      ON f.codFunc = d.CodigoFuncionarioGerente

-- 8. Liste o valor da folha de pagamento de cada departamento (nome)
select d.nome as Depto sum(salario) as TotFolhaDepto
FROM func f INNER JOIN depto d on f.CodDepto = d.CodDepto
GROUP BY d.nome

-- 9. Liste os departamentos dos funcionários que têm a função de supervisor
select d.nome as Depto, PrimeiroNome, Funcao
FROM func f INNER JOIN depto d on f.CodDepto = d.CodDepto
WHERE funcao = 'SUPERVISOR'

-- Sub-select
select d.nome
from depto
where CodDepto IN (select CodDepto -- Tem que deixar só um campo, não pode ser *
                  from Func
                  Where Funcao = 'SUPERVISOR')

-- 10. 

-- 11. Liste o salário médio pago pela empresa
SELECT avg(salario) as MediaSalarial
FROM func

-- 12. Liste a quantidade de funcionários que trabalham em cada departamento
select d.nome as Depto, count(*) as QtdeFuncionarios
FROM func f inner join depto d
      on f.CodDepto = d.CodDepto
GROUP BY d.nome

-- 13. Liste o menor salário pago pela empresa em cada departamento
SELECT d.nome as Depto, min(salario) as MenorSalDepto
FROM func f inner join depto d on f.CodDepto = d.CodDepto
GROUP BY d.nome

-- 14. a) Liste o nome completo de todos os funcionários que não tenham segundo nome
select PrimeiroNome, UltimoNome
from func
where isnull(SegundoNome, '') ='' -- isnull junto é uma função

-- 14. b) Liste os nomes dos funcionários e os nomes de seus gerentes
select F.PrimeiroNome as nomeFunc, G.PrimeiroNome as nomeGerente
from func as F inner join func as G
      on F.CodFunc = G.CodigoFuncionarioGerente
      -- Aqui o professor confundiu a estrutura da tabela

-- 14. b) Corrigida
select F.PrimeiroNome as nomeFunc, G.PrimeiroNome as nomeGerente
from func as F inner join Depto as D
      on F.CodDepto = D.CodDepto
            INNER JOIN func as G
      ON F.CodFunc = G.CodDepto

-- 15. Liste os departamentos que possuem mais de três funcionários
-- 16. Liste o nome do departamento e do funcionário ordenados por departamento e funcionário
-- 17. Liste os nomes dos funcionários que moram em Recife e que exerçam a função telefonista
-- 18. Liste a localização do departamento e os nomes dos funcionários que trabalham no departamento pessoal