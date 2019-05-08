package userbbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserBbsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	/* 실제로 DB에 접근해서 데이터 가져오거나 데이터를 넣는 역할하는 데이터 접근 개체 */
	public UserBbsDAO() {
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
	
	public String getDate() {
		String SQL="SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";		// 데이터베이스 오류
	}
	
	public ArrayList<UserBbs> getList(String cname){
		String SQL = "SELECT * FROM userBbs WHERE bbsAvailable = 1 AND courseID = ? ORDER BY bbsID DESC";
		ArrayList<UserBbs> list = new ArrayList<UserBbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cname);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBbs ubbs = new UserBbs();
				ubbs.setBbsID(rs.getInt(1));
				ubbs.setBbsTitle(rs.getString(2));
				ubbs.setUserID(rs.getString(3));
				ubbs.setCourseID(rs.getString(4));
				ubbs.setBbsDate(rs.getString(5));
				ubbs.setBbsContent(rs.getString(6));
				ubbs.setBbsAvailable(rs.getInt(7));
				ubbs.setFileName(rs.getString(8));
				list.add(ubbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;		
	}
	
	public int getNext() {
		String SQL="SELECT bbsID FROM userBbs ORDER BY  bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;		// 첫 번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;			// 데이터베이스 오류
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM userBbs WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	public int write(String bbsTitle, String userID, String courseID, String bbsContent, String fileName) {
		String SQL = "INSERT INTO userBbs VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, courseID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, bbsContent);
			pstmt.setInt(7, 1);
			pstmt.setString(8, fileName);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;			// 데이터베이스 오류
	}
	
	public UserBbs getuBbs(int bbsID) {
		String SQL = "SELECT * from userBbs WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				UserBbs bbs = new UserBbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setCourseID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				bbs.setFileName(rs.getString(8));
				
				return bbs;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return null;
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE userBbs SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent, String fileName) {
		String SQL = "UPDATE userBbs SET bbsTitle = ? , bbsContent = ?, fileName = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, fileName);
			pstmt.setInt(4, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류
	}
}
