package com.blockchain;

import com.values.Values;

public class Transaction {
	public String source, destination, typeOfFish, company, dateTime, qty, finalAmount, deliveryAddr, destMobile;
	public int productCode;
	
	public Transaction(String src, String dst, String dstMobile, String typeOfFish, String comp, String dateTime, String qty, String amt, String addr, int productCode) {
		this.source = src;
		this.destination = dst;
		this.typeOfFish = typeOfFish;
		this.company = comp;
		this.destMobile = dstMobile;
		this.dateTime = dateTime;
		this.qty = qty;
		this.finalAmount = amt;
		this.deliveryAddr= addr;
		this.productCode= productCode;
	}
	
	public Transaction(String str) {
		String[] arr= str.split(Values.seperator);
		int io= 0;
		for (String s: arr) {
			System.out.println(io + " :-: " + s);
			io++;
		}
		
		this.source = arr[0];
		this.destination = arr[1];
		this.typeOfFish = arr[2];
		this.company = arr[3];
		this.destMobile = arr[4];
		this.dateTime = arr[5];
		this.qty = arr[6];
		this.finalAmount = arr[7];
		this.deliveryAddr= arr[8];
		this.productCode= Integer.parseInt(arr[9]);
	}

	@Override
	public String toString() {
		return Values.concatStrings(this.source, this.destination, this.typeOfFish, this.company, this.destMobile,
				this.dateTime, this.qty, this.finalAmount, this.deliveryAddr, "" + this.productCode);
	}
	
}
