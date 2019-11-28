-- Consultas Etapa 3
/*Grupo 9:Arthur Fernandes
        Angela Sousa
        Débora Ferreira
        Gilmar Gonzaga
        Luana Barbosa
*/

-- Consulta 1 

SELECT *
FROM CLIENTE 
WHERE cpf in (SELECT cpf
              FROM REALIZA_RECLAMACAO r, CLIENTE c, FILIAL f
              WHERE r.cpf_cliente = c.cpf AND 
              f.codigo_identificacao = r.codigo_filial AND
              f.nome = 'Campina'
              GROUP BY cpf_cliente
              HAVING COUNT(*) > 1) 
;
-- Consulta 2

SELECT MAX(i.quantidade)
FROM ITEM i
WHERE i.desconto BETWEEN 0.05 AND 0.10
;

-- Consulta 3

CREATE VIEW ListaCompras AS
SELECT c.nome AS nomeCliente, c.cpf, f.nome
FROM CLIENTE c, FILIAL f, ORDEM_COMPRA o
WHERE c.cpf = o.cpf_cliente AND f.codigo_identificacao = o.codigo_filial
;

-- Consulta 4

SELECT DISTINCT f.*
FROM FUNCIONARIO f, FUNCIONARIO s
WHERE f.matricula = s.matricula_supervisor
    ORDER BY f.salario DESC;
;

-- Consulta 5

SELECT p.codigo_identificacao, p.nome
FROM PRODUTO p
WHERE (preco_venda * quantidade) < 100
;

-- Consulta 6

SELECT p.codigo_identificacao, p.nome
FROM PRODUTO p, CATEGORIA c, MARCA m
WHERE p.margem_lucro in (SELECT  MAX(p.margem_lucro)
                    FROM PRODUTO p, CATEGORIA c
                    WHERE p.id_categoria = c.identificador)
AND c.nome = 'Jardim'
AND p.id_categoria = c.identificador
AND p.id_marca = m.identificador 
AND m.nome = 'SempreVerde'
;

-- Consulta 7

SELECT f.nome AS nome_funcionario, d.nome AS nome_dependentes
FROM DEPENDENTE d, FUNCIONARIO f
WHERE d.matricula_funcionario = f.matricula AND
d.matricula_funcionario = (SELECT matricula_funcionario
                           FROM(SELECT d.matricula_funcionario, COUNT(d.matricula_funcionario) AS quantidade_dependentes
                                FROM FUNCIONARIO f, DEPENDENTE d
                                WHERE  f.matricula = d.matricula_funcionario
                                GROUP BY d.matricula_funcionario)
                           WHERE quantidade_dependentes = (SELECT MAX(quantidade_dependentes)
                                                           FROM(SELECT d.matricula_funcionario, COUNT(d.matricula_funcionario) AS quantidade_dependentes
                                                                FROM FUNCIONARIO f, DEPENDENTE d
                                                                WHERE  f.matricula = d.matricula_funcionario
                                                                GROUP BY d.matricula_funcionario)))
 
;

-- Consulta 8

CREATE VIEW ListaFiliais AS
SELECT f.nome AS nomeF, i.nome
FROM FUNCIONARIO f, FILIAL i
WHERE f.matricula = i.gerente
;

-- Consulta 9

SELECT DISTINCT c.numero_caixa
FROM CAIXA c, REALIZA_MANUTENCAO r, EQUIPAMENTO e
WHERE c.numero_caixa = e.numero_caixa AND
e.identificador = r.identificador_equipamento
GROUP BY c.numero_caixa, r.identificador_equipamento
HAVING COUNT(*) <= 1
;    

-- Consulta 10

SELECT *
FROM (SELECT o.*
    FROM CLIENTE c, ORDEM_COMPRA o
    WHERE c.cpf = o.cpf_cliente
    ORDER BY o.data_hora)
WHERE ROWNUM <= 5
;

-- Consulta 11

SELECT r.*
FROM REALIZA_MANUTENCAO r, FUNCIONARIO f
WHERE ((r.matricula_funcionario = f.matricula) AND (f.nome LIKE '%Pereira%' AND f.funcao = 'padeiro'))
;

