package com.blockchain;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Map.Entry;

import com.general.DB_Conn;
import com.values.DB;
import com.values.Values;

public class AddBlockClass {
	
	public static boolean addBlockToBlockChain(Transaction tr) {
		chainVerify();
		String correctId= majorityCount();
		return addBlock(new Block(tr, getPreviousHashValue(correctId), Values.version));
	}
	
	// Chain Verification
	public static void chainVerify () {
		
		// Check pair to pair verification
		long startTime= System.currentTimeMillis();

		for (int id = 1; id <= Values.nodes; id++) {
				// Mining and puzzle
				Values.datanodeValid.put(id, ChainConsensus.Consensus(id));
		} // for loop end
		
		long endTime = System.currentTimeMillis();
		System.out.println("\t Data Nodes verifying total time => " + (startTime - endTime));
	
	}
	
	// Counts Majority and gives the most found node id
	public static String majorityCount() {
		String[] arr= Values.datanodeValid.values().toArray(new String[0]);
		
		String majorHash= findMajorEle(arr);
		System.out.println("Major Hash : " + majorHash);
		int id= getHashId(majorHash), i= 1;
		
		if (id != -1) {
			for (String h: Values.datanodeValid.values()) {
				if (h.equals(majorHash)) { 
					System.out.println("Block Chain " + i + " is Valid with Hash : " + h + " !!");
				} else {
					repairDataNodes(Values.DatanodeStr + id, Values.DatanodeStr + i);
				}
				i++;
			}
		}
		
		return Values.DatanodeStr + id;
	}

	// For Previous Hash Value
	public static String getPreviousHashValue(String id) {
		String output= "0";
		try {
			Connection conn= DB_Conn.conn(id);
			Statement st= conn.createStatement();
			st.executeQuery("select * from " + DB.tableName + ";");
			ResultSet rs= st.getResultSet();
			
			while(rs.next()) {
				output= rs.getString(rs.findColumn(DB.hashBlock));
			}
			
		} catch ( Exception e) {
			e.printStackTrace();
		}
		return output;
	}
	
	// Find Major Hash
	public static String findMajorEle(String arr[]) {
		int counter= 1;
		String major= arr[0];
		  
		for(int i = 1; i < arr.length; i++) {
			if (arr[i].equals(major)) {
				counter++;
			} else {
				counter = counter - 1;
			}
			
			if (counter == 0) {
				major= arr[i];
				counter= 1;
			}
		}
		return major;
	}
	
	public static int getHashId(String hash) {
		for (Entry<Integer, String> entry : Values.datanodeValid.entrySet()) {
            if (entry.getValue().equals(hash)) {
                System.out.println(entry.getKey());
                return entry.getKey();
            }
        }
		return -1;
	}
	
	// Recovering Data nodes
	public static void repairDataNodes(String majorId, String recoverId) {
		BlockchainDatanodes.recoverNode(majorId, recoverId);
		System.out.println("Block " + recoverId + " Recoverd Succecfully !!");
	}
		
	// New Transaction
	public static boolean addBlock(Block block) {
		Connection conndata= null;
		boolean flag= false;
		
		try {
			for (int i = 1; i <= Values.nodes; i++) {
				
				String db = Values.DatanodeStr + i;
				conndata = (Connection) DB_Conn.conn(db);
				Statement stat4 = (Statement) conndata.createStatement();
				
				// Mine Block
				long startTime= System.currentTimeMillis();
				block.mineBlock(Values.difficulty);
				long endTime= System.currentTimeMillis();
				
				long mineTime= endTime - startTime;
				
				System.out.println("Time Taken to Mine the block on node " + i + " is " + mineTime);
				
				String sql= "INSERT INTO blockchain (" + DB.previousHash + ", " + DB.blockData + ", " + DB.hashBlock +
						", " + DB.timeStamp + ", " + DB.version + ")  VALUES ('" + block.previousHash + "', '" + block.toString() +
						"','" + block.hash + "','" + block.timeStamp + "', '" + block.version + "');";
				
				flag = (stat4.executeUpdate(sql) != 0);
			}
			conndata.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return flag;
	}
	
	public static void main(String[] args) {
		System.out.println( AddBlockClass.addBlockToBlockChain(new Transaction("admin@gmail.com", "dist@gmail.com", "8451251245",  "samurai",
				"lucious", "" + new SimpleDateFormat("dd-MM-yyyy").format(new Date(System.currentTimeMillis())).toString(), "6", "699.25",
				"CM-1, 512, Prozone Mall Opposite, Chhtrapati Sambhaji Nagar, Maharashtra, 431005", 251)));
		
	}

}