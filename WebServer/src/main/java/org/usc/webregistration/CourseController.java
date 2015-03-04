package org.usc.webregistration;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.usc.webregistration.dao.CoursesDAO;
import org.usc.webregistration.pojo.CourseSections;
import org.usc.webregistration.pojo.Courses;
import org.usc.webregistration.pojo.Section;

@RestController
@RequestMapping(value = "/course", method = RequestMethod.GET)
public class CourseController {
	@RequestMapping(value = "/section")
	public static CourseSections getSection(
			@RequestParam(value = "id", required = true) Long id) {
		while (!CoursesDAO.state) {
		}
		final Section s = CoursesDAO.sections.getOrDefault(id, null);
		if (s == null)
			return null;
		return new CourseSections(CoursesDAO.codeCourses.get(s.getCourseID())){{addSection(s);}};

	}

	@RequestMapping(value = "/search/{term}")
	public static HashMap<String, Collection<CourseSections>> searchCourse(

			@PathVariable String term,
			@RequestParam(value = "cName", required = false, defaultValue = "") String cName,
			@RequestParam(value = "pName", required = false, defaultValue = "") String pName,
			@RequestParam(value = "cRating", required = false) String cRating,
			@RequestParam(value = "pRating", required = false, defaultValue = "0") float pRating,
			@RequestParam(value = "units", required = false, defaultValue = "-1") float units,
			@RequestParam(value = "day", required = false, defaultValue = "127") int day,
			@RequestParam(value = "tStart", required = false, defaultValue = "0") int timeStart,
			@RequestParam(value = "tEnd", required = false, defaultValue = "2400") int timeEnd,
			@RequestParam(value = "tType", required = false, defaultValue = "include") String timeType) {
		while (!CoursesDAO.state) {
		}
		HashMap<String, Collection<CourseSections>> courses = new HashMap<String, Collection<CourseSections>>();
		for (String dept : CoursesDAO.termSections.getOrDefault(term,
				new HashMap<String, HashSet<Section>>()).keySet()) {
			courses.put(
					dept,
					searchCourse(term, dept, cName, pName, cRating, pRating,
							units, day, timeStart, timeEnd, timeType));
		}
		return courses;
	}

	@RequestMapping(value = "/search/{term}/{dept}")
	public static Collection<CourseSections> searchCourse(
			@PathVariable String term,
			@PathVariable String dept,
			@RequestParam(value = "cName", required = false, defaultValue = "") String cName,
			@RequestParam(value = "pName", required = false, defaultValue = "") String pName,
			@RequestParam(value = "cRating", required = false) String cRating,
			@RequestParam(value = "pRating", required = false, defaultValue = "0") float pRating,
			@RequestParam(value = "units", required = false, defaultValue = "-1") float units,
			@RequestParam(value = "day", required = false, defaultValue = "127") int day,
			@RequestParam(value = "tStart", required = false, defaultValue = "0") int timeStart,
			@RequestParam(value = "tEnd", required = false, defaultValue = "2400") int timeEnd,
			@RequestParam(value = "tType", required = false, defaultValue = "include") String timeType) {
		while (!CoursesDAO.state) {
		}
		HashMap<Long, CourseSections> res = new HashMap<Long, CourseSections>();
		cName = cName.toLowerCase();
		pName = pName.toLowerCase();
		HashSet<Section> sections = null;
		try {
			sections = CoursesDAO.termSections.get(term).get(dept);
		} catch (NullPointerException e) {
			return new HashMap<Long, CourseSections>().values();
		}
		for (Section s : sections) {
			try {
				Courses cou = CoursesDAO.codeCourses.get(s.getCourseID());
				if ((s.getMinUnits() > units || s.getMaxUnits() < units)
						&& units != -1)
					continue;
				if (!s.getInstructor().toLowerCase()
						.contains(pName.toLowerCase()))
					continue;
				if (!cou.getTitle().toLowerCase().contains(cName.toLowerCase())
						&& !cou.getuCourseID()
								.toLowerCase()
								.replaceAll("[-| ]", "")
								.contains(
										cName.replaceAll("[-| ]", "")
												.toLowerCase()))
					continue;
				if (!s.getpSecFlag().equals("Y") && !s.getpFlag().equals("Y"))
					continue;
				if ((s.getiDay() & day) == s.getiDay()) {
					// #TODO Check For Course Rating
					float rating = s.getiRating().equals("N/A") ? 5 : Float
							.parseFloat(s.getiRating());
					if (rating < pRating)
						continue;
					int startTime = s.getbTime().equals("TBA") ? 0 : Integer
							.parseInt(s.getbTime().replace(":", ""));
					int endTime = s.geteTime().equals("TBA") ? 2400 : Integer
							.parseInt(s.geteTime().replace(":", ""));
					if ((timeType.equals("include") && startTime >= timeStart && endTime <= timeEnd)
							|| (timeType.equals("exclude")
									&& (startTime <= timeStart || startTime >= timeEnd) && (endTime <= timeStart || endTime >= timeEnd))) {
						CourseSections c = res.getOrDefault(s.getCourseID(),
								new CourseSections(cou));
						c.addSection(s);
						res.put(s.getCourseID(), c);
						// result.add(s);
					} else
						continue;
				} else
					continue;
			} catch (Exception e) {
				// System.out.println(s.getSectionID() + " " + e.getMessage());
			}
		}
		return res.values();

	}
}
