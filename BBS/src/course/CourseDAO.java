package course;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CourseDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	/* 실제로 DB에 접근해서 데이터 가져오거나 데이터를 넣는 역할하는 데이터 접근 개체 */
	public CourseDAO() {
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
	
	public ArrayList<Course> getList(String userID, String userLevel) {
		String SQL = null;
		if(userLevel != null) {
			if(userLevel.equals("교수"))
				SQL = "SELECT * FROM COURSE, LECTURE WHERE ccode=lccode AND lpcode = ?";
			if(userLevel.equals("학생"))
				SQL = "SELECT * FROM COURSE, REGISTER WHERE ccode=rccode AND rscode = ?";
		}
		ArrayList<Course> list = new ArrayList<Course>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Course course = new Course();
				course.setCcode(rs.getString(1));
				course.setCname(rs.getString(2));
				course.setCtime(rs.getString(3));
				course.setCroom(rs.getString(4));
				
				list.add(course);				
			}			
		}catch(Exception e){
			e.printStackTrace();
		}		
		return list;		// 데이터베이스 오류
	}
	
	public ArrayList<Student> getStd(String courseID) {
		String SQL = null;
		
		SQL = "SELECT * FROM STUDENT WHERE scode IN (SELECT rscode FROM REGISTER WHERE rccode = ?)";
			
		ArrayList<Student> list = new ArrayList<Student>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, courseID);			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Student std = new Student();
				std.setScode(rs.getString(1));
				std.setSname(rs.getString(2));
				std.setSdept(rs.getString(3));
				std.setSemail(rs.getString(4));
				
				list.add(std);				
			}			
		}catch(Exception e){
			e.printStackTrace();
		}		
		return list;		// 데이터베이스 오류
	}
	
	public String getCoursecode(String ccode) {
		String SQL = "SELECT cname FROM COURSE WHERE ccode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, ccode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
