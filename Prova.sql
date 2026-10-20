create database prova
go
use prova

create table participante (
      id int constraint pk_part primary key identity (1,1),
      nome varchar (90),
      data_nasc date,
      profissao varchar(50),
      cidade varchar(20),
      uf varchar(2),
      status varchar(30) constraint ck_sta check(status in('ATIVO', 'ELIMINADO'))
)

create table prova (
      id int constraint pk_prov primary key identity(1,1),
      nome varchar(40),
      data date constraint df_dat default(getdate()),
      tipo varchar(50),
      tempo_minutos int constraint ck_temp check(tempo_minutos between(0, 180))
)

create table ingrediente (
      id int constraint pk_ingr primary key identity(1,1)
      nome varchar(80),
      categoria varchar(80)
)

create table prato (
      id int constraint pk_prato primary key identity(1,1),
      nome varchar(80),
      descricao varchar(300),
      dificuldade varchar(80) constraint df_dif default ('Média'),
      id_participante int constraint fk_part foreign key references participante(id),
      id_prova int constraint fk_prov foreign key references prova(id)
)
create table utiliza (
      id int constraint pk_util primary key identity(1,1),
      quantidade int,
      unidade_medida varchar(10),
      id_prato int constraint fk_prat foreign key references prato(id),
      id_ingrediente int constraint fk_ingred foreign key references ingrediente(id),
)

insert into prova (nome, tipo, tempo_minutos) values (
      'Desafio da Massa', 'Eliminação', 90
)

update prova
set tempo_minutos = 120
where tipo = 'eliminação' and tempo_minutos < 90

update participante
set status = 'Eliminado'
where
       uf = 'SP' and
       status = 'Ativo' and
       data_nasc < '1995/01/01'

create view pp
as
select nome, profissao, cidade, uf
from participantewhere status = 'ativo'

create view viewex5
as
select p.nome as nomeParticipante, pr.nome as nomePrato, pr.dificuldade
from participante as p inner join prato as pr
on p.id = pr.id_participante
where dificuldade = 'difícil'


create view viewex6
as
select p.nome as nomePrato, i.nome as nome.Ingred, categoria, quantidade, unidade_medida
from prato as p inner join utiliza as u on  p.id = u.id_prato
                inner join ingrediente as i on i.id = u.id_ingrediente

select pa.nome as nomeParticipante, pr.nome as nomePrato, po.nome as nomeProva
from participante as pa inner join prato as pr on pa.id = pr.id_participante
                                 inner join prova as po on po.id = pr.id_prova
where pa.status = 'Ativo' and PO.tipo = 'Eliminação'

select pa.nome as nomeParticipante, pr.nome as nomePrato, i.nome as nomeIngrediente
from participanteas pa inner join prato as pr on pa.id = pr.id_participante
                       inner join utiliza as u on pr.id = u.id_prato
                       inner join ingrediente as i on i.id = u.id_ingrediente
where i.categoria = 'Laticínios'
order by pa.nome