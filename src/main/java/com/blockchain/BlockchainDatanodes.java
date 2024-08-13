package com.blockchain;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.general.DB_Conn;
import com.values.DB;
import com.values.Values;


public class BlockchainDatanodes {
	
	public static void createDataNodes (int size) {
		
		for (int i = 1; i <= size; i++) {
			Connection conn = null;
			Connection con = null;
			Statement stmt = null;
			Statement stmt1 = null;
			
			try {
				Class.forName(Values.DRIVER);
				conn = DriverManager.getConnection(Values.HOST, Values.DB_User, Values.DB_Pass);
				String databasename = Values.DatanodeStr + i;
				stmt = conn.createStatement();

				String sql = "CREATE DATABASE if not exists " + databasename;
				stmt.executeUpdate(sql);

				con = DriverManager.getConnection(Values.HOST + databasename, Values.DB_User, Values.DB_Pass);
				stmt1 = con.createStatement();
				
				String sqlQuery = "CREATE TABLE  if not exists " + DB.tableName + "(ID INT(11) NOT NULL AUTO_INCREMENT"
						+ " PRIMARY KEY, " + " " + DB.previousHash +" Varchar(100) NULL, " + DB.hashBlock + " varchar(100)," +
						DB.blockData + " LONGTEXT," + DB.timeStamp + " varchar(50) NULL, " + DB.version + " varchar(10) NULL, " +
						DB.nonce + " varchar(30));";
				
				stmt1.executeUpdate(sqlQuery);
				System.out.println("Data Node " + i + " created successfully...");
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if (stmt != null)
						stmt.close();
					
					if (conn != null)
						conn.close();
				} catch (Exception se) {
					se.printStackTrace();
				}
			}
		}
	}

	// Majority Recovering
	public static void recoverNode(String fromNode, String recoveryNode) { 
		// majority count
		try {
			Connection conn= (Connection) DB_Conn.conn(recoveryNode);
			Statement stmt= (Statement) conn.createStatement();
			
			stmt.execute("TRUNCATE " + DB.tableName + ";");
			
			System.out.println("From Node = " + fromNode + " Recovery Node = " + recoveryNode);
			
			Connection con= (Connection) DB_Conn.conn(fromNode);
			Statement fromStmt= (Statement) con.createStatement();
			
			fromStmt.executeQuery("SELECT * FROM " + DB.tableName + ";");
			
			ResultSet rd= (ResultSet) fromStmt.getResultSet();
			
			String blockHash, previousBlockHash, timeStamp, version, blockData, nonce;
			int i= 1;

			while (rd.next()) {
				blockHash= rd.getString(rd.findColumn(DB.hashBlock));
				previousBlockHash= rd.getString(rd.findColumn(DB.previousHash));
				timeStamp= rd.getString(rd.findColumn(DB.timeStamp));
				version= rd.getString(rd.findColumn(DB.version));
				blockData= rd.getString(rd.findColumn(DB.blockData));
				nonce= rd.getString(rd.findColumn(DB.nonce));
				
				System.out.print("Block Id " + i + " : " + blockHash + " - ");
				System.out.println(blockData);
				System.out.print(previousBlockHash + " - ");
				System.out.print(timeStamp + " - ");
				System.out.print(version + " - " + nonce + " !\n");
				
				System.out.println("INSERT INTO " + DB.tableName + "(" + DB.previousHash + ", " + DB.hashBlock + ", " +
						DB.blockData + ", " + DB.timeStamp + ", " + DB.version + ") VALUES ('" + previousBlockHash + "' ,'" +
						blockHash + "' ,'" + blockData + "', '" + timeStamp + "' ,'" + version + "');");
				
				stmt.executeUpdate("INSERT INTO " + DB.tableName + "(" + DB.previousHash + ", " + DB.hashBlock + ", " +
						DB.blockData + ", " + DB.timeStamp + ", " + DB.version + ", " + DB.nonce +") VALUES ('" + previousBlockHash + "' ,'" +
						blockHash + "' ,'" + blockData + "', '" + timeStamp + "' ,'" + version + "', '" + nonce + "');");
			}
			
			} catch (Exception e) {
				e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		BlockchainDatanodes.createDataNodes(Values.nodes);
	}
}