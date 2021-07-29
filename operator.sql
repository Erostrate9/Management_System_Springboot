/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.7.11-log : Database - operator
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`operator` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `operator`;

/*Table structure for table `rp_account_fee_record_t` */

DROP TABLE IF EXISTS `rp_account_fee_record_t`;

CREATE TABLE `rp_account_fee_record_t` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `ACCOUNT_FEE_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '出账类型编码',
  `ACCOUNT_RECORD_MONTH` date DEFAULT NULL COMMENT '录入月份',
  `ACCOUNT_FEE` decimal(12,2) DEFAULT NULL COMMENT '录入金额',
  `ACCOUNT_OPERATOR` varchar(30) DEFAULT NULL COMMENT '录入员工用户名',
  `CHECK_STATUS` varchar(1) DEFAULT NULL COMMENT '稽核状态',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人',
  `CHECK_TIME` date DEFAULT NULL COMMENT '稽核时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_ACCOUNT_FEE_RECORD_T_PK` (`ID`) USING BTREE,
  KEY `ACCOUNTFEE_ACCOUNT_TYPECODE_FK` (`ACCOUNT_FEE_TYPE_CODE`) USING BTREE,
  KEY `ACCOUNT_PRODUCT_CODE_FK` (`PRODUCT_CODE`) USING BTREE,
  KEY `CITY_CODE_FK` (`CITY_CODE`) USING BTREE,
  CONSTRAINT `ACCOUNTFEE_ACCOUNT_TYPECODE_FK` FOREIGN KEY (`ACCOUNT_FEE_TYPE_CODE`) REFERENCES `rp_account_type_code_t` (`ACCOUNT_TYPE_CODE`),
  CONSTRAINT `ACCOUNT_PRODUCT_CODE_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`),
  CONSTRAINT `CITY_CODE_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_account_fee_record_t` */

/*Table structure for table `rp_account_gather_t` */

DROP TABLE IF EXISTS `rp_account_gather_t`;

