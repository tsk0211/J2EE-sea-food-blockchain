package com.blockchain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.values.Values;
import com.general.DB_Conn;
import com.values.DB;


public class BlockChain {
	public static ArrayList<Block> blockchain = new ArrayList<Block>();
	public static ArrayList<String> chain= new ArrayList<String>();
	public static int difficulty = Values.difficulty;
	public static String Previsblk = "";
	public static String hashTarget = Values.targetString;
	private static int id= 0;

	public static String Blockchaindata(int id) {
		String chainHash= "0";
		BlockChain.id= id;
		
		blockchain = getChain(Values.DatanodeStr + id);
		System.out.println("Database Is " + Values.DatanodeStr + id);
		
		// Validation block chain
		if ((blockchain.size() > 0)) {
			if (isChainValid(blockchain)) {
				chainHash= getChainHash(blockchain);
			} else {
				System.out.println("Data Node " + BlockChain.id + " is Invalid !!");
				chainHash= Block.applySha256("noice");
			}
		} else {
			System.out.println("It's a Genesis Block.");
			chainHash= Block.applySha256("0");
		}
		return chainHash;
	}
	
	public static ArrayList<Block> getChain(String db) {
		ArrayList<Block> blockList = new ArrayList<Block>();
		String hb, v, previous = "0";
		long time;

		try {			
			Connection con= (Connection) DB_Conn.conn(db);
			Statement stat = (Statement) con.createStatement();
			stat.executeQuery("SELECT * FROM " + db + "." + DB.tableName);
			ResultSet rs = stat.getResultSet();

			while (rs.next()) {
				hb= rs.getString(rs.findColumn(DB.hashBlock)).trim();
				v= rs.getString(rs.findColumn(DB.version)).trim();
				previous= rs.getString(rs.findColumn(DB.previousHash)).trim();
				
				time= Long.parseLong(rs.getString(rs.findColumn(DB.timeStamp)).trim());
				
				blockList.add(new Block(hb, previous, v, time));
				Values.version= rs.getString(rs.findColumn(DB.version));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blockList;
	}
	
	public static ArrayList<Transaction> getChainData(String db) {
		ArrayList<Transaction> trList = new ArrayList<Transaction>();
		String data = "0";

		try {			
			Connection con= (Connection) DB_Conn.conn(db);
			Statement stat = (Statement) con.createStatement();
			stat.executeQuery("SELECT * FROM " + db + "." + DB.tableName);
			ResultSet rs = stat.getResultSet();

			while (rs.next()) {
				data= rs.getString(rs.findColumn(DB.blockData)).trim();
				trList.add(new Transaction(data));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return trList;
	}
	
	public static void printChain(ArrayList<Block> list) {
		for (Block b : list) {
			System.out.println(b.hashForConcensus());
		}
	}

	// Checks for a valid block chain by confirming previous and current hash
	public static Boolean isChainValid(ArrayList<Block> list) {
		ArrayList<Block> blockList = list;
		
		boolean flag = false;
		
		for (int i = 0; i < blockList.size(); i++) {
			
			flag= (i == 0) ? true : false;
			
			if ((i != 0) && (blockList.get(i).previousHash.equals(blockList.get(i-1).hash))) {
				flag= true;
			} else if (i != 0) {
				flag= false;
				System.out.println("Block Chain " + BlockChain.id + " is Currupted With Block " + i + " .");
				break;
			}
		}
		return flag;
	}

	// Getting chain Hash for consensus
	public static String getChainHash(ArrayList<Block> list) {
		String output= "";
		for (Block b : list) {
			output= output.concat(b.hashForConcensus());
		}
		System.out.println("Output of Blockchain : " + output);
		output= Block.applySha256(output);
		
		System.out.println("Output Block Chain : " + BlockChain.id +  " Hash : " + output);
		return output;
	}
	
	public static void main(String[] args) {
		ArrayList<Block> arr= getChain(Values.DatanodeStr + 1);
		printChain(arr);
		
		System.out.println("\n Is Chain Valid : " + isChainValid(arr));
	}
	
}