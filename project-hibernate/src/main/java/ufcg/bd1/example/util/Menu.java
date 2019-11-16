package ufcg.bd1.example.util;

public class Menu {

	final String NL = System.lineSeparator();

	public String toString() {

		return "(I)nserir Estudante" + NL + "(A)tualizar Nome Estudante" + NL + "(L)istar Estudantes" + NL +
			    "(S)air" + NL + NL + "Opção> ";

	}
}
