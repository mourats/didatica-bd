# -*- coding: utf-8 -*-
# Importa os módulos necessários 'MySQLdb'
import MySQLdb, time

# Define endereço do servidor, nome de usuário do bd, senha do usuário do bd e nome da base de dados
servidor = "localhost"
usuario  = "thiago"
senha  = "123456"
banco = "STUDYBD"

# Realiza a conexão com o banco
db = MySQLdb.connect(servidor, usuario, senha, banco)
cursor = db.cursor() # seta o cursor para a conexão

# Função que executa os comandos SQL no banco
def Executa_SQL(pSQL):
  try:
    cursor.execute(pSQL)
    db.commit()
  except:
    print("Erro: Não foi possível executar o SQL")
    db.rollback()

# Função que executa comandos SQL (Select)
def Busca_SQL(pSQL):
  try:
    cursor.execute(pSQL)
    results = cursor.fetchall()
    return results
  except:
    print("Erro: Não foi possível buscar os dados")
    return 0


# Cria uma variavel com o SQL e chama a função passando como parametro o SQL
vSQL = "CREATE TABLE IF NOT EXISTS USUARIO (NOME VARCHAR(50) NOT NULL, LOGIN VARCHAR(20), SENHA VARCHAR(20) )"
Executa_SQL(vSQL)

Executa_SQL("INSERT INTO USUARIO(NOME, LOGIN, SENHA) VALUES ('Kelvin S do Prado', 'Kelvin', 'Kelvin')")

# Chama a função Busca_SQL passando o comando SQL como parâmetro
vResultado = Busca_SQL("SELECT * FROM USUARIO WHERE LOGIN = 'Kelvin'")
for row in vResultado:
  # Lê cada coluna de cada linha retornada do SELECT, começando pela coluna 0
  vNome  = row[0]
  vLogin = row[1]
  vSenha = row[2]
  print("Nome : " + vNome)
  print("Sobrenome : " + vLogin)
  print("Senha : " + vSenha+"\n")

Executa_SQL("UPDATE USUARIO SET NOME = 'Outro'")

# Chama a função Busca_SQL passando o comando SQL como parâmetro
vResultado = Busca_SQL("SELECT * FROM USUARIO WHERE LOGIN = 'Kelvin'")
for row in vResultado:
  vNome  = row[0]
  vLogin = row[1]
  vSenha = row[2]
  print("Nome : " + vNome)
  print("Sobrenome : " + vLogin)
  print("Senha : " + vSenha)

Executa_SQL("DELETE FROM USUARIO WHERE LOGIN = 'Kelvin'")

# Fecha a conexão com o banco de dados
db.close()

time.sleep(3)
