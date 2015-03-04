package org.usc.webregistration;

import java.util.Collection;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.usc.webregistration.dao.CalendarDAO;
import org.usc.webregistration.pojo.CourseSections;
import org.usc.webregistration.pojo.ServerResponse;
import org.usc.webregistration.pojo.StudentCalendar;

@RestController
@RequestMapping(value = "/calendar", method = RequestMethod.POST)
public class CalendarController {
	@RequestMapping(value = "/{studentID}/getAll")
	public List<StudentCalendar> getCalendar(@PathVariable String studentID) {
		return CalendarDAO.getCalendar(studentID);
		
	}
	@RequestMapping(value = "/{studentID}/create")
	public StudentCalendar createCalendar(@PathVariable String studentID) {
		return CalendarDAO.createNewCalendar(studentID);
		
	}
	@RequestMapping(value = {"/{studentID}/{calendarID}","/{studentID}/{calendarID}/fetch"})
	public Collection<CourseSections> fetchCalendar(@PathVariable String studentID,@PathVariable long calendarID) {
		return CalendarDAO.fetchCalendar(calendarID);
	}
	@RequestMapping(value = "/{studentID}/{calendarID}/insert")
	public ServerResponse insertIntoCalendar(@PathVariable String studentID,@PathVariable long calendarID,
			@RequestParam(value = "sectionId", required = true) Long sId) {
		return CalendarDAO.addCourseToCalendar(calendarID, sId);
	}
	@RequestMapping(value = "/{studentID}/{calendarID}/delete")
	public StudentCalendar deleteFromCalendar(@PathVariable String studentID,@PathVariable long calendarID,
			@RequestParam(value = "sectionId", required = true) Long sId) {
		return CalendarDAO.removeCourseFromCalendar(calendarID, sId);
	}
	@RequestMapping(value = "/{studentID}/{calendarID}/deleteCalendar")
	public Boolean deleteCalendar(@PathVariable String studentID,@PathVariable long calendarID) {
		return CalendarDAO.deleteCalendar(calendarID);
	}
	@RequestMapping(value = "/{studentID}/{calendarID}/registerCalendar")
	public Boolean registerCalendar(@PathVariable String studentID,@PathVariable long calendarID) {
		return false;//return CalendarDAO.deleteCalendar(calendarID);
	}
}
