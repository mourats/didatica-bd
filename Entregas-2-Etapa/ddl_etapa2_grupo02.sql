CREATE TABLE Funcionario(
    matricula char(10),
    matriculaGerente char(10),
    codigoIdentificacao INTEGER, 
    nome VARCHAR(20) NOT NULL,
    cpf char(11) NOT NULL,
    identidade char(10),
    endereco VARCHAR(30) NOT NULL,
    salario float NOT NULL,
    funcao VARCHAR(12) NOT NULL,
    PRIMARY KEY(matricula),
    CHECK(salario > 0)
);


CREATE TABLE TelefoneFuncionario(
	matricula char(10),
	telefone char(15),
	PRIMARY KEY (matricula , telefone),
	FOREIGN KEY (matricula) REFERENCES
    	Funcionario(matricula)
);


CREATE TABLE Dependente(
    cpf char(11),
    matriculaFuncionario char(10),
    dataDeNascimento TIMESTAMP,
    nome VARCHAR(20),
    PRIMARY KEY(cpf),
    FOREIGN KEY(matriculaFuncionario) REFERENCES Funcionario(matricula)
);



CREATE TABLE Categoria(
    identificador INTEGER,
    nome VARCHAR(15),
    PRIMARY KEY(identificador)
);

CREATE TABLE Fornecedor(
    cnpj char(18),
    identificador INTEGER,
    nome VARCHAR(20),
    endereco char(50),
    email VARCHAR(30),
    site VARCHAR(30),
    PRIMARY KEY(cnpj),
    FOREIGN KEY(identificador) REFERENCES Categoria(identificador)
);

CREATE TABLE TelefonesFornecedor(
    cnpj char(18),
    telefone char(15),
    PRIMARY KEY (cnpj, telefone),
    FOREIGN KEY (cnpj) REFERENCES Fornecedor(cnpj)
);

CREATE TABLE NotaFiscal(
    numero INTEGER,
    cnpj char(18),
    quantidade INTEGER,
    data TIMESTAMP,
    valorPorItem REAL,
    PRIMARY KEY(numero)
);

CREATE TABLE Marca(
    identificador INTEGER,
    nome VARCHAR(15),
    PRIMARY KEY(identificador)
);

CREATE TABLE Filial(
    matricula char(10),
    codigoIdentificacao INTEGER, 
    nome VARCHAR(20),
    endereco VARCHAR(50),
    telefone char(15),
    PRIMARY KEY(codigoIdentificacao),
    FOREIGN KEY(matricula) REFERENCES Funcionario(matricula)
);


CREATE TABLE Solicitacao(
    identificador INTEGER,
    numero INTEGER,
    cnpj char(18),
    codigoIdentificacao INTEGER,
    dataSolicitacao TIMESTAMP,
    dataPrevistaEntrega TIMESTAMP,
    dataEntrega TIMESTAMP,
    valorCompra REAL,
    prazoPagamentoDias INTEGER,
    PRIMARY KEY (identificador),
    FOREIGN KEY (numero) REFERENCES NotaFiscal(numero),
    FOREIGN KEY (cnpj) REFERENCES Fornecedor(cnpj),
    FOREIGN KEY (codigoIdentificacao) REFERENCES Filial(codigoIdentificacao)
);

CREATE TABLE Cliente(
    cpf char(11), 
    nome VARCHAR(25),
    email VARCHAR(25),
    pontosCRM INTEGER,
    rua VARCHAR(25),
    numRua INTEGER,
    cidade VARCHAR(20),
    estado VARCHAR(20),
    bairro VARCHAR(20),
    PRIMARY KEY(cpf)
);

CREATE TABLE TelefonesCliente(
    cpf char(11),
    telefone char(15) UNIQUE,
    PRIMARY KEY(cpf, telefone),
    FOREIGN KEY(cpf) REFERENCES Cliente
);

CREATE TABLE Caixa(
    numeroCaixa INTEGER,
    codigoIdentificacao INTEGER,
    PRIMARY KEY(numeroCaixa),
    FOREIGN KEY(codigoIdentificacao) REFERENCES Filial(codigoIdentificacao)
);

