package com.foo.manager.commonManager.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.InputStreamRequestEntity;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.foo.abstractService.AbstractService;
import com.foo.common.CommonDefine;
import com.foo.common.CommonException;
import com.foo.common.MessageCodeDefine;
import com.foo.dao.mysql.CommonManagerMapper;
import com.foo.dao.mysql.NJCommonManagerMapper;
import com.foo.handler.ExceptionHandler;
import com.foo.util.CommonUtil;
import com.foo.util.ConfigUtil;
import com.foo.util.FileWriterUtil;
import com.foo.util.FtpUtils;
import com.foo.util.XmlUtil;

/**
 * @author xuxiaojun
 *
 */
public abstract class CommonManagerService extends AbstractService {
	@Resource
	protected CommonManagerMapper commonManagerMapper;
	@Resource
	protected NJCommonManagerMapper njCommonManagerMapper;

	protected static String T_NJ_SKU = "T_NJ_SKU";
	protected static String T_NJ_ORDERS = "T_NJ_ORDERS";
	protected static String T_NJ_ORDER_DETAIL = "T_NJ_ORDER_DETAIL";
	protected static String T_NJ_LOGISTICS = "T_NJ_LOGISTICS";
	protected static String T_NJ_INVENTORY = "T_NJ_INVENTORY";
	protected static String T_NJ_INVENTORY_DETAIL = "T_NJ_INVENTORY_DETAIL";
	protected static String T_CONTACT = "T_CONTACT";

	protected static String V_NJ_INVENTORY = "V_NJ_INVENTORY";
	protected static String V_NJ_INVENTORY_DETAIL = "V_NJ_INVENTORY_DETAIL";
	protected static String V_NJ_LOGISTICS_UNUSE = "V_NJ_LOGISTICS_UNUSE";
	protected static String V_NJ_ORDERS_UNUSE = "V_NJ_ORDERS_UNUSE";

