/*
Date: 2015/09/14 
*/

use labassistant;

SET FOREIGN_KEY_CHECKS=0;
-- -----------------------------------
-- Table structure for `t_user` 用户表
-- -----------------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `userid` varchar(40) NOT NULL,
  `nickname` varchar(40) NOT NULL,
  `pwd` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telno` varchar(20),
  `provinceid` int NOT NULL DEFAULT -1,
  `cityid` int NOT NULL DEFAULT -1,
  `collegeid` int NOT NULL DEFAULT -1,
  `majorid` int NOT NULL DEFAULT -1,
  `educationid` int NOT NULL DEFAULT -1,
  `titleid` int NOT NULL DEFAULT -1,
  `nstate` int NOT NULL DEFAULT 0,
  `nsource` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO t_user VALUES ('4028c681494b994701494b99aba50000', 'admin', '25d55ad283aa400af464c76d713c07ad', '12345678@qq.com', '', 0, 0, 0, 0, 0, 0, 0, 0);


-- -----------------------------------
-- Table structure for `t_teacher` 导师表
-- -----------------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `teacherid` varchar(40) NOT NULL,
  `nickname` varchar(40) NOT NULL,
  `pwd` varchar(40) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telno` varchar(20),
  `provinceid` int NOT NULL DEFAULT -1,
  `cityid` int NOT NULL DEFAULT -1,
  `collegeid` int NOT NULL DEFAULT -1,
  `majorid` int NOT NULL DEFAULT -1,
  `educationid` int NOT NULL DEFAULT -1,
  `titleid` int NOT NULL DEFAULT -1,
  `nstate` int NOT NULL DEFAULT 0,
  `nsource` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`teacherid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_teacher` 学生导师对应表
