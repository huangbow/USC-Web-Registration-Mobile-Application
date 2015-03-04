package org.usc.webregistration.dao;


public class AuthorizationCodeDAO {
	private static long DEFAULT_VALIDITY = 36000000;
	String code;
	long ttl;
	long creationTime;
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public long getTtl() {
		return ttl;
	}

	public void setTtl(long ttl) {
		this.ttl = ttl;
	}

	public static AuthorizationCodeDAO getNewAuthorizationCode(){
		return new AuthorizationCodeDAO("kjasdhfjdfjshdfasdf",1000);
	}

	public AuthorizationCodeDAO(String code, long ttl) {
		super();
		this.code = code;
		this.ttl = ttl;
		this.creationTime=System.currentTimeMillis();
	}
	
	public AuthorizationCodeDAO() {
		super();
		this.code =""; //auto-generate some unique code
		this.ttl = DEFAULT_VALIDITY;
		this.creationTime=System.currentTimeMillis();
	}
}
