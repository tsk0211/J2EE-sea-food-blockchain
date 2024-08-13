package com.user;

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

@WebServlet("/UserOrder")
public class UserOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static int noofnode = Values.nodes;

	public UserOrder() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		PrintWriter pw = response.getWriter();

		String email = (String) request.getSession().getAttribute("loginEmail");
		String msg = "fail";
		int s = 0;

		String productName = request.getParameter("productName");
		String companyname = request.getParameter("companyName");
		String expdate= request.getParameter("expDate");
		String qty = request.getParameter("quantity");

		try {
			String sql = "SELECT * FROM usertable WHERE emailId = '" + email + "';";

			System.out.println(sql);

			Connection c = (Connection) DB_Conn.conn(Values.DB_Name);
			Statement st = (Statement) c.createStatement();

			ResultSet rs = (ResultSet) st.executeQuery(sql);

			if (rs.next()) {

				String userName = rs.getString(rs.findColumn("userName"));
				String userEmail = rs.getString(rs.findColumn("emailId"));

				String timestamp = new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());

				String sqlP = "INSERT INTO product_user_req (productName, companyName, userName, userEmail, expdate, timestamp, quantity, status)"
						+ " VALUES ( '" + productName + "', '" + companyname + "', '" + userName + "', '" + userEmail + "', '" + expdate
						+ "', '" + timestamp + "', '" + qty + "', 'UNSET');";

				Connection con = DB_Conn.conn(Values.DB_Name);
				Statement stmt = con.createStatement();

				s = stmt.executeUpdate(sqlP);
				System.out.println(sqlP + "    ->   " + s);
				if (s != 0) {
					msg = "succ";
				} else {
					msg = "fail";
				}
			} else {
				msg = "fail";
			}

		} catch (Exception e) {
			System.out.println(e);
		}
		pw.println("");
		pw.println("</body></html>");

		response.sendRedirect("userOrder.jsp?msg=" + msg);
	}
}