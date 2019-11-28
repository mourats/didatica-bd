/* 

  Integrantes:
  GRUPO:
  Caio Maxximus Pereira
  Luiggy Silva
  Matheus Borges
  Marcelo Andrade
  Lucas Salustiano 

 */


/* QUESTÃO 1 */

SELECT nome, data_nasc FROM DEPENDENTE ORDER BY nome DESC;

/* QUESTÃO 2 */
SELECT *
FROM ITEM
WHERE preco_produto <= 200 AND preco_produto <= 400

/* QUESTÃO 3 */

SELECT *
FROM FUNCIONARIO f
ORDER BY (SELECT COUNT(*)
FROM DEPENDENTE d
WHERE f.MATRICULA = d.MATRICULA_FUNCIONARIO) DESC

/* QUESTÃO 4 */

SELECT d.nome, d.cpf
FROM DEPENDENTE d, FUNCIONARIO f
WHERE (Floor(Months_Between(sysdate, d.data_nasc)/12)) and
      d.matriculaFuncionario = f.matricula and
      f.nome LIKE '%João%'

/* QUESTÃO 7 */

SELECT * FROM CAIXA WHERE (SELECT COUNT(*) FROM EQUIPAMENTO WHERE (CAIXA.numero_caixa = EQUIPAMENTO.numero_caixa)) > 2;

/* QUESTÃO 10 */
            
SELECT f.nome, SUM(quantidade) total_vendido
FROM FILIAL f, NOTA_FISCAL n, ORDEM_COMPRA o 
WHERE (f.codigo_identificacao = o.codigo_filial AND o.numero_nota_fiscal = n.numero) GROUP BY f.nome;
                                                                  
/* QUESTÃO 12 */

CREATE VIEW TeleReclamacoes
AS SELECT f.telefone
FROM Filial f
WHERE (SELECT COUNT(*)
FROM Reclamacao r
WHERE r.codigoIdentificacao = f.codigoIdentificacao) > 10

/* QUESTÃO 14 */

CREATE VIEW DEPENDENTES_ADOLESCENTES AS SELECT * FROM DEPENDENTE WHERE 
 (Floor(Months_Between(sysdate, DEPENDENTE.data_nasc)/12) < 18);

/* QUESTÃO 17 */

CREATE OR REPLACE TRIGGER GERA_NOTA_FISCAL
  AFTER INSERT ON SOLICITACAO
  FOR EACH ROW
  ENABLE
  BEGIN
    INSERT INTO NOTA_FISCAL(numero,cnpj,quantidade,data,valor_por_item,identificador_solicitacao) VALUES(:NEW.identificador, :NEW.cnpj_fornecedor, 10, sysdate, :NEW.valor_compra / 10, :NEW.identificador);
  END;
                                                                   
 
/* QUESTÃO 18 */
create or replace TRIGGER VERIFICA_IDADE_DEPENDENTE 
 BEFORE INSERT ON DEPENDENTE 
 FOR EACH ROW 
 BEGIN 
  IF (Floor(Months_Between(sysdate,:new.data_nasc)) /12 ) > 21 THEN  
   raise_application_error(-20001,'Nao e permitido inserir dependente com mais de 21 anos'); 
  END IF; 
 END;                                                       

/* QUESTÃO 16 */ 
CREATE OR REPLACE TRIGGER solicitacaoCheck
 BEFORE INSERT OR UPDATE ON SOLICITACAO
 FOR EACH ROW
 BEGIN
  IF(:new.data_solicitacao >= :new.data_entrega) THEN
   raise_application_error(-20001,'Data de solicitacao nao pode ser maior ou igual a danta de entrega.');
  END IF;
 END;


/*Questão 8*/
SELECT nome FROM FUNCIONARIO 
    WHERE ((SELECT COUNT(*) FROM DEPENDENTE WHERE FUNCIONARIO.matricula = DEPENDENTE.matricula_funcionario) > 1) 
    AND (FUNCIONARIO.salario > 1000);

/*Questão 9*/

SELECT cpf FROM CLIENTE WHERE (
    SELECT COUNT(*) FROM ORDEM_COMPRA WHERE CLIENTE.cpf = ORDEM_COMPRA.cpf_cliente
) > 10
;

/*Quetsão 5*/

SELECT nome, cpf FROM FUNCIONARIO WHERE (SELECT COUNT(*) FROM REALIZA_MANUTENCAO WHERE FUNCIONARIO.matricula = REALIZA_MANUTENCAO.matricula_funcionario) >= 3;

/*Questão 20*/
EXEC getComprasByCliente;
GO
CREATE PROCEDURE getComprasByCliente
    (@cpf AS int)
    AS
    SELECT * FROM ORDEM_COMPRA WHERE ORDEM_COMPRA.cpf_cliente = @cpf;
    
GO