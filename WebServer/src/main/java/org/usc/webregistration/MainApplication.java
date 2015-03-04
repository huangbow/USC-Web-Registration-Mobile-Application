package org.usc.webregistration;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.usc.webregistration.dao.CoursesDAO;
import org.usc.webregistration.dao.ProfessorDAO;
import org.usc.webregistration.dao.SchoolDAO;

@SpringBootApplication
public class MainApplication extends SpringBootServletInitializer{

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	return application.sources(MainApplication.class);
	}
    public static void main(String[] args) {
    	Thread cacheCourseData = new Thread(new CoursesDAO());
    	Thread cacheDepartmentData = new Thread (new SchoolDAO());
    	Thread cacheProfessorData = new Thread (new ProfessorDAO());
    	cacheCourseData.start();
    	cacheDepartmentData.start();
    	cacheProfessorData.start();
        SpringApplication.run(MainApplication.class, args);
    }
}
