/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2016/5/12 16:44:08                           */
/*==============================================================*/


DROP TRIGGER IF EXISTS TRIGGER_UPDATE_NJ_ORDERNO;

DROP TRIGGER IF EXISTS TRIGGER_UPDATE_ORDERNO;

DROP VIEW IF EXISTS V_INVENTORY;

DROP VIEW IF EXISTS V_INVENTORY_DETAIL;

DROP VIEW IF EXISTS V_LOGISTICS_UNUSE;

DROP VIEW IF EXISTS V_NJ_INVENTORY;

DROP VIEW IF EXISTS V_NJ_INVENTORY_DETAIL;

DROP VIEW IF EXISTS V_NJ_LOGISTICS;

DROP VIEW IF EXISTS V_NJ_LOGISTICS_UNUSE;

DROP VIEW IF EXISTS V_NJ_ORDERS_UNUSE;

DROP VIEW IF EXISTS V_ORDERS_UNUSE;

DROP VIEW IF EXISTS V_USER_ROLE;

DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;

DROP TABLE IF EXISTS QRTZ_CALENDARS;

DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;

DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;

DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;

DROP TABLE IF EXISTS QRTZ_JOB_LISTENERS;

DROP TABLE IF EXISTS QRTZ_LOCKS;

DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;

DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;

DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;

DROP TABLE IF EXISTS QRTZ_TRIGGERS;

DROP TABLE IF EXISTS QRTZ_TRIGGER_LISTENERS;

DROP TABLE IF EXISTS T_CODE_NAME;

DROP TABLE IF EXISTS T_CONTACT;

DROP TABLE IF EXISTS T_FILE_LOCATION_CONFIG;

DROP TABLE IF EXISTS T_GUID_REL;

DROP TABLE IF EXISTS T_INVENTORY;

DROP TABLE IF EXISTS T_INVENTORY_DETAIL;

DROP TABLE IF EXISTS T_LOGISTICS;

DROP TABLE IF EXISTS T_LOGISTICS_SN;

DROP TABLE IF EXISTS T_NJ_INVENTORY;

DROP TABLE IF EXISTS T_NJ_INVENTORY_DETAIL;

DROP TABLE IF EXISTS T_NJ_LOGISTICS;

DROP TABLE IF EXISTS T_NJ_ORDERS;

DROP TABLE IF EXISTS T_NJ_ORDER_DETAIL;

DROP TABLE IF EXISTS T_NJ_SKU;

DROP TABLE IF EXISTS T_ORDERS;

DROP TABLE IF EXISTS T_ORDER_DETAIL;

DROP TABLE IF EXISTS T_SKU;

DROP TABLE IF EXISTS T_SYS_MENU;

DROP TABLE IF EXISTS T_SYS_ROLE;

DROP TABLE IF EXISTS T_SYS_ROLE_REF;

DROP TABLE IF EXISTS T_SYS_USER;

DROP TABLE IF EXISTS T_SYS_USER_REF_ROLE;

