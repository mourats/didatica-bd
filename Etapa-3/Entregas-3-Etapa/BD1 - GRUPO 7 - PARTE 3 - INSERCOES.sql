-- categoria
INSERT INTO CATEGORIA(IDENTIFICADOR, NOME)
VALUES(1, 'Bebidas');

INSERT INTO CATEGORIA(IDENTIFICADOR, NOME)
VALUES(2, 'Papelaria');

INSERT INTO CATEGORIA(IDENTIFICADOR, NOME)
VALUES(3, 'Alimentos');

insert into CATEGORIA (IDENTIFICADOR, NOME)
values(4, 'alimentos');

INSERT INTO CATEGORIA (IDENTIFICADOR, NOME)
VALUES(5, 'vestuario');

INSERT INTO CATEGORIA (IDENTIFICADOR, NOME)
VALUES(6, 'verduras');

-- fornecedor
INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO, EMAIL, ID_CATEGORIA, SITE)
VALUES('55136789000102', 'Ricardo das Cocadas', 'Rua das fomes', 'cocadinhas@mail.com', 3, 'cocadas.bom');

INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO, EMAIL, ID_CATEGORIA, SITE)
VALUES('55136789000122', 'Lojão das Cervejas', 'Rua das sedes', 'cervejinha@mail.com', 1, 'bebedeira.com');

INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO, EMAIL, ID_CATEGORIA, SITE)
VALUES('11136789000102', 'Casa dos Papeis', 'Rua do trabalho', 'pepel@mail.com', 2, 'faztrabalho.to');

INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO,EMAIL, ID_CATEGORIA, SITE)
VALUES('000000000000000001', 'joao','Rua juão mora aqui ','joao@gmail.com', 3, 'oi.com');

INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO,EMAIL, ID_CATEGORIA, SITE)
VALUES('000000000000000002', 'josé','RUA lana del rey é vida','Jose@GMAIL.COM', 1, 'ola.com' );

INSERT INTO FORNECEDOR(CNPJ, NOME, ENDERECO,EMAIL, ID_CATEGORIA, SITE)
VALUES('000000000000000003', 'Ana','RUA ali detrás','ana@gmail.com', 2, 'test.com');

-- filial
INSERT INTO FILIAL(CODIGO_IDENTIFICACAO, NOME, ENDERECO, TELEFONE, GERENTE)
VALUES(1,'Filial CG', 'Campina Grande', '8320203976', NULL);

INSERT INTO FILIAL(CODIGO_IDENTIFICACAO, NOME, ENDERECO, TELEFONE, GERENTE)
VALUES(2,'Filial JP', 'João Pessoa', '8320203977', NULL);
       
-- funcionario
INSERT INTO FUNCIONARIO(MATRICULA, CPF, IDENTIDADE, NOME, ENDERECO, SALARIO, FUNCAO, MATRICULA_SUPERVISOR, CODIGO_FILIAL)
VALUES(1, '07625539461', '7924321', 'Zé Trabalhador', 'Rua dos empregados', 1200, 'Empacotador', null, null);

INSERT INTO FUNCIONARIO(MATRICULA, CPF, IDENTIDADE, NOME, ENDERECO, SALARIO, FUNCAO, MATRICULA_SUPERVISOR, CODIGO_FILIAL)
VALUES(2, '07621539469', '8924322', 'Maria Trabalhadora', 'Rua dos empregados', 1300, 'Empacotador', null, 1);

INSERT INTO FUNCIONARIO(MATRICULA, CPF, IDENTIDADE, NOME, ENDERECO, SALARIO, FUNCAO, MATRICULA_SUPERVISOR, CODIGO_FILIAL)
VALUES(3, '07623539469', '3924322', 'João Trabalhador', 'Rua dos empregados', 1200, 'Empacotador', null, 1);

-- dependente
INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('81919191919', TO_DATE('26/08/2002', 'dd/mm/yyyy'), 'Dependende func 2', 2);

INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('81911191919', TO_DATE('26/08/2003', 'dd/mm/yyyy'), 'Dependende func 2.1', 2);

INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('91919191919', TO_DATE('26/08/2002', 'dd/mm/yyyy'), 'Dependende func 1', 1);

INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('10919191919', TO_DATE('26/08/2002', 'dd/mm/yyyy'), 'Dependende func 1.1', 1);

INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('91919191119', TO_DATE('26/08/2000', 'dd/mm/yyyy'), 'Dependende func 1.2', 1);

INSERT INTO DEPENDENTE(CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO)
VALUES('82919191919', TO_DATE('26/08/2001', 'dd/mm/yyyy'), 'Dependende func 3', 3);