-- Consulta 12

SELECT f.nome AS supervisor, d.nome AS nome_dependentes_mais_de_18
FROM FUNCIONARIO f, FUNCIONARIO s, DEPENDENTE d
WHERE f.matricula = s.matricula_supervisor AND 
d.matricula_funcionario = f.matricula AND 
d.cpf in (SELECT cpf
          FROM DEPENDENTE d 
          WHERE trunc(to_char(sysdate - d.data_nasc)/365) >= 18)      
;

--Consulta 13
    
CREATE VIEW lista AS (
    SELECT p.*
    FROM PRODUTO p, CATEGORIA c
    WHERE p.id_categoria = c.identificador AND c.nome= 'Limpeza' AND
    p.quantidade*p.preco_compra > 200)
;

-- Consulta 14
     
CREATE VIEW list_CNPJ AS
SELECT f.cnpj
FROM FORNECEDOR f, SOLICITACAO s
WHERE ((s.data_solicitacao BETWEEN '01/01/2019' AND '31/12/2019') AND (f.cnpj = s.cnpj_fornecedor)) 
        AND (s.valor_compra >= (SELECT MAX(s.valor_compra) AS maiorVenda
                                FROM FORNECEDOR f, SOLICITACAO s
                                WHERE f.cnpj = s.cnpj_fornecedor))  
;  

-- Consulta 15
     
ALTER TABLE FORNECEDOR
ADD CONSTRAINT cnpj_fo
CHECK(REGEXP_LIKE(cnpj,'^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$'))
;

-- Consulta 16
     
CREATE TRIGGER TRI_DataPrevistaMenor_DataSolitacao
BEFORE INSERT OR UPDATE OF data_solicitacao, data_prevista ON SOLICITACAO
FOR EACH ROW
WHEN  (NEW.data_prevista < NEW.data_solicitacao)
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Data de entrega prevista não permitida');
END;
;

     
-- Consulta 17

CREATE TRIGGER TRI_SalarioFuncionario_SalarioGerente
BEFORE INSERT OR UPDATE OF salario ON FUNCIONARIO
FOR EACH ROW
WHEN  (((NEW.salario>OLD.salario) AND (NEW.funcao != 'gerente')) OR ((NEW.salario<OLD.salario) AND (NEW.funcao = 'gerente')))
BEGIN
        RAISE_APPLICATION_ERROR(-20003, 'Valor salarial não permitido');
END;
;

-- Consulta 18
     
CREATE TRIGGER TRI_DataCompra_DataValidade
BEFORE INSERT OR UPDATE OF data_compra, data_validade ON PRODUTO
FOR EACH ROW
WHEN  ((NEW.data_compra > NEW.data_validade))
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Data de compra não permitida');
END;
;

-- Consulta 19

CREATE OR REPLACE PROCEDURE calculaComprasNoPeriodo
    (primeira_data_hora IN ORDEM_COMPRA.data_hora%TYPE, 
    segunda_data_hora IN ORDEM_COMPRA.data_hora%TYPE, 
    total_compras OUT NUMBER)
AS
BEGIN
    total_compras:= TO_CHAR(
    SELECT SUM(i.preco_produto * i.quantidade)
    FROM ITEM i, ORDEM_COMPRA o
    WHERE ((i.num_nota_fiscal_ordem = o.numero_nota_fiscal) AND (o.data_hora BETWEEN o.primeira_data_hora AND o.segunda_data_hora)));
    
    DBMS_OUTPUT.PUT_LINE('O valor total de compras é'||TO_CHAR(total_compras));
    
COMMIT;
END;
;

-- Consulta 20
     
CREATE OR REPLACE PROCEDURE alteraPrecoDeVenda
    (p_codigo_identificacao IN PRODUTO.codigo_identificacao%TYPE, 
     novo_preco_compra IN PRODUTO.preco_compra%TYPE) 
AS
BEGIN
     UPDATE PRODUTO
     SET preco_compra = novo_preco_compra
     WHERE codigo_identificacao = p_codigo_identificacao;
     COMMIT;
END;
;