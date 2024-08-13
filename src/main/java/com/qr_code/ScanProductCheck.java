package com.qr_code;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.Date;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.general.DB_Conn;
import com.values.Values;

public class ScanProductCheck {
	
	public static boolean Datecheck(String newdate,String dbdate) {
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
		Date d1, d2;
		try {
			d1 =  (Date) sdformat.parse(newdate);
			d2 = (Date) sdformat.parse(dbdate);
			if(d1.compareTo(d2) == 0) {
				return true;
			} else {
				return false;
				}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static boolean isProductValid(String id, String role)
	{
		boolean flag= false;
		String sql= (role.equals("dist")) ? "select * from product_table where productId = '"+id+"';" : "select * from product_table where productId = '" + id + "'";
		try {
			Connection con = (Connection) DB_Conn.conn(Values.DB_Name);
			Statement stRegister1 = (Statement) con.createStatement();
			ResultSet rsLogin1 = stRegister1.executeQuery(sql);
			
			if (rsLogin1.next()) {
				flag= true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}