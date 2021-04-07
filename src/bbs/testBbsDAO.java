package bbs;

import java.util.ArrayList;

public class testBbsDAO {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BbsDAO bbsDAO = new BbsDAO();
		
		for(int i = 20; i < 40; i++) {
			bbsDAO.write("article" + i, "heedong8", "content" + i);
		}	
	}

}
