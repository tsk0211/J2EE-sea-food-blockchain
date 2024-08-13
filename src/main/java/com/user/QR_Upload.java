package com.user;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.general.DB_Conn;
import com.qr_code.Read_QR;
import com.values.Values;

@WebServlet("/UserQrCode")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class QR_Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static String filepath = null;
	private static final int BUFFER_SIZE = 4096;

	public QR_Upload() {
		super();
		
	}

	String getFileName(Part filePart) {
		for (String cd : filePart.getHeader("content-disposition").split(";")) {
			if (cd.trim().startsWith("filename")) {
				String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
				return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1);
			}
		}
		return null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Part tenfile = request.getPart("qrcodefile");
		
		InputStream teninputStream = null;
		String tenmsg = "qr.png";
		
		try {
			
			String userEmail= (String) request.getSession().getAttribute("loginEmail");

			teninputStream = tenfile.getInputStream();
			
			filepath = Values.filePath + File.separator + "temp" + File.separator + tenmsg;
			File f = new File(filepath);
			OutputStream outStream = new FileOutputStream(f);
			byte[] buffer = new byte[BUFFER_SIZE];
			int bytesRead = -1;
			
			while ((bytesRead = teninputStream.read(buffer)) != -1) {
				outStream.write(buffer, 0, bytesRead);
			}
			
			teninputStream.close();
			outStream.close();
			
			String data = Read_QR.readQR(filepath);
			
			f.delete();
			
			String[] qr_data = data.split(Values.seperator);
			
			int k= 0;
			for (String q : qr_data) {
				System.out.println("QR data item " + k  + " index :-> " + q);
				k++;
			}
			
			if (data.equalsIgnoreCase("Unable to scan")) {
				response.sendRedirect("userQrUpload.jsp?unable");
			} else {
				if (qr_data.length < 7) {
					response.sendRedirect("userQrUpload.jsp?unable");
				} else {
					String id = qr_data[8];
					String timestamp = qr_data[2];
					
					if (!(id.equals(userEmail))) {
						System.out.println("Email doesn't match !");
						response.sendRedirect("userQrUpload.jsp?notuser");
					} else if (qr_data[9].equals(Values.User)) {
						request.getSession().setAttribute("distReqId", qr_data[7]);
						
						Connection c= (Connection) DB_Conn.conn(Values.DB_Name);
						Statement s= (Statement) c.createStatement();
						
						String sql= "SELECT * FROM product_user_req WHERE id = '" + qr_data[7] + "';";
						
						ResultSet rs= (ResultSet) s.executeQuery(sql);
						
						System.out.println("distReqId qr_data 7 :: " + qr_data[7]);
						
						if (rs.next()) {
							if (!(rs.getString(rs.findColumn("status")).equals("Shipped"))) {
								response.sendRedirect("./userQrDetails.jsp?id=" + id + "," + timestamp);							
							} else {
								response.sendRedirect("./userQrUpload.jsp?dup_qr");
							}
						} else {
							response.sendRedirect("./userQrUpload.jsp?notvalid");
						}
						
					} else {
						response.sendRedirect("userQrUpload.jsp?notuser");
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		}
	}

}