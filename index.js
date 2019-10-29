const fs = require("fs");

const insert = {
  cliente:
    "INSERT INTO CLIENTE (CPF, NOME, EMAIL, PONTOS_CRM, RUA, NUM, CIDADE, ESTADO, BAIRRO) VALUES",
  telefoneCliente:
    "INSERT INTO TELEFONE_CLIENTE (CPF_CLIENTE, TELEFONE) VALUES",
  funcionario:
    "INSERT INTO FUNCIONARIO (MATRICULA, CPF, IDENTIDADE, NOME, ENDERECO, SALARIO, FUNCAO, MATRICULA_SUPERVISOR) VALUES",
  telefoneFuncionario:
    "INSERT INTO TELEFONE_FUNCIONARIO (MATRICULA, TELEFONE) VALUES",
  dependente:
    "INSERT INTO DEPENDENTE (CPF, DATA_NASC, NOME, MATRICULA_FUNCIONARIO) VALUES",
  filial:
    "INSERT INTO FILIAL (CODIGO_IDENTIFICACAO, NOME, ENDERECO, TELEFONE) VALUES",
  marca: "INSERT INTO MARCA (IDENTIFICADOR, NOME) VALUES",
  categoria: "INSERT INTO CATEGORIA (IDENTIFICADOR, NOME) VALUES",
  produto:
    "INSERT INTO PRODUTO (CODIGO_IDENTIFICACAO, NOME, DESCRICAO, MARGEM_LUCRO, CODIGO_FILIAL, QUANTIDADE, PRECO_COMPRA, PRECO_VENDA, DATA_COMPRA, DATA_VALIDADE, ID_MARCA, ID_CATEGORIA) VALUES",
  caixa: "INSERT INTO CAIXA (NUMERO_CAIXA, CODIGO_FILIAL) VALUES",
  equipamento:
    "INSERT INTO EQUIPAMENTO (IDENTIFICADOR, DESCRICAO, NUMERO_CAIXA) VALUES",
  realizaManutencao:
    "INSERT INTO REALIZA_MANUTENCAO (ID_MANUTENCAO, IDENTIFICADOR_EQUIPAMENTO, NUMERO_CAIXA, MATRICULA_FUNCIONARIO, DATA_HORA, CUSTO) VALUES",
  fornecedor:
    "INSERT INTO FORNECEDOR (CNPJ, NOME, ENDERECO, EMAIL, ID_CATEGORIA) VALUES",
  solicitacao:
    "INSERT INTO SOLICITACAO (IDENTIFICADOR, DATA_SOLICITACAO, DATA_PREVISTA, DATA_ENTREGA, VALOR_COMPRA, PRAZO_PAGAMENTO, CODIGO_FILIAL, CNPJ_FORNECEDOR) VALUES",
  notaFiscal:
    "INSERT INTO NOTA_FISCAL (NUMERO, CNPJ, QUANTIDADE, DATA, VALOR_POR_ITEM, IDENTIFICADOR_SOLICITACAO) VALUES",
  telefoneFornecedor: "INSERT INTO TELEFONE_FORNECEDOR (CNPJ, TELEFONE) VALUES",
  ordemCompra:
    "INSERT INTO ORDEM_COMPRA (NUMERO_NOTA_FISCAL, DATA_HORA, CPF_CLIENTE, CODIGO_FILIAL, MATRICULA_FUNCIONARIO, NUMERO_CAIXA) VALUES",
  item:
    "INSERT INTO ITEM (IDENTIFICADOR, NUM_NOTA_FISCAL_ORDEM, NUMERO_NOTA_FISCAL, QUANTIDADE, PRECO_PRODUTO, DESCONTO) VALUES",
  realizaReclamacao:
    "INSERT INTO REALIZA_MANUTENCAO (ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE) VALUES"
};

let primaryKeys = {};

const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const getElement = array => {
  return array[getRandomInt(0, array.length - 1)];
};

const getRandomCpf = () => {
  return (
    "" +
    getRandomInt(100, 999) +
    "." +
    getRandomInt(100, 999) +
    "." +
    getRandomInt(100, 999) +
    "-" +
    getRandomInt(10, 99)
  );
};

const getRandomTelefone = () => {
  return `(${getRandomInt(10, 99)}) ${getRandomInt(
    90000,
    99999
  )}-${getRandomInt(1000, 9999)}`;
};

const getRandomDate = () => {
  return `TO_DATE('0${getRandomInt(1, 9)}/0${getRandomInt(1, 9)}/${getRandomInt(
    1910,
    2019
  )}','DD/MM/YYYY')`;
};

