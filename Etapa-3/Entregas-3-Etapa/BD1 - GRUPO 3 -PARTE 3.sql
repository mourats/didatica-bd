/*

--------------- GRUPO 3 -------------

Componentes:

    Caio Fernandes
    Wesley Matteus
    Mathias Abreu
    Klaywert Danillo
    Vinícius Abner

*/

------- QUESTÃO 1 --------

/*
    Liste o total de produtos agrupados pela filial a qual ele está estocado.
*/

SELECT p.codigo_identificacao, p.nome as "nome do produto", p.codigo_filial, f.nome as "nome da filial"
FROM "PRODUTO" p JOIN "FILIAL" f ON p.codigo_filial = f.codigo_identificacao

------ FIM QUESTÃO 1 ------


-------- QUESTÃO 2 --------

/*
    Quais as matrículas dos funcionários que possuem o salário maior ou igual a R$5.000?
*/

SELECT f.matricula
FROM "FUNCIONARIO" f
WHERE f.salario >= 5000

------ FIM QUESTÃO 2 ------



-------- QUESTÃO 3 --------

/*
    Crie uma view que lista todas as colunas das filiais que possuem produtos vencidos em seu
    estoque.
*/

SELECT DISTINCT f.*
FROM "FILIAL" f
JOIN "PRODUTO" p ON f.codigo_identificacao = p.codigo_filial
WHERE NOT (SYSDATE BETWEEN p.data_compra AND p.data_validade)

------ FIM QUESTÃO 3 ------



-------- QUESTÃO 4 --------

/*
	Quais os itens que não possuem o menor preço do produto? Liste todas as colunas desses
	itens
*/

SELECT *
FROM "ITEM"
WHERE preco_produto != (SELECT MIN(preco_produto)
			            FROM "ITEM")

------ FIM QUESTÃO 4 ------



------- QUESTÃO 5 ---------

/*
    Liste todas as colunas dos produtos da marca “Nestlé” e que possuam a palavra “Leite” na
    nome.
*/

SELECT p.* 
FROM "PRODUTO" p JOIN "MARCA" m ON id_marca = identificador
WHERE p.nome LIKE '%Leite%' AND m.nome = 'Nestlé'


----- FIM QUESTÃO 5 -------



-------- QUESTÃO 6 --------

/*
    Quais os nomes dos clientes que compraram mais de 10 itens do mesmo produto, em uma só
    compra, entre 2018 e 2019?
*/

SELECT c.cpf, c.nome, o.numero_nota_fiscal, n.quantidade, n.data 
FROM "CLIENTE" c 
JOIN "ORDEM_COMPRA" o ON c.cpf = o.cpf_cliente
JOIN "NOTA_FISCAL" n ON n.numero = o.numero_nota_fiscal
WHERE n.quantidade > 10 AND n.data BETWEEN "01/01/2018" AND "31/12/2019"

-------- FIM QUESTÃO 6 ---------



---------- QUESTÃO 7 -----------

/*
    Quais clientes que possuem dois telefones de contato? Liste todas as colunas.
*/

SELECT *
FROM "CLIENTE" c
WHERE (SELECT COUNT(*)
		FROM "TELEFONE_CLIENTE" t
		WHERE t.cpf_cliente = c.cpf) = 2

-------- FIM QUESTÃO 7 ---------



---------- QUESTÃO 8 -----------

/*
    Qual o menor margem de lucro do produto da marca “Coca-Cola”?
*/

SELECT MIN(p.margem_lucro) AS MARGEM
FROM "PRODUTO" p
JOIN "MARCA" m ON p.id_marca = m.identificador
WHERE m.nome = 'Coca-Cola'

-------- FIM QUESTÃO 8 ---------



---------- QUESTÃO 9  ----------

/*
    Quais as matrículas dos funcionarios que possuem mais dependentes que a média de dependentes por
    funcionário?
*/

