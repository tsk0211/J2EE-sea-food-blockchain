package com.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;

@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddProduct() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter pw = response.getWriter();
		
		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String Descriptionname = request.getParameter("description");
		String mfgdate = request.getParameter("mfgDate");
		String price = request.getParameter("price");
		String Expirydate = request.getParameter("expDate");
		String qty = request.getParameter("quantity");
		
		
		try {
			Connection con = DB_Conn.conn(Values.DB_Name);
			
			String sql, s= "SELECT productId FROM product_table WHERE productName = '" + productName + "' AND companyName = '" + 
					companyname + "';";
			
			Statement stmt= (Statement) con.createStatement();
			ResultSet rs= (ResultSet) stmt.executeQuery(s);
			
			if (rs.next()) {
				int value= Integer.parseInt(qty) + Integer.parseInt(rs.getString(rs.findColumn("quantity")));
				
				sql= "UPDATE product_table SET quantity = '" + value + "' AND expDate = '" + Expirydate +
						"' WHERE productName = '" + productName + "' AND companyName = '" + companyname + "';";
			} else {
				sql= "INSERT INTO product_table (productName, companyName, mfd, exp, quantity, price, description)" +
						"VALUES ('" + productName +"', '" + companyname + "', '" + mfgdate + "' , '" + Expirydate + 
						"', '" + qty + "', '" + price + "', '" + Descriptionname + "');";
			}
			
			Statement st = (Statement) con.createStatement();
			
			int l= st.executeUpdate(sql);
			
			if (l != 0) {
				pw.println("");
				pw.println("</body></html>");
				response.sendRedirect("./adminAddProduct.jsp?succ");
			} else {
				pw.println("");
				pw.println("</body></html>");
				response.sendRedirect("./adminAddProduct.jsp?fail");
			}
		} catch (Exception e) {
			System.out.println(e);
			pw.println("<html><script>alert(" + e.getMessage() + ");</script><body>");
		}
	}

}