	public Map<String, Object> getAllCodeNames(Map<String, Object> params)
			throws CommonException {
		try {

			List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

			int total = 0;
			// 开始
			Integer start = params.get("start") == null ? null : Integer
					.valueOf(params.get("start").toString());
			// 结束
			Integer limit = params.get("limit") == null ? null : Integer
					.valueOf(params.get("limit").toString());
			// 按类别查询
			if (params.get("RELATION_CATEGORY") != null
					&& !params.get("RELATION_CATEGORY").toString().isEmpty()) {
				rows = commonManagerMapper.selectTableListByCol("t_code_name",
						"RELATION_CATEGORY", params.get("RELATION_CATEGORY"),
						start, limit);
				total = commonManagerMapper.selectTableListCountByCol(
						"t_code_name", "RELATION_CATEGORY",
						params.get("RELATION_CATEGORY"));
			} else {
				// 查询所有
				rows = commonManagerMapper.selectTable("t_code_name", start,
						limit);
				total = commonManagerMapper.selectTableCount("t_code_name");
			}
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", total);
			result.put("rows", rows);
			return result;
		} catch (Exception e) {
			ExceptionHandler.handleException(e);
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public List<Map> getAllCodeCategory()
			throws CommonException {
		
		List<Map> result = new ArrayList<Map>();
		try {
			result = commonManagerMapper.getAllCodeCategory();
			
			return result;
		} catch (Exception e) {
			ExceptionHandler.handleException(e);
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public boolean uniqueCheck(String tableName,String uniqueCol,Object uniqueVal,
			String primaryCol,Object primaryVal,
			boolean preventException) throws CommonException {
		boolean valid=false;
		List<Map<String, Object>> list = commonManagerMapper.selectTableListByCol(tableName, uniqueCol, uniqueVal, null, null);
		switch(list.size()){
		case 0:
			valid=true;
			break;
		case 1:
			if(primaryVal!=null){
				Object val=list.get(0).get(primaryCol);
				valid=(val!=null&&primaryVal.equals(val));
			}else{
				valid=false;
			}
			break;
		default:
			valid=false;
		}
		if(!preventException&&!valid){
			throw new CommonException(null,
					MessageCodeDefine.COM_EXCPT_DUPLICATE_ENTRY);
		}
		return valid;
	}
	
	public boolean uniqueCheck(String tableName,List<String> uniqueCol,List<Object> uniqueVal,
			String primaryCol,Object primaryVal,
			boolean preventException) throws CommonException {
		boolean valid=false;
		List<Map<String, Object>> list = commonManagerMapper.selectTableListByNVList(tableName, uniqueCol, uniqueVal, null, null);
		switch(list.size()){
		case 0:
			valid=true;
			break;
		case 1:
			if(primaryVal!=null){
				Object val=list.get(0).get(primaryCol);
				valid=(val!=null&&primaryVal.equals(val));
			}else{
				valid=false;
			}
			break;
		default:
			valid=false;
		}
		if(!preventException&&!valid){
			String message = "";

			if(T_NJ_SKU.equals(tableName.toUpperCase())){
				message = "商品货号已存在！";
			}else if(T_NJ_ORDERS.equals(tableName.toUpperCase())){
				message = "订单编号已存在！";
			}else if(T_NJ_LOGISTICS.equals(tableName.toUpperCase())){
				message = "运单号已存在！";
			}else if(T_NJ_INVENTORY.equals(tableName.toUpperCase())){
				message = "运单号已存在！";
			}
			
			if(message.isEmpty()){
			throw new CommonException(null,
					MessageCodeDefine.COM_EXCPT_DUPLICATE_ENTRY);
			}else{
				throw new CommonException(null,
						MessageCodeDefine.COM_EXCPT_DUPLICATE_ENTRY,message);
			}
		}
		return valid;
	}

	// 生成xml文件 messageType = CommonDefine.CEB501或CommonDefine.CEB503
	public boolean submitXml_LOGISTICS(Map<String, Object> data,
			Integer logisticsId, int messageType, int logisticsType) {
		
		//修改指定运单表
		String tableName = "T_LOGISTICS";
		
		switch (logisticsType) {
		case CommonDefine.LOGISTICS_TYPE_NORMAL:
			tableName = "T_LOGISTICS";
			break;
		case CommonDefine.LOGISTICS_TYPE_SUNING:
			tableName = "T_LOGISTICS_SN";
			break;
		default:

		}
		// 提交需要生成xml文件,
		if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
				data.get("APP_STATUS"))) {
			System.out.println("submitXml_LOGISTICS 表："+tableName);

			// 更新数据，添加申报时间
			// 插入申报时间
			String currentTime = new SimpleDateFormat(
					CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
			data.put("APP_TIME", currentTime);
			commonManagerMapper.updateLogistics(data, tableName);

			// 获取guid
			String guid = data.get("GUID").toString();

			String generalXmlFilePath = null;

			switch (messageType) {
			case CommonDefine.CEB501:
				generalXmlFilePath = ConfigUtil
						.getFileLocationPath(CommonDefine.FILE_CATEGORY_WLYD)
						.get("GENERAL_XML").toString();
				
				switch (logisticsType) {
				case CommonDefine.LOGISTICS_TYPE_NORMAL:
					// 获取需要生成报文的数据
					data = commonManagerMapper.selectDataForMessage501(guid);
					break;
				case CommonDefine.LOGISTICS_TYPE_SUNING:
					// 获取需要生成报文的数据
					data = commonManagerMapper.selectDataForMessage501_SN(guid);
					break;
				}
				break;
			case CommonDefine.CEB503:
				// 设置申请状态为申报中
				data.put("APP_STATUS", CommonDefine.APP_STATUS_UPLOAD);
				// 清空回执获取信息
				commonManagerMapper.updateLogisticsReturnInfoToNull(data, tableName);
				generalXmlFilePath = ConfigUtil
						.getFileLocationPath(CommonDefine.FILE_CATEGORY_YDZT)
						.get("GENERAL_XML").toString();
				
				switch (logisticsType) {
				case CommonDefine.LOGISTICS_TYPE_NORMAL:
					// 获取需要生成报文的数据
					data = commonManagerMapper.selectDataForMessage503(guid);
					break;
				case CommonDefine.LOGISTICS_TYPE_SUNING:
					// 获取需要生成报文的数据
					data = commonManagerMapper.selectDataForMessage503_SN(guid);
					break;
				}
				break;
			}

			File file = XmlUtil.generalXml(data, null, messageType);

			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();

			boolean result = ftpUtil.uploadFile(file.getPath(),
					generalXmlFilePath, file.getName());

			if (result) {
				file.delete();
			}
			return result;
		}
		return true;
	}
	//http请求调用webservice
	public String sendHttpCMD(String xmlString,int messageType,int cmdType) throws CommonException {
		String result = "";
		
		String requestUrl = "";

		switch(cmdType){
		case CommonDefine.CMD_TYPE_DECLARE:
			requestUrl = CommonUtil.getSystemConfigProperty("requestUrl");
			break;
		case CommonDefine.CMD_TYPE_RECEIPT:
			requestUrl = CommonUtil.getSystemConfigProperty("receiptUrl");
			break;
		}
		//测试ftp服务器有没有正常启动
		checkFtpServerValid();
		
		try {
			PostMethod postMethod = new PostMethod(requestUrl);

			// 然后把Soap请求数据添加到PostMethod中
			byte[] b = xmlString.getBytes("utf-8");
			InputStream is = new ByteArrayInputStream(b,0,b.length);
			RequestEntity re = new InputStreamRequestEntity(is,b.length,"application/soap+xml; charset=utf-8");
			postMethod.setRequestEntity(re);

			// 最后生成一个HttpClient对象，并发出postMethod请求
			HttpClient httpClient = new HttpClient();
			int statusCode = httpClient.executeMethod(postMethod);
			if (statusCode == 200) {
				String soapResponseData = postMethod.getResponseBodyAsString();
				System.out.println("request xml String:"+xmlString);
				System.out.println("reponse xml String:"+soapResponseData);
				result = XmlUtil.getResponseFromXmlString(soapResponseData,messageType);
				//上传请求回应数据
				uploadRequestLog(messageType,xmlString,soapResponseData,result);
				
				if(result == null){
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, "无回执信息！");
				}else{
					System.out.println("reponse result String:"+result);
				}
				
			} else {
				//抛出错误信息
				throw new CommonException(new Exception(),
						MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, "调用失败！错误码：" + statusCode);
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//检测ftp时候启动
	private void checkFtpServerValid() throws CommonException{
		try{
			//上传文件
			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();
			
			ftpUtil.ftpClient.list("/");
		}catch(Exception e){
			//抛出错误信息
			throw new CommonException(new Exception(),
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, "FTP服务未启动！");
		}
	}
	
	//上传请求信息及回应
	private void uploadRequestLog(int messageType, String request,String reponse,String resultString){
		
		String uploadPath = "";
		switch (messageType) {
		case CommonDefine.CEB201:
		case CommonDefine.CEB202:
		case CommonDefine.CEB203:
		case CommonDefine.CEB201_RECEIPT_SINGLE:
		case CommonDefine.CEB201_RECEIPT_LIST:
			uploadPath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_SPBA)
					.get("GENERAL_XML").toString();
			break;
		case CommonDefine.CEB301:
		case CommonDefine.CEB302:
		case CommonDefine.CEB303:
			uploadPath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_DZDD)
					.get("GENERAL_XML").toString();
			break;
		case CommonDefine.CEB501:
		case CommonDefine.CEB502:
		case CommonDefine.CEB503:
			uploadPath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_WLYD)
					.get("GENERAL_XML").toString();
			break;
		case CommonDefine.CEB601:
		case CommonDefine.CEB602:
		case CommonDefine.CEB601_RECEIPT_SINGLE:
		case CommonDefine.CEB601_RECEIPT_LIST:
			uploadPath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_CJQD)
					.get("GENERAL_XML").toString();
			break;
		}
		
		SimpleDateFormat sf = new SimpleDateFormat(CommonDefine.COMMON_SIMPLE_FORMAT);
		//文件名
		String fileName = messageType+"_RequestData_"+sf.format(new Date());
		
		String filePath = System.getProperty("java.io.tmpdir") + "/"
				+ fileName + ".txt";
		
		request = request == null?"":request;
		reponse = reponse == null?"":reponse;
		resultString = resultString == null?"":resultString;

		request = request.replaceAll("&lt;", '<' + "");
		request = request.replaceAll("&gt;", '>'+"");
		
		reponse = reponse.replaceAll("&lt;", '<' + "");
		reponse = reponse.replaceAll("&gt;", '>'+"");
		
		resultString = resultString.replaceAll("&lt;", '<' + "");
		resultString = resultString.replaceAll("&gt;", '>'+"");
		
		Map resultData = new HashMap();
		resultData.put("请求数据", formatXML(request));
		resultData.put("返回数据", formatXML(reponse));
		resultData.put("结果解析", resultString);
		
		File file = null;
		try {
			file = FileWriterUtil.writeToTxt(filePath, resultData);
			
			//上传文件
			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();

			boolean result = ftpUtil.uploadFile(file.getPath(),
					uploadPath, file.getName());

			if (result) {
				file.delete();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//格式化xml字符串输出
	public String formatXML(String inputXML) {
        SAXReader reader = new SAXReader();  
        Document document = null;
		try {
			document = reader.read(new StringReader(inputXML));
		} catch (DocumentException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}  
        String requestXML = null;  
        XMLWriter writer = null;  
        if (document != null) {  
          try {  
            StringWriter stringWriter = new StringWriter();  
            OutputFormat format = new OutputFormat(" ", true);  
            writer = new XMLWriter(stringWriter, format);  
            writer.write(document);  
            writer.flush();  
            requestXML = stringWriter.getBuffer().toString();  
          }  catch (Exception e) {  
        	  e.printStackTrace();
          }  finally {  
            if (writer != null) {  
              try {  
                writer.close();  
              } catch (IOException e) {  
              }  
            }  
          }  
        }  
        return requestXML;  
      }
	
	public static void main(String args[]){
		String soapResponseData = "<NewDataSet>"+"\n"+
		        "<NJKJ_MESSAGE_APPR_RTN>"+"\n"+
	            "<EBC_CODE>3215916102</EBC_CODE>"+"\n"+
	            "<ITEM_NO>G23521506000000261</ITEM_NO>"+"\n"+
				"<G_NO />"+"\n"+
	            "<CHK_STATUS>3</CHK_STATUS>"+"\n"+
	            "<CHK_RESULT>审批意见</CHK_RESULT>"+"\n"+
				"<CHK_TIME>20150723085544 </CHK_TIME>"+"\n"+
	        "</NJKJ_MESSAGE_APPR_RTN>"+"\n"+
	    "</NewDataSet>";
		System.out.println(soapResponseData);
		soapResponseData = soapResponseData.replaceAll( "\\s*|\t|\r|\n", "" );
		System.out.println(soapResponseData);
		if(soapResponseData == null ||soapResponseData.isEmpty()){
			//抛出错误信息
//			throw new CommonException(new Exception(),
//					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, soapResponseData);
		}
		List<Map<String,String>> response = XmlUtil.parseXmlStringForReceipt(soapResponseData);
		if(response!=null&&response.size()>0){
			//更新商品数据
			//{EBC_CODE=3215916102, G_NO=, CHK_TIME=20150723085544 , ITEM_NO=G23521506000000261, CHK_STATUS=3, CHK_RESULT=审批意见}
			for(Map data:response){
				if(data.get("EBC_CODE")!=null){
					Map sku = new HashMap();
					sku.put("RETURN_STATUS", data.get("CHK_STATUS"));
					sku.put("RETURN_TIME", data.get("CHK_TIME"));
					sku.put("RETURN_INFO", data.get("CHK_RESULT"));
					sku.put("G_NO", data.get("G_NO"));
//					sku.put("GUID", guid);
					//回执状态为3审批通过 更新申报状态 为申报完成
					if (sku.get("RETURN_STATUS") != null
							&& Integer.valueOf(sku.get(
									"RETURN_STATUS").toString()) == CommonDefine.RETURN_STATUS_2) {
						sku.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
					}
//					njCommonManagerMapper.updateSku_nj(sku);
				}
			}
		}else{
			//抛出错误信息
//			throw new CommonException(new Exception(),
//					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, soapResponseData);
		}
	}
}
