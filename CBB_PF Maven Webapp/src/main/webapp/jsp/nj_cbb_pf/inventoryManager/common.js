function isInventoryReadOnly(record){
	return !(record.get("APP_STATUS")==1||	//暂存
			record.get("RETURN_STATUS")==3);	//海关退单
}
var InventoryCompleteParam={
	RETURN_STATUS:2 //结关
};
function isInventoryComplete(record){
	if(Ext.isEmpty(record)) return false;
	return (record.get("RETURN_STATUS")==2);	//结关
}