package com.general;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.values.Values;

@WebServlet("/AddLogin")
public class AddLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddLogin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		HttpSession session = request.getSession();
		session.invalidate();

		out.println("<script type=\"text/javascript\">");
		out.println("alert('You are successfully logged out!');");
		out.println("</script>");
		request.getRequestDispatcher("index.jsp").include(request, response);
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(true);
		PrintWriter pw = response.getWriter();
		
		RequestDispatcher rd;
		
		String emailId = request.getParameter("email");
		String pwd = request.getParameter("password");
		String roll = request.getParameter("role");
		
		session.setAttribute("loginEmail", emailId);
		
		try {
			
			if (roll.equals("Admin")) {
				if (emailId.equals(Values.admin_email) && pwd.equals(Values.admin_pass)) {
					pw.println("<html><script>alert('Login Successfully as Admin.');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("./adminHome.jsp?succ");

				} else {
					pw.println("<html><script>alert('Incorrect Email Id or Password.....');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("index.jsp?invalid");
				}
				
			} else if (roll.equals("Distributer")) {
				rd= request.getRequestDispatcher("distHome.jsp?succ");
				Connection con = DB_Conn.conn(Values.DB_Name);
				Statement st = (Statement) con.createStatement();
				ResultSet rs;
				
				String str = "select * from distTable where emailId='" + emailId + "' and distPassword='" + pwd + "'";

				rs = ((java.sql.Statement) st).executeQuery(str);
				
				if (rs.next()) {
					session.setAttribute("emailId", emailId);
					session.setAttribute("distMobile", rs.getString("distMobile"));
					session.setAttribute("distName", rs.getString("distName"));
					
										
					pw.println("<html><script>alert('Login Successfully');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					request.setAttribute("email", emailId);
					rd.forward(request, response);
					
				} else {
					pw.println("<html><script>alert('Incorrect Email Id or Password.....');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("index.jsp?invalid");
				}
				
			} else if (roll.equals("User")) {
				
				Connection con = DB_Conn.conn(Values.DB_Name);
				Statement st = (Statement) con.createStatement();
				ResultSet rs;
				String str = "select * from userTable where emailId='" + emailId + "' and userPassword='" + pwd + "'";
				
				rs = ((java.sql.Statement) st).executeQuery(str);
				
				if (rs.next()) {
					session.setAttribute("emailId", emailId);
					session.setAttribute("userMobile", rs.getString("userMobile"));
					session.setAttribute("userName", rs.getString("userName"));
					session.setAttribute("userAddress", rs.getString("userAddress"));
					
					pw.println("<html><script>alert('Login Successfully');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					rd= request.getRequestDispatcher("userHome.jsp?succ");
					request.setAttribute("email", emailId);
					rd.forward(request, response);
				} else {
					pw.println("<html><script>alert('Incorrect Email Id or Password.....');</script><body>");
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("index.jsp?invalid");
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}