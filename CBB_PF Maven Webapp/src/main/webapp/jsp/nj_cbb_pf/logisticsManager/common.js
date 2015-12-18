function isLogisticsReadOnly(record){
	return !(record.get("APP_STATUS")==1||	//暂存
			(Ext.isEmpty(record.get("LOGISTICS_STATUS"))&&
			(record.get("RETURN_STATUS")==3)));//审批不通过
}
function isLogisticsStatusReadOnly(record){
	return !((record.get("RETURN_STATUS")==2&&	//审批通过
			  record.get("LOGISTICS_STATUS")!="S")||
//			 record.get("LOGISTICS_STATUS")=="W"||
			 (!Ext.isEmpty(record.get("LOGISTICS_STATUS"))&&
			  (record.get("RETURN_STATUS")==3)));	//审批不通过
}
var LogisticsCompleteParam={
//	LOGISTICS_STATUS:'("R","C","L","S")',
	RETURN_STATUS:2
};