package com.foo.manager.commonManager.serviceImpl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foo.IService.ICommonManagerService;
import com.foo.common.CommonDefine;
import com.foo.common.CommonException;
import com.foo.common.MessageCodeDefine;
import com.foo.handler.ExceptionHandler;
import com.foo.manager.commonManager.service.CommonManagerService;
import com.foo.util.CommonUtil;
import com.foo.util.ConfigUtil;
import com.foo.util.FtpUtils;
import com.foo.util.XmlUtil;

@Service
@Transactional(rollbackFor = Exception.class)
public class CommonManagerServiceImpl extends CommonManagerService implements ICommonManagerService{

	@Override
	public List<Map> getSubMenuList(int menuParentId) throws CommonException {

		List<Map> menuList = getSubMenu(menuParentId);

		return menuList;

	}

	/**
	 * @param userId
	 * @param menuParentId
	 * @return
	 */
	private List<Map> getSubMenu(int menuParentId) {

		List<Map> nodes = new ArrayList<Map>();
		// 查询全部菜单项
		List<Map> allMenuList = commonManagerMapper
				.getAllSubMenuList(menuParentId);

		if (allMenuList != null) {
			// 标示符，防止重复
			for (Map obj : allMenuList) {
				obj.put("DISABLED", false);
				// 指定菜单项变灰
				if (obj.get("MENU_HREF") != null
						&& "DISABLED".equals(obj.get("MENU_HREF").toString())) {
					obj.put("DISABLED", true);
				}
				nodes.add(obj);
				if (menuParentId != 0) {
					nodes.addAll(getSubMenu(Integer.parseInt(obj.get(
							"SYS_MENU_ID").toString())));
				}
			}
		}
		return nodes;
	}

