package com.general;

import java.sql.Connection;
import java.sql.DriverManager;

import com.values.Values;

public class DB_Conn {
	
	public static Connection conn(String database) {
		Connection con= null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:" + Values.PORT +"/" + database, Values.DB_User, Values.DB_Pass);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return con;
	}
}