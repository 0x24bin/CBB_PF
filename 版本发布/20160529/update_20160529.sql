DROP VIEW IF EXISTS V_NJ_INVENTORY;

/*==============================================================*/
/* View: V_NJ_INVENTORY                                         */
/*==============================================================*/
CREATE VIEW  V_NJ_INVENTORY
 AS
SELECT 
  I.*,
  L.`LOGISTICS_CODE`,
  L.`IE_FLAG`,
  L.`TRAF_MODE`,
  L.`VOYAGE_NO`,
  L.`BILL_NO`,
  L.`TRAF_NAME`,
  -- L.`CUSTOM_CODE`, L.`APP_UID`, 
  O.`ORDER_NO`,
  O.`EBP_CODE`,
  O.`EBC_CODE`,
  O.`AGENT_CODE`,
  CODENAME.`CODE` AS CODE_CODE,
  CODENAME.`NAME` AS CODE_NAME,
  CONTACT.`CODE` AS CONTACT_CODE,
  CONTACT.`NAME` AS CONTACT_NAME 
FROM
  `T_NJ_INVENTORY` I 
  LEFT JOIN `T_NJ_LOGISTICS` L 
    ON L.`LOGISTICS_NO` = I.`LOGISTICS_NO` 
  LEFT JOIN `T_NJ_ORDERS` O 
    ON L.`ORDER_NO` = O.`ORDER_NO` 
  LEFT JOIN `T_CODE_NAME` CODENAME 
    ON L.`LOGISTICS_CODE` = CODENAME.`CODE` AND CODENAME.`RELATION_CATEGORY`="LOGISTICS_CODE"
  LEFT JOIN `T_CONTACT` CONTACT 
    ON L.`CONSIGNEE_ID` = CONTACT.`CONTACT_ID`;
	
	
DROP TABLE IF EXISTS T_NJ_PAY;

/*==============================================================*/
/* Table: T_NJ_PAY                                              */
/*==============================================================*/
CREATE TABLE T_NJ_PAY
(
   PAY_ID               INT NOT NULL AUTO_INCREMENT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '支付企业海关10位数代码',
   RECEIVER_ID          VARCHAR(4) COMMENT '接收海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   PAY_CODE             VARCHAR(10) COMMENT '支付企业代码（10位）',
   PAY_NAME             VARCHAR(255) COMMENT '支付企业名称',
   PAY_TYPE             VARCHAR(1) COMMENT '支付交易类型',
   PAY_NO               VARCHAR(50) COMMENT '支付交易编号--要求唯一',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   PAY_STATUS           VARCHAR(1) COMMENT '支付状态，D-代扣， S-实扣，R-部分退款， C-取消(退款)',
   DRAWEE               VARCHAR(50) COMMENT '支付人姓名',
   DRAWEE_INDENTIFY     VARCHAR(18) COMMENT '付款人的代码。进口支付单信息填支付人的身份证号',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (PAY_ID),
   UNIQUE KEY AK_KEY_2 (PAY_NO)
);

ALTER TABLE T_NJ_PAY COMMENT '支付表';

ALTER TABLE T_NJ_PAY ADD CONSTRAINT FK_REFERENCE_5 FOREIGN KEY (ORDER_NO)
      REFERENCES T_NJ_ORDERS (ORDER_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;


	  
DROP VIEW IF EXISTS V_NJ_ORDERS_UNUSE_PAY;

/*==============================================================*/
/* View: V_NJ_ORDERS_UNUSE_PAY                                  */
/*==============================================================*/
CREATE VIEW  V_NJ_ORDERS_UNUSE_PAY
 AS
SELECT 
  O.* 
FROM
  `T_NJ_ORDERS` O 
  LEFT JOIN `T_NJ_PAY` L 
    ON O.`ORDER_NO` = L.`ORDER_NO` 
WHERE ISNULL(L.`ORDER_NO`);



DROP VIEW IF EXISTS V_NJ_PAY;

/*==============================================================*/
/* View: V_NJ_PAY                                               */
/*==============================================================*/
CREATE VIEW  V_NJ_PAY
 AS
SELECT 
  P.*,
  O.`GOODS_VALUE`,
  O.`TAX_FEE`,
  O.`FREIGHT`,
  O.`CURRENCY`,
  (O.`GOODS_VALUE`+O.`TAX_FEE`+O.`FREIGHT`) AS CHARGE
FROM
  `T_NJ_PAY` P 
  LEFT JOIN `T_NJ_ORDERS` O 
    ON O.`ORDER_NO` = P.`ORDER_NO`;
	
	
insert  into `t_sys_menu`(`SYS_MENU_ID`,`MENU_DISPLAY_NAME`,`MENU_HREF`,`MENU_PARENT_ID`,`IS_LEAF`,`ICON_CLASS`) values (4050000,'支付凭证','../nj_cbb_pf/payManager/PAY.menu',4000000,1,NULL);  