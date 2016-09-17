package com.bjsxt.shopping;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import com.bjsxt.shopping.dao.ProductDAO;
import com.bjsxt.shopping.dao.ProductMySQLDAO;
import com.bjsxt.shopping.util.DB;

public class ProductMgr {
	
	private static ProductMgr pm = null;     //单例模式
	private int pageCount = 0;
	
	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	static {
		if(pm == null) {
			pm = new ProductMgr();
			//此时应该看配置文件中设置什么样的dao对象
			pm.setDao(new ProductMySQLDAO());
		}
	}
	
	private ProductMgr() {
		
	}
	
	public static ProductMgr getInstance() {
		return pm;
	}
	
	ProductDAO dao = null;
	
	public ProductDAO getDao() {
		return dao;
	}

	public void setDao(ProductDAO dao) {
		this.dao = dao;
	}

	public List<Product> getProducts() {
		return dao.getProducts();
	}
	
	public List<Product> getProducts(int pageNo, int pageSize) {
		return dao.getProducts(pageNo, pageSize); 
	}
	
	public int getProducts(List<Product> products, int pageNo, int pageSize) {
		return dao.getProducts(products, pageNo, pageSize);
	}
	
	public Product getProduct(int id) {
		return dao.getProduct(id);
	}
	
	public int findProducts(List<Product> list, int[] categoryId,     //这个层还有对参数的检测
									  String keyword,
									  double lowNormalPrice, 
									  double highNormalPrice, 
									  double lowMemberPrice, 
									  double highMemberPrice,
									  Date startDate,
								      Date endDate,
									  int pageNo,
									  int pageSize) {
									
		return dao.findProducts(list, categoryId, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, startDate, endDate, pageNo, pageSize);
	}
	

	
	public List<Product> findProducts(String name) {
		return null;
	}
	
	public boolean deleteProductByCategoryId(int categoryId) {
		
		return dao.deleteProductByCategoryId(categoryId);
	}
	
	public boolean deleteProductById(int id) {
		return dao.deleteProductById(id); 
	}
	
	public boolean modifyProductById(int id, Product p) {
		return dao.modifyProductById(id, p);
	}	
	
	public boolean updateProduct(Product p) {
		return dao.updateProduct(p);
	}
	
	public boolean addProduct(Product p) {
		return dao.addProduct(p);
	}
	
	public Product loadById(int id) {
		return dao.loadById(id);
	}
	
	public boolean update(Product p) {
		return false;
	}
	
	public List<Product> getLatestProducts(int count) {
		return dao.getLatestProducts(count);
	}
	
	public List<Product> getChildrenProduct(Category parent) {
		return dao.getChildrenProduct(parent);
	}
}
