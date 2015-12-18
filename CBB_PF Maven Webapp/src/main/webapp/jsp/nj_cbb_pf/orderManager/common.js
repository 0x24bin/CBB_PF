function isOrderReadOnly(record){
	return !(record.get("APP_STATUS")==1||//暂存
			record.get("RETURN_STATUS")==3);//审批不通过
}
var OrderCompleteParam={
	RETURN_STATUS:2	//海关入库
};