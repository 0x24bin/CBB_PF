function isPayReadOnly(record){
	return !(record.get("APP_STATUS")==1||	//暂存
			(record.get("RETURN_STATUS")==3));//审批不通过
}

var PayCompleteParam={
//	Pay_STATUS:'("R","C","L","S")',
	RETURN_STATUS:2
};

var ComboBoxValue={
	APP_STATUS:[["暂存","1"],["审批中/申报中","2"],["无需申报","4"],["申报完成","99"]],
	RETURN_STATUS:[["审批通过","2"],["审批不通过","3"]]
};