CREATE TABLE Equipamento(
	identificador INTEGER,
	numeroCaixa INTEGER,
    codigoIdentificacao INTEGER,
	descricao CLOB,
    PRIMARY KEY(identificador,numeroCaixa),
    FOREIGN KEY(numeroCaixa) REFERENCES Caixa(numeroCaixa),
	CHECK(identificador > 0)
);

CREATE TABLE ManutencaoEquipamento (
    identificador INTEGER,
    numeroCaixa INTEGER,
    matricula char(10),
    dataEHora TIMESTAMP,
    custo REAL,
    PRIMARY KEY (identificador, numeroCaixa, matricula),
    FOREIGN KEY (identificador, numeroCaixa) REFERENCES Equipamento(identificador, numeroCaixa),
    FOREIGN KEY (matricula) REFERENCES Funcionario(matricula)
);

CREATE TABLE OrdemCompra(
    numeroNotaFiscal char(15),
    matricula char(10),
    codigoIdentificacao INTEGER,
    cpf char(11),
    numeroCaixa INTEGER,
    PRIMARY KEY (numeroNotaFiscal),
    FOREIGN KEY (matricula) REFERENCES Funcionario(matricula),
    FOREIGN KEY (codigoIdentificacao) REFERENCES Filial(codigoIdentificacao),
    FOREIGN KEY (cpf) REFERENCES Cliente(cpf),
    FOREIGN KEY (numeroCaixa) REFERENCES Caixa(numeroCaixa)
);

CREATE TABLE Produto(
    codigoIdentificacao INTEGER,
    identificador INTEGER,
    codigoIdentificacaoFilial INTEGER,
    identificadorMarca INTEGER,
    nome VARCHAR(20),
    descricao CLOB,
    margemLucroMinimo float,
    dataValidade DATE,
    quantidade INTEGER,
    precoVenda float,
    precoCompra float,
    dataCompra DATE,
    PRIMARY KEY (codigoIdentificacao),
    FOREIGN KEY (codigoIdentificacaoFilial) REFERENCES Filial(codigoIdentificacao),
    FOREIGN KEY (identificadorMarca) REFERENCES marca(identificador),
    FOREIGN KEY (identificador) REFERENCES Categoria(identificador)
);

CREATE TABLE Item(
    identificador INTEGER,
    numeroNotaFiscal char(15),
    numero INTEGER,
    codigoIdentificacao INTEGER,
    quantidade INTEGER,
    precoProduto float,
    desconto float,
    PRIMARY KEY (identificador , numeroNotaFiscal),
    FOREIGN KEY (codigoIdentificacao) REFERENCES Produto(codigoIdentificacao),
    FOREIGN KEY (numeroNotaFiscal) REFERENCES OrdemCompra(numeroNotaFiscal),
    FOREIGN KEY (numero) REFERENCES NotaFiscal(numero)
);

CREATE TABLE Reclamacao(
    cpf char(11),
    codigoIdentificacao INTEGER,
    PRIMARY KEY (cpf, codigoIdentificacao),
    FOREIGN KEY (codigoIdentificacao) REFERENCES Filial(codigoIdentificacao),
    FOREIGN KEY (cpf) REFERENCES Cliente(cpf)
);


ALTER TABLE Funcionario ADD CONSTRAINT IdentificacaodeFilial FOREIGN KEY(codigoIdentificacao) REFERENCES Filial(codigoIdentificacao);
ALTER TABLE Funcionario ADD CONSTRAINT MatriculaGerenteFuncionario FOREIGN KEY(matriculaGerente) REFERENCES Funcionario(matricula);



DROP TABLE TelefonesFornecedor;
DROP TABLE Solicitacao;
DROP TABLE Fornecedor;

DROP TABLE Item;
DROP TABLE OrdemCompra;

DROP TABLE Produto;
DROP TABLE Marca;
DROP TABLE Categoria;

DROP TABLE ManutencaoEquipamento;
DROP TABLE Equipamento;
DROP TABLE Caixa;

DROP TABLE TelefonesCliente;

DROP TABLE TelefoneFuncionario;
DROP TABLE Dependente;

DROP TABLE Reclamacao;

DROP TABLE Cliente;
DROP TABLE Filial CASCADE CONSTRAINT;
DROP TABLE Funcionario CASCADE CONSTRAINT;

DROP TABLE NotaFiscal;