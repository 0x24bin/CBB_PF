package com.foo.manager.commonManager.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.foo.IService.INJCommonManagerService;
import com.foo.common.CommonDefine;
import com.foo.common.CommonException;
import com.foo.common.MessageCodeDefine;
import com.foo.manager.commonManager.service.CommonManagerService;
import com.foo.util.CommonUtil;
import com.foo.util.XmlUtil;

@Service
public class NJCommonManagerServiceImpl extends CommonManagerService implements INJCommonManagerService{

	@Override
	public Map<String, Object> getAllSkus(Map<String, Object> params)
			throws CommonException {
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		int total = 0;

		// 开始
		Integer start = params.get("start") == null ? null : Integer
				.valueOf(params.get("start").toString());
		// 结束
		Integer limit = params.get("limit") == null ? null : Integer
				.valueOf(params.get("limit").toString());

		params.remove("start");
		params.remove("limit");
		try {
			List<String> keys=new ArrayList<String>(params.keySet());
			List<Object> values=new ArrayList<Object>(params.values());
			rows = commonManagerMapper.selectTableListByNVList(T_NJ_SKU, 
					keys,values,start, limit);

			total = commonManagerMapper.selectTableListCountByNVList(T_NJ_SKU,
					keys,values);

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", total);
			result.put("rows", rows);
			return result;
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}

	@Override
	public void delSku(Map<String, Object> params) throws CommonException {
		try {
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					params.get("APP_STATUS"))) {
				String guid = params.get("GUID").toString();
				//
				Map data =  njCommonManagerMapper.selectDataForMessage203_NJ(guid);
				
				if(data.get("APP_TIME")!=null){
					data.remove("APP_TIME");
					
					//更新申报时间
					String currentTime = new SimpleDateFormat(
							CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
					
					String reponse = submitXml_SKU(guid,data,CommonDefine.CEB203,currentTime);
					
					if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse)){
						//删除数据
						commonManagerMapper.delTableById(T_NJ_SKU, "SKU_ID",
								params.get("SKU_ID"));
					}else{
						//抛出错误信息
						throw new CommonException(new Exception(),
								MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
					}
				}
			}else if(Integer.valueOf(CommonDefine.APP_STATUS_STORE).equals(
					params.get("APP_STATUS"))){
				//删除数据
				commonManagerMapper.delTableById(T_NJ_SKU, "SKU_ID",
						params.get("SKU_ID"));
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}

	@Override
	public void setSku(Map<String, Object> sku, boolean statusOnly)
			throws CommonException {
		try {
			String tableName=T_NJ_SKU;
			List<String> uniqueCol = new ArrayList<String>();
			uniqueCol.add("ITEM_NO");
			uniqueCol.add("BIZ_TYPE");
			List<Object> uniqueVal = new ArrayList<Object>();
			uniqueVal.add(sku.get("ITEM_NO"));
			uniqueVal.add(sku.get("BIZ_TYPE"));
			String primaryCol="SKU_ID";
			// 货号/业务类型唯一性校验
			uniqueCheck(tableName,uniqueCol,uniqueVal,primaryCol,sku.get(primaryCol),false);
			
			sku.remove("editType");

			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					sku.get("APP_STATUS"))) {
				String guid = sku.get("GUID").toString();
				//原始数据
				Map oldData = commonManagerMapper.selectTableListByCol(T_NJ_SKU, "GUID", guid, null, null).get(0);
				
				Map data =  null;
				
				int messageType = CommonDefine.CEB202;
				if(oldData.get("APP_TIME") == null){
					data = njCommonManagerMapper.selectDataForMessage201_NJ(guid);
					messageType = CommonDefine.CEB201;
				}else{
					Map newData = sku;
					//获取差异字段
					data = compareData(newData,oldData);
					//必须添加GNo作为唯一识别
					data.put("G_NO", newData.get("G_NO"));
				}
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_SKU(guid,data,messageType,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) ||
						reponse.startsWith("P")){
					
					sku.put("APP_TIME", currentTime);
					sku.put("PRE_NO", reponse);
					
//					njCommonManagerMapper.updateSku_nj(sku);
					//更新数据
					commonManagerMapper.updateTableByNVList(tableName, primaryCol,
							sku.get(primaryCol), new ArrayList<String>(sku.keySet()),
							new ArrayList<Object>(sku.values()));
				}else{
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}else{
				//更新数据
				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						sku.get(primaryCol), new ArrayList<String>(sku.keySet()),
						new ArrayList<Object>(sku.values()));
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}