/*==============================================================*/
/* Table: QRTZ_BLOB_TRIGGERS                                    */
/*==============================================================*/
CREATE TABLE QRTZ_BLOB_TRIGGERS
(
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   BLOB_DATA            BLOB,
   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_CALENDARS                                        */
/*==============================================================*/
CREATE TABLE QRTZ_CALENDARS
(
   CALENDAR_NAME        VARCHAR(200) NOT NULL,
   CALENDAR             BLOB NOT NULL,
   PRIMARY KEY (CALENDAR_NAME)
);

/*==============================================================*/
/* Table: QRTZ_CRON_TRIGGERS                                    */
/*==============================================================*/
CREATE TABLE QRTZ_CRON_TRIGGERS
(
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   CRON_EXPRESSION      VARCHAR(200) NOT NULL,
   TIME_ZONE_ID         VARCHAR(80),
   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_FIRED_TRIGGERS                                   */
/*==============================================================*/
CREATE TABLE QRTZ_FIRED_TRIGGERS
(
   ENTRY_ID             VARCHAR(95) NOT NULL,
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   IS_VOLATILE          VARCHAR(1) NOT NULL,
   INSTANCE_NAME        VARCHAR(200) NOT NULL,
   FIRED_TIME           BIGINT(13) NOT NULL,
   PRIORITY             INT(11) NOT NULL,
   STATE                VARCHAR(16) NOT NULL,
   JOB_NAME             VARCHAR(200),
   JOB_GROUP            VARCHAR(200),
   IS_STATEFUL          VARCHAR(1),
   REQUESTS_RECOVERY    VARCHAR(1),
   PRIMARY KEY (ENTRY_ID)
);

/*==============================================================*/
/* Table: QRTZ_JOB_DETAILS                                      */
/*==============================================================*/
CREATE TABLE QRTZ_JOB_DETAILS
(
   JOB_NAME             VARCHAR(200) NOT NULL,
   JOB_GROUP            VARCHAR(200) NOT NULL,
   DESCRIPTION          VARCHAR(250),
   JOB_CLASS_NAME       VARCHAR(250) NOT NULL,
   IS_DURABLE           VARCHAR(1) NOT NULL,
   IS_VOLATILE          VARCHAR(1) NOT NULL,
   IS_STATEFUL          VARCHAR(1) NOT NULL,
   REQUESTS_RECOVERY    VARCHAR(1) NOT NULL,
   JOB_DATA             BLOB,
   PRIMARY KEY (JOB_NAME, JOB_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_JOB_LISTENERS                                    */
/*==============================================================*/
CREATE TABLE QRTZ_JOB_LISTENERS
(
   JOB_NAME             VARCHAR(200) NOT NULL,
   JOB_GROUP            VARCHAR(200) NOT NULL,
   JOB_LISTENER         VARCHAR(200) NOT NULL,
   PRIMARY KEY (JOB_LISTENER, JOB_NAME, JOB_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_LOCKS                                            */
/*==============================================================*/
CREATE TABLE QRTZ_LOCKS
(
   LOCK_NAME            VARCHAR(40) NOT NULL,
   PRIMARY KEY (LOCK_NAME)
);

/*==============================================================*/
/* Table: QRTZ_PAUSED_TRIGGER_GRPS                              */
/*==============================================================*/
CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
(
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   PRIMARY KEY (TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_SCHEDULER_STATE                                  */
/*==============================================================*/
CREATE TABLE QRTZ_SCHEDULER_STATE
(
   INSTANCE_NAME        VARCHAR(200) NOT NULL,
   LAST_CHECKIN_TIME    BIGINT(13) NOT NULL,
   CHECKIN_INTERVAL     BIGINT(13) NOT NULL,
   PRIMARY KEY (INSTANCE_NAME)
);

/*==============================================================*/
/* Table: QRTZ_SIMPLE_TRIGGERS                                  */
/*==============================================================*/
CREATE TABLE QRTZ_SIMPLE_TRIGGERS
(
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   REPEAT_COUNT         BIGINT(7) NOT NULL,
   REPEAT_INTERVAL      BIGINT(12) NOT NULL,
   TIMES_TRIGGERED      BIGINT(10) NOT NULL,
   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_TRIGGERS                                         */
/*==============================================================*/
CREATE TABLE QRTZ_TRIGGERS
(
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   JOB_NAME             VARCHAR(200) NOT NULL,
   JOB_GROUP            VARCHAR(200) NOT NULL,
   IS_VOLATILE          VARCHAR(1) NOT NULL,
   DESCRIPTION          VARCHAR(250),
   NEXT_FIRE_TIME       BIGINT(13),
   PREV_FIRE_TIME       BIGINT(13),
   PRIORITY             INT(11),
   TRIGGER_STATE        VARCHAR(16) NOT NULL,
   TRIGGER_TYPE         VARCHAR(8) NOT NULL,
   START_TIME           BIGINT(13) NOT NULL,
   END_TIME             BIGINT(13),
   CALENDAR_NAME        VARCHAR(200),
   MISFIRE_INSTR        SMALLINT(2),
   JOB_DATA             BLOB,
   PRIMARY KEY (TRIGGER_NAME, TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: QRTZ_TRIGGER_LISTENERS                                */
/*==============================================================*/
CREATE TABLE QRTZ_TRIGGER_LISTENERS
(
   TRIGGER_NAME         VARCHAR(200) NOT NULL,
   TRIGGER_GROUP        VARCHAR(200) NOT NULL,
   TRIGGER_LISTENER     VARCHAR(200) NOT NULL,
   PRIMARY KEY (TRIGGER_LISTENER, TRIGGER_NAME, TRIGGER_GROUP)
);

/*==============================================================*/
/* Table: T_CODE_NAME                                           */
/*==============================================================*/
CREATE TABLE T_CODE_NAME
(
   CODE_NAME_ID         INT NOT NULL AUTO_INCREMENT,
   RELATION_CATEGORY    VARCHAR(64) COMMENT '关联类别',
   RELATION_NAME        VARCHAR(128) COMMENT '关联说明',
   CODE                 VARCHAR(64) COMMENT '代号',
   SN_CODE              VARCHAR(64) COMMENT '苏宁代号',
   NAME                 VARCHAR(128) COMMENT '名称',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (CODE_NAME_ID),
   UNIQUE KEY AK_KEY_2 (RELATION_CATEGORY, RELATION_NAME, CODE)
);

ALTER TABLE T_CODE_NAME COMMENT '报文中代码与名称之间关系';

/*==============================================================*/
/* Table: T_CONTACT                                             */
/*==============================================================*/
CREATE TABLE T_CONTACT
(
   CONTACT_ID           INT NOT NULL AUTO_INCREMENT,
   CODE                 VARCHAR(50) NOT NULL,
   NAME                 VARCHAR(200),
   TEL                  VARCHAR(50),
   COUNTRY              VARCHAR(50),
   ADDRESS              TEXT COMMENT 'PROVINCE+CITY+DISTRICT+SPECIFIC_ADDRESS组合',
   PROVINCE             VARCHAR(50),
   CITY                 VARCHAR(50),
   DISTRICT             VARCHAR(50),
   SPECIFIC_ADDRESS     VARCHAR(200),
   PRIMARY KEY (CONTACT_ID)
);

ALTER TABLE T_CONTACT COMMENT '联系人表';

/*==============================================================*/
/* Table: T_FILE_LOCATION_CONFIG                                */
/*==============================================================*/
CREATE TABLE T_FILE_LOCATION_CONFIG
(
   FILE_LOCATION_CONFIG_ID INT NOT NULL AUTO_INCREMENT,
   CATEGORY             INT DEFAULT 1 COMMENT '1.商品备案数据 2.电子订单 3.支付凭证 4.物流运单 5.物流运单状态 6.出境清单',
   GENERAL_XML          VARCHAR(128) DEFAULT 'general' COMMENT '生成xml地址',
   RECEIPT_XML          VARCHAR(128) DEFAULT 'receipt' COMMENT '回执xml地址',
   TRANSFER_XML         VARCHAR(128) DEFAULT 'transfer' COMMENT '阅读xml回执后转移地址',
   INPUT_XML            VARCHAR(128) DEFAULT 'input' COMMENT '电子订单获取源数据地址',
   PRIMARY KEY (FILE_LOCATION_CONFIG_ID),
   UNIQUE KEY AK_KEY_2 (CATEGORY)
);

ALTER TABLE T_FILE_LOCATION_CONFIG COMMENT '生成xml，回执xml，回执读取后xml，文件地址配置';

/*==============================================================*/
/* Table: T_GUID_REL                                            */
/*==============================================================*/
CREATE TABLE T_GUID_REL
(
   GUID_REL_ID          INT NOT NULL AUTO_INCREMENT,
   GUIDS                VARCHAR(50) COMMENT '本平台GUID',
   GUIDC                VARCHAR(50) COMMENT '海关平台GUID',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (GUID_REL_ID),
   UNIQUE KEY AK_KEY_2 (GUIDS),
   UNIQUE KEY AK_KEY_3 (GUIDC)
);

ALTER TABLE T_GUID_REL COMMENT '存放本平台中guid与海关平台guid之间对应关系';

/*==============================================================*/
/* Table: T_INVENTORY                                           */
/*==============================================================*/
CREATE TABLE T_INVENTORY
(
   INVENTORY_ID         INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
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
   DESTINATION_PORT     VARCHAR(4) COMMENT '指运港代码--出口运往境外的最终目的港的标识代码。最终目的港不可预知时，应尽可能按预知的目的港填报',
   FREIGHT              NUMERIC(19,5) COMMENT '订单商品运费--交易包运费则填写"0"',
   FREIGHT_CURR         VARCHAR(3) COMMENT '运费币制--海关标准的参数代码',
   FREIGHT_MARK         INT COMMENT '运费标志--1-率，2-单价，3-总价',
   INSURE_FEE           NUMERIC(19,5) COMMENT '保价费--货物保险费用',
   INSURE_FEE_CURR      VARCHAR(3) COMMENT '保费币制--海关标准的参数代码',
   INSURE_FEE_MARK      INT COMMENT '保费标志--1-率，2-单价，3-总价',
   WRAP_TYPE            VARCHAR(1) COMMENT '包装种类代码--海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
   PACK_NO              INT COMMENT '件数--单个运单下包裹数',
   WEIGHT               NUMERIC(19,5) COMMENT '毛重--单位为千克',
   NET_WEIGHT           NUMERIC(19,5) COMMENT '净重--单位为千克',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (INVENTORY_ID)
);

ALTER TABLE T_INVENTORY COMMENT '存放出境清单数据';

/*==============================================================*/
/* Table: T_INVENTORY_DETAIL                                    */
/*==============================================================*/
CREATE TABLE T_INVENTORY_DETAIL
(
   INVENTORY_DETAIL_ID  INT NOT NULL AUTO_INCREMENT,
   INVENTORY_ID         INT,
   GNUM                 INT COMMENT '商品序号--从1开始的递增序号',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   QTY                  NUMERIC(19,5) COMMENT '成交数量',
   QTY1                 NUMERIC(19,5) COMMENT '成交数量',
   QTY2                 NUMERIC(19,5) COMMENT '成交数量',
   UNIT                 VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT1                VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT2                VARCHAR(3) COMMENT '海关标准的参数代码',
   PRICE                NUMERIC(19,5) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   TOTAL                NUMERIC(19,5) COMMENT '总价',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (INVENTORY_DETAIL_ID)
);

/*==============================================================*/
/* Table: T_LOGISTICS                                           */
/*==============================================================*/
CREATE TABLE T_LOGISTICS
(
   LOGISTICS_ID         INT NOT NULL AUTO_INCREMENT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   LOGISTICS_CODE       VARCHAR(10) COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
   LOGISTICS_NAME       VARCHAR(128) COMMENT '物流企业的海关备案名称',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   LOGISTICS_STATUS     VARCHAR(1) COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
   IE_FLAG              VARCHAR(1) COMMENT '进出口标记--I进口/E出口',
   TRAF_MODE            VARCHAR(1) COMMENT '运输方式--海关标准的参数代码',
   SHIP_NAME            VARCHAR(100) COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
   VOYAGE_NO            VARCHAR(32) COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
   BILL_NO              VARCHAR(37) COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
   FREIGHT              NUMERIC(19,5) COMMENT '订单商品运费--交易包运费则填写"0"',
   INSURE_FEE           NUMERIC(19,5) COMMENT '保价费--货物保险费用',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   WEIGHT               NUMERIC(19,5) COMMENT '毛重--单位为千克',
   NET_WEIGHT           NUMERIC(19,5) COMMENT '净重--单位为千克',
   PACK_NO              INT COMMENT '件数--单个运单下包裹数',
   PARCEL_INFO          VARCHAR(200) COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
   GOODS_INFO           VARCHAR(200) COMMENT '商品信息--物流企业可知的商品信息',
   CONSIGNEE            VARCHAR(100) COMMENT '收货人名称',
   CONSIGNEE_ADDRESS    VARCHAR(512) COMMENT '收货人地址',
   CONSIGNEE_TELEPHONE  VARCHAR(50) COMMENT '收货人电话',
   CONSIGNEE_COUNTRY    VARCHAR(3) COMMENT '收货人所在国--海关标准的参数代码',
   SHIPPER              VARCHAR(100) COMMENT '发货人名称',
   SHIPPER_ADDRESS      VARCHAR(200) COMMENT '发货人地址',
   SHIPPER_TELEPHONE    VARCHAR(50) COMMENT '发货人电话',
   SHIPPER_COUNTRY      VARCHAR(3) COMMENT '发货人所在国--海关标准的参数代码',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (LOGISTICS_ID),
   UNIQUE KEY AK_KEY_2 (LOGISTICS_NO)
);

ALTER TABLE T_LOGISTICS COMMENT '运单表存放运单信息';

/*==============================================================*/
/* Table: T_LOGISTICS_SN                                        */
/*==============================================================*/
CREATE TABLE T_LOGISTICS_SN
(
   LOGISTICS_ID         INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '企业系统生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SUNING-YYYYMMDDhhmmss-0001,即系统当前时间加4位流水号',
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   LOGISTICS_ORDER_ID   VARCHAR(128),
   LOGISTICS_CODE       VARCHAR(10) COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
   LOGISTICS_NAME       VARCHAR(128) COMMENT '物流企业的海关备案名称',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   LOGISTICS_STATUS     VARCHAR(1) COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
   IE_FLAG              VARCHAR(1) COMMENT '进出口标记--I进口/E出口',
   TRAF_MODE            VARCHAR(1) COMMENT '运输方式--海关标准的参数代码',
   SHIP_NAME            VARCHAR(100) COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
   VOYAGE_NO            VARCHAR(32) COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
   BILL_NO              VARCHAR(37) COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
   FREIGHT              NUMERIC(19,5) COMMENT '订单商品运费--交易包运费则填写"0"',
   INSURE_FEE           NUMERIC(19,5) COMMENT '保价费--货物保险费用',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   WEIGHT               NUMERIC(19,5) COMMENT '毛重--单位为千克',
   NET_WEIGHT           NUMERIC(19,5) COMMENT '净重--单位为千克',
   PACK_NO              INT COMMENT '件数--单个运单下包裹数',
   PARCEL_INFO          VARCHAR(200) COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
   GOODS_INFO           VARCHAR(200) COMMENT '商品信息--物流企业可知的商品信息',
   CONSIGNEE            VARCHAR(100) COMMENT '收货人名称',
   CONSIGNEE_ADDRESS    VARCHAR(512) COMMENT '收货人地址',
   CONSIGNEE_TELEPHONE  VARCHAR(50) COMMENT '收货人电话',
   CONSIGNEE_COUNTRY    VARCHAR(3) COMMENT '收货人所在国--海关标准的参数代码',
   SHIPPER              VARCHAR(100) COMMENT '发货人名称',
   SHIPPER_ADDRESS      VARCHAR(200) COMMENT '发货人地址',
   SHIPPER_TELEPHONE    VARCHAR(50) COMMENT '发货人电话',
   SHIPPER_COUNTRY      VARCHAR(3) COMMENT '发货人所在国--海关标准的参数代码',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (LOGISTICS_ID),
   UNIQUE KEY AK_KEY_2 (LOGISTICS_NO),
   KEY AK_KEY_3 (ORDER_NO)
);

ALTER TABLE T_LOGISTICS_SN COMMENT '运单表存放运单信息';

/*==============================================================*/
/* Table: T_NJ_INVENTORY                                        */
/*==============================================================*/
CREATE TABLE T_NJ_INVENTORY
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

ALTER TABLE T_NJ_INVENTORY COMMENT '存放出境清单数据';

/*==============================================================*/
/* Table: T_NJ_INVENTORY_DETAIL                                 */
/*==============================================================*/
CREATE TABLE T_NJ_INVENTORY_DETAIL
(
   INVENTORY_DETAIL_ID  INT NOT NULL AUTO_INCREMENT,
   INVENTORY_ID         INT,
   GNUM                 INT COMMENT '商品序号--从1开始的递增序号',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   QTY                  NUMERIC(18,2) COMMENT '成交数量',
   QTY1                 NUMERIC(18,2) COMMENT '成交数量',
   QTY2                 NUMERIC(18,2) COMMENT '成交数量',
   UNIT                 VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT1                VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT2                VARCHAR(3) COMMENT '海关标准的参数代码',
   PRICE                NUMERIC(18,2) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   TOTAL                NUMERIC(18,2) COMMENT '总价',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (INVENTORY_DETAIL_ID)
);

/*==============================================================*/
/* Table: T_NJ_LOGISTICS                                        */
/*==============================================================*/
CREATE TABLE T_NJ_LOGISTICS
(
   LOGISTICS_ID         INT NOT NULL AUTO_INCREMENT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   RECEIVER_ID          VARCHAR(4) COMMENT '接收海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   LOGISTICS_CODE       VARCHAR(10) COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
   LOGISTICS_NAME       VARCHAR(128) COMMENT '物流企业的海关备案名称',
   LOGISTICS_NO         VARCHAR(20) COMMENT '物流运单编号--物流企业的运单包裹面单号',
   LOGISTICS_STATUS     VARCHAR(1) COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
   IE_FLAG              VARCHAR(1) COMMENT '进出口标记--I进口/E出口',
   TRAF_MODE            VARCHAR(1) COMMENT '运输方式--海关标准的参数代码',
   TRAF_NAME            VARCHAR(100) COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
   VOYAGE_NO            VARCHAR(32) COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
   BILL_NO              VARCHAR(37) COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
   MAIN_BILL_NO         VARCHAR(50) COMMENT '总运单号',
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

ALTER TABLE T_NJ_LOGISTICS COMMENT '运单表存放运单信息';

/*==============================================================*/
/* Table: T_NJ_ORDERS                                           */
/*==============================================================*/
CREATE TABLE T_NJ_ORDERS
(
   ORDERS_ID            INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-ORDER-YYYYMMDDhhmmss-00001,即系统当前时间加5位流水号',
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   RECEIVER_ID          VARCHAR(4) COMMENT '接收海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 2 COMMENT '业务状态:1-暂存,2-申报,默认为2',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   ORDER_TYPE           INT COMMENT '1、一般进口2、一般出口3、保税进口4、保税出口',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   EBC_CODE             VARCHAR(64) COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
   EBC_NAME             VARCHAR(128) COMMENT '电商企业名称',
   AGENT_CODE           VARCHAR(64) COMMENT '申报企业代码',
   AGENT_NAME           VARCHAR(128) COMMENT '申报企业名称',
   GOODS_VALUE          NUMERIC(18,2) COMMENT '商品价格',
   FREIGHT              NUMERIC(18,2) COMMENT '订单商品运费--交易包运费则填写"0"',
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

ALTER TABLE T_NJ_ORDERS COMMENT '存放电子订单的表头数据';

/*==============================================================*/
/* Table: T_NJ_ORDER_DETAIL                                     */
/*==============================================================*/
CREATE TABLE T_NJ_ORDER_DETAIL
(
   ORDER_DETAIL_ID      INT NOT NULL AUTO_INCREMENT,
   ORDERS_ID            INT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   GNUM                 INT COMMENT '商品序号--从1开始的递增序号',
   QTY                  NUMERIC(18,2) COMMENT '成交数量',
   PRICE                NUMERIC(18,2) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   TOTAL                NUMERIC(18,2) COMMENT '总价',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (ORDER_DETAIL_ID)
);

ALTER TABLE T_NJ_ORDER_DETAIL COMMENT '存放电子订单的表体数据';

/*==============================================================*/
/* Table: T_NJ_SKU                                              */
/*==============================================================*/
CREATE TABLE T_NJ_SKU
(
   SKU_ID               INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT 'CEB_企业海关10位数编码_主管海关4位编码_19位时间戳[YYYYMMDDHHMISSFFFFF],
            例如CEB_201_1113240359_2301_2015010116301223134',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   RECEIVER_ID          VARCHAR(4) COMMENT '接收海关代码',
   BIZ_TYPE             INT COMMENT '业务类型',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   PRE_NO               VARCHAR(50) COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   EBC_CODE             VARCHAR(64) COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
   EBC_NAME             VARCHAR(128) COMMENT '电商企业名称',
   AGENT_CODE           VARCHAR(64) COMMENT '申报企业代码',
   AGENT_NAME           VARCHAR(128) COMMENT '申报企业名称',
   CLASSIFY_CODE        VARCHAR(64) COMMENT '预归类企业代码',
   CLASSIFY_NAME        VARCHAR(128) COMMENT '预归类企业名称',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   ITEM_NAME            VARCHAR(250) COMMENT '商品上架品名--电商平台标识商品的名称',
   G_NO                 VARCHAR(20) COMMENT '海关商品备案编号--海关审核生成标识商品备案数据的编号(4位年+2位月+4位关区+8位流水号)',
   G_CODE               VARCHAR(10) COMMENT '海关商品编码--海关标准的参数代码',
   G_NAME               VARCHAR(250) COMMENT '商品名称--同一类商品的中文名称。任何一种具体商品可以并只能归入表中的一个条目',
   G_MODEL              VARCHAR(250) COMMENT '规格型号--商品的规格型号，应尽可能详细，以能满足海关归类、审价以及监管的要求为准。包括：品名、牌名、规格、型号、成份、含量、等级等',
   BAR_CODE             VARCHAR(13) COMMENT '条形码--商品条形码一般由前缀部分、制造厂商代码、商品代码和校验码组成。没有条形码填“无”',
   BRAND                VARCHAR(100) COMMENT '品牌--没有填“无”',
   TAX_CODE             VARCHAR(8) COMMENT '海关标准的参数代码',
   TAX_RATE             NUMERIC(19,5) COMMENT '行邮税率',
   UNIT                 VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT1                VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT2                VARCHAR(3) COMMENT '海关标准的参数代码',
   PRICE                NUMERIC(18,2) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   COUNTRY              VARCHAR(3) COMMENT '原产国',
   GIFT_FLAG            INT COMMENT '是否赠品:0-否，1-是',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '版本号',
   RETURN_STATUS        INT COMMENT '2：审批通过 3：审批不通过
            ',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (SKU_ID),
   UNIQUE KEY AK_KEY_2 (ITEM_NO, BIZ_TYPE)
);

ALTER TABLE T_NJ_SKU COMMENT '存放商品信息';

/*==============================================================*/
/* Table: T_ORDERS                                              */
/*==============================================================*/
CREATE TABLE T_ORDERS
(
   ORDERS_ID            INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-ORDER-YYYYMMDDhhmmss-00001,即系统当前时间加5位流水号',
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 2 COMMENT '业务状态:1-暂存,2-申报,默认为2',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   ORDER_TYPE           VARCHAR(1) COMMENT '电商平台的订单类型 I进口/E出口',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   EBC_CODE             VARCHAR(64) COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
   EBC_NAME             VARCHAR(128) COMMENT '电商企业名称',
   AGENT_CODE           VARCHAR(64) COMMENT '申报企业代码',
   AGENT_NAME           VARCHAR(128) COMMENT '申报企业名称',
   GOODS_VALUE          NUMERIC(19,5) COMMENT '商品价格',
   FREIGHT              NUMERIC(19,5) COMMENT '订单商品运费--交易包运费则填写"0"',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   CONSIGNEE            VARCHAR(100) COMMENT '收货人名称',
   CONSIGNEE_ADDRESS    VARCHAR(512) COMMENT '收货人地址',
   CONSIGNEE_TELEPHONE  VARCHAR(50) COMMENT '收货人电话',
   CONSIGNEE_COUNTRY    VARCHAR(3) COMMENT '收货人所在国--海关标准的参数代码',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (ORDERS_ID),
   UNIQUE KEY AK_KEY_2 (ORDER_NO)
);

ALTER TABLE T_ORDERS COMMENT '存放电子订单的表头数据';

/*==============================================================*/
/* Table: T_ORDER_DETAIL                                        */
/*==============================================================*/
CREATE TABLE T_ORDER_DETAIL
(
   ORDER_DETAIL_ID      INT NOT NULL AUTO_INCREMENT,
   ORDERS_ID            INT,
   ORDER_NO             VARCHAR(30) COMMENT '订单编号--电商平台的原始订单编号，格式',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   GNUM                 INT COMMENT '商品序号--从1开始的递增序号',
   QTY                  NUMERIC(19,5) COMMENT '成交数量',
   PRICE                NUMERIC(19,5) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   TOTAL                NUMERIC(19,5) COMMENT '总价',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (ORDER_DETAIL_ID)
);

ALTER TABLE T_ORDER_DETAIL COMMENT '存放电子订单的表体数据';

/*==============================================================*/
/* Table: T_SKU                                                 */
/*==============================================================*/
CREATE TABLE T_SKU
(
   SKU_ID               INT NOT NULL AUTO_INCREMENT,
   GUID                 VARCHAR(64) COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
   CUSTOM_CODE          VARCHAR(4) COMMENT '办理商品备案手续的4位海关代码',
   APP_TYPE             INT DEFAULT 1 COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
   APP_TIME             VARCHAR(64) COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
   APP_STATUS           INT DEFAULT 1 COMMENT '业务状态:1-暂存,2-申报,默认为1',
   APP_UID              VARCHAR(64) COMMENT '电子口岸持卡人IC卡或IKEY编号',
   APP_UNAME            VARCHAR(128) COMMENT '电子口岸持卡人姓名',
   PRE_NO               VARCHAR(18) COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
   EBP_CODE             VARCHAR(64) COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
   EBP_NAME             VARCHAR(128) COMMENT '电商平台名称',
   EBC_CODE             VARCHAR(64) COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
   EBC_NAME             VARCHAR(128) COMMENT '电商企业名称',
   AGENT_CODE           VARCHAR(64) COMMENT '申报企业代码',
   AGENT_NAME           VARCHAR(128) COMMENT '申报企业名称',
   CLASSIFY_CODE        VARCHAR(64) COMMENT '预归类企业代码',
   CLASSIFY_NAME        VARCHAR(128) COMMENT '预归类企业名称',
   ITEM_NO              VARCHAR(20) COMMENT '企业商品货号--电商平台标识商品的货号',
   ITEM_NAME            VARCHAR(250) COMMENT '商品上架品名--电商平台标识商品的名称',
   G_NO                 VARCHAR(18) COMMENT '海关商品备案编号--海关审核生成标识商品备案数据的编号(4位年+2位月+4位关区+8位流水号)',
   G_CODE               VARCHAR(10) COMMENT '海关商品编码--海关标准的参数代码',
   G_NAME               VARCHAR(250) COMMENT '商品名称--同一类商品的中文名称。任何一种具体商品可以并只能归入表中的一个条目',
   G_MODEL              VARCHAR(250) COMMENT '规格型号--商品的规格型号，应尽可能详细，以能满足海关归类、审价以及监管的要求为准。包括：品名、牌名、规格、型号、成份、含量、等级等',
   BAR_CODE             VARCHAR(13) COMMENT '条形码--商品条形码一般由前缀部分、制造厂商代码、商品代码和校验码组成。没有条形码填“无”',
   BRAND                VARCHAR(100) COMMENT '品牌--没有填“无”',
   TAX_CODE             VARCHAR(8) COMMENT '海关标准的参数代码',
   UNIT                 VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT1                VARCHAR(3) COMMENT '海关标准的参数代码',
   UNIT2                VARCHAR(3) COMMENT '海关标准的参数代码',
   PRICE                NUMERIC(19,5) COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
   CURRENCY             VARCHAR(3) COMMENT '海关标准的参数代码--币制',
   GIFT_FLAG            INT COMMENT '是否赠品:0-否，1-是',
   NOTE                 VARCHAR(1000) COMMENT '备注',
   RETURN_STATUS        INT COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
   RETURN_TIME          VARCHAR(64) COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '回执信息--备注（如:退单原因）',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (SKU_ID),
   UNIQUE KEY AK_KEY_2 (ITEM_NO)
);

ALTER TABLE T_SKU COMMENT '存放商品信息';

/*==============================================================*/
/* Table: T_SYS_MENU                                            */
/*==============================================================*/
CREATE TABLE T_SYS_MENU
(
   SYS_MENU_ID          INT NOT NULL COMMENT 'id',
   MENU_DISPLAY_NAME    VARCHAR(128) COMMENT '菜单名称',
   MENU_HREF            VARCHAR(128) COMMENT '链接',
   MENU_PARENT_ID       INT COMMENT '父节点Id',
   IS_LEAF              INT COMMENT '是否叶子节点 0：不是 1：是',
   ICON_CLASS           VARCHAR(32) COMMENT '图标css样式',
   PRIMARY KEY (SYS_MENU_ID)
);

ALTER TABLE T_SYS_MENU COMMENT '菜单表';

/*==============================================================*/
/* Table: T_SYS_ROLE                                            */
/*==============================================================*/
CREATE TABLE T_SYS_ROLE
(
   SYS_ROLE_ID          INT NOT NULL AUTO_INCREMENT,
   NAME                 VARCHAR(128) COMMENT '角色名',
   NOTE                 VARCHAR(128) COMMENT '备注',
   IS_DEL               INT DEFAULT 0 COMMENT '是否删除 0：不是 1：是',
   CREATE_TIME          DATETIME COMMENT '创建时间',
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (SYS_ROLE_ID)
);

ALTER TABLE T_SYS_ROLE COMMENT '角色表';

/*==============================================================*/
/* Table: T_SYS_ROLE_REF                                        */
/*==============================================================*/
CREATE TABLE T_SYS_ROLE_REF
(
   SYS_ROLE_REF_ID      INT NOT NULL AUTO_INCREMENT,
   SYS_ROLE_ID          INT,
   SYS_MENU_ID          INT COMMENT 'id',
   PRIMARY KEY (SYS_ROLE_REF_ID)
);

ALTER TABLE T_SYS_ROLE_REF COMMENT '角色与菜单关联表';

/*==============================================================*/
/* Table: T_SYS_USER                                            */
/*==============================================================*/
CREATE TABLE T_SYS_USER
(
   SYS_USER_ID          INT NOT NULL AUTO_INCREMENT,
   USER_NAME            VARCHAR(64) COMMENT '姓名',
   LOGIN_NAME           VARCHAR(128) COMMENT '登录名',
   PASSWORD             VARCHAR(64) COMMENT '密码',
   JOB_NUMBER           VARCHAR(64) COMMENT '工号',
   DEPARTMENT           VARCHAR(64) COMMENT '部门',
   POSITION             VARCHAR(64) COMMENT '职务',
   EMAIL                VARCHAR(64) COMMENT '邮箱',
   TELEPHONE            VARCHAR(16) COMMENT '电话',
   NOTE                 VARCHAR(128) COMMENT '备注',
   LOGIN_TIME           DATETIME COMMENT '登陆时间',
   LOGOUT_TIME          DATETIME COMMENT '退出时间',
   IS_DEL               INT DEFAULT 0 COMMENT '是否删除 0：不是 1：是',
   CREATE_TIME          DATETIME COMMENT '创建时间',
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
   PRIMARY KEY (SYS_USER_ID)
);

ALTER TABLE T_SYS_USER COMMENT '用户表';

/*==============================================================*/
/* Table: T_SYS_USER_REF_ROLE                                   */
/*==============================================================*/
CREATE TABLE T_SYS_USER_REF_ROLE
(
   SYS_USER_REF_ROLE_ID INT NOT NULL AUTO_INCREMENT,
   SYS_USER_ID          INT,
   SYS_ROLE_ID          INT,
   PRIMARY KEY (SYS_USER_REF_ROLE_ID)
);

ALTER TABLE T_SYS_USER_REF_ROLE COMMENT '用户,角色关联表';

/*==============================================================*/
/* View: V_INVENTORY                                            */
/*==============================================================*/
CREATE VIEW  V_INVENTORY
 AS
SELECT 
  I.*,
  L.`LOGISTICS_CODE`,
  L.`IE_FLAG`,
  L.`TRAF_MODE`,
  L.`SHIP_NAME`,
  L.`VOYAGE_NO`,
  L.`BILL_NO`,
  -- L.`CUSTOM_CODE`, L.`APP_UID`, 
  O.`ORDER_NO`,
  O.`EBP_CODE`,
  O.`EBC_CODE`,
  O.`AGENT_CODE`,
  O.`CONSIGNEE_COUNTRY` 
FROM
  `T_INVENTORY` I 
  LEFT JOIN `T_LOGISTICS` L 
    ON L.`LOGISTICS_NO` = I.`LOGISTICS_NO` 
  LEFT JOIN `T_ORDERS` O 
    ON L.`ORDER_NO` = O.`ORDER_NO`;

/*==============================================================*/
/* View: V_INVENTORY_DETAIL                                     */
/*==============================================================*/
CREATE VIEW  V_INVENTORY_DETAIL
 AS
SELECT 
  ID.`INVENTORY_DETAIL_ID`,
  ID.`INVENTORY_ID`,
  ID.`GNUM`,
  ID.`UNIT` AS `UNIT_I`,
  ID.`UNIT1` AS `UNIT1_I`,
  ID.`UNIT2` AS `UNIT2_I`,
  ID.`QTY`,
  ID.`QTY1`,
  ID.`QTY2`,
  ID.`PRICE` AS `ONE_PRICE`,
  ID.`TOTAL`,
  S.* 
FROM
  `T_INVENTORY_DETAIL` ID 
  LEFT JOIN `T_SKU` S 
    ON ID.`ITEM_NO` = S.`ITEM_NO`;

/*==============================================================*/
/* View: V_LOGISTICS_UNUSE                                      */
/*==============================================================*/
CREATE VIEW  V_LOGISTICS_UNUSE
 AS
SELECT 
  L.* 
FROM
  `T_LOGISTICS` L 
  LEFT JOIN `T_INVENTORY` I 
    ON L.`LOGISTICS_NO` = I.`LOGISTICS_NO` 
WHERE ISNULL(I.`LOGISTICS_NO`);

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
  O.`AGENT_CODE`
FROM
  `T_NJ_INVENTORY` I 
  LEFT JOIN `T_NJ_LOGISTICS` L 
    ON L.`LOGISTICS_NO` = I.`LOGISTICS_NO` 
  LEFT JOIN `T_NJ_ORDERS` O 
    ON L.`ORDER_NO` = O.`ORDER_NO`;

/*==============================================================*/
/* View: V_NJ_INVENTORY_DETAIL                                  */
/*==============================================================*/
CREATE VIEW  V_NJ_INVENTORY_DETAIL
 AS
SELECT 
  ID.`INVENTORY_DETAIL_ID`,
  ID.`INVENTORY_ID`,
  ID.`GNUM`,
  ID.`UNIT` AS `UNIT_I`,
  ID.`UNIT1` AS `UNIT1_I`,
  ID.`UNIT2` AS `UNIT2_I`,
  ID.`QTY`,
  ID.`QTY1`,
  ID.`QTY2`,
  ID.`PRICE` AS `ONE_PRICE`,
  ID.`TOTAL`,
  S.* 
FROM
  `T_NJ_INVENTORY_DETAIL` ID 
  LEFT JOIN T_NJ_INVENTORY INVENTORY 
    ON INVENTORY.INVENTORY_ID = ID.INVENTORY_ID 
  LEFT JOIN T_NJ_LOGISTICS LOGISTICS 
    ON LOGISTICS.LOGISTICS_NO = INVENTORY.LOGISTICS_NO 
  LEFT JOIN T_NJ_ORDERS ORDERS 
    ON ORDERS.ORDER_NO = LOGISTICS.ORDER_NO 
  LEFT JOIN `T_NJ_SKU` S 
    ON (
      ID.ITEM_NO = S.ITEM_NO 
      AND ORDERS.ORDER_TYPE = S.BIZ_TYPE
    );

/*==============================================================*/
/* View: V_NJ_LOGISTICS                                         */
/*==============================================================*/
CREATE VIEW  V_NJ_LOGISTICS
 AS
SELECT 
  L.*,
  C.NAME AS CONSIGNEE,
  C.TEL AS CONSIGNEE_TELEPHONE 
FROM
  `T_NJ_LOGISTICS` L 
  LEFT JOIN `T_CONTACT` C 
    ON L.`CONSIGNEE_ID` = C.`CONTACT_ID`;

/*==============================================================*/
/* View: V_NJ_LOGISTICS_UNUSE                                   */
/*==============================================================*/
CREATE VIEW  V_NJ_LOGISTICS_UNUSE
 AS
SELECT 
  L.*,
  C.NAME AS CONSIGNEE,
  C.TEL AS CONSIGNEE_TELEPHONE 
FROM
  `T_NJ_LOGISTICS` L 
  LEFT JOIN `T_NJ_INVENTORY` I 
    ON L.`LOGISTICS_NO` = I.`LOGISTICS_NO` 
  LEFT JOIN `T_CONTACT` C 
    ON L.`CONSIGNEE_ID` = C.`CONTACT_ID` 
WHERE ISNULL(I.`LOGISTICS_NO`);

/*==============================================================*/
/* View: V_NJ_ORDERS_UNUSE                                      */
/*==============================================================*/
CREATE VIEW  V_NJ_ORDERS_UNUSE
 AS
SELECT 
  O.* 
FROM
  `T_NJ_ORDERS` O 
  LEFT JOIN `T_NJ_LOGISTICS` L 
    ON O.`ORDER_NO` = L.`ORDER_NO` 
WHERE ISNULL(L.`ORDER_NO`);

/*==============================================================*/
/* View: V_ORDERS_UNUSE                                         */
/*==============================================================*/
CREATE VIEW  V_ORDERS_UNUSE
 AS
SELECT 
  O.* 
FROM
  `T_ORDERS` O 
  LEFT JOIN `T_LOGISTICS` L 
    ON O.`ORDER_NO` = L.`ORDER_NO` 
WHERE ISNULL(L.`ORDER_NO`);

/*==============================================================*/
/* View: V_USER_ROLE                                            */
/*==============================================================*/
CREATE VIEW  V_USER_ROLE
 AS
SELECT 
  SYSUSER.`SYS_USER_ID` AS SYS_USER_ID,
  SYSMENU.`MENU_PARENT_ID`  AS MENU_PARENT_ID,
  SYSMENU.`SYS_MENU_ID` AS `SYS_MENU_ID`,
  SYSMENU.`MENU_DISPLAY_NAME` AS `MENU_DISPLAY_NAME`,
  SYSMENU.`MENU_HREF` AS `MENU_HREF`,
  SYSMENU.`IS_LEAF` AS `IS_LEAF`,
  SYSMENU.`ICON_CLASS` AS `ICON_CLASS`
FROM
  T_SYS_USER SYSUSER,
  T_SYS_ROLE_REF AUTHDOMAINREF 
  LEFT JOIN T_SYS_MENU SYSMENU 
    ON (
      SYSMENU.`SYS_MENU_ID` = AUTHDOMAINREF.`SYS_MENU_ID` 
    )
WHERE AUTHDOMAINREF.`SYS_ROLE_ID` IN 
  (SELECT 
    AUTHREF.`SYS_ROLE_ID` 
  FROM
    T_SYS_USER_REF_ROLE AUTHREF 
  WHERE AUTHREF.`SYS_USER_ID` = SYSUSER.`SYS_USER_ID`);

ALTER TABLE QRTZ_BLOB_TRIGGERS ADD CONSTRAINT QRTZ_BLOB_TRIGGERS_IBFK_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP)
      REFERENCES QRTZ_TRIGGERS (TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_CRON_TRIGGERS ADD CONSTRAINT QRTZ_CRON_TRIGGERS_IBFK_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP)
      REFERENCES QRTZ_TRIGGERS (TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_JOB_LISTENERS ADD CONSTRAINT QRTZ_JOB_LISTENERS_IBFK_1 FOREIGN KEY (JOB_NAME, JOB_GROUP)
      REFERENCES QRTZ_JOB_DETAILS (JOB_NAME, JOB_GROUP);

ALTER TABLE QRTZ_SIMPLE_TRIGGERS ADD CONSTRAINT QRTZ_SIMPLE_TRIGGERS_IBFK_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP)
      REFERENCES QRTZ_TRIGGERS (TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE QRTZ_TRIGGERS ADD CONSTRAINT QRTZ_TRIGGERS_IBFK_1 FOREIGN KEY (JOB_NAME, JOB_GROUP)
      REFERENCES QRTZ_JOB_DETAILS (JOB_NAME, JOB_GROUP);

ALTER TABLE QRTZ_TRIGGER_LISTENERS ADD CONSTRAINT QRTZ_TRIGGER_LISTENERS_IBFK_1 FOREIGN KEY (TRIGGER_NAME, TRIGGER_GROUP)
      REFERENCES QRTZ_TRIGGERS (TRIGGER_NAME, TRIGGER_GROUP);

ALTER TABLE T_INVENTORY ADD CONSTRAINT FK_REFERENCE_10 FOREIGN KEY (LOGISTICS_NO)
      REFERENCES T_LOGISTICS (LOGISTICS_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_INVENTORY_DETAIL ADD CONSTRAINT FK_REFERENCE_11 FOREIGN KEY (INVENTORY_ID)
      REFERENCES T_INVENTORY (INVENTORY_ID) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_LOGISTICS ADD CONSTRAINT FK_REFERENCE_12 FOREIGN KEY (ORDER_NO)
      REFERENCES T_ORDERS (ORDER_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_NJ_INVENTORY ADD CONSTRAINT FK_REFERENCE_4 FOREIGN KEY (LOGISTICS_NO)
      REFERENCES T_NJ_LOGISTICS (LOGISTICS_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_NJ_INVENTORY_DETAIL ADD CONSTRAINT FK_REFERENCE_111 FOREIGN KEY (INVENTORY_ID)
      REFERENCES T_NJ_INVENTORY (INVENTORY_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_NJ_LOGISTICS ADD CONSTRAINT FK_REFERENCE_2 FOREIGN KEY (ORDER_NO)
      REFERENCES T_NJ_ORDERS (ORDER_NO) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE T_NJ_ORDER_DETAIL ADD CONSTRAINT FK_REFERENCE_99 FOREIGN KEY (ORDERS_ID)
      REFERENCES T_NJ_ORDERS (ORDERS_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_ORDER_DETAIL ADD CONSTRAINT FK_REFERENCE_9 FOREIGN KEY (ORDERS_ID)
      REFERENCES T_ORDERS (ORDERS_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLE_REF ADD CONSTRAINT FK_REFERENCE_13 FOREIGN KEY (SYS_MENU_ID)
      REFERENCES T_SYS_MENU (SYS_MENU_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_SYS_ROLE_REF ADD CONSTRAINT FK_REFERENCE_97 FOREIGN KEY (SYS_ROLE_ID)
      REFERENCES T_SYS_ROLE (SYS_ROLE_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USER_REF_ROLE ADD CONSTRAINT FK_REFERENCE_14 FOREIGN KEY (SYS_USER_ID)
      REFERENCES T_SYS_USER (SYS_USER_ID) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE T_SYS_USER_REF_ROLE ADD CONSTRAINT FK_REFERENCE_15 FOREIGN KEY (SYS_ROLE_ID)
      REFERENCES T_SYS_ROLE (SYS_ROLE_ID) ON DELETE CASCADE ON UPDATE RESTRICT;


DELIMITER $$

CREATE TRIGGER TRIGGER_UPDATE_NJ_ORDERNO AFTER UPDATE
ON T_NJ_ORDERS FOR EACH ROW
BEGIN
    UPDATE 
      T_NJ_ORDER_DETAIL 
    SET
      T_NJ_ORDER_DETAIL.ORDER_NO = NEW.ORDER_NO 
    WHERE NEW.ORDERS_ID = T_NJ_ORDER_DETAIL.ORDERS_ID; 
END;
$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER TRIGGER_UPDATE_ORDERNO AFTER UPDATE
ON T_ORDERS FOR EACH ROW
BEGIN
    UPDATE 
      T_ORDER_DETAIL 
    SET
      T_ORDER_DETAIL.ORDER_NO = NEW.ORDER_NO 
    WHERE NEW.ORDERS_ID = T_ORDER_DETAIL.ORDERS_ID; 
END;
$$

DELIMITER ;

