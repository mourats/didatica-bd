CREATE TABLE Filial (
    codigo_identificacao INT,
    nome VARCHAR(256),
    endereco VARCHAR(256),
    telefone VARCHAR(20)
);

CREATE TABLE Cliente (
    cpf CHAR(11),
    nome VARCHAR(256),
    email VARCHAR(256),
    pontos_crm INT,
    rua VARCHAR(256),
    numero INT,
    cidade VARCHAR(256),
    estado VARCHAR(256),
    bairro VARCHAR(256)
);

CREATE TABLE Reclamacao (
    dataHora DATE,
    descricao VARCHAR(256),
    codigo_filial INT,
    cpf_cliente CHAR(11)
);

CREATE TABLE Telefones_Cliente (
    telefone VARCHAR(20),
    cpf_cliente CHAR(11)
);

CREATE TABLE Funcionario (
    matricula INT,
    supervisor INT,
    codigo_filial INT,
    cpf CHAR(11) UNIQUE,
    identidade VARCHAR(14),
    nome VARCHAR(256),
    endereco VARCHAR(256),
    salario NUMERIC(10,2),
    funcao VARCHAR(100)
);

CREATE TABLE Manutencao (
    id_equipamento INT,
    numero_caixa INT,
    matricula_funcionario INT,
    dataHora DATE,
    custo NUMERIC(8,2)
);

CREATE TABLE Telefones_Funcionario (
    telefone VARCHAR(20),
    matricula INT
);

CREATE TABLE Dependente (
    cpf CHAR(11),
    matricula_funcionario INT,
    data_nascimento DATE,
    nome VARCHAR(256)
);

CREATE TABLE Caixa (
    numero_caixa INT,
    codigo_filial INT
);

CREATE TABLE Equipamento (
    id INT,
    descricao VARCHAR(256),
    numero_caixa INT
);

CREATE TABLE Fornecedor (
    cnpj CHAR(14),
    id_categoria INT,
    nome VARCHAR(256),
    endereco VARCHAR(256),
    email VARCHAR(256),
    site_forn VARCHAR(70)
);

CREATE TABLE Telefones_Fornecedor (
    telefone VARCHAR(20),
    cnpj CHAR(14)
);

CREATE TABLE Categoria (
    id INT,
    nome VARCHAR(256)
);

CREATE TABLE Solicitacao (
    id INT,
    codigo_filial INT,
    cnpj_fornecedor CHAR(14),
    numero_nota_fiscal INT,
    data_solicitacao DATE,
    data_prev_entrega DATE,
    data_entrega DATE,
    valor_compra NUMERIC(8,2),
    prazo_pag_dias INT
);

CREATE TABLE NotaFiscal (
    numero INT,
    cnpj CHAR(14),
    quantidade INT,
    data_nota_fiscal DATE,
    valor_por_item NUMERIC(8,2)
);

CREATE TABLE Produto (
    id INT,
    id_marca INT,
    id_categoria INT,
    codigo_filial INT,
    nome VARCHAR(256),
    descricao VARCHAR(100),
    margem_lucro NUMERIC(8,2)
);

CREATE TABLE Marca (
    id INT,
    nome VARCHAR(256)
);

CREATE TABLE OrdemDeCompra (
    numero_nota_fiscal INT,
    matricula_funcionario INT,
    cpf_cliente CHAR(11),
    codigo_filial INT,
    numero_caixa INT,
    data_hora DATE
);

CREATE TABLE Item (
    id INT,
    id_produto INT,
    numero_nota_fiscal INT,
    quantidade INT,
    preco NUMERIC(8,2),
    desconto NUMERIC(8,2)
);

-- Adicionando chaves primárias nas tabelas

ALTER TABLE Filial
ADD CONSTRAINT PK_Filial
    PRIMARY KEY (codigo_identificacao);

ALTER TABLE Cliente
ADD CONSTRAINT PK_Cliente
    PRIMARY KEY (cpf);

ALTER TABLE Telefones_Cliente
ADD CONSTRAINT PK_Telefones_Cliente
    PRIMARY KEY (cpf_cliente, telefone);

ALTER TABLE Funcionario
ADD CONSTRAINT PK_Funcionario
    PRIMARY KEY (matricula);

ALTER TABLE Telefones_Funcionario
ADD CONSTRAINT PK_Telefones_Funcionario
    PRIMARY KEY (matricula, telefone);

ALTER TABLE Dependente
ADD CONSTRAINT PK_Dependente
    PRIMARY KEY (cpf, matricula_funcionario);

ALTER TABLE Caixa
ADD CONSTRAINT PK_Caixa
    PRIMARY KEY (numero_caixa);

ALTER TABLE Equipamento
ADD CONSTRAINT PK_Equipamento
    PRIMARY KEY (id, numero_caixa);

ALTER TABLE Fornecedor
ADD CONSTRAINT PK_Fornecedor
    PRIMARY KEY (cnpj);

ALTER TABLE Telefones_Fornecedor
ADD CONSTRAINT PK_Telefones_Fornecedor
    PRIMARY KEY (cnpj, telefone);

ALTER TABLE Categoria
ADD CONSTRAINT PK_Categoria
    PRIMARY KEY (id);

ALTER TABLE Solicitacao
ADD CONSTRAINT PK_Solicitacao
    PRIMARY KEY (id);

ALTER TABLE NotaFiscal
ADD CONSTRAINT PK_NotaFiscal
    PRIMARY KEY (numero);

ALTER TABLE Produto
ADD CONSTRAINT PK_Produto
    PRIMARY KEY (id);

