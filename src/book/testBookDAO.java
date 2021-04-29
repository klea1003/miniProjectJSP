package book;
import java.util.ArrayList;

public class testBookDAO {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		BookDAO bookDAO = new BookDAO();
		
		ArrayList<Book> list = bookDAO.getList(0, 0);
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		
		
	}

}
