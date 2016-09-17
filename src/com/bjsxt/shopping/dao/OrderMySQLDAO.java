package com.bjsxt.shopping.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.bjsxt.shopping.Cart;
import com.bjsxt.shopping.CartItem;
import com.bjsxt.shopping.Category;
import com.bjsxt.shopping.Product;
import com.bjsxt.shopping.SalesItem;
import com.bjsxt.shopping.SalesOrder;
import com.bjsxt.shopping.User;
import com.bjsxt.shopping.util.DB;

public class OrderMySQLDAO {

	public void saveOrder(SalesOrder so) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rsKey = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "insert into salesorder values (null, ?, ?, ?, ?)";
//System.out.println(sql);
//System.out.println(so.getoDate());
			pstmt = DB.getPStmt(conn, sql, true);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getoDate());
			pstmt.setInt(4, so.getStatus());
			pstmt.executeUpdate();
			rsKey = pstmt.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);

//System.out.println(key);
//System.out.println(so.getAddr());
//System.out.println(so.getUser().getUsername());
		
			String sqlItem = "insert into salesitem values (null, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sqlItem);
			Cart c = so.getCart();
			List<CartItem> items = c.getItems();
			
			for(int i=0; i<items.size(); i++) {
				CartItem ci = items.get(i);
//System.out.println(ci.getProductId());
//System.out.println(ci.getPrice());
//System.out.println(ci.getCount());
//System.out.println(key);
				pstmt.setInt(1, ci.getProductId());
				pstmt.setDouble(2, ci.getPrice());
				pstmt.setInt(3, ci.getCount());
				pstmt.setInt(4, key);
				//pstmt.executeUpdate();

				pstmt.addBatch();
			}
			//System.out.println(pstmt.executeBatch());
			pstmt.executeBatch();     //这个方法有问题，上网找解决方法
			conn.commit();
			conn.setAutoCommit(true);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
				DB.closeStmt(pstmt);
				DB.closeRs(rsKey);
				DB.closeConn(conn);
		}
	}

	public int getOrders(List<SalesOrder> list, int pageNo,
			int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;
		try {
			conn = DB.getConn();
			//conn.setAutoCommit(false);
			rsCount = DB.executeQuery(conn, "select count(*) from salesorder");
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			//conn = DB.getConn();
			//conn.setAutoCommit(false);
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status, " +
					" ruser.id uid, ruser.username, ruser.password, ruser.addr uaddr, ruser.phone, ruser.rdate from salesorder" +
					" left join ruser on (salesorder.userid = ruser.id)" +
					" limit " + (pageNo-1)*pageSize + "," + pageSize ;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				
				
				SalesOrder so = new SalesOrder();
				so.setAddr(rs.getString("addr"));
				so.setId(rs.getInt("id"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				so.setUser(u);

				
				list.add(so);
		 
			//conn.commit();
			//conn.setAutoCommit(true);
			}
		} catch(SQLException e) {
				e.printStackTrace();
		}finally {
				DB.closeRs(rs);
				DB.closeRs(rsCount);
				DB.closeConn(conn);
		}	
		return pageCount;
	}

	public SalesOrder loadById(int id) {
		Connection conn = null;
		ResultSet rs = null;
		SalesOrder so = null;
		try {
			conn = DB.getConn();
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status, " +
					" ruser.id uid, ruser.username, ruser.password, ruser.addr uaddr, ruser.phone, ruser.rdate from salesorder" +
					" join ruser on (salesorder.userid = ruser.id) where salesorder.id = " + id;
			
			rs = DB.executeQuery(conn, sql);
		    if(rs.next()) {
				User u = new User();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				
				
				so = new SalesOrder();
				so.setAddr(rs.getString("addr"));
				so.setId(rs.getInt("id"));
				so.setoDate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				so.setUser(u);

			}
		} catch(SQLException e) {
				e.printStackTrace();
		}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return so;
	}

	public List<SalesItem> getSalesItems(SalesOrder salesOrder) {
		Connection conn = null;
		ResultSet rs = null;
		int pageCount = 0;
		List<SalesItem> items = new ArrayList<SalesItem>();
		try {
			conn = DB.getConn();
			String sql = "select salesorder.id, salesorder.userid, salesorder.odate, salesorder.addr, salesorder.status, " +
					     " salesitem.id itemid, salesitem.productid, salesitem.unitprice, salesitem.pcount, salesitem.orderid, " +
					     " product.id pid, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid" +
					     " from salesorder join salesitem on (salesorder.id = salesitem.orderid)" +
					     " join product on (salesitem.productid = product.id) where salesorder.id = " + salesOrder.getId();
System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("pid"));
				p.setCategoryID(rs.getInt("categoryid"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				
				SalesItem si = new SalesItem();
				si.setOrder(salesOrder);
				si.setId(rs.getInt("itemid"));
				si.setCount(rs.getInt("pcount"));
				si.setUnitPrice(rs.getDouble("unitprice"));
				si.setProduct(p);
				
				items.add(si);
			}
		} catch(SQLException e) {
				e.printStackTrace();
		}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return items;
	}

	public void updateStatus(SalesOrder salesOrder) {
		Connection conn = null;
		try {
			conn = DB.getConn();
			String sql = "update salesorder set status = " + salesOrder.getStatus() + " where id = " + salesOrder.getId();
			DB.executeUpdate(conn, sql);
//System.out.println(sql);
		} finally {
			DB.closeConn(conn);
		}
	}

}
