DROP VIEW IF EXISTS V_NJ_LOGISTICS_UNUSE;

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

DROP VIEW IF EXISTS V_NJ_LOGISTICS;

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
