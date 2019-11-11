CREATE TABLE CLIENTE (
    cpf 	    VARCHAR2(15),
	nome 	    VARCHAR2(100) NOT NULL,
    telefone    VARCHAR2(13),
    email 	    VARCHAR2(50) NOT NULL,
    pontos_crm  INT NOT NULL,
	endereco 	VARCHAR2(50) NOT NULL,
	
	
	CONSTRAINT pk_cliente
	PRIMARY KEY (cpf)
);

CREATE TABLE FILIAL (
    cod_id          VARCHAR2(15),
    nome            VARCHAR2(100) NOT NULL,
    endereco        VARCHAR2(50) NOT NULL,
    telefone        VARCHAR2(20) NOT NULL,
    
    
    CONSTRAINT pk_filial
    PRIMARY KEY (cod_id)
);

CREATE TABLE FUNCIONARIO (
    matricula  VARCHAR2(20),
    cpf		   VARCHAR2(15) NOT NULL,
    identidade VARCHAR2(15) NOT NULL,
    nome 	   VARCHAR2(100) NOT NULL,
    endereco   VARCHAR2(50) NOT NULL,
    salario	   FLOAT NOT NULL,
    funcao	   VARCHAR2(50) NOT NULL,
	matricula_supervisor    VARCHAR2(20),
    
    CONSTRAINT fk_matricula_supervisor
    FOREIGN KEY (matricula_supervisor) 
    REFERENCES funcionario(matricula),
	
	CONSTRAINT pk_funcionario
	PRIMARY KEY (matricula)
);

CREATE TABLE PRODUTO (
    cod_id_prod    VARCHAR2(15),
    nome           VARCHAR(100) NOT NULL,
    descricao      VARCHAR(100),
    margem_lucro   NUMBER(5,2) NOT NULL,

    CONSTRAINT pk_produto
    PRIMARY KEY (cod_id_prod)
);

CREATE TABLE FORNECEDOR(
    cnpj        VARCHAR2(25),
    nome        VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(50) NOT NULL,
    email       VARCHAR2(50),
    site        VARCHAR2(50) NOT NULL,
    
    CONSTRAINT pk_fornecedor
    PRIMARY KEY (cnpj)
    
);

CREATE TABLE SOLICITACAO (
    id        VARCHAR2(15),
    data_solicitacao DATE NOT NULL, 
    data_previsao    DATE NOT NULL,
    data_entrega     DATE,
    valor_compra     FLOAT NOT NULL,
    prazo_pagamento  int NOT NULL,
    
    CONSTRAINT pk_solicitacao
    PRIMARY KEY (id)
);

CREATE TABLE CATEGORIA (
    id               VARCHAR2(15),
    nome             VARCHAR2(100) NOT NULL,
    cnpj_fornecedor  VARCHAR2(25),
    
    CONSTRAINT fk_categoria_fornecedor
    FOREIGN KEY (cnpj_fornecedor)
    REFERENCES FORNECEDOR(cnpj),
    
   CONSTRAINT pk_categoria
   PRIMARY KEY (id)
);

CREATE TABLE NOTAFISCAL (
    numero        INT,
    cnpj          VARCHAR2(25) NOT NULL,
    quantidade    INT,
    data          DATE NOT NULL,
    valor         FLOAT,
    
    CONSTRAINT pk_nota_fiscal
    PRIMARY KEY (numero)


);

CREATE TABLE ITEM (
    id          INT,
    quantidade  INT,
    preco       NUMBER(6,2),
    desconto    INT,
    
    CONSTRAINT pk_int
    PRIMARY KEY (id)

);

CREATE TABLE CAIXA (
    numero    INT,
    
    CONSTRAINT pk_caixa
    PRIMARY KEY (numero)

);


CREATE TABLE DEPENDENTE (
    cpf 	    VARCHAR2(14),
    data_nasc 	DATE NOT NULL,
    nome 	    VARCHAR2(100) NOT NULL,
	cpf_cliente VARCHAR2(14) NOT NULL,
    
    CONSTRAINT fk_dependente_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf)
    ON DELETE CASCADE,
	
	CONSTRAINT pk_dependente
	PRIMARY KEY (cpf)	
);

CREATE TABLE MARCA (
    id        VARCHAR2(10),
    nome      VARCHAR(100) NOT NULL,
    cod_prod  VARCHAR2(15),
    
    CONSTRAINT fk_marca_produto
    FOREIGN KEY (cod_prod)
    REFERENCES PRODUTO(cod_id_prod),
    
    CONSTRAINT pk_marca
    PRIMARY KEY (id)

);