-- -----------------------------------
DROP TABLE IF EXISTS `t_userteachermap`;
CREATE TABLE `t_userteachermap` (
  `userteachermapid` varchar(40) NOT NULL,
  `userid` varchar(40) NOT NULL,
  `teacherid` varchar(40) NOT NULL,
  PRIMARY KEY (`userteachermapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_province` 省份表
-- -----------------------------------
DROP TABLE IF EXISTS `t_province`;
CREATE TABLE `t_province` (
  `provinceid` varchar(40) NOT NULL,
  `provincename` varchar(50) NOT NULL,
  PRIMARY KEY (`provinceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_city` 城市表
-- -----------------------------------
DROP TABLE IF EXISTS `t_city`;
CREATE TABLE `t_city` (
  `cityid` varchar(40) NOT NULL,
  `provinceid` varchar(40) NOT NULL,
  `cityname` varchar(50) NOT NULL,
  PRIMARY KEY (`cityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_college` 院校表
-- -----------------------------------
DROP TABLE IF EXISTS `t_college`;
CREATE TABLE `t_college` (
  `collegeid` varchar(40) NOT NULL,
  `collegename` varchar(50) NOT NULL,
  `cityid` varchar(40) NOT NULL,
  `provinceid` varchar(40) NOT NULL,
  PRIMARY KEY (`collegeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_major` 专业表
-- -----------------------------------
DROP TABLE IF EXISTS `t_major`;
CREATE TABLE `t_major` (
  `majorid` varchar(40) NOT NULL,
  `majorname` varchar(50) NOT NULL,
  PRIMARY KEY (`majorid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_education` 学历表
-- -----------------------------------
DROP TABLE IF EXISTS `t_education`;
CREATE TABLE `t_education` (
  `educationid` varchar(40) NOT NULL,
  `educationname` varchar(50) NOT NULL,
  PRIMARY KEY (`educationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------
-- Table structure for `t_title` 职称表
-- -----------------------------------
DROP TABLE IF EXISTS `t_title`;
CREATE TABLE `t_title` (
  `titleid` varchar(40) NOT NULL,
  `titlename` varchar(50) NOT NULL,
  PRIMARY KEY (`titleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_supplier` 供应商表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier` (
  `supplierid` varchar(40) NOT NULL,
  `suppliername` varchar(100) NOT NULL,
  `suppliertype` int,
  `contacts` varchar(20),
  `telno` varchar(20),
  `mobilephone` varchar(20),
  `email` varchar(50),
  `address` varchar(200),
  PRIMARY KEY (`supplierid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_supplier
-- ----------------------------
INSERT INTO t_supplier VALUES ('4037d681494b994701494b99aba50000', '海尔', 0, 'Li', 18000000000, 18000000000, '', '');


-- -----------------------------------------------
-- Table structure for `t_reagentlevelone` 试剂一级分类表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_reagentlevelone`;
CREATE TABLE `t_reagentlevelone` (
  `levelonesortid` varchar(40) NOT NULL,
  `levelonesortname` varchar(200),
  PRIMARY KEY (`levelonesortid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_reagentleveltwo` 试剂二级分类表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_reagentleveltwo`;
CREATE TABLE `t_reagentleveltwo` (
  `leveltwosortid` varchar(40) NOT NULL,
  `leveltwosortname` varchar(200),
  `levelonesortid` varchar(40),
  PRIMARY KEY (`leveltwosortid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_reagent` 试剂表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_reagent`;
CREATE TABLE `t_reagent` (
  `reagentid` varchar(40) NOT NULL,
  `reagentname` varchar(100) NOT NULL,
  `reagentcommonname` varchar(500),
  `levelonesortid` varchar(40),
  `leveltwosortid` varchar(40),
  `originplace` varchar(50),
  `productno` varchar(50),
  `agents` varchar(50),
  `specification` varchar(50),
  `price` int,
  `chemicalname` varchar(100),
  `casno` varchar(50),
  `arrivaldate` date,
  `memo` varchar(500),
  PRIMARY KEY (`reagentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_reagent
-- ----------------------------
INSERT INTO t_reagent VALUES (111, '洗涤液', '洗涤液', '11','1','','','','',20,'','','2016-09-10','');
INSERT INTO t_reagent VALUES (112, '洗涤液1', '洗涤液1', '11','1','','','','',20,'','','2016-09-10','');
INSERT INTO t_reagent VALUES (113, '洗涤液2', '洗涤液2', '11','1','','','','',20,'','','2016-09-10','');


-- -----------------------------------------------
-- Table structure for `t_reagentmap` 试剂厂商对应表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_reagentmap`;
CREATE TABLE `t_reagentmap` (
  `reagentmapid` varchar(32) NOT NULL,
  `reagentid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  `issuggestion` int DEFAULT 0,
  PRIMARY KEY (`reagentmapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_reagentmap
-- ----------------------------
INSERT INTO t_reagentmap VALUES ('4028c681494b994701494b00aba50000', 111, '4037d681494b994701494b99aba50000', 0);
INSERT INTO t_reagentmap VALUES ('4028c681494b994701494b00aba51111', 112, '4037d681494b994701494b99aba50000', 0);
INSERT INTO t_reagentmap VALUES ('4028c681494b994701494b00aba52222', 113, '4037d681494b994701494b99aba50000', 0);


-- -----------------------------------------------
-- Table structure for `t_consumable` 耗材表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_consumable`;
CREATE TABLE `t_consumable` (
  `consumableid` varchar(40) NOT NULL,
  `consumablename` varchar(100) NOT NULL,
  `consumabletype` varchar(20),
  PRIMARY KEY (`consumableid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_consumablemap` 耗材厂商对应表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_consumablemap`;
CREATE TABLE `t_consumablemap` (
  `consumablemapid` varchar(32) NOT NULL,
  `consumableid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  `issuggestion` int DEFAULT 0,
  PRIMARY KEY (`consumablemapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_equipment` 设备表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_equipment`;
CREATE TABLE `t_equipment` (
  `equipmentid` varchar(40) NOT NULL,
  `equipmentname` varchar(100) NOT NULL,
  PRIMARY KEY (`equipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_equipmentmap` 设备厂商对应表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_equipmentmap`;
CREATE TABLE `t_equipmentmap` (
  `equipmentmapid` varchar(32) NOT NULL,
  `equipmentid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  `issuggestion` int DEFAULT 0,
  PRIMARY KEY (`equipmentmapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ---------------------------------------------------------
-- Table structure for `t_expinstructionsmain` 实验说明书主表
-- ---------------------------------------------------------
DROP TABLE IF EXISTS `t_expinstructionsmain`;
CREATE TABLE `t_expinstructionsmain` (
  `expinstructionid` varchar(40) NOT NULL,
  `experimentname` varchar(200),
  `experimentdesc` varchar(1000),
  `experimenttheory` text,
  `provideuser` varchar(40),
  `supplierid` varchar(40),
  `suppliername` varchar(40),
  `productnum` varchar(40),
  `expcategoryid` varchar(40),
  `expsubcategoryid` varchar(40),
  `createdate` date,
  `expversion` int,
  `allowdownload` int,
  `filterstr` varchar(400),
  `reviewcount` int,
  `downloadcount` int,
  PRIMARY KEY (`expinstructionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_expinstructionsmain
-- ----------------------------
INSERT INTO t_expinstructionsmain VALUES ('4028c681494b994701494b99bab60000', 'ELISA检测血清TNF-a浓度', '我也不知道', '还是不知道', '', '4037d681494b994701494b99aba50000', '海尔', 'hhd', 1, 11, '2015-09-16', 1, 1, '', 0, 0);
INSERT INTO t_expinstructionsmain VALUES ('4028c681494b994701494b99bab61111', 'ELISA检测血清TNF-b浓度', '我也不知道', '还是不知道', '', '4037d681494b994701494b99aba50000', '海尔', 'hhd', 1, 11, '2015-09-16', 1, 1, '', 0, 20);
INSERT INTO t_expinstructionsmain VALUES ('4028c681494b994701494b99bab62222', 'ELISA检测血清TNF-c浓度', '我也不知道', '还是不知道', '', '4037d681494b994701494b99aba50000', '海尔', 'hhd', 1, 11, '2015-09-16', 1, 1, '', 0, 5);


-- -----------------------------------------------
-- Table structure for `t_expprocess` 实验步骤表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_expprocess`;
CREATE TABLE `t_expprocess` (
  `expstepid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `stepnum` int,
  `expstepdesc` text,
  `expsteptime` decimal(5,2) DEFAULT 0,
  PRIMARY KEY (`expstepid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_expprocess
-- ----------------------------
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70000', '4028c681494b994701494b99bab60000', 1, '用包被缓冲液溶解抗原，使抗原浓度为10-20 μg/ml，加100 μl/孔，4℃放置', 10);
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70001', '4028c681494b994701494b99bab60000', 2, '弃去液体后，在吸水纸拍干，每孔加入300μl PBST 洗涤，振荡', 10);
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70002', '4028c681494b994701494b99bab60000', 3, '弃去液体后，在吸水纸拍干，每孔加入300μl PBST 洗涤，振荡', 10);
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70003', '4028c681494b994701494b99bab60000', 4, '弃去液体后，在吸水纸拍干，每孔加入300μl PBST 洗涤，振荡', 10);
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70004', '4028c681494b994701494b99bab60000', 5, '每孔加入150 μl 1％ BSA 37℃封闭1 小时', 10);
INSERT INTO t_expprocess VALUES ('4028c681494b994701494b99bab70005', '4028c681494b994701494b99bab60000', 6, '弃去液体后，在吸水纸拍干，每孔加入300μl PBST 洗涤，振荡', 10);


-- -----------------------------------------------
-- Table structure for `t_expreagent` 实验试剂表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_expreagent`;
CREATE TABLE `t_expreagent` (
  `expreagentid` varchar(32) NOT NULL,
  `expinstructionid` varchar(40),
  `reagentid` varchar(40),
  `reagentname` varchar(100),
  `reagentcommonname` varchar(500),
  `createMethod` varchar(1000),
  `reagentspec` varchar(50),
  `useamount` int,
  PRIMARY KEY (`expreagentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_expreagent
-- ----------------------------
INSERT INTO t_expreagent VALUES ('4028c681494b994701494b99aba50000','4028c681494b994701494b99bab60000', '111', '洗涤液', '洗涤液', '洗涤液', '洗涤液', 50);
INSERT INTO t_expreagent VALUES ('4028c681494b994701494b99aba50001','4028c681494b994701494b99bab60000', '112', '洗涤液1', '洗涤液1', '洗涤液1', '洗涤液1', 500);
INSERT INTO t_expreagent VALUES ('4028c681494b994701494b99aba50002','4028c681494b994701494b99bab60000', '113', '洗涤液2', '洗涤液2', '洗涤液2', '洗涤液2', 60);


-- -----------------------------------------------
-- Table structure for `t_expconsumable` 实验耗材表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_expconsumable`;
CREATE TABLE `t_expconsumable` (
  `expconsumableid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40),
  `consumableid` varchar(40),
  `consumabletype` varchar(20),
  `consumablecount` int,
  `consumablefactory` varchar(100),
  PRIMARY KEY (`expconsumableid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_expconsumable
-- ----------------------------
INSERT INTO t_expconsumable VALUES ('4028c791494b994701494b99aba50000','4028c681494b994701494b99bab60000', '111', '96T', 2, '不知道');


-- -----------------------------------------------
-- Table structure for `t_expequipment` 实验设备表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_expequipment`;
CREATE TABLE `t_expequipment` (
  `expequipmentid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40),
  `equipmentid` varchar(40),
  `equipmentname` varchar(100),
  `equipmentfactory` varchar(100),
  PRIMARY KEY (`expequipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_expequipment
-- ----------------------------
INSERT INTO t_expequipment VALUES ('4028c791564b994701494b99aba50000','4028c681494b994701494b99bab60000', '222', '4℃冰箱', '海尔');
INSERT INTO t_expequipment VALUES ('4028c791564b994701494b99aba50001','4028c681494b994701494b99bab60000', '223', '恒温培养箱', '上海一恒');
INSERT INTO t_expequipment VALUES ('4028c791564b994701494b99aba50002','4028c681494b994701494b99bab60000', '224', '酶标仪', 'Tecan 200');


-- -----------------------------------------------
-- Table structure for `t_myexpinstruction` 我的说明书表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpinstruction`;
CREATE TABLE `t_myexpinstruction` (
  `myexpinstructionid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `userid` varchar(40),
  `downloadtime` datetime,
  PRIMARY KEY (`myexpinstructionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- -----------------------------------------------
-- Table structure for `t_myexpmain` 我的实验主表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpmain`;
CREATE TABLE `t_myexpmain` (
  `myexpid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `userid` varchar(40),
  `createtime` datetime,
  `createyear` int,
  `createmonth` int,
  `finishtime` datetime,
  `expversion` int,
  `isreviewed` int,
  `iscreatereport` int,
  `isupload` int,
  `reportname` varchar(100),
  `reportlocation` varchar(1000),
  `reportserverpath` varchar(1000),
  `expstate` int,
  `expmeno` varchar(500),
  PRIMARY KEY (`myexpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpmain
-- ----------------------------
INSERT INTO t_myexpmain VALUES ('4039c681494b994701494b99aba51236', '4028c681494b994701494b99bab60000','4028c681494b994701494b99aba50000', '2015-09-16', 2015, 09, '2015-09-16', 1, 0, 0, 0, '', '', '', 0, '');
INSERT INTO t_myexpmain VALUES ('4039c681494b994701494b99aba51237', '4028c681494b994701494b99bab61111','4028c681494b994701494b99aba50000', '2015-09-16', 2015, 09, '2015-09-16', 1, 0, 0, 0, '', '', '', 2, '');


-- -----------------------------------------------
-- Table structure for `t_myexpprocess` 我的实验步骤表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpprocess`;
CREATE TABLE `t_myexpprocess` (
  `myexpstepid` varchar(40) NOT NULL,
  `myexpid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `expstepid` varchar(40) NOT NULL,
  `stepnum` int,
  `expstepdesc` text,
  `expsteptime` decimal(5,2) DEFAULT 0,
  `isusetimer` int,
  `processmemo` varchar(500),
  PRIMARY KEY (`myexpstepid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpprocess
-- ----------------------------
INSERT INTO t_myexpprocess VALUES ('4039c681494b994701494b99aba50000', '4039c681494b994701494b99aba51236', '4028c681494b994701494b99bab60000', '4028c681494b994701494b00bab60000', 0, '', 5, 1, '');
INSERT INTO t_myexpprocess VALUES ('4039c681494b994701494b99aba50010', '4039c681494b994701494b99aba51237', '4028c681494b994701494b99bab61111', '4028c681494b994701494b00bab60123', 0, '', 5, 1, '');


-- -----------------------------------------------
-- Table structure for `t_myexpreagent` 我的实验试剂表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpreagent`;
CREATE TABLE `t_myexpreagent` (
  `myexpreagentid` varchar(40) NOT NULL,
  `myexpid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `reagentid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  PRIMARY KEY (`myexpreagentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpreagent
-- ----------------------------
INSERT INTO t_myexpreagent VALUES ('5039c681494b994701494b99aba50000', '4039c681494b994701494b99aba51236', '4028c681494b994701494b99bab60000', '111', '4037d681494b994701494b99aba50000');
INSERT INTO t_myexpreagent VALUES ('5039c681494b994701494b99aba50010', '4039c681494b994701494b99aba51237', '4028c681494b994701494b99bab61111', '112', '4037d681494b994701494b99aba50000');


-- -----------------------------------------------
-- Table structure for `t_myexpconsumable` 我的实验耗材表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpconsumable`;
CREATE TABLE `t_myexpconsumable` (
  `myexpconsumableid` varchar(40) NOT NULL,
  `myexpid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `consumableid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  PRIMARY KEY (`myexpconsumableid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpconsumable
-- ----------------------------
INSERT INTO t_myexpconsumable VALUES ('6039c681494b994701494b99aba50000', '4039c681494b994701494b99aba51236', '4028c681494b994701494b99bab60000', '4028c791494b994701494b99aba50000', '4037d681494b994701494b99aba50000');
INSERT INTO t_myexpconsumable VALUES ('6039c681494b994701494b99aba50010', '4039c681494b994701494b99aba51237', '4028c681494b994701494b99bab61111', '4028c791494b994701494b99aba50000', '4037d681494b994701494b99aba50000');


-- -----------------------------------------------
-- Table structure for `t_myexpequipment` 我的实验设备表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpequipment`;
CREATE TABLE `t_myexpequipment` (
  `myexpequipmentid` varchar(40) NOT NULL,
  `myexpid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40) NOT NULL,
  `equipmentid` varchar(40) NOT NULL,
  `supplierid` varchar(40) NOT NULL,
  PRIMARY KEY (`myexpequipmentid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpequipment
-- ----------------------------
INSERT INTO t_myexpequipment VALUES ('7039c681494b994701494b99aba50000', '4039c681494b994701494b99aba51236', '4028c681494b994701494b99bab60000', '4028c791564b994701494b99aba50000', '4037d681494b994701494b99aba50000');
INSERT INTO t_myexpequipment VALUES ('7039c681494b994701494b99aba50010', '4039c681494b994701494b99aba51237', '4028c681494b994701494b99bab61111', '4028c791564b994701494b99aba50000', '4037d681494b994701494b99aba50000');


-- -----------------------------------------------
-- Table structure for `t_myexpplan` 我的实验计划表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_myexpplan`;
CREATE TABLE `t_myexpplan` (
  `myexpplanid` varchar(40) NOT NULL,
  `userid` varchar(40) NOT NULL,
  `expinstructionid` varchar(40),
  `experimentname` varchar(200),
  `plandate` date,
  `planofyear` int,
  `planofmonth` int,
  PRIMARY KEY (`myexpplanid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_myexpplan
-- ----------------------------
INSERT INTO t_myexpplan VALUES ('8039c681494b994701494b99aba50000', '4028c681494b994701494b99aba50000', '4028c681494b994701494b99bab60000', '我也不知道', '2015-09-21', 2015, 09);


-- -----------------------------------------------
-- Table structure for `t_map` 地图相关表
-- -----------------------------------------------
DROP TABLE IF EXISTS `t_map`;
CREATE TABLE `t_map` (
  `mapid` varchar(32) NOT NULL,
  `userid` varchar(40) NOT NULL,
  `longitude` nvarchar(40),
  `latitude` nvarchar(40),
  `reagentname` varchar(100), 
  PRIMARY KEY (`mapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records of t_map
-- ----------------------------
INSERT INTO t_map VALUES ('2c9283f54fcf25eb014fcf2648530000', '4028c681494b994701494b99aba50000', '121.43657326690004', '31.18331495056','包被稀释液');
INSERT INTO t_map VALUES ('2c9283f54fcf29b3014fcf29cfdd0000', '2c9283f54fcf29b3014fcf2a3f530001', '121.43760323516177', '31.18471009979488','洗涤液');
INSERT INTO t_map VALUES ('2c9283f54fcf29b3014fcf2a915f0002', '2c9283f54fcf29b3014fcf2abba70003', '121.4375174044733', '31.184416385875302','封闭液');
INSERT INTO t_map VALUES ('2c9283f54fcf29b3014fcf2ac4bb0004', '2c9283f54fcf29b3014fcf2b23e50005', '121.44498467437076', '31.189335973819038','显色剂');