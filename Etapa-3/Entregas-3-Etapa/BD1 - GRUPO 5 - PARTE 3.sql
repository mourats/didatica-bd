-- BANCO DE DADOS - GRUPO 5 
-- Grupo:
-- - Gaspar Soares
-- - Larissa Amorim
-- - Thiago Yuri
-- - Sérgio Duarte


-- ITEM 1
SELECT p.codigo_filial, COUNT(*) as total_produtos 
FROM produto p 
GROUP BY p.codigo_filial



-- ITEM 2
SELECT * 
FROM CLIENTE 
ORDER BY ESTADO;



-- ITEM 3
SELECT f.matricula 
FROM funcionario f 
ORDER BY funcao, salario DESC



-- ITEM 4
SELECT * 
FROM cliente
WHERE cidade = 'João Pessoa' AND pontos_crm > 1000 ;



-- ITEM 5
SELECT * 
FROM solicitacao s 
WHERE s.prazo_pagamento BETWEEN SYSDATE AND s.prazo_pagamento



-- ITEM 6
SELECT * 
FROM nota_fiscal 
WHERE VALOR_POR_ITEM >150.00 and DATA BETWEEN '12-01-2018' AND '12-31-2018'



-- ITEM 7
SELECT * FROM filial f WHERE (
    SELECT COUNT(*) FROM solicitacao s WHERE s.codigo_filial = f.codigo_identificacao
) = (
    SELECT MAX(quantidade) FROM (SELECT COUNT(*) AS quantidade FROM solicitacao s GROUP BY codigo_filial)
)



-- ITEM 8
SELECT NUMERO_CAIXA
FROM realiza_manutencao 
WHERE custo > 1000.00 AND data_hora BETWEEN '01-01-2019 00:00:00,000000' AND '31-12-2019 23:59:59,999999'



-- ITEM 9
SELECT nf.numero, nf.identificador_solicitacao, s.cnpj_fornecedor 
FROM nota_fiscal nf, solicitacao s 
WHERE nf.identificador_solicitacao = s.identificador AND (SELECT count(*) FROM item i WHERE nf.numero = i.num_nota_fiscal_ordem) > 10



-- ITEM 10
SELECT * 
FROM produto
WHERE (preco_venda - preco_compra > 20.00) AND
        (data_validade >= SYSDATE + 365)



-- ITEM 11
CREATE VIEW funcionario_silva_carneiro AS
    SELECT *
    FROM funcionario
    WHERE LOWER(nome) LIKE '%silva%' OR LOWER(nome) LIKE '%carneiro%'
    


-- ITEM 12
CREATE VIEW supervisores_caixa AS
    SELECT *
    FROM funcionario
    WHERE matricula_supervisor IS NULL AND
            LOWER(funcao) LIKE '%caixa%'




-- ITEM 13
CREATE VIEW fornecedor_dois_ou_mais_telefones AS
    SELECT *
    FROM fornecedor f
    WHERE (
        SELECT COUNT(*)
        FROM telefone_fornecedor tf
        WHERE tf.cnpj = f.cnpj
    ) >= 2



-- ITEM 14
SELECT c.nome 
FROM categoria c
WHERE c.identificador NOT IN (SELECT f.id_categoria
FROM fornecedor  f)



-- ITEM 15
ALTER TABLE telefone_cliente ADD CONSTRAINT formato_telefone_cliente CHECK ( REGEXP_LIKE ( telefone, '^\(\d{2}\) \d{5}-\d{4}$'))
ALTER TABLE telefone_fornecedor ADD CONSTRAINT formato_telefone_fornecedor CHECK ( REGEXP_LIKE ( telefone, '^\(\d{2}\) \d{5}-\d{4}$'))
ALTER TABLE telefone_funcionario ADD CONSTRAINT formato_telefone_funcionario CHECK ( REGEXP_LIKE ( telefone, '^\(\d{2}\) \d{5}-\d{4}$'))



-- ITEM 16



-- ITEM 17
CREATE OR REPLACE TRIGGER VERIFICA_SALARIO BEFORE
UPDATE of salario on FUNCIONARIO FOR EACH ROW
BEGIN
    IF (:NEW.salario > :OLD.salario * 1.5) THEN
    RAISE_APPLICATION_ERROR(-20000, 'Aumento salarial de mais do que 50perc do salario antigo nao eh permitido');
    END IF;
end;



-- ITEM 18
CREATE OR REPLACE TRIGGER GARANTE_LUCRO BEFORE
INSERT on PRODUTO FOR EACH ROW
BEGIN
    IF ( :NEW.preco_venda < :NEW.preco_compra) THEN
    RAISE_APPLICATION_ERROR(-20000, 'preco de venda menor que o preco de compra nao eh permitido');
    END IF;
end;



-- ITEM 19
CREATE OR REPLACE FUNCTION calculaTotalComprasByPeriodo(
    data_inicial IN DATE,
    data_final IN DATE
) 
RETURN NUMBER
IS
    total_compras NUMBER ;
BEGIN
    SELECT SUM(quantidade * valor_por_item) 
    INTO total_compras
    FROM NOTA_FISCAL
    WHERE data >= data_inicial and DATA <= data_final;
    RETURN total_compras;
END;



-- ITEM 20



