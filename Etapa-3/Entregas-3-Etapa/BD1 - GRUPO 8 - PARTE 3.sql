-- Lucas Jarrier de Aquino Cavalcanti
-- Enzo Raian Texeira Candido
-- Bruno Henrique Assis de Sousa
-- Matheus Eduardo Rodrigues da Silva
-- Kamila Da Silva Albuquerque

-- 1 
Select * From CLIENTE
Where cpf in (Select cpf
             from ORDEM_COMPRA o, CLIENTE c 
             where o.cpf_cliente = c.cpf and o.data_hora >= '1546311600')
   
-- 2           
Select * From ORDEM_COMPRA
where numero_nota_fiscal in (select max(i.desconto) from
                            ORDEM_COMPRA o, ITEM i
                            where o.numero_nota_fiscal = i.numero_nota_fiscal)

-- 3 
CREATE VIEW nome_codigo_equipamento AS
    SELECT nome, codigo_filial, COUNT(codigo_filial) AS equipamento
    FROM CAIXA, FILIAL 
    WHERE codigo_filial = codigo_identificacao 
    GROUP BY codigo_filial, nome;

-- 4              
select f.nome, d.nome
from FUNCIONARIO f, DEPENDENTE d, FILIAL x
where x.gerente = f.matricula and f.matricula = d.matricula_funcionario                

-- 5
select count(i.quantidade)
from ITEM i, FILIAL f, PRODUTO p
where f.nome = 'Campina' and i.identificador in (select p.codigo_identificacao from PRODUTO p where p.margem_lucro in(select max(p.margem_lucro) from PRODUTO p))

-- 6
Select c.cpf, c.nome 
from CLIENTE c, FILIAL f
where f.nome = 'Salvador' and c.pontos_crm in (select max(c.pontos_crm) from CLIENTE c)

-- 7 
CREATE VIEW  aux as
    SELECT p.id_marca as id, m.nome, COUNT(p.id_marca) AS qtd
    	    FROM PRODUTO p, MARCA m 
            WHERE p.id_marca = m.identificador 
            GROUP BY p.id_marca, m.nome

CREATE VIEW marca_com_mais_produtos AS
	SELECT a.nome as marca, p.nome as produto
	FROM aux a, produto p
	WHERE a.qtd in (SELECT MAX(qtd) FROM aux) AND p.id_marca = a.id
;

-- 8
Select count(*) from FUNCIONARIO f, FILIAL x
where (x.nome = 'Campina' or x.nome = 'Jampa') and f.funcao = 'segurança'

-- 10
SELECT o.numero_nota_fiscal
FROM ORDEM_COMPRA o, FUNCIONARIO f
WHERE lower(f.nome) LIKE '%lucas%' and o.matricula_funcionario = f.matricula

-- 11
Select SUM(r.custo) 
from REALIZA_MANUTENCAO r
where r.data_hora >= '1546311600'

-- 12
Select f.matricula, f.cpf, f.nome 
from FUNCIONARIO f, FILIAL x
where x.nome = 'Jampa' and f.salario > 2000

-- 13
create or replace view bebidas as
	select p.nome as produto, m.nome as marca
	from produto p, marca m, categoria c
	where p.id_marca = m.identificador and p.id_categoria = c.identificador and c.nome = 'Bebidas'

-- 14
create or replace view funcionarios_dependentes as
	select f.nome as funcionario, d.nome as dependente
	from funcionario f, dependente d
	where f.matricula = d.matricula_funcionario
		and EXTRACT(YEAR from d.data_nasc) >= 2001

-- 15
ALTER TABLE CLIENTE
ADD CONSTRAINT cpf_cliente
CHECK(REGEXP_LIKE(cpf,'^\d{3}\.\d{3}\.\d{3}\-\d{2}$'))
		
-- 18
CREATE OR REPLACE TRIGGER funcao_caixa
	BEFORE INSERT ON ORDEM_COMPRA
	FOR EACH ROW
	DECLARE
		funcao_alvo VARCHAR2(50);
	BEGIN
		SELECT f.funcao INTO funcao_alvo
		FROM funcionario f
		WHERE :new.matricula_funcionario = f.matricula;
	IF (funcao_alvo != 'CAIXA') THEN
		RAISE_APPLICATION_ERROR(-20001,'Funcionario tem que ser caixa');
	END IF;
END;

-- 17
CREATE OR REPLACE TRIGGER item_menor_zero
    BEFORE INSERT ON ITEM
    FOR EACH ROW
    BEGIN
    IF (:new.quantidade <= 0) THEN
        RAISE_APPLICATION_ERROR(-20001,'Quantidade deve ser maior que zero');
    END IF;
END;
