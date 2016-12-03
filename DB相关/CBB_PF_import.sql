/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/12/3 15:30:52                           */
/*==============================================================*/


DROP TRIGGER IF EXISTS TRIGGER_UPDATE_IMPORT_ORDERNO;

DROP VIEW IF EXISTS V_IMPORT_LOGISTICS;

DROP VIEW IF EXISTS V_IMPORT_ORDERS_UNUSE;

DROP TABLE IF EXISTS T_IMPORT_DELIVERY;

DROP TABLE IF EXISTS T_IMPORT_INVENTORY;

DROP TABLE IF EXISTS T_IMPORT_LOGISTICS;

DROP TABLE IF EXISTS T_IMPORT_ORDERS;

DROP TABLE IF EXISTS T_IMPORT_ORDER_DETAIL;

/*==============================================================*/
/* Table: T_IMPORT_DELIVERY                                     */
/*==============================================================*/
CREATE TABLE T_IMPORT_DELIVERY
(
   DELIVERY_ID          INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   DELIVERY_NO          VARCHAR(30) COMMENT '入库单号',
   TRAF_MODE            VARCHAR(1) COMMENT '运输方式--海关标准的参数代码',
   TRAF_NO              VARCHAR(100) COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
   VOYAGE_NO            VARCHAR(32) COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
   BILL_NO              VARCHAR(37) COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (DELIVERY_ID),
   UNIQUE KEY AK_KEY_2 (DELIVERY_NO)
);

ALTER TABLE T_IMPORT_DELIVERY COMMENT '入库单';

/*==============================================================*/
/* Table: T_IMPORT_INVENTORY                                    */
/*==============================================================*/
CREATE TABLE T_IMPORT_INVENTORY
(
   INVENTORY_ID         INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   RECEIVER_ID          VARCHAR(4) COMMENT '接收海关代码',
   CHK_CUSTOM_CODE      VARCHAR(4) COMMENT '验放海关代码，清单进出境实货放行海关。',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   COP_NO               VARCHAR(20) COMMENT '企业内部编号--企业内部生成标识清单的编号',
   PRE_NO               VARCHAR(18) COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   INVT_NO              VARCHAR(18) COMMENT '清单编号--海关审批生成标识清单的编号',
   PORT_CODE            VARCHAR(4) COMMENT '出口口岸代码--商品实际出我国关境口岸海关的关区代码',
   IE_DATE              DATETIME COMMENT '进出口时间',
   OWNER_CODE           VARCHAR(10) COMMENT '发货人代码--出口发货人填写10位海关企业代码',
   OWNER_NAME           VARCHAR(128) COMMENT '发货人名称',
   TRADE_MODE           VARCHAR(4) COMMENT '贸易方式 默认为9610,预留支持跨境的多种贸易方式',
   LOCT_NO              VARCHAR(10) COMMENT '监管场所代码--针对同一申报地海关下有多个跨境电子商务的监管场所,需要填写区分',
   LICENSE_NO           VARCHAR(19) COMMENT '许可证号--商务主管部门及其授权发证机关签发的进出口货物许可证的编号',
   COUNTRY              VARCHAR(3) COMMENT '运抵国（地区）--出口货物的直接运抵的国家（地区），按海关规定的《国家（地区）代码表》填写代码。',
   GOODS_VALUE          NUMERIC(18,2) COMMENT '商品价格',
   GOODS_CURRENCY       VARCHAR(3) COMMENT '进口清单为人民币',
   TAX_FEE              NUMERIC(18,2) COMMENT '行邮税费',
   DESTINATION_PORT     VARCHAR(5) COMMENT '指运港代码--出口运往境外的最终目的港的标识代码。最终目的港不可预知时，应尽可能按预知的目的港填报',
   FREIGHT              NUMERIC(18,2) COMMENT '订单商品运费--交易包运费则填写"0"',
   FREIGHT_CURR         VARCHAR(3) COMMENT '运费币制--海关标准的参数代码',
   FREIGHT_MARK         INT COMMENT '运费标志--1-率，2-单价，3-总价',
   INSURE_FEE           NUMERIC(18,2) COMMENT '保价费--货物保险费用',
   INSURE_FEE_CURR      VARCHAR(3) COMMENT '保费币制--海关标准的参数代码',
   INSURE_FEE_MARK      INT COMMENT '保费标志--1-率，2-单价，3-总价',
   WRAP_TYPE            VARCHAR(1) COMMENT '包装种类代码--海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
   PACK_NO              INT COMMENT '件数--单个运单下包裹数',
   WEIGHT               NUMERIC(18,5) COMMENT '毛重--单位为千克',
   NET_WEIGHT           NUMERIC(18,5) COMMENT '净重--单位为千克',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   PRIMARY KEY (INVENTORY_ID)
);

