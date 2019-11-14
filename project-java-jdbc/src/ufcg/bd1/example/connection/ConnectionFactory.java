package ufcg.bd1.example.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
	public Connection getConnection() {
		try {
			System.out.println("Created BD Connection....\n");
			return DriverManager.getConnection("jdbc:mysql://localhost/STUDYBD", "thiago", "123456");
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}