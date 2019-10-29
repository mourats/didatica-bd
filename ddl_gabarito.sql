-- Esquema padrão para o projeto de Banco de Dados 1 2019.2

CREATE TABLE CLIENTE (
    cpf 	VARCHAR2(14),
	nome 	VARCHAR2(100) NOT NULL,
	email 	VARCHAR2(50) NOT NULL,
	pontos_crm INT,
    rua 	VARCHAR2(100) NOT NULL,
	num 	VARCHAR2(14) NOT NULL,
	cidade 	VARCHAR2(100) NOT NULL,
	estado 	VARCHAR2(100) NOT NULL,
	bairro 	VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_cliente
	PRIMARY KEY (cpf)
);

CREATE TABLE TELEFONE_CLIENTE (
	telefone VARCHAR2(15),
	cpf_cliente VARCHAR2(14),

    CONSTRAINT fk_telefone_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

	CONSTRAINT pk_telefone_cliente
	PRIMARY KEY (cpf_cliente, telefone)
);

CREATE TABLE FUNCIONARIO (
    matricula INT,
    cpf		VARCHAR2(14) NOT NULL,
    identidade	VARCHAR2(7) NOT NULL,
    nome 	VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
    salario	NUMBER(6,2) NOT NULL,
    funcao	VARCHAR2(50) NOT NULL,
	
	CONSTRAINT pk_funcionario
	PRIMARY KEY (matricula)
);

CREATE TABLE TELEFONE_FUNCIONARIO (
	telefone VARCHAR2(15),
	matricula INT,

    CONSTRAINT fk_telefone_funcionario
    FOREIGN KEY (matricula)
    REFERENCES  FUNCIONARIO(matricula),
••••••••
••••••••
••••••••
••••••••

CREATE TABLE DEPENDENTE (
    cpf 	VARCHAR2(14),
    data_nasc 	DATE NOT NULL,
    nome 	VARCHAR2(100) NOT NULL,
	matricula_funcionario INT NOT NULL,
    
    CONSTRAINT fk_dependente_matricula
    FOREIGN KEY (matricula_funcionario) 
    REFERENCES  FUNCIONARIO(matricula),
	
	CONSTRAINT pk_dependente
	PRIMARY KEY (cpf, matricula_funcionario)	
);

CREATE TABLE FILIAL (
    codigo_identificacao  INT,
    nome  VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
	telefone VARCHAR2(15),

	CONSTRAINT pk_filial
	PRIMARY KEY (codigo_identificacao)
);

CREATE TABLE PRODUTO (
    codigo_identificacao  INT,
    nome  VARCHAR2(100) NOT NULL,
    descricao	VARCHAR2(255) NOT NULL,
    margem_lucro  VARCHAR2(4) NOT NULL,

	CONSTRAINT pk_produto
	PRIMARY KEY (codigo_identificacao)
);

CREATE TABLE CAIXA (
    numero_caixa  INT,
    codigo_filial INT,

    CONSTRAINT fk_caixa_filial
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

	CONSTRAINT pk_caixa
	PRIMARY KEY (numero_caixa)
);

CREATE TABLE EQUIPAMENTO (
	identificador INT,
    descricao	VARCHAR2(255) NOT NULL,
    numero_caixa INT,

    CONSTRAINT fk_equipamento_caixa
    FOREIGN KEY (numero_caixa) 
    REFERENCES  CAIXA(numero_caixa),
	
	CONSTRAINT pk_equipamento
	PRIMARY KEY (numero_caixa, identificador)
);

CREATE TABLE REALIZA_MANUTENCAO (
    id_manutencao INT,
	identificador_equipamento INT NOT NULL,
	cpf_funcionario VARCHAR2(14) NOT NULL,
	data_hora	TIMESTAMP NOT NULL,

    CONSTRAINT fk_manutencao_funcionario
    FOREIGN KEY (cpf_funcionario) 
    REFERENCES  FUNCIONARIO(cpf),

    CONSTRAINT fk_manutencao_equipamento
    FOREIGN KEY (identificador) 
    REFERENCES  EQUIPAMENTO(identificador),

	CONSTRAINT pk_manutencao
	PRIMARY KEY (id_manutencao)
);

CREATE TABLE MARCA (
	identificador INT,
    nome  VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_marca
	PRIMARY KEY (identificador)
);

CREATE TABLE CATEGORIA (
	identificador INT,
    nome  VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_categoria
	PRIMARY KEY (identificador)
);

CREATE TABLE SOLICITACAO (
	identificador INT,
    data_solicitacao 	DATE NOT NULL,
    data_prevista 	DATE NOT NULL,
    data_entrega 	DATE NOT NULL,
    valor_compra	NUMBER(10,2) NOT NULL,
    prazo_pagamento INT NOT NULL, 

	CONSTRAINT pk_solicitacao
	PRIMARY KEY (identificador)
);

CREATE TABLE NOTA_FISCAL (
    numero INT,
    cnpj	VARCHAR2(14) NOT NULL,
    quantidade	INT NOT NULL,
    data  DATE NOT NULL,
    salario	NUMBER(8,2) NOT NULL,
	
	CONSTRAINT pk_nota_fiscal
	PRIMARY KEY (numero)
);

CREATE TABLE FORNECEDOR (
    cnpj		VARCHAR2(14),
    nome  VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
	email 	VARCHAR2(50) NOT NULL,
    
	CONSTRAINT pk_fornecedor
	PRIMARY KEY (cnpj)
);

CREATE TABLE TELEFONE_FORNECEDOR (
	telefone VARCHAR2(15),
	cnpj	VARCHAR2(14)

    CONSTRAINT fk_telefone_fornecedor
    FOREIGN KEY (cnpj)
    REFERENCES  FORNECEDOR(cnpj),

	CONSTRAINT pk_telefone_fornecedor
	PRIMARY KEY (cnpj, telefone)
);

CREATE TABLE ORDEM_COMPRA (
    numero_nota_fiscal  INT,
	data_hora	TIMESTAMP NOT NULL,
	cpf_cliente VARCHAR2(14) NOT NULL,
    codigo_filial INT NOT NULL,
	cpf_funcionario VARCHAR2(14) NOT NULL,

    CONSTRAINT fk_ordem_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

    CONSTRAINT fk_filial_possui_ordem
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_funcionario_realiza
    FOREIGN KEY (cpf_funcionario) 
    REFERENCES  FUNCIONARIO(cpf),

	CONSTRAINT pk_ordem_compra
	PRIMARY KEY (numero_nota_fiscal)
);

CREATE TABLE ITEM (
    identificador  INT,
    numero_nota_fiscal INT,
    quantidade	INT NOT NULL,
    preco_produto NUMBER(6,2) NOT NULL,
    desconto NUMBER(6,2) NOT NULL,

    CONSTRAINT fk_ordem_compra
    FOREIGN KEY (numero_nota_fiscal)
    REFERENCES  ORDEM_COMPRA(numero_nota_fiscal),

	CONSTRAINT pk_item
	PRIMARY KEY (identificador. numero_nota_fiscal)
);

CREATE TABLE REALIZA_RECLAMACAO (
	data_hora	TIMESTAMP NOT NULL,
    descricao	VARCHAR2(255) NOT NULL,
    codigo_filial INT,
	cpf_cliente VARCHAR2(14),

    CONSTRAINT fk_reclamacao_filial
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_reclamacao_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

	CONSTRAINT pk_reclamacao
	PRIMARY KEY (codigo_filial, cpf_cliente)
);