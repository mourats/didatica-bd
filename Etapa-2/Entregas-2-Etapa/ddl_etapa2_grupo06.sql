-- Esquema padrão para o projeto de Banco de Dados 1 2019.2
-- Grupo 06

--Criação das tabelas

CREATE TABLE  cliente (
        cpf_cliente VARCHAR2(14), 
	nome VARCHAR2(100) NOT NULL, 
	email VARCHAR2(50) NOT NULL, 
	pontos_crm INT NOT NULL, 
	rua VARCHAR2(100) NOT NULL,
        numero INT,
        cidade VARCHAR2(50) NOT NULL,
        bairro VARCHAR2(50) NOT NULL,
        estado VARCHAR2(50) NOT NULL,
        
        CONSTRAINT pk_cliente
	PRIMARY KEY (cpf_cliente)
   );

CREATE TABLE telefone_cliente(
        cpf_cliente VARCHAR2 (14),
        tel_cliente VARCHAR2(14),
        
        CONSTRAINT fk_telefone_cliente
        FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf_cliente),
        
        CONSTRAINT pk_telefone_cliente
        PRIMARY KEY (cpf_cliente, tel_cliente)
        
);

CREATE TABLE funcionario(
        matricula_funcionario VARCHAR2(20),
        cpf_funcionario VARCHAR2(14) NOT NULL,
        identidade VARCHAR2(14) NOT NULL,
        nome VARCHAR2(100) NOT NULL,
        endereco VARCHAR2(50) NOT NULL,
        salario FLOAT NOT NULL,
        funcao VARCHAR2(20) NOT NULL,
        matricula_supervisor VARCHAR2(20),
        
        CONSTRAINT pk_matricula_funcionario
        PRIMARY KEY (matricula_funcionario),
        
        CONSTRAINT fk_matricula_supervisor
        FOREIGN KEY (matricula_supervisor) REFERENCES funcionario(matricula_funcionario)

);

CREATE TABLE telefone_funcionario(
        matricula_funcionario VARCHAR2 (20),
        tel_funcionario VARCHAR2(20),
        
        CONSTRAINT fk_telefone_funcionarrio
        FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula_funcionario),
        
        CONSTRAINT pk_telefone_funcionario
        PRIMARY KEY (matricula_funcionario, tel_funcionario)
);

CREATE TABLE dependente(
        cpf VARCHAR2(14),
        data_nasc DATE NOT NULL,
        nome VARCHAR2(100) NOT NULL,
        matricula_funcionario VARCHAR2(14) NOT NULL,
    
        CONSTRAINT fk_dependente_funcionario
        FOREIGN KEY (matricula_funcionario) REFERENCES  funcionario(matricula_funcionario),
	
	CONSTRAINT pk_dependente
	PRIMARY KEY (cpf, matricula_funcionario)	
);

CREATE TABLE equipamento(
        id_equipamento INT,
        descricao VARCHAR2(140) NOT NULL,
        
        CONSTRAINT pk_id_equipamento
        PRIMARY KEY (id_equipamento)
);

CREATE TABLE nota_fiscal(
        num_nota NUMBER, 
        cnpj CHAR(14) NOT NULL,
        quantidade INT NOT NULL,
        data DATE NOT NULL,
        valor_por_item FLOAT NOT NULL,
        
        CONSTRAINT pk_num_nota
        PRIMARY KEY (num_nota)
);

CREATE TABLE solicitacao(
        id_solicitacao INT,
        data_solicitacao DATE NOT NULL,
        data_prev_entrega DATE NOT NULL,
        data_entrega DATE NOT NULL,
        valor_compra FLOAT NOT NULL,
        prazo_pagamento INT NOT NULL,
        
        CONSTRAINT pk_id_solicitacao
        PRIMARY KEY (id_solicitacao)
);

CREATE TABLE item(
        id_item INT,
        quantidade INT NOT NULL,
        preco FLOAT NOT NULL,
        desconto FLOAT,
        
        CONSTRAINT pk_id_item
        PRIMARY KEY (id_item)
);

CREATE TABLE ordem_de_compra(
        num_nota_fiscal INT, 
	data_hora DATE NOT NULL, 
        
        CONSTRAINT pk_num_nota_fiscal
	PRIMARY KEY (num_nota_fiscal)
);

