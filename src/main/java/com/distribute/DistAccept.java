package com.distribute;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.Date;
import java.util.HashMap;
import java.util.Map.Entry;
import java.text.SimpleDateFormat;

import com.qr_code.Create_QR;
import com.general.DB_Conn;
import com.values.Values;

/* QR code Creation File */

@WebServlet("/DistAccept")
public class DistAccept extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DistAccept() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String[] arr = id.split(",");
		
		
		PrintWriter pw = response.getWriter();
		String distEmail = (String) request.getSession().getAttribute("loginEmail");
		
		try {
			Connection con = (Connection) DB_Conn.conn(Values.DB_Name);
			String msg = "Accepted";
			int oldqty = 0, oqty;
			
			HashMap <String, Integer> manager= new HashMap<String, Integer>();
			
			String order_qty = "", cn = "", userEmail= "", pn = "", desc = "", mfg = "", pr = "", exp = "";
			
			String sql1= "SELECT * FROM product_user_req WHERE id='" + arr[1] + "';";
			String sql2= "", qty;
			
			Statement st1 = (Statement) con.createStatement();
			ResultSet rs1 = st1.executeQuery(sql1);
			
			if (rs1.next()) {
				userEmail = rs1.getString(rs1.findColumn("userEmail"));
				order_qty = rs1.getString(rs1.findColumn("quantity"));
				cn= rs1.getString(rs1.findColumn("companyName"));
				pn= rs1.getString(rs1.findColumn("productName"));
				
				String reqDate= (String) new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis() + 86400 * 1000 * 2));
				
				sql2= "SELECT * FROM dist_product_table WHERE productName = '" + pn + "' AND companyName = '" + cn +
						"' AND distEmail = '" + distEmail + "' AND expdate > '" + reqDate + "';";
				
				Statement st2 = (Statement) con.createStatement();
				ResultSet rs2 = st2.executeQuery(sql2);
				
				while (rs2.next()) {
					desc = rs2.getString(rs2.findColumn("description"));
					mfg = rs2.getString(rs2.findColumn("mfgdate"));
					pr = rs2.getString(rs2.findColumn("price"));
					exp = rs2.getString(rs2.findColumn("expdate"));
					qty = rs2.getString(rs2.findColumn("quantity"));
					
					manager.put(exp, Integer.parseInt(qty));
					
					oldqty = oldqty + Integer.parseInt(qty);
				}
				
				oqty = Integer.parseInt(order_qty);
				
				if (oqty <= oldqty) {
					String timestamp= new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());
					
					String sql3= "";
					Statement st3;
					
					for (Entry<String, Integer> entry : manager.entrySet()) {
						if (oqty > entry.getValue()) {
							sql3= "UPDATE dist_product_table SET quantity = '0' WHERE productName = '" +
									pn + "' AND companyName = '" + cn + "' AND expdate = '" + entry.getKey() + "' ;";
							
							st3= (Statement) con.createStatement();
							st3.executeUpdate(sql3);
							oqty = oqty - entry.getValue();
						} else {
							sql3= "UPDATE dist_product_table SET quantity = '" + (entry.getValue() - oqty) + "' WHERE productName = '" +
									pn + "' AND companyName = '" + cn + "' AND expdate = '" + entry.getKey() + "' ;";
							
							st3= (Statement) con.createStatement();
							st3.executeUpdate(sql3);
							break;
						}
					}
					
					String sql4= "UPDATE product_user_req SET status='" + msg + "' WHERE id ='" + arr[1] + "';";
					Statement st4= (Statement) con.createStatement();
					st4.executeUpdate(sql4);					
					
					double total_qty= Double.parseDouble(pr) * Double.parseDouble(order_qty);
					
					String sql5= "INSERT INTO user_orders (distEmail, userEmail, quantity, productName, companyName, timestamp, totalAmt," + 
							" status) VALUES ('" + distEmail + "','" + userEmail + "' , '" + order_qty + "','" + pn + "', '" + cn +
							"','" + timestamp + "','" + total_qty + "', 'Accepted');";
					
					Statement st5= (Statement) con.createStatement();
					st5.executeUpdate(sql5);
					
					String path= Values.filePath + "\\" + userEmail + "-" + timestamp;
					
					File file= new File(path);
					if (file.mkdir()) {
						path= path + "\\" + userEmail + "_" + timestamp + ".png";
						
						file= new File(path);
						file.createNewFile();
					}
					
					// Creating QR code
					String datainfo = Values.concatStrings(pn, cn, timestamp, desc, mfg, "" + total_qty, exp, arr[1], userEmail, Values.User, distEmail);
					
					Create_QR.CreateQR(datainfo, path);
					
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("./distUserOrders.jsp?succ");
				} else {
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("./distUserOrders.jsp?stock");
				}
				
			} else {
				pw.println("");
				pw.println("</body></html>");
				response.sendRedirect("distUserOrders.jsp?noreq");
			}
		} catch (Exception e0) {
			e0.printStackTrace();
		}
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

	
}