CREATE TABLE `rp_account_gather_t` (
  `ACCOUNT_MONTH` varchar(6) DEFAULT NULL COMMENT '出帐月份',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `ACCOUNT_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '出帐收入类型编码',
  `UPDATE_TIME` date DEFAULT NULL COMMENT '数据更新时间',
  `ACCOUN_FEE` decimal(12,2) DEFAULT NULL COMMENT '出帐金额',
  KEY `rp_account_gather_t_rp_account_type_code_t_ACCOUNT_TYPE_CODE_fk` (`ACCOUNT_TYPE_CODE`),
  KEY `rp_account_gather_t_rp_city_code_t_CITY_CODE_fk` (`CITY_CODE`),
  KEY `rp_account_gather_t_rp_product_code_t_PRODUCT_CODE_fk` (`PRODUCT_CODE`),
  CONSTRAINT `ACCOUNT_CITY_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `ACCOUNT_PRODUCT_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`),
  CONSTRAINT `ACCOUNT_TYPE_FK` FOREIGN KEY (`ACCOUNT_TYPE_CODE`) REFERENCES `rp_account_type_code_t` (`ACCOUNT_TYPE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_account_gather_t` */

insert  into `rp_account_gather_t`(`ACCOUNT_MONTH`,`CITY_CODE`,`PRODUCT_CODE`,`ACCOUNT_TYPE_CODE`,`UPDATE_TIME`,`ACCOUN_FEE`) values ('7','750','120502','4005','2021-07-27',10000.00),('7','754','320113','4008','2021-07-27',2000.00),('7','752','420201','4004','2021-07-27',6000.00),('7','755','120502','4004','2021-07-28',40000.00),('7','759','420201','4008','2021-07-28',3000.00);

/*Table structure for table `rp_account_type_code_t` */

DROP TABLE IF EXISTS `rp_account_type_code_t`;

CREATE TABLE `rp_account_type_code_t` (
  `ACCOUNT_TYPE_CODE` varchar(10) NOT NULL COMMENT '出账收入类型编码',
  `ACCOUNT_TYPE_NAME` varchar(100) NOT NULL COMMENT '出账收入名称',
  PRIMARY KEY (`ACCOUNT_TYPE_CODE`) USING BTREE,
  UNIQUE KEY `RP_ACCOUNT_TYPE_CODE_T_PK` (`ACCOUNT_TYPE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_account_type_code_t` */

insert  into `rp_account_type_code_t`(`ACCOUNT_TYPE_CODE`,`ACCOUNT_TYPE_NAME`) values ('4001','主营业务收入-公众客户-月租费收入'),('4002','主营业务收入-公众客户-本地区内通话费'),('4003','主营业务收入-公众客户-本地区间通话费'),('4004','主营业务收入-公众客户-本地拨号上网通信费'),('4005','主营业务收入-公众客户-国内长途通信费'),('4006','主营业务收入-公众客户-国际长途通信费'),('4007','主营业务收入-公众客户-港澳台长途通信费'),('4008','主营业务收入-公众客户-IP国内长途通信费'),('4009','主营业务收入-公众客户-IP国际长途通信费'),('4010','主营业务收入-公众客户-IP港澳台长途通信费'),('4011','主营业务收入-公众客户-装移机工料费收入'),('4012','主营业务收入-公众客户-开户费收入'),('4013','主营业务收入-公众客户-网络使用费'),('4014','主营业务收入-公众客户-一次性费用'),('4015','主营业务收入-公众客户-标准资费收入'),('4020','主营业务收入-公众客户-增值业务收入'),('4021','主营业务收入-公众客户-其他类收入'),('4022','主营业务收入-公众客户-折扣与折让');

/*Table structure for table `rp_admin_t` */

DROP TABLE IF EXISTS `rp_admin_t`;

CREATE TABLE `rp_admin_t` (
  `ADMINID` varchar(10) NOT NULL COMMENT '编号',
  `USERNAME` varchar(30) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(30) NOT NULL COMMENT '密码',
  `LOC` varchar(20) NOT NULL COMMENT '所属地区',
  `DEPT` varchar(30) NOT NULL COMMENT '所属部门',
  `TRUENAME` varchar(30) NOT NULL COMMENT '真实姓名',
  PRIMARY KEY (`ADMINID`) USING BTREE,
  UNIQUE KEY `RP_ADMIN_T_PK` (`ADMINID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_admin_t` */

insert  into `rp_admin_t`(`ADMINID`,`USERNAME`,`PASSWORD`,`LOC`,`DEPT`,`TRUENAME`) values ('001','hfy','123456','000','02','霍飞宇'),('002','yhh','123456','751','03','姚后欢'),('003','zsy','123456','000','04','张士育'),('004','lhl','123456','740','01','刘洪磊');

/*Table structure for table `rp_balance_sp_code_t` */

DROP TABLE IF EXISTS `rp_balance_sp_code_t`;

CREATE TABLE `rp_balance_sp_code_t` (
  `BALANCE_SP_CODE` varchar(10) NOT NULL COMMENT '结算运营商编码',
  `BALANCE_SP_NAME` varchar(100) NOT NULL COMMENT '结算运营商名称',
  PRIMARY KEY (`BALANCE_SP_CODE`) USING BTREE,
  UNIQUE KEY `RP_BALANCE_SP_CODE_T_PK` (`BALANCE_SP_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_balance_sp_code_t` */

insert  into `rp_balance_sp_code_t`(`BALANCE_SP_CODE`,`BALANCE_SP_NAME`) values ('1','电信'),('2','移动'),('3','联通');

/*Table structure for table `rp_balance_type_code_t` */

DROP TABLE IF EXISTS `rp_balance_type_code_t`;

CREATE TABLE `rp_balance_type_code_t` (
  `BALANCE_TYPE_CODE` varchar(10) NOT NULL COMMENT '结算类型编码',
  `BALANCE_TYPE_NAME` varchar(100) NOT NULL COMMENT '结算类型名称',
  PRIMARY KEY (`BALANCE_TYPE_CODE`) USING BTREE,
  UNIQUE KEY `RP_BALANCE_TYPE_CODE_T_PK` (`BALANCE_TYPE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_balance_type_code_t` */

insert  into `rp_balance_type_code_t`(`BALANCE_TYPE_CODE`,`BALANCE_TYPE_NAME`) values ('1','结算支出'),('2','结算收入');

/*Table structure for table `rp_business_fee_gather_t` */

DROP TABLE IF EXISTS `rp_business_fee_gather_t`;

CREATE TABLE `rp_business_fee_gather_t` (
  `BUSINESS_FEE_DATE` varchar(8) DEFAULT NULL COMMENT '营业收款日期',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `BUSINESS_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '通知单收入编码',
  `BUSINESS_FEE` decimal(12,2) DEFAULT NULL COMMENT '通知单收入金额',
  `UPDATE_TIME` date DEFAULT NULL COMMENT '数据更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_business_fee_gather_t` */

/*Table structure for table `rp_business_fee_record_t` */

DROP TABLE IF EXISTS `rp_business_fee_record_t`;

CREATE TABLE `rp_business_fee_record_t` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `BUSINESS_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '通知单类型编码',
  `BUSINESS_RECORD_DATE` date DEFAULT NULL COMMENT '录入日期',
  `BUSINESS_FEE` decimal(12,2) DEFAULT NULL COMMENT '录入金额',
  `RECORD_OPERATOR` varchar(30) DEFAULT NULL COMMENT '录入人员',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人员',
  `CHECK_TIME` date DEFAULT NULL COMMENT '稽核时间',
  `CHECK_STATUS` varchar(1) DEFAULT NULL COMMENT '稽核状态',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_BUSINESS_FEE_RECORD_T_PK` (`ID`) USING BTREE,
  KEY `BUSINESSFEE_BUSINESS_TYPE_FK` (`BUSINESS_TYPE_CODE`) USING BTREE,
  KEY `BUSINESSFEE_CITY_CODE_FK` (`CITY_CODE`) USING BTREE,
  KEY `BUSINESSFEE_PRODUCT_CODE_FK` (`PRODUCT_CODE`) USING BTREE,
  CONSTRAINT `BUSINESSFEE_BUSINESS_TYPE_FK` FOREIGN KEY (`BUSINESS_TYPE_CODE`) REFERENCES `rp_business_fee_type_code_t` (`BUSINESS_FEE_TYPE_CODE`),
  CONSTRAINT `BUSINESSFEE_CITY_CODE_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `BUSINESSFEE_PRODUCT_CODE_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_business_fee_record_t` */

/*Table structure for table `rp_business_fee_type_code_t` */

DROP TABLE IF EXISTS `rp_business_fee_type_code_t`;

CREATE TABLE `rp_business_fee_type_code_t` (
  `BUSINESS_FEE_TYPE_CODE` varchar(10) NOT NULL COMMENT '通知单类型ID',
  `BUSINESS_FEE_TYPE_NAME` varchar(100) NOT NULL COMMENT '通知单类型名称',
  PRIMARY KEY (`BUSINESS_FEE_TYPE_CODE`) USING BTREE,
  UNIQUE KEY `RP_BUSINESS_FEE_TYPE_CODE__PK` (`BUSINESS_FEE_TYPE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_business_fee_type_code_t` */

insert  into `rp_business_fee_type_code_t`(`BUSINESS_FEE_TYPE_CODE`,`BUSINESS_FEE_TYPE_NAME`) values ('I0001','主业-公众-装移机工料费-普通电话'),('I0009','主业-公众-装移机工料费-公用电话-公话超市电话'),('I0014','主业-公众-装移机工料费-宽带-ADSL虚拟拨号'),('I0024','主业-公众-装移机工料费-IDC-主机托管'),('I0027','主业-公众-开户费-普通电话'),('I0035','主业-公众-开户费-公用电话-公话超市电话'),('I0040','主业-公众-开户费-宽带-ADSL虚拟拨号'),('I0050','主业-公众-开户费-IDC-主机托管'),('I0053','主业-公众-一次性费用-普通电话'),('I0061','主业-公众-一次性费用-公用电话-公话超市电话'),('I0067','主业-公众-一次性费用-宽带-ADSL虚拟拨号'),('I0232','主业-公众-一次性费用-IDC-主机托管'),('I0239','预收账款-用户预存款-普通电话'),('I0247','预收账款-用户预存款-公用电话-公话超市电话'),('I0262','预收账款-预付费卡款-面值-200卡'),('I0264','预收账款-预付费卡款-面值-300卡'),('I0267','预收账款-预付费卡款-销售折扣-200卡'),('I0269','预收账款-预付费卡款-销售折扣-300卡');

/*Table structure for table `rp_card_sale_gather_t` */

DROP TABLE IF EXISTS `rp_card_sale_gather_t`;

CREATE TABLE `rp_card_sale_gather_t` (
  `CARD_SALE_MONTH` varchar(6) DEFAULT NULL COMMENT '卡销售月份',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `DISCOUNT_RATE` decimal(5,2) DEFAULT NULL COMMENT '折扣率',
  `CARD_SALE_AMOUNT` decimal(10,0) DEFAULT NULL COMMENT '卡销售数量',
  `CARD_PAR_VALUE_FEE` decimal(12,2) DEFAULT NULL COMMENT '面值金额',
  `TOTAL_FEE` varchar(10) DEFAULT NULL COMMENT '卡总金额',
  `UPDATE_TIME` date DEFAULT NULL COMMENT '数据更新时间',
  KEY `city_code` (`CITY_CODE`),
  KEY `product_code` (`PRODUCT_CODE`),
  CONSTRAINT `city_code` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `product_code` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_card_sale_gather_t` */

/*Table structure for table `rp_card_sale_record_t` */

DROP TABLE IF EXISTS `rp_card_sale_record_t`;

CREATE TABLE `rp_card_sale_record_t` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `SALE_DATE` date DEFAULT NULL COMMENT '录入日期',
  `DISCOUNT_RATE` decimal(5,2) DEFAULT NULL COMMENT '折扣率',
  `CARD_SALE_AMOUNT` decimal(10,0) DEFAULT NULL COMMENT '卡销售数量',
  `CARD_PAR_VALUE_FEE` decimal(12,2) DEFAULT NULL COMMENT '面值金额',
  `RECORD_OPERATOR` varchar(30) DEFAULT NULL COMMENT '录入人员',
  `CHECK_STATUS` varchar(2) DEFAULT NULL COMMENT '稽核状态',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人',
  `CHECK_TIME` date DEFAULT NULL COMMENT '稽核时间',
  `TOTAL_FEE` varchar(10) DEFAULT NULL COMMENT '卡总金额',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_CARD_SALE_RECORD_T_PK` (`ID`) USING BTREE,
  KEY `CARDSALERECORD_CITY_CODE_FK` (`CITY_CODE`) USING BTREE,
  KEY `CARDSALERECORD_PRODUCT_CODE_FK` (`PRODUCT_CODE`) USING BTREE,
  CONSTRAINT `CARDSALERECORD_CITY_CODE_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `CARDSALERECORD_PRODUCT_CODE_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_card_sale_record_t` */

/*Table structure for table `rp_city_code_t` */

DROP TABLE IF EXISTS `rp_city_code_t`;

CREATE TABLE `rp_city_code_t` (
  `CITY_CODE` varchar(6) NOT NULL COMMENT '城市编码',
  `CITY_NAME` varchar(100) NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`CITY_CODE`) USING BTREE,
  UNIQUE KEY `RP_CITY_CODE_T_PK` (`CITY_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_city_code_t` */

insert  into `rp_city_code_t`(`CITY_CODE`,`CITY_NAME`) values ('000','江西本部'),('740','江西景德镇'),('750','江西南昌'),('751','江西吉安'),('752','江西赣州'),('753','江西新余'),('754','江西鹰潭'),('755','江西九江'),('756','江西宜春'),('757','江西上饶'),('758','江西萍乡'),('759','江西抚州');

/*Table structure for table `rp_fee_source_code_t` */

DROP TABLE IF EXISTS `rp_fee_source_code_t`;

CREATE TABLE `rp_fee_source_code_t` (
  `FEE_SOURCE_CODE` varchar(10) NOT NULL COMMENT '收款来源编码',
  `FEE_SOURCE_NAME` varchar(100) NOT NULL COMMENT '收款来源名称',
  PRIMARY KEY (`FEE_SOURCE_CODE`) USING BTREE,
  UNIQUE KEY `RP_FEE_SOURCE_CODE_T_PK` (`FEE_SOURCE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_fee_source_code_t` */

/*Table structure for table `rp_fee_use_code_t` */

DROP TABLE IF EXISTS `rp_fee_use_code_t`;

CREATE TABLE `rp_fee_use_code_t` (
  `FEE_USE_CODE` varchar(10) NOT NULL COMMENT '收款类型ID',
  `FEE_USE_NAME` varchar(100) NOT NULL COMMENT '收款类型名称',
  PRIMARY KEY (`FEE_USE_CODE`) USING BTREE,
  UNIQUE KEY `RP_FEE_USE_CODE_T_PK` (`FEE_USE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_fee_use_code_t` */

insert  into `rp_fee_use_code_t`(`FEE_USE_CODE`,`FEE_USE_NAME`) values ('1','保证金'),('2','押金'),('3','滞纳金'),('4','欠费收回'),('5','预收帐款'),('6','预存转收入'),('7','折让金额');

/*Table structure for table `rp_gather_failed_record_t` */

DROP TABLE IF EXISTS `rp_gather_failed_record_t`;

CREATE TABLE `rp_gather_failed_record_t` (
  `USERID` int(11) NOT NULL COMMENT '未通过记录序号',
  `GATHER_FAILED_REPORT` varchar(100) NOT NULL COMMENT '未通过原因',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人',
  PRIMARY KEY (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_gather_failed_record_t` */

/*Table structure for table `rp_net_balance_gather_t` */

DROP TABLE IF EXISTS `rp_net_balance_gather_t`;

CREATE TABLE `rp_net_balance_gather_t` (
  `BALANCE_MONTH` varchar(6) DEFAULT NULL,
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `BALANCE_SP_CODE` varchar(12) DEFAULT NULL COMMENT '结算运营商编码',
  `BALANCE_TYPE_CODE` varchar(12) DEFAULT NULL COMMENT '结算类型编码',
  `WRITE_OFF_FEE` decimal(12,2) DEFAULT NULL COMMENT '结算金额',
  `UPDATE_TIME` date DEFAULT NULL COMMENT '数据更新时间',
  KEY `city_code1` (`CITY_CODE`),
  KEY `product_code1` (`PRODUCT_CODE`),
  KEY `balance_type_code` (`BALANCE_TYPE_CODE`),
  KEY `balance_sp_code` (`BALANCE_SP_CODE`),
  CONSTRAINT `balance_sp_code` FOREIGN KEY (`BALANCE_SP_CODE`) REFERENCES `rp_balance_sp_code_t` (`BALANCE_SP_CODE`),
  CONSTRAINT `balance_type_code` FOREIGN KEY (`BALANCE_TYPE_CODE`) REFERENCES `rp_balance_type_code_t` (`BALANCE_TYPE_CODE`),
  CONSTRAINT `city_code1` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `product_code1` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_net_balance_gather_t` */

/*Table structure for table `rp_net_balance_record_t` */

DROP TABLE IF EXISTS `rp_net_balance_record_t`;

CREATE TABLE `rp_net_balance_record_t` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BALANCE_MONTH` date DEFAULT NULL COMMENT '结算月份',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `BALANCE_SP_CODE` varchar(12) DEFAULT NULL COMMENT '结算运营商编码',
  `BALANCE_TYPE_CODE` varchar(12) DEFAULT NULL COMMENT '结算类型编码',
  `RECORD_OPERATOR` varchar(30) DEFAULT NULL COMMENT '录入人员',
  `BALANCE_FEE` decimal(12,2) DEFAULT NULL COMMENT '结算金额',
  `CHECK_STATUS` varchar(2) DEFAULT NULL COMMENT '稽核状态',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人',
  `CHECK_TIME` date DEFAULT NULL COMMENT '稽核时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_NET_BALANCE_RECORD_T_PK` (`ID`) USING BTREE,
  KEY `NETBALANCERECORD_CITY_CODE_FK` (`CITY_CODE`) USING BTREE,
  KEY `NETBALANCE_BALANCE_SP_CODE_FK` (`BALANCE_SP_CODE`) USING BTREE,
  KEY `NETBALANCE_BALANCE_TYPE_FK` (`BALANCE_TYPE_CODE`) USING BTREE,
  KEY `NETBALANCE_PRODUCT_CODE_FK` (`PRODUCT_CODE`) USING BTREE,
  CONSTRAINT `NETBALANCERECORD_CITY_CODE_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `NETBALANCE_BALANCE_SP_CODE_FK` FOREIGN KEY (`BALANCE_SP_CODE`) REFERENCES `rp_balance_sp_code_t` (`BALANCE_SP_CODE`),
  CONSTRAINT `NETBALANCE_BALANCE_TYPE_FK` FOREIGN KEY (`BALANCE_TYPE_CODE`) REFERENCES `rp_balance_type_code_t` (`BALANCE_TYPE_CODE`),
  CONSTRAINT `NETBALANCE_PRODUCT_CODE_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_net_balance_record_t` */

insert  into `rp_net_balance_record_t`(`ID`,`BALANCE_MONTH`,`CITY_CODE`,`PRODUCT_CODE`,`BALANCE_SP_CODE`,`BALANCE_TYPE_CODE`,`RECORD_OPERATOR`,`BALANCE_FEE`,`CHECK_STATUS`,`CHECK_PERSON`,`CHECK_TIME`) values (1,'2021-07-27','740','120502','2','2','jack',10000.00,'1','rose','2021-07-27'),(2,'2021-07-13','753','320114','3','1','jack',20000.00,'0','rose','2021-07-27'),(4,'2021-07-14','750','120502','2','1','jack',5000.00,'1','rose','2021-07-27'),(5,'2021-07-15','740','420201','1','1','jack',8000.00,'0','rose','2021-07-27'),(6,'2021-07-17','753','420301','1','1','jack',10000.00,'1','rose','2021-07-27');

/*Table structure for table `rp_p800_local_account_code_t` */

DROP TABLE IF EXISTS `rp_p800_local_account_code_t`;

CREATE TABLE `rp_p800_local_account_code_t` (
  `ACCOUNT_CODE` varchar(10) NOT NULL COMMENT '800电话帐户编码',
  `ACCOUNT_NAME` varchar(100) NOT NULL COMMENT '本地800电话帐户名称',
  `TET_REMARK` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ACCOUNT_CODE`) USING BTREE,
  UNIQUE KEY `RP_P800_LOCAL_ACCOUNT_CODE_PK` (`ACCOUNT_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_p800_local_account_code_t` */

/*Table structure for table `rp_pre_fee_gather_t` */

DROP TABLE IF EXISTS `rp_pre_fee_gather_t`;

CREATE TABLE `rp_pre_fee_gather_t` (
  `ACCOUNT_MONTH` varchar(6) DEFAULT NULL COMMENT '出帐月份',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `WRITE_OFF_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '销账类型编码',
  `WRITE_OFF_FEE` decimal(12,2) DEFAULT NULL COMMENT '销帐金额',
  `UPDATE_TIME` date DEFAULT NULL COMMENT '数据更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_pre_fee_gather_t` */

/*Table structure for table `rp_pre_fee_record_t` */

DROP TABLE IF EXISTS `rp_pre_fee_record_t`;

CREATE TABLE `rp_pre_fee_record_t` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECORD_DATE` date DEFAULT NULL COMMENT '预存转录入日期',
  `CITY_CODE` varchar(8) DEFAULT NULL COMMENT '城市编码',
  `PRODUCT_CODE` varchar(10) DEFAULT NULL COMMENT '产品编码',
  `WRITE_OFF_TYPE_CODE` varchar(10) DEFAULT NULL COMMENT '销账类型编码',
  `WRITE_OFF_FEE` decimal(12,2) DEFAULT NULL COMMENT '销帐金额',
  `RECORD_OPERATOR` varchar(30) DEFAULT NULL COMMENT '录入人员',
  `CHECK_STATUS` varchar(2) DEFAULT NULL COMMENT '稽核状态',
  `CHECK_PERSON` varchar(30) DEFAULT NULL COMMENT '稽核人',
  `CHECK_TIME` date DEFAULT NULL COMMENT '稽核时间',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_PRE_FEE_RECORD_T_PK` (`ID`) USING BTREE,
  KEY `PREFEE_CITY_CODE_FK` (`CITY_CODE`) USING BTREE,
  KEY `PREFEE_PRODUCT_CODE_FK` (`PRODUCT_CODE`) USING BTREE,
  KEY `PREFEE_WRITE_OFF_TYPE_CODE_FK` (`WRITE_OFF_TYPE_CODE`) USING BTREE,
  CONSTRAINT `PREFEE_CITY_CODE_FK` FOREIGN KEY (`CITY_CODE`) REFERENCES `rp_city_code_t` (`CITY_CODE`),
  CONSTRAINT `PREFEE_PRODUCT_CODE_FK` FOREIGN KEY (`PRODUCT_CODE`) REFERENCES `rp_product_code_t` (`PRODUCT_CODE`),
  CONSTRAINT `PREFEE_WRITE_OFF_TYPE_CODE_FK` FOREIGN KEY (`WRITE_OFF_TYPE_CODE`) REFERENCES `rp_write_off_type_code_t` (`WRITE_OFF_TYPE_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_pre_fee_record_t` */

/*Table structure for table `rp_product_code_t` */

DROP TABLE IF EXISTS `rp_product_code_t`;

CREATE TABLE `rp_product_code_t` (
  `PRODUCT_CODE` varchar(10) NOT NULL COMMENT '产品编码',
  `PRODUCT_NAME` varchar(256) NOT NULL COMMENT '产品名称',
  `USE_FLAG` varchar(1) NOT NULL COMMENT '是否使用',
  `USE_ACCOUNT` varchar(1) NOT NULL COMMENT '是否出账收入',
  `USE_CARD_SALE` varchar(1) NOT NULL COMMENT '是否卡销售',
  `USE_BALANCE` varchar(1) NOT NULL COMMENT '是否网间结算',
  `USE_PRE_FEE` varchar(1) NOT NULL COMMENT '是否预存转收',
  `USE_BUSINESS_FEE` varchar(1) NOT NULL COMMENT '是否通知单',
  PRIMARY KEY (`PRODUCT_CODE`) USING BTREE,
  UNIQUE KEY `RP_PRODUCT_CODE_T_PK` (`PRODUCT_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_product_code_t` */

insert  into `rp_product_code_t`(`PRODUCT_CODE`,`PRODUCT_NAME`,`USE_FLAG`,`USE_ACCOUNT`,`USE_CARD_SALE`,`USE_BALANCE`,`USE_PRE_FEE`,`USE_BUSINESS_FEE`) values ('110101','固话-基础业务-普通电话','1','1','0','1','1','1'),('110503','固话-基础业务-公用电话-公话超市电话','1','1','0','1','1','1'),('120502','固话-增值业务-800-国内','1','1','0','1','1','1'),('320113','卡类-IP卡-省内IP电话卡-200卡','1','1','1','0','0','1'),('320114','卡类-IP卡-省内IP电话卡-300卡','1','1','1','0','0','1'),('420201','数据业务-互联网接入服务-宽带接入-ADSL虚拟拨号','1','1','0','0','1','1'),('420301','数据业务-互联网接入服务-互联网普通专线接入','1','1','0','0','1','0'),('430101','数据业务-平台业务-IDC-主机托管','1','1','0','0','0','1');

/*Table structure for table `rp_return_fee_code_t` */

DROP TABLE IF EXISTS `rp_return_fee_code_t`;

CREATE TABLE `rp_return_fee_code_t` (
  `RETURN_USE_CODE` varchar(10) NOT NULL COMMENT '退款用途编码',
  `RETURN_USE_NAME` varchar(100) NOT NULL COMMENT '退款用途名称',
  PRIMARY KEY (`RETURN_USE_CODE`) USING BTREE,
  UNIQUE KEY `RP_RETURN_FEE_CODE_T_PK` (`RETURN_USE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_return_fee_code_t` */

/*Table structure for table `rp_syslog_t` */

DROP TABLE IF EXISTS `rp_syslog_t`;

CREATE TABLE `rp_syslog_t` (
  `ID` varchar(30) NOT NULL COMMENT '编号',
  `USERID` varchar(10) NOT NULL COMMENT '用户编号',
  `OPERATION_KIND` varchar(4) NOT NULL COMMENT '操作种类',
  `OPERATION_TIME` date NOT NULL COMMENT '操作精确时间',
  `OPERATION_SQL` varchar(300) NOT NULL COMMENT '操作语句',
  `NOTICE` varchar(300) DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `RP_SYSLOG_T_PK` (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_syslog_t` */

/*Table structure for table `rp_user_check_module_t` */

DROP TABLE IF EXISTS `rp_user_check_module_t`;

CREATE TABLE `rp_user_check_module_t` (
  `USERID` varchar(10) NOT NULL COMMENT '编号',
  `CHECK_MODULE_RIGHT` varchar(5) NOT NULL COMMENT '稽核模块权限',
  PRIMARY KEY (`USERID`) USING BTREE,
  UNIQUE KEY `RP_USER_CHECK_MODULE_T_PK` (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_user_check_module_t` */

insert  into `rp_user_check_module_t`(`USERID`,`CHECK_MODULE_RIGHT`) values ('001','1'),('002','1'),('003','1'),('004','1');

/*Table structure for table `rp_user_enter_module_t` */

DROP TABLE IF EXISTS `rp_user_enter_module_t`;

CREATE TABLE `rp_user_enter_module_t` (
  `USERID` varchar(10) NOT NULL COMMENT '编号',
  `ACCOUNT_FEE_RECORD_RIGHT` varchar(4) NOT NULL COMMENT '出账录入',
  `CARD_SALE_RECORD_RIGHT` varchar(4) NOT NULL COMMENT '卡销售录入',
  `NET_BALANCE_RECORD_RIGHT` varchar(4) NOT NULL COMMENT '网间结算录入',
  `PRE_FEE_RECORD_RIGHT` varchar(4) NOT NULL COMMENT '预存转收录入',
  `BUSINESS_FEE_RECORD_RIGHT` varchar(4) NOT NULL COMMENT '通知单录入',
  PRIMARY KEY (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_user_enter_module_t` */

insert  into `rp_user_enter_module_t`(`USERID`,`ACCOUNT_FEE_RECORD_RIGHT`,`CARD_SALE_RECORD_RIGHT`,`NET_BALANCE_RECORD_RIGHT`,`PRE_FEE_RECORD_RIGHT`,`BUSINESS_FEE_RECORD_RIGHT`) values ('001','1','1','1','1','1'),('002','1','1','1','1','1'),('003','1','1','1','1','1'),('004','1','1','1','1','1');

/*Table structure for table `rp_user_gather_module_t` */

DROP TABLE IF EXISTS `rp_user_gather_module_t`;

CREATE TABLE `rp_user_gather_module_t` (
  `USERID` varchar(10) NOT NULL COMMENT '编号',
  `GATHER_MODULE_RIGHT` varchar(5) NOT NULL COMMENT '归集模块权限',
  PRIMARY KEY (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_user_gather_module_t` */

insert  into `rp_user_gather_module_t`(`USERID`,`GATHER_MODULE_RIGHT`) values ('001','1'),('002','1'),('003','1'),('004','1');

/*Table structure for table `rp_user_operate_t` */

DROP TABLE IF EXISTS `rp_user_operate_t`;

CREATE TABLE `rp_user_operate_t` (
  `USERID` varchar(10) NOT NULL COMMENT '编号',
  `ENTER_MODULE_RIGHT` varchar(5) NOT NULL COMMENT '模块权限',
  PRIMARY KEY (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_user_operate_t` */

insert  into `rp_user_operate_t`(`USERID`,`ENTER_MODULE_RIGHT`) values ('001','1'),('002','1'),('003','1'),('004','1');

/*Table structure for table `rp_user_t` */

DROP TABLE IF EXISTS `rp_user_t`;

CREATE TABLE `rp_user_t` (
  `USERID` varchar(10) NOT NULL COMMENT '编号',
  `USERNAME` varchar(30) NOT NULL COMMENT '用户名',
  `PASSWORD` varchar(30) NOT NULL COMMENT '密码',
  `TRUENAME` varchar(30) NOT NULL COMMENT '姓名',
  `SEX` varchar(2) NOT NULL COMMENT '性别',
  `AGE` decimal(3,0) NOT NULL COMMENT '年龄',
  `ROLE_RIGHT` varchar(3) NOT NULL COMMENT '角色权限',
  `LOCATION_NO` varchar(8) NOT NULL COMMENT '所属地区编号',
  `DEPT` varchar(30) NOT NULL COMMENT '所属部门',
  `EMAIL` varchar(30) NOT NULL COMMENT '电子邮件',
  `VIP_RIGHT` varchar(1) NOT NULL COMMENT '查询特权(省2，市1)',
  PRIMARY KEY (`USERID`) USING BTREE,
  UNIQUE KEY `RP_USER_T_PK` (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_user_t` */

/*Table structure for table `rp_write_off_type_code_t` */

DROP TABLE IF EXISTS `rp_write_off_type_code_t`;

CREATE TABLE `rp_write_off_type_code_t` (
  `WRITE_OFF_TYPE_CODE` varchar(10) NOT NULL COMMENT '销账类型ID',
  `WRITE_OFF_TYPE_NAME` varchar(100) NOT NULL COMMENT '销账类型名称',
  PRIMARY KEY (`WRITE_OFF_TYPE_CODE`) USING BTREE,
  UNIQUE KEY `RP_WRITE_OFF_TYPE_CODE_T_PK` (`WRITE_OFF_TYPE_CODE`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/*Data for the table `rp_write_off_type_code_t` */

insert  into `rp_write_off_type_code_t`(`WRITE_OFF_TYPE_CODE`,`WRITE_OFF_TYPE_NAME`) values ('P100','预收账款-用户预存款'),('P110','预收账款-缴费卡款'),('P120','预收账款-预付费卡款-面值'),('P130','预收账款-预付费卡款-销售折扣'),('P140','预收账款-预收出租商品租金'),('P150','预收账款-预收代办工程款'),('P160','预收账款-其他-其他');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