CREATE TABLE produto(
        id_produto INT,
	nome VARCHAR2(30) NOT NULL,
	descricao VARCHAR2(40) NOT NULL,
	margem_lucro FLOAT(126) NOT NULL, 
        
        CONSTRAINT pk_id_produto
	PRIMARY KEY (id_produto)
);

CREATE TABLE filial(
        id_filial INT,
        nome VARCHAR(50) NOT NULL,
        endereco  VARCHAR(100) NOT NULL, 
        telefone VARCHAR(20) NOT NULL,
        
        CONSTRAINT pk_id_filial
        PRIMARY KEY(id_filial)
   
);

CREATE TABLE marca(
        id_marca INT,
        nome_marca VARCHAR (50) NOT NULL,
        
        CONSTRAINT pk_id_marca
        PRIMARY KEY (id_marca)
);

CREATE TABLE categoria(
        id_categoria INT,
        nome_categoria VARCHAR (50) NOT NULL,
        
        CONSTRAINT pk_id_categoria
        PRIMARY KEY (id_categoria)
);

CREATE TABLE caixa(
        num_caixa INT,
        cod_id_caixa INT NOT NULL,
        
        CONSTRAINT pk_num_caixa
        PRIMARY KEY (num_caixa)
);

CREATE TABLE fornecedor(
        cnpj_fornecedor VARCHAR2(14),
        nome VARCHAR(30) NOT NULL,
        endereco VARCHAR(100) NOT NULL,
        email VARCHAR(50) NOT NULL,
        site VARCHAR(30) NOT NULL,
        
        CONSTRAINT pk_cnpj_fornecedor
        PRIMARY KEY (cnpj_fornecedor)
);

CREATE TABLE telefone_fornecedor(
	telefone VARCHAR2(14),
	cnpj_fornecedor VARCHAR2(14),

        CONSTRAINT fk_telefone_fornecedor
        FOREIGN KEY (cnpj_fornecedor) 
        REFERENCES  fornecedor(cnpj_fornecedor),

	CONSTRAINT pk_telefone_fornecedor
	PRIMARY KEY (cnpj_fornecedor, telefone)
);

CREATE TABLE realiza_reclamacao(
        cpf_cliente VARCHAR(11),
        id_filial INT,
	data_e_hora VARCHAR(50),
	descricao VARCHAR(60),
       	FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf_cliente),
       	FOREIGN KEY (id_filial) REFERENCES filial(id_filial),
	PRIMARY KEY (cpf_cliente, id_filial)
);

CREATE TABLE realiza_manutencao(
        id_equipamento NUMBER,
        matricula_funcionario VARCHAR(20),
	data_e_hora VARCHAR(50),
	descricao VARCHAR(60),
       	FOREIGN KEY (id_equipamento) REFERENCES equipamento(id_equipamento),
       	FOREIGN KEY (matricula_funcionario) REFERENCES funcionario(matricula_funcionario),
	PRIMARY KEY (id_equipamento, matricula_funcionario)
);

--Remoção das tabelas

DROP TABLE cliente CASCADE CONSTRAINT;
DROP TABLE ordem_de_compra CASCADE CONSTRAINT;
DROP TABLE funcionario CASCADE CONSTRAINT;
DROP TABLE produto CASCADE CONSTRAINT;
DROP TABLE filial CASCADE CONSTRAINT;
DROP TABLE marca CASCADE CONSTRAINT;
DROP TABLE categoria CASCADE CONSTRAINT;
DROP TABLE caixa CASCADE CONSTRAINT;

DROP TABLE dependente CASCADE CONSTRAINT;
DROP TABLE fornecedor CASCADE CONSTRAINT;
DROP TABLE equipamento CASCADE CONSTRAINT;
DROP TABLE nota_fiscal CASCADE CONSTRAINT;
DROP TABLE solicitacao CASCADE CONSTRAINT;
DROP TABLE item CASCADE CONSTRAINT;

DROP TABLE telefone_cliente CASCADE CONSTRAINT;
DROP TABLE telefone_funcionario CASCADE CONSTRAINT;
DROP TABLE telefone_fornecedor  CASCADE CONSTRAINT;

DROP TABLE realiza_reclamacao CASCADE CONSTRAINT;
DROP TABLE realiza_manutencao  CASCADE CONSTRAINT;
