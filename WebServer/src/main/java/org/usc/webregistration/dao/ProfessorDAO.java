package org.usc.webregistration.dao;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.usc.webregistration.pojo.Professors;

public class ProfessorDAO implements Runnable {
	//private static String rmpLink = "http://www.ratemyprofessors.com/filter/professor/?department=&institution=University+of+Southern+California&filter=teacherlastname_sort_s+asc&query=*%3A*&queryoption=TEACHER&queryBy=schoolId&sid=1381&page=";
	public static HashMap<String, Professors> profData = new HashMap<String, Professors>();
	public static Boolean state = false;
	public static String getProfessorRating(String name){
		while(!state){}
		if (profData.containsKey(name.toLowerCase()))
			return profData.get(name.toLowerCase()).getRating();
		else
			return "N/A";
	}
	@Override
	public void run() {
		HashMap<String, Professors> tProfData = new HashMap<String, Professors>();
		while (true) {
			JSONArray profs = null;
			try {
				profs = new JSONArray(new String(Files.readAllBytes(Paths
						.get("rateMyProfessor/data.txt"))));
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			for (int j = 0; j < profs.length(); j++) {
				JSONObject prof = new JSONObject(profs.get(j).toString());
				String name = prof.optString("tLname", "") + ", "
						+ prof.optString("tFname", "");
				Professors p = new Professors(name, prof.optString(
						"overall_rating", "0"), prof.optInt("tid", 0),
						prof.optInt("tNumRatings", 0));
				tProfData.put(name.toLowerCase(), p);
			}

			synchronized (state) {
				state = false;
			}
			synchronized (profData) {
				profData = tProfData;
			}
			synchronized (state) {
				state = true;
			}
			System.out.println("Professor Data loaded");
			try {
				Thread.sleep(SchoolDAO.oneDayMsec);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

}