	@Override
	public void addSku(Map<String, Object> sku) throws CommonException {
		try {
			String tableName=T_NJ_SKU;
			List<String> uniqueCol = new ArrayList<String>();
			uniqueCol.add("ITEM_NO");
			uniqueCol.add("BIZ_TYPE");
			List<Object> uniqueVal = new ArrayList<Object>();
			uniqueVal.add(sku.get("ITEM_NO"));
			uniqueVal.add(sku.get("BIZ_TYPE"));
			
			String primaryCol="SKU_ID";
			// 货号/业务类型唯一性校验
			uniqueCheck(tableName,uniqueCol,uniqueVal,null,null,false);
			
			sku.remove("editType");
			// 设置空id
			sku.put(primaryCol, null);
			// 设置guid
			sku.put("GUID", CommonUtil.generalGuid4NJ(CommonDefine.CEB201,sku.get("EBC_CODE").toString(),sku.get("CUSTOM_CODE").toString()));
			// 设置创建时间
			sku.put("CREAT_TIME", new Date());

			Map primary=new HashMap();
			primary.put("primaryId", null);

			//插入数据
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(sku.keySet()), 
					new ArrayList<Object>(sku.values()),
					primary);
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					sku.get("APP_STATUS"))) {
				String guid = sku.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage201_NJ(guid);
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_SKU(guid,data,CommonDefine.CEB201,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					sku.put("APP_TIME", currentTime);
					sku.put("PRE_NO", reponse);
					
					njCommonManagerMapper.updateSku_nj(sku);
				}else{
					//删除数据
					commonManagerMapper.delTableById(T_NJ_SKU, "GUID",
							guid);
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public Map<String, Object> getAllOrders(Map<String, Object> params)
			throws CommonException {
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		int total = 0;

		// 开始
		Integer start = params.get("start") == null ? null : Integer
				.valueOf(params.get("start").toString());
		// 结束
		Integer limit = params.get("limit") == null ? null : Integer
				.valueOf(params.get("limit").toString());

		params.remove("start");
		params.remove("limit");
		try {
			String tableName = T_NJ_ORDERS;
			if(params.get("IN_USE")!=null){
				if(Boolean.FALSE.equals(params.get("IN_USE"))){
					tableName = V_NJ_ORDERS_UNUSE;
				}
				params.remove("IN_USE");
			}
			List<String> keys=new ArrayList<String>(params.keySet());
			List<Object> values=new ArrayList<Object>(params.values());
			rows = commonManagerMapper.selectTableListByNVList(tableName, 
					keys,values,start, limit);
			total = commonManagerMapper.selectTableListCountByNVList(tableName,
					keys,values);
			
			for(Map<String, Object> row:rows){
				row.put("GOODSList", getGoodsList(row));
			}

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", total);
			result.put("rows", rows);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void delOrder(Map<String, Object> params) throws CommonException {
		try {
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					params.get("APP_STATUS"))) {
				String guid = params.get("GUID").toString();
				//
				Map data =  njCommonManagerMapper.selectDataForMessage303_NJ(guid);
				
				if(data.get("APP_TIME")!=null){
					data.remove("APP_TIME");
					
					//更新申报时间
					String currentTime = new SimpleDateFormat(
							CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
					
					String reponse = submitXml_ORDER(guid,data,null,CommonDefine.CEB303,currentTime);
					
					if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse)){
						//删除数据
						commonManagerMapper.delTableById(T_NJ_ORDERS, "ORDERS_ID",
								params.get("ORDERS_ID"));
					}else{
						//抛出错误信息
						throw new CommonException(new Exception(),
								MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
					}
				}
			}else if(Integer.valueOf(CommonDefine.APP_STATUS_STORE).equals(
					params.get("APP_STATUS"))){
				//删除数据
				commonManagerMapper.delTableById(T_NJ_ORDERS, "ORDERS_ID",
						params.get("ORDERS_ID"));
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void addOrder(Map<String, Object> order) throws CommonException {
		try {
			String tableName=T_NJ_ORDERS;
			String uniqueCol="ORDER_NO";
			String primaryCol="ORDERS_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,order.get(uniqueCol),null,null,false);
			
			order.remove("editType");
			// 设置空id
			order.put(primaryCol, null);
			
			// 设置guid
			order.put("GUID", CommonUtil.generalGuid4NJ(CommonDefine.CEB301,order.get("EBC_CODE").toString(),order.get("CUSTOM_CODE").toString()));
			// 设置创建时间
			order.put("CREAT_TIME", new Date());
			
			Object orderNo = order.get("ORDER_NO");
			List<Map> GOODSList=(List<Map>)order.get("GOODSList");
			order.remove("GOODSList");
			//插入数据
			Map primary=new HashMap();
			primary.put("primaryId", null);
			
			if(order.get("UNDER_THE_SINGER_ID") == null || order.get("UNDER_THE_SINGER_ID").toString().isEmpty()){
				order.put("UNDER_THE_SINGER_ID", null);
			}
			if(order.get("TAX_FEE") == null || order.get("TAX_FEE") .toString().isEmpty()){
				order.put("TAX_FEE", null);
			}
			
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(order.keySet()), 
					new ArrayList<Object>(order.values()),
					primary);
			Object primaryId=primary.get("primaryId");
			setGoodsList(GOODSList,orderNo,primaryId);
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					order.get("APP_STATUS"))) {
				String guid = order.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage301_NJ(guid);
				
				//获取订单详细信息
				List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage301_NJ(Integer.valueOf(primaryId.toString()));
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_ORDER(guid,data,subDataList,CommonDefine.CEB301,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					order.put("APP_TIME", currentTime);
//					order.put("PRE_NO", reponse);
					order.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
					order.put("RETURN_STATUS",CommonDefine.RETURN_STATUS_2);
					
					njCommonManagerMapper.updateOrder_nj(order);
				}else{
					//删除数据
					commonManagerMapper.delTableById(T_NJ_ORDERS, "GUID",
							guid);
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void setOrder(Map<String, Object> order, boolean statusOnly)
			throws CommonException {
		try {
			String tableName=T_NJ_ORDERS;
			String uniqueCol="ORDER_NO";
			String primaryCol="ORDERS_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,order.get(uniqueCol),primaryCol,order.get(primaryCol),false);
			
			order.remove("editType");
			
			Object orderNo = order.get("ORDER_NO");
			List<Map> GOODSList=(List<Map>)order.get("GOODSList");
			order.remove("GOODSList");
			
			Object primaryId=order.get(primaryCol);
			
			if(order.get("UNDER_THE_SINGER_ID") == null || order.get("UNDER_THE_SINGER_ID").toString().isEmpty()){
				order.put("UNDER_THE_SINGER_ID", null);
			}

			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					order.get("APP_STATUS"))) {
				String guid = order.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage301_NJ(guid);
				
				//获取订单详细信息
				List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage301_NJ(Integer.valueOf(primaryId.toString()));
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_ORDER(guid,data,subDataList,CommonDefine.CEB301,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					order.put("APP_TIME", currentTime);
//					order.put("PRE_NO", reponse);
					order.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
					order.put("RETURN_STATUS",CommonDefine.RETURN_STATUS_2);
					//更新数据
					if(order.get("TAX_FEE") == null || order.get("TAX_FEE") .toString().isEmpty()){
						order.put("TAX_FEE", null);
					}
					commonManagerMapper.updateTableByNVList(tableName, primaryCol,
							order.get(primaryCol), new ArrayList<String>(order.keySet()),
							new ArrayList<Object>(order.values()));
					setGoodsList(GOODSList,orderNo,primaryId);
					
//					njCommonManagerMapper.updateOrder_nj(order);
				}else{
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}else{
				//更新数据
				if(order.get("TAX_FEE") == null || order.get("TAX_FEE") .toString().isEmpty()){
					order.put("TAX_FEE", null);
				}
				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						order.get(primaryCol), new ArrayList<String>(order.keySet()),
						new ArrayList<Object>(order.values()));
				setGoodsList(GOODSList,orderNo,primaryId);
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public void setGoodsList(List<Map> GOODSList,Object orderNo, Object ordersId){
		commonManagerMapper.delTableById(T_NJ_ORDER_DETAIL, "ORDERS_ID", ordersId);
		Date createTime=new Date();
		for(int i=0;i<GOODSList.size();i++){
			GOODSList.get(i).put("PRICE", GOODSList.get(i).get("ONE_PRICE"));
			GOODSList.get(i).put("NOTE", GOODSList.get(i).get("NOTE_OD"));
			Map good=new HashMap();
			good.put("ORDERS_ID", ordersId);
			good.put("ORDER_NO", orderNo);
			good.put("GNUM", i+1);
			good.put("CREAT_TIME", createTime);
			String[] copyColumns=new String[]{"ITEM_NO","QTY","PRICE","TOTAL","NOTE"};
			for(String col:copyColumns){
				good.put(col, GOODSList.get(i).get(col));
			}
			Map primary=new HashMap();
			primary.put("primaryId", null);
			commonManagerMapper.insertTableByNVList(T_NJ_ORDER_DETAIL,
					new ArrayList<String>(good.keySet()), 
					new ArrayList<Object>(good.values()),
					primary);
		}
	}
	
	@Override
	public void getReceipt(Map<String, Object> params) throws CommonException {
		try {
			String guid = params.get("GUID").toString();
			String ebcCode = params.get("EBC_CODE").toString();
			
			Integer MessageType = Integer.valueOf(params.get("MESSAGE_TYPE").toString());
			switch(MessageType){
			case CommonDefine.CEB201:
				String itemNo = params.get("ITEM_NO").toString();
				//更新回执状态
				getReceipt_SKU(guid, ebcCode,itemNo, CommonDefine.CEB201_RECEIPT_SINGLE);
				break;
			case CommonDefine.CEB601:
				String logisticsNo = params.get("LOGISTICS_NO").toString();
				//更新回执状态
				getReceipt_INVENTORY(guid, ebcCode,logisticsNo, CommonDefine.CEB601_RECEIPT_SINGLE);
				break;
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public List<Map<String, Object>> getGoodsList(Map<String, Object> order){
		List<Map<String, Object>> goods=commonManagerMapper.selectTableListByCol(T_NJ_ORDER_DETAIL, "ORDERS_ID", order.get("ORDERS_ID"), null, null);
		for(Map<String, Object> good:goods){
			good.put("ONE_PRICE", good.get("PRICE"));
			good.remove("PRICE");
			good.put("NOTE_OD", good.get("NOTE"));
			good.remove("NOTE");
			List<Map<String, Object>> skus=commonManagerMapper.selectTableListByCol(T_NJ_SKU, "ITEM_NO", good.get("ITEM_NO"), 0, 1);
			if(!skus.isEmpty()){
				for(String col:skus.get(0).keySet()){
					if(!good.containsKey(col))
						good.put(col, skus.get(0).get(col));
				}
			}
		}
		return goods;
	}
	
	
	@Override
	public Map<String, Object> getAllLogisticses(Map<String, Object> params)
			throws CommonException {
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		int total = 0;

		// 开始
		Integer start = params.get("start") == null ? null : Integer
				.valueOf(params.get("start").toString());
		// 结束
		Integer limit = params.get("limit") == null ? null : Integer
				.valueOf(params.get("limit").toString());

		params.remove("start");
		params.remove("limit");
		try {
			String tableName = T_NJ_LOGISTICS;
			if(params.get("IN_USE")!=null){
				if(Boolean.FALSE.equals(params.get("IN_USE"))){
					tableName = V_NJ_LOGISTICS_UNUSE;
				}
				params.remove("IN_USE");
			}
			
			List<String> keys=new ArrayList<String>(params.keySet());
			List<Object> values=new ArrayList<Object>(params.values());
			rows = commonManagerMapper.selectTableListByNVList(tableName, 
					keys,values,start, limit);
			total = commonManagerMapper.selectTableListCountByNVList(tableName,
					keys,values);
			
			for(Map<String, Object> row:rows){
				Map<String, Object> additionInfo=getLogisticsOrder(row);
				if(additionInfo!=null)
					row.putAll(additionInfo);
			}

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", total);
			result.put("rows", rows);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void delLogistics(Map<String, Object> params) throws CommonException {
		try {
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					params.get("APP_STATUS"))) {
				String guid = params.get("GUID").toString();
				//
				Map data =  njCommonManagerMapper.selectDataForMessage502_NJ(guid);
				
				if(data.get("APP_TIME")!=null){
					data.remove("APP_TIME");
					
					//更新申报时间
					String currentTime = new SimpleDateFormat(
							CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
					
					String reponse = submitXml_LOGISTICS(guid,data,null,CommonDefine.CEB502,currentTime);
					
					if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse)){
						//删除数据
						commonManagerMapper.delTableById(T_NJ_LOGISTICS, "LOGISTICS_ID",
								params.get("LOGISTICS_ID"));
					}else{
						//抛出错误信息
						throw new CommonException(new Exception(),
								MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
					}
				}
			}else if(Integer.valueOf(CommonDefine.APP_STATUS_STORE).equals(
					params.get("APP_STATUS"))){
				//删除数据
				commonManagerMapper.delTableById(T_NJ_LOGISTICS, "LOGISTICS_ID",
						params.get("LOGISTICS_ID"));
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void setLogistics(Map<String, Object> logistics, boolean statusOnly)
			throws CommonException {
		
		logistics.remove("EBC_CODE");
		logistics.remove("EBP_CODE");
		
		try {
			String primaryCol="LOGISTICS_ID";
			String tableName=T_NJ_LOGISTICS;
			if(statusOnly){
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String guid = logistics.get("GUID").toString();
				
				Map data =  njCommonManagerMapper.selectDataForMessage503_NJ(guid);
				
				//填充数据
				data.put("LOGISTICS_STATUS", logistics.get("LOGISTICS_STATUS"));
				data.put("LOGISTICS_TIME", currentTime);
				
//				String reponse = "";
				
				String reponse = submitXml_LOGISTICS(guid,data,null,CommonDefine.CEB503,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
//					logistics.put("APP_TIME", currentTime);
//					order.put("PRE_NO", reponse);
					logistics.put("RETURN_STATUS",CommonDefine.RETURN_STATUS_2);
					logistics.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
					//更新数据
				List<String> keys=Arrays.asList(new String[]{
						"LOGISTICS_STATUS","RETURN_STATUS","RETURN_TIME","RETURN_INFO"});
				List<Object> values=Arrays.asList(new Object[]{
						logistics.get("LOGISTICS_STATUS"),
							logistics.get("RETURN_STATUS"),null,null});

				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						logistics.get(primaryCol), keys, values);
					
//					njCommonManagerMapper.updateOrder_nj(order);
				}else{
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}else{
				String uniqueCol="LOGISTICS_NO";
				// 唯一性校验
				uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),primaryCol,logistics.get(primaryCol),false);
				uniqueCol="ORDER_NO";
				uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),primaryCol,logistics.get(primaryCol),false);
				logistics.remove("editType");
				//生成报文
				if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
						logistics.get("APP_STATUS"))) {
					String guid = logistics.get("GUID").toString();
					Map data =  njCommonManagerMapper.selectDataForMessage501_NJ(guid);
					
					//获取订单详细信息
					List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage501_NJ(logistics.get("ORDER_NO").toString());
					
					//更新申报时间
					String currentTime = new SimpleDateFormat(
							CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
					
					//测试
//					String reponse = "";
					
					String reponse = submitXml_LOGISTICS(guid,data,subDataList,CommonDefine.CEB501,currentTime);
					
					if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
							reponse.startsWith("P")){
						
						logistics.put("APP_TIME", currentTime);
//						order.put("PRE_NO", reponse);
						logistics.put("RETURN_STATUS",CommonDefine.RETURN_STATUS_2);
						logistics.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
						//更新数据
						commonManagerMapper.updateTableByNVList(tableName, primaryCol,
								logistics.get(primaryCol), new ArrayList<String>(logistics.keySet()),
								new ArrayList<Object>(logistics.values()));
						
//						njCommonManagerMapper.updateOrder_nj(order);
					}else{
						//抛出错误信息
						throw new CommonException(new Exception(),
								MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
					}
				}else{
					//更新数据
					commonManagerMapper.updateTableByNVList(tableName, primaryCol,
							logistics.get(primaryCol), new ArrayList<String>(logistics.keySet()),
							new ArrayList<Object>(logistics.values()));
				}
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	@Override
	public void addLogistics(Map<String, Object> logistics) throws CommonException {
		try {
			String tableName=T_NJ_LOGISTICS;
			String uniqueCol="LOGISTICS_NO";
			String primaryCol="LOGISTICS_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),null,null,false);
			uniqueCol="ORDER_NO";
			uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),null,null,false);
			
			logistics.remove("editType");
			// 设置空id
			logistics.put(primaryCol, null);
			
			// 设置guid
			logistics.put("GUID", CommonUtil.generalGuid4NJ(CommonDefine.CEB501,logistics.get("EBC_CODE").toString(),logistics.get("CUSTOM_CODE").toString()));
			// 设置创建时间
			logistics.put("CREAT_TIME", new Date());
			
			Map primary=new HashMap();
			primary.put("primaryId", null);
			
			logistics.remove("EBC_CODE");
			logistics.remove("EBP_CODE");

			//插入数据
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(logistics.keySet()), 
					new ArrayList<Object>(logistics.values()),
					primary);
			
			Object primaryId=primary.get("primaryId");
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					logistics.get("APP_STATUS"))) {
				
				String guid = logistics.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage501_NJ(guid);
				
				//获取订单详细信息
				List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage501_NJ(logistics.get("ORDER_NO").toString());
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_LOGISTICS(guid,data,subDataList,CommonDefine.CEB501,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					logistics.put("APP_TIME", currentTime);
					
					logistics.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
					logistics.put("RETURN_STATUS",CommonDefine.RETURN_STATUS_2);
					
					njCommonManagerMapper.updateLogistics_nj(logistics);
				}else{
					//删除数据
					commonManagerMapper.delTableById(T_NJ_LOGISTICS, "GUID",
							guid);
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public Map<String, Object> getLogisticsOrder(Map<String, Object> logistics){
		Map<String, Object> resultMap=null;
		Object ORDER_NO=logistics.get("ORDER_NO");
		if(ORDER_NO!=null){
			List<Map<String, Object>> orders=commonManagerMapper.selectTableListByCol(
					T_NJ_ORDERS, "ORDER_NO", ORDER_NO, null, null);
			if(orders!=null&&!orders.isEmpty()){
				Map<String, Object> orderMap=orders.get(0);
				resultMap=new HashMap<String, Object>();
				resultMap.put("EBP_CODE", orderMap.get("EBP_CODE"));
				resultMap.put("EBC_CODE", orderMap.get("EBC_CODE"));
				resultMap.put("AGENT_CODE", orderMap.get("AGENT_CODE"));
				resultMap.put("CONSIGNEE_COUNTRY_O", orderMap.get("CONSIGNEE_COUNTRY"));
				resultMap.put("GOODSList", getGoodsList(orderMap));
			}
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> getAllInventorys(Map<String, Object> params)
			throws CommonException {
		List<Map<String, Object>> rows = new ArrayList<Map<String, Object>>();

		int total = 0;

		// 开始
		Integer start = params.get("start") == null ? null : Integer
				.valueOf(params.get("start").toString());
		// 结束
		Integer limit = params.get("limit") == null ? null : Integer
				.valueOf(params.get("limit").toString());

		params.remove("start");
		params.remove("limit");
		try {
			String tableName = V_NJ_INVENTORY;
			/*if(params.get("IN_USE")!=null){
				if(Boolean.FALSE.equals(params.get("IN_USE"))){
					tableName = "v_logistics_unuse";
				}
				params.remove("IN_USE");
			}*/
			
			List<String> keys=new ArrayList<String>(params.keySet());
			List<Object> values=new ArrayList<Object>(params.values());
			rows = commonManagerMapper.selectTableListByNVList(tableName, 
					keys,values,start, limit);
			total = commonManagerMapper.selectTableListCountByNVList(tableName,
					keys,values);
			
			for(Map<String, Object> row:rows){
				row.put("GOODSList", 
					commonManagerMapper.selectTableListByCol(
						V_NJ_INVENTORY_DETAIL, "INVENTORY_ID", row.get("INVENTORY_ID"), null, null));
			}

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("total", total);
			result.put("rows", rows);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void delInventory(Map<String, Object> params) throws CommonException {
		
		try {
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					params.get("APP_STATUS"))) {
				String guid = params.get("GUID").toString();
				//
				Map data =  njCommonManagerMapper.selectDataForMessage602_NJ(guid);
				
				if(data.get("APP_TIME")!=null){
					data.remove("APP_TIME");
					
					//更新申报时间
					String currentTime = new SimpleDateFormat(
							CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
					
					String reponse = submitXml_INVENTORY(guid,data,null,CommonDefine.CEB603,currentTime);
					
					if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse)){
						//删除数据
						commonManagerMapper.delTableById(T_NJ_INVENTORY, "INVENTORY_ID",
								params.get("INVENTORY_ID"));
					}else{
						//抛出错误信息
						throw new CommonException(new Exception(),
								MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
					}
				}
			}else if(Integer.valueOf(CommonDefine.APP_STATUS_STORE).equals(
					params.get("APP_STATUS"))){
				//删除数据
				commonManagerMapper.delTableById(T_NJ_INVENTORY, "INVENTORY_ID",
						params.get("INVENTORY_ID"));
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	@Override
	public void setInventory(Map<String, Object> inventory, boolean statusOnly)
			throws CommonException {
		try {
			String tableName=T_NJ_INVENTORY;
			String uniqueCol="COP_NO";
			String primaryCol="INVENTORY_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),primaryCol,inventory.get(primaryCol),false);
			uniqueCol="LOGISTICS_NO";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),primaryCol,inventory.get(primaryCol),false);
			
			inventory.remove("editType");
			inventory.remove("EBC_CODE");
			
			List<Map> GOODSList=(List<Map>)inventory.get("GOODSList");
			inventory.remove("GOODSList");

			Object primaryId=inventory.get(primaryCol);

			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					inventory.get("APP_STATUS"))) {
				String guid = inventory.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage601_NJ(guid);
				
				//获取订单详细信息
				List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage601_NJ(Integer.valueOf(primaryId.toString()));
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_INVENTORY(guid,data,subDataList,CommonDefine.CEB601,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					inventory.put("APP_TIME", currentTime);
					inventory.put("PRE_NO", reponse);
					//更新数据
					commonManagerMapper.updateTableByNVList(tableName, primaryCol,
							inventory.get(primaryCol), new ArrayList<String>(inventory.keySet()),
							new ArrayList<Object>(inventory.values()));
					setInventoryGoodsList(GOODSList,primaryId,true);
					
//					njCommonManagerMapper.updateOrder_nj(order);
				}else{
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}else{
				//更新数据
				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						inventory.get(primaryCol), new ArrayList<String>(inventory.keySet()),
						new ArrayList<Object>(inventory.values()));
				setInventoryGoodsList(GOODSList,primaryId,true);
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	
	@Override
	public void addInventory(Map<String, Object> inventory) throws CommonException {
		try {
			String tableName=T_NJ_INVENTORY;
			String uniqueCol="COP_NO";
			String primaryCol="INVENTORY_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),null,null,false);
			uniqueCol="LOGISTICS_NO";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),null,null,false);
			
			inventory.remove("editType");
			// 设置空id
			inventory.put(primaryCol, null);
			
			// 设置guid
			inventory.put("GUID", CommonUtil.generalGuid4NJ(CommonDefine.CEB601,inventory.get("EBC_CODE").toString(),inventory.get("CUSTOM_CODE").toString()));
			
			inventory.remove("EBC_CODE");
			// 设置创建时间
			inventory.put("CREAT_TIME", new Date());
			
			List<Map> GOODSList=(List<Map>)inventory.get("GOODSList");
			inventory.remove("GOODSList");
			
			Map primary=new HashMap();
			primary.put("primaryId", null);
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(inventory.keySet()), 
					new ArrayList<Object>(inventory.values()),
					primary);
			
			Object primaryId=primary.get("primaryId");
			setInventoryGoodsList(GOODSList,primaryId,false);
			//生成报文
			if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
					inventory.get("APP_STATUS"))) {
				String guid = inventory.get("GUID").toString();
				Map data =  njCommonManagerMapper.selectDataForMessage601_NJ(guid);
				
				//获取订单详细信息
				List<Map> subDataList = njCommonManagerMapper.selectSubDataForMessage601_NJ(Integer.valueOf(primaryId.toString()));
				
				//更新申报时间
				String currentTime = new SimpleDateFormat(
						CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
				
				String reponse = submitXml_INVENTORY(guid,data,subDataList,CommonDefine.CEB601,currentTime);
				
				if(reponse.isEmpty() || CommonDefine.RESPONSE_OK.equals(reponse) || 
						reponse.startsWith("P")){
					
					inventory.put("APP_TIME", currentTime);
					inventory.put("PRE_NO", reponse);
					
					njCommonManagerMapper.updateInventory_nj(inventory);
				}else{
					//删除数据
					commonManagerMapper.delTableById(T_NJ_INVENTORY, "GUID",
							guid);
					//抛出错误信息
					throw new CommonException(new Exception(),
							MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, reponse);
				}
			}
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	
	public void setInventoryGoodsList(List<Map> GOODSList,Object inventoryId,boolean isUpdate){

		String tableName=T_NJ_INVENTORY_DETAIL;
		String primaryCol="INVENTORY_DETAIL_ID";
		String ownerCol="INVENTORY_ID";
		Date createTime=new Date();
		for(int i=0;i<GOODSList.size();i++){
			Map rowMap=GOODSList.get(i);
			rowMap.put("PRICE", rowMap.get("ONE_PRICE"));
			rowMap.put("UNIT", rowMap.get("UNIT_I"));
			rowMap.put("UNIT1", rowMap.get("UNIT1_I"));
			rowMap.put("UNIT2", rowMap.get("UNIT2_I"));
			
			Map good=new HashMap();
			good.put(ownerCol, inventoryId);
			good.put("CREAT_TIME", createTime);
			String[] copyColumns=new String[]{primaryCol,
					"GNUM","ITEM_NO","QTY","QTY1","QTY2",
					"UNIT","UNIT1","UNIT2","PRICE","TOTAL"};
			for(String col:copyColumns){
				good.put(col, rowMap.get(col));
			}

			if(!isUpdate){
				good.remove(primaryCol);
				Map primary=new HashMap();
				primary.put("primaryId", null);
				commonManagerMapper.insertTableByNVList(tableName,
						new ArrayList<String>(good.keySet()), 
						new ArrayList<Object>(good.values()),
						primary);
			}else{
				Object primaryValue=good.get(primaryCol);
				commonManagerMapper.updateTableByNVList(tableName,
						primaryCol,primaryValue,
						new ArrayList<String>(good.keySet()), 
						new ArrayList<Object>(good.values()));
			}
		}
	}

	// 生成xml文件
	private String submitXml_SKU(String guid, Map<String, Object> data,int messageType,String currentTime) throws CommonException{
		// 提交需要生成xml文件
			System.out.println("submitXml_SKU_NJ_"+messageType);
			
			Map head = njCommonManagerMapper.selectDataForMessage20X_NJ_head(guid);
			
			head.put("SEND_TIME", currentTime);
			
			switch(messageType){
			case CommonDefine.CEB201:
				head.put("MESSAGE_TYPE", CommonDefine.CEB201);
				break;
			case CommonDefine.CEB202:
				head.put("MESSAGE_TYPE", CommonDefine.CEB202);
				break;
			case CommonDefine.CEB203:
				head.put("MESSAGE_TYPE", CommonDefine.CEB203);
				break;	
			}
			//xml报文
			String resultXmlString = XmlUtil.generalRequestXml4NJ(head, data, null, messageType);
			//获取返回xml字符串
			String response = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_DECLARE);
			
			//获取返回信息
			return response;
	}
	
	// 生成xml文件
	private String submitXml_LOGISTICS(String guid, Map<String, Object> data,List<Map> subDataList, int messageType,String currentTime) throws CommonException{
		// 提交需要生成xml文件
			System.out.println("submitXml_LOGISTICS_NJ_"+messageType);
			
			Map head = njCommonManagerMapper.selectDataForMessage50X_NJ_head(guid);
			
			head.put("SEND_TIME", currentTime);
			if(data.containsKey("APP_TIME")){
			data.put("APP_TIME", currentTime);
			}
			switch(messageType){
			case CommonDefine.CEB501:
				head.put("MESSAGE_TYPE", CommonDefine.CEB501);
				break;
			case CommonDefine.CEB502:
				head.put("MESSAGE_TYPE", CommonDefine.CEB502);
				break;
			case CommonDefine.CEB503:
				head.put("MESSAGE_TYPE", CommonDefine.CEB503);
				break;	
			}
			//xml报文
			String resultXmlString = XmlUtil.generalRequestXml4NJ(head, data, subDataList, messageType);
			//获取返回xml字符串
			String response = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_DECLARE);
			
			//获取返回信息
			return response;
	}
	

	// 生成xml文件
	public String submitXml_ORDER(String guid, Map<String, Object> data, List<Map> subDataList, int messageType,String currentTime)  throws CommonException{
		
		// 提交需要生成xml文件
		System.out.println("submitXml_ORDER_NJ_"+messageType);
		
		Map head = njCommonManagerMapper.selectDataForMessage30X_NJ_head(guid);
		
		head.put("SEND_TIME", currentTime);
		data.put("APP_TIME", currentTime);
		
		switch(messageType){
		case CommonDefine.CEB301:
			head.put("MESSAGE_TYPE", CommonDefine.CEB301);
			break;
		case CommonDefine.CEB302:
			head.put("MESSAGE_TYPE", CommonDefine.CEB302);
			break;
		case CommonDefine.CEB303:
			head.put("MESSAGE_TYPE", CommonDefine.CEB303);
			break;	
		}
		//xml报文
		String resultXmlString = XmlUtil.generalRequestXml4NJ(head, data, subDataList, messageType);
		//获取返回xml字符串
		String response = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_DECLARE);
		
		//获取返回信息
		return response;
	}
	
	// 生成xml文件
	public String submitXml_INVENTORY(String guid, Map<String, Object> data, List<Map> subDataList, int messageType,String currentTime)  throws CommonException{
		
		// 提交需要生成xml文件
		System.out.println("submitXml_INVENTORY_NJ_"+messageType);
		
		Map head = njCommonManagerMapper.selectDataForMessage60X_NJ_head(guid);
		
		head.put("SEND_TIME", currentTime);
		data.put("APP_TIME", currentTime);
		
		switch(messageType){
		case CommonDefine.CEB601:
			head.put("MESSAGE_TYPE", CommonDefine.CEB601);
			break;
		case CommonDefine.CEB603:
			head.put("MESSAGE_TYPE", CommonDefine.CEB603);
			break;
		}
		//xml报文
		String resultXmlString = XmlUtil.generalRequestXml4NJ(head, data, subDataList, messageType);
		//获取返回xml字符串
		String response = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_DECLARE);
		
		//获取返回信息
		return response;
	}
	
	// 生成xml文件
	private void getReceipt_SKU(String guid, String ebcCode,String itemNo, int messageType) throws CommonException{
		// 提交需要生成xml文件
			System.out.println("getReceipt_SKU_NJ_"+messageType);
			
			Map<String,String> leafNods = new HashMap<String,String>();

			switch(messageType){
			case CommonDefine.CEB201_RECEIPT_SINGLE:
				leafNods.put("strEbcCode", ebcCode);
				leafNods.put("strItemNo", itemNo);
				break;
			case CommonDefine.CEB201_RECEIPT_LIST:
				leafNods.put("strEbcCode", ebcCode);
				break;
			}
			//xml报文
			String resultXmlString = XmlUtil.generalReceiptXml4NJ(messageType, leafNods);
			//获取返回数据
			String soapResponseData = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_RECEIPT);
/*			//摘取出返回信息
			soapResponseData = "<NewDataSet>"+
		        "<NJKJ_MESSAGE_APPR_RTN>"+
		            "<EBC_CODE>3215916102</EBC_CODE>"+
		            "<ITEM_NO>G23521506000000261</ITEM_NO>"+
					"<G_NO />"+
		            "<CHK_STATUS>3</CHK_STATUS>"+
		            "<CHK_RESULT>审批意见</CHK_RESULT>"+
					"<CHK_TIME>20150723085544 </CHK_TIME>"+
		        "</NJKJ_MESSAGE_APPR_RTN>"+
		        "<NJKJ_MESSAGE_APPR_RTN>"+
		            "<EBC_CODE>3215916102</EBC_CODE>"+
		           "<ITEM_NO>G23521506000000262</ITEM_NO>"+
		            "<G_NO>32159161020000000012</G_NO>"+
		            "<CHK_STATUS>2</CHK_STATUS>"+
					"<CHK_RESULT />"+
					"<CHK_TIME>20150723085544 </CHK_TIME>"+
		        "</NJKJ_MESSAGE_APPR_RTN>"+
		    "</NewDataSet>";*/
			if(soapResponseData == null ||soapResponseData.isEmpty()){
				//抛出错误信息
				throw new CommonException(new Exception(),
						MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, "无回执信息！");
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
						sku.put("GUID", guid);
						//回执状态为3审批通过 更新申报状态 为申报完成
						if (sku.get("RETURN_STATUS") != null
								&& Integer.valueOf(sku.get(
										"RETURN_STATUS").toString()) == CommonDefine.RETURN_STATUS_2) {
							sku.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
						}
						njCommonManagerMapper.updateSku_nj(sku);
					}
				}
			}else{
				//抛出错误信息
				throw new CommonException(new Exception(),
						MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, soapResponseData);
			}
	}

	// 生成xml文件
	private void getReceipt_INVENTORY(String guid, String ebcCode,String logisticsNo, int messageType) throws CommonException{
		// 提交需要生成xml文件
			System.out.println("getReceipt_INVENTORY_NJ_"+messageType);
			
			Map<String,String> leafNods = new HashMap<String,String>();

			switch(messageType){
			case CommonDefine.CEB601_RECEIPT_SINGLE:
				leafNods.put("strEbcCode", ebcCode);
				leafNods.put("strLogisticsNo", logisticsNo);
				break;
			case CommonDefine.CEB601_RECEIPT_LIST:
				leafNods.put("strEbcCode", ebcCode);
				break;
			}
			//xml报文
			String resultXmlString = XmlUtil.generalReceiptXml4NJ(messageType, leafNods);
			//获取返回数据
			String soapResponseData = sendHttpCMD(resultXmlString,messageType,CommonDefine.CMD_TYPE_RECEIPT);
/*			//摘取出返回信息
			soapResponseData = "<NewDataSet>"+
		        "<NJKJ_MESSAGE_APPR_RTN>"+
		            "<EBC_CODE>3215916102</EBC_CODE>"+
		            "<LOGISTICS_NO>G23521506000000261</LOGISTICS_NO>"+
					 "<PRE_NO>P23001150000000006</PRE_NO>"+
					  "<INVT_NO>D23001150000000006</INVT_NO>"+
		            "<CHK_STATUS>3</CHK_STATUS>"+
		            "<CHK_RESULT>审批意见</CHK_RESULT>"+
					"<CHK_TIME>20150723085544 </CHK_TIME>"+
		        "</NJKJ_MESSAGE_APPR_RTN>"+
		        "<NJKJ_MESSAGE_APPR_RTN>"+
		            "<EBC_CODE>3215916102</EBC_CODE>"+
		          "<LOGISTICS_NO>G23521506000000261</LOGISTICS_NO>"+
					 "<PRE_NO>P23001150000000006</PRE_NO>"+
					  "<INVT_NO>D23001150000000006</INVT_NO>"+
		            "<CHK_STATUS>2</CHK_STATUS>"+
					"<CHK_RESULT />"+
					"<CHK_TIME>20150723085544 </CHK_TIME>"+
		        "</NJKJ_MESSAGE_APPR_RTN>"+
		    "</NewDataSet>";*/
			if(soapResponseData == null ||soapResponseData.isEmpty()){
				//抛出错误信息
				throw new CommonException(new Exception(),
						MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, "无回执信息！");
			}
			List<Map<String,String>> response = XmlUtil.parseXmlStringForReceipt(soapResponseData);
			if(response!=null&&response.size()>0){
				//更新商品数据
				//{EBC_CODE=3215916102, G_NO=, CHK_TIME=20150723085544 , ITEM_NO=G23521506000000261, CHK_STATUS=3, CHK_RESULT=审批意见}
				for(Map data:response){
					if(data.get("EBC_CODE")!=null){
						Map inventory = new HashMap();
						inventory.put("RETURN_STATUS", data.get("CHK_STATUS"));
						inventory.put("RETURN_TIME", data.get("CHK_TIME"));
						inventory.put("RETURN_INFO", data.get("CHK_RESULT"));
						inventory.put("INVT_NO", data.get("INVT_NO"));
						inventory.put("GUID", guid);
						//回执状态为3审批通过 更新申报状态 为申报完成
						if (inventory.get("RETURN_STATUS") != null
								&& Integer.valueOf(inventory.get(
										"RETURN_STATUS").toString()) == CommonDefine.RETURN_STATUS_2) {
							inventory.put("APP_STATUS",CommonDefine.APP_STATUS_COMPLETE);
						}
						njCommonManagerMapper.updateInventory_nj(inventory);
					}
				}
			}else{
				//抛出错误信息
				throw new CommonException(new Exception(),
						MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR, soapResponseData);
			}
	}

	//比较旧数据与新数据，筛选出修改过的字段信息
	private Map compareData(Map newData,Map oldData){
		Map result = new HashMap();
		for(Object key:newData.keySet()){
			if(oldData.containsKey(key) && !newData.get(key).equals(oldData.get(key))){
				if(BigDecimal.class.isInstance(oldData.get(key)) || Double.class.isInstance(oldData.get(key))){
					if(Double.valueOf(oldData.get(key).toString()).compareTo(Double.valueOf(newData.get(key).toString())) != 0){
						result.put(key, newData.get(key));
					}
				}else{
					result.put(key, newData.get(key));
				}
			}
		}
		return result;
	}
}
