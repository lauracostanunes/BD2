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