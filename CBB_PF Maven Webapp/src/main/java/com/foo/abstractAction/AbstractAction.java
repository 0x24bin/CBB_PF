package com.foo.abstractAction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;

import com.foo.common.CommonResult;
import com.opensymphony.xwork2.ActionSupport;

@Results( {
		@Result(name = "resultObj", type = "json", params = { "root",
				"resultObj" }),
		@Result(name = "resultArray", type = "json", params = { "root",
				"resultArray" }),
		//导入excel的返回值
		@Result(name = "upload", type = "json", params = { "contentType",
				"text/html", "root", "resultObj" }) })
public abstract class AbstractAction extends ActionSupport{

	/**
	 * 
	 */

	public static final String RESULT_OBJ = "resultObj";
	protected final String RESULT_ARRAY = "resultArray";

	protected final String RESULT_UPLOAD = "upload";

	protected JSONObject resultObj = null;
	protected JSONArray resultArray = null;
	protected int limit;
	protected int start = 0;
	protected String jsonString;
	protected Map<String, Object> params = new HashMap<String, Object>();
	protected CommonResult result = new CommonResult();

	/**
	 * 因为action无法直接接收List<Map>所以添加的转换类
	 * 
	 * @param in
	 * @return
	 */
	protected List<Map> ListStringtoListMap(List<String> in) {
		List<Map> out = new ArrayList<Map>();
		if (in == null)
			return out;
		for (String s : in) {
			if (!"".equals(s)) {
				try {
					Map m = (Map) JSONUtil.deserialize(s);
					out.add(m);
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
		}
		return out;
	}

	public String getText(int errorCode) {
		String aTextName = String.valueOf(errorCode);
		return super.getText(aTextName);
	}

	public JSONObject getResultObj() {
		return resultObj;
	}

	public void setResultObj(JSONObject resultObj) {
		this.resultObj = resultObj;
	}

	public JSONArray getResultArray() {
		return resultArray;
	}

	public void setResultArray(JSONArray resultArray) {
		this.resultArray = resultArray;
	}

	public CommonResult getResult() {
		return result;
	}

	public void setResult(CommonResult result) {
		this.result = result;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
		params.put("limit", limit);
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
		params.put("start", start);
	}

	public String getJsonString() {
		return jsonString;
	}

	public void setJsonString(String jsonString) {
		this.jsonString = jsonString;
	}

}
