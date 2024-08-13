package com.qr_code;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class Read_QR {

	public static String readQR(String filePath) {
		String textdata = "";
		try {
			String charset = "UTF-8";
			Map<EncodeHintType, ErrorCorrectionLevel> hintMap = new HashMap<EncodeHintType, ErrorCorrectionLevel>();
			hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
			textdata = readQRCode(filePath, charset, hintMap);
			if (textdata.isEmpty()) {
				textdata = "abc";
			}

		} catch (NotFoundException | IOException e) {
			textdata = "Unable to scan";
		}
		return textdata;
	}

	public static String readQRCode(String filePath, String charset, @SuppressWarnings("rawtypes") Map hintMap)
			throws FileNotFoundException, IOException, NotFoundException {
		BinaryBitmap binaryBitmap = new BinaryBitmap(
				new HybridBinarizer(new BufferedImageLuminanceSource(ImageIO.read(new FileInputStream(filePath)))));
		@SuppressWarnings("unchecked")
		Result qrCodeResult = new MultiFormatReader().decode(binaryBitmap, hintMap);
		return qrCodeResult.getText();
	}
}
