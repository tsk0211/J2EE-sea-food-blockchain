package com.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.values.Values;
import com.general.DB_Conn;


@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static int noofnode = Values.nodes;

	public UpdateProduct() {
		super();	
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id= "1";
		
		if (request.getParameter("id") != null) {
			id= request.getParameter("id");
		}
		
		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String Descriptionname = request.getParameter("description");
		String mfgdate = request.getParameter("mfgDate");
		String price = request.getParameter("price");
		String Expirydate = request.getParameter("expDate");
		String qty = request.getParameter("quantity");
		
		String sql= "UPDATE product_table SET `productName` = '" + productName + "', `companyName` = '" + companyname + "',"
				+ "`mfd` = '" + mfgdate + "', `exp` = '" + Expirydate + "', `quantity` = '" + qty + "', `price` = '" +
				price + "', `description` = '" + Descriptionname + "'  WHERE `productId` = '" + id + "';";
		try {
			Connection con = DB_Conn.conn(Values.DB_Name);
			Statement stmt = con.createStatement();
			
			int i= stmt.executeUpdate(sql);
			
			if (i != 0) {
				id = "succ";
			} else {
				id= "fail";
			}
			
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
		response.sendRedirect("./adminUpdateProducts.jsp?" + id);
	}

}
