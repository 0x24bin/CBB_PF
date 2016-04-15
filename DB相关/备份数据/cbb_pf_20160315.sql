/*
SQLyog v10.2 
MySQL - 5.6.20-log : Database - cbb_pf
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `qrtz_blob_triggers` */

DROP TABLE IF EXISTS `qrtz_blob_triggers`;

CREATE TABLE `qrtz_blob_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_IBFK_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_blob_triggers` */

/*Table structure for table `qrtz_calendars` */

DROP TABLE IF EXISTS `qrtz_calendars`;

CREATE TABLE `qrtz_calendars` (
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_calendars` */

/*Table structure for table `qrtz_cron_triggers` */

DROP TABLE IF EXISTS `qrtz_cron_triggers`;

CREATE TABLE `qrtz_cron_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_IBFK_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_cron_triggers` */

/*Table structure for table `qrtz_fired_triggers` */

DROP TABLE IF EXISTS `qrtz_fired_triggers`;

CREATE TABLE `qrtz_fired_triggers` (
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_STATEFUL` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_fired_triggers` */

/*Table structure for table `qrtz_job_details` */

DROP TABLE IF EXISTS `qrtz_job_details`;

CREATE TABLE `qrtz_job_details` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `IS_STATEFUL` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_job_details` */

/*Table structure for table `qrtz_job_listeners` */

DROP TABLE IF EXISTS `qrtz_job_listeners`;

CREATE TABLE `qrtz_job_listeners` (
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `JOB_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`JOB_LISTENER`,`JOB_NAME`,`JOB_GROUP`),
  KEY `QRTZ_JOB_LISTENERS_IBFK_1` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_JOB_LISTENERS_IBFK_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_job_listeners` */

/*Table structure for table `qrtz_locks` */

DROP TABLE IF EXISTS `qrtz_locks`;

CREATE TABLE `qrtz_locks` (
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_locks` */

insert  into `qrtz_locks`(`LOCK_NAME`) values ('CALENDAR_ACCESS'),('JOB_ACCESS'),('MISFIRE_ACCESS'),('STATE_ACCESS'),('TRIGGER_ACCESS');

/*Table structure for table `qrtz_paused_trigger_grps` */

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;

CREATE TABLE `qrtz_paused_trigger_grps` (
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_paused_trigger_grps` */

/*Table structure for table `qrtz_scheduler_state` */

DROP TABLE IF EXISTS `qrtz_scheduler_state`;

CREATE TABLE `qrtz_scheduler_state` (
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_scheduler_state` */

/*Table structure for table `qrtz_simple_triggers` */

DROP TABLE IF EXISTS `qrtz_simple_triggers`;

CREATE TABLE `qrtz_simple_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_IBFK_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_simple_triggers` */

/*Table structure for table `qrtz_trigger_listeners` */

DROP TABLE IF EXISTS `qrtz_trigger_listeners`;

CREATE TABLE `qrtz_trigger_listeners` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `TRIGGER_LISTENER` varchar(200) NOT NULL,
  PRIMARY KEY (`TRIGGER_LISTENER`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `QRTZ_TRIGGER_LISTENERS_IBFK_1` (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_TRIGGER_LISTENERS_IBFK_1` FOREIGN KEY (`TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_trigger_listeners` */

/*Table structure for table `qrtz_triggers` */

DROP TABLE IF EXISTS `qrtz_triggers`;

CREATE TABLE `qrtz_triggers` (
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `IS_VOLATILE` varchar(1) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `QRTZ_TRIGGERS_IBFK_1` (`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_TRIGGERS_IBFK_1` FOREIGN KEY (`JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `qrtz_triggers` */

/*Table structure for table `t_code_name` */

DROP TABLE IF EXISTS `t_code_name`;

CREATE TABLE `t_code_name` (
  `CODE_NAME_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RELATION_CATEGORY` varchar(64) DEFAULT NULL COMMENT '关联类别',
  `RELATION_NAME` varchar(128) DEFAULT NULL COMMENT '关联说明',
  `CODE` varchar(64) DEFAULT NULL COMMENT '代号',
  `SN_CODE` varchar(64) DEFAULT NULL COMMENT '苏宁代号',
  `NAME` varchar(128) DEFAULT NULL COMMENT '名称',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CODE_NAME_ID`),
  UNIQUE KEY `AK_KEY_2` (`RELATION_CATEGORY`,`RELATION_NAME`,`CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='报文中代码与名称之间关系';

/*Data for the table `t_code_name` */

insert  into `t_code_name`(`CODE_NAME_ID`,`RELATION_CATEGORY`,`RELATION_NAME`,`CODE`,`SN_CODE`,`NAME`,`CREAT_TIME`,`UPDATE_TIME`) values (1,'CUSTOM_CODE','申报海关代码','2308',NULL,'我是申报海关代码123133333',NULL,'2016-02-15 15:46:39'),(2,'APP_UID','用户名称','1',NULL,'我是用户名称',NULL,'2014-12-01 19:38:16'),(3,'EBP_CODE','电商平台名称','1',NULL,'电商平台名称',NULL,'2014-12-01 19:38:46'),(4,'EBC_CODE','电商企业名称','1',NULL,'电商企业名称',NULL,'2014-12-01 19:38:56'),(5,'AGENT_CODE','申报企业名称','1',NULL,'申报企业名称',NULL,'2014-12-01 19:38:57'),(6,'CLASSIFY_CODE','预归类企业名称','1',NULL,'预归类企业名称',NULL,'2014-12-01 19:39:26'),(7,'UNIT','计量单位','KG',NULL,'千克',NULL,'2014-12-11 22:17:18'),(8,'CURRENCY','币制','142',NULL,'人民币',NULL,'2015-10-12 16:21:28'),(10,'TAX_CODE','海关物品税号','15010200',NULL,'增值税',NULL,'2015-10-12 16:19:33'),(11,'LOGISTICS_CODE','物流企业名称','1',NULL,'物流企业名称',NULL,'2014-12-11 22:33:16'),(12,'TRAF_MODE','运输方式','1',NULL,'运输方式',NULL,'2014-12-11 22:33:16'),(13,'WRAP_TYPE','包装种类','1',NULL,'包装种类',NULL,'2015-01-28 10:10:12'),(14,'PORT','港口','1',NULL,'港口',NULL,'2015-01-28 10:13:19'),(15,'COUNTRY','国家','142','CN','中国',NULL,'2015-03-02 14:33:47'),(16,'AGENT_CODE','申报企业名称','234234','234234','申报企业名称sdfadfasdf','2015-04-03 17:12:15','2015-04-03 17:12:40'),(17,'UNIT','计量单位','001',NULL,'台',NULL,'2015-10-12 16:09:23'),(18,'CUSTOM_CODE','申报海关代码','2309',NULL,'接收海关代码',NULL,'2015-10-14 16:13:41'),(19,'COUNTRY','国家','143',NULL,'萨芬',NULL,'2015-10-16 15:28:09');

/*Table structure for table `t_contact` */

DROP TABLE IF EXISTS `t_contact`;

CREATE TABLE `t_contact` (
  `CONTACT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CODE` varchar(50) NOT NULL,
  `NAME` varchar(200) DEFAULT NULL,
  `TEL` varchar(50) DEFAULT NULL,
  `COUNTRY` varchar(50) DEFAULT NULL,
  `ADDRESS` text COMMENT 'PROVINCE+CITY+DISTRICT+SPECIFIC_ADDRESS组合',
  `PROVINCE` varchar(50) DEFAULT NULL,
  `CITY` varchar(50) DEFAULT NULL,
  `DISTRICT` varchar(50) DEFAULT NULL,
  `SPECIFIC_ADDRESS` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CONTACT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='联系人表';

/*Data for the table `t_contact` */

insert  into `t_contact`(`CONTACT_ID`,`CODE`,`NAME`,`TEL`,`COUNTRY`,`ADDRESS`,`PROVINCE`,`CITY`,`DISTRICT`,`SPECIFIC_ADDRESS`) values (1,'320219198601221514','徐大神','18652040122','142','高尔夫',NULL,NULL,NULL,NULL),(5,'3202191093873487','陈萌萌','1239734978','143','2342_234_234_234234','2342','234','234','234234'),(6,'3202191987234','撒旦法','2123423','142','江苏省234_江阴市222_问下区222_稳住留2222','江苏省234','江阴市222','问下区222','稳住留2222'),(10,'3202191093873487','陈似的','莲花新城','123','143_条达成_320219198601221514_高尔夫','143','条达成','320219198601221514','高尔夫');

/*Table structure for table `t_file_location_config` */

DROP TABLE IF EXISTS `t_file_location_config`;

CREATE TABLE `t_file_location_config` (
  `FILE_LOCATION_CONFIG_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY` int(11) DEFAULT '1' COMMENT '1.商品备案数据 2.电子订单 3.支付凭证 4.物流运单 5.物流运单状态 6.出境清单',
  `GENERAL_XML` varchar(128) DEFAULT 'general' COMMENT '生成xml地址',
  `RECEIPT_XML` varchar(128) DEFAULT 'receipt' COMMENT '回执xml地址',
  `TRANSFER_XML` varchar(128) DEFAULT 'transfer' COMMENT '阅读xml回执后转移地址',
  `INPUT_XML` varchar(128) DEFAULT 'input' COMMENT '电子订单获取源数据地址',
  PRIMARY KEY (`FILE_LOCATION_CONFIG_ID`),
  UNIQUE KEY `AK_KEY_2` (`CATEGORY`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='生成xml，回执xml，回执读取后xml，文件地址配置';

/*Data for the table `t_file_location_config` */

insert  into `t_file_location_config`(`FILE_LOCATION_CONFIG_ID`,`CATEGORY`,`GENERAL_XML`,`RECEIPT_XML`,`TRANSFER_XML`,`INPUT_XML`) values (1,1,'sku/general','sku/receipt','sku/transfer','sku/input'),(2,2,'order/general','order/receipt','order/transfer','order/input'),(3,3,'pay/general','pay/receipt','pay/transfer','pay/input'),(4,4,'logistics/general','logistics/receipt','logistics/transfer','logistics/input'),(5,5,'logisticsStatus/general','logisticsStatus/receipt','logisticsStatus/transfer','logisticsStatus/input'),(6,6,'inventory/general','inventory/receipt','inventory/transfer','inventory/input');

/*Table structure for table `t_guid_rel` */

DROP TABLE IF EXISTS `t_guid_rel`;

CREATE TABLE `t_guid_rel` (
  `GUID_REL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUIDS` varchar(50) DEFAULT NULL COMMENT '本平台GUID',
  `GUIDC` varchar(50) DEFAULT NULL COMMENT '海关平台GUID',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`GUID_REL_ID`),
  UNIQUE KEY `AK_KEY_2` (`GUIDS`),
  UNIQUE KEY `AK_KEY_3` (`GUIDC`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='存放本平台中guid与海关平台guid之间对应关系';

/*Data for the table `t_guid_rel` */

insert  into `t_guid_rel`(`GUID_REL_ID`,`GUIDS`,`GUIDC`,`CREAT_TIME`,`UPDATE_TIME`) values (1,'SINOTRANS-SKU-20150106124524-0000001','SINOTRANS-SKU-20150106124524-0000001','2015-01-06 12:48:31','2015-01-06 12:48:30'),(4,'SINOTRANS-SKU-20150106124544-0000002','SINOTRANS-SKU-20150106124544-0000002','2015-02-05 16:20:26','2015-02-05 16:20:33'),(5,'SINOTRANS-SKU-20150205144447-0000003','SINOTRANS-SKU-20150205144447-0000003','2015-02-05 16:20:42','2015-02-05 16:20:46'),(6,'SINOTRANS-SKU-20150205173048-0000004','aaaaaaaa','2015-02-05 17:36:00','2015-02-05 17:36:00'),(7,'SINOTRANS-ORDER-20150205182309-00004','bbbbbbbbbbbbb','2015-02-05 18:32:00','2015-02-05 18:32:00'),(9,'SINOTRANS-EXPORT-20150205185047-0003','dddddddddddd','2015-02-05 18:52:01','2015-02-05 18:52:00'),(10,'SINOTRANS-SUNING-20150211085333-0004','mmmmmmmmmmmmmmmmmmm,sdfdfsd','2015-02-11 09:08:30','2015-02-12 13:56:04'),(11,'SINOTRANS-LOGISTIC-20150205161027-09','kkkkkkkkkkkkk,gggggggggggggggg','2015-02-12 14:13:30','2015-02-12 14:16:30');

/*Table structure for table `t_inventory` */

DROP TABLE IF EXISTS `t_inventory`;

CREATE TABLE `t_inventory` (
  `INVENTORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `COP_NO` varchar(20) DEFAULT NULL COMMENT '企业内部编号--企业内部生成标识清单的编号',
  `PRE_NO` varchar(18) DEFAULT NULL COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `INVT_NO` varchar(18) DEFAULT NULL COMMENT '清单编号--海关审批生成标识清单的编号',
  `PORT_CODE` varchar(4) DEFAULT NULL COMMENT '出口口岸代码--商品实际出我国关境口岸海关的关区代码',
  `IE_DATE` datetime DEFAULT NULL COMMENT '进出口时间',
  `OWNER_CODE` varchar(10) DEFAULT NULL COMMENT '发货人代码--出口发货人填写10位海关企业代码',
  `OWNER_NAME` varchar(128) DEFAULT NULL COMMENT '发货人名称',
  `TRADE_MODE` varchar(4) DEFAULT NULL COMMENT '贸易方式 默认为9610,预留支持跨境的多种贸易方式',
  `LOCT_NO` varchar(10) DEFAULT NULL COMMENT '监管场所代码--针对同一申报地海关下有多个跨境电子商务的监管场所,需要填写区分',
  `LICENSE_NO` varchar(19) DEFAULT NULL COMMENT '许可证号--商务主管部门及其授权发证机关签发的进出口货物许可证的编号',
  `COUNTRY` varchar(3) DEFAULT NULL COMMENT '运抵国（地区）--出口货物的直接运抵的国家（地区），按海关规定的《国家（地区）代码表》填写代码。',
  `DESTINATION_PORT` varchar(4) DEFAULT NULL COMMENT '指运港代码--出口运往境外的最终目的港的标识代码。最终目的港不可预知时，应尽可能按预知的目的港填报',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `FREIGHT_CURR` varchar(3) DEFAULT NULL COMMENT '运费币制--海关标准的参数代码',
  `FREIGHT_MARK` int(11) DEFAULT NULL COMMENT '运费标志--1-率，2-单价，3-总价',
  `INSURE_FEE` decimal(19,5) DEFAULT NULL COMMENT '保价费--货物保险费用',
  `INSURE_FEE_CURR` varchar(3) DEFAULT NULL COMMENT '保费币制--海关标准的参数代码',
  `INSURE_FEE_MARK` int(11) DEFAULT NULL COMMENT '保费标志--1-率，2-单价，3-总价',
  `WRAP_TYPE` varchar(1) DEFAULT NULL COMMENT '包装种类代码--海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
  `PACK_NO` int(11) DEFAULT NULL COMMENT '件数--单个运单下包裹数',
  `WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '毛重--单位为千克',
  `NET_WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '净重--单位为千克',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`INVENTORY_ID`),
  KEY `FK_REFERENCE_10` (`LOGISTICS_NO`),
  CONSTRAINT `FK_REFERENCE_10` FOREIGN KEY (`LOGISTICS_NO`) REFERENCES `t_logistics` (`LOGISTICS_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存放出境清单数据';

/*Data for the table `t_inventory` */

/*Table structure for table `t_inventory_detail` */

DROP TABLE IF EXISTS `t_inventory_detail`;

CREATE TABLE `t_inventory_detail` (
  `INVENTORY_DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `INVENTORY_ID` int(11) DEFAULT NULL,
  `GNUM` int(11) DEFAULT NULL COMMENT '商品序号--从1开始的递增序号',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `QTY` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `QTY1` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `QTY2` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `UNIT` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT1` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT2` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `TOTAL` decimal(19,5) DEFAULT NULL COMMENT '总价',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`INVENTORY_DETAIL_ID`),
  KEY `FK_REFERENCE_11` (`INVENTORY_ID`),
  CONSTRAINT `FK_REFERENCE_11` FOREIGN KEY (`INVENTORY_ID`) REFERENCES `t_inventory` (`INVENTORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_inventory_detail` */

/*Table structure for table `t_logistics` */

DROP TABLE IF EXISTS `t_logistics`;

CREATE TABLE `t_logistics` (
  `LOGISTICS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `LOGISTICS_CODE` varchar(10) DEFAULT NULL COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
  `LOGISTICS_NAME` varchar(128) DEFAULT NULL COMMENT '物流企业的海关备案名称',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `LOGISTICS_STATUS` varchar(1) DEFAULT NULL COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
  `IE_FLAG` varchar(1) DEFAULT NULL COMMENT '进出口标记--I进口/E出口',
  `TRAF_MODE` varchar(1) DEFAULT NULL COMMENT '运输方式--海关标准的参数代码',
  `SHIP_NAME` varchar(100) DEFAULT NULL COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
  `VOYAGE_NO` varchar(32) DEFAULT NULL COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
  `BILL_NO` varchar(37) DEFAULT NULL COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `INSURE_FEE` decimal(19,5) DEFAULT NULL COMMENT '保价费--货物保险费用',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '毛重--单位为千克',
  `NET_WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '净重--单位为千克',
  `PACK_NO` int(11) DEFAULT NULL COMMENT '件数--单个运单下包裹数',
  `PARCEL_INFO` varchar(200) DEFAULT NULL COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
  `GOODS_INFO` varchar(200) DEFAULT NULL COMMENT '商品信息--物流企业可知的商品信息',
  `CONSIGNEE` varchar(100) DEFAULT NULL COMMENT '收货人名称',
  `CONSIGNEE_ADDRESS` varchar(512) DEFAULT NULL COMMENT '收货人地址',
  `CONSIGNEE_TELEPHONE` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `CONSIGNEE_COUNTRY` varchar(3) DEFAULT NULL COMMENT '收货人所在国--海关标准的参数代码',
  `SHIPPER` varchar(100) DEFAULT NULL COMMENT '发货人名称',
  `SHIPPER_ADDRESS` varchar(200) DEFAULT NULL COMMENT '发货人地址',
  `SHIPPER_TELEPHONE` varchar(50) DEFAULT NULL COMMENT '发货人电话',
  `SHIPPER_COUNTRY` varchar(3) DEFAULT NULL COMMENT '发货人所在国--海关标准的参数代码',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LOGISTICS_ID`),
  UNIQUE KEY `AK_KEY_2` (`LOGISTICS_NO`),
  KEY `FK_REFERENCE_12` (`ORDER_NO`),
  CONSTRAINT `FK_REFERENCE_12` FOREIGN KEY (`ORDER_NO`) REFERENCES `t_orders` (`ORDER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='运单表存放运单信息';

/*Data for the table `t_logistics` */

insert  into `t_logistics`(`LOGISTICS_ID`,`ORDER_NO`,`GUID`,`CUSTOM_CODE`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`LOGISTICS_CODE`,`LOGISTICS_NAME`,`LOGISTICS_NO`,`LOGISTICS_STATUS`,`IE_FLAG`,`TRAF_MODE`,`SHIP_NAME`,`VOYAGE_NO`,`BILL_NO`,`FREIGHT`,`INSURE_FEE`,`CURRENCY`,`WEIGHT`,`NET_WEIGHT`,`PACK_NO`,`PARCEL_INFO`,`GOODS_INFO`,`CONSIGNEE`,`CONSIGNEE_ADDRESS`,`CONSIGNEE_TELEPHONE`,`CONSIGNEE_COUNTRY`,`SHIPPER`,`SHIPPER_ADDRESS`,`SHIPPER_TELEPHONE`,`SHIPPER_COUNTRY`,`NOTE`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (1,'order1','SINOTRANS-LOGISTIC-20150106125942-01','1',1,'xxxxxxx',99,'1',NULL,'1',NULL,'1','A','I','1','1','1','1','1.00000','1.00000','CNY','1.00000','1.00000',1,'1','1','1','1','1','CN','1','1','1','CN','1',120,NULL,NULL,'2015-01-06 12:59:43','2015-03-03 11:52:34'),(8,'order2','SINOTRANS-LOGISTIC-20150205160932-08','1',1,'20150203100607',99,'1',NULL,'1',NULL,'3','L','I','1','3','3','3','3.00000','3.00000','CNY','3.00000','3.00000',3,'3','3','3','3','3','142','3','3','3','142','3',120,NULL,NULL,'2015-02-05 16:09:32','2015-03-03 11:51:49'),(9,'order3','SINOTRANS-LOGISTIC-20150205161027-09','1',1,'20150212142220',99,'1',NULL,'1',NULL,'4','C','I','1','44','4','4','4444.00000','4.00000','CNY','4.00000','4.00000',4,'4','4','4444','44444','4444','CN','4','4','4','CN','4',120,'20150106124551','[gggggggggggggggg]','2015-02-05 16:10:27','2015-03-03 11:52:05'),(10,'order4','SINOTRANS-LOGISTIC-20150205184111-10','1',1,'20150212164353',99,'1',NULL,'1',NULL,'5','S','I','1','5','5','5','5.00000','5.00000','CNY','5.00000','5.00000',5,'5','5','5','5','5','CN','5','5','5','CN','5',120,'20150106124551','[gggggggggggggggg]','2015-02-05 18:41:12','2015-02-12 16:44:30');

/*Table structure for table `t_logistics_sn` */

DROP TABLE IF EXISTS `t_logistics_sn`;

CREATE TABLE `t_logistics_sn` (
  `LOGISTICS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '企业系统生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SUNING-YYYYMMDDhhmmss-0001,即系统当前时间加4位流水号',
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `EBP_CODE` varchar(64) DEFAULT NULL COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
  `EBP_NAME` varchar(128) DEFAULT NULL COMMENT '电商平台名称',
  `LOGISTICS_ORDER_ID` varchar(128) DEFAULT NULL,
  `LOGISTICS_CODE` varchar(10) DEFAULT NULL COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
  `LOGISTICS_NAME` varchar(128) DEFAULT NULL COMMENT '物流企业的海关备案名称',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `LOGISTICS_STATUS` varchar(1) DEFAULT NULL COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
  `IE_FLAG` varchar(1) DEFAULT NULL COMMENT '进出口标记--I进口/E出口',
  `TRAF_MODE` varchar(1) DEFAULT NULL COMMENT '运输方式--海关标准的参数代码',
  `SHIP_NAME` varchar(100) DEFAULT NULL COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
  `VOYAGE_NO` varchar(32) DEFAULT NULL COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
  `BILL_NO` varchar(37) DEFAULT NULL COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `INSURE_FEE` decimal(19,5) DEFAULT NULL COMMENT '保价费--货物保险费用',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '毛重--单位为千克',
  `NET_WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '净重--单位为千克',
  `PACK_NO` int(11) DEFAULT NULL COMMENT '件数--单个运单下包裹数',
  `PARCEL_INFO` varchar(200) DEFAULT NULL COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
  `GOODS_INFO` varchar(200) DEFAULT NULL COMMENT '商品信息--物流企业可知的商品信息',
  `CONSIGNEE` varchar(100) DEFAULT NULL COMMENT '收货人名称',
  `CONSIGNEE_ADDRESS` varchar(512) DEFAULT NULL COMMENT '收货人地址',
  `CONSIGNEE_TELEPHONE` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `CONSIGNEE_COUNTRY` varchar(3) DEFAULT NULL COMMENT '收货人所在国--海关标准的参数代码',
  `SHIPPER` varchar(100) DEFAULT NULL COMMENT '发货人名称',
  `SHIPPER_ADDRESS` varchar(200) DEFAULT NULL COMMENT '发货人地址',
  `SHIPPER_TELEPHONE` varchar(50) DEFAULT NULL COMMENT '发货人电话',
  `SHIPPER_COUNTRY` varchar(3) DEFAULT NULL COMMENT '发货人所在国--海关标准的参数代码',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LOGISTICS_ID`),
  UNIQUE KEY `AK_KEY_2` (`LOGISTICS_NO`),
  KEY `AK_KEY_3` (`ORDER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='运单表存放运单信息';

/*Data for the table `t_logistics_sn` */

insert  into `t_logistics_sn`(`LOGISTICS_ID`,`GUID`,`ORDER_NO`,`CUSTOM_CODE`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`EBP_CODE`,`EBP_NAME`,`LOGISTICS_ORDER_ID`,`LOGISTICS_CODE`,`LOGISTICS_NAME`,`LOGISTICS_NO`,`LOGISTICS_STATUS`,`IE_FLAG`,`TRAF_MODE`,`SHIP_NAME`,`VOYAGE_NO`,`BILL_NO`,`FREIGHT`,`INSURE_FEE`,`CURRENCY`,`WEIGHT`,`NET_WEIGHT`,`PACK_NO`,`PARCEL_INFO`,`GOODS_INFO`,`CONSIGNEE`,`CONSIGNEE_ADDRESS`,`CONSIGNEE_TELEPHONE`,`CONSIGNEE_COUNTRY`,`SHIPPER`,`SHIPPER_ADDRESS`,`SHIPPER_TELEPHONE`,`SHIPPER_COUNTRY`,`NOTE`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (20,'SINOTRANS-SUNING-20150302144137-0020','13075056','1',1,'20150302144209',2,'1',NULL,'1',NULL,'OMS0001931525120456','1',NULL,'123',NULL,'I','1','123','123','123','123.00000','123.00000','CNY','200.00000','200.00000',1,'123','长虹空调KFR35GWBP2DN1YF','苏宁门店','18楼1801','18513891234','CN','C店商户苏宁','5楼0502','13913891234','CN','奔跑吧，哥们！',NULL,NULL,NULL,'2015-03-02 14:41:37','2015-03-02 14:42:09');

/*Table structure for table `t_nj_inventory` */

DROP TABLE IF EXISTS `t_nj_inventory`;

CREATE TABLE `t_nj_inventory` (
  `INVENTORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `RECEIVER_ID` varchar(4) DEFAULT NULL COMMENT '接收海关代码',
  `CHK_CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '验放海关代码，清单进出境实货放行海关。',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `COP_NO` varchar(20) DEFAULT NULL COMMENT '企业内部编号--企业内部生成标识清单的编号',
  `PRE_NO` varchar(18) DEFAULT NULL COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `INVT_NO` varchar(18) DEFAULT NULL COMMENT '清单编号--海关审批生成标识清单的编号',
  `PORT_CODE` varchar(4) DEFAULT NULL COMMENT '出口口岸代码--商品实际出我国关境口岸海关的关区代码',
  `IE_DATE` datetime DEFAULT NULL COMMENT '进出口时间',
  `OWNER_CODE` varchar(10) DEFAULT NULL COMMENT '发货人代码--出口发货人填写10位海关企业代码',
  `OWNER_NAME` varchar(128) DEFAULT NULL COMMENT '发货人名称',
  `TRADE_MODE` varchar(4) DEFAULT NULL COMMENT '贸易方式 默认为9610,预留支持跨境的多种贸易方式',
  `LOCT_NO` varchar(10) DEFAULT NULL COMMENT '监管场所代码--针对同一申报地海关下有多个跨境电子商务的监管场所,需要填写区分',
  `LICENSE_NO` varchar(19) DEFAULT NULL COMMENT '许可证号--商务主管部门及其授权发证机关签发的进出口货物许可证的编号',
  `COUNTRY` varchar(3) DEFAULT NULL COMMENT '运抵国（地区）--出口货物的直接运抵的国家（地区），按海关规定的《国家（地区）代码表》填写代码。',
  `GOODS_VALUE` decimal(19,5) DEFAULT NULL COMMENT '商品价格',
  `GOODS_CURRENCY` varchar(3) DEFAULT NULL COMMENT '进口清单为人民币',
  `TAX_FEE` decimal(19,5) DEFAULT NULL COMMENT '行邮税费',
  `DESTINATION_PORT` varchar(5) DEFAULT NULL COMMENT '指运港代码--出口运往境外的最终目的港的标识代码。最终目的港不可预知时，应尽可能按预知的目的港填报',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `FREIGHT_CURR` varchar(3) DEFAULT NULL COMMENT '运费币制--海关标准的参数代码',
  `FREIGHT_MARK` int(11) DEFAULT NULL COMMENT '运费标志--1-率，2-单价，3-总价',
  `INSURE_FEE` decimal(19,5) DEFAULT NULL COMMENT '保价费--货物保险费用',
  `INSURE_FEE_CURR` varchar(3) DEFAULT NULL COMMENT '保费币制--海关标准的参数代码',
  `INSURE_FEE_MARK` int(11) DEFAULT NULL COMMENT '保费标志--1-率，2-单价，3-总价',
  `WRAP_TYPE` varchar(1) DEFAULT NULL COMMENT '包装种类代码--海关对进出口货物实际采用的外部包装方式的标识代码，采用1 位数字表示，如：木箱、纸箱、桶装、散装、托盘、包、油罐车等',
  `PACK_NO` int(11) DEFAULT NULL COMMENT '件数--单个运单下包裹数',
  `WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '毛重--单位为千克',
  `NET_WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '净重--单位为千克',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `VERSION` varchar(16) DEFAULT 'V1.0' COMMENT '版本号',
  PRIMARY KEY (`INVENTORY_ID`),
  KEY `FK_REFERENCE_4` (`LOGISTICS_NO`),
  CONSTRAINT `FK_REFERENCE_4` FOREIGN KEY (`LOGISTICS_NO`) REFERENCES `t_nj_logistics` (`LOGISTICS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='存放出境清单数据';

/*Data for the table `t_nj_inventory` */

insert  into `t_nj_inventory`(`INVENTORY_ID`,`GUID`,`CUSTOM_CODE`,`RECEIVER_ID`,`CHK_CUSTOM_CODE`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`COP_NO`,`PRE_NO`,`LOGISTICS_NO`,`INVT_NO`,`PORT_CODE`,`IE_DATE`,`OWNER_CODE`,`OWNER_NAME`,`TRADE_MODE`,`LOCT_NO`,`LICENSE_NO`,`COUNTRY`,`GOODS_VALUE`,`GOODS_CURRENCY`,`TAX_FEE`,`DESTINATION_PORT`,`FREIGHT`,`FREIGHT_CURR`,`FREIGHT_MARK`,`INSURE_FEE`,`INSURE_FEE_CURR`,`INSURE_FEE_MARK`,`WRAP_TYPE`,`PACK_NO`,`WEIGHT`,`NET_WEIGHT`,`NOTE`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`,`VERSION`) values (3,'CEB_601_1_2308_2016010511134147200','2308','2308','2308',1,NULL,1,'1',NULL,'123',NULL,'234',NULL,'2308','2016-01-05 00:00:00','1',NULL,NULL,'123','123','142',NULL,NULL,NULL,'1','123.00000','142',3,'234.00000','142',3,'1',234,'234.00000','234.00000','123123',NULL,NULL,NULL,'2016-01-05 11:13:41','2016-01-05 11:13:41','V1.0');

/*Table structure for table `t_nj_inventory_detail` */

DROP TABLE IF EXISTS `t_nj_inventory_detail`;

CREATE TABLE `t_nj_inventory_detail` (
  `INVENTORY_DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `INVENTORY_ID` int(11) DEFAULT NULL,
  `GNUM` int(11) DEFAULT NULL COMMENT '商品序号--从1开始的递增序号',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `QTY` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `QTY1` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `QTY2` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `UNIT` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT1` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT2` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `TOTAL` decimal(19,5) DEFAULT NULL COMMENT '总价',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`INVENTORY_DETAIL_ID`),
  KEY `FK_REFERENCE_111` (`INVENTORY_ID`),
  CONSTRAINT `FK_REFERENCE_111` FOREIGN KEY (`INVENTORY_ID`) REFERENCES `t_nj_inventory` (`INVENTORY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `t_nj_inventory_detail` */

insert  into `t_nj_inventory_detail`(`INVENTORY_DETAIL_ID`,`INVENTORY_ID`,`GNUM`,`ITEM_NO`,`QTY`,`QTY1`,`QTY2`,`UNIT`,`UNIT1`,`UNIT2`,`PRICE`,`TOTAL`,`CREAT_TIME`,`UPDATE_TIME`) values (3,3,1,'G111113434','1.00000','1.00000',NULL,'001',NULL,NULL,'123.00000','123.00000','2016-01-05 11:13:42','2016-01-05 11:13:41');

/*Table structure for table `t_nj_logistics` */

DROP TABLE IF EXISTS `t_nj_logistics`;

CREATE TABLE `t_nj_logistics` (
  `LOGISTICS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `RECEIVER_ID` varchar(4) DEFAULT NULL COMMENT '接收海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `LOGISTICS_CODE` varchar(10) DEFAULT NULL COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
  `LOGISTICS_NAME` varchar(128) DEFAULT NULL COMMENT '物流企业的海关备案名称',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `LOGISTICS_STATUS` varchar(1) DEFAULT NULL COMMENT '物流状态--物流状态,A-承运,R-运抵,C-退货,L-离境,S-签收',
  `IE_FLAG` varchar(1) DEFAULT NULL COMMENT '进出口标记--I进口/E出口',
  `TRAF_MODE` varchar(1) DEFAULT NULL COMMENT '运输方式--海关标准的参数代码',
  `TRAF_NAME` varchar(100) DEFAULT NULL COMMENT '（对应报文中的trafName）运输工具名称--货物进出境的运输工具的名称或运输工具编号。填报内容应与运输部门向海关申报的载货清单所列相应内容一致；同报关单填制规范。',
  `VOYAGE_NO` varchar(32) DEFAULT NULL COMMENT '航班航次号--货物进出境的运输工具的航次编号；同报关单填制规范。',
  `BILL_NO` varchar(37) DEFAULT NULL COMMENT '提运单号--货物提单或运单的编号；同报关单填制规范。',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `INSURE_FEE` decimal(19,5) DEFAULT NULL COMMENT '保价费--货物保险费用',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '毛重--单位为千克',
  `NET_WEIGHT` decimal(19,5) DEFAULT NULL COMMENT '净重--单位为千克',
  `PACK_NO` int(11) DEFAULT NULL COMMENT '件数--单个运单下包裹数',
  `PARCEL_INFO` varchar(200) DEFAULT NULL COMMENT '包裹单信息--单个运单下多个包裹单号信息,分割使用"/"',
  `GOODS_INFO` varchar(200) DEFAULT NULL COMMENT '商品信息--物流企业可知的商品信息',
  `CONSIGNEE_ID` int(11) DEFAULT NULL COMMENT '收货人',
  `SHIPPER_ID` int(11) DEFAULT NULL COMMENT '发货人',
  `LOGISTICS_HEAD_NO` varchar(20) DEFAULT NULL COMMENT '总运单号',
  `IS_AUTO` int(11) DEFAULT '0' COMMENT '是否自动生成 0：不是 1：是',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `VERSION` varchar(16) DEFAULT 'V1.0' COMMENT '版本号',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`LOGISTICS_ID`),
  UNIQUE KEY `AK_KEY_2` (`LOGISTICS_NO`),
  KEY `FK_REFERENCE_2` (`ORDER_NO`),
  CONSTRAINT `FK_REFERENCE_2` FOREIGN KEY (`ORDER_NO`) REFERENCES `t_nj_orders` (`ORDER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='运单表存放运单信息';

/*Data for the table `t_nj_logistics` */

insert  into `t_nj_logistics`(`LOGISTICS_ID`,`ORDER_NO`,`GUID`,`CUSTOM_CODE`,`RECEIVER_ID`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`LOGISTICS_CODE`,`LOGISTICS_NAME`,`LOGISTICS_NO`,`LOGISTICS_STATUS`,`IE_FLAG`,`TRAF_MODE`,`TRAF_NAME`,`VOYAGE_NO`,`BILL_NO`,`FREIGHT`,`INSURE_FEE`,`CURRENCY`,`WEIGHT`,`NET_WEIGHT`,`PACK_NO`,`PARCEL_INFO`,`GOODS_INFO`,`CONSIGNEE_ID`,`SHIPPER_ID`,`LOGISTICS_HEAD_NO`,`IS_AUTO`,`NOTE`,`VERSION`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (2,'13','CEB_501_1_2308_2015111311050445000','2308','2308',1,'20151113114728',1,'1',NULL,'1',NULL,'234',NULL,'I','1','234','234','234','123.00000','234.00000','142','234.83200','234.83200',234,'234','234',5,1,NULL,0,'234','1.0',2,NULL,NULL,'2015-11-13 11:05:04','2016-03-25 19:09:53'),(18,'2','CEB_501_1234567890_2308_2016030213552006600','2308','2308',1,NULL,1,'1',NULL,'1',NULL,'000000000001',NULL,'I','1',NULL,NULL,NULL,'2423.00000','123.00000',NULL,NULL,'1.10000',6,NULL,'1231',10,NULL,NULL,1,NULL,'V1.0',NULL,NULL,NULL,'2016-03-02 13:55:20','2016-03-04 20:42:48');

/*Table structure for table `t_nj_order_detail` */

DROP TABLE IF EXISTS `t_nj_order_detail`;

CREATE TABLE `t_nj_order_detail` (
  `ORDER_DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDERS_ID` int(11) DEFAULT NULL,
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `GNUM` int(11) DEFAULT NULL COMMENT '商品序号--从1开始的递增序号',
  `QTY` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `TOTAL` decimal(19,5) DEFAULT NULL COMMENT '总价',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ORDER_DETAIL_ID`),
  KEY `FK_REFERENCE_99` (`ORDERS_ID`),
  CONSTRAINT `FK_REFERENCE_99` FOREIGN KEY (`ORDERS_ID`) REFERENCES `t_nj_orders` (`ORDERS_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='存放电子订单的表体数据';

/*Data for the table `t_nj_order_detail` */

insert  into `t_nj_order_detail`(`ORDER_DETAIL_ID`,`ORDERS_ID`,`ORDER_NO`,`ITEM_NO`,`GNUM`,`QTY`,`PRICE`,`TOTAL`,`NOTE`,`CREAT_TIME`,`UPDATE_TIME`) values (30,12,'123','G111113434',1,'1.00000','123.00000','123.00000','123','2015-10-17 21:02:27','2015-10-17 21:02:27'),(47,15,'123444443366','G111113434',1,'1.00000','123.00000','123.00000','123','2015-10-19 15:02:31','2015-10-19 15:02:30'),(48,16,'13','G111113434',1,'1.00000','123.00000','123.00000','123','2015-10-19 20:23:29','2015-10-19 20:23:28'),(57,8,'1231','G111113434',1,'1.00000','123.00000','123.00000','123','2015-11-13 10:43:00','2015-11-13 10:42:59'),(108,42,'2','G111113434',1,'1.00000','123.00000','123.00000','123','2016-03-02 13:55:20','2016-03-02 13:55:20'),(109,42,'2','G111113434',2,'5.00000','123.00000','123.00000','123','2016-03-02 13:55:20','2016-03-02 13:55:20');

/*Table structure for table `t_nj_orders` */

DROP TABLE IF EXISTS `t_nj_orders`;

CREATE TABLE `t_nj_orders` (
  `ORDERS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-ORDER-YYYYMMDDhhmmss-00001,即系统当前时间加5位流水号',
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `RECEIVER_ID` varchar(4) DEFAULT NULL COMMENT '接收海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '2' COMMENT '业务状态:1-暂存,2-申报,默认为2',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `ORDER_TYPE` int(11) DEFAULT NULL COMMENT '1、一般进口2、一般出口3、保税进口4、保税出口',
  `EBP_CODE` varchar(64) DEFAULT NULL COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
  `EBP_NAME` varchar(128) DEFAULT NULL COMMENT '电商平台名称',
  `EBC_CODE` varchar(64) DEFAULT NULL COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
  `EBC_NAME` varchar(128) DEFAULT NULL COMMENT '电商企业名称',
  `AGENT_CODE` varchar(64) DEFAULT NULL COMMENT '申报企业代码',
  `AGENT_NAME` varchar(128) DEFAULT NULL COMMENT '申报企业名称',
  `GOODS_VALUE` decimal(19,5) DEFAULT NULL COMMENT '商品价格',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `TAX_FEE` decimal(19,5) DEFAULT NULL COMMENT '行邮税费',
  `CONSIGNEE_ID` int(11) DEFAULT NULL COMMENT '收货人',
  `UNDER_THE_SINGER_ID` int(11) DEFAULT NULL COMMENT '下单人',
  `LOGISTICS_CODE` varchar(10) DEFAULT NULL COMMENT '物流企业代码--物流企业的海关备案编码（10位）',
  `LOGISTICS_NAME` varchar(128) DEFAULT NULL COMMENT '物流企业的海关备案名称',
  `LOGISTICS_NO` varchar(20) DEFAULT NULL COMMENT '物流运单编号--物流企业的运单包裹面单号',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `VERSION` varchar(16) DEFAULT 'V1.0' COMMENT '版本号',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ORDERS_ID`),
  UNIQUE KEY `AK_KEY_2` (`ORDER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='存放电子订单的表头数据';

/*Data for the table `t_nj_orders` */

insert  into `t_nj_orders`(`ORDERS_ID`,`GUID`,`ORDER_NO`,`CUSTOM_CODE`,`RECEIVER_ID`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`ORDER_TYPE`,`EBP_CODE`,`EBP_NAME`,`EBC_CODE`,`EBC_NAME`,`AGENT_CODE`,`AGENT_NAME`,`GOODS_VALUE`,`FREIGHT`,`CURRENCY`,`TAX_FEE`,`CONSIGNEE_ID`,`UNDER_THE_SINGER_ID`,`LOGISTICS_CODE`,`LOGISTICS_NAME`,`LOGISTICS_NO`,`NOTE`,`VERSION`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (8,'CEB_301_1111111111_2308_2015101715282712500','1231','2308','2308',1,NULL,1,'1',NULL,2,'1',NULL,'1',NULL,'234234',NULL,'45.00000','123.00000','142',NULL,5,NULL,'1',NULL,'2423','123','V1.0',NULL,NULL,NULL,'2015-10-17 15:28:27','2015-11-13 10:42:59'),(12,'CEB_301_1111111111_2308_2015101721022723800','123','2308','2309',1,NULL,2,'1',NULL,2,'1',NULL,'1',NULL,'234234',NULL,'12.00000','3123.00000','142','123.00000',1,1,'1',NULL,'缺','231','V1.0',NULL,NULL,NULL,'2015-10-17 21:02:27','2015-10-17 21:02:27'),(15,'CEB_301_1111111111_2308_2015101721135233900','123444443366','2308','2309',1,NULL,2,'1',NULL,2,'1',NULL,'1',NULL,'234234',NULL,'12.00000','3123.00000','142','123.00000',1,NULL,'1',NULL,'缺','','V1.0',NULL,NULL,NULL,'2015-10-17 21:13:52','2015-10-20 12:45:29'),(16,'CEB_301_1_2308_2015101920232891300','13','2308','2308',1,NULL,2,'1',NULL,1,'1',NULL,'1',NULL,'1',NULL,'123.00000','123.00000','142','1231.00000',5,1,'1',NULL,'123123','123123','V1.0',2,NULL,NULL,'2015-10-19 20:23:29','2015-10-20 12:47:54'),(42,'CEB_301_1234567890_2308_2016030213552002700','2','2308','2308',1,NULL,4,'1234567890',NULL,1,'1234567890',NULL,'1234567890',NULL,'1234567890',NULL,'1.00000','2423.00000','123','0.30000',10,NULL,NULL,NULL,'000000000001','123','V1.0',NULL,NULL,NULL,'2016-03-02 13:55:20','2016-03-02 13:55:20');

/*Table structure for table `t_nj_sku` */

DROP TABLE IF EXISTS `t_nj_sku`;

CREATE TABLE `t_nj_sku` (
  `SKU_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT 'CEB_企业海关10位数编码_主管海关4位编码_19位时间戳[YYYYMMDDHHMISSFFFFF],\n            例如CEB_201_1113240359_2301_2015010116301223134',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `RECEIVER_ID` varchar(4) DEFAULT NULL COMMENT '接收海关代码',
  `BIZ_TYPE` int(11) DEFAULT NULL COMMENT '业务类型',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `PRE_NO` varchar(50) DEFAULT NULL COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
  `EBP_CODE` varchar(64) DEFAULT NULL COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
  `EBP_NAME` varchar(128) DEFAULT NULL COMMENT '电商平台名称',
  `EBC_CODE` varchar(64) DEFAULT NULL COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
  `EBC_NAME` varchar(128) DEFAULT NULL COMMENT '电商企业名称',
  `AGENT_CODE` varchar(64) DEFAULT NULL COMMENT '申报企业代码',
  `AGENT_NAME` varchar(128) DEFAULT NULL COMMENT '申报企业名称',
  `CLASSIFY_CODE` varchar(64) DEFAULT NULL COMMENT '预归类企业代码',
  `CLASSIFY_NAME` varchar(128) DEFAULT NULL COMMENT '预归类企业名称',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `ITEM_NAME` varchar(250) DEFAULT NULL COMMENT '商品上架品名--电商平台标识商品的名称',
  `G_NO` varchar(20) DEFAULT NULL COMMENT '海关商品备案编号--海关审核生成标识商品备案数据的编号(4位年+2位月+4位关区+8位流水号)',
  `G_CODE` varchar(10) DEFAULT NULL COMMENT '海关商品编码--海关标准的参数代码',
  `G_NAME` varchar(250) DEFAULT NULL COMMENT '商品名称--同一类商品的中文名称。任何一种具体商品可以并只能归入表中的一个条目',
  `G_MODEL` varchar(250) DEFAULT NULL COMMENT '规格型号--商品的规格型号，应尽可能详细，以能满足海关归类、审价以及监管的要求为准。包括：品名、牌名、规格、型号、成份、含量、等级等',
  `BAR_CODE` varchar(13) DEFAULT NULL COMMENT '条形码--商品条形码一般由前缀部分、制造厂商代码、商品代码和校验码组成。没有条形码填“无”',
  `BRAND` varchar(100) DEFAULT NULL COMMENT '品牌--没有填“无”',
  `TAX_CODE` varchar(8) DEFAULT NULL COMMENT '海关标准的参数代码',
  `TAX_RATE` decimal(19,5) DEFAULT NULL COMMENT '行邮税率',
  `UNIT` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT1` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT2` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `COUNTRY` varchar(3) DEFAULT NULL COMMENT '原产国',
  `GIFT_FLAG` int(11) DEFAULT NULL COMMENT '是否赠品:0-否，1-是',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `VERSION` varchar(16) DEFAULT 'V1.0' COMMENT '版本号',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '2：审批通过 3：审批不通过\n            ',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SKU_ID`),
  UNIQUE KEY `AK_KEY_2` (`ITEM_NO`,`BIZ_TYPE`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='存放商品信息';

/*Data for the table `t_nj_sku` */

insert  into `t_nj_sku`(`SKU_ID`,`GUID`,`CUSTOM_CODE`,`RECEIVER_ID`,`BIZ_TYPE`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`PRE_NO`,`EBP_CODE`,`EBP_NAME`,`EBC_CODE`,`EBC_NAME`,`AGENT_CODE`,`AGENT_NAME`,`CLASSIFY_CODE`,`CLASSIFY_NAME`,`ITEM_NO`,`ITEM_NAME`,`G_NO`,`G_CODE`,`G_NAME`,`G_MODEL`,`BAR_CODE`,`BRAND`,`TAX_CODE`,`TAX_RATE`,`UNIT`,`UNIT1`,`UNIT2`,`PRICE`,`CURRENCY`,`COUNTRY`,`GIFT_FLAG`,`NOTE`,`VERSION`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (42,'CEB_201_1111111111_2308_2015101217585231300','2308',NULL,1,1,'20151012175853',2,'1',NULL,'P10000000004','1',NULL,'2',NULL,'234234',NULL,'1',NULL,'G11111111111112',NULL,NULL,'8450111000','洗衣机','123','1','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',2,NULL,NULL,'2015-10-12 17:58:52','2015-10-26 15:56:16'),(43,'CEB_201_1111111111_2308_2015101416141677600','2308',NULL,1,1,'20151014161426',2,'1',NULL,'P10000000004','1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G14544545',NULL,NULL,'8450111000','洗衣机','12312','1','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2015-10-14 16:14:17','2015-10-14 16:14:26'),(44,'CEB_201_1111111111_2308_2015101416150711400','2308',NULL,1,1,'20151014162008',2,'1',NULL,NULL,'1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G343434',NULL,NULL,'8450111000','洗衣机','123','1','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2015-10-14 16:15:07','2015-10-14 16:20:08'),(45,'CEB_201_1111111111_2308_2015101514555721300','2308','2308',1,1,NULL,1,'1',NULL,NULL,'1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G1134111','alskdjf;alksdjf;laskd',NULL,'8450111000','洗衣机','12312','','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2015-10-15 14:55:57','2016-03-02 16:57:46'),(46,'CEB_201_1111111111_2308_2015101514571776500','2308','2308',1,1,'20151019111545',2,'1',NULL,NULL,'1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G11341324',NULL,NULL,'8450111000','洗衣机','12312','','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2015-10-15 14:57:18','2015-10-19 11:15:45'),(47,'CEB_201_1111111111_2308_2015101516450904300','2308','2308',2,1,'20151019111224',2,'1',NULL,NULL,'1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G1111134341111',NULL,NULL,'8450111000','洗衣机','12312','1','123','23','23.00000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2015-10-15 16:45:09','2015-10-19 11:12:24'),(58,'CEB_201_1234567890_2308_2016030213552001300','2308','2308',1,1,NULL,4,'1234567890',NULL,NULL,'1234567890',NULL,'1234567890',NULL,'1234567890',NULL,NULL,NULL,'G111113434',NULL,NULL,NULL,'洗衣机',NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,'123.00000','123',NULL,NULL,'123','V1.0',NULL,NULL,NULL,'2016-03-02 13:55:20','2016-03-02 13:55:20'),(59,'CEB_201_1_2308_2016030216581816500','2308','2308',1,1,NULL,1,'1',NULL,NULL,'1',NULL,'1',NULL,'234234',NULL,'1',NULL,'G1134111111','111111',NULL,'8450111000','洗衣机','12312','3123123','123','15010200','0.20000','001',NULL,NULL,'123.00000','142','142',1,'123','V1.0',NULL,NULL,NULL,'2016-03-02 16:58:18','2016-03-02 16:58:18');

/*Table structure for table `t_order_detail` */

DROP TABLE IF EXISTS `t_order_detail`;

CREATE TABLE `t_order_detail` (
  `ORDER_DETAIL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ORDERS_ID` int(11) DEFAULT NULL,
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `GNUM` int(11) DEFAULT NULL COMMENT '商品序号--从1开始的递增序号',
  `QTY` decimal(19,5) DEFAULT NULL COMMENT '成交数量',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `TOTAL` decimal(19,5) DEFAULT NULL COMMENT '总价',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ORDER_DETAIL_ID`),
  KEY `FK_REFERENCE_9` (`ORDERS_ID`),
  CONSTRAINT `FK_REFERENCE_9` FOREIGN KEY (`ORDERS_ID`) REFERENCES `t_orders` (`ORDERS_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='存放电子订单的表体数据';

/*Data for the table `t_order_detail` */

insert  into `t_order_detail`(`ORDER_DETAIL_ID`,`ORDERS_ID`,`ORDER_NO`,`ITEM_NO`,`GNUM`,`QTY`,`PRICE`,`TOTAL`,`NOTE`,`CREAT_TIME`,`UPDATE_TIME`) values (6,2,'order2','item2',1,'4.00000','2.00000','8.00000','2','2015-01-06 12:53:37','2015-01-06 12:53:37'),(14,3,'order3','item3',1,'1.00000','3.00000','3.00000','333','2015-02-05 15:18:40','2015-02-05 16:13:29'),(17,4,'order4','4',1,'1.00000','4.00000','4.00000','4','2015-02-05 18:23:38','2015-02-05 18:23:38'),(18,1,'order1','item1',1,'1.00000','1.00000','1.00000','1','2015-02-06 09:04:28','2015-02-06 09:04:27'),(19,1,'order1','item2',2,'1.00000','2.00000','2.00000','2','2015-02-06 09:04:28','2015-02-06 09:04:27'),(21,8,'订单编号10','item3',1,'1.00000','3.00000','3.00000','33333','2015-02-12 10:53:16','2015-02-12 10:53:16'),(22,5,'订单编号2','4',1,'1.00000','4.00000','4.00000','4','2015-02-12 14:08:40','2015-02-12 14:08:39');

/*Table structure for table `t_orders` */

DROP TABLE IF EXISTS `t_orders`;

CREATE TABLE `t_orders` (
  `ORDERS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-ORDER-YYYYMMDDhhmmss-00001,即系统当前时间加5位流水号',
  `ORDER_NO` varchar(30) DEFAULT NULL COMMENT '订单编号--电商平台的原始订单编号，格式',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '2' COMMENT '业务状态:1-暂存,2-申报,默认为2',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `ORDER_TYPE` varchar(1) DEFAULT NULL COMMENT '电商平台的订单类型 I进口/E出口',
  `EBP_CODE` varchar(64) DEFAULT NULL COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
  `EBP_NAME` varchar(128) DEFAULT NULL COMMENT '电商平台名称',
  `EBC_CODE` varchar(64) DEFAULT NULL COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
  `EBC_NAME` varchar(128) DEFAULT NULL COMMENT '电商企业名称',
  `AGENT_CODE` varchar(64) DEFAULT NULL COMMENT '申报企业代码',
  `AGENT_NAME` varchar(128) DEFAULT NULL COMMENT '申报企业名称',
  `GOODS_VALUE` decimal(19,5) DEFAULT NULL COMMENT '商品价格',
  `FREIGHT` decimal(19,5) DEFAULT NULL COMMENT '订单商品运费--交易包运费则填写"0"',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `CONSIGNEE` varchar(100) DEFAULT NULL COMMENT '收货人名称',
  `CONSIGNEE_ADDRESS` varchar(512) DEFAULT NULL COMMENT '收货人地址',
  `CONSIGNEE_TELEPHONE` varchar(50) DEFAULT NULL COMMENT '收货人电话',
  `CONSIGNEE_COUNTRY` varchar(3) DEFAULT NULL COMMENT '收货人所在国--海关标准的参数代码',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ORDERS_ID`),
  UNIQUE KEY `AK_KEY_2` (`ORDER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='存放电子订单的表头数据';

/*Data for the table `t_orders` */

insert  into `t_orders`(`ORDERS_ID`,`GUID`,`ORDER_NO`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`ORDER_TYPE`,`EBP_CODE`,`EBP_NAME`,`EBC_CODE`,`EBC_NAME`,`AGENT_CODE`,`AGENT_NAME`,`GOODS_VALUE`,`FREIGHT`,`CURRENCY`,`CONSIGNEE`,`CONSIGNEE_ADDRESS`,`CONSIGNEE_TELEPHONE`,`CONSIGNEE_COUNTRY`,`NOTE`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (1,'SINOTRANS-ORDER-20150106125215-00001','order1',1,'20150206090427',2,'1',NULL,'I','1',NULL,'1',NULL,'1',NULL,'1.00000','1.00000','CNY','1','1','1','CN','1',120,'20150106124551','[1111]','2015-01-06 12:52:15','2015-02-06 09:04:27'),(2,'SINOTRANS-ORDER-20150106125318-00002','order2',1,'20150106125337',99,'1',NULL,'E','1',NULL,'1',NULL,'1',NULL,'2.00000','2.00000','CNY','2','2','2','CN','2',120,'20150106124551','[2222]','2015-01-06 12:53:19','2015-02-05 14:16:26'),(3,'SINOTRANS-ORDER-20150205144955-00003','order3',1,'20150205151840',99,'1',NULL,'I','1',NULL,'1',NULL,'1',NULL,'333.00000','333.00000','CNY','333','3333','3333','CN','3333',120,'20150106124551','[3333]','2015-02-05 14:49:56','2015-02-05 16:12:20'),(4,'SINOTRANS-ORDER-20150205182309-00004','order4',1,'20150205182338',99,'1',NULL,'E','1',NULL,'1',NULL,'1',NULL,'4.00000','4.00000','CNY','4','4','4','CN','4',120,'nnnnn','[bbbbbbbbbbbbb]','2015-02-05 18:23:09','2015-02-05 18:40:00'),(5,'SINOTRANS-ORDER-20150211091530-00005','订单编号2',1,'20150212140839',2,'1','我是用户名称','I','1','电商平台名称','1','电商企业名称','1','申报企业名称','2.20000','2.20000','CNY','收货人名称','收货人地址','3434535','CN','备注2',NULL,NULL,NULL,'2015-02-11 09:15:30','2015-02-12 14:08:39'),(8,'SINOTRANS-ORDER-20150211092230-00008','订单编号10',1,'20150212105316',2,'1','我是用户名称','E','1','电商平台名称','1','电商企业名称','1','申报企业名称','2.20000','2.20000','CNY','收货人名称','收货人地址','收货人电话','CN','备注2',NULL,NULL,NULL,'2015-02-11 09:22:30','2015-02-12 10:53:16');

/*Table structure for table `t_sku` */

DROP TABLE IF EXISTS `t_sku`;

CREATE TABLE `t_sku` (
  `SKU_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GUID` varchar(64) DEFAULT NULL COMMENT '本平台生成36位唯一序号（英文字母大写和数字和横杠）,格式:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,即系统当前时间加7位流水号',
  `CUSTOM_CODE` varchar(4) DEFAULT NULL COMMENT '办理商品备案手续的4位海关代码',
  `APP_TYPE` int(11) DEFAULT '1' COMMENT '申报类型:1-新增 2-变更 3-删除,默认为1',
  `APP_TIME` varchar(64) DEFAULT NULL COMMENT '申报时间以海关审批反馈时间为准,格式:YYYYMMDDhhmmss,系统当前时间（回执中获取）',
  `APP_STATUS` int(11) DEFAULT '1' COMMENT '业务状态:1-暂存,2-申报,默认为1',
  `APP_UID` varchar(64) DEFAULT NULL COMMENT '电子口岸持卡人IC卡或IKEY编号',
  `APP_UNAME` varchar(128) DEFAULT NULL COMMENT '电子口岸持卡人姓名',
  `PRE_NO` varchar(18) DEFAULT NULL COMMENT '预录入编号--电子口岸生成标识商品备案数据的编号',
  `EBP_CODE` varchar(64) DEFAULT NULL COMMENT '电商平台代码--电商企业的海关备案编码（10位）',
  `EBP_NAME` varchar(128) DEFAULT NULL COMMENT '电商平台名称',
  `EBC_CODE` varchar(64) DEFAULT NULL COMMENT '电商企业代码--电商平台的海关备案编码（10位）',
  `EBC_NAME` varchar(128) DEFAULT NULL COMMENT '电商企业名称',
  `AGENT_CODE` varchar(64) DEFAULT NULL COMMENT '申报企业代码',
  `AGENT_NAME` varchar(128) DEFAULT NULL COMMENT '申报企业名称',
  `CLASSIFY_CODE` varchar(64) DEFAULT NULL COMMENT '预归类企业代码',
  `CLASSIFY_NAME` varchar(128) DEFAULT NULL COMMENT '预归类企业名称',
  `ITEM_NO` varchar(20) DEFAULT NULL COMMENT '企业商品货号--电商平台标识商品的货号',
  `ITEM_NAME` varchar(250) DEFAULT NULL COMMENT '商品上架品名--电商平台标识商品的名称',
  `G_NO` varchar(18) DEFAULT NULL COMMENT '海关商品备案编号--海关审核生成标识商品备案数据的编号(4位年+2位月+4位关区+8位流水号)',
  `G_CODE` varchar(10) DEFAULT NULL COMMENT '海关商品编码--海关标准的参数代码',
  `G_NAME` varchar(250) DEFAULT NULL COMMENT '商品名称--同一类商品的中文名称。任何一种具体商品可以并只能归入表中的一个条目',
  `G_MODEL` varchar(250) DEFAULT NULL COMMENT '规格型号--商品的规格型号，应尽可能详细，以能满足海关归类、审价以及监管的要求为准。包括：品名、牌名、规格、型号、成份、含量、等级等',
  `BAR_CODE` varchar(13) DEFAULT NULL COMMENT '条形码--商品条形码一般由前缀部分、制造厂商代码、商品代码和校验码组成。没有条形码填“无”',
  `BRAND` varchar(100) DEFAULT NULL COMMENT '品牌--没有填“无”',
  `TAX_CODE` varchar(8) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT1` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `UNIT2` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码',
  `PRICE` decimal(19,5) DEFAULT NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致',
  `CURRENCY` varchar(3) DEFAULT NULL COMMENT '海关标准的参数代码--币制',
  `GIFT_FLAG` int(11) DEFAULT NULL COMMENT '是否赠品:0-否，1-是',
  `NOTE` varchar(1000) DEFAULT NULL COMMENT '备注',
  `RETURN_STATUS` int(11) DEFAULT NULL COMMENT '回执状态--操作结果（1电子口岸已暂存/2电子口岸申报中/3发送海关成功/4发送海关失败/100海关退单/120海关入库成功/399海关审结）,若小于0数字表示处理异常回执',
  `RETURN_TIME` varchar(64) DEFAULT NULL COMMENT '回执时间--操作时间(格式:YYYYMMDDhhmmss)',
  `RETURN_INFO` varchar(1000) DEFAULT NULL COMMENT '回执信息--备注（如:退单原因）',
  `CREAT_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SKU_ID`),
  UNIQUE KEY `AK_KEY_2` (`ITEM_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='存放商品信息';

/*Data for the table `t_sku` */

insert  into `t_sku`(`SKU_ID`,`GUID`,`CUSTOM_CODE`,`APP_TYPE`,`APP_TIME`,`APP_STATUS`,`APP_UID`,`APP_UNAME`,`PRE_NO`,`EBP_CODE`,`EBP_NAME`,`EBC_CODE`,`EBC_NAME`,`AGENT_CODE`,`AGENT_NAME`,`CLASSIFY_CODE`,`CLASSIFY_NAME`,`ITEM_NO`,`ITEM_NAME`,`G_NO`,`G_CODE`,`G_NAME`,`G_MODEL`,`BAR_CODE`,`BRAND`,`TAX_CODE`,`UNIT`,`UNIT1`,`UNIT2`,`PRICE`,`CURRENCY`,`GIFT_FLAG`,`NOTE`,`RETURN_STATUS`,`RETURN_TIME`,`RETURN_INFO`,`CREAT_TIME`,`UPDATE_TIME`) values (1,'SINOTRANS-SKU-20150106124524-0000001','1',1,'20150206090349',2,'1',NULL,'11111','1',NULL,'1',NULL,'1',NULL,'1',NULL,'item1','1','1111111','1','1','1','1','1','1','KG','KG','KG','1.00000','CNY',1,'1',399,'20150106124551','[SINOTRANS-SKU-20150106124524-0000001]','2015-01-06 12:45:24','2015-02-06 09:03:49'),(2,'SINOTRANS-SKU-20150106124544-0000002','1',1,'20150106124558',99,'1',NULL,'2222','1',NULL,'1',NULL,'1',NULL,'1',NULL,'item2','2','2222','2','2','2','2','2','1','KG','KG','KG','2.00000','CNY',1,'2',399,'20150106124551','[SINOTRANS-SKU-20150106124544-0000002]','2015-01-06 12:45:45','2015-01-06 12:51:30'),(4,'SINOTRANS-SKU-20150205173048-0000004','1',1,'20150205173048',99,'1',NULL,'11111','1',NULL,'1',NULL,'1',NULL,'1',NULL,'4','4','1111111','4','4','4','4','4','1','KG','KG','KG','4.00000','CNY',1,'4',399,'1111111','[SINOTRANS-SKU-20150205173048-0000004]','2015-02-05 17:30:49','2015-02-05 17:38:00'),(5,'SINOTRANS-SKU-20150209112104-0000005','1',1,'20150209162224',2,'1',NULL,NULL,'1',NULL,'1',NULL,'1',NULL,'1',NULL,'6','6',NULL,'6','6','6','6','6','1','KG','KG','KG','6.00000','CNY',0,'6',NULL,NULL,NULL,'2015-02-09 11:21:04','2015-02-09 16:22:24'),(6,'SINOTRANS-SKU-20150209163734-0000006','1',1,'20150209163734',2,'1',NULL,NULL,'1',NULL,'1',NULL,'1',NULL,'1',NULL,'item7','1',NULL,'1','1','1','1','1','1','KG','KG','KG','1.00000','CNY',1,'1',NULL,NULL,NULL,'2015-02-09 16:37:35','2015-02-09 16:37:34'),(7,'SINOTRANS-SKU-20150209163913-0000007','1',1,'20150209163913',2,'1',NULL,NULL,'1',NULL,'1',NULL,'1',NULL,'1',NULL,'8','8',NULL,'8','8','8','8','8','1','KG','KG','KG','8.00000','CNY',0,'8',NULL,NULL,NULL,'2015-02-09 16:39:14','2015-02-09 16:39:13'),(8,'SINOTRANS-SKU-20150209164059-0000008','1',1,'20150209164059',2,'1',NULL,NULL,'1',NULL,'1',NULL,'1',NULL,'1',NULL,'9','9',NULL,'9','9','9','9','9','1','KG','KG','KG','8.00000','CNY',1,'9',NULL,NULL,NULL,'2015-02-09 16:41:00','2015-02-09 16:40:59'),(9,'SINOTRANS-SKU-20150212105204-0000009','1',1,'20150212141014',2,'1',NULL,NULL,'1',NULL,'1',NULL,'1',NULL,'1',NULL,'10','10',NULL,'10','10','10','10','10','1','KG','KG','KG','10.00000','CNY',0,'10',NULL,NULL,NULL,'2015-02-12 10:52:05','2015-02-12 14:10:14');

/*Table structure for table `t_sys_menu` */

DROP TABLE IF EXISTS `t_sys_menu`;

CREATE TABLE `t_sys_menu` (
  `SYS_MENU_ID` int(11) NOT NULL COMMENT 'id',
  `MENU_DISPLAY_NAME` varchar(128) DEFAULT NULL COMMENT '菜单名称',
  `MENU_HREF` varchar(128) DEFAULT NULL COMMENT '链接',
  `MENU_PARENT_ID` int(11) DEFAULT NULL COMMENT '父节点Id',
  `IS_LEAF` int(11) DEFAULT NULL COMMENT '是否叶子节点 0：不是 1：是',
  `ICON_CLASS` varchar(32) DEFAULT NULL COMMENT '图标css样式',
  PRIMARY KEY (`SYS_MENU_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

/*Data for the table `t_sys_menu` */

insert  into `t_sys_menu`(`SYS_MENU_ID`,`MENU_DISPLAY_NAME`,`MENU_HREF`,`MENU_PARENT_ID`,`IS_LEAF`,`ICON_CLASS`) values (1000000,'系统管理',NULL,0,0,'system'),(1010000,'代号管理','../codeManager/codeManagement.jsp',1000000,1,NULL),(1020000,'-',NULL,1000000,1,NULL),(1030000,'ftp路径管理','../filePathManager/filePathManagement.jsp',1000000,1,NULL),(1040000,'-',NULL,1000000,1,NULL),(1050000,'联系人管理','../contactManager/contactManagement.jsp',1000000,1,NULL),(1060000,'用户管理','../systemManager/userManagement.jsp',1000000,1,NULL),(1070000,'角色管理','../systemManager/authRegionManage.jsp',1000000,1,NULL),(2000000,'跨境电商',NULL,0,0,'goods'),(2010000,'商品备案','../skuManager/SKU.menu',2000000,1,NULL),(2020000,'-',NULL,2000000,1,NULL),(2030000,'电子订单','../orderManager/ORDER.menu',2000000,1,NULL),(2040000,'-',NULL,2000000,1,NULL),(2050000,'支付凭证','DISABLED',2000000,1,NULL),(2060000,'-',NULL,2000000,1,NULL),(2070000,'物流运单','../logisticsManager/LOGISTICS.menu',2000000,1,NULL),(2080000,'-',NULL,2000000,1,NULL),(2090000,'出境清单','../inventoryManager/INVENTORY.menu',2000000,1,NULL),(3000000,'苏宁',NULL,0,0,'suning'),(3010000,'物流运单','../logisticsManager/suning/LOGISTICS.menu',3000000,1,NULL),(4000000,'跨境电商（南京）',NULL,0,0,'goods'),(4010000,'商品备案','../nj_cbb_pf/skuManager/SKU.menu',4000000,1,NULL),(4020000,'电子订单','../nj_cbb_pf/orderManager/ORDER.menu',4000000,1,NULL),(4030000,'物流运单','../nj_cbb_pf/logisticsManager/LOGISTICS.menu',4000000,1,NULL),(4040000,'出境清单','../nj_cbb_pf/inventoryManager/INVENTORY.menu',4000000,1,NULL);

/*Table structure for table `t_sys_role` */

DROP TABLE IF EXISTS `t_sys_role`;

CREATE TABLE `t_sys_role` (
  `SYS_ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(128) DEFAULT NULL COMMENT '角色名',
  `NOTE` varchar(128) DEFAULT NULL COMMENT '备注',
  `IS_DEL` int(11) DEFAULT '0' COMMENT '是否删除 0：不是 1：是',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`SYS_ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `t_sys_role` */

/*Table structure for table `t_sys_role_ref` */

DROP TABLE IF EXISTS `t_sys_role_ref`;

CREATE TABLE `t_sys_role_ref` (
  `SYS_ROLE_REF_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SYS_ROLE_ID` int(11) DEFAULT NULL,
  `SYS_MENU_ID` int(11) DEFAULT NULL COMMENT 'id',
  PRIMARY KEY (`SYS_ROLE_REF_ID`),
  KEY `FK_REFERENCE_13` (`SYS_MENU_ID`),
  KEY `FK_REFERENCE_97` (`SYS_ROLE_ID`),
  CONSTRAINT `FK_REFERENCE_13` FOREIGN KEY (`SYS_MENU_ID`) REFERENCES `t_sys_menu` (`SYS_MENU_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_REFERENCE_97` FOREIGN KEY (`SYS_ROLE_ID`) REFERENCES `t_sys_role` (`SYS_ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与菜单关联表';

/*Data for the table `t_sys_role_ref` */

/*Table structure for table `t_sys_user` */

DROP TABLE IF EXISTS `t_sys_user`;

CREATE TABLE `t_sys_user` (
  `SYS_USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_NAME` varchar(64) DEFAULT NULL COMMENT '姓名',
  `LOGIN_NAME` varchar(128) DEFAULT NULL COMMENT '登录名',
  `PASSWORD` varchar(64) DEFAULT NULL COMMENT '密码',
  `JOB_NUMBER` varchar(64) DEFAULT NULL COMMENT '工号',
  `DEPARTMENT` varchar(64) DEFAULT NULL COMMENT '部门',
  `POSITION` varchar(64) DEFAULT NULL COMMENT '职务',
  `EMAIL` varchar(64) DEFAULT NULL COMMENT '邮箱',
  `TELEPHONE` varchar(16) DEFAULT NULL COMMENT '电话',
  `NOTE` varchar(128) DEFAULT NULL COMMENT '备注',
  `TIME_OUT` int(11) DEFAULT '15' COMMENT '登陆超时时间，单位：分钟',
  `PASSWORD_VALIDITY` varchar(2) DEFAULT NULL,
  `LOGIN_TIME` datetime DEFAULT NULL COMMENT '登陆时间',
  `LOGOUT_TIME` datetime DEFAULT NULL COMMENT '退出时间',
  `IS_DEL` int(11) DEFAULT '0' COMMENT '是否删除 0：不是 1：是',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`SYS_USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `t_sys_user` */

insert  into `t_sys_user`(`SYS_USER_ID`,`USER_NAME`,`LOGIN_NAME`,`PASSWORD`,`JOB_NUMBER`,`DEPARTMENT`,`POSITION`,`EMAIL`,`TELEPHONE`,`NOTE`,`TIME_OUT`,`PASSWORD_VALIDITY`,`LOGIN_TIME`,`LOGOUT_TIME`,`IS_DEL`,`CREATE_TIME`,`UPDATE_TIME`) values (-1,'admin','admin','admin','0000','','','','11111','',999,NULL,NULL,NULL,0,NULL,'2016-02-19 10:35:29'),(1,'张英','zhangy','123456','0001','','','','1111','',30,'0','2014-09-28 11:09:07','2014-09-28 10:38:48',0,'2014-09-28 10:29:24','2014-09-28 11:09:07'),(2,'文博','wenb','924553','0002','','','','1112','',30,'0','2014-09-28 11:15:58','2014-09-28 11:16:04',0,'2014-09-28 10:33:43','2014-09-28 11:16:03'),(3,'贾长洪','jiach','123456','0003','','','','1113','',30,'0','2014-09-28 11:16:21','2014-09-28 11:16:32',0,'2014-09-28 10:36:51','2014-09-28 11:16:32'),(4,'黄倩','huangq','123456','0004',NULL,'','','1114','',30,'0','2014-09-28 11:16:52','2014-09-28 11:16:56',0,'2014-09-28 10:43:58','2015-04-21 08:39:16'),(5,'李明','lim','111111','0005','','','','1115','',30,'0','2014-09-28 11:17:04','2014-09-28 11:17:08',0,'2014-09-28 10:45:24','2016-02-19 10:12:35'),(6,'徐心琮','xuxc','123456','0006','','','','1116','',30,'0','2014-09-28 11:17:25','2014-09-28 11:17:29',0,'2014-09-28 10:46:38','2014-09-28 11:17:29'),(7,'葛鹏','gep','123456','0007','','','','1117','',30,'0','2014-09-28 11:17:36','2014-09-28 11:17:41',0,'2014-09-28 10:47:25','2014-09-28 11:17:41'),(8,'李书峰','lisf','123456','0008','','','','1118','',30,'0','2014-09-28 11:17:48','2014-09-28 11:17:51',0,'2014-09-28 10:48:15','2014-09-28 11:17:51'),(9,'刘敏','lium','123456','0009','','','','1119','',30,'0','2014-09-28 11:19:46','2014-09-28 11:19:50',0,'2014-09-28 10:49:01','2014-09-28 11:19:50'),(10,'范广建','fangj','123456','0010','','','','1120','',30,'0','2014-09-28 11:18:14','2014-09-28 11:18:20',0,'2014-09-28 10:50:03','2014-09-28 11:18:19'),(11,'闫军','yanj','123456','0011','','','','1121','',30,'0','2014-09-28 11:20:00','2014-09-28 11:20:04',0,'2014-09-28 10:50:54','2014-09-28 11:20:04'),(14,'111111','111111','888888',NULL,NULL,NULL,'','1111111','',15,NULL,NULL,NULL,0,'2016-02-23 17:23:12','2016-02-23 17:23:11');

/*Table structure for table `t_sys_user_ref_role` */

DROP TABLE IF EXISTS `t_sys_user_ref_role`;

CREATE TABLE `t_sys_user_ref_role` (
  `SYS_USER_REF_ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SYS_USER_ID` int(11) DEFAULT NULL,
  `SYS_ROLE_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`SYS_USER_REF_ROLE_ID`),
  KEY `FK_REFERENCE_14` (`SYS_USER_ID`),
  KEY `FK_REFERENCE_15` (`SYS_ROLE_ID`),
  CONSTRAINT `FK_REFERENCE_14` FOREIGN KEY (`SYS_USER_ID`) REFERENCES `t_sys_user` (`SYS_USER_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_REFERENCE_15` FOREIGN KEY (`SYS_ROLE_ID`) REFERENCES `t_sys_role` (`SYS_ROLE_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户,角色关联表';

/*Data for the table `t_sys_user_ref_role` */

/* Trigger structure for table `t_nj_orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `TRIGGER_UPDATE_NJ_ORDERNO` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'ftsp'@'localhost' */ /*!50003 TRIGGER `TRIGGER_UPDATE_NJ_ORDERNO` AFTER UPDATE ON `t_nj_orders` FOR EACH ROW BEGIN
    UPDATE 
      T_NJ_ORDER_DETAIL 
    SET
      T_NJ_ORDER_DETAIL.ORDER_NO = NEW.ORDER_NO 
    WHERE NEW.ORDERS_ID = T_NJ_ORDER_DETAIL.ORDERS_ID; 
END */$$


DELIMITER ;

/* Trigger structure for table `t_orders` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `TRIGGER_UPDATE_ORDERNO` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'ftsp'@'localhost' */ /*!50003 TRIGGER `TRIGGER_UPDATE_ORDERNO` AFTER UPDATE ON `t_orders` FOR EACH ROW BEGIN
    UPDATE 
      T_ORDER_DETAIL 
    SET
      T_ORDER_DETAIL.ORDER_NO = NEW.ORDER_NO 
    WHERE NEW.ORDERS_ID = T_ORDER_DETAIL.ORDERS_ID; 
END */$$


DELIMITER ;

/*Table structure for table `v_inventory` */

DROP TABLE IF EXISTS `v_inventory`;

/*!50001 DROP VIEW IF EXISTS `v_inventory` */;
/*!50001 DROP TABLE IF EXISTS `v_inventory` */;

/*!50001 CREATE TABLE  `v_inventory`(
 `INVENTORY_ID` int(11) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `COP_NO` varchar(20) ,
 `PRE_NO` varchar(18) ,
 `LOGISTICS_NO` varchar(20) ,
 `INVT_NO` varchar(18) ,
 `PORT_CODE` varchar(4) ,
 `IE_DATE` datetime ,
 `OWNER_CODE` varchar(10) ,
 `OWNER_NAME` varchar(128) ,
 `TRADE_MODE` varchar(4) ,
 `LOCT_NO` varchar(10) ,
 `LICENSE_NO` varchar(19) ,
 `COUNTRY` varchar(3) ,
 `DESTINATION_PORT` varchar(4) ,
 `FREIGHT` decimal(19,5) ,
 `FREIGHT_CURR` varchar(3) ,
 `FREIGHT_MARK` int(11) ,
 `INSURE_FEE` decimal(19,5) ,
 `INSURE_FEE_CURR` varchar(3) ,
 `INSURE_FEE_MARK` int(11) ,
 `WRAP_TYPE` varchar(1) ,
 `PACK_NO` int(11) ,
 `WEIGHT` decimal(19,5) ,
 `NET_WEIGHT` decimal(19,5) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp ,
 `LOGISTICS_CODE` varchar(10) ,
 `IE_FLAG` varchar(1) ,
 `TRAF_MODE` varchar(1) ,
 `SHIP_NAME` varchar(100) ,
 `VOYAGE_NO` varchar(32) ,
 `BILL_NO` varchar(37) ,
 `ORDER_NO` varchar(30) ,
 `EBP_CODE` varchar(64) ,
 `EBC_CODE` varchar(64) ,
 `AGENT_CODE` varchar(64) ,
 `CONSIGNEE_COUNTRY` varchar(3) 
)*/;

/*Table structure for table `v_inventory_detail` */

DROP TABLE IF EXISTS `v_inventory_detail`;

/*!50001 DROP VIEW IF EXISTS `v_inventory_detail` */;
/*!50001 DROP TABLE IF EXISTS `v_inventory_detail` */;

/*!50001 CREATE TABLE  `v_inventory_detail`(
 `INVENTORY_DETAIL_ID` int(11) ,
 `INVENTORY_ID` int(11) ,
 `GNUM` int(11) ,
 `UNIT_I` varchar(3) ,
 `UNIT1_I` varchar(3) ,
 `UNIT2_I` varchar(3) ,
 `QTY` decimal(19,5) ,
 `QTY1` decimal(19,5) ,
 `QTY2` decimal(19,5) ,
 `ONE_PRICE` decimal(19,5) ,
 `TOTAL` decimal(19,5) ,
 `SKU_ID` int(11) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `PRE_NO` varchar(18) ,
 `EBP_CODE` varchar(64) ,
 `EBP_NAME` varchar(128) ,
 `EBC_CODE` varchar(64) ,
 `EBC_NAME` varchar(128) ,
 `AGENT_CODE` varchar(64) ,
 `AGENT_NAME` varchar(128) ,
 `CLASSIFY_CODE` varchar(64) ,
 `CLASSIFY_NAME` varchar(128) ,
 `ITEM_NO` varchar(20) ,
 `ITEM_NAME` varchar(250) ,
 `G_NO` varchar(18) ,
 `G_CODE` varchar(10) ,
 `G_NAME` varchar(250) ,
 `G_MODEL` varchar(250) ,
 `BAR_CODE` varchar(13) ,
 `BRAND` varchar(100) ,
 `TAX_CODE` varchar(8) ,
 `UNIT` varchar(3) ,
 `UNIT1` varchar(3) ,
 `UNIT2` varchar(3) ,
 `PRICE` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `GIFT_FLAG` int(11) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*Table structure for table `v_logistics_unuse` */

DROP TABLE IF EXISTS `v_logistics_unuse`;

/*!50001 DROP VIEW IF EXISTS `v_logistics_unuse` */;
/*!50001 DROP TABLE IF EXISTS `v_logistics_unuse` */;

/*!50001 CREATE TABLE  `v_logistics_unuse`(
 `LOGISTICS_ID` int(11) ,
 `ORDER_NO` varchar(30) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `LOGISTICS_CODE` varchar(10) ,
 `LOGISTICS_NAME` varchar(128) ,
 `LOGISTICS_NO` varchar(20) ,
 `LOGISTICS_STATUS` varchar(1) ,
 `IE_FLAG` varchar(1) ,
 `TRAF_MODE` varchar(1) ,
 `SHIP_NAME` varchar(100) ,
 `VOYAGE_NO` varchar(32) ,
 `BILL_NO` varchar(37) ,
 `FREIGHT` decimal(19,5) ,
 `INSURE_FEE` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `WEIGHT` decimal(19,5) ,
 `NET_WEIGHT` decimal(19,5) ,
 `PACK_NO` int(11) ,
 `PARCEL_INFO` varchar(200) ,
 `GOODS_INFO` varchar(200) ,
 `CONSIGNEE` varchar(100) ,
 `CONSIGNEE_ADDRESS` varchar(512) ,
 `CONSIGNEE_TELEPHONE` varchar(50) ,
 `CONSIGNEE_COUNTRY` varchar(3) ,
 `SHIPPER` varchar(100) ,
 `SHIPPER_ADDRESS` varchar(200) ,
 `SHIPPER_TELEPHONE` varchar(50) ,
 `SHIPPER_COUNTRY` varchar(3) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*Table structure for table `v_nj_inventory` */

DROP TABLE IF EXISTS `v_nj_inventory`;

/*!50001 DROP VIEW IF EXISTS `v_nj_inventory` */;
/*!50001 DROP TABLE IF EXISTS `v_nj_inventory` */;

/*!50001 CREATE TABLE  `v_nj_inventory`(
 `INVENTORY_ID` int(11) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `RECEIVER_ID` varchar(4) ,
 `CHK_CUSTOM_CODE` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `COP_NO` varchar(20) ,
 `PRE_NO` varchar(18) ,
 `LOGISTICS_NO` varchar(20) ,
 `INVT_NO` varchar(18) ,
 `PORT_CODE` varchar(4) ,
 `IE_DATE` datetime ,
 `OWNER_CODE` varchar(10) ,
 `OWNER_NAME` varchar(128) ,
 `TRADE_MODE` varchar(4) ,
 `LOCT_NO` varchar(10) ,
 `LICENSE_NO` varchar(19) ,
 `COUNTRY` varchar(3) ,
 `GOODS_VALUE` decimal(19,5) ,
 `GOODS_CURRENCY` varchar(3) ,
 `TAX_FEE` decimal(19,5) ,
 `DESTINATION_PORT` varchar(5) ,
 `FREIGHT` decimal(19,5) ,
 `FREIGHT_CURR` varchar(3) ,
 `FREIGHT_MARK` int(11) ,
 `INSURE_FEE` decimal(19,5) ,
 `INSURE_FEE_CURR` varchar(3) ,
 `INSURE_FEE_MARK` int(11) ,
 `WRAP_TYPE` varchar(1) ,
 `PACK_NO` int(11) ,
 `WEIGHT` decimal(19,5) ,
 `NET_WEIGHT` decimal(19,5) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp ,
 `VERSION` varchar(16) ,
 `LOGISTICS_CODE` varchar(10) ,
 `IE_FLAG` varchar(1) ,
 `TRAF_MODE` varchar(1) ,
 `VOYAGE_NO` varchar(32) ,
 `BILL_NO` varchar(37) ,
 `TRAF_NAME` varchar(100) ,
 `ORDER_NO` varchar(30) ,
 `EBP_CODE` varchar(64) ,
 `EBC_CODE` varchar(64) ,
 `AGENT_CODE` varchar(64) 
)*/;

/*Table structure for table `v_nj_inventory_detail` */

DROP TABLE IF EXISTS `v_nj_inventory_detail`;

/*!50001 DROP VIEW IF EXISTS `v_nj_inventory_detail` */;
/*!50001 DROP TABLE IF EXISTS `v_nj_inventory_detail` */;

/*!50001 CREATE TABLE  `v_nj_inventory_detail`(
 `INVENTORY_DETAIL_ID` int(11) ,
 `INVENTORY_ID` int(11) ,
 `GNUM` int(11) ,
 `UNIT_I` varchar(3) ,
 `UNIT1_I` varchar(3) ,
 `UNIT2_I` varchar(3) ,
 `QTY` decimal(19,5) ,
 `QTY1` decimal(19,5) ,
 `QTY2` decimal(19,5) ,
 `ONE_PRICE` decimal(19,5) ,
 `TOTAL` decimal(19,5) ,
 `SKU_ID` int(11) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `RECEIVER_ID` varchar(4) ,
 `BIZ_TYPE` int(11) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `PRE_NO` varchar(50) ,
 `EBP_CODE` varchar(64) ,
 `EBP_NAME` varchar(128) ,
 `EBC_CODE` varchar(64) ,
 `EBC_NAME` varchar(128) ,
 `AGENT_CODE` varchar(64) ,
 `AGENT_NAME` varchar(128) ,
 `CLASSIFY_CODE` varchar(64) ,
 `CLASSIFY_NAME` varchar(128) ,
 `ITEM_NO` varchar(20) ,
 `ITEM_NAME` varchar(250) ,
 `G_NO` varchar(20) ,
 `G_CODE` varchar(10) ,
 `G_NAME` varchar(250) ,
 `G_MODEL` varchar(250) ,
 `BAR_CODE` varchar(13) ,
 `BRAND` varchar(100) ,
 `TAX_CODE` varchar(8) ,
 `TAX_RATE` decimal(19,5) ,
 `UNIT` varchar(3) ,
 `UNIT1` varchar(3) ,
 `UNIT2` varchar(3) ,
 `PRICE` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `COUNTRY` varchar(3) ,
 `GIFT_FLAG` int(11) ,
 `NOTE` varchar(1000) ,
 `VERSION` varchar(16) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*Table structure for table `v_nj_logistics` */

DROP TABLE IF EXISTS `v_nj_logistics`;

/*!50001 DROP VIEW IF EXISTS `v_nj_logistics` */;
/*!50001 DROP TABLE IF EXISTS `v_nj_logistics` */;

/*!50001 CREATE TABLE  `v_nj_logistics`(
 `LOGISTICS_ID` int(11) ,
 `ORDER_NO` varchar(30) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `RECEIVER_ID` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `LOGISTICS_CODE` varchar(10) ,
 `LOGISTICS_NAME` varchar(128) ,
 `LOGISTICS_NO` varchar(20) ,
 `LOGISTICS_STATUS` varchar(1) ,
 `IE_FLAG` varchar(1) ,
 `TRAF_MODE` varchar(1) ,
 `TRAF_NAME` varchar(100) ,
 `VOYAGE_NO` varchar(32) ,
 `BILL_NO` varchar(37) ,
 `FREIGHT` decimal(19,5) ,
 `INSURE_FEE` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `WEIGHT` decimal(19,5) ,
 `NET_WEIGHT` decimal(19,5) ,
 `PACK_NO` int(11) ,
 `PARCEL_INFO` varchar(200) ,
 `GOODS_INFO` varchar(200) ,
 `CONSIGNEE_ID` int(11) ,
 `SHIPPER_ID` int(11) ,
 `LOGISTICS_HEAD_NO` varchar(20) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp ,
 `VERSION` varchar(16) ,
 `INVENTORY_APP_STATUS` int(11) 
)*/;

/*Table structure for table `v_nj_logistics_unuse` */

DROP TABLE IF EXISTS `v_nj_logistics_unuse`;

/*!50001 DROP VIEW IF EXISTS `v_nj_logistics_unuse` */;
/*!50001 DROP TABLE IF EXISTS `v_nj_logistics_unuse` */;

/*!50001 CREATE TABLE  `v_nj_logistics_unuse`(
 `LOGISTICS_ID` int(11) ,
 `ORDER_NO` varchar(30) ,
 `GUID` varchar(64) ,
 `CUSTOM_CODE` varchar(4) ,
 `RECEIVER_ID` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `LOGISTICS_CODE` varchar(10) ,
 `LOGISTICS_NAME` varchar(128) ,
 `LOGISTICS_NO` varchar(20) ,
 `LOGISTICS_STATUS` varchar(1) ,
 `IE_FLAG` varchar(1) ,
 `TRAF_MODE` varchar(1) ,
 `TRAF_NAME` varchar(100) ,
 `VOYAGE_NO` varchar(32) ,
 `BILL_NO` varchar(37) ,
 `FREIGHT` decimal(19,5) ,
 `INSURE_FEE` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `WEIGHT` decimal(19,5) ,
 `NET_WEIGHT` decimal(19,5) ,
 `PACK_NO` int(11) ,
 `PARCEL_INFO` varchar(200) ,
 `GOODS_INFO` varchar(200) ,
 `CONSIGNEE_ID` int(11) ,
 `SHIPPER_ID` int(11) ,
 `LOGISTICS_HEAD_NO` varchar(20) ,
 `IS_AUTO` int(11) ,
 `NOTE` varchar(1000) ,
 `VERSION` varchar(16) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*Table structure for table `v_nj_orders_unuse` */

DROP TABLE IF EXISTS `v_nj_orders_unuse`;

/*!50001 DROP VIEW IF EXISTS `v_nj_orders_unuse` */;
/*!50001 DROP TABLE IF EXISTS `v_nj_orders_unuse` */;

/*!50001 CREATE TABLE  `v_nj_orders_unuse`(
 `ORDERS_ID` int(11) ,
 `GUID` varchar(64) ,
 `ORDER_NO` varchar(30) ,
 `CUSTOM_CODE` varchar(4) ,
 `RECEIVER_ID` varchar(4) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `ORDER_TYPE` int(11) ,
 `EBP_CODE` varchar(64) ,
 `EBP_NAME` varchar(128) ,
 `EBC_CODE` varchar(64) ,
 `EBC_NAME` varchar(128) ,
 `AGENT_CODE` varchar(64) ,
 `AGENT_NAME` varchar(128) ,
 `GOODS_VALUE` decimal(19,5) ,
 `FREIGHT` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `TAX_FEE` decimal(19,5) ,
 `CONSIGNEE_ID` int(11) ,
 `UNDER_THE_SINGER_ID` int(11) ,
 `LOGISTICS_CODE` varchar(10) ,
 `LOGISTICS_NAME` varchar(128) ,
 `LOGISTICS_NO` varchar(20) ,
 `NOTE` varchar(1000) ,
 `VERSION` varchar(16) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*Table structure for table `v_orders_unuse` */

DROP TABLE IF EXISTS `v_orders_unuse`;

/*!50001 DROP VIEW IF EXISTS `v_orders_unuse` */;
/*!50001 DROP TABLE IF EXISTS `v_orders_unuse` */;

/*!50001 CREATE TABLE  `v_orders_unuse`(
 `ORDERS_ID` int(11) ,
 `GUID` varchar(64) ,
 `ORDER_NO` varchar(30) ,
 `APP_TYPE` int(11) ,
 `APP_TIME` varchar(64) ,
 `APP_STATUS` int(11) ,
 `APP_UID` varchar(64) ,
 `APP_UNAME` varchar(128) ,
 `ORDER_TYPE` varchar(1) ,
 `EBP_CODE` varchar(64) ,
 `EBP_NAME` varchar(128) ,
 `EBC_CODE` varchar(64) ,
 `EBC_NAME` varchar(128) ,
 `AGENT_CODE` varchar(64) ,
 `AGENT_NAME` varchar(128) ,
 `GOODS_VALUE` decimal(19,5) ,
 `FREIGHT` decimal(19,5) ,
 `CURRENCY` varchar(3) ,
 `CONSIGNEE` varchar(100) ,
 `CONSIGNEE_ADDRESS` varchar(512) ,
 `CONSIGNEE_TELEPHONE` varchar(50) ,
 `CONSIGNEE_COUNTRY` varchar(3) ,
 `NOTE` varchar(1000) ,
 `RETURN_STATUS` int(11) ,
 `RETURN_TIME` varchar(64) ,
 `RETURN_INFO` varchar(1000) ,
 `CREAT_TIME` datetime ,
 `UPDATE_TIME` timestamp 
)*/;

/*View structure for view v_inventory */

/*!50001 DROP TABLE IF EXISTS `v_inventory` */;
/*!50001 DROP VIEW IF EXISTS `v_inventory` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory` AS select `i`.`INVENTORY_ID` AS `INVENTORY_ID`,`i`.`GUID` AS `GUID`,`i`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`i`.`APP_TYPE` AS `APP_TYPE`,`i`.`APP_TIME` AS `APP_TIME`,`i`.`APP_STATUS` AS `APP_STATUS`,`i`.`APP_UID` AS `APP_UID`,`i`.`APP_UNAME` AS `APP_UNAME`,`i`.`COP_NO` AS `COP_NO`,`i`.`PRE_NO` AS `PRE_NO`,`i`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`i`.`INVT_NO` AS `INVT_NO`,`i`.`PORT_CODE` AS `PORT_CODE`,`i`.`IE_DATE` AS `IE_DATE`,`i`.`OWNER_CODE` AS `OWNER_CODE`,`i`.`OWNER_NAME` AS `OWNER_NAME`,`i`.`TRADE_MODE` AS `TRADE_MODE`,`i`.`LOCT_NO` AS `LOCT_NO`,`i`.`LICENSE_NO` AS `LICENSE_NO`,`i`.`COUNTRY` AS `COUNTRY`,`i`.`DESTINATION_PORT` AS `DESTINATION_PORT`,`i`.`FREIGHT` AS `FREIGHT`,`i`.`FREIGHT_CURR` AS `FREIGHT_CURR`,`i`.`FREIGHT_MARK` AS `FREIGHT_MARK`,`i`.`INSURE_FEE` AS `INSURE_FEE`,`i`.`INSURE_FEE_CURR` AS `INSURE_FEE_CURR`,`i`.`INSURE_FEE_MARK` AS `INSURE_FEE_MARK`,`i`.`WRAP_TYPE` AS `WRAP_TYPE`,`i`.`PACK_NO` AS `PACK_NO`,`i`.`WEIGHT` AS `WEIGHT`,`i`.`NET_WEIGHT` AS `NET_WEIGHT`,`i`.`NOTE` AS `NOTE`,`i`.`RETURN_STATUS` AS `RETURN_STATUS`,`i`.`RETURN_TIME` AS `RETURN_TIME`,`i`.`RETURN_INFO` AS `RETURN_INFO`,`i`.`CREAT_TIME` AS `CREAT_TIME`,`i`.`UPDATE_TIME` AS `UPDATE_TIME`,`l`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`l`.`IE_FLAG` AS `IE_FLAG`,`l`.`TRAF_MODE` AS `TRAF_MODE`,`l`.`SHIP_NAME` AS `SHIP_NAME`,`l`.`VOYAGE_NO` AS `VOYAGE_NO`,`l`.`BILL_NO` AS `BILL_NO`,`o`.`ORDER_NO` AS `ORDER_NO`,`o`.`EBP_CODE` AS `EBP_CODE`,`o`.`EBC_CODE` AS `EBC_CODE`,`o`.`AGENT_CODE` AS `AGENT_CODE`,`o`.`CONSIGNEE_COUNTRY` AS `CONSIGNEE_COUNTRY` from ((`t_inventory` `i` left join `t_logistics` `l` on((`l`.`LOGISTICS_NO` = `i`.`LOGISTICS_NO`))) left join `t_orders` `o` on((`l`.`ORDER_NO` = `o`.`ORDER_NO`))) */;

/*View structure for view v_inventory_detail */

/*!50001 DROP TABLE IF EXISTS `v_inventory_detail` */;
/*!50001 DROP VIEW IF EXISTS `v_inventory_detail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory_detail` AS select `id`.`INVENTORY_DETAIL_ID` AS `INVENTORY_DETAIL_ID`,`id`.`INVENTORY_ID` AS `INVENTORY_ID`,`id`.`GNUM` AS `GNUM`,`id`.`UNIT` AS `UNIT_I`,`id`.`UNIT1` AS `UNIT1_I`,`id`.`UNIT2` AS `UNIT2_I`,`id`.`QTY` AS `QTY`,`id`.`QTY1` AS `QTY1`,`id`.`QTY2` AS `QTY2`,`id`.`PRICE` AS `ONE_PRICE`,`id`.`TOTAL` AS `TOTAL`,`s`.`SKU_ID` AS `SKU_ID`,`s`.`GUID` AS `GUID`,`s`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`s`.`APP_TYPE` AS `APP_TYPE`,`s`.`APP_TIME` AS `APP_TIME`,`s`.`APP_STATUS` AS `APP_STATUS`,`s`.`APP_UID` AS `APP_UID`,`s`.`APP_UNAME` AS `APP_UNAME`,`s`.`PRE_NO` AS `PRE_NO`,`s`.`EBP_CODE` AS `EBP_CODE`,`s`.`EBP_NAME` AS `EBP_NAME`,`s`.`EBC_CODE` AS `EBC_CODE`,`s`.`EBC_NAME` AS `EBC_NAME`,`s`.`AGENT_CODE` AS `AGENT_CODE`,`s`.`AGENT_NAME` AS `AGENT_NAME`,`s`.`CLASSIFY_CODE` AS `CLASSIFY_CODE`,`s`.`CLASSIFY_NAME` AS `CLASSIFY_NAME`,`s`.`ITEM_NO` AS `ITEM_NO`,`s`.`ITEM_NAME` AS `ITEM_NAME`,`s`.`G_NO` AS `G_NO`,`s`.`G_CODE` AS `G_CODE`,`s`.`G_NAME` AS `G_NAME`,`s`.`G_MODEL` AS `G_MODEL`,`s`.`BAR_CODE` AS `BAR_CODE`,`s`.`BRAND` AS `BRAND`,`s`.`TAX_CODE` AS `TAX_CODE`,`s`.`UNIT` AS `UNIT`,`s`.`UNIT1` AS `UNIT1`,`s`.`UNIT2` AS `UNIT2`,`s`.`PRICE` AS `PRICE`,`s`.`CURRENCY` AS `CURRENCY`,`s`.`GIFT_FLAG` AS `GIFT_FLAG`,`s`.`NOTE` AS `NOTE`,`s`.`RETURN_STATUS` AS `RETURN_STATUS`,`s`.`RETURN_TIME` AS `RETURN_TIME`,`s`.`RETURN_INFO` AS `RETURN_INFO`,`s`.`CREAT_TIME` AS `CREAT_TIME`,`s`.`UPDATE_TIME` AS `UPDATE_TIME` from (`t_inventory_detail` `id` left join `t_sku` `s` on((`id`.`ITEM_NO` = `s`.`ITEM_NO`))) */;

/*View structure for view v_logistics_unuse */

/*!50001 DROP TABLE IF EXISTS `v_logistics_unuse` */;
/*!50001 DROP VIEW IF EXISTS `v_logistics_unuse` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_logistics_unuse` AS select `l`.`LOGISTICS_ID` AS `LOGISTICS_ID`,`l`.`ORDER_NO` AS `ORDER_NO`,`l`.`GUID` AS `GUID`,`l`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`l`.`APP_TYPE` AS `APP_TYPE`,`l`.`APP_TIME` AS `APP_TIME`,`l`.`APP_STATUS` AS `APP_STATUS`,`l`.`APP_UID` AS `APP_UID`,`l`.`APP_UNAME` AS `APP_UNAME`,`l`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`l`.`LOGISTICS_NAME` AS `LOGISTICS_NAME`,`l`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`l`.`LOGISTICS_STATUS` AS `LOGISTICS_STATUS`,`l`.`IE_FLAG` AS `IE_FLAG`,`l`.`TRAF_MODE` AS `TRAF_MODE`,`l`.`SHIP_NAME` AS `SHIP_NAME`,`l`.`VOYAGE_NO` AS `VOYAGE_NO`,`l`.`BILL_NO` AS `BILL_NO`,`l`.`FREIGHT` AS `FREIGHT`,`l`.`INSURE_FEE` AS `INSURE_FEE`,`l`.`CURRENCY` AS `CURRENCY`,`l`.`WEIGHT` AS `WEIGHT`,`l`.`NET_WEIGHT` AS `NET_WEIGHT`,`l`.`PACK_NO` AS `PACK_NO`,`l`.`PARCEL_INFO` AS `PARCEL_INFO`,`l`.`GOODS_INFO` AS `GOODS_INFO`,`l`.`CONSIGNEE` AS `CONSIGNEE`,`l`.`CONSIGNEE_ADDRESS` AS `CONSIGNEE_ADDRESS`,`l`.`CONSIGNEE_TELEPHONE` AS `CONSIGNEE_TELEPHONE`,`l`.`CONSIGNEE_COUNTRY` AS `CONSIGNEE_COUNTRY`,`l`.`SHIPPER` AS `SHIPPER`,`l`.`SHIPPER_ADDRESS` AS `SHIPPER_ADDRESS`,`l`.`SHIPPER_TELEPHONE` AS `SHIPPER_TELEPHONE`,`l`.`SHIPPER_COUNTRY` AS `SHIPPER_COUNTRY`,`l`.`NOTE` AS `NOTE`,`l`.`RETURN_STATUS` AS `RETURN_STATUS`,`l`.`RETURN_TIME` AS `RETURN_TIME`,`l`.`RETURN_INFO` AS `RETURN_INFO`,`l`.`CREAT_TIME` AS `CREAT_TIME`,`l`.`UPDATE_TIME` AS `UPDATE_TIME` from (`t_logistics` `l` left join `t_inventory` `i` on((`l`.`LOGISTICS_NO` = `i`.`LOGISTICS_NO`))) where isnull(`i`.`LOGISTICS_NO`) */;

/*View structure for view v_nj_inventory */

/*!50001 DROP TABLE IF EXISTS `v_nj_inventory` */;
/*!50001 DROP VIEW IF EXISTS `v_nj_inventory` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_nj_inventory` AS select `i`.`INVENTORY_ID` AS `INVENTORY_ID`,`i`.`GUID` AS `GUID`,`i`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`i`.`RECEIVER_ID` AS `RECEIVER_ID`,`i`.`CHK_CUSTOM_CODE` AS `CHK_CUSTOM_CODE`,`i`.`APP_TYPE` AS `APP_TYPE`,`i`.`APP_TIME` AS `APP_TIME`,`i`.`APP_STATUS` AS `APP_STATUS`,`i`.`APP_UID` AS `APP_UID`,`i`.`APP_UNAME` AS `APP_UNAME`,`i`.`COP_NO` AS `COP_NO`,`i`.`PRE_NO` AS `PRE_NO`,`i`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`i`.`INVT_NO` AS `INVT_NO`,`i`.`PORT_CODE` AS `PORT_CODE`,`i`.`IE_DATE` AS `IE_DATE`,`i`.`OWNER_CODE` AS `OWNER_CODE`,`i`.`OWNER_NAME` AS `OWNER_NAME`,`i`.`TRADE_MODE` AS `TRADE_MODE`,`i`.`LOCT_NO` AS `LOCT_NO`,`i`.`LICENSE_NO` AS `LICENSE_NO`,`i`.`COUNTRY` AS `COUNTRY`,`i`.`GOODS_VALUE` AS `GOODS_VALUE`,`i`.`GOODS_CURRENCY` AS `GOODS_CURRENCY`,`i`.`TAX_FEE` AS `TAX_FEE`,`i`.`DESTINATION_PORT` AS `DESTINATION_PORT`,`i`.`FREIGHT` AS `FREIGHT`,`i`.`FREIGHT_CURR` AS `FREIGHT_CURR`,`i`.`FREIGHT_MARK` AS `FREIGHT_MARK`,`i`.`INSURE_FEE` AS `INSURE_FEE`,`i`.`INSURE_FEE_CURR` AS `INSURE_FEE_CURR`,`i`.`INSURE_FEE_MARK` AS `INSURE_FEE_MARK`,`i`.`WRAP_TYPE` AS `WRAP_TYPE`,`i`.`PACK_NO` AS `PACK_NO`,`i`.`WEIGHT` AS `WEIGHT`,`i`.`NET_WEIGHT` AS `NET_WEIGHT`,`i`.`NOTE` AS `NOTE`,`i`.`RETURN_STATUS` AS `RETURN_STATUS`,`i`.`RETURN_TIME` AS `RETURN_TIME`,`i`.`RETURN_INFO` AS `RETURN_INFO`,`i`.`CREAT_TIME` AS `CREAT_TIME`,`i`.`UPDATE_TIME` AS `UPDATE_TIME`,`i`.`VERSION` AS `VERSION`,`l`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`l`.`IE_FLAG` AS `IE_FLAG`,`l`.`TRAF_MODE` AS `TRAF_MODE`,`l`.`VOYAGE_NO` AS `VOYAGE_NO`,`l`.`BILL_NO` AS `BILL_NO`,`l`.`TRAF_NAME` AS `TRAF_NAME`,`o`.`ORDER_NO` AS `ORDER_NO`,`o`.`EBP_CODE` AS `EBP_CODE`,`o`.`EBC_CODE` AS `EBC_CODE`,`o`.`AGENT_CODE` AS `AGENT_CODE` from ((`t_nj_inventory` `i` left join `t_nj_logistics` `l` on((`l`.`LOGISTICS_NO` = `i`.`LOGISTICS_NO`))) left join `t_nj_orders` `o` on((`l`.`ORDER_NO` = `o`.`ORDER_NO`))) */;

/*View structure for view v_nj_inventory_detail */

/*!50001 DROP TABLE IF EXISTS `v_nj_inventory_detail` */;
/*!50001 DROP VIEW IF EXISTS `v_nj_inventory_detail` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_nj_inventory_detail` AS select `id`.`INVENTORY_DETAIL_ID` AS `INVENTORY_DETAIL_ID`,`id`.`INVENTORY_ID` AS `INVENTORY_ID`,`id`.`GNUM` AS `GNUM`,`id`.`UNIT` AS `UNIT_I`,`id`.`UNIT1` AS `UNIT1_I`,`id`.`UNIT2` AS `UNIT2_I`,`id`.`QTY` AS `QTY`,`id`.`QTY1` AS `QTY1`,`id`.`QTY2` AS `QTY2`,`id`.`PRICE` AS `ONE_PRICE`,`id`.`TOTAL` AS `TOTAL`,`s`.`SKU_ID` AS `SKU_ID`,`s`.`GUID` AS `GUID`,`s`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`s`.`RECEIVER_ID` AS `RECEIVER_ID`,`s`.`BIZ_TYPE` AS `BIZ_TYPE`,`s`.`APP_TYPE` AS `APP_TYPE`,`s`.`APP_TIME` AS `APP_TIME`,`s`.`APP_STATUS` AS `APP_STATUS`,`s`.`APP_UID` AS `APP_UID`,`s`.`APP_UNAME` AS `APP_UNAME`,`s`.`PRE_NO` AS `PRE_NO`,`s`.`EBP_CODE` AS `EBP_CODE`,`s`.`EBP_NAME` AS `EBP_NAME`,`s`.`EBC_CODE` AS `EBC_CODE`,`s`.`EBC_NAME` AS `EBC_NAME`,`s`.`AGENT_CODE` AS `AGENT_CODE`,`s`.`AGENT_NAME` AS `AGENT_NAME`,`s`.`CLASSIFY_CODE` AS `CLASSIFY_CODE`,`s`.`CLASSIFY_NAME` AS `CLASSIFY_NAME`,`s`.`ITEM_NO` AS `ITEM_NO`,`s`.`ITEM_NAME` AS `ITEM_NAME`,`s`.`G_NO` AS `G_NO`,`s`.`G_CODE` AS `G_CODE`,`s`.`G_NAME` AS `G_NAME`,`s`.`G_MODEL` AS `G_MODEL`,`s`.`BAR_CODE` AS `BAR_CODE`,`s`.`BRAND` AS `BRAND`,`s`.`TAX_CODE` AS `TAX_CODE`,`s`.`TAX_RATE` AS `TAX_RATE`,`s`.`UNIT` AS `UNIT`,`s`.`UNIT1` AS `UNIT1`,`s`.`UNIT2` AS `UNIT2`,`s`.`PRICE` AS `PRICE`,`s`.`CURRENCY` AS `CURRENCY`,`s`.`COUNTRY` AS `COUNTRY`,`s`.`GIFT_FLAG` AS `GIFT_FLAG`,`s`.`NOTE` AS `NOTE`,`s`.`VERSION` AS `VERSION`,`s`.`RETURN_STATUS` AS `RETURN_STATUS`,`s`.`RETURN_TIME` AS `RETURN_TIME`,`s`.`RETURN_INFO` AS `RETURN_INFO`,`s`.`CREAT_TIME` AS `CREAT_TIME`,`s`.`UPDATE_TIME` AS `UPDATE_TIME` from ((((`t_nj_inventory_detail` `id` left join `t_nj_inventory` `inventory` on((`inventory`.`INVENTORY_ID` = `id`.`INVENTORY_ID`))) left join `t_nj_logistics` `logistics` on((`logistics`.`LOGISTICS_NO` = `inventory`.`LOGISTICS_NO`))) left join `t_nj_orders` `orders` on((`orders`.`ORDER_NO` = `logistics`.`ORDER_NO`))) left join `t_nj_sku` `s` on(((`id`.`ITEM_NO` = `s`.`ITEM_NO`) and (`orders`.`ORDER_TYPE` = `s`.`BIZ_TYPE`)))) */;

/*View structure for view v_nj_logistics */

/*!50001 DROP TABLE IF EXISTS `v_nj_logistics` */;
/*!50001 DROP VIEW IF EXISTS `v_nj_logistics` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_nj_logistics` AS select `l`.`LOGISTICS_ID` AS `LOGISTICS_ID`,`l`.`ORDER_NO` AS `ORDER_NO`,`l`.`GUID` AS `GUID`,`l`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`l`.`RECEIVER_ID` AS `RECEIVER_ID`,`l`.`APP_TYPE` AS `APP_TYPE`,`l`.`APP_TIME` AS `APP_TIME`,`l`.`APP_STATUS` AS `APP_STATUS`,`l`.`APP_UID` AS `APP_UID`,`l`.`APP_UNAME` AS `APP_UNAME`,`l`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`l`.`LOGISTICS_NAME` AS `LOGISTICS_NAME`,`l`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`l`.`LOGISTICS_STATUS` AS `LOGISTICS_STATUS`,`l`.`IE_FLAG` AS `IE_FLAG`,`l`.`TRAF_MODE` AS `TRAF_MODE`,`l`.`TRAF_NAME` AS `TRAF_NAME`,`l`.`VOYAGE_NO` AS `VOYAGE_NO`,`l`.`BILL_NO` AS `BILL_NO`,`l`.`FREIGHT` AS `FREIGHT`,`l`.`INSURE_FEE` AS `INSURE_FEE`,`l`.`CURRENCY` AS `CURRENCY`,`l`.`WEIGHT` AS `WEIGHT`,`l`.`NET_WEIGHT` AS `NET_WEIGHT`,`l`.`PACK_NO` AS `PACK_NO`,`l`.`PARCEL_INFO` AS `PARCEL_INFO`,`l`.`GOODS_INFO` AS `GOODS_INFO`,`l`.`CONSIGNEE_ID` AS `CONSIGNEE_ID`,`l`.`SHIPPER_ID` AS `SHIPPER_ID`,`l`.`LOGISTICS_HEAD_NO` AS `LOGISTICS_HEAD_NO`,`l`.`NOTE` AS `NOTE`,`l`.`RETURN_STATUS` AS `RETURN_STATUS`,`l`.`RETURN_TIME` AS `RETURN_TIME`,`l`.`RETURN_INFO` AS `RETURN_INFO`,`l`.`CREAT_TIME` AS `CREAT_TIME`,`l`.`UPDATE_TIME` AS `UPDATE_TIME`,`l`.`VERSION` AS `VERSION`,`i`.`APP_STATUS` AS `INVENTORY_APP_STATUS` from (`t_nj_logistics` `l` left join `t_nj_inventory` `i` on((`l`.`LOGISTICS_NO` = `i`.`LOGISTICS_NO`))) */;

/*View structure for view v_nj_logistics_unuse */

/*!50001 DROP TABLE IF EXISTS `v_nj_logistics_unuse` */;
/*!50001 DROP VIEW IF EXISTS `v_nj_logistics_unuse` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_nj_logistics_unuse` AS select `l`.`LOGISTICS_ID` AS `LOGISTICS_ID`,`l`.`ORDER_NO` AS `ORDER_NO`,`l`.`GUID` AS `GUID`,`l`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`l`.`RECEIVER_ID` AS `RECEIVER_ID`,`l`.`APP_TYPE` AS `APP_TYPE`,`l`.`APP_TIME` AS `APP_TIME`,`l`.`APP_STATUS` AS `APP_STATUS`,`l`.`APP_UID` AS `APP_UID`,`l`.`APP_UNAME` AS `APP_UNAME`,`l`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`l`.`LOGISTICS_NAME` AS `LOGISTICS_NAME`,`l`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`l`.`LOGISTICS_STATUS` AS `LOGISTICS_STATUS`,`l`.`IE_FLAG` AS `IE_FLAG`,`l`.`TRAF_MODE` AS `TRAF_MODE`,`l`.`TRAF_NAME` AS `TRAF_NAME`,`l`.`VOYAGE_NO` AS `VOYAGE_NO`,`l`.`BILL_NO` AS `BILL_NO`,`l`.`FREIGHT` AS `FREIGHT`,`l`.`INSURE_FEE` AS `INSURE_FEE`,`l`.`CURRENCY` AS `CURRENCY`,`l`.`WEIGHT` AS `WEIGHT`,`l`.`NET_WEIGHT` AS `NET_WEIGHT`,`l`.`PACK_NO` AS `PACK_NO`,`l`.`PARCEL_INFO` AS `PARCEL_INFO`,`l`.`GOODS_INFO` AS `GOODS_INFO`,`l`.`CONSIGNEE_ID` AS `CONSIGNEE_ID`,`l`.`SHIPPER_ID` AS `SHIPPER_ID`,`l`.`LOGISTICS_HEAD_NO` AS `LOGISTICS_HEAD_NO`,`l`.`IS_AUTO` AS `IS_AUTO`,`l`.`NOTE` AS `NOTE`,`l`.`VERSION` AS `VERSION`,`l`.`RETURN_STATUS` AS `RETURN_STATUS`,`l`.`RETURN_TIME` AS `RETURN_TIME`,`l`.`RETURN_INFO` AS `RETURN_INFO`,`l`.`CREAT_TIME` AS `CREAT_TIME`,`l`.`UPDATE_TIME` AS `UPDATE_TIME` from (`t_nj_logistics` `l` left join `t_nj_inventory` `i` on((`l`.`LOGISTICS_NO` = `i`.`LOGISTICS_NO`))) where isnull(`i`.`LOGISTICS_NO`) */;

/*View structure for view v_nj_orders_unuse */

/*!50001 DROP TABLE IF EXISTS `v_nj_orders_unuse` */;
/*!50001 DROP VIEW IF EXISTS `v_nj_orders_unuse` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_nj_orders_unuse` AS select `o`.`ORDERS_ID` AS `ORDERS_ID`,`o`.`GUID` AS `GUID`,`o`.`ORDER_NO` AS `ORDER_NO`,`o`.`CUSTOM_CODE` AS `CUSTOM_CODE`,`o`.`RECEIVER_ID` AS `RECEIVER_ID`,`o`.`APP_TYPE` AS `APP_TYPE`,`o`.`APP_TIME` AS `APP_TIME`,`o`.`APP_STATUS` AS `APP_STATUS`,`o`.`APP_UID` AS `APP_UID`,`o`.`APP_UNAME` AS `APP_UNAME`,`o`.`ORDER_TYPE` AS `ORDER_TYPE`,`o`.`EBP_CODE` AS `EBP_CODE`,`o`.`EBP_NAME` AS `EBP_NAME`,`o`.`EBC_CODE` AS `EBC_CODE`,`o`.`EBC_NAME` AS `EBC_NAME`,`o`.`AGENT_CODE` AS `AGENT_CODE`,`o`.`AGENT_NAME` AS `AGENT_NAME`,`o`.`GOODS_VALUE` AS `GOODS_VALUE`,`o`.`FREIGHT` AS `FREIGHT`,`o`.`CURRENCY` AS `CURRENCY`,`o`.`TAX_FEE` AS `TAX_FEE`,`o`.`CONSIGNEE_ID` AS `CONSIGNEE_ID`,`o`.`UNDER_THE_SINGER_ID` AS `UNDER_THE_SINGER_ID`,`o`.`LOGISTICS_CODE` AS `LOGISTICS_CODE`,`o`.`LOGISTICS_NAME` AS `LOGISTICS_NAME`,`o`.`LOGISTICS_NO` AS `LOGISTICS_NO`,`o`.`NOTE` AS `NOTE`,`o`.`VERSION` AS `VERSION`,`o`.`RETURN_STATUS` AS `RETURN_STATUS`,`o`.`RETURN_TIME` AS `RETURN_TIME`,`o`.`RETURN_INFO` AS `RETURN_INFO`,`o`.`CREAT_TIME` AS `CREAT_TIME`,`o`.`UPDATE_TIME` AS `UPDATE_TIME` from (`t_nj_orders` `o` left join `t_nj_logistics` `l` on((`o`.`ORDER_NO` = `l`.`ORDER_NO`))) where isnull(`l`.`ORDER_NO`) */;

/*View structure for view v_orders_unuse */

/*!50001 DROP TABLE IF EXISTS `v_orders_unuse` */;
/*!50001 DROP VIEW IF EXISTS `v_orders_unuse` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`ftsp`@`localhost` SQL SECURITY DEFINER VIEW `v_orders_unuse` AS select `o`.`ORDERS_ID` AS `ORDERS_ID`,`o`.`GUID` AS `GUID`,`o`.`ORDER_NO` AS `ORDER_NO`,`o`.`APP_TYPE` AS `APP_TYPE`,`o`.`APP_TIME` AS `APP_TIME`,`o`.`APP_STATUS` AS `APP_STATUS`,`o`.`APP_UID` AS `APP_UID`,`o`.`APP_UNAME` AS `APP_UNAME`,`o`.`ORDER_TYPE` AS `ORDER_TYPE`,`o`.`EBP_CODE` AS `EBP_CODE`,`o`.`EBP_NAME` AS `EBP_NAME`,`o`.`EBC_CODE` AS `EBC_CODE`,`o`.`EBC_NAME` AS `EBC_NAME`,`o`.`AGENT_CODE` AS `AGENT_CODE`,`o`.`AGENT_NAME` AS `AGENT_NAME`,`o`.`GOODS_VALUE` AS `GOODS_VALUE`,`o`.`FREIGHT` AS `FREIGHT`,`o`.`CURRENCY` AS `CURRENCY`,`o`.`CONSIGNEE` AS `CONSIGNEE`,`o`.`CONSIGNEE_ADDRESS` AS `CONSIGNEE_ADDRESS`,`o`.`CONSIGNEE_TELEPHONE` AS `CONSIGNEE_TELEPHONE`,`o`.`CONSIGNEE_COUNTRY` AS `CONSIGNEE_COUNTRY`,`o`.`NOTE` AS `NOTE`,`o`.`RETURN_STATUS` AS `RETURN_STATUS`,`o`.`RETURN_TIME` AS `RETURN_TIME`,`o`.`RETURN_INFO` AS `RETURN_INFO`,`o`.`CREAT_TIME` AS `CREAT_TIME`,`o`.`UPDATE_TIME` AS `UPDATE_TIME` from (`t_orders` `o` left join `t_logistics` `l` on((`o`.`ORDER_NO` = `l`.`ORDER_NO`))) where isnull(`l`.`ORDER_NO`) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