ALTER TABLE Marca
ADD CONSTRAINT PK_Marca
    PRIMARY KEY (id);

ALTER TABLE OrdemDeCompra
ADD CONSTRAINT PK_OrdemDeCompra
    PRIMARY KEY (numero_nota_fiscal);

ALTER TABLE Item
ADD CONSTRAINT PK_Item
    PRIMARY KEY (id, numero_nota_fiscal);

ALTER TABLE Reclamacao
ADD CONSTRAINT PK_Reclamacao
    PRIMARY KEY (codigo_filial, cpf_cliente);

ALTER TABLE Manutencao
ADD CONSTRAINT PK_Manutencao
    PRIMARY KEY (id_equipamento, numero_caixa, matricula_funcionario);

-- Adicionando chaves estrangeiras

ALTER TABLE Telefones_Cliente
    ADD CONSTRAINT FK_TelefonesClientes FOREIGN KEY (cpf_cliente)
    REFERENCES Cliente(cpf);

ALTER TABLE Telefones_Funcionario
    ADD CONSTRAINT FK_TelefonesFuncionarios FOREIGN KEY (matricula)
    REFERENCES Funcionario(matricula);

ALTER TABLE Telefones_Fornecedor
    ADD CONSTRAINT FK_TelefonesFornecedores FOREIGN KEY (cnpj)
    REFERENCES Fornecedor(cnpj);

ALTER TABLE Funcionario
    ADD CONSTRAINT FK_FuncionarioFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);
ALTER TABLE Funcionario
    ADD CONSTRAINT FK_FuncionarioSuper FOREIGN KEY (supervisor)
    REFERENCES Funcionario(matricula);

ALTER TABLE Dependente
    ADD CONSTRAINT FK_DependentesFuncionario FOREIGN KEY (matricula_funcionario)
    REFERENCES Funcionario(matricula);

ALTER TABLE Equipamento
    ADD CONSTRAINT FK_EquipamentoCaixa FOREIGN KEY (numero_caixa)
    REFERENCES Caixa(numero_caixa);

ALTER TABLE OrdemDeCompra
    ADD CONSTRAINT FK_OrdemCompraNota FOREIGN KEY (numero_nota_fiscal)
    REFERENCES NotaFiscal(numero);
ALTER TABLE OrdemDeCompra
    ADD CONSTRAINT FK_OrdemCompraCaixa FOREIGN KEY (numero_caixa)
    REFERENCES Caixa(numero_caixa);
ALTER TABLE OrdemDeCompra
    ADD CONSTRAINT FK_OrdemCompraCliente FOREIGN KEY (cpf_cliente)
    REFERENCES Cliente(cpf);
ALTER TABLE OrdemDeCompra
    ADD CONSTRAINT FK_OrdemCompraFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);
ALTER TABLE OrdemDeCompra
    ADD CONSTRAINT FK_OrdemCompraFuncionario FOREIGN KEY (matricula_funcionario)
    REFERENCES Funcionario(matricula);

ALTER TABLE Produto
    ADD CONSTRAINT FK_ProdutoFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);
ALTER TABLE Produto
    ADD CONSTRAINT FK_ProdutoMarca FOREIGN KEY (id_marca)
    REFERENCES Marca(id);
ALTER TABLE Produto
    ADD CONSTRAINT FK_ProdutoCategoria FOREIGN KEY (id_categoria)
    REFERENCES Categoria(id);

ALTER TABLE Item
    ADD CONSTRAINT FK_ItemCompra FOREIGN KEY (numero_nota_fiscal)
    REFERENCES OrdemDeCompra(numero_nota_fiscal);
ALTER TABLE Item
    ADD CONSTRAINT FK_ItemProduto FOREIGN KEY (id_produto)
    REFERENCES Produto(id);

ALTER TABLE NotaFiscal
    ADD CONSTRAINT FK_NotaFiscal FOREIGN KEY (cnpj)
    REFERENCES Fornecedor(cnpj);

ALTER TABLE Solicitacao
    ADD CONSTRAINT FK_SolicitacaoNota FOREIGN KEY (numero_nota_fiscal)
    REFERENCES NotaFiscal(numero);
ALTER TABLE Solicitacao
    ADD CONSTRAINT FK_SolicitacaoFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);
ALTER TABLE Solicitacao
    ADD CONSTRAINT FK_SolicitacaoFornecedor FOREIGN KEY (cnpj_fornecedor)
    REFERENCES Fornecedor(cnpj);

ALTER TABLE Caixa
    ADD CONSTRAINT FK_CaixaFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);

ALTER TABLE Fornecedor
    ADD CONSTRAINT FK_FornecedorCategoria FOREIGN KEY (id_categoria)
    REFERENCES Categoria(id);

ALTER TABLE Reclamacao
    ADD CONSTRAINT FK_ReclamacaoFilial FOREIGN KEY (codigo_filial)
    REFERENCES Filial(codigo_identificacao);
ALTER TABLE Reclamacao
    ADD CONSTRAINT FK_ReclamacaoCliente FOREIGN KEY (cpf_cliente)
    REFERENCES Cliente(cpf);

ALTER TABLE Manutencao
    ADD CONSTRAINT FK_ManutencaoEquipamento FOREIGN KEY (id_equipamento, numero_caixa)
    REFERENCES Equipamento(id, numero_caixa);
ALTER TABLE Manutencao
    ADD CONSTRAINT FK_ManutencaoFuncionario FOREIGN KEY (matricula_funcionario)
    REFERENCES Funcionario(matricula);