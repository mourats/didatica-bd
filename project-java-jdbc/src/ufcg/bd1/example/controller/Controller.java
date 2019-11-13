package ufcg.bd1.example.controller;

import java.sql.Connection;
import java.sql.SQLException;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import ufcg.bd1.example.connection.ConnectionFactory;

public class Controller {

	private Connection connection;
	final static String NL = System.lineSeparator();

	public Controller() {
		this.connection = new ConnectionFactory().getConnection();
	}

	public String criarTabelaEmpregado() {
		String sql = "CREATE OR REPLACE TABLE empregado (matricula int, nome varchar(20), endereco varchar(32), salario float)";
		Statement statement;
		try {
			statement = connection.createStatement();
			statement.execute(sql);
			return "Tabela Funionário criada com sucesso." + NL;
		} catch (SQLException e) {
			return "Error na criação da tabela." + NL;
		}
	}

	public void inserirEmpregado(Integer matricula, String nome, String endereco, Float salario) {

		String empregadoSql = "INSERT INTO empregado (matricula, nome, endereco, salario)" + "VALUES ('" + matricula
				+ "', '" + nome + "', '" + endereco + "', " + salario + ");";
		Statement statement;
		try {
			statement = connection.createStatement();
			statement.executeUpdate(empregadoSql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateEmpregado(Integer matricula, Float salario) {
		PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.prepareStatement("UPDATE empregado SET salario = ? WHERE matricula = ?");
			preparedStatement.setFloat(1, salario);
			preparedStatement.setInt(2, matricula);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public String listarEmpregados() {
		String sql = "SELECT * FROM empregado;";
		String result = "";
		Statement statement;
		try {
			statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				result += "Empregado: " + rs.getString("nome") + NL + "Matrícula: " + rs.getInt("matricula") + NL
						+ "Endereço: " + rs.getString("endereco") + NL + "Salário: " + rs.getFloat("salario") + NL;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if (result.equals(""))
			return "Nenhum empregado encontrado." + NL;
		else
			return result;
	}

	public String exibirEmpregado(Integer matricula) {
		// TODO Auto-generated method stub
		return null;
	}

}
