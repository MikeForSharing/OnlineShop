package com.bjsxt.shopping;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.bjsxt.shopping.util.DB;

public class User {
	private int id;
	private String username;
	private String password;
	private String phone;
	private String addr;
	private Timestamp rdate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Timestamp getRdate() {
		return rdate;
	}
	public void setRdate(Timestamp rdate) {
		this.rdate = rdate;
	}
	
	public static void deleteUser(int id) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = DB.getConn();
			stmt = DB.getStmt(conn); 
			stmt.executeUpdate("delete from ruser where id =" + id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
	}
	
	public void save() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "insert into ruser values(null, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, phone);
			pstmt.setString(4, addr);
			pstmt.setTimestamp(5, rdate);
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
	}
	
	public static List<User> getUsers() {
		List<User> list = new ArrayList<User>();
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from ruser";
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setAddr(rs.getString("addr"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				list.add(u);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
		return list;
	}
	
	
	 public static void delete(int id) {
		 Connection conn = null;
		 try {
			 conn = DB.getConn();
			 String sql = "delete from ruser where id =" + id;
			 DB.executeQuery(conn, sql);
		 } finally {
			 DB.closeConn(conn);
		 }
	 }
	 //自己写的另一种判断用户名和密码的方法
	 public static boolean userExists(String username) {
		 Connection conn = null;
		 ResultSet rs = null;
		 boolean a = false;
		 try {
			 conn = DB.getConn();
			 String sql = "select * from ruser where username = '"  + username + "'";
System.out.println(sql);
			 rs = DB.executeQuery(conn, sql);
		
			 a = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			 DB.closeRs(rs);
			 DB.closeConn(conn);	 
		}
		 
		if(a) {
			return true;
		} else {
			return false;
			//System.out.println("用户名不存在");
		}
	 }
	 
	 public static User validate(String username, String password) throws UserNotFoundException, PasswordNotCorrectException {

			Connection conn = null;
			ResultSet rs = null;
			User u = null;
			try {
				conn = DB.getConn();
				String sql = "select * from ruser where username = '" + username + "'";
				rs = DB.executeQuery(conn, sql);
				if(!rs.next()) {
					throw new UserNotFoundException();
				} else if(!rs.getString("password").equals(password)) {
					throw new PasswordNotCorrectException();
				} else {
					u = new User();
					u.setId(rs.getInt("id"));
					u.setAddr(rs.getString("addr"));
					u.setUsername(rs.getString("username"));
					u.setPassword(rs.getString("password"));
					u.setPhone(rs.getString("phone"));
					u.setRdate(rs.getTimestamp("rdate"));
				}
				
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
			}
			return u;
	 }
	 
	 public void update() {
		 Connection conn = null;
			PreparedStatement pstmt = null;
			try {
				conn = DB.getConn();
				String sql = "update ruser set username = ?, phone = ?, addr = ? where id = " + this.id;
				pstmt = DB.getPStmt(conn, sql);
				pstmt.setString(1, username);
				pstmt.setString(2, phone);
				pstmt.setString(3, addr);
				pstmt.executeUpdate();
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeStmt(pstmt);
				DB.closeConn(conn);
			}
	 }


}
