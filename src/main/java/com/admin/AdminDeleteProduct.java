package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;


@WebServlet("/AdminDeleteProduct")
public class AdminDeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminDeleteProduct() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		try {
			Connection conn= (Connection) DB_Conn.conn(Values.DB_Name);
			Statement stmt= (Statement) conn.createStatement();
			PrintWriter pw = response.getWriter();
			
			String sql= "DELETE FROM product_table WHERE productId = " + id + ";";
			
			int flag= stmt.executeUpdate(sql);
			
			if (flag == 0) {
				pw.println("<html><script>alert('Product Is deleted successfully');</script><body>");
				pw.println("");
				pw.println("</body></html>");
			} else {
				pw.println("<html><script>alert('Something is wrong');</script><body>");
				pw.println("");
				pw.println("</body></html>");
			}
			
			response.sendRedirect("adminUpdateProducts.jsp?Updated");
			} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}