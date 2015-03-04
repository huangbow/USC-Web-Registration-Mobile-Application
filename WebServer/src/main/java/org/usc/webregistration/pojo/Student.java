package org.usc.webregistration.pojo;



import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="student")
public class Student implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8093425358511354779L;
	@Id
	@Column (name="studentID")
	private String studentID;
	@Column (name="created")
	private long created;
	@Column (name="lastLoggedIn")
	private long lastLoggedIn;
	@Column (name="major")
	private String major;
	@Column (name="degree")
	private String degree;
	@Column (name="name")
	private String name;
	
	public String getStudentID() {
		return studentID;
	}

	public void setStudentID(String studentID) {
		this.studentID = studentID;
	}

	public long getCreated() {
		return created;
	}

	public void setCreated(long created) {
		this.created = created;
	}

	public long getLastUpdated() {
		return lastLoggedIn;
	}

	public void setLastUpdated(long lastUpdated) {
		this.lastLoggedIn = lastUpdated;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getDegree() {
		return degree;
	}

	public void setDegree(String degree) {
		this.degree = degree;
	}

	
	public void onCreate() {
		created = System.currentTimeMillis();
	}

	
	public void onUpdate() {
		lastLoggedIn = System.currentTimeMillis();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
