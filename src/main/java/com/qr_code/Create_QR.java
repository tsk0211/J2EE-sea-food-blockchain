package com.qr_code;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.values.Values;

public class Create_QR {
	public static int qr_width = Values.QR_WIDTH;
	public static int qr_height = Values.QR_HEIGHT;
	public static String charset = Values.CHARSET;

	public static void CreateQR(String qrCodeData, String filePath) {
		try {
			Map<EncodeHintType, ErrorCorrectionLevel> hintMap = new HashMap<EncodeHintType, ErrorCorrectionLevel>();
			
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
			
			BitMatrix matrix = new MultiFormatWriter().encode(new String(qrCodeData.getBytes(charset), charset), BarcodeFormat.QR_CODE, qr_width, qr_height, hintMap);
			
			MatrixToImageWriter.writeToFile(matrix, filePath.substring(filePath.lastIndexOf('.') + 1), new File(filePath));
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

	public static void main(String[] a) {
		try {
			String path= Values.filePath + "\\" + "aybc" + "-" + "ac";
			
			File file= new File(path);
			if (file.mkdir()) {
				path= path + "\\" + "ssq" + "_" + "15wd15" + ".png";
				
				file= new File(path);
				file.createNewFile();
			}
			
			String datainfo = Values.concatStrings("productName", "CompanyName", "timestamp", "DescriptionName", "MFGDate", "Price", "ExpiryDate", "arr[1]", "mfwmfowmqro");
			
			CreateQR(datainfo, path);
		} catch (Exception e0) {
			e0.printStackTrace();
		}
	}
}