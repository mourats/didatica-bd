const fs = require("fs");

const insert = {
  cliente:
    "INSERT INTO CLIENTE (CPF, NOME, EMAIL, PONTOS_CRM, RUA, NUM, CIDADE, ESTADO, BAIRRO) VALUES",
  telefoneCliente:
    "INSERT INTO TELEFONE_CLIENTE (CPF_CLIENTE, TELEFONE) VALUES",
  funcionario:
    "INSERT INTO FUNCIONARIO (MATRICULA, CPF, IDENTIDADE, NOME, ENDERECO, SALARIO, FUNCAO, MATRICULA_SUPERVISOR, CODIGO_FILIAL) VALUES",
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
    "INSERT INTO REALIZA_RECLAMACAO (ID_RECLAMACAO, DATA_HORA, DESCRICAO, CODIGO_FILIAL, CPF_CLIENTE) VALUES"
};

let primaryKeys = {};
const QUANTIDADE_FILIAL = 10;

const getRandomInt = (min, max) => {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const getElement = array => {
  return array[getRandomInt(0, array.length - 1)];
};

const getValue = value => {
  return value < 10 ? "0" + value : value;
};

const getRandomCnpj = () => {
  return (
    "" +
    getValue(getRandomInt(0, 99)) +
    "." +
    getRandomInt(100, 999) +
    "." +
    getRandomInt(100, 999) +
    "/0001-" +
    getRandomInt(10, 99)
  );
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
  return `TO_DATE('${getValue(getRandomInt(1, 28))}/${getValue(
    getRandomInt(1, 12)
  )}/${getRandomInt(1910, 2019)}','DD/MM/YYYY')`;
};

const getRandomTimestamp = () => {
  return `TO_TIMESTAMP('${getRandomInt(2000, 2019)}-${getValue(
    getRandomInt(1, 12)
  )}-${getValue(getRandomInt(1, 28))} ${getValue(
    getRandomInt(0, 23)
  )}:${getValue(getRandomInt(0, 59))}:${getValue(
    getRandomInt(0, 59)
  )}', 'YYYY-MM-DD HH24:MI:SS')`;
};
const cliente = () => {
  let cliente = "\n\n------ CLIENTE ------\n\n";

  primaryKeys.cliente = [];

  for (let idx = 0; idx < 200; idx++) {
    const cpf = getRandomCpf();
    primaryKeys.cliente.push(cpf);

    cliente += `${
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

  return cliente;
};

const telefoneCliente = () => {
  let telefoneCliente = "\n\n------ TELEFONE_CLIENTE ------\n\n";

  for (let idx = 0; idx < 200; idx++) {
    telefoneCliente += `${insert.telefoneCliente} ('${getElement(
      primaryKeys.cliente
    )}', '${getRandomTelefone()}');\n`;
  }

  return telefoneCliente;
};

const funcionario = () => {
  const funcao = [
    "Caixa",
    "Empacotador",
    "Açougueiro",
    "Padeiro",
    "Limpeza",
    "Segurança"
  ];

  let funcionario = "\n\n------ FUNCIONARIO ------\n\n";

  primaryKeys.funcionario = [];

  for (let idx = 0; idx < 150; idx++) {
    primaryKeys.funcionario.push(idx);

    funcionario += `${
      insert.funcionario
    } (${idx}, '${getRandomCpf()}', '${getRandomInt(
      100000,
      900000
    )}', 'Funcionario 0${idx}', 'Rua ${getRandomInt(10, 100)}', ${getRandomInt(
      1000,
      10000
    )}, '${getElement(funcao)}', ${
      idx ? getElement(primaryKeys.funcionario) : null
    }, null);\n`;
  }

  return funcionario;
};

const telefoneFuncionario = () => {
  let telefoneFuncionario = "\n\n------ TELEFONE_FUNCIONARIO ------\n\n";

  for (let idx = 0; idx < 100; idx++) {
    telefoneFuncionario += `${insert.telefoneFuncionario} (${getElement(
      primaryKeys.funcionario
    )}, '${getRandomTelefone()}');\n`;
  }

  return telefoneFuncionario;
};

const dependente = () => {
  let dependente = "\n\n------ DEPENDENTE ------\n\n";

  for (let idx = 0; idx < 80; idx++) {
    dependente += `${
      insert.dependente
    } ('${getRandomCpf()}', ${getRandomDate()}, 'Dependente 0${idx}', ${getElement(
      primaryKeys.funcionario
    )});\n`;
  }

  return dependente;
};

