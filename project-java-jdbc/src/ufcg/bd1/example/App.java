package ufcg.bd1.example;

import java.util.Scanner;

import ufcg.bd1.example.controller.Controller;
import ufcg.bd1.example.util.Menu;

public class App {

	private static Scanner sc;
	final static String NL = System.lineSeparator();

	public static void main(String[] args) {

		sc = new Scanner(System.in);
		Menu menu = new Menu();
		Controller controller = new Controller();
		String op;
		Integer matricula;
		Float salario;

		do {
			System.out.println(menu.toString());
			op = sc.nextLine().toUpperCase();

			switch (op) {
			case "C":
				System.out.println(controller.criarTabelaEmpregado());
				break;
			case "I":
				matricula = lerMatricula();
				String nome = lerNome();
				String endereco = lerEndereco();
				salario = lerSalario();
				controller.inserirEmpregado(matricula, nome, endereco, salario);
				System.out.println("Empregado inserido com sucesso!" + NL);
				break;
			
			case "A":
				matricula = lerMatricula();
				salario = lerSalario();
			    controller.updateEmpregado(matricula, salario);
			    System.out.println("Empregado atualizado com sucesso!" + NL);
				break;

			case "L":
				System.out.println(controller.listarEmpregados());
				break;

			case "E":
				matricula = lerMatricula();
				System.out.println(controller.exibirEmpregado(matricula));
				break;
				
			case "S":
				controller.closeConnection();
				break;

			default:
				opcaoInvalida(menu);
				break;
			}
		} while (!op.equals("S"));

		sc.close();

	}
	
	private static Float lerSalario() {
		System.out.print("Salário: ");
		String str = sc.nextLine();
		Float salario = Float.parseFloat(str);
		return salario;
	}

	private static Integer lerMatricula() {
		System.out.print("Matrícula: ");
		String str = sc.nextLine();
		Integer matricula = Integer.parseInt(str);
		return matricula;
	}

	private static String lerEndereco() {
		System.out.print("Endereço: ");
		String endereco = sc.nextLine();
		return endereco;
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