-- solicitacao
INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(1, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '55136789000122');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(2, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 1000, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(3, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(4, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(5, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(6, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(7, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(8, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(9, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(10, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(11, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(12, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(13, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 1, '11136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(14, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(15, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(16, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(17, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(18, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(19, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(20, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(21, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 10000.2, TO_DATE('20/12/2019', 'dd/mm/yyyy'), 2, '55136789000102');

-- TESTA TRIGGER QUESTÃO 17
INSERT INTO SOLICITACAO(IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR)
VALUES(22, TO_DATE('20/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), TO_DATE('24/11/2019', 'dd/mm/yyyy'), 99, TO_DATE('20/11/2020', 'dd/mm/yyyy'), 2, '55136789000102');

-- telefone fornecedor
INSERT INTO TELEFONE_FORNECEDOR(TELEFONE, CNPJ)
VALUES('83933333333', '55136789000122');

INSERT INTO TELEFONE_FORNECEDOR(TELEFONE, CNPJ)
VALUES('83933333332', '55136789000122');

INSERT INTO TELEFONE_FORNECEDOR(TELEFONE, CNPJ)
VALUES('83933333334', '55136789000122');

INSERT INTO TELEFONE_FORNECEDOR(TELEFONE, CNPJ)
VALUES('83833333332', '11136789000102');

-- caixa
INSERT INTO CAIXA(NUMERO_CAIXA, CODIGO_FILIAL)
VALUES(1, NULL);

INSERT INTO CAIXA(NUMERO_CAIXA, CODIGO_FILIAL)
VALUES(2, 1);

-- equipamento
INSERT INTO EQUIPAMENTO(IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA)
VALUES(1, 'COISA', 1);

INSERT INTO EQUIPAMENTO(IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA)
VALUES(2, 'COISA 2', 1);

INSERT INTO EQUIPAMENTO(IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA)
VALUES(2, 'EQP CAIXA 2', 2);

INSERT INTO EQUIPAMENTO(IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA)
VALUES(3, 'EQP CAIXA 2', 2);

INSERT INTO EQUIPAMENTO(IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA)
VALUES(4, 'EQP CAIXA 2', 2);

-- marca
INSERT INTO MARCA(IDENTIFICADOR,NOME)
VALUES('0000000000000000000000001', 'Coca Cola');

INSERT INTO MARCA(IDENTIFICADOR,NOME)
VALUES('0000000000000000000000002', 'Adidas');

INSERT INTO MARCA(IDENTIFICADOR,NOME)
VALUES('0000000000000000000000003', 'Dove');

-- produto

-- cliente
INSERT INTO CLIENTE(CPF, NOME, EMAIL, PONTOS_CRM, RUA, NUM, CIDADE, ESTADO, BAIRRO)
VALUES('10001480482','João Pereira', 'joazinho@gmail.com',3,'sei lá das quantas','3','picui', 'paraiba','centro');

INSERT INTO CLIENTE(CPF, NOME, EMAIL, PONTOS_CRM, RUA, NUM, CIDADE, ESTADO, BAIRRO)
VALUES ('10601289081','Janaina Beltrão', 'jana@gmail.com',9,'ali detrás do mercado','56','Campina Grande', 'paraiba','Bodocongó');

-- realiza de reclamação 
INSERT INTO REALIZA_RECLAMACAO(ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE)
VALUES('1',TO_DATE('2018/04/17', 'yyyy/mm/dd') , 'não gostou de nascer', '1','10601289081');

INSERT INTO REALIZA_RECLAMACAO(ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE)
VALUES('2',TO_DATE('2018/10/15', 'yyyy/mm/dd') , 'queria star morta', '1','10601289081');

INSERT INTO REALIZA_RECLAMACAO(ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE)
VALUES('3',TO_DATE('2018/07/13', 'yyyy/mm/dd') , 'ai gabi, só quem viveu sabe...', '1','10601289081');

INSERT INTO REALIZA_RECLAMACAO(ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE)
VALUES('4',TO_DATE('2018/07/13', 'yyyy/mm/dd') , 'preferia ter ido ver o filme do pelé', '1','10601289081');

--  nota fiscal 
INSERT INTO NOTA_FISCAL( NUMERO, CNPJ, QUANTIDADE, DATA, VALOR_POR_ITEM, IDENTIFICADOR_SOLICITACAO)
VALUES(1,'123',3,TO_DATE('2018/11/27','yyyy/mm/dd'), 3.00, '2');

INSERT INTO NOTA_FISCAL( NUMERO, CNPJ, QUANTIDADE, DATA,  VALOR_POR_ITEM, IDENTIFICADOR_SOLICITACAO) 
VALUES (2, '123',10, to_date('2019/01/01','yyyy/mm/dd'), 10.0, '2' );

INSERT INTO NOTA_FISCAL( NUMERO, CNPJ, QUANTIDADE, DATA,  VALOR_POR_ITEM, IDENTIFICADOR_SOLICITACAO) 
VALUES (3, '123',10, to_date('2019/01/01','yyyy/mm/dd'), 15.0, '2' );

-- ordem compra
INSERT INTO ORDEM_COMPRA( NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA)
VALUES(400, TO_DATE('2019/11/27', 'yyyy/mm/dd'), '10601289081', '2','1','1' );

INSERT INTO ORDEM_COMPRA( NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA)
VALUES(401, TO_DATE('2019/11/27', 'yyyy/mm/dd'), '10601289081', '2','1','1' );

INSERT INTO ORDEM_COMPRA( NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA)
VALUES(402, TO_DATE('2019/11/27', 'yyyy/mm/dd'), '10601289081', '2','1','1' );

INSERT INTO ORDEM_COMPRA( NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA)
VALUES(406, TO_DATE('2019/11/27', 'yyyy/mm/dd'), '10601289081', '2','1','1' );

INSERT INTO ORDEM_COMPRA( NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA)
VALUES(353, TO_DATE('2019/11/27', 'yyyy/mm/dd'), '10001480482', '2','1','1' );
