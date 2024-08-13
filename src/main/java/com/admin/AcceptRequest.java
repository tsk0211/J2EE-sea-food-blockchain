package com.admin;

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
import java.text.SimpleDateFormat;

import com.qr_code.Create_QR;
import com.general.DB_Conn;
import com.values.Values;

/* QR code Creation File */

@WebServlet("/Accept")
public class AcceptRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AcceptRequest() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String[] arr = id.split(",");
		
		
		PrintWriter pw = response.getWriter();
		
		try {
			Connection con = (Connection) DB_Conn.conn(Values.DB_Name);
			String qty = "", distEmail = "";
			String msg = "Accepted";

			int oldqty = 0;
			String cn, productName = "", CompanyName = "", DescriptionName = "", MFGDate = "", Price = "", ExpiryDate = "";
			
			String sql1= "SELECT * FROM product_dist_req WHERE id='" + arr[1] + "';";
			String sql2= "";
			
			Statement st = (Statement) con.createStatement();
			ResultSet rsLogin12 = st.executeQuery(sql1);
			
			if (rsLogin12.next()) {
				distEmail = rsLogin12.getString(rsLogin12.findColumn("distEmail"));
				qty = rsLogin12.getString(rsLogin12.findColumn("quantity"));
				cn= rsLogin12.getString(rsLogin12.findColumn("companyName"));
				
				sql2= "SELECT * FROM product_table WHERE productName='" + arr[0] + "' AND companyName= '" + cn + "';";
				
				Statement stRegister = (Statement) con.createStatement();
				ResultSet rs = stRegister.executeQuery(sql2);
				
				if (rs.next()) {
					productName = rs.getString(rs.findColumn("productName"));
					CompanyName = rs.getString(rs.findColumn("companyName"));
					DescriptionName = rs.getString(rs.findColumn("description"));
					MFGDate = rs.getString(rs.findColumn("mfd"));
					Price = rs.getString(rs.findColumn("price"));
					ExpiryDate = rs.getString(rs.findColumn("exp"));
					oldqty = rs.getInt(rs.findColumn("quantity"));
					
					Statement st101 = con.createStatement();
					int order_qty = Integer.parseInt(qty);
					
					String sql3, sql4, sql5;
					
					// Quantity Check
					if (order_qty <= oldqty) {
						int totalqty = oldqty - order_qty;
						double price= Double.valueOf(Price);
						String timestamp= new SimpleDateFormat("yyyy-MM-dd hh.mm.ss").format(new Date());
						
						sql3 = "UPDATE product_table SET quantity='" + totalqty + "' WHERE productName='" + arr[0] + "' and companyName = '" + CompanyName + "';";
						sql4 = "UPDATE product_dist_req SET status='" + msg + "' WHERE id ='" + arr[1] + "' and productName='" + arr[0] + "';";
						sql5= "INSERT INTO dist_orders (distEmail, quantity, productName, companyName, timestamp, totalAmt, status) VALUES ('" +
								arr[2] + "','" + order_qty + "','" + productName + "','" + CompanyName + "','" + timestamp + "','"+ 
								(price*order_qty) + "', 'Accepted');";
						
						st101.executeUpdate(sql3);
						Statement stRegister101 = con.createStatement();
						
						stRegister101.executeUpdate(sql4);
						
						Statement stmt= (Statement) con.createStatement();
						stmt.execute(sql5);
						
						String path= Values.filePath + "\\" + distEmail + "-" + timestamp;
						
						File file= new File(path);
						if (file.mkdir()) {
							path= path + "\\" + distEmail + "_" + timestamp + ".png";
							
							file= new File(path);
							file.createNewFile();
						}
						
						// Creating QR code
						String datainfo = Values.concatStrings(productName, CompanyName, timestamp, DescriptionName, MFGDate, Price, ExpiryDate, arr[1], distEmail, Values.Dist);
						
						Create_QR.CreateQR(datainfo, path);
						
						pw.println("");
						pw.println("</body></html>");
						response.sendRedirect("adminDistReq.jsp?updated");
						
					} else {
						pw.println("");
						pw.println("</body></html>");
						response.sendRedirect("adminDistReq.jsp?stock");
					}
				} else {
					pw.println("");
					pw.println("</body></html>");
					response.sendRedirect("adminDistReq.jsp?nopro");
				}
			} else {
				pw.println("");
				pw.println("</body></html>");
				response.sendRedirect("adminDistReq.jsp?noreq");
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("\n------\n\n" + e.getMessage());
		}


	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}