/*CRIAÇÃO DAS TABELAS*/

CREATE TABLE funcionario(
    matricula VARCHAR(20),
    cpfFuncionario CHAR(11) NOT NULL,
    identidade CHAR(7) NOT NULL,
    nomeFuncionario VARCHAR(50) NOT NULL,
    enderecoFuncionario VARCHAR(50) NOT NULL,
    salario FLOAT NOT NULL,
    funcao VARCHAR(20) NOT NULL,
    matriculaSupervisor VARCHAR(20),
    PRIMARY KEY (matricula),
    FOREIGN KEY (matriculaSupervisor) REFERENCES funcionario(matricula) 
);

CREATE TABLE  filial(
    codIdFilial INT,
    nomeFilial VARCHAR(50) NOT NULL,
    enderecoFilial  VARCHAR(100) NOT NULL,
    telefoneFilial VARCHAR(20),
    matriculaFuncionario VARCHAR(20),
    PRIMARY KEY(codIdFilial),
    FOREIGN KEY (matriculaFuncionario) REFERENCES funcionario(matricula)
);

CREATE TABLE cliente(
    cpfCliente CHAR(11),
    nomeCliente VARCHAR(50) NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    pontosCRM INT NOT NULL,
    rua VARCHAR(50)NOT NULL,
    numero INT,
    cidade VARCHAR(30) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    estado VARCHAR (20) NOT NULL,
    PRIMARY KEY (cpfCliente)
);

CREATE TABLE dependente(
    cpfDependente CHAR(11) NOT NULL,
    nascimentoDependente DATE NOT NULL,
    nomeDependente VARCHAR(50) NOT NULL,
    matriculaFuncionario VARCHAR(20),
    PRIMARY KEY (cpfDependente),
    FOREIGN KEY (matriculaFuncionario) REFERENCES funcionario(matricula)
);

CREATE TABLE realizaReclamacao (
    cpfClienteReclamacao CHAR(11),
    codIdFilialReclamacao INT,
    dataHoraReclamacao TIMESTAMP NOT NULL,
    descricao VARCHAR(200),
    PRIMARY KEY (cpfClienteReclamacao, codIdFilialReclamacao),
    FOREIGN KEY (cpfClienteReclamacao) REFERENCES cliente (cpfCliente),
    FOREIGN KEY (codIdFilialReclamacao) REFERENCES filial (codIdFilial)
);

CREATE TABLE telefoneFuncionario(
    matriculaFuncionario VARCHAR (20),
    numeroTelFuncionario VARCHAR(20),
    PRIMARY KEY (matriculaFuncionario, numeroTelFuncionario),
    FOREIGN KEY (matriculaFuncionario) REFERENCES funcionario(matricula)
);

CREATE TABLE marca(
    idMarca VARCHAR (12),
    nomeMarca VARCHAR (50) NOT NULL,
    PRIMARY KEY (idMarca)
);

CREATE TABLE categoria(
    idCategoria VARCHAR (12),
    nomeCategoria VARCHAR (50) NOT NULL,
    PRIMARY KEY (idCategoria)
);

CREATE TABLE caixa (
    numeroCaixa INT,
    idFilial INT,
    PRIMARY KEY (numeroCaixa),
    FOREIGN KEY (idFilial) REFERENCES filial(codIdFilial)
);

CREATE TABLE equipamento (
    idEquipamento INT,
    descricao VARCHAR (50) NOT NULL,
    numeroCaixaEquipamento INT NOT NULL,
    PRIMARY KEY (idEquipamento),
    FOREIGN KEY (numeroCaixaEquipamento) REFERENCES caixa(numeroCaixa)    
);

CREATE TABLE realizaManutencao (
    idEquipamento INT,
    matFuncionario VARCHAR(20),
    dataHoraManutencao TIMESTAMP NOT NULL,
    custo NUMBER NOT NULL,
    PRIMARY KEY (idEquipamento, matFuncionario),
    FOREIGN KEY (idEquipamento) REFERENCES equipamento (idEquipamento),
    FOREIGN KEY (matFuncionario) REFERENCES funcionario (matricula)
);

CREATE TABLE telefoneCliente(
    cpfTelCliente CHAR (11),
    numeroTelCliente VARCHAR(20),
    PRIMARY KEY (cpfTelCliente, numeroTelCliente),
    FOREIGN KEY (cpfTelCliente) REFERENCES cliente(cpfCliente)
);

CREATE TABLE fornecedor(
    cnpj VARCHAR(20),
    nomeFornecedor VARCHAR(50) NOT NULL,
    enderecoFornecedor VARCHAR(50) NOT NULL,
    emailFornecedor VARCHAR(50) NOT NULL,
    siteFornecedor VARCHAR(20) NOT NULL,
    idCategoriaFornecedor VARCHAR (12),
    PRIMARY KEY (cnpj),
    FOREIGN KEY (idCategoriaFornecedor) REFERENCES categoria(idCategoria)
);

