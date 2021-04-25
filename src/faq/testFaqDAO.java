package faq;

import java.util.ArrayList;

public class testFaqDAO {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		FaqDAO bbsDAO = new FaqDAO();
		
		for(int i = 20; i < 40; i++) {
			bbsDAO.write("article" + i, "heedong8", "content" + i);
		}	
	}

}
