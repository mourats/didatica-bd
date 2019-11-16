package ufcg.bd1.example;

import java.util.Scanner;

import ufcg.bd1.example.controller.Controller;
import ufcg.bd1.example.util.Menu;

public class Main {

	private static Scanner sc;
	final static String NL = System.lineSeparator();

	public static void main(String[] args) {

		sc = new Scanner(System.in);
		Menu menu = new Menu();
		Controller controller = new Controller();
		String op;
		do {
			System.out.println(menu.toString());
			op = sc.nextLine().toUpperCase();
			String nome;
			switch (op) {
			case "I":
				nome = lerNome();
				String sobrenome = lerSobrenome();
				String email = lerEmail();
				controller.inserirEstudante(nome, sobrenome, email);
				break;
			
			case "A":
				Integer id = lerId();
				nome = lerNome();
			    controller.updateEstudante(id, nome);
			    System.out.println("Empregado atualizado com sucesso!" + NL);
				break;
				
			case "L":
				controller.listarEstudantes();
				break;
				
			case "S":
				break;

			default:
				opcaoInvalida(menu);
				break;
			}
		} while (!op.equals("S"));

		sc.close();

	}
	
	private static Integer lerId() {
		System.out.print("ID: ");
		String str = sc.nextLine();
		Integer matricula = Integer.parseInt(str);
		return matricula;
	}

	private static String lerEmail() {
		System.out.print("Email: ");
		String email = sc.nextLine();
		return email;
	}

	private static String lerSobrenome() {
		System.out.print("Sobrenome: ");
		String sobrenome = sc.nextLine();
		return sobrenome;
	}

	private static String lerNome() {
		System.out.print("Nome: ");
		String nome = sc.nextLine();
		return nome;
	}

	private static void opcaoInvalida(Menu menu) {
		System.out.println("Opção Inválida!" + NL);
		menu.toString();
	}
}
