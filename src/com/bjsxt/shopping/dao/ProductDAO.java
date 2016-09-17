package com.bjsxt.shopping.dao;

import java.util.*;

import com.bjsxt.shopping.Category;
import com.bjsxt.shopping.Product;

public interface ProductDAO {
	public List<Product> getProducts();
	
	public List<Product> getProducts(int pageNo, int pageSize);
	
	public Product getProduct(int id);
	  
	public int findProducts(List<Product> list, int[] categoryId, 
									  String keyword,
									  double lowNormalPrice, 
									  double highNormalPrice, 
									  double lowMemberPrice, 
									  double highMemberPrice,
									  Date startDate,
								      Date endDate,
									  int pageNo,
									  int pageSize);
		
	public boolean deleteProductByCategoryId(int categoryId);
	
	public boolean deleteProductById(int id);
	
	public boolean modifyProductById(int id, Product p);
	
	public boolean updateProduct(Product p);
	
	public boolean addProduct(Product p);

	public int getProducts(List<Product> products, int pageNo, int pageSize);

	public Product loadById(int id);

	public List<Product> getLatestProducts(int count);
	
	public List<Product> getChildrenProduct(Category parent);
}
