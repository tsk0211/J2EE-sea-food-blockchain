package com.blockchain;


public class ChainConsensus {
	public static String Consensus(int id) {
        try {
            String blockHash = BlockChain.Blockchaindata(id);
            return blockHash;
        } catch (Exception e) {
        	System.out.println(e.getMessage());
        	e.printStackTrace();
        }
        return null;
    }
	
	public static void main(String[] args) {
		try { 
			System.out.println("Block Hash : " + Consensus(2));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
