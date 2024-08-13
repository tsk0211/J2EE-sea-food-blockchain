package com.admin;

import java.io.IOException;
import java.sql.*;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.general.DB_Conn;
import com.values.Values;

@WebServlet("/Reject")
public class RejectRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public RejectRequest() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String[] mid=id.split(",");
		
		int op= 1;
		
		try {
			Connection con = (Connection) DB_Conn.conn(Values.DB_Name);
			String msg="Reject Request";
			Statement stRegister101=con.createStatement();
			
			op= stRegister101.executeUpdate("UPDATE product_user_req SET status='" + msg + "' WHERE id='" + mid[1] + "' AND productName='" + mid[0] + "';");		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (op != 0) {
			response.sendRedirect("adminDistReq.jsp?update");
		} else {
			response.sendRedirect("adminDistReq.jsp?noreq");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
