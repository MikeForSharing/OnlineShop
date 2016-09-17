package com.bjsxt.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.*;

import com.bjsxt.shopping.Category;
import com.bjsxt.shopping.Product;
import com.bjsxt.shopping.util.DB;

public class ProductMySQLDAO implements ProductDAO  {
	
	public List<Product> getChildrenProduct(Category parent) {
		Connection conn = null;
		List<Product> children = new ArrayList<Product>();
		ResultSet rs = null;
		try {
			conn = DB.getConn();
			String sql = "select * from product where categoryid = " + parent.getId();
//System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				children.add(p);				
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
			
		}
		return children;
	}	
	
	
	
	
	
	public List<Product> getProducts() {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select * from product";
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				list.add(p);
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return list;
	}
	
	public List<Product> getProducts(int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid " +
					", category.id cid,  category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade " +
					" from product join category on (product.categoryid = category.id) limit " + (pageNo-1)*pageSize + "," + pageSize ;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				
				
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setDescr(rs.getString("cdescr"));
				c.setName(rs.getString("cname"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
				list.add(p);
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return list;
	}
	
	
	public int findProducts(List<Product> list, int[] categoryId, 
									  String keyword, 
									  double lowNormalPrice, 
									  double highNormalPrice, 
									  double lowMemberPrice, 
									  double highMemberPrice,
									  Date startDate,
								      Date endDate,
									  int pageNo,
									  int pageSize) {
									
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select * from product where 1 = 1 ";
			
			
			String strId = "";
			if(categoryId != null && categoryId.length > 0) {
				strId += '(';
				for(int i=0; i<categoryId.length; i++) {
					if(i < categoryId.length -1) {
						strId += categoryId[i] + ",";
					} else {
						strId += categoryId[i];
					}
				}
				strId += ")";
				sql += " and categoryid in " + strId;
			}
			
			if(keyword != null &&  !keyword.trim().equals("")) {
				sql += " and name like '%" + keyword + "%' or descr like '%" + keyword + "%'";
			}
			
			if(lowNormalPrice >= 0) {
				sql += " and normalprice > " + lowNormalPrice;
			}
			
			if(highNormalPrice > 0) {
				sql += " and normalprice < " + highNormalPrice;
			}
			
			if(lowMemberPrice >= 0) {
				sql += " and memberprice > " + lowMemberPrice;
			}
			
			if(highMemberPrice >= 0) {
				sql += " and memberprice < " + highMemberPrice;
			}
			
			if(startDate != null) {
				sql += " and pdate >= '" + new SimpleDateFormat("yyyy-MM-dd").format(startDate) + "'";
			}
			
			if(endDate != null) {
				sql += " and pdate >= '" + new SimpleDateFormat("yyyy-MM-dd").format(endDate) + "'";
			}
			
			
			String sqlCount = sql.replaceFirst("select \\*", "select count(*)");
//System.out.println("sqlCount:" + sqlCount);
			sql += " limit " + (pageNo-1)*pageSize + "," + pageSize;
//System.out.println(sql);
			
			

			rsCount = DB.executeQuery(conn, sqlCount);
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			
			
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				list.add(p);
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return pageCount;
	}  
			
	
	public boolean deleteProductByCategoryId(int categoryId) {
		Connection conn = null;
		Statement stmt = null;
		int i = 0;
		try {
			conn = DB.getConn();
			stmt = DB.getStmt(conn); 
			
			i = stmt.executeUpdate("delete from product where categoryid = " + categoryId);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}
		
		return true;
	}
	
	public boolean deleteProductById(int id) {
		Connection conn = null;
		Statement stmt = null;
		int i = 0;
		try {
			conn = DB.getConn();
			stmt = DB.getStmt(conn); 
			
			i = stmt.executeUpdate("delete from product where id = " + id);
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			DB.closeStmt(stmt);
			DB.closeConn(conn);
		}

		return true;
		
	}
	
	public boolean updateProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			//conn.setAutoCommit(false);
			String sql = "update product set name=?, descr=?, normalprice=?, memberprice=?, categoryid=? where id=?";
//System.out.println(sql);
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setInt(5, p.getCategoryID());
			pstmt.setInt(6, p.getId());
			pstmt.executeUpdate();
		
			//conn.commit();
			//conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
				return false;
			}finally {
				DB.closeStmt(pstmt);
				DB.closeConn(conn);
		}		
		return true;
	}

	@Override
	public boolean addProduct(Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?)";
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, p.getPdate());
			pstmt.setInt(6, p.getCategoryID());
			pstmt.executeUpdate();
		
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
				return false;
			}finally {
				DB.closeStmt(pstmt);
				DB.closeConn(conn);
		}		
		return true;
	}

	@Override
	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		Connection conn = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		int pageCount = 0;
		try {
			conn = DB.getConn();
			//conn.setAutoCommit(false);
			rsCount = DB.executeQuery(conn, "select count(*) from product");
			rsCount.next();
			pageCount = (rsCount.getInt(1) + pageSize - 1) / pageSize;
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid " +
					", category.id cid,  category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade " +
					" from product join category on (product.categoryid = category.id) limit " + (pageNo-1)*pageSize + "," + pageSize ;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				
				
				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setDescr(rs.getString("cdescr"));
				c.setName(rs.getString("cname"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				p.setCategory(c);
				products.add(p);
		 
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

	@Override
	public boolean modifyProductById(int id, Product p) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DB.getConn();
			String sql = "update product set name = ?, descr = ? where id = " + id;    //等到产品价格的double转换问题弄好，在加上价格的改变
			pstmt = DB.getPStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}finally {
			DB.closeStmt(pstmt);
			DB.closeConn(conn);
		}
		return false;
	}

	@Override
	public Product getProduct(int id) {
		Connection conn = null;
		ResultSet rs = null;
		Product p = null;
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select * from product where id = " + id;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				//list.add(p);
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return p;
	}

	//如果数据库中没有，返回值就是空值
	public Product loadById(int id) {
		Product p = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select product.id, product.name, product.descr, product.normalprice, product.memberprice, product.pdate, product.categoryid " +
					", category.id cid,  category.name cname, category.descr cdescr, category.pid, category.isleaf, category.grade " +
					" from product join category on (product.categoryid = category.id) where product.id = " + id;
			//System.out.println(sql);
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));

				Category c = new Category();
				c.setId(rs.getInt("cid"));
				c.setDescr(rs.getString("cdescr"));
				c.setName(rs.getString("cname"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				c.setGrade(rs.getInt("grade"));
				
				p.setCategory(c);
			
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}
		return p;
	}

	@Override
	public List<Product> getLatestProducts(int count) {
		Connection conn = null;
		ResultSet rs = null;
		List<Product> list = new ArrayList<Product>();
		try {
			conn = DB.getConn();
			conn.setAutoCommit(false);
			String sql = "select * from product order by pdate desc limit 0," + count;
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				p.setCategoryID(rs.getInt("categoryid"));
				list.add(p);
			}
		 
			conn.commit();
			conn.setAutoCommit(true);
			
			} catch(SQLException e) {
				e.printStackTrace();
			}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
		return list;	}
}
