package org.usc.webregistration;

import java.util.HashMap;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.usc.webregistration.dao.ProfessorDAO;
import org.usc.webregistration.dao.SchoolDAO;
import org.usc.webregistration.pojo.Professors;
import org.usc.webregistration.pojo.School;

@RestController
@RequestMapping(value = "/misc", method = RequestMethod.GET)
public class MiscController {
	@RequestMapping(value = "/dept")
	public static HashMap<String, School> getDepartment() {
		while (!SchoolDAO.state) {
		}
		return SchoolDAO.schools;
	}

	@RequestMapping(value = "/term")
	public static String getTerm() {
		while (!SchoolDAO.state) {
		}
		return SchoolDAO.termData.toString();
	}
	@RequestMapping(value = "/prof/All")
	public static HashMap<String, Professors> getProf() {
		while (!ProfessorDAO.state) {
		}
		return ProfessorDAO.profData;
	}
	@RequestMapping(value = "/prof")
	public static Professors getProf(
			@RequestParam(value = "name", required = true) String name) {
		while (!ProfessorDAO.state) {
		}
		return ProfessorDAO.profData.getOrDefault(name.toLowerCase(), null);
	}
}
