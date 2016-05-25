/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

USE `cbb_pf`;/* 外键已删除现在要重新建立*/
ALTER TABLE `t_nj_inventory` 
	DROP FOREIGN KEY `FK_REFERENCE_4`  ;

ALTER TABLE `t_nj_inventory_detail` 
	DROP FOREIGN KEY `FK_REFERENCE_111`  ;

ALTER TABLE `t_nj_logistics` 
	DROP FOREIGN KEY `FK_REFERENCE_2`  ;

ALTER TABLE `t_nj_order_detail` 
	DROP FOREIGN KEY `FK_REFERENCE_99`  ;


/* Alter table in target */
ALTER TABLE `t_nj_inventory` 
	CHANGE `GOODS_VALUE` `GOODS_VALUE` decimal(18,2)   NULL COMMENT '商品价格' after `COUNTRY` , 
	CHANGE `TAX_FEE` `TAX_FEE` decimal(18,2)   NULL COMMENT '行邮税费' after `GOODS_CURRENCY` , 
	CHANGE `FREIGHT` `FREIGHT` decimal(18,2)   NULL COMMENT '订单商品运费--交易包运费则填写\"0\"' after `DESTINATION_PORT` , 
	CHANGE `INSURE_FEE` `INSURE_FEE` decimal(18,2)   NULL COMMENT '保价费--货物保险费用' after `FREIGHT_MARK` , 
	CHANGE `WEIGHT` `WEIGHT` decimal(18,5)   NULL COMMENT '毛重--单位为千克' after `PACK_NO` , 
	CHANGE `NET_WEIGHT` `NET_WEIGHT` decimal(18,5)   NULL COMMENT '净重--单位为千克' after `WEIGHT` ;

/* Alter table in target */
ALTER TABLE `t_nj_inventory_detail` 
	CHANGE `QTY` `QTY` decimal(18,2)   NULL COMMENT '成交数量' after `ITEM_NO` , 
	CHANGE `QTY1` `QTY1` decimal(18,2)   NULL COMMENT '成交数量' after `QTY` , 
	CHANGE `QTY2` `QTY2` decimal(18,2)   NULL COMMENT '成交数量' after `QTY1` , 
	CHANGE `PRICE` `PRICE` decimal(18,2)   NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致' after `UNIT2` , 
	CHANGE `TOTAL` `TOTAL` decimal(18,2)   NULL COMMENT '总价' after `PRICE` ;

/* Alter table in target */
ALTER TABLE `t_nj_logistics` 
	CHANGE `FREIGHT` `FREIGHT` decimal(18,2)   NULL COMMENT '订单商品运费--交易包运费则填写\"0\"' after `BILL_NO` , 
	CHANGE `INSURE_FEE` `INSURE_FEE` decimal(18,2)   NULL COMMENT '保价费--货物保险费用' after `FREIGHT` , 
	CHANGE `WEIGHT` `WEIGHT` decimal(18,5)   NULL COMMENT '毛重--单位为千克' after `CURRENCY` , 
	CHANGE `NET_WEIGHT` `NET_WEIGHT` decimal(18,5)   NULL COMMENT '净重--单位为千克' after `WEIGHT` ;

/* Alter table in target */
ALTER TABLE `t_nj_order_detail` 
	CHANGE `QTY` `QTY` decimal(18,2)   NULL COMMENT '成交数量' after `GNUM` , 
	CHANGE `PRICE` `PRICE` decimal(18,2)   NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致' after `QTY` , 
	CHANGE `TOTAL` `TOTAL` decimal(18,2)   NULL COMMENT '总价' after `PRICE` ;

/* Alter table in target */
ALTER TABLE `t_nj_orders` 
	CHANGE `GOODS_VALUE` `GOODS_VALUE` decimal(18,2)   NULL COMMENT '商品价格' after `AGENT_NAME` , 
	CHANGE `FREIGHT` `FREIGHT` decimal(18,2)   NULL COMMENT '订单商品运费--交易包运费则填写\"0\"' after `GOODS_VALUE` , 
	CHANGE `TAX_FEE` `TAX_FEE` decimal(18,2)   NULL COMMENT '行邮税费' after `CURRENCY` ;

/* Alter table in target */
ALTER TABLE `t_nj_sku` 
	CHANGE `PRICE` `PRICE` decimal(18,2)   NULL COMMENT '备案价格--商品备案的参考价格,不强制要求与订单和清单一致' after `UNIT2` ;/* 外键已删除现在要重新建立*/
ALTER TABLE `t_nj_inventory` 
	ADD CONSTRAINT `FK_REFERENCE_4` 
	FOREIGN KEY (`LOGISTICS_NO`) REFERENCES `t_nj_logistics` (`LOGISTICS_NO`) ;

ALTER TABLE `t_nj_inventory_detail` 
	ADD CONSTRAINT `FK_REFERENCE_111` 
	FOREIGN KEY (`INVENTORY_ID`) REFERENCES `t_nj_inventory` (`INVENTORY_ID`) ON DELETE CASCADE ;

ALTER TABLE `t_nj_logistics` 
	ADD CONSTRAINT `FK_REFERENCE_2` 
	FOREIGN KEY (`ORDER_NO`) REFERENCES `t_nj_orders` (`ORDER_NO`) ;

ALTER TABLE `t_nj_order_detail` 
	ADD CONSTRAINT `FK_REFERENCE_99` 
	FOREIGN KEY (`ORDERS_ID`) REFERENCES `t_nj_orders` (`ORDERS_ID`) ON DELETE CASCADE ;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;