package com.distribute;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;


@WebServlet("/DistOrder")
public class DistOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static int noofnode = Values.nodes;

	public DistOrder() {
		super();	
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter pw = response.getWriter();
		
		String email= (String) request.getSession().getAttribute("loginEmail");
		
		
		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String qty = request.getParameter("quantity");
		int status= 0;
		
		try {
			String sql= "SELECT * FROM disttable WHERE emailId = '" + email + "';";
			
			System.out.println(sql);
			
			Connection c = (Connection) DB_Conn.conn(Values.DB_Name);
			Statement st= (Statement) c.createStatement();
			
			ResultSet rs= (ResultSet) st.executeQuery(sql);
			
			rs.next();
			
			String distName= rs.getString(rs.findColumn("distName"));
			String distEmail= rs.getString(rs.findColumn("emailId"));
			
			String timestamp= new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());
			
			String sqlP= "INSERT INTO product_dist_req (productName, companyName, distName, distEmail, timestamp, quantity, status)" +
					" VALUES ( '" + productName + "', '" + companyname + "', '" + distName + "', '" + distEmail + "', '" +
					timestamp + "', '" + qty + "', 'UNSET');";
			
			Connection con = DB_Conn.conn(Values.DB_Name);
			Statement stmt = con.createStatement();
			
			status= stmt.executeUpdate(sqlP);
			Thread.sleep(2000);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		pw.println("");
		pw.println("</body></html>");
		
		
		if (status != 0) {
			response.sendRedirect("distOrderProducts.jsp?succ");			
		} else {
			response.sendRedirect("distOrderProducts.jsp?invalid");
		}

	}

}
