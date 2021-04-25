package faq;

public class Faq {
	
	private int faqID;
	private String faqTitle;
	private String userID;
	private String faqDate;
	private String faqContent;
	private int faqAvailable;
	public int getFaqID() {
		return faqID;
	}
	public void setFaqID(int faqID) {
		this.faqID = faqID;
	}
	public String getFaqTitle() {
		return faqTitle;
	}
	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getFaqDate() {
		return faqDate;
	}
	public void setFaqDate(String faqDate) {
		this.faqDate = faqDate;
	}
	public String getFaqContent() {
		return faqContent;
	}
	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}
	public int getFaqAvailable() {
		return faqAvailable;
	}
	public void setFaqAvailable(int faqAvailable) {
		this.faqAvailable = faqAvailable;
	}
}
