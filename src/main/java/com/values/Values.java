package com.values;

import java.util.HashMap;

public class Values {
	public static int difficulty= 5;
	public static int nodes= 9;
	public static String PORT= "3306";
	
	public static String DB_User= "root";
	public static String DB_Pass= "mysqlPass";
	public static String DB_Name= "SupplyChainDB";
	
	public static String seperator= "%%";
	public static String filePath= "E:\\Final Year Project\\Code\\output";
	
	public static String HOST= "jdbc:mysql://localhost/";
	public static String DRIVER= "com.mysql.cj.jdbc.Driver";
	public static String DatanodeStr= "Datanode_";
	
	public static String majorHash;
	public static String version= "1.0";
	public static HashMap<Integer, String> datanodeValid= new HashMap<Integer, String>();
	
	public static String admin_email= "admin@gmail.com";
	public static String admin_pass= "Admin123";
	public static String Dist= "DIST";
	public static String User= "USER";
	
	
	public static int QR_WIDTH= 300;
	public static int QR_HEIGHT= 300;
	public static String CHARSET= "UTF-8";
	
	public static String targetString= new String(new char[difficulty]).replace('\0', '0');
	
 	public static String concatStrings(String... strings) {
		String output= "";
		for (String str: strings) {
			output= output.concat(str);
			output= output.concat(seperator);
		}
		int end= output.length() - 2;
		output = output.substring(0,end);
		return output;
	}
}