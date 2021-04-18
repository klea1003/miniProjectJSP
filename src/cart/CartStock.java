package cart;

public class CartStock {
	private int bookID;
	private String bookTitle;
	private int bookPrice;
	private int bookAmount;
	private int TotalPrice;
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
	public int getBookAmount() {
		return bookAmount;
	}
	public void setBookAmount(int bookAmount) {
		this.bookAmount = bookAmount;
	}
	public int getTotalPrice() {
		return TotalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		TotalPrice = totalPrice;
	}
	
	public String toString() {
		return String.format("Stock[BookID: %d, Title: %s, Price: %d, Amount: %d, TotalPrice: %d]", bookID, bookTitle, bookPrice, bookAmount, TotalPrice);
	}
	
}
