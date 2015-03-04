package org.usc.webregistration.pojo;

import org.usc.webregistration.dao.ProfessorDAO;

public class Section {
	private long sectionID;
	private String termCode;
	private double minUnits;
	private double maxUnits;

	public Section() {
		super();
	}

	private long courseID;

	private String uSectionID;
	private String session;
	private String bTime;
	private String eTime;
	private String day;
	private int iDay;
	private String type;
	private String location;
	private int registered;
	private int seats;
	private String instructor;
	private String iRating;
	private String addBy;
	private String dropBy;
	private String pFlag;
	private String pSecFlag;

	public long getSectionID() {
		return sectionID;
	}

	public void setSectionID(long sectionID) {
		this.sectionID = sectionID;
	}

	public String getTermCode() {
		return termCode;
	}

	public void setTermCode(String termCode) {
		this.termCode = termCode;
	}

	public double getMinUnits() {
		return minUnits;
	}

	public void setMinUnits(double minUnits) {
		this.minUnits = minUnits;
	}

	public double getMaxUnits() {
		return maxUnits;
	}

	public void setMaxUnits(double maxUnits) {
		this.maxUnits = maxUnits;
	}

	public long getCourseID() {
		return courseID;
	}

	public void setCourseID(long courseID) {
		this.courseID = courseID;
	}

	public String getuSectionID() {
		return uSectionID;
	}

	public void setuSectionID(String uSectionID) {
		this.uSectionID = uSectionID;
	}

	public String getSession() {
		return session;
	}

	public void setSession(String session) {
		this.session = session;
	}

	public String getbTime() {
		return bTime;
	}

	public void setbTime(String bTime) {
		this.bTime = bTime;
	}

	public String geteTime() {
		return eTime;
	}

	public void seteTime(String eTime) {
		this.eTime = eTime;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getRegistered() {
		return registered;
	}

	public void setRegistered(int registered) {
		this.registered = registered;
	}

	public int getSeats() {
		return seats;
	}

	public void setSeats(int seats) {
		this.seats = seats;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}

	public String getAddBy() {
		return addBy;
	}

	public void setAddBy(String addBy) {
		this.addBy = addBy;
	}

	public String getDropBy() {
		return dropBy;
	}

	public void setDropBy(String dropBy) {
		this.dropBy = dropBy;
	}

	public String getpFlag() {
		return pFlag;
	}

	public void setpFlag(String pFlag) {
		this.pFlag = pFlag;
	}

	public String getpSecFlag() {
		return pSecFlag;
	}

	public void setpSecFlag(String pSecFlag) {
		this.pSecFlag = pSecFlag;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public int getiDay() {
		return iDay;
	}

	public void setiDay(int iDay) {
		this.iDay = iDay;
	}

	public String getiRating() {
		return iRating;
	}

	public void setiRating(String iRating) {
		this.iRating = iRating;
	}

	



	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Section(long sectionID, String termCode, double minUnits,
			double maxUnits, long courseID, String uSectionID, String session,
			String bTime, String eTime, String day, int iDay, String type,
			String location, int registered, int seats, String instructor,
			 String addBy, String dropBy, String pFlag,
			String pSecFlag) {
		super();
		this.sectionID = sectionID;
		this.termCode = termCode;
		this.minUnits = minUnits;
		this.maxUnits = maxUnits;
		this.courseID = courseID;
		this.uSectionID = uSectionID;
		this.session = session;
		this.bTime = bTime;
		this.eTime = eTime;
		this.day = day;
		this.iDay = iDay;
		this.type = type;
		this.location = location;
		this.registered = registered;
		this.seats = seats;
		this.instructor = instructor;
		this.iRating  = ProfessorDAO.getProfessorRating(instructor);
		this.addBy = addBy;
		this.dropBy = dropBy;
		this.pFlag = pFlag;
		this.pSecFlag = pSecFlag;
	}

}
