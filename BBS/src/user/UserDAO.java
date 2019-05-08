package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	/* ������ DB�� �����ؼ� ������ �������ų� �����͸� �ִ� �����ϴ� ������ ���� ��ü */
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "7280pak";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword, String userLevel) {
		String SQL = "SELECT userPassword, userLevel FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword) && rs.getString(2).equals(userLevel)) 
						return 1;	// �α��� ����
				else
					return 0;	// ��й�ȣ ����ġ
			}
			
			return -1;			// ���̵� ����
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -2;				// �����ͺ��̽� ����
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserLevel());
			pstmt.setString(5, user.getUserEmail());				
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;			// �����ͺ��̽� ����
	}

}