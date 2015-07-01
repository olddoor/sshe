package sy.util.base;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;

import org.junit.Test;

import com.alibaba.fastjson.JSONObject;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.Binarizer;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.NotFoundException;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

public class QRCodeUtil {
	
	public static void  main(String args[]){
//		QRCodeUtil q=new QRCodeUtil();
//		try {
//			q.encode("MR.乔丹111","Y://");
//		} catch (WriterException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	}

/**
 * 生成图片
 * @param fileName文件名
 * @param loginName登录名
 * @throws WriterException
 * @throws IOException
 */
	@Test
	public void encode(String userid,String loginName,String filePath,Integer qrmoban) throws WriterException, IOException {
//		String filePath = "Y://";
		JSONObject json = new JSONObject();
//		String url="http://112.5.141.83:10320/sshe/base/qrqrurl.sy?vcard="+loginName;//http://112.5.141.83:10320/sshe/index.jsp
		String url=ConfigUtil.getQRURL();
		url=url+loginName;
		String content = url;
		System.out.println(content);
//		String content="www.xw568.com";
		int width = 200; // 图像宽度
		int height = 200; // 图像高度
		String format = "png";// 图像类型
		loginName=loginName+".jpg";
		Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
		BitMatrix bitMatrix = new MultiFormatWriter().encode(content,
				BarcodeFormat.QR_CODE, width, height, hints);// 生成矩阵
		Path path = FileSystems.getDefault().getPath(filePath, loginName);
		File up = new File(filePath);
		if (!up.exists()) {
			up.mkdirs();
		}
		MatrixToImageWriter.writeToPath(bitMatrix, format, path);// 输出图像
		System.out.println("输出成功."+loginName);
	}

	/**
	 * 解析图像
	 */
	@Test
	public void decode(String fileName) {
		String filePath = "Y:\\";
		fileName=fileName+".jpg";
		filePath =filePath+fileName;
		BufferedImage image;
		try {
			image = ImageIO.read(new File(filePath));
			LuminanceSource source = new BufferedImageLuminanceSource(image);
			Binarizer binarizer = new HybridBinarizer(source);
			BinaryBitmap binaryBitmap = new BinaryBitmap(binarizer);
			Map<DecodeHintType, Object> hints = new HashMap<DecodeHintType, Object>();
			hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
			Result result = new MultiFormatReader().decode(binaryBitmap, hints);// 对图像进行解码
			String content = result.toString();
			System.out.println("图片中内容：	");
			System.out.println(content.toString());
//			System.out.println("author：	" + content.getString("author"));
//			System.out.println("zxing：	" + content.getString("zxing"));
//			System.out.println("图片中格式：	");
//			System.out.println("encode：	" + result.getBarcodeFormat());
		} catch (IOException e) {
			e.printStackTrace();
		} catch (NotFoundException e) {
			e.printStackTrace();
		}
	}
}
