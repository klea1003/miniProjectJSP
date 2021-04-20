package book;

public class Book {
	private int bookID;
	private String bookTitle;
	private int bookPrice;
	private String bookAuthor;
	private int bookCategory;
	private String bookPublisher;
	private String bookImagePath;
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public int getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	public String getBookAuthor() {
		return bookAuthor;
	}
	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}
	public int getBookCategory() {
		return bookCategory;
	}
	public void setBookCategory(int bookCategory) {
		this.bookCategory = bookCategory;
	}
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public String getBookImagePath() {
		return bookImagePath;
	}
	public void setBookImagePath(String bookImagePath) {
		this.bookImagePath = bookImagePath;
	}
	
	public String toString() {
		return String.format("Book[ID: %d, Title: %s, Price: %d, Author: %s, Category: %d, Publisher: %s, Image Path: %s]", 
				bookID, bookTitle, bookPrice, bookAuthor, bookCategory, bookPublisher, bookImagePath);
	}
}