CREATE TABLE telefoneFornecedor(
    cnpjFornecedor VARCHAR (20),
    numeroTelFornecedor VARCHAR(20),
    PRIMARY KEY (cnpjFornecedor, numeroTelFornecedor),
    FOREIGN KEY (cnpjFornecedor) REFERENCES fornecedor(cnpj)
);

CREATE TABLE ordemDeCompra(
    numOrdemDeCompra INT,
    dataEHotaVenda TIMESTAMP NOT NULL,
    numCaixa INT NOT NULL,
    cpfClienteCompra CHAR(11) NOT NULL,
    codIdFilialCompra INT NOT NULL,
    matFuncionario VARCHAR(20) NOT NULL,
    PRIMARY KEY (numOrdemDeCompra),
    FOREIGN KEY (numCaixa) REFERENCES caixa(numeroCaixa),
    FOREIGN KEY (cpfClienteCompra) REFERENCES cliente (cpfCliente),
    FOREIGN KEY (codIdFilialCompra) REFERENCES filial (codIdFilial),
    FOREIGN KEY (matFuncionario) REFERENCES funcionario(matricula)
);

CREATE TABLE solicitacao(
    idSolicitacao INT,
    dataSolicitacao DATE NOT NULL,
    dataPrevistaEntrega DATE NOT NULL,
    dataEntrega DATE NOT NULL,
    valorCompra NUMBER,
    prazoPagamentoDia DATE,
    codIDFilial INT,
    cnpjFornecedor VARCHAR(20),
    PRIMARY KEY (idSolicitacao),
    FOREIGN KEY (codIDFilial) REFERENCES filial(codIdFilial),
    FOREIGN KEY (cnpjFornecedor) REFERENCES fornecedor (cnpj)
);

CREATE TABLE notafiscal(
    numNotaFiscal INT,
    cnpjNotaFiscal VARCHAR(20) NOT NULL,
    quantidade INT,
    dataNotaFiscal DATE NOT NULL,
    valorPorItem NUMBER,
    idNFSolicitacao INT NOT NULL,
    PRIMARY KEY (numNotaFiscal),
    FOREIGN KEY(idNFSolicitacao) REFERENCES solicitacao(idSolicitacao)
);

CREATE TABLE produto (
    codIdProduto INT,
    nomeProduto VARCHAR(10) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    margemLucroMin NUMBER NOT NULL,
    codIdFilialProduto INT NOT NULL,
    idMarcaProduto VARCHAR (12) NOT NULL,   
    idCategoriaProduto VARCHAR (12) NOT NULL,  
    PRIMARY KEY (codIdProduto),
    FOREIGN KEY (codIdFilialProduto) REFERENCES filial(codIdFilial),
    FOREIGN KEY (idMarcaProduto) REFERENCES marca (idMarca), 
    FOREIGN KEY (idCategoriaProduto) REFERENCES categoria (idCategoria) 
);

CREATE TABLE item (
    idItem INT,
    quantidadeItens INT NOT NULL,
    preco FLOAT NOT NULL,
    desconto NUMBER,
    numOrdemDeCompraItem INT NOT NULL,
    numNotaFiscalItem INT NOT NULL,
    codIdProdutoItem INT NOT NULL,    
    PRIMARY KEY (idItem),
    FOREIGN KEY (numOrdemDeCompraItem) REFERENCES ordemDeCompra(numOrdemDeCompra),
    FOREIGN KEY (numNotaFiscalItem) REFERENCES notafiscal (numNotaFiscal), 
    FOREIGN KEY (codIdProdutoItem) REFERENCES produto (codIdProduto) 
);

ALTER TABLE funcionario ADD idFilial INT;
ALTER TABLE funcionario ADD CONSTRAINT refFilial FOREIGN KEY (idFilial) REFERENCES filial(codIdFilial);


/*DELEÇÃO DAS TABELAS*/    

DROP TABLE funcionario CASCADE CONSTRAINT;
DROP TABLE filial CASCADE CONSTRAINT;
DROP TABLE cliente CASCADE CONSTRAINT;
DROP TABLE dependente;
DROP TABLE realizaReclamacao;
DROP TABLE telefoneFuncionario;
DROP TABLE marca CASCADE CONSTRAINT;
DROP TABLE categoria CASCADE CONSTRAINT;
DROP TABLE caixa CASCADE CONSTRAINT;
DROP TABLE equipamento CASCADE CONSTRAINT;
DROP TABLE realizaManutencao;
DROP TABLE telefoneCliente;
DROP TABLE fornecedor CASCADE CONSTRAINT;
DROP TABLE telefoneFornecedor;
DROP TABLE ordemDeCompra CASCADE CONSTRAINT;
DROP TABLE solicitacao CASCADE CONSTRAINT;
DROP TABLE notafiscal CASCADE CONSTRAINT;
DROP TABLE produto CASCADE CONSTRAINT;
DROP TABLE item;
