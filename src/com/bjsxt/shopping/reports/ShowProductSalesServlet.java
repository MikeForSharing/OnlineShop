package com.bjsxt.shopping.reports;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import com.bjsxt.shopping.SalesOrder;
import com.bjsxt.shopping.User;
import com.bjsxt.shopping.util.DB;

/**
 * Servlet implementation class ShowProductSalesServlet
 */
public class ShowProductSalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowProductSalesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    private DefaultCategoryDataset categoryDataset = new DefaultCategoryDataset();
    private DefaultPieDataset pieDataset = new DefaultPieDataset();
    
    private void getDataSet() { 
        Connection conn = null;
		ResultSet rs = null;
		int pageCount = 0;
		try {
			conn = DB.getConn();

			String sql = "select p.name, sum(pcount) from product p join salesitem si on (p.id = si.productid) group by p.id"; 
			rs = DB.executeQuery(conn, sql);
			while(rs.next()) {
				categoryDataset.addValue(rs.getInt(2), "", rs.getString(1));
				pieDataset.setValue(rs.getString(1), rs.getInt(2));
			}
		} catch(SQLException e) {
				e.printStackTrace();
		}finally {
				DB.closeRs(rs);
				DB.closeConn(conn);
		}	
    } 
  

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		getDataSet(); 
        JFreeChart chartCategory = ChartFactory.createBarChart3D( 
                           "产品销量图", // 图表标题
                           "产品", // 目录轴的显示标签
                           "销量", // 数值轴的显示标签
                            categoryDataset, // 数据集
                            PlotOrientation.VERTICAL, // 图表方向：水平、垂直
                            true,  // 是否显示图例(对于简单的柱状图必须是 false)
                            false, // 是否生成工具
                            false  // 是否生成 URL 链接
                            ); 
        JFreeChart pieChart = ChartFactory.createPieChart("水果产量图",  // 图表标题
       		 pieDataset, 
       		 true, // 是否显示图例
       		 false, 
       		 false 
       		 ); 
                           
        FileOutputStream category_jpg = null;
        FileOutputStream pie_jpg = null;
        try { 
            category_jpg = new FileOutputStream("E:\\Eclipse\\MyEclipseWorkspaceV3\\Shopping\\WebContent\\admin\\images\\reports\\productsales.jpg"); 
            ChartUtilities.writeChartAsJPEG(category_jpg,1.0f,chartCategory,400,300,null); 
            
            pie_jpg = new FileOutputStream("E:\\Eclipse\\MyEclipseWorkspaceV3\\Shopping\\WebContent\\admin\\images\\reports\\productsales_pie.jpg"); 
            ChartUtilities.writeChartAsJPEG(pie_jpg,1.0f,pieChart,400,300,null); 
            
            
            this.getServletContext().getRequestDispatcher("/admim/ShowProductSalesChart.jsp").forward(request, response);
        } finally { 
            try { 
                category_jpg.close(); 
                pie_jpg.close();
            } catch (Exception e) {} 
        } 	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