CREATE TABLE ORDEMCOMPRA (
    num_nota     INT,
    data_hora    VARCHAR2(100) NOT NULL,
    cpf_cliente  VARCHAR2(15),
    mat_funcionario VARCHAR2(20),
    num_caixa    INT,
    cod_filial   VARCHAR2(15),
    
    CONSTRAINT fk_cpf_cliente_compra
    FOREIGN KEY (cpf_cliente)
    REFERENCES CLIENTE(cpf),
    
    CONSTRAINT fk_mat_funcionario_compra
    FOREIGN KEY (mat_funcionario)
    REFERENCES FUNCIONARIO(matricula),
    
    CONSTRAINT fk_num_caixa_compra
    FOREIGN KEY (num_caixa)
    REFERENCES CAIXA(numero),
    
    CONSTRAINT fk_cod_filial_compra
    FOREIGN KEY (cod_filial)
    REFERENCES FILIAL(cod_id),
    
    CONSTRAINT pk_ordem
    PRIMARY KEY (num_nota)

);

CREATE TABLE ENDERECOCLIENTE (
    rua         VARCHAR(20),
    cidade      VARCHAR(20),
    bairro      VARCHAR(20),
    estado      VARCHAR(20),
    numero      INT,
    cpf_cliente VARCHAR(15),
    
    CONSTRAINT fk_endereco_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),
    
    CONSTRAINT pk_endereco
    PRIMARY KEY (cpf_cliente, rua)


);

CREATE TABLE TELEFONE (
	telefone     VARCHAR2(14),
	cpf_cliente  VARCHAR2(15),

    CONSTRAINT fk_telefone_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

	CONSTRAINT pk_telefone
	PRIMARY KEY (cpf_cliente, telefone)
);

CREATE TABLE TELEFONEFORNECEDOR(
    telefone VARCHAR(14),
    cnpj_fornecedor VARCHAR(25),
    
    CONSTRAINT fk_telefone_fornecedor
    FOREIGN KEY (cnpj_fornecedor)
    REFERENCES FORNECEDOR(cnpj),
    
    CONSTRAINT pk_telefone_fornecedor
    PRIMARY KEY (cnpj_fornecedor, telefone)


);

CREATE TABLE EQUIPAMENTO (
	id        VARCHAR2(15),
    descricao VARCHAR2(100),
    numero_caixa INT,

    CONSTRAINT fk_equipamento_caixa
    FOREIGN KEY (numero_caixa) 
    REFERENCES  CAIXA(numero),
	
	CONSTRAINT pk_equipamento
	PRIMARY KEY (numero_caixa, id)
);

CREATE TABLE RECLAMACAO (
    data_hora     VARCHAR2(50),
    descricao     VARCHAR2(100),
    cpf_cliente   VARCHAR2(15),
    cod_id_filial VARCHAR2(14),
    
    CONSTRAINT fk_reclamacao_cliente
    FOREIGN KEY (cpf_cliente)
    REFERENCES CLIENTE(cpf),
    
    CONSTRAINT fk_reclamacao_filial
    FOREIGN KEY (cod_id_filial)
    REFERENCES FILIAL(cod_id),

    CONSTRAINT pk_reclamacao
    PRIMARY KEY (cpf_cliente, cod_id_filial, data_hora)
);


CREATE TABLE ESTOCA (
    data_validade    DATE,
    data_compra      DATE,
    preco_compra     FLOAT,
    preco_venda      FLOAT,
    quantidade       INT,
    cod_id_filial    VARCHAR(14),
    cod_id_produto   VARCHAR2(15),
    
    CONSTRAINT fk_estoca_filial
    FOREIGN KEY (cod_id_filial)
    REFERENCES FILIAL(cod_id),
    
    CONSTRAINT fk_estoca_produto
    FOREIGN KEY (cod_id_produto)
    REFERENCES PRODUTO(cod_id_prod),
    
    CONSTRAINT pk_estoca
    PRIMARY KEY (cod_id_filial, data_compra)
);


DROP TABLE CLIENTE CASCADE CONSTRAINT;
DROP TABLE FUNCIONARIO CASCADE CONSTRAINT;
DROP TABLE PRODUTO CASCADE CONSTRAINT;
DROP TABLE FILIAL CASCADE CONSTRAINT;
DROP TABLE CAIXA CASCADE  CONSTRAINT;
DROP TABLE FORNECEDOR CASCADE CONSTRAINT;

DROP TABLE DEPENDENTE;
DROP TABLE EQUIPAMENTO;
DROP TABLE CATEGORIA;
DROP TABLE TELEFONEFORNECEDOR;
DROP TABLE TELEFONE;
DROP TABLE MARCA;
DROP TABLE ENDERECOCLIENTE;
DROP TABLE ORDEMCOMPRA;
DROP TABLE SOLICITACAO;
DROP TABLE ITEM;
DROP TABLE NOTAFISCAL;
DROP TABLE RECLAMACAO;
DROP TABLE ESTOCA;