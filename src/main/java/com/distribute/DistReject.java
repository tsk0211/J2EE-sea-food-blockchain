package com.distribute;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;

@WebServlet("/DistReject")
public class DistReject extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public DistReject() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		int st= 0;
		
		try {
			Connection con = (Connection) DB_Conn.conn(Values.DB_Name);
			String msg="Reject Request";
			Statement stRegister101=con.createStatement();
			
			st= stRegister101.executeUpdate("UPDATE product_user_req SET status='" + msg + "' WHERE id='" + id + "';");		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (st != 0) {
			response.sendRedirect("distUserOrders.jsp?succ");
		} else {
			response.sendRedirect("distUserOrders.jsp?fail");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}