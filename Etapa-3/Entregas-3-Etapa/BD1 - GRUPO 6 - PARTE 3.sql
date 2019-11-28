/*Grupo 06
- Thalyta Barbosa do Nascimento
- Lucas Matheus Ferreira Barreto
- Almir Gonçalves Crispiniano
- Wesley Roseno Saraiva
- Walisson Farias Nascimento
*/

-- Remove as estruturas criadas no arquivo
DROP TRIGGER dezoito;
DROP TRIGGER dezessete;
DROP TRIGGER dezesseis;
ALTER TABLE TELEFONE_FUNCIONARIO DROP CONSTRAINT quinze;
DROP VIEW quatorze;
DROP VIEW treze;
DROP VIEW doze;
DROP VIEW funcionarios;

/*
1. Qual o número de compras feitas entre 01/01/2018 e 31/12/2019 ?
*/
SELECT COUNT(*) AS total
FROM ORDEM_COMPRA
WHERE data_hora
BETWEEN TO_DATE('01/01/2018','DD/MM/YYYY') AND TO_DATE('31/12/2019','DD/MM/YYYY');
/*
2. Qual é o nome da marca do produto com maior quantidade em estoque?
*/
SELECT nome
FROM MARCA
WHERE identificador =
    (SELECT id_marca
    FROM PRODUTO
    WHERE quantidade =
        (SELECT MAX(quantidade)
        FROM PRODUTO));
/*
3. Crie uma view que lista todos os dados dos funcionários que recebem menos que a média dos
salários dos funcionários.
*/
CREATE VIEW funcionarios AS
    SELECT *
    FROM FUNCIONARIO
    WHERE salario <
        (SELECT AVG(f.salario)
        FROM FUNCIONARIO f);
/*
4. Liste o código de identificação e nome de todos os produtos agrupados pela sua categoria e
ordenados pelo seu preço de compra.
*/
SELECT codigo_identificacao, nome
FROM PRODUTO
GROUP BY id_categoria, preco_compra, codigo_identificacao, nome
ORDER BY id_categoria, preco_compra;
/*
5. Liste o CPF e nome de todos os clientes que residem na cidade ‘Campina Grande’ e compraram
na filial de nome ‘Campina’.
*/
SELECT c.cpf, c.nome
FROM CLIENTE c, ORDEM_COMPRA o, FILIAL f
WHERE c.cpf = o.cpf_cliente AND o.codigo_filial = f.codigo_identificacao AND f.nome = 'Campina';
/*
6.  Liste o CPF, nome e pontos CRM dos clientes por ordem decrescente do valor total comprado.
*/
SELECT cpf, nome, pontos_crm
FROM(
    SELECT c.cpf, c.nome, c.pontos_crm, i.quantidade * (i.preco_produto - i.desconto) AS preco
    FROM CLIENTE c, ORDEM_COMPRA o, ITEM i
    WHERE c.cpf = o.cpf_cliente AND o.numero_nota_fiscal = i.num_nota_fiscal_ordem)
GROUP BY cpf, nome, pontos_crm
ORDER BY sum(preco) DESC;
/*
7. Liste todos os dados das solicitações agrupadas por filial e ordenadas de forma crescente
pelo prazo para pagamento em dias.
*/
SELECT identificador, data_solicitacao,data_prevista, data_entrega, valor_compra, prazo_pagamento, codigo_filial, cnpj_fornecedor
FROM(
    SELECT (prazo_pagamento - data_solicitacao) AS prazo, identificador, data_solicitacao,data_prevista, data_entrega, valor_compra, prazo_pagamento, codigo_filial, cnpj_fornecedor
    FROM SOLICITACAO)
GROUP BY identificador, data_solicitacao,data_prevista, data_entrega, valor_compra, prazo_pagamento, codigo_filial, cnpj_fornecedor, codigo_filial, prazo
ORDER BY codigo_filial, prazo;
/*
8. Liste a matrícula, nome e CPF dos funcionários que possuem mais do que 3 dependentes.
Ordene-os pelo valor do salário, em ordem decrescente.
*/
SELECT f.nome, f.cpf
FROM FUNCIONARIO f, DEPENDENTE d
WHERE f.matricula = d.matricula_funcionario
GROUP BY f.nome, f.cpf, f.salario
HAVING COUNT(*) > 3
ORDER BY f.salario DESC;
/*
9. Quais os funcionários que possuem telefones que começam com ‘(83) 33’ e têm mais de 2
dependentes? Liste matrícula, CPF, nome e salário.
*/
SELECT f.matricula, f.cpf, f.nome, f.salario
FROM FUNCIONARIO f, DEPENDENTE d, TELEFONE_FUNCIONARIO t
WHERE f.matricula = t.matricula AND f.matricula = d.matricula_funcionario AND t.telefone LIKE '(83) 33%'
GROUP BY f.matricula, f.cpf, f.nome, f.salario
HAVING COUNT(*) > 2;
/*
10. Liste o CPF e nome de todos clientes que realizaram compras entre 01/01/2019 e 30/06/2019
nas filiais ‘Campina’ ou ‘Jampa’.
*/
SELECT c.cpf, c.nome
FROM CLIENTE c, ORDEM_COMPRA o, FILIAL f
WHERE c.cpf = o.cpf_cliente AND o.codigo_filial = f.codigo_identificacao AND (f.nome = 'Campina' OR f.nome = 'Jampa') AND data_hora BETWEEN TO_DATE('01/01/2019','DD/MM/YYYY') AND TO_DATE('30/06/2019','DD/MM/YYYY');
/*
11. Liste a matrícula e nome de todos os supervisores com salário inferior a R$2.000,00.
*/
SELECT s.matricula, s.nome
FROM FUNCIONARIO s, FUNCIONARIO f
WHERE s.matricula = f.matricula_supervisor AND s.salario < 2000;
/*
12. Crie uma View que lista todos os dados dos produtos agrupados por sua categoria e
ordenados de forma decrescente pela margem de lucro mínima.
*/
CREATE VIEW doze AS
    SELECT *
    FROM PRODUTO
    ORDER BY id_categoria ASC, margem_lucro DESC;
/*
13. Crie uma view que liste o CPF, nome e telefones de todos os clientes que já compraram
algum produto da categoria ‘limpeza’ ou da marca ‘Yard’.
*/
CREATE VIEW treze AS
    WITH clientes (cpf, nome, telefone) AS
        (SELECT cpf, nome, telefone
        FROM CLIENTE LEFT OUTER JOIN TELEFONE_CLIENTE ON CLIENTE.cpf = TELEFONE_CLIENTE.cpf_cliente)
    SELECT c.cpf, c.nome, c.telefone
    FROM clientes c, ORDEM_COMPRA o, ITEM i, PRODUTO p, CATEGORIA a, MARCA m
    WHERE c.cpf = o.cpf_cliente
        AND o.numero_nota_fiscal = i.num_nota_fiscal_ordem
            AND i.codigo_produto = p.codigo_identificacao 
            AND ((p.id_categoria = a.identificador AND a.nome = 'limpeza') OR (p.id_marca = m.identificador AND m.nome = 'Yard'));
/*
14. Crie uma view que liste todos os dados de funcionários que possuem algum dependente com a
palavra ‘Maria’ no nome.
*/
CREATE VIEW quatorze AS
    SELECT DISTINCT f.*
    FROM FUNCIONARIO f, DEPENDENTE d
    WHERE f.matricula = d.matricula_funcionario AND LOWER(d.nome) LIKE '%maria%';
/*
15. Modifique a tabela TELEFONE_FUNCIONARIO, adicionando uma restrição de integridade que
valide se a coluna TELEFONE está no formato “(XX) XXXXX-XXXX”, onde X é qualquer dígito de
0 à 9.
*/
ALTER TABLE TELEFONE_FUNCIONARIO ADD CONSTRAINT quinze
CHECK (REGEXP_LIKE ( telefone, '^\(\d{2}\) \d{5}-\d{4}$' ));
/*
16. Crie um trigger que exclua a categoria correspondente a um fornecedor quando este for
excluído.
*/
CREATE OR REPLACE TRIGGER dezesseis
AFTER DELETE ON FORNECEDOR
for each row
BEGIN
    DELETE FROM CATEGORIA
    WHERE CATEGORIA.identificador = :old.id_categoria;
END;
/*
17. Crie um trigger que não permita a inserção de mais de um produto com o mesmo nome.
*/
CREATE OR REPLACE TRIGGER dezessete
BEFORE INSERT ON PRODUTO
for each row
ENABLE
DECLARE
total number;
    BEGIN
    SELECT COUNT(*) INTO (total) FROM PRODUTO WHERE nome = :NEW.nome;
    IF (total > 0) THEN
    raise_application_error(-20502,'Já existe um produto com o mesmo nome');
    END IF;
END dezessete;
/*
18. Crie um trigger que não permita que o funcionário mantenha mais que 3 dependentes.
*/
CREATE OR REPLACE TRIGGER dezoito
BEFORE INSERT ON DEPENDENTE
for each row
ENABLE
DECLARE
total number;
    BEGIN
    SELECT COUNT(*) INTO (total) FROM DEPENDENTE WHERE DEPENDENTE.matricula_funcionario = :NEW.matricula_funcionario;
    IF (total > 2) THEN
    raise_application_error(-20502,'Já possui 3 dependentes');
    END IF;
END dezoito;
/*
19. Crie uma função chamada calculaValorCompraByClienteNoPeriodo que deve receber o CPF de um
cliente e um intervalo de datas (inicial e final) como parâmetros e deve retornar o valor
total gasto em compras por aquele cliente naquele determinado período. Coloque no script
também o código de como executar a função.
*/
CREATE OR REPLACE FUNCTION calculaValorCompraByClienteNoPeriodo(cpfcliente VARCHAR2,inicio IN DATE,fim IN DATE)
RETURN NUMBER
AS
resultFunction NUMBER;
CURSOR cursorCompra IS SELECT o.data_hora, i.preco_produto, i.desconto, i.quantidade FROM ORDEM_COMPRA o, ITEM i WHERE o.cpf_cliente = cpfcliente AND o.numero_nota_fiscal = i.num_nota_fiscal_ordem AND data_hora BETWEEN inicio AND fim;
begin
resultFunction := 0;
FOR cp IN cursorCompra LOOP
resultFunction := resultFunction + (cp.quantidade*(cp.preco_produto - cp.desconto));
END LOOP;
RETURN resultFunction;
END;

SELECT calculaValorCompraByClienteNoPeriodo('10000000001','01/01/2018','31/12/2019') total FROM DUAL;

/*
20. Crie uma stored procedure chamada getFornecedorByCategoria que deve receber como parâmetro
identificador de uma categoria e retornar o fornecedor daquela categoria que mais teve
solicitações realizadas. Coloque no script também o código de como executar a procedure.
*/
