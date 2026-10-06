(2.2, 'SORVETE NAPOLITANO', 4, 100),
(1.80, 'ARROZ BRANCO', 1, 101),
(10.5, 'CHOCOLATE DE PRESTÍGIO', 3, 102),
(11.5, 'SKOL LATA', 2, 100),
(18.5, 'PATO', 

-- f
alter table produto
add
	estoque int constrant chk_estq check(estoque >=0)


create view vProFaCat
as
select codPro, p.Descricao as NomePro, Preco,
	c.Descricao as NomeCat,
	f.RazaoSocial as NomeFabricante, f.cidade as CidadeFabricante
from produto P inner join Fabricante F ON CodFabr = F.CodFabr
	inner join Categoria AS C ON P.CodCat = c.CodCat

select * from vProFabCat

select * from vProFabCat
where CidadeFabricante = 'SAOPAULO'
order by preco

create view ProdutosRJ
as
	select P.Descricao, F.UF
	from produto P inner join Fabricante F ON CodFabr = F.CodFabr
	where F.UF = 'RJ'

create view CatSPInativas
as
	select distinct c.Descricao
	from produto p inner join Fabricante F ON P.CodFabr = F.CodFabr
			inner join Categoria C ON P.CodCat = C.CodCat
where UF = 'SP' AND Situacao = 'INATIVO'

select * from CatSPInativas

create view EstoqueSP
as
select p.Descricao as Produto, c.Descricao,
	(estoque * Preco) as ValorEstoque
from produto P inner join Fabricante F ON CodFabr = F.CodFabr
		inner join Categoria C ON P.CodCat = c.CodCat
where UF = 'SP'

create table Marca (
	codMarca int constraint pk_marca primary key identity(5000, 1)
	nomeMarca varchar(50) constraint uk_nome unique not null
)

alter table produto ADD codMarca int
	constraint fk_pro_marca foreign key references Marca(codMarca)

insert into marca
values
('OMO')
('YPÊ)
('')

create view vFabrInativo
as
select f.RazaoSocial, m.nomeMarca
from FAbricante f inner join produto p on p.CodFabr = f.CodFabr
inner join Marca m on p.codMarca = m.codMArca
inner join Categoria c on p.CodCat = c.codCat
where c.Situacao = 'Inativo'


