package ufcg.bd1.example.controller;

import ufcg.bd1.example.entity.Student;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


public class Controller {
	
	public void inserirEstudante(String nome, String sobrenome, String email) {
		// create session factory
		SessionFactory factory = new Configuration()
								.configure("hibernate.cfg.xml")
								.addAnnotatedClass(Student.class)
								.buildSessionFactory();
		
		// create session
		Session session = factory.getCurrentSession();
		
		// create a student object
		System.out.println("Creating new student object...");
		Student tempStudent = new Student(nome, sobrenome, email);
		
		// start a transaction
		session.beginTransaction();
		
		// save the student object
		System.out.println("Saving the student...");
		session.save(tempStudent);
		
		// commit transaction
		session.getTransaction().commit();
		
		System.out.println("Done!");
	}
	
	public void updateEstudante(Integer studentId, String nome) {
		// create session factory
		SessionFactory factory = new Configuration()
								.configure("hibernate.cfg.xml")
								.addAnnotatedClass(Student.class)
								.buildSessionFactory();
		
		// create session
		Session session = factory.getCurrentSession();
		// start a transaction
		session.beginTransaction();
		
		// retrieve student based on the id: primary key
		System.out.println("\nGetting student with id: " + studentId);
		
		Student myStudent = session.get(Student.class, studentId);
		
		System.out.println("Updating student...");
		myStudent.setFirstName(nome);
		
		// commit transaction
		session.getTransaction().commit();
		
		System.out.println("Done!");
	}
	
	private static void displayStudents(List<Student> theStudents) {
		for (Student tempStudent : theStudents) {
			System.out.println(tempStudent);
		}

}

	@SuppressWarnings("unchecked")
	public void listarEstudantes() {
		// create session factory
		SessionFactory factory = new Configuration()
								.configure("hibernate.cfg.xml")
								.addAnnotatedClass(Student.class)
								.buildSessionFactory();
		
		// create session
		Session session = factory.getCurrentSession();
		
		// start a transaction
		session.beginTransaction();
		
		// query students
		List<Student> theStudents = session.createQuery("from Student").list();
		
		// display the students
		displayStudents(theStudents);
		
		// commit transaction
		session.getTransaction().commit();
		
		System.out.println("Done!");
	}
}
