
create table economia(
	estados char(55),
	total int,
	branca int,
	preta int,
	parda int,
	idestado int primary key
);

COPY economia
FROM 'C:\Users\gabri_w8qregu\OneDrive\Desktop\Python\Portifolio\Analise SQL\economia.csv'
DELIMITER ','
CSV HEADER;

create table quantidade_estado(
	total int,
	branca int,
	preta int,
	amerela int,
	parda int,
	indigena int,
	id_estado int
);

alter table quantidade_estado
add constraint fk_economia_quantidade
foreign key(id_estado) references economia(idestado);

COPY quantidade_estado
FROM 'C:\Users\gabri_w8qregu\OneDrive\Desktop\Python\Portifolio\Analise SQL\quantidade_estados.csv'
DELIMITER ','
CSV HEADER;


create table ensino_sup(
	total int,
	branca int,
	preta int,
	amerela int,
	parda int,
	indigena int,
	id_estado int
);

alter table ensino_sup
add constraint fk_ensinosup_economia
foreign key(id_estado) references economia(idestado);

COPY ensino_sup
FROM 'C:\Users\gabri_w8qregu\OneDrive\Desktop\Python\Portifolio\Analise SQL\usando no sql\Ensino superior.csv'
DELIMITER ','
CSV HEADER;




/* Query usada em python */

select 
e.estados,
round((q.branca * 1.00) / q.total * 100,2) as "% População Branca no Estado",
round(((q.preta + q.parda * 1.00) / q.total * 100),2)  as "% População Negra no Estado",
e.total as "Média Salarial",
e.branca as "Média Salarial Branca",
round(
(
(Cast(e.preta as bigint) * q.preta ) + (cast(e.parda as bigint) * q.parda * 1.00))  / (q.parda+q.preta * 1.00) 
,2) as "Média Salarial Negra",
round((e.branca * 1.00)/(((Cast(e.preta as bigint) * q.preta ) + (cast(e.parda as bigint) * q.parda * 1.00))  / 
(q.parda+q.preta * 1.00)),2) - 1 as "Diferença de Salário",
round((es.total * 1.00 / q.total)* 100,2) as "% de Pessoas com ensino superior",
round((es.branca * 1.00/ es.total)* 100,2) as "% da população que possui ensino superior que são brancos",
round((1.00 * (es.preta + es.parda)/es.total) * 100,2) as "% da população com ensino superior que são negros",
round(((q.preta + q.parda * 1.00) / q.branca),2)  as "% Razão Negros x Brancos, População",
round((1.00 * (es.preta + es.parda)/es.branca) ,2) as "Razão Negros X Brancos, Ensino Superior"
from economia e
inner join quantidade_estado q 
on e.idestado = q.id_estado
inner join ensino_sup es
on es.id_estado = e.idestado