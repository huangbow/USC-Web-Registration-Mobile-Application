package org.usc.webregistration.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.usc.webregistration.HibernateUtil;
import org.usc.webregistration.pojo.ServerResponse;
import org.usc.webregistration.pojo.Student;

public class StudentDAO {
	private static String usernameQuery = "From Student where studentID=:un";

	// private static String emailQuery = "From student where emailID=:em";
	// private static String phoneQuery = "From student where phNumber=:ph";
	public static ServerResponse getStudent(String username){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try{
			Query q = session.createQuery(usernameQuery);
			q.setParameter("un", username);
			if (q.list().size() > 0) {
				List<?> s=q.list();
				session.close();
				return new ServerResponse(200,(Student)s.get(0),"Success");
			}
			session.close();
			
		}catch (Exception e){
			e.printStackTrace();
			return null;
		}
		return new ServerResponse(600,null,"Failed");
	}
	public static int checkUsernameExist(String username) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try{
			Query q = session.createQuery(usernameQuery);
			q.setParameter("un", username);
			if (q.list().size() > 0) {
				session.close();
				return 1;
			}
			session.close();
			
		}catch (Exception e){
			e.printStackTrace();
			return -1;
		}
		return 0;
	}

	public static boolean addNewStudent(String username) {
		return addNewStudent(username, null, null);
	}

	public static boolean addNewStudent(String username, String major,
			String degree) {
		Student newStudent = new Student();
		newStudent.setStudentID(username);
		if (major != null)
			newStudent.setMajor(major);
		if (degree != null)
			newStudent.setMajor(degree);
		newStudent.onCreate();
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		try {
			session = HibernateUtil.getSessionFactory().openSession();
			tx = session.beginTransaction();
			tx.setTimeout(5);
			session.save(newStudent);
			tx.commit();
			return true;
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return false;
			} catch (RuntimeException rbe) {
				// log.error("Couldn’t roll back transaction", rbe);
				return false;
			}
		} finally {
			if (session != null) {
				session.close();
			}
		}
	}

	public static boolean updateStudentInformation(String username,
			String major, String degree,String name) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			Student student = (Student) session.get(Student.class, username);
			student.onUpdate();
			if (major != null)
				student.setMajor(major);
			if (degree != null)
				student.setDegree(degree);
			if (name!=null)
				student.setName(name);
			session.update(student);
			tx.commit();
			return true;
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return false;
			} catch (RuntimeException rbe) {
				// log.error("Couldn’t roll back transaction", rbe);
				return false;
			}
		} finally {
			session.close();
		}
	}

	public static int loginStudent(String username) {
		int statusCode = checkUsernameExist(username);
		if (statusCode==1) {
			// Returning User
			if(updateStudentInformation(username, null, null,null))
				return 1;
			else
				return -1;
		} else if(statusCode==0){
			// New User
			if(addNewStudent(username))
				return 2;
			else
				return -2;
		}else {
			return -3;
		}
		
	}

}