const filial = () => {
  let filial = "\n\n------ FILIAL ------\n\n";

  primaryKeys.filial = [];

  for (let idx = 0; idx < QUANTIDADE_FILIAL; idx++) {
    primaryKeys.filial.push(idx);

    filial += `${insert.filial} (${idx}, 'Filial ${idx}', 'Rua ${getRandomInt(
      10,
      100
    )}', '${getRandomTelefone()}');\n`;
  }

  return filial;
};

const marca = () => {
  let marca = "\n\n------ MARCA ------\n\n";

  primaryKeys.marca = [];

  for (let idx = 0; idx < 25; idx++) {
    primaryKeys.marca.push(idx);

    marca += `${insert.marca} (${idx}, 'Marca ${idx}');\n`;
  }

  return marca;
};

const categoria = () => {
  let categoria = "\n\n------ CATEGORIA ------\n\n";

  primaryKeys.categoria = [];

  for (let idx = 0; idx < 30; idx++) {
    primaryKeys.categoria.push(idx);

    categoria += `${insert.categoria} (${idx}, 'Categoria ${idx}');\n`;
  }

  return categoria;
};

const produto = () => {
  let produto = "\n\n------ PRODUTO ------\n\n";

  primaryKeys.produto = [];

  for (let idx = 0; idx < 300; idx++) {
    primaryKeys.produto.push(idx);

    produto += `${
      insert.produto
    } (${idx}, 'Produto 0${idx}', 'Descrição do Produto 0${idx}', '${getRandomInt(
      1,
      9999
    )}', ${getElement(primaryKeys.filial)}, ${getRandomInt(
      1,
      1000
    )}, ${getRandomInt(1, 30)}, ${getRandomInt(
      30,
      100
    )}, ${getRandomDate()}, ${getRandomDate()}, ${getElement(
      primaryKeys.marca
    )}, ${getElement(primaryKeys.categoria)});\n`;
  }

  return produto;
};

const caixa = () => {
  let caixa = "\n\n------ CAIXA ------\n\n";

  primaryKeys.caixa = [];

  for (let idx = 0; idx < 10; idx++) {
    primaryKeys.caixa.push(idx);

    caixa += `${insert.caixa} (${idx}, ${getElement(primaryKeys.filial)});\n`;
  }

  return caixa;
};

const equipamento = () => {
  let equipamento = "\n\n------ EQUIPAMENTO ------\n\n";

  primaryKeys.equipamento = [];

  for (let idx = 0; idx < 20; idx++) {
    const obj = {
      identificador: idx,
      numero_caixa: getElement(primaryKeys.caixa)
    };
    primaryKeys.equipamento.push(obj);

    equipamento += `${insert.equipamento} (${idx}, 'Descrição do Equipamento ${obj.identificador}', ${obj.numero_caixa});\n`;
  }

  return equipamento;
};

const realizaManutencao = () => {
  let realizaManutencao = "\n\n------ REALIZA_MANUTENCAO ------\n\n";

  primaryKeys.realizaManutencao = [];

  for (let idx = 0; idx < 30; idx++) {
    primaryKeys.realizaManutencao.push(idx);
    const objEquipamento = getElement(primaryKeys.equipamento);
    realizaManutencao += `${insert.realizaManutencao} (${idx}, ${
      objEquipamento.identificador
    }, ${objEquipamento.numero_caixa}, ${getElement(
      primaryKeys.funcionario
    )}, ${getRandomTimestamp()}, ${getRandomInt(10, 200)});\n`;
  }

  return realizaManutencao;
};

const fornecedor = () => {
  let fornecedor = "\n\n------ FORNECEDOR ------\n\n";

  primaryKeys.fornecedor = [];

  for (let idx = 0; idx < 20; idx++) {
    const cnpj = getRandomCnpj();
    primaryKeys.fornecedor.push(cnpj);

    fornecedor += `${
      insert.fornecedor
    } ('${cnpj}', 'Fornecedor ${idx}', 'Rua 0${idx}', 'fornecedor${idx}@gmail.com', ${getElement(
      primaryKeys.categoria
    )});\n`;
  }

  return fornecedor;
};

let cnpjSolicitacao = [];

