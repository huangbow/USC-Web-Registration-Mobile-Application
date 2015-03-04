package org.usc.webregistration.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.usc.webregistration.HibernateUtil;
import org.usc.webregistration.pojo.CourseSections;
import org.usc.webregistration.pojo.Section;
import org.usc.webregistration.pojo.ServerResponse;
import org.usc.webregistration.pojo.StudentCalendar;

public class CalendarDAO {
	private static String calendarQuery = "From StudentCalendar where studentid=:un";

	public static List<StudentCalendar> getCalendar(String studentId) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {
			Query q = session.createQuery(calendarQuery);
			q.setParameter("un", studentId);
			List<StudentCalendar> cal = new ArrayList<StudentCalendar>();

			for (Object o : q.list()) {
				cal.add((StudentCalendar) o);
				
			}
			session.close();
			return cal;

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static Boolean deleteCalendar(long calendarID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			StudentCalendar sc = (StudentCalendar) session.get(
					StudentCalendar.class, calendarID);
			session.delete(sc);
			tx.commit();
			return true;
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return null;
			} catch (RuntimeException rbe) {

				return null;
			}
		} finally {
			session.close();
		}
	}

	public static StudentCalendar removeCourseFromCalendar(long calendarID,
			long sectionID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			StudentCalendar sc = (StudentCalendar) session.get(
					StudentCalendar.class, calendarID);
			sc.deleteSection(sectionID);

			session.update(sc);
			tx.commit();
			return sc;
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return null;
			} catch (RuntimeException rbe) {

				return null;
			}
		} finally {
			session.close();
		}
	}

	public static Collection<CourseSections> fetchCalendar(long calendarID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		try {

			StudentCalendar sc = (StudentCalendar) session.get(
					StudentCalendar.class, calendarID);
			if (sc == null)
				return null;
			else
				return sc.fetchCalendar();
		} catch (RuntimeException e) {
			try {
				return null;
			} catch (RuntimeException rbe) {

				return null;
			}
		} finally {
			session.close();
		}
	}

	public static ServerResponse addCourseToCalendar(long calendarID,
			long sectionID) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			StudentCalendar sc = (StudentCalendar) session.get(
					StudentCalendar.class, calendarID);
			Section newSection = CoursesDAO.sections.getOrDefault(sectionID,
					null);
			if (newSection == null)
				return new ServerResponse(600, null, "Invalid Section ID");
			Set<Long> sections = sc.getSections();
			if (sections.contains(sectionID))
				return new ServerResponse(601, sc,
						"Section already exists in calendar");
			for (Long id : sections) {
				Section e = CoursesDAO.sections.getOrDefault(id, null);
				if ((e.getiDay() & newSection.getiDay()) == 0) {
					continue;
				} else {
					int startTime = e.getbTime().equals("TBA") ? -1 : Integer
							.parseInt(e.getbTime().replaceAll("[:]", "")
									.replaceAll(" ||.*", ""));
					int endTime = e.geteTime().equals("TBA") ? -1 : Integer
							.parseInt(e.geteTime().replaceAll("[:]", "")
									.replaceAll(" ||.*", ""));
					if (startTime == -1 || endTime == -1) {
						continue;
					}
					int nStartTime = newSection.getbTime().equals("TBA") ? -1
							: Integer.parseInt(newSection.getbTime()
									.replaceAll("[:]", "")
									.replaceAll(" ||.*", ""));
					int nEndTime = newSection.geteTime().equals("TBA") ? -1
							: Integer.parseInt(newSection.geteTime()
									.replaceAll("[:]", "")
									.replaceAll(" ||.*", ""));
					if (nStartTime == -1 || nEndTime == -1) {
						continue;
					}
					if ((nStartTime >= startTime && nStartTime < endTime)
							|| (nEndTime > startTime && nEndTime <= endTime))
						return new ServerResponse(602, sc,
								"Insertion Failed, there is a schedule collision");
				}
			}
			sc.addNewSection(sectionID);
			session.update(sc);
			tx.commit();
			return new ServerResponse(200, sc, "Update Successful");
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return null;
			} catch (RuntimeException rbe) {

				return null;
			}
		} finally {
			session.close();
		}
	}

	public static StudentCalendar createNewCalendar(String studentID) {
		StudentCalendar c = new StudentCalendar(studentID);
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		try {
			session = HibernateUtil.getSessionFactory().openSession();
			tx = session.beginTransaction();
			tx.setTimeout(5);
			session.save(c);
			tx.commit();
			return c;
		} catch (RuntimeException e) {
			try {
				tx.rollback();
				return null;
			} catch (RuntimeException rbe) {

				return null;
			}
		} finally {
			if (session != null) {
				session.close();
			}
		}

	}
}
