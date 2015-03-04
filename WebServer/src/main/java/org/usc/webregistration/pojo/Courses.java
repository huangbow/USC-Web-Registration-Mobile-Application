package org.usc.webregistration.pojo;


public class Courses {
	private long courseID;
	private String uCourseID;
	private String title;
	private String description;
	private double minUnits;
	private double maxUnits;
	private String tMaxUnits;
	private String dFlag;

	public Courses() {
		super();
	}

	public Courses(long courseID, String uCourseID, String title,
			String description, double minUnits, double maxUnits,
			String tMaxUnits, String dFlag, String eTermCode) {
		super();
		this.courseID = courseID;
		this.uCourseID = uCourseID;
		this.title = title;
		this.description = description;
		this.minUnits = minUnits;
		this.maxUnits = maxUnits;
		this.tMaxUnits = tMaxUnits;
		this.dFlag = dFlag;
		this.eTermCode = eTermCode;
	}

	private String eTermCode;

	public long getCourseID() {
		return courseID;
	}

	public void setCourseID(long courseID) {
		this.courseID = courseID;
	}

	public String getuCourseID() {
		return uCourseID;
	}

	public void setuCourseID(String uCourseID) {
		this.uCourseID = uCourseID;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String gettMaxUnits() {
		return tMaxUnits;
	}

	public void settMaxUnits(String tMaxUnits) {
		this.tMaxUnits = tMaxUnits;
	}

	public String getdFlag() {
		return dFlag;
	}

	public void setdFlag(String dFlag) {
		this.dFlag = dFlag;
	}

	public String geteTermCode() {
		return eTermCode;
	}

	public void seteTermCode(String eTermCode) {
		this.eTermCode = eTermCode;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (courseID ^ (courseID >>> 32));
		result = prime * result + ((dFlag == null) ? 0 : dFlag.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		result = prime * result
				+ ((eTermCode == null) ? 0 : eTermCode.hashCode());
		long temp;
		temp = Double.doubleToLongBits(maxUnits);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits(minUnits);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result
				+ ((tMaxUnits == null) ? 0 : tMaxUnits.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result
				+ ((uCourseID == null) ? 0 : uCourseID.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Courses other = (Courses) obj;
		if (courseID != other.courseID)
			return false;
		if (dFlag == null) {
			if (other.dFlag != null)
				return false;
		} else if (!dFlag.equals(other.dFlag))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (eTermCode == null) {
			if (other.eTermCode != null)
				return false;
		} else if (!eTermCode.equals(other.eTermCode))
			return false;
		if (Double.doubleToLongBits(maxUnits) != Double
				.doubleToLongBits(other.maxUnits))
			return false;
		if (Double.doubleToLongBits(minUnits) != Double
				.doubleToLongBits(other.minUnits))
			return false;
		if (tMaxUnits == null) {
			if (other.tMaxUnits != null)
				return false;
		} else if (!tMaxUnits.equals(other.tMaxUnits))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (uCourseID == null) {
			if (other.uCourseID != null)
				return false;
		} else if (!uCourseID.equals(other.uCourseID))
			return false;
		return true;
	}

	

}
