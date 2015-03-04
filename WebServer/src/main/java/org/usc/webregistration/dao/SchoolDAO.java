package org.usc.webregistration.dao;

import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.client.RestTemplate;
import org.usc.webregistration.pojo.School;

public class SchoolDAO implements Runnable {
	public static Boolean state = false;
	public static HashMap<String, School> schools = new HashMap<String, School>();
	public static JSONArray termData = new JSONArray();
	public static long oneDayMsec = 8640000;

	@Override
	public void run() {
		while (true) {
			RestTemplate r = new RestTemplate();
			JSONArray data = new JSONArray(
					r.getForObject(
							"http://petri.esd.usc.edu/socAPI/Schools/ALL",
							String.class));
			HashMap<String, School> temp = new HashMap<String, School>();
			for (int i = 0; i < data.length(); i++) {
				JSONObject school = data.getJSONObject(i);
				School s = new School(
						school.getString("SOC_SCHOOL_DESCRIPTION"));
				JSONArray depts = school.getJSONArray("SOC_DEPARTMENT_CODE");
				for (int j = 0; j < depts.length(); j++) {
					JSONObject dept = depts.getJSONObject(j);
					s.addDept(dept.getString("SOC_DEPARTMENT_CODE"),
							dept.getString("SOC_DEPARTMENT_DESCRIPTION"));
				}
				temp.put(school.getString("SOC_SCHOOL_CODE"), s);
			}
			synchronized (state) {
				state = false;
			}
			synchronized (schools) {
				schools = temp;
			}
			synchronized (schools) {
				termData = new JSONArray(r.getForObject(
						"http://petri.esd.usc.edu/socAPI/Terms", String.class));
			}
			synchronized (state) {
				state = true;
			}
			try {
				Thread.sleep(oneDayMsec);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
