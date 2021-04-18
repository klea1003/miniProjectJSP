package cart;

import java.util.ArrayList;

public class testCartDAO {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		CartDAO cartDAO = new CartDAO();
		//int result = cartDAO.addCart(1, "gildong", 2);
		
		ArrayList<CartStock> list = cartDAO.getStockList("gildong");
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
		
		int result = cartDAO.order(2, "gildong");
		
		System.out.print(result);
	}

}
