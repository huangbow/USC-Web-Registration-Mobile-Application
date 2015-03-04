package org.usc.webregistration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.usc.webregistration.dao.AuthorizationCodeDAO;
import org.usc.webregistration.dao.StudentDAO;
import org.usc.webregistration.pojo.ServerResponse;
import org.usc.webregistration.pojo.Student;

@RestController
@RequestMapping(value = "/student", method = RequestMethod.POST)
public class StudentController {
	
	@RequestMapping(value = "/update")
	public String updateStudent(
			@RequestParam(value = "username") String username,
			@RequestParam(value = "name",required = false) String name,
			@RequestParam(value = "degree",required = false) String degree,
			@RequestParam(value = "major",required = false) String major,
			
			HttpServletRequest request, HttpServletResponse response) {
		//Check for auth to be valid
		//System.out.println(username+" "+authorizationCode);
		boolean statusCode=StudentDAO.updateStudentInformation(username, major, degree, name);
		if(statusCode) return "success"; else return "failure";
		
	}
	@RequestMapping(value = "/fetch")
	public ServerResponse fetchStudent(
			@RequestParam(value = "username") String username,
			
			HttpServletRequest request, HttpServletResponse response) {
		//Check for auth to be valid
		//System.out.println(username+" "+authorizationCode);
		return StudentDAO.getStudent(username);
		
	}
	@RequestMapping(value = "/login")
	public ServerResponse login(
			@RequestParam(value = "username") String username,
			@RequestParam(value = "auth") String authorizationCode,
			HttpServletRequest request, HttpServletResponse response) {
		//Check for auth to be valid
		//System.out.println(username+" "+authorizationCode);
		int statusCode=StudentDAO.loginStudent(username);
		if (statusCode==1){
			return new ServerResponse(200,AuthorizationCodeDAO.getNewAuthorizationCode(),"returnUser");
		}else if(statusCode==2){
			return new ServerResponse(200,AuthorizationCodeDAO.getNewAuthorizationCode(),"newUser");
		}else if(statusCode==-1){
			return new ServerResponse(601,null,"Login Failed");
		}else if(statusCode==-2){
			return new ServerResponse(602,null,"New User Creating Failed");
		}else {
			return new ServerResponse(603,null,"Database Connection Error");
		}
		
	}

	@RequestMapping(value = "/{studentID}/addCourse")
	public String addCourse(@PathVariable String studentID,
			@RequestParam(value = "courseID") String courseID,
			@RequestParam(value = "term") String term) {
		return studentID;
	}
}