const solicitacao = () => {
  let solicitacao = "\n\n------ SOLICITACAO ------\n\n";

  primaryKeys.solicitacao = [];

  for (let idx = 0; idx < 80; idx++) {
    primaryKeys.solicitacao.push(idx);
    const cnpjFornecedor = getElement(primaryKeys.fornecedor);
    cnpjSolicitacao.push(cnpjFornecedor);

    solicitacao += `${
      insert.solicitacao
    } (${idx}, ${getRandomDate()}, ${getRandomDate()}, ${getRandomDate()}, ${getRandomInt(
      1000,
      10000
    )}, ${getRandomDate()}, ${getElement(
      primaryKeys.filial
    )}, '${cnpjFornecedor}');\n`;
  }

  return solicitacao;
};

const notaFiscal = () => {
  let notaFiscal = "\n\n------ NOTA_FISCAL ------\n\n";

  cnpjSolicitacao = cnpjSolicitacao.reverse();

  primaryKeys.notaFiscal = [];

  for (let idx = 0; idx < 80; idx++) {
    primaryKeys.notaFiscal.push(idx);

    notaFiscal += `${
      insert.notaFiscal
    } (${idx}, '${cnpjSolicitacao.pop()}', ${getRandomInt(
      10,
      1000
    )}, ${getRandomDate()}, ${getRandomInt(10, 100)}, ${idx});\n`;
  }

  return notaFiscal;
};

const telefoneFornecedor = () => {
  let telefoneFornecedor = "\n\n------ TELEFONE_FORNECEDOR ------\n\n";

  for (let idx = 0; idx < 20; idx++) {
    telefoneFornecedor += `${insert.telefoneFornecedor} ('${getElement(
      primaryKeys.fornecedor
    )}', '${getRandomTelefone()}');\n`;
  }

  return telefoneFornecedor;
};

const ordemCompra = () => {
  let ordemCompra = "\n\n------ ORDEM_COMPRA ------\n\n";

  primaryKeys.ordemCompra = [];

  for (let idx = 0; idx < 200; idx++) {
    primaryKeys.ordemCompra.push(idx);

    ordemCompra += `${
      insert.ordemCompra
    } (${idx}, ${getRandomTimestamp()}, '${getElement(
      primaryKeys.cliente
    )}', ${getElement(primaryKeys.filial)}, ${getElement(
      primaryKeys.funcionario
    )}, ${getElement(primaryKeys.caixa)});\n`;
  }

  return ordemCompra;
};

const item = () => {
  let item = "\n\n------ ITEM ------\n\n";

  primaryKeys.item = [];

  for (let idx = 0; idx < 300; idx++) {
    primaryKeys.item.push(idx);

    item += `${insert.item} (${idx}, ${getElement(
      primaryKeys.ordemCompra
    )}, ${getElement(primaryKeys.notaFiscal)}, ${getRandomInt(
      1,
      100
    )}, ${getRandomInt(1, 100)}.${getValue(getRandomInt(1, 99))}, 0.${getValue(
      getRandomInt(0, 20)
    )});\n`;
  }

  return item;
};

const realizaReclamacao = () => {
  let realizaReclamacao = "\n\n------ REALIZA_RECLAMACAO ------\n\n";

  primaryKeys.realizaReclamacao = [];

  for (let idx = 0; idx < 30; idx++) {
    primaryKeys.realizaReclamacao.push(idx);

    realizaReclamacao += `${
      insert.realizaReclamacao
    } (${idx}, ${getRandomTimestamp()}, 'Descrição da Reclamação ${idx}', ${getElement(
      primaryKeys.filial
    )}, '${getElement(primaryKeys.cliente)}');\n`;
  }

  return realizaReclamacao;
};

const updateFuncionario = () => {

  let funcionario = "\n\n------ UPDATE FUNCIONARIO ------\n\n";

  for (let idx = 0; idx < primaryKeys.funcionario.length; idx++) {

    funcionario += `UPDATE FUNCIONARIO SET CODIGO_FILIAL = ${getElement(primaryKeys.filial)} WHERE MATRICULA = ${idx};\n`;
  }
  return funcionario;
};

const generateInserts = () => {
  save(
    cliente() +
      telefoneCliente() +
      funcionario() +
      telefoneFuncionario() +
      dependente() +
      filial() +
      marca() +
      categoria() +
      produto() +
      caixa() +
      equipamento() +
      realizaManutencao() +
      fornecedor() +
      solicitacao() +
      notaFiscal() +
      telefoneFornecedor() +
      ordemCompra() +
      item() +
      realizaReclamacao() +
      updateFuncionario()
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
