package com.blockchain;

import java.security.MessageDigest;
import java.util.Date;

import com.values.Values;

public class Block {
	
	public String hash;
	public String previousHash;
	public Transaction data;
	public long timeStamp;
	public int nonce;
	public int difficulty= Values.difficulty;
	public String version;
	
	// Block Constructor
	public Block(Transaction transaction, String previousHash, String version) {
		this.data = transaction;
		this.previousHash = previousHash;
		this.timeStamp = new Date().getTime();
		
		this.hash = calculateHash();
		this.version = version;
		}
	
	public Block(String hash, String previousHash, String version, long time) {
		this.hash= hash;
		this.previousHash= previousHash;
		this.version= version;
		this.timeStamp= time;
	}
	
	
	// Encryption Algorithm
 	public static String applySha256(String input) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
	        
			//Applies sha256 to our input, 
			byte[] hash = digest.digest(input.getBytes("UTF-8"));
	        
			StringBuffer hexString = new StringBuffer();
			
			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if(hex.length() == 1) hexString.append('0');
				hexString.append(hex);
			}
			return hexString.toString();
		}
		catch(Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	// Calculate new hash based on blocks contents
	public String calculateHash() {
		return applySha256( this.previousHash + Long.toString(this.timeStamp) +
				Integer.toString(this.nonce) + this.data.toString() + this.version);
	}
	
	public String hashForConcensus() {
		return (this.previousHash + " - " + this.version + " - " + this.hash + " - " + this.timeStamp + "\n");
	}
	
	// Mine Block
	public void mineBlock(int difficulty) {
		String target = new String(new char[difficulty]).replace('\0', '0'); //Create a string with difficulty * "0" 
		while(!this.hash.substring(0, difficulty).equals(target)) {
			this.nonce ++;
			this.hash = calculateHash();
			}
        }

	
	@Override
	public String toString() {
		return this.data.toString();
	}

	
}