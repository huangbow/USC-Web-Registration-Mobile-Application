package org.usc.webregistration.pojo;

import java.util.HashSet;

public class CourseSections extends Courses{
	HashSet<Section> section;
	public CourseSections() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CourseSections(Courses c){
		super(c.getCourseID(), c.getuCourseID(), c.getTitle(), c.getDescription(), c.getMinUnits(), c.getMaxUnits(), c.gettMaxUnits(),
				c.getdFlag(), c.geteTermCode());
		this.section=new HashSet<Section>();
	}
	public CourseSections(long courseID, String uCourseID, String title,
			String description, double minUnits, double maxUnits,
			String tMaxUnits, String dFlag, String eTermCode) {
		super(courseID, uCourseID, title, description, minUnits, maxUnits, tMaxUnits,
				dFlag, eTermCode);
		this.section=new HashSet<Section>();
	}
	public void addSection(Section e){
		section.add(e);
	}
	public HashSet<Section> getSection() {
		return section;
	}
	public void setSection(HashSet<Section> section) {
		this.section = section;
	}

}