ALTER TABLE T_IMPORT_INVENTORY COMMENT '存放出境清单数据';

/*==============================================================*/
/* Table: T_IMPORT_LOGISTICS                                    */
/*==============================================================*/
CREATE TABLE T_IMPORT_LOGISTICS
(
   LOGISTICS_ID         INT NOT NULL AUTO_INCREMENT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   LOGISTICS_CODE       VARCHAR(10) COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
   LOGISTICS_NAME       VARCHAR(128) COMMENT '物流企业的海关备案名称',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   LOGISTICS_STATUS     VARCHAR(1) COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
   FREIGHT              NUMERIC(18,2) COMMENT '订单商品运费--交易包运费则填写"0"',
   INSURE_FEE           NUMERIC(18,2) COMMENT '保价费--货物保险费用',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   WEIGHT               NUMERIC(18,5) COMMENT '毛重--单位为千克',
   NET_WEIGHT           NUMERIC(18,5) COMMENT '净重--单位为千克',
   PACK_NO              INT COMMENT '件数--单个运单下包裹数',
   PARCEL_INFO          VARCHAR(200) COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
   GOODS_INFO           VARCHAR(200) COMMENT '商品信息--物流企业可知的商品信息',
   CONSIGNEE_ID         INT COMMENT '收货人',
   SHIPPER_ID           INT COMMENT '发货人',
   LOGISTICS_HEAD_NO    VARCHAR(20) COMMENT '总运单号',
   DELIVERY_NO          VARCHAR(64) COMMENT '入库单号',
   IS_AUTO              INT DEFAULT 0 COMMENT '是否自动生成 0：不是 1：是',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (LOGISTICS_ID),
   UNIQUE KEY AK_KEY_2 (LOGISTICS_NO)
);

ALTER TABLE T_IMPORT_LOGISTICS COMMENT '运单表存放运单信息';

/*==============================================================*/
/* Table: T_IMPORT_ORDERS                                       */
/*==============================================================*/
CREATE TABLE T_IMPORT_ORDERS
(
   ORDERS_ID            INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-ORDER-YYYYMMDDhhmmss-00001,即系统当前时间加5位流水号',
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 2 COMMENT '业务状态:1-暂存,2-申报,默认为2',
   ORDER_TYPE           INT COMMENT '1、一般进口2、一般出口3、保税进口4、保税出口',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   EBC_CODE             VARCHAR(64) COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
   EBC_NAME             VARCHAR(128) COMMENT '电商企业名称',
   GOODS_VALUE          NUMERIC(18,2) COMMENT '商品价格',
   FREIGHT              NUMERIC(18,2) COMMENT '订单商品运费--交易包运费则填写"0"',
   DISCOUNT             NUMERIC(18,2) COMMENT '非现金抵扣金额',
   TAX_TOTAL            NUMERIC(18,2) COMMENT '代扣税款',
   ACTURAL_PAID         NUMERIC(18,2) COMMENT '实际支付金额',
   BUYER_REG_NO         VARCHAR(64) COMMENT '订购人注册号',
   BUYER_NAME           VARCHAR(64) COMMENT '订购人姓名',
   BUYER_ID_TYPE        INT DEFAULT 1 COMMENT '订购人证件类型',
   BUYER_ID_NUMBER      VARCHAR(64) COMMENT '订购人证件号码',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   TAX_FEE              NUMERIC(18,2) COMMENT '行邮税费',
   CONSIGNEE_ID         INT COMMENT '收货人',
   UNDER_THE_SINGER_ID  INT COMMENT '下单人',
   LOGISTICS_CODE       VARCHAR(10) COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
   LOGISTICS_NAME       VARCHAR(128) COMMENT '物流企业的海关备案名称',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (ORDERS_ID),
   UNIQUE KEY AK_KEY_2 (ORDER_NO)
);

ALTER TABLE T_IMPORT_ORDERS COMMENT '存放电子订单的表头数据';

