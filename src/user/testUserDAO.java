package user;

public class testUserDAO {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserDAO testDAO = new UserDAO();
		
		int rs = testDAO.login("gildong", "123456");
		
		System.out.print(rs);
	}

}