	/**
	 * 获取菜单集合--首页显示用
	 * 
	 * @param userId
	 * @param menuId
	 * @return
	 */
	public List<Map> getMenuList(List<Integer> menuIds) throws CommonException {
		// 查询菜单项
		List<Map> menuList = new ArrayList<Map>();
		try {
			// 查询菜单项
			menuList = commonManagerMapper.getMenuList(menuIds);
			if (menuList != null) {
				int pos = 0;
				while (pos < menuList.size()) {
					Map posMenu = menuList.get(pos);
					posMenu.put("DISABLED", false);
					for (int i = 0; i < pos; i++) {
						Map cosMenu = menuList.get(i);
					}
					++pos;
				}
			}
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
		return menuList;
	}

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
			rows = commonManagerMapper.selectTableListByNVList("t_sku", 
					keys,values,start, limit);

			total = commonManagerMapper.selectTableListCountByNVList("t_sku",
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
			commonManagerMapper.delTableById("t_sku", "SKU_ID",
					params.get("SKU_ID"));
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}

	@Override
	public void setSku(Map<String, Object> sku, boolean statusOnly)
			throws CommonException {
		try {
			String tableName="t_sku";
			String uniqueCol="ITEM_NO";
			String primaryCol="SKU_ID";
			// 货号唯一性校验
			uniqueCheck(tableName,uniqueCol,sku.get(uniqueCol),primaryCol,sku.get(primaryCol),false);
			
			sku.remove("editType");

			commonManagerMapper.updateTableByNVList(tableName, primaryCol,
					sku.get(primaryCol), new ArrayList<String>(sku.keySet()),
					new ArrayList<Object>(sku.values()));

			submitXml_SKU(sku);
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
			String tableName="t_sku";
			String uniqueCol="ITEM_NO";
			String primaryCol="SKU_ID";
			// 货号唯一性校验
			uniqueCheck(tableName,uniqueCol,sku.get(uniqueCol),null,null,false);
			
			sku.remove("editType");
			// 设置空id
			sku.put(primaryCol, null);
			// 设置guid
			sku.put("GUID", CommonUtil.generalGuid(CommonDefine.GUID_FOR_SKU,7,tableName));
			// 设置创建时间
			sku.put("CREAT_TIME", new Date());

			Map primary=new HashMap();
			primary.put("primaryId", null);
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(sku.keySet()), 
					new ArrayList<Object>(sku.values()),
					primary);

			submitXml_SKU(sku);
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}

	// 生成xml文件
	public boolean submitXml_SKU(Map<String, Object> data) {
		// 提交需要生成xml文件
		if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
				data.get("APP_STATUS"))) {
			System.out.println("submitXml_SKU");
			
			//更新sku数据，添加申报时间
			//插入申报时间
			String currentTime = new SimpleDateFormat(
					CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
			data.put("APP_TIME", currentTime);
			commonManagerMapper.updateSku(data);
			
			//获取guid
			String guid = data.get("GUID").toString();
			//获取需要生成报文的数据
			data = commonManagerMapper.selectDataForMessage201(guid);

			File file = XmlUtil.generalXml(data, null, CommonDefine.CEB201);

			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();

			String generalXmlFilePath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_SPBA)
					.get("GENERAL_XML").toString();

			boolean result = ftpUtil.uploadFile(file.getPath(),
					generalXmlFilePath, file.getName());

			if (result) {
				file.delete();
			}
			return result;
		}
		return true;
	}
	
	// 生成xml文件
	public boolean submitXml_ORDER(Map<String, Object> data, Integer orderId) {
		// 提交需要生成xml文件,
		if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
				data.get("APP_STATUS"))) {
			System.out.println("submitXml_ORDER");
			
			//更新order数据，添加申报时间
			//插入申报时间
			String currentTime = new SimpleDateFormat(
					CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
			data.put("APP_TIME", currentTime);
			commonManagerMapper.updateOrder(data);

			//获取guid
			String guid = data.get("GUID").toString();
			//获取需要生成报文的数据
			data = commonManagerMapper.selectDataForMessage301(guid);
			
			//获取订单详细信息
			List<Map> subDataList = commonManagerMapper.selectSubDataForMessage301(orderId);

			File file = XmlUtil.generalXml(data, subDataList, CommonDefine.CEB301);

			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();

			String generalXmlFilePath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_DZDD)
					.get("GENERAL_XML").toString();

			boolean result = ftpUtil.uploadFile(file.getPath(),
					generalXmlFilePath, file.getName());

			if (result) {
				file.delete();
			}
			return result;
		}
		return true;
	}
	
	// 生成xml文件
	public boolean submitXml_INVENTORY(Map<String, Object> data, Integer invertoryId) {
		// 提交需要生成xml文件,
		if (Integer.valueOf(CommonDefine.APP_STATUS_UPLOAD).equals(
				data.get("APP_STATUS"))) {
			System.out.println("submitXml_INVENTORY");
			
			//更新数据，添加申报时间
			//插入申报时间
			String currentTime = new SimpleDateFormat(
					CommonDefine.RETRIEVAL_TIME_FORMAT).format(new Date());
			data.put("APP_TIME", currentTime);
			commonManagerMapper.updateInventory(data);

			//获取guid
			String guid = data.get("GUID").toString();
			//获取需要生成报文的数据
			data = commonManagerMapper.selectDataForMessage601(guid);
			
			//获取订单详细信息
			List<Map> subDataList = commonManagerMapper.selectSubDataForMessage601(invertoryId);

			File file = XmlUtil.generalXml(data, subDataList, CommonDefine.CEB601);

			FtpUtils ftpUtil = FtpUtils.getDefaultFtp();

			String generalXmlFilePath = ConfigUtil
					.getFileLocationPath(CommonDefine.FILE_CATEGORY_CJQD)
					.get("GENERAL_XML").toString();

			boolean result = ftpUtil.uploadFile(file.getPath(),
					generalXmlFilePath, file.getName());

			if (result) {
				file.delete();
			}
			return result;
		}
		return true;
	}
	
	@Override
	public void addCodeName(Map data) {
		data.put("CREAT_TIME", new Date());
		Map primary=new HashMap();
		primary.put("primaryId", null);
		commonManagerMapper.insertTableByNVList("t_code_name",
				new ArrayList<String>(data.keySet()), 
				new ArrayList<Object>(data.values()),
				primary);
	}

	@Override
	public void modifyCodeName(List<Map> dataList) {
		// 更新数据
		for (Map data : dataList) {
			commonManagerMapper.updateTableByNVList("t_code_name",
					"CODE_NAME_ID", data.get("CODE_NAME_ID"),
					new ArrayList<String>(data.keySet()),
					new ArrayList<Object>(data.values()));
		}
	}

	@Override
	public boolean checkCodeName(Map data) throws CommonException {
		
		int count  = commonManagerMapper.selectTableListCountByNVList("t_code_name", new ArrayList<String>(data.keySet()),
				new ArrayList<Object>(data.values()));
		
		return !(count>0);
	}

	@Override
	public void setOrder(Map<String, Object> order, boolean statusOnly)
			throws CommonException {
		try {
			String tableName="t_orders";
			String uniqueCol="ORDER_NO";
			String primaryCol="ORDERS_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,order.get(uniqueCol),primaryCol,order.get(primaryCol),false);
			
			order.remove("editType");
			
			Object orderNo = order.get("ORDER_NO");
			List<Map> GOODSList=(List<Map>)order.get("GOODSList");
			order.remove("GOODSList");
			
			commonManagerMapper.updateTableByNVList(tableName, primaryCol,
					order.get(primaryCol), new ArrayList<String>(order.keySet()),
					new ArrayList<Object>(order.values()));

			Object primaryId=order.get(primaryCol);
			setGoodsList(GOODSList,orderNo,primaryId);
			//生成xml报文
			submitXml_ORDER(order,Integer.valueOf(primaryId.toString()));
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	@Override
	public void addOrder(Map<String, Object> order) throws CommonException {
		try {
			String tableName="t_orders";
			String uniqueCol="ORDER_NO";
			String primaryCol="ORDERS_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,order.get(uniqueCol),null,null,false);
			
			order.remove("editType");
			// 设置空id
			order.put(primaryCol, null);
			
			// 设置guid
			order.put("GUID", CommonUtil.generalGuid(CommonDefine.GUID_FOR_ORDER,5,tableName));
			// 设置创建时间
			order.put("CREAT_TIME", new Date());
			
			Object orderNo = order.get("ORDER_NO");
			List<Map> GOODSList=(List<Map>)order.get("GOODSList");
			order.remove("GOODSList");
			
			Map primary=new HashMap();
			primary.put("primaryId", null);
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(order.keySet()), 
					new ArrayList<Object>(order.values()),
					primary);
			
			Object primaryId=primary.get("primaryId");
			setGoodsList(GOODSList,orderNo,primaryId);
			//生成xml报文
			submitXml_ORDER(order,Integer.valueOf(primaryId.toString()));
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	public void setGoodsList(List<Map> GOODSList,Object orderNo, Object ordersId){
		commonManagerMapper.delTableById("t_order_detail", "ORDERS_ID", ordersId);
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
			commonManagerMapper.insertTableByNVList("t_order_detail",
					new ArrayList<String>(good.keySet()), 
					new ArrayList<Object>(good.values()),
					primary);
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
			String tableName = "t_orders";
			if(params.get("IN_USE")!=null){
				if(Boolean.FALSE.equals(params.get("IN_USE"))){
					tableName = "v_orders_unuse";
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
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	public List<Map<String, Object>> getGoodsList(Map<String, Object> order){
		List<Map<String, Object>> goods=commonManagerMapper.selectTableListByCol("t_order_detail", "ORDERS_ID", order.get("ORDERS_ID"), null, null);
		for(Map<String, Object> good:goods){
			good.put("ONE_PRICE", good.get("PRICE"));
			good.remove("PRICE");
			good.put("NOTE_OD", good.get("NOTE"));
			good.remove("NOTE");
			List<Map<String, Object>> skus=commonManagerMapper.selectTableListByCol("t_sku", "ITEM_NO", good.get("ITEM_NO"), 0, 1);
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
	public void delOrder(Map<String, Object> params) throws CommonException {
		try {
			commonManagerMapper.delTableById("t_order_detail", "ORDER_NO",
					params.get("ORDER_NO"));
			commonManagerMapper.delTableById("t_orders", "ORDERS_ID",
					params.get("ORDERS_ID"));
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
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
			String tableName = "t_logistics";
			if(params.get("IN_USE")!=null){
				if(Boolean.FALSE.equals(params.get("IN_USE"))){
					tableName = "v_logistics_unuse";
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
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	public Map<String, Object> getLogisticsOrder(Map<String, Object> logistics){
		Map<String, Object> resultMap=null;
		Object ORDER_NO=logistics.get("ORDER_NO");
		if(ORDER_NO!=null){
			List<Map<String, Object>> orders=commonManagerMapper.selectTableListByCol(
					"t_orders", "ORDER_NO", ORDER_NO, null, null);
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
	public void delLogistics(Map<String, Object> params) throws CommonException {
		try {
			commonManagerMapper.delTableById("t_logistics", "LOGISTICS_ID",
					params.get("LOGISTICS_ID"));
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	@Override
	public void setLogistics(Map<String, Object> logistics, boolean statusOnly)
			throws CommonException {
		try {
			String primaryCol="LOGISTICS_ID";
			String tableName="t_logistics";
			if(statusOnly){
				List<String> keys=Arrays.asList(new String[]{
						"LOGISTICS_STATUS","RETURN_STATUS","RETURN_TIME","RETURN_INFO"});
				List<Object> values=Arrays.asList(new Object[]{
						logistics.get("LOGISTICS_STATUS"),
						null,null,null});
				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						logistics.get(primaryCol), keys, values);
				Object primaryId=logistics.get(primaryCol);
				
				//生成xml报文
				//修改APP_STATUS为upload
				logistics.put("APP_STATUS", CommonDefine.APP_STATUS_UPLOAD);
				submitXml_LOGISTICS(logistics,
						Integer.valueOf(primaryId.toString()),
						CommonDefine.CEB503, CommonDefine.LOGISTICS_TYPE_NORMAL);
			}else{
				String uniqueCol="LOGISTICS_NO";
				// 唯一性校验
				uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),primaryCol,logistics.get(primaryCol),false);
				uniqueCol="ORDER_NO";
				uniqueCheck(tableName,uniqueCol,logistics.get(uniqueCol),primaryCol,logistics.get(primaryCol),false);
				
				logistics.remove("editType");
				
				commonManagerMapper.updateTableByNVList(tableName, primaryCol,
						logistics.get(primaryCol), new ArrayList<String>(logistics.keySet()),
						new ArrayList<Object>(logistics.values()));
	
				Object primaryId=logistics.get(primaryCol);
	
				// 生成xml报文
				submitXml_LOGISTICS(logistics,
						Integer.valueOf(primaryId.toString()),
						CommonDefine.CEB501, CommonDefine.LOGISTICS_TYPE_NORMAL);
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
			String tableName="t_logistics";
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
			logistics.put("GUID", CommonUtil.generalGuid(CommonDefine.GUID_FOR_LOGISTICS,2,tableName));
			// 设置创建时间
			logistics.put("CREAT_TIME", new Date());
			
			Map primary=new HashMap();
			primary.put("primaryId", null);
			commonManagerMapper.insertTableByNVList(tableName,
					new ArrayList<String>(logistics.keySet()), 
					new ArrayList<Object>(logistics.values()),
					primary);
			
			Object primaryId=primary.get("primaryId");

			// 生成xml报文
			submitXml_LOGISTICS(logistics,
					Integer.valueOf(primaryId.toString()), CommonDefine.CEB501,
					CommonDefine.LOGISTICS_TYPE_NORMAL);
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
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
			String tableName = "v_inventory";
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
						"v_inventory_detail", "INVENTORY_ID", row.get("INVENTORY_ID"), null, null));
			}

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
	public void delInventory(Map<String, Object> params) throws CommonException {
		try {
			commonManagerMapper.delTableById("t_inventory_detail", "INVENTORY_ID",
					params.get("INVENTORY_ID"));
			commonManagerMapper.delTableById("t_inventory", "INVENTORY_ID",
					params.get("INVENTORY_ID"));
		} catch (Exception e) {
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	@Override
	public void setInventory(Map<String, Object> inventory, boolean statusOnly)
			throws CommonException {
		try {
			String tableName="t_inventory";
			String uniqueCol="COP_NO";
			String primaryCol="INVENTORY_ID";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),primaryCol,inventory.get(primaryCol),false);
			uniqueCol="LOGISTICS_NO";
			// 唯一性校验
			uniqueCheck(tableName,uniqueCol,inventory.get(uniqueCol),primaryCol,inventory.get(primaryCol),false);
			
			inventory.remove("editType");
			
			List<Map> GOODSList=(List<Map>)inventory.get("GOODSList");
			inventory.remove("GOODSList");
			
			commonManagerMapper.updateTableByNVList(tableName, primaryCol,
					inventory.get(primaryCol), new ArrayList<String>(inventory.keySet()),
					new ArrayList<Object>(inventory.values()));

			Object primaryId=inventory.get(primaryCol);
			setInventoryGoodsList(GOODSList,primaryId,true);
			//生成xml报文
			submitXml_INVENTORY(inventory,Integer.valueOf(primaryId.toString()));
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
			String tableName="t_inventory";
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
			inventory.put("GUID", CommonUtil.generalGuid(CommonDefine.GUID_FOR_INVENTORY,4,tableName));
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
			//生成xml报文
			submitXml_INVENTORY(inventory,Integer.valueOf(primaryId.toString()));
		} catch (CommonException e) {
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			throw new CommonException(e,
					MessageCodeDefine.COM_EXCPT_INTERNAL_ERROR);
		}
	}
	public void setInventoryGoodsList(List<Map> GOODSList,Object inventoryId,boolean isUpdate){

		String tableName="t_inventory_detail";
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
	
	@Override
	public Map<String, Object> getAllFilePath(Map<String, Object> params)
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
			// 查询所有
			rows = commonManagerMapper.selectTable("t_file_location_config", start,
					limit);
			total = commonManagerMapper.selectTableCount("t_file_location_config");
			
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
	
	
	@Override
	public void modifyFilePath(List<Map> dataList) {
		// 更新数据
		for (Map data : dataList) {
			commonManagerMapper.updateTableByNVList("t_file_location_config",
					"FILE_LOCATION_CONFIG_ID", data.get("FILE_LOCATION_CONFIG_ID"),
					new ArrayList<String>(data.keySet()),
					new ArrayList<Object>(data.values()));
		}
	}
	
	
	@Override
	public Map<String, Object> getAllContact(Map<String, Object> params)
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
			// 查询所有
			rows = commonManagerMapper.selectTable("T_CONTACT", start,
					limit);
			total = commonManagerMapper.selectTableCount("T_CONTACT");
			
			for(Map xxx:rows){
				xxx.put("CONTACT_ID", xxx.get("CONTACT_ID").toString());
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
	
	@Override
	public void addContact(Map data) {
		Map primary=new HashMap();
		primary.put("primaryId", null);
		
		String address = data.get("PROVINCE") + "_" + data.get("CITY")
				+ "_" + data.get("DISTRICT") + "_"
				+ data.get("SPECIFIC_ADDRESS");
		data.put("ADDRESS", address);
		
		commonManagerMapper.insertTableByNVList("T_CONTACT",
				new ArrayList<String>(data.keySet()), 
				new ArrayList<Object>(data.values()),
				primary);
	}
	
	@Override
	public void modifyContact(List<Map> dataList) {
		
		for (Map data : dataList) {
			String address = data.get("PROVINCE") + "_" + data.get("CITY")
					+ "_" + data.get("DISTRICT") + "_"
					+ data.get("SPECIFIC_ADDRESS");
			data.put("ADDRESS", address);
		}
		
		// 更新数据
		for (Map data : dataList) {
			commonManagerMapper.updateTableByNVList("T_CONTACT",
					"CONTACT_ID", data.get("CONTACT_ID"),
					new ArrayList<String>(data.keySet()),
					new ArrayList<Object>(data.values()));
		}
	}
	
	@Override
	public void deleteContact(List<Map> dataList) {
		// 更新数据
		for (Map data : dataList) {
			commonManagerMapper.delTableById("T_CONTACT",
					"CONTACT_ID", data.get("CONTACT_ID"));
		}
	}
	
	@Override
	public boolean checkContact(Map data) throws CommonException {
		
		int count  = commonManagerMapper.selectTableListCountByNVList("T_CONTACT", new ArrayList<String>(data.keySet()),
				new ArrayList<Object>(data.values()));
		
		return !(count>0);
	}

}