/*==============================================================*/
/* Table: T_IMPORT_ORDER_DETAIL                                 */
/*==============================================================*/
CREATE TABLE T_IMPORT_ORDER_DETAIL
(
   ORDER_DETAIL_ID      INT NOT NULL AUTO_INCREMENT,
   ORDERS_ID            INT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   GNUM                 INT COMMENT '商品序号--从1开始的递增序号',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   ITEM_NAME            VARCHAR(255) COMMENT '企业商品名称',
   ITEM_DESCRIBE        VARCHAR(1024) COMMENT '企业商品描述',
   ITEM_RECORDNO        VARCHAR(255),
   BARCODE              VARCHAR(64) COMMENT '条形码',
   UNIT                 VARCHAR(3) COMMENT '单位',
   UNIT1                VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT2                VARCHAR(3) COMMENT '海关标准的参数代码',
   G_CODE               VARCHAR(10) COMMENT '海关商品编码--海关标准的参数代码',
   G_NAME               VARCHAR(250) COMMENT '商品名称--同一类商品的中文名称。任何一种具体商品可以并只能归入表中的一个条目',
   G_MODEL              VARCHAR(250) COMMENT '规格型号--商品的规格型号，应尽可能详细，以能满足海关归类、审价以及监管的要求为准。包括：品名、牌名、规格、型号、成份、含量、等级等',
   QTY                  NUMERIC(18,2) COMMENT '成交数量',
   QTY1                 NUMERIC(18,2) COMMENT '成交数量',
   QTY2                 NUMERIC(18,2) COMMENT '成交数量',
   REFOUND_QTY          NUMERIC(18,2),
   PRICE                NUMERIC(18,2) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   TOTAL                NUMERIC(18,2) COMMENT '总价',
   CURRENCY             VARCHAR(3) COMMENT '币制',
   COUNTRY              VARCHAR(3) COMMENT '原产国',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (ORDER_DETAIL_ID)
);

ALTER TABLE T_IMPORT_ORDER_DETAIL COMMENT '存放电子订单的表体数据';

/*==============================================================*/
/* View: V_IMPORT_LOGISTICS                                     */
/*==============================================================*/
CREATE VIEW  V_IMPORT_LOGISTICS
 AS
SELECT 
  L.*,
  O.`EBP_CODE` AS EBP_CODE,
  C.NAME AS CONSIGNEE,
  C.TEL AS CONSIGNEE_TELEPHONE 
FROM
  `T_IMPORT_LOGISTICS` L 
  LEFT JOIN `T_IMPORT_ORDERS` O 
    ON L.`ORDER_NO` = O.`ORDER_NO` 
  LEFT JOIN `T_CONTACT` C 
    ON L.`CONSIGNEE_ID` = C.`CONTACT_ID`;

/*==============================================================*/
/* View: V_IMPORT_ORDERS_UNUSE                                  */
/*==============================================================*/
CREATE VIEW  V_IMPORT_ORDERS_UNUSE
 AS
SELECT 
  O.* 
FROM
  `T_IMPORT_ORDERS` O 
  LEFT JOIN `T_IMPORT_LOGISTICS` L 
    ON O.`ORDER_NO` = L.`ORDER_NO` 
WHERE ISNULL(L.`ORDER_NO`);

ALTER TABLE T_IMPORT_LOGISTICS ADD CONSTRAINT FK_REFERENCE_3 FOREIGN KEY (ORDER_NO)
      REFERENCES T_IMPORT_ORDERS (ORDER_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_IMPORT_ORDER_DETAIL ADD CONSTRAINT FK_REFERENCE_1 FOREIGN KEY (ORDERS_ID)
      REFERENCES T_IMPORT_ORDERS (ORDERS_ID) ON DELETE CASCADE ON UPDATE RESTRICT;


DELIMITER $$

CREATE TRIGGER TRIGGER_UPDATE_IMPORT_ORDERNO AFTER UPDATE
ON T_IMPORT_ORDERS FOR EACH ROW
BEGIN
    UPDATE 
      T_IMPORT_LOGISTICS 
    SET
      T_IMPORT_LOGISTICS.ORDER_NO = NEW.ORDER_NO 
    WHERE NEW.ORDERS_ID = T_IMPORT_LOGISTICS.ORDERS_ID; 
END;
$$

DELIMITER ;

