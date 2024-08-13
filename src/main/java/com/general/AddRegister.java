package com.general;

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

import com.values.Values;

@WebServlet("/AddRegister")
public class AddRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddRegister() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter pw = response.getWriter();

		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String cnfPassword= request.getParameter("cnfPassword");
		String mob_no = request.getParameter("mob_no");
		String role = request.getParameter("role");
		String address= request.getParameter("address");
		
		if (password.equals(cnfPassword)) {
			if (addToDatabase(pw, role, username, email, password, mob_no, address)) {
				response.sendRedirect("index.jsp?succ");
			} else {
				response.sendRedirect("register.jsp?notreg");
			}
		}
	}
	
	private boolean addToDatabase(PrintWriter pw, String role, String username, String email, String password, String mob_no, String address) {
		
		boolean flag= false;
		try {
			Connection con = DB_Conn.conn(Values.DB_Name);

			if (role.equalsIgnoreCase("Distributer")) {
				Statement st1 = con.createStatement();
				String str = "SELECT * FROM distTable WHERE emailId='" + email + "';";
				ResultSet rs1 = ((java.sql.Statement) st1).executeQuery(str);
				
				if (rs1.next()) {
					pw.println("<script> alert('Already Email-ID Exists');</script>");
				} else {
					Statement st = (Statement) con.createStatement();
					String sqlStr= "INSERT INTO distTable(distName, emailId, distPassword, distMobile, distAddress) VALUES ('" +
									username + "','" + email + "','" + password + "','" + mob_no + "', " + "'" + address +"');";
					
					((java.sql.Statement) st).executeUpdate(sqlStr);
					pw.println("<script> alert(' Register Successfully');</script>");
					flag= true;
				}

			} else if (role.equalsIgnoreCase("User")) {

				Statement st1 = con.createStatement();
				String str = "SELECT * FROM userTable WHERE emailId='" + email + "'";
				ResultSet rs1 = ((java.sql.Statement) st1).executeQuery(str);
				
				if (rs1.next()) {
					pw.println("<script> alert('Already Email-ID Exists');</script>");
				} else {
					Statement st = (Statement) con.createStatement();
					String sqlStr= "INSERT INTO userTable(userName, emailId, userPassword, userMobile, userAddress) VALUES ('" +
									username + "','" + email + "','" + password + "','" + mob_no + "', '" + address + "');";
					
					((java.sql.Statement) st).executeUpdate(sqlStr);
					
					pw.println("<script> alert('Register Successfully');</script>");
					flag= true;
				}
			} else {
				flag= false;
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return flag;
	}
}