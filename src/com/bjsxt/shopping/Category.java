package com.bjsxt.shopping;
import java.util.*;


public class Category {
	int id;
	String name;
	String descr;
	int pid;
	boolean leaf;
	int grade;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	
	public void addChild(Category c) {
		Category.addChildCategory(id, c.getName(), c.getDescr());
	}
	
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public void add(Category c) {
		CategoryDAO.save(c);
	}
	
	public static void addTopCategory(String name, String descr) {
		/*
		Category c = new Category();
		c.setName(name);
		c.setId(-1);
		c.setDescr(descr);
		c.setGrade(1);
		c.setLeaf(true);
		c.setPid(0);
		CategoryDAO.save(c);
		//add(c);
		 */
		
		addChildCategory(0, name, descr);
	}
	
	public static List<Category> getCategories() {
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getCategories(list, 0);
		return list;
	}
	
	public static void addChildCategory(int pid, String name, String descr) {
		CategoryDAO.addChildCategory(pid, name, descr);
	}
	
	public static Category loadById(int id) {
		return CategoryDAO.loadById(id);
	}
	
	
	public static List<Category> getChildren(Category parent) {
		return CategoryDAO.getChildren(parent);
	}
	
	
	public static boolean isLeaf(int id) {
		return false;
	}
}
