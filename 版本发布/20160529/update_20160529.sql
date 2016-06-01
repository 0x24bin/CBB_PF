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
   ORDER_NO             VARCHAR(30) COMMENT '�������--����ƽ̨��ԭʼ������ţ���ʽ',
   GUID                 VARCHAR(64) COMMENT '��ƽ̨����36λΨһ��ţ�Ӣ����ĸ��д�����ֺͺ�ܣ�,��ʽ:SINOTRANS-SKU-YYYYMMDDhhmmss-0000001,��ϵͳ��ǰʱ���7λ��ˮ��',
   CUSTOM_CODE          VARCHAR(4) COMMENT '֧����ҵ����10λ������',
   RECEIVER_ID          VARCHAR(4) COMMENT '���պ��ش���',
   APP_TYPE             INT DEFAULT 1 COMMENT '�걨����:1-���� 2-��� 3-ɾ��,Ĭ��Ϊ1',
   APP_TIME             VARCHAR(64) COMMENT '�걨ʱ���Ժ�����������ʱ��Ϊ׼,��ʽ:YYYYMMDDhhmmss,ϵͳ��ǰʱ�䣨��ִ�л�ȡ��',
   APP_STATUS           INT DEFAULT 1 COMMENT 'ҵ��״̬:1-�ݴ�,2-�걨,Ĭ��Ϊ1',
   APP_UID              VARCHAR(64) COMMENT '���ӿڰ��ֿ���IC����IKEY���',
   APP_UNAME            VARCHAR(128) COMMENT '���ӿڰ��ֿ�������',
   PAY_CODE             VARCHAR(10) COMMENT '֧����ҵ���루10λ��',
   PAY_NAME             VARCHAR(255) COMMENT '֧����ҵ����',
   PAY_TYPE             VARCHAR(1) COMMENT '֧����������',
   PAY_NO               VARCHAR(50) COMMENT '֧�����ױ��--Ҫ��Ψһ',
   EBP_CODE             VARCHAR(64) COMMENT '����ƽ̨����--������ҵ�ĺ��ر������루10λ��',
   EBP_NAME             VARCHAR(128) COMMENT '����ƽ̨����',
   PAY_STATUS           VARCHAR(1) COMMENT '֧��״̬��D-���ۣ� S-ʵ�ۣ�R-�����˿ C-ȡ��(�˿�)',
   DRAWEE               VARCHAR(50) COMMENT '֧��������',
   DRAWEE_INDENTIFY     VARCHAR(18) COMMENT '�����˵Ĵ��롣����֧������Ϣ��֧���˵����֤��',
   NOTE                 VARCHAR(1000) COMMENT '��ע',
   VERSION              VARCHAR(16) DEFAULT 'V1.0' COMMENT '�汾��',
   RETURN_STATUS        INT COMMENT '��ִ״̬--���������1���ӿڰ����ݴ�/2���ӿڰ��걨��/3���ͺ��سɹ�/4���ͺ���ʧ��/100�����˵�/120�������ɹ�/399������ᣩ,��С��0���ֱ�ʾ�����쳣��ִ',
   RETURN_TIME          VARCHAR(64) COMMENT '��ִʱ��--����ʱ��(��ʽ:YYYYMMDDhhmmss)',
   RETURN_INFO          VARCHAR(1000) COMMENT '��ִ��Ϣ--��ע����:�˵�ԭ��',
   CREAT_TIME           DATETIME,
   UPDATE_TIME          TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (PAY_ID),
   UNIQUE KEY AK_KEY_2 (PAY_NO)
);

ALTER TABLE T_NJ_PAY COMMENT '֧����';

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
	
	
insert  into `t_sys_menu`(`SYS_MENU_ID`,`MENU_DISPLAY_NAME`,`MENU_HREF`,`MENU_PARENT_ID`,`IS_LEAF`,`ICON_CLASS`) values (4050000,'֧��ƾ֤','../nj_cbb_pf/payManager/PAY.menu',4000000,1,NULL);  