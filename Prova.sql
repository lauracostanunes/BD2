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