SELECT f.matricula
FROM "FUNCIONARIO" f
WHERE (SELECT COUNT(*)
	   FROM "DEPENDENTE" d
	   WHERE d.matricula_funcionario = f.matricula)
	   > 
	   (SELECT AVG(COUNT(d.cpf))
		FROM "DEPENDENTE" d
		GROUP BY matricula_funcionario)

-------- FIM QUESTÃO 9  --------



---------- QUESTÃO 10 ----------

/*
    Quais os identificadores dos produtos que possuem o preço da compra superior a R$ 200,00 e
    com quantidade de estoque superior a 10 produtos?
*/

SELECT codigo_identificacao
FROM "PRODUTO" p 
WHERE preco_compra > 200 AND quantidade > 10

-------- FIM QUESTÃO 10 ---------



-------- QUESTÃO 11 --------

/*
    Quais os custos das manutenções realizadas em um equipamento que possui “Monitor” em sua
    descrição.
*/

SELECT r.id_manutencao, e.identificador, e.descricao, r.custo
FROM "REALIZA_MANUTENCAO" r 
JOIN "EQUIPAMENTO" e ON r.numero_caixa = e.numero_caixa AND r.identificador_equipamento = e.identificador
WHERE e.descricao LIKE '%Monitor%'

-------- FIM QUESTÃO 11 ---------



---------- QUESTÃO 12  ----------

/*

    Crie uma view que lista todas as colunas de todos os produtos comprados pelo caixa de
    número 10.

*/

CREATE VIEW "PRODUTOS_CAIXA_10" AS 
	SELECT p.*
	FROM "ORDEM_COMPRA" o
	JOIN "ITEM" i ON i.num_nota_fiscal_ordem = o.numero_nota_fiscal
	JOIN "PRODUTO" p ON i.codigo_produto = p.codigo_identificacao
	WHERE o.numero_caixa = 10;

-------- FIM QUESTÃO 12 ---------



---------- QUESTÃO 13 -----------

/*
    Crie uma view que mostra a descrição da reclamação e todos os dados do cliente que
    reclamou.
*/

CREATE VIEW RELATORIO_DE_RECLAMACOES AS
    SELECT r.descricao, c.*
    FROM "REALIZA_RECLAMACAO" r
    JOIN "CLIENTE" c ON r.cpf_cliente = c.cpf

-------- FIM QUESTÃO 13 ---------



----------- QUESTÃO 14 ----------

/*
	Crie uma view que liste o nome e a identidade de todos os funcionários da função de 'limpeza'
	ou da função de 'segurança'
*/

CREATE VIEW IdNomeFuncionarios(idF, nomeF)
	AS SELECT identidade, nome
	FROM "FUNCIONARIO"
	WHERE funcao IN ('limpeza', 'segurança')

-------- FIM QUESTÃO 14  --------



---------- QUESTÃO 15 -----------

/*
    Modifique a tabela FORNECEDOR, adicionando uma restrição de integridade que valide se a
    coluna CNPJ está no formato "xx.xxx.xxx/0001-xx", onde cada “x” é um dígito de 0 a 9.
*/

ALTER TABLE "FORNECEDOR"
ADD CONSTRAINT check_cnpj CHECK (REGEXP_LIKE(cnpj, '^[0-9]{2}.[0-9]{3}.[0-9]{3}/0001-[0-9]{2}$'))

------- FIM QUESTÃO 15 ---------



---------- QUESTÃO 16 ----------

/*
	Faça um trigger que ao ser inserido ou atualizado uma solicitação, não seja permitido que
    a data de solicitação seja maior que a data atual.
*/

CREATE OR REPLACE TRIGGER trigger_solic
    BEFORE INSERT OR UPDATE ON solicitacao
    FOR EACH ROW
    BEGIN
        IF (SYSDATE < :NEW.data_solicitacao) THEN
            RAISE_APPLICATION_ERROR(-20205,'Não é permitido que a data de solicitação seja maior que a data atual.');
        END IF;
    END trigger_solic;

-------- FIM QUESTÃO 16 --------



---------- QUESTÃO 17 ----------

/*
    Faça um trigger que quando houver um update no gerente de uma filial o salário do
    funcionário que se tornou gerente deve ter um acréscimo de 20%.
*/

CREATE OR REPLACE TRIGGER IncrementaSalarioGerente
	BEFORE UPDATE OF funcao ON funcionario
	FOR EACH ROW
    WHEN (NEW.funcao = 'Gerente')
	BEGIN
        :NEW.salario := :NEW.salario * 1.2;
    END;

------- FIM QUESTÃO 17 ---------



-------- QUESTÃO 18 ------------

/*
    Faça um trigger que não permita a inserção de um produto se faltar menos de 30 dias para o
    término de sua validade.
*/

CREATE OR REPLACE TRIGGER trigger_prod_val
    BEFORE INSERT ON produto
    FOR EACH ROW
    BEGIN
        IF (:NEW.data_validade - SYSDATE < 30) THEN
            RAISE_APPLICATION_ERROR(-20205,'Não é permitida inserção de produtos cuja validade é menor do que 30 dias.');
        END IF;
    END trigger_prod_val;

------ FIM QUESTÃO 18 ----------



---------- QUESTÃO 19 ----------

/*
    Crie uma stored procedure chamada atualizaSalarios que deve atualizar os salários de todos
    os funcionários aplicando um percentual informado como parâmetro da procedure, é
    obrigatório o uso de CURSOR. Coloque no script também o código de como executar a
    procedure.
*/

CREATE OR REPLACE PROCEDURE atualizaSalarios(percentual IN NUMBER) AS
  matr funcionario.matricula%TYPE;

  CURSOR c_func IS
    SELECT matricula
      FROM FUNCIONARIO; 
      
BEGIN
  OPEN c_func;

  LOOP
    FETCH c_func INTO matr;
    EXIT WHEN c_func%NOTFOUND;

    UPDATE FUNCIONARIO
      SET salario = salario * (1 + percentual)
      WHERE matricula = matr;
  END LOOP;

  CLOSE c_func;    
END;


----- FORMA DE INSTANCIAÇÃO DO PROCEDURE

BEGIN
    atualizaSalarios(percentual => 0.5);
END;


-------- FIM QUESTÃO 19 --------



---------- QUESTÃO 20 ----------

/*
    Crie uma stored procedure chamada getReclamacoesByPeriodo que mostra todas as reclamações
    registradas num determinado período informado como parâmetro da procedure, ordenadas
    decrescentemente por data (as reclamações mais recentes devem ser mostradas primeiro).
    Coloque no script também o código de como executar a procedure.
*/

CREATE OR REPLACE 
PROCEDURE getReclamacoesByPeriodo (
            f_date IN VARCHAR, 
            s_date IN VARCHAR,
            r_cursor OUT sys_refcursor) AS
BEGIN
    open r_cursor for SELECT id_reclamacao
                      FROM REALIZA_RECLAMACAO
                      WHERE data_hora BETWEEN f_date AND s_date
                      ORDER BY data_hora DESC;
END;

----- FORMA DE INSTANCIAÇÃO DO PROCEDURE

/* 
    Para chamar o procedimento basta editar os valores das
    datas presentes em first_dt e second_dt (essas datas 
    especificam o início e o fim do período respectivamente)
*/

DECLARE
    r_cursor   sys_refcursor;
    first_dt   VARCHAR(20);
    second_dt  VARCHAR(20);
    r_id_reclamacao NUMBER;
BEGIN
    first_dt := '2019/12/10 00:00:00';
    second_dt := '2019/12/16 00:00:00';

    getReclamacoesByPeriodo(f_date => TO_TIMESTAMP(first_dt, 'YYYY-MM-DD HH24:MI:SS'),
                            s_date => TO_TIMESTAMP(second_dt, 'YYYY-MM-DD HH24:MI:SS'),
                            r_cursor => r_cursor);

    LOOP
        FETCH r_cursor
        INTO  r_id_reclamacao;
        EXIT WHEN r_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(' | ' || r_id_reclamacao || ' | ');
    END LOOP;

    CLOSE r_cursor;
END;

------------ FIM QUESTÃO 20 ------------
