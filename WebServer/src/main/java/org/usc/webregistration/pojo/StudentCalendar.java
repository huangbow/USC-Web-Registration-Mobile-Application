package org.usc.webregistration.pojo;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.usc.webregistration.dao.CoursesDAO;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name = "studentcalendar")
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, 
property = "calendarID")
public class StudentCalendar implements Serializable {
	private static final long serialVersionUID = 1L;
	
	
	
	@Column(name = "studentID", nullable = false)
	private String studentID;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "calendarID", nullable = false)
	private long calendarID;
	
	@ElementCollection
	@CollectionTable(name = "calendarsections", joinColumns = @JoinColumn(name = "calendarID"))
	@Column(name = "sections")
	@JsonIgnore  
	Set<Long> sections;

	
	public StudentCalendar() {
		sections = new HashSet<Long>();
	}

	public StudentCalendar(String sID) {
		this.studentID = sID;
	}

	public String getStudentID() {
		return studentID;
	}

	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}

	public long getCalendarID() {
		return calendarID;
	}

	public void setCalendarID(long calendarID) {
		this.calendarID = calendarID;
	}

	public Set<Long> getSections() {
		return sections;
	}

	public void setSections(Set<Long> sections) {
		this.sections = sections;
	}

	public boolean addNewSection(Long s) {
		return sections.add(s);
	}

	public boolean deleteSection(Long s) {
		return sections.remove(s);
	}
	public Collection<CourseSections> fetchCalendar(){
		HashMap<Long, CourseSections> res = new HashMap<Long, CourseSections>();
		for (long sid:sections){
			Section s=CoursesDAO.sections.get(sid);
			CourseSections cou = res.getOrDefault(s.getCourseID(),new CourseSections(CoursesDAO.codeCourses.get(s.getCourseID())));
			cou.addSection(s);
			res.put(s.getCourseID(), cou);
		}
		return res.values();
	}
}
