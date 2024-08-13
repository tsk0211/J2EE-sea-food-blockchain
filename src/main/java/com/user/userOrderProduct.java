package com.user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;
import com.blockchain.Transaction;

@WebServlet("/UserOrderProduct")
public class userOrderProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static int noofnode = Values.nodes;
	
	public userOrderProduct() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email= (String) request.getSession().getAttribute("loginEmail");
		String userEmail= "";
		int id= 0;
		
		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String distAddress = request.getParameter("address");
		String amount = request.getParameter("totalAmt");
		String mobile = request.getParameter("mobile");
		String qty = request.getParameter("quantity");
		
		String userReqId= (String) request.getSession().getAttribute("distReqId");
		
		// User Info
		try {
			String sl= "SELECT * FROM product_user_req WHERE id = '" + userReqId + "';";
			Connection c= (Connection) DB_Conn.conn(Values.DB_Name);
			Statement s= (Statement) c.createStatement();
			
			ResultSet r= (ResultSet) s.executeQuery(sl);
			
			if (r.next()) {
				userEmail= r.getString(r.findColumn("userEmail"));
			}
		} catch (Exception e0) {
			e0.printStackTrace();
		}
		
		String sql= "SELECT * FROM product_table WHERE productName = '" + productName + "' and companyName = '" + companyname + "';";
		
		try {
			Connection con= (Connection) DB_Conn.conn(Values.DB_Name);
			Statement st= (Statement) con.createStatement();
			ResultSet rs= (ResultSet) st.executeQuery(sql);
			
			if (rs.next()) {
				id = rs.getInt(rs.findColumn("productId"));
			}
		} catch (Exception e0) {
			e0.printStackTrace();
		}
		
		String timestamp= new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());
		
		Transaction tr= new Transaction(userEmail, email, mobile, productName, companyname, timestamp, qty, amount, distAddress, id);
		
		
		String sl2= "UPDATE `supplychaindb`.`product_user_req` SET `status` = 'Shipped' WHERE `id` = '" + userReqId + "';";
		
		HttpSession s= request.getSession();
		
		s.setAttribute("sl", sl2);
		s.setAttribute("transaction", tr);
		
		RequestDispatcher rd= request.getRequestDispatcher("./PaymentPage.jsp");
		rd.forward(request, response);
	}

}