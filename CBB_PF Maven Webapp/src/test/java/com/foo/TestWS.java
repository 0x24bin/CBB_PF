package com.foo;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.apache.cxf.endpoint.Client;
import org.apache.cxf.jaxws.endpoint.dynamic.JaxWsDynamicClientFactory;
import org.apache.cxf.transport.http.HTTPConduit;
import org.apache.cxf.transports.http.configuration.HTTPClientPolicy;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.junit.Test;
import org.xml.sax.SAXException;

public class TestWS {
	
	private String requestUrl = "http://127.0.0.1:8080/CBB_PF/WS/CBB_PF_WS?wsdl";
	
//	@Test
	public void testGetOrderReceipt() {
		String xml = getDataFromXmlFile(null);
		
		System.out.println(formatXML(sendHttpCMD(xml)));
	}
	
	@Test
	public void validateXml() {

		try {
			// 建立schema工厂
			SchemaFactory schemaFactory = SchemaFactory
					.newInstance("http://www.w3.org/2001/XMLSchema");
			// 建立验证文档文件对象，利用此文件对象所封装的文件进行schema验证
			Source sourceSchema = new StreamSource(Thread
					.currentThread()
					.getContextClassLoader()
					.getResourceAsStream(
							"xmlDataSource/SNT101.xsd"));
			// 利用schema工厂，接收验证文档文件对象生成Schema对象
			Schema schema = schemaFactory.newSchema(sourceSchema);
			// 通过Schema产生针对于此Schema的验证器，利用schenaFile进行验证
			Validator validator = schema.newValidator();
//			 // 创建默认的XML错误处理器
//			XmlValidateErrorHandler errorHandler = new XmlValidateErrorHandler();
//	          validator.setErrorHandler(errorHandler);
			// 得到验证的数据源
			Source sourceFile = new StreamSource(Thread
					.currentThread()
					.getContextClassLoader()
					.getResourceAsStream(
							"xmlDataSource/orderData.xml"));
			// 开始验证，成功输出success!!!，失败输出fail
			validator.validate(sourceFile);
			
		} catch (SAXException e) {
			System.out.println("校验错误："+e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	

	// http请求调用webservice
	private String sendHttpCMD(String xmlString){
		String result = "";
		Object[] obj = null;
		try {
			JaxWsDynamicClientFactory dcf = JaxWsDynamicClientFactory.newInstance();
		    HTTPClientPolicy httpClientPolicy = new HTTPClientPolicy();    // 策略
		    httpClientPolicy.setConnectionTimeout( 36000 );    //连接超时 
		    httpClientPolicy.setAllowChunking( false );   
		    httpClientPolicy.setReceiveTimeout( 10000 );       //接收超时
		    Client client = dcf.createClient(requestUrl);
		    HTTPConduit http = (HTTPConduit) client.getConduit();  
		    http.setClient(httpClientPolicy);
		    obj = client.invoke("ParseXml", new Object[]{xmlString});
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(obj!=null && obj.length>0){
			result = (String)obj[0];
		}
		return result;
	}
	
	private String getDataFromXmlFile(String testDataFilePath){

		InputStream in = null;
		Document document = null;
		SAXReader saxReader = new SAXReader();
		try {
			//配置了测试数据地址，使用外部数据
			if(testDataFilePath!=null){
				 File file = new File(testDataFilePath);
				 in = new FileInputStream(file);
			}else{
				in = Thread
						.currentThread()
						.getContextClassLoader()
						.getResourceAsStream(
								"xmlDataSource/orderData.xml");
			}
			document = saxReader.read(in);
		} catch (DocumentException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		String xml = document.asXML();
		
		return xml;
	
	}
	
	//格式化xml字符串输出
	private static String formatXML(String inputXML) {
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

}
