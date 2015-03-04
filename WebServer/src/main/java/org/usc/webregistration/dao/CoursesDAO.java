package org.usc.webregistration.dao;

import java.util.HashMap;
import java.util.HashSet;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.usc.webregistration.pojo.Courses;
import org.usc.webregistration.pojo.Section;

public class CoursesDAO implements Runnable {

	public static HashMap<Long, Courses> codeCourses = new HashMap<Long, Courses>();
	// public static HashMap<Integer, HashSet<Section>> daySections = new
	// HashMap<Integer, HashSet<Section>>();
	public static HashMap<String, HashMap<String, HashSet<Section>>> termSections = new HashMap<String, HashMap<String, HashSet<Section>>>();
	public static HashMap<String, HashSet<Section>> profSections = new HashMap<String, HashSet<Section>>();
	public static HashMap<Long, Section> sections = new HashMap<Long, Section>(); 
	public static Boolean state = false;
	public static long oneHourTime = 3600000;

	public static int convertDayToInt(String day) {
		if (day == null || day.equals(""))
			return -1;
		day = day.toUpperCase();
		int iDay = 0;
		if (day.contains("M"))
			iDay += 1;
		if (day.contains("T")
		/*
		 * && (StringUtils.countOccurrencesOf(day, "T") > 1 || !day
		 * .contains("TH"))
		 */)
			iDay += 2;
		if (day.contains("W"))
			iDay += 4;
		if (day.contains("H") /* || day.contains("TH") */)
			iDay += 8;
		if (day.contains("F"))
			iDay += 16;
		if (day.contains("S")
				&& (StringUtils.countOccurrencesOf(day, "S") > 1 || !day
						.contains("SU")))
			iDay += 32;
		if (day.contains("Su"))
			iDay += 64;
		return iDay;
	}

	@Override
	public void run() {
		while (true) {
			HashMap<Long, Courses> tCodeCourses = new HashMap<Long, Courses>();
			// HashMap<Integer, HashSet<Section>> tDaySections = new
			// HashMap<Integer, HashSet<Section>>();
			HashMap<String, HashMap<String, HashSet<Section>>> tTermSections = new HashMap<String, HashMap<String, HashSet<Section>>>();
			HashMap<String, HashSet<Section>> tProfSections = new HashMap<String, HashSet<Section>>();
			HashMap<Long, Section> tSections = new HashMap<Long, Section>();
			RestTemplate r = new RestTemplate();
			while (!SchoolDAO.state) {
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			for (int k = 0; k < SchoolDAO.termData.length(); k++) {
				
				JSONArray data = new JSONArray(r.getForObject(
						"http://petri.esd.usc.edu/courses/"+SchoolDAO.termData.getJSONObject(k).getString("TERM_CODE")+"/ALL",
						String.class));
				for (int i = 0; i < data.length(); i++) {
					JSONObject course = data.getJSONObject(i);
					Courses c = new Courses(course.optLong("COURSE_ID"),
							course.optString("SIS_COURSE_ID"),
							course.optString("TITLE"),
							course.optString("DESCRIPTION"),
							course.optDouble("MIN_UNITS"),
							course.optDouble("MAX_UNITS"),
							course.optString("TOTAL_MAX_UNITS"),
							course.optString("DIVERSITY_FLAG"),
							course.optString("EFFECTIVE_TERM_CODE"));
					tCodeCourses.put(course.getLong("COURSE_ID"), c);
					JSONArray sections = course.getJSONArray("V_SOC_SECTION");
					for (int j = 0; j < sections.length(); j++) {
						JSONObject section = sections.getJSONObject(j);
						int iDay = convertDayToInt(section.optString("DAY"));
						Section s = new Section(section.optLong("SECTION_ID"),
								section.optString("TERM_CODE"),
								section.optDouble("MIN_UNITS"),
								section.optDouble("MAX_UNITS"),
								section.optLong("COURSE_ID"),
								section.optString("SECTION"),
								section.optString("SESSION"),
								section.optString("BEGIN_TIME"),
								section.optString("END_TIME"),
								section.optString("DAY"), iDay,
								section.optString("TYPE","N/A"),
								section.optString("LOCATION"),
								section.optInt("REGISTERED"),
								section.optInt("SEATS"),
								section.optString("INSTRUCTOR"),
								section.optString("ADD_DATE"),
								section.optString("CANCEL_DATE"),
								section.optString("PUBLISH_FLAG"),
								section.optString("PUBLISH_SECTION_FLAG"));
						String department = section.optString("SIS_COURSE_ID")
								.replaceAll("-.*", "");

						HashSet<Section> tProfSet = tProfSections.getOrDefault(
								section.optString("INSTRUCTOR", "N/A"),
								new HashSet<Section>());
						tProfSet.add(s);
						tSections.put(section.optLong("SECTION_ID"),s);
						tProfSections.put(
								section.optString("INSTRUCTOR", "N/A"),
								tProfSet);

						/*
						 * HashSet<Section> tDaySet =
						 * tDaySections.getOrDefault(iDay, new
						 * HashSet<Section>()); tDaySet.add(s);
						 * tDaySections.put(iDay, tDaySet);
						 */

						HashMap<String, HashSet<Section>> tTerm = tTermSections
								.getOrDefault(
										section.optString("TERM_CODE", "N/A"),
										new HashMap<String, HashSet<Section>>());
						HashSet<Section> tdept = tTerm.getOrDefault(department,
								new HashSet<Section>());
						tdept.add(s);
						tTerm.put(department, tdept);
						tTermSections.put(
								section.optString("TERM_CODE", "N/A"), tTerm);

					}

				}
			}
			synchronized (state) {
				state = false;
			}
			synchronized (codeCourses) {
				codeCourses = tCodeCourses;
			}
			/*
			 * synchronized (daySections) { daySections = tDaySections; }
			 */
			synchronized (termSections) {
				termSections = tTermSections;
			}
			synchronized (profSections) {
				profSections = tProfSections;
			}
			synchronized (sections){
				sections=tSections;
			}
			synchronized (state) {
				state = true;
			}
			System.out.println("Courses Loaded");
			try {
				Thread.sleep(oneHourTime);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