const clientes = () => {
  let clientes = "\n\n----- CLIENTE -----\n\n";

  primaryKeys.clientes = [];

  for (let idx = 0; idx < 20; idx++) {
    const cpf = getRandomCpf();
    primaryKeys.clientes.push(cpf);

    clientes += `${
      insert.cliente
    } ('${cpf}', 'Cliente 0${idx}', 'cliente0${idx}@gmail.com', ${getRandomInt(
      0,
      2000
    )}, 'Rua ${getRandomInt(10, 100)}', 'Num ${getRandomInt(
      10,
      1000
    )}', 'Cidade ${getRandomInt(10, 100)}', 'Estado ${getRandomInt(
      10,
      100
    )}', 'Bairro ${getRandomInt(10, 100)}');\n`;
  }

  return clientes;
};

const telefonesClientes = () => {
  let telefonesClientes = "\n\n----- TELEFONE_CLIENTE -----\n\n";

  for (let idx = 0; idx < 50; idx++) {
    telefonesClientes += `${insert.telefoneCliente} ('${getElement(
      primaryKeys.clientes
    )}', '${getRandomTelefone()}');\n`;
  }

  return telefonesClientes;
};

const funcionarios = () => {
  const funcao = [
    "Caixa",
    "Empacotador",
    "Açougueiro",
    "Padeiro",
    "Limpeza",
    "Segurança"
  ];

  let funcionarios = "\n\n----- FUNCIONARIO -----\n\n";

  primaryKeys.funcionarios = [];

  for (let idx = 0; idx < 15; idx++) {
    primaryKeys.funcionarios.push(idx);

    funcionarios += `${
      insert.funcionario
    } (${idx}, '${getRandomCpf()}', '${getRandomInt(
      100000,
      900000
    )}', 'Funcionario 0${idx}', 'Rua ${getRandomInt(10, 100)}', ${getRandomInt(
      1000,
      10000
    )}, '${getElement(funcao)}', ${
      idx ? getElement(primaryKeys.funcionarios) : null
    });\n`;
  }

  return funcionarios;
};

const telefonesFuncionarios = () => {
  let telefonesFuncionarios = "\n\n----- TELEFONE_FUNCIONARIO -----\n\n";

  for (let idx = 0; idx < 30; idx++) {
    telefonesFuncionarios += `${insert.telefoneFuncionario} (${getElement(
      primaryKeys.funcionarios
    )}, '${getRandomTelefone()}');\n`;
  }

  return telefonesFuncionarios;
};

const dependentes = () => {
  let dependentes = "\n\n----- DEPENDENTE ------\n\n";

  for (let idx = 0; idx < 40; idx++) {
    dependentes += `${
      insert.dependente
    } ('${getRandomCpf()}', ${getRandomDate()}, 'dependente 0${idx}', ${getElement(
      primaryKeys.funcionarios
    )});\n`;
  }

  return dependentes;
};

const filiais = () => {
  let filiais = "\n\n----- FILIAL ------\n\n";

  primaryKeys.filiais = [];

  for (let idx = 0; idx < 15; idx++) {
    primaryKeys.filiais.push(idx);

    filiais += `${insert.filial} (${idx}, 'Filial ${idx}', 'Rua ${getRandomInt(
      10,
      100
    )}', '${getRandomTelefone()}');\n`;
  }

  return filiais;
};

const marcas = () => {
  let marcas = "\n\n----- MARCA ------\n\n";

  primaryKeys.marcas = [];

  for (let idx = 0; idx < 25; idx++) {
    primaryKeys.marcas.push(idx);

    marcas += `${insert.marca} (${idx}, 'Marca ${idx}');\n`;
  }

  return marcas;
};

const categorias = () => {
  let categorias = "\n\n----- CATEGORIA ------\n\n";

  primaryKeys.categorias = [];

  for (let idx = 0; idx < 20; idx++) {
    primaryKeys.categorias.push(idx);

    categorias += `${insert.categoria} (${idx}, 'Categoria ${idx}');\n`;
  }

  return categorias;
};

const generateInserts = () => {
  save(
    clientes() +
      telefonesClientes() +
      funcionarios() +
      telefonesFuncionarios() +
      dependentes() +
      filiais() +
      marcas() +
      categorias()
  );
};

save = string => {
  fs.unlink("inserts.sql", function(err) {
    if (err) {
    }
    console.log("File deleted!");
  });

  fs.appendFile("inserts.sql", string, function(err) {
    if (err) {
      return console.log(err);
    }
    console.log("inserts.sql" + " was saved!");
  });
};

generateInserts();
