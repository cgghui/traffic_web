/*
 Navicat Premium Data Transfer

 Source Server         : 45.253.64.130
 Source Server Type    : MySQL
 Source Server Version : 50650
 Source Host           : 45.253.64.130:3306
 Source Schema         : traffic

 Target Server Type    : MySQL
 Target Server Version : 50650
 File Encoding         : 65001

 Date: 17/01/2021 14:10:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fa_admin
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin`;
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录IP',
  `dev_num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '设备数量',
  `speed_yesterday` tinyint(1) NOT NULL DEFAULT '0' COMMENT '昨日带宽速度',
  `speed_current_month` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '当前月速度',
  `speed_last_month` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '上个月速度',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- ----------------------------
-- Records of fa_admin
-- ----------------------------
BEGIN;
INSERT INTO `fa_admin` VALUES (1, 'admin', 'Admin', 'e2903c5ecd71dfc4c76b28f777ec3fff', '8fdc3d', '/assets/img/avatar.png', '', 'admin@admin.com', 0, 1610857909, '180.120.70.109', 426, 0, 0, 0, 1492186163, 1610857909, 'a89a5704-765e-4fe0-87b1-b83c33203f02', 'normal');
INSERT INTO `fa_admin` VALUES (2, 'zt001', '张涛', '29b0fedc04b5d614edb51345f93e25b7', 'bsUyCi', '/assets/img/avatar.png', '', '319891@qq.com', 0, NULL, NULL, 38, 0, 0, 0, 1610782838, 1610782838, '', 'normal');
INSERT INTO `fa_admin` VALUES (3, 'lcwx', 'lcwx', 'cf4a07c28eddb694094c54a4b2561c83', 'RQ8xz6', '/assets/img/avatar.png', '', 'lcwx@qq.com', 0, NULL, NULL, 4, 0, 0, 0, 1610785526, 1610785526, '', 'normal');
INSERT INTO `fa_admin` VALUES (4, 'wxj', 'wxj', '46b4d4a9e3f1e5d00b37b29682256f66', '786VAf', '/assets/img/avatar.png', '', 'wxj@11.com', 0, NULL, NULL, 7, 0, 0, 0, 1610785550, 1610785550, '', 'normal');
INSERT INTO `fa_admin` VALUES (5, 'wzh', 'wzh', '2fdf4bd3428ee301fd46fcb030dbf01b', 'SbVMFG', '/assets/img/avatar.png', '', 'wzh@qq.com', 0, NULL, NULL, 4, 0, 0, 0, 1610785590, 1610785590, '', 'normal');
INSERT INTO `fa_admin` VALUES (6, 'wzl', '王芝林', '2d9eea8546b802f274374416a83d0c5a', '0goxw3', '/assets/img/avatar.png', '', 'wzj@ss.com', 0, NULL, NULL, 2, 0, 0, 0, 1610785651, 1610785651, '', 'normal');
INSERT INTO `fa_admin` VALUES (7, 'wjwj', 'wjwj', '63e296582d36c9e97092debc4a21d2ef', 'EAewkD', '/assets/img/avatar.png', '', 'wj@qq.com', 0, NULL, NULL, 14, 0, 0, 0, 1610785932, 1610785932, '', 'normal');
INSERT INTO `fa_admin` VALUES (8, 'gywl', 'gywl', '42aaa7731697d56a2f458f3fd53b3a54', 'GSuDVw', '/assets/img/avatar.png', '', 'gywl@qq.com', 0, NULL, NULL, 5, 0, 0, 0, 1610788601, 1610858948, '', 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_admin_log`;
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '日志标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员日志表';

-- ----------------------------
-- Records of fa_admin_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_area
-- ----------------------------
DROP TABLE IF EXISTS `fa_area`;
CREATE TABLE `fa_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级 0 1 2 省市区县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='地区表';

-- ----------------------------
-- Records of fa_area
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fa_attachment`;
CREATE TABLE `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '高度',
  `imagetype` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filename` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) DEFAULT NULL COMMENT '创建日期',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` int(10) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='附件表';

-- ----------------------------
-- Records of fa_attachment
-- ----------------------------
BEGIN;
INSERT INTO `fa_attachment` VALUES (1, 1, 0, '/assets/img/qrcode.png', '150', '150', 'png', 0, 'qrcode.png', 21859, 'image/png', '', 1499681848, 1499681848, 1499681848, 'local', '17163603d0263e4838b9387ff2cd4877e8b018f6');
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group`;
CREATE TABLE `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '规则ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='分组表';

-- ----------------------------
-- Records of fa_auth_group
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_group` VALUES (1, 0, 'Admin group', '*', 1490883540, 149088354, 'normal');
INSERT INTO `fa_auth_group` VALUES (4, 1, '普通会员', '1,8,13,29,30,31,32,33,34,86,88,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,2,85', 1490883540, 1606291831, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_group_access`;
CREATE TABLE `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='权限分组表';

-- ----------------------------
-- Records of fa_auth_group_access
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_group_access` VALUES (1, 1);
INSERT INTO `fa_auth_group_access` VALUES (2, 4);
INSERT INTO `fa_auth_group_access` VALUES (3, 4);
INSERT INTO `fa_auth_group_access` VALUES (4, 4);
INSERT INTO `fa_auth_group_access` VALUES (5, 4);
INSERT INTO `fa_auth_group_access` VALUES (6, 4);
INSERT INTO `fa_auth_group_access` VALUES (7, 4);
INSERT INTO `fa_auth_group_access` VALUES (8, 1);
INSERT INTO `fa_auth_group_access` VALUES (8, 4);
COMMIT;

-- ----------------------------
-- Table structure for fa_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_auth_rule`;
CREATE TABLE `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图标',
  `condition` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '条件',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `weigh` (`weigh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='节点表';

-- ----------------------------
-- Records of fa_auth_rule
-- ----------------------------
BEGIN;
INSERT INTO `fa_auth_rule` VALUES (1, 'file', 0, 'dashboard2', '控制台', 'fa fa-dashboard', '', 'Dashboard tips', 1, 1497429920, 1605059473, 143, 'normal');
INSERT INTO `fa_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', 1, 1497429920, 1497430169, 137, 'normal');
INSERT INTO `fa_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-leaf', '', 'Category tips', 0, 1497429920, 1605059443, 119, 'normal');
INSERT INTO `fa_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', 0, 1502035509, 1604544433, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', 1, 1497429920, 1497430092, 99, 'normal');
INSERT INTO `fa_auth_rule` VALUES (6, 'file', 2, 'general/config', '系统配置', 'fa fa-cog', '', '', 1, 1497429920, 1606269409, 60, 'normal');
INSERT INTO `fa_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', 1, 1497429920, 1603704822, 53, 'normal');
INSERT INTO `fa_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user', '', '', 1, 1497429920, 1497429920, 34, 'normal');
INSERT INTO `fa_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Admin', 'fa fa-user', '', 'Admin tips', 1, 1497429920, 1497430320, 118, 'normal');
INSERT INTO `fa_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Admin log', 'fa fa-list-alt', '', 'Admin log tips', 1, 1497429920, 1497430307, 113, 'normal');
INSERT INTO `fa_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', 1, 1497429920, 1497429920, 109, 'normal');
INSERT INTO `fa_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', 1, 1497429920, 1497430581, 104, 'normal');
INSERT INTO `fa_auth_rule` VALUES (13, 'file', 1, 'dashboard2/index', '查看', 'fa fa-circle-o', '', '', 0, 1497429920, 1606268443, 136, 'normal');
INSERT INTO `fa_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 52, 'normal');
INSERT INTO `fa_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 51, 'normal');
INSERT INTO `fa_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 50, 'normal');
INSERT INTO `fa_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 49, 'normal');
INSERT INTO `fa_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 48, 'normal');
INSERT INTO `fa_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', 'Attachment tips', 0, 1497429920, 1497429920, 59, 'normal');
INSERT INTO `fa_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 58, 'normal');
INSERT INTO `fa_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 57, 'normal');
INSERT INTO `fa_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 56, 'normal');
INSERT INTO `fa_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 55, 'normal');
INSERT INTO `fa_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 54, 'normal');
INSERT INTO `fa_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 33, 'normal');
INSERT INTO `fa_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 32, 'normal');
INSERT INTO `fa_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 31, 'normal');
INSERT INTO `fa_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 30, 'normal');
INSERT INTO `fa_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 29, 'normal');
INSERT INTO `fa_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 28, 'normal');
INSERT INTO `fa_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', 'Category tips', 0, 1497429920, 1497429920, 142, 'normal');
INSERT INTO `fa_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 141, 'normal');
INSERT INTO `fa_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 140, 'normal');
INSERT INTO `fa_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 139, 'normal');
INSERT INTO `fa_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 138, 'normal');
INSERT INTO `fa_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', 'Admin tips', 0, 1497429920, 1497429920, 117, 'normal');
INSERT INTO `fa_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 116, 'normal');
INSERT INTO `fa_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 115, 'normal');
INSERT INTO `fa_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 114, 'normal');
INSERT INTO `fa_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', 'Admin log tips', 0, 1497429920, 1497429920, 112, 'normal');
INSERT INTO `fa_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 111, 'normal');
INSERT INTO `fa_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 110, 'normal');
INSERT INTO `fa_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', 'Group tips', 0, 1497429920, 1497429920, 108, 'normal');
INSERT INTO `fa_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 107, 'normal');
INSERT INTO `fa_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 106, 'normal');
INSERT INTO `fa_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 105, 'normal');
INSERT INTO `fa_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', 'Rule tips', 0, 1497429920, 1497429920, 103, 'normal');
INSERT INTO `fa_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 102, 'normal');
INSERT INTO `fa_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 101, 'normal');
INSERT INTO `fa_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1497429920, 1497429920, 100, 'normal');
INSERT INTO `fa_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', 'Addon tips', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (59, 'file', 4, 'addon/downloaded', 'Local addon', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1502035509, 1502035509, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (66, 'file', 0, 'user', 'User', 'fa fa-list', '', '', 0, 1516374729, 1604544455, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (67, 'file', 66, 'user/user', 'User', 'fa fa-user', '', '', 0, 1516374729, 1604544955, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (68, 'file', 67, 'user/user/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (69, 'file', 67, 'user/user/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (70, 'file', 67, 'user/user/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (71, 'file', 67, 'user/user/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (72, 'file', 67, 'user/user/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (73, 'file', 66, 'user/group', 'User group', 'fa fa-users', '', '', 0, 1516374729, 1604544956, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (74, 'file', 73, 'user/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (75, 'file', 73, 'user/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (76, 'file', 73, 'user/group/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (77, 'file', 73, 'user/group/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (78, 'file', 73, 'user/group/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (79, 'file', 66, 'user/rule', 'User rule', 'fa fa-circle-o', '', '', 0, 1516374729, 1604544957, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (80, 'file', 79, 'user/rule/index', 'View', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (81, 'file', 79, 'user/rule/del', 'Del', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (82, 'file', 79, 'user/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (83, 'file', 79, 'user/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (84, 'file', 79, 'user/rule/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1516374729, 1516374729, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (85, 'file', 0, 'device', '带宽管理', 'fa fa-cloud-upload', '', '', 1, 1603179088, 1606269966, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (86, 'file', 88, 'device/device/index', '查看', 'fa fa-circle-o', '', '', 0, 1603416656, 1606270452, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (88, 'file', 85, 'device/device', '设备管理', 'fa fa-server', '', '', 1, 1603862185, 1605836054, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (90, 'file', 85, 'device/app', '应用管理', 'fa fa-gg', '', '', 1, 1604545135, 1604546169, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (91, 'file', 85, '/device/chart', '统计图表', 'fa fa-bar-chart', '', '', 0, 1605839413, 1606208581, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (92, 'file', 88, 'device/device/add', '添加', 'fa fa-circle-o', '', '', 0, 1606270374, 1606270399, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (93, 'file', 88, 'device/device/edit', '编辑', 'fa fa-circle-o', '', '', 0, 1606270568, 1606270568, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (94, 'file', 88, 'device/device/del', '删除', 'fa fa-circle-o', '', '', 0, 1606270590, 1606270590, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (95, 'file', 88, 'device/device/chart_info', '图表', 'fa fa-circle-o', '', '', 0, 1606270669, 1606270669, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (96, 'file', 88, 'device/device/get_chart_speed_data', '图表_用于加载某月的数据_必选', 'fa fa-circle-o', '', '', 0, 1606270792, 1606270952, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (97, 'file', 88, 'device/device/get_chart_speed_date_detail', '图表_用于加载某天的数据_必选', 'fa fa-circle-o', '', '', 0, 1606270940, 1606270940, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (98, 'file', 88, 'device/device/detail', '详情', 'fa fa-circle-o', '', '', 0, 1606271038, 1606271446, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (99, 'file', 88, 'device/device/get_traffic_count', '详情_每日带宽数据统计_必选', 'fa fa-circle-o', '', '', 0, 1606271175, 1606271175, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (100, 'file', 88, 'device/device/get_device_dot_log', '详情_每5分钟带宽情细列表', 'fa fa-circle-o', '', '', 0, 1606271296, 1606271331, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (101, 'file', 88, 'device/device/get_device_pack_log', '详情_每次取点的具体流量日志', 'fa fa-circle-o', '', '', 0, 1606271427, 1606271427, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (102, 'file', 88, 'device/device/get_device_log', '详情_设备异常日志查看', 'fa fa-circle-o', '', '', 0, 1606271516, 1606271516, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (103, 'file', 1, 'dashboard2/count_dl', '电联数据列表', 'fa fa-circle-o', '', '', 0, 1606291561, 1606291561, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (104, 'file', 1, 'dashboard2/count_yd', '移动数据列表', 'fa fa-circle-o', '', '', 0, 1606291594, 1606291594, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (105, 'file', 1, 'dashboard2/get_chart_speed_data', '按月取图表数据', 'fa fa-circle-o', '', '', 0, 1606291709, 1606291709, 0, 'normal');
INSERT INTO `fa_auth_rule` VALUES (106, 'file', 1, 'dashboard2/get_chart_speed_date_detail', '按天取图表数据', 'fa fa-circle-o', '', '', 0, 1606291813, 1606293004, 0, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_category
-- ----------------------------
DROP TABLE IF EXISTS `fa_category`;
CREATE TABLE `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `weigh` (`weigh`,`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='分类表';

-- ----------------------------
-- Records of fa_category
-- ----------------------------
BEGIN;
INSERT INTO `fa_category` VALUES (1, 0, 'page', '官方新闻', 'news', 'recommend', '/assets/img/qrcode.png', '', '', 'news', 1495262190, 1495262190, 1, 'normal');
INSERT INTO `fa_category` VALUES (2, 0, 'page', '移动应用', 'mobileapp', 'hot', '/assets/img/qrcode.png', '', '', 'mobileapp', 1495262244, 1495262244, 2, 'normal');
INSERT INTO `fa_category` VALUES (3, 2, 'page', '微信公众号', 'wechatpublic', 'index', '/assets/img/qrcode.png', '', '', 'wechatpublic', 1495262288, 1495262288, 3, 'normal');
INSERT INTO `fa_category` VALUES (4, 2, 'page', 'Android开发', 'android', 'recommend', '/assets/img/qrcode.png', '', '', 'android', 1495262317, 1495262317, 4, 'normal');
INSERT INTO `fa_category` VALUES (5, 0, 'page', '软件产品', 'software', 'recommend', '/assets/img/qrcode.png', '', '', 'software', 1495262336, 1499681850, 5, 'normal');
INSERT INTO `fa_category` VALUES (6, 5, 'page', '网站建站', 'website', 'recommend', '/assets/img/qrcode.png', '', '', 'website', 1495262357, 1495262357, 6, 'normal');
INSERT INTO `fa_category` VALUES (7, 5, 'page', '企业管理软件', 'company', 'index', '/assets/img/qrcode.png', '', '', 'company', 1495262391, 1495262391, 7, 'normal');
INSERT INTO `fa_category` VALUES (8, 6, 'page', 'PC端', 'website-pc', 'recommend', '/assets/img/qrcode.png', '', '', 'website-pc', 1495262424, 1495262424, 8, 'normal');
INSERT INTO `fa_category` VALUES (9, 6, 'page', '移动端', 'website-mobile', 'recommend', '/assets/img/qrcode.png', '', '', 'website-mobile', 1495262456, 1495262456, 9, 'normal');
INSERT INTO `fa_category` VALUES (10, 7, 'page', 'CRM系统 ', 'company-crm', 'recommend', '/assets/img/qrcode.png', '', '', 'company-crm', 1495262487, 1495262487, 10, 'normal');
INSERT INTO `fa_category` VALUES (11, 7, 'page', 'SASS平台软件', 'company-sass', 'recommend', '/assets/img/qrcode.png', '', '', 'company-sass', 1495262515, 1495262515, 11, 'normal');
INSERT INTO `fa_category` VALUES (12, 0, 'test', '测试1', 'test1', 'recommend', '/assets/img/qrcode.png', '', '', 'test1', 1497015727, 1497015727, 12, 'normal');
INSERT INTO `fa_category` VALUES (13, 0, 'test', '测试2', 'test2', 'recommend', '/assets/img/qrcode.png', '', '', 'test2', 1497015738, 1497015738, 13, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_config
-- ----------------------------
DROP TABLE IF EXISTS `fa_config`;
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '分组',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '变量字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='系统配置';

-- ----------------------------
-- Records of fa_config
-- ----------------------------
BEGIN;
INSERT INTO `fa_config` VALUES (1, 'name', 'basic', 'Site name', '请填写站点名称', 'string', '我的网站', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (2, 'beian', 'basic', 'Beian', '粤ICP备15000000号-1', 'string', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (3, 'cdnurl', 'basic', 'Cdn url', '如果全站静态资源使用第三方云储存请配置该值', 'string', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (4, 'version', 'basic', 'Version', '如果静态资源有变动请重新配置该值', 'string', '1.0.1', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (5, 'timezone', 'basic', 'Timezone', '', 'string', 'Asia/Shanghai', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (6, 'forbiddenip', 'basic', 'Forbidden ip', '一行一条记录', 'text', '', '', '', '', NULL);
INSERT INTO `fa_config` VALUES (7, 'languages', 'basic', 'Languages', '', 'array', '{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (8, 'fixedpage', 'basic', 'Fixed page', '请尽量输入左侧菜单栏存在的链接', 'string', 'dashboard', '', 'required', '', NULL);
INSERT INTO `fa_config` VALUES (9, 'categorytype', 'dictionary', 'Category type', '', 'array', '{\"default\":\"Default\",\"page\":\"Page\",\"article\":\"Article\",\"test\":\"Test\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (10, 'configgroup', 'dictionary', 'Config group', '', 'array', '{\"basic\":\"Basic\",\"email\":\"Email\",\"dictionary\":\"Dictionary\",\"user\":\"User\",\"example\":\"Example\"}', '', '', '', '');
INSERT INTO `fa_config` VALUES (11, 'mail_type', 'email', 'Mail type', '选择邮件发送方式', 'select', '1', '[\"请选择\",\"SMTP\",\"Mail\"]', '', '', '');
INSERT INTO `fa_config` VALUES (12, 'mail_smtp_host', 'email', 'Mail smtp host', '错误的配置发送邮件会导致服务器超时', 'string', 'smtp.qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (13, 'mail_smtp_port', 'email', 'Mail smtp port', '(不加密默认25,SSL默认465,TLS默认587)', 'string', '465', '', '', '', '');
INSERT INTO `fa_config` VALUES (14, 'mail_smtp_user', 'email', 'Mail smtp user', '（填写完整用户名）', 'string', '10000', '', '', '', '');
INSERT INTO `fa_config` VALUES (15, 'mail_smtp_pass', 'email', 'Mail smtp password', '（填写您的密码）', 'string', 'password', '', '', '', '');
INSERT INTO `fa_config` VALUES (16, 'mail_verify_type', 'email', 'Mail vertify type', '（SMTP验证方式[推荐SSL]）', 'select', '2', '[\"无\",\"TLS\",\"SSL\"]', '', '', '');
INSERT INTO `fa_config` VALUES (17, 'mail_from', 'email', 'Mail from', '', 'string', '10000@qq.com', '', '', '', '');
INSERT INTO `fa_config` VALUES (18, 'soft_down_url', 'basic', '监测软件下载地址', '监测软件下载地址', 'string', 'https://github.com/cgghui/traffic_monitor/releases/download/2020.11.26/traffic_ware_client_linux_64.zip', '', 'url', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (19, 'service_api_url', 'basic', '监控软件 API URL', '', 'string', 'http://127.0.0.1:86', '', 'url', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (22, 'dxlt_unit_price', 'basic', '电信和联通的结算单价（元）', '', 'number', '2500', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
INSERT INTO `fa_config` VALUES (23, 'yd_unit_price', 'basic', '移动的结算单价（元）', '', 'number', '2000', '', '', '', '{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
COMMIT;

-- ----------------------------
-- Table structure for fa_ems
-- ----------------------------
DROP TABLE IF EXISTS `fa_ems`;
CREATE TABLE `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='邮箱验证码表';

-- ----------------------------
-- Records of fa_ems
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_sms
-- ----------------------------
DROP TABLE IF EXISTS `fa_sms`;
CREATE TABLE `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'IP',
  `createtime` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='短信验证码表';

-- ----------------------------
-- Records of fa_sms
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_test
-- ----------------------------
DROP TABLE IF EXISTS `fa_test`;
CREATE TABLE `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片',
  `images` varchar(1500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '关键字',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '描述',
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '省市',
  `json` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置:key=名称,value=值',
  `price` float(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) DEFAULT NULL COMMENT '刷新时间(int)',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='测试表';

-- ----------------------------
-- Records of fa_test
-- ----------------------------
BEGIN;
INSERT INTO `fa_test` VALUES (1, 0, 12, '12,13', 'monday', 'hot,index', 'male', 'music,reading', '我是一篇测试文章', '<p>我是测试内容</p>', '/assets/img/avatar.png', '/assets/img/avatar.png,/assets/img/qrcode.png', '/assets/img/avatar.png', '关键字', '描述', '广西壮族自治区/百色市/平果县', '{\"a\":\"1\",\"b\":\"2\"}', 0.00, 0, '2017-07-10', '2017-07-10 18:24:45', 2017, '18:24:45', 1499682285, 1499682526, 1499682526, NULL, 0, 1, 'normal', '1');
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_95_dxlt
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_95_dxlt`;
CREATE TABLE `fa_traffic_network_counts_95_dxlt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `device_disk_uuid` varchar(64) NOT NULL COMMENT '设备编号',
  `total_dot` smallint(4) unsigned NOT NULL COMMENT '总取点次数',
  `posi` smallint(4) unsigned NOT NULL COMMENT '排序后 95取点的位置',
  `speed_byte` bigint(16) unsigned NOT NULL COMMENT '95点位的速度，为字节速度（不是bit）',
  `free_dot` smallint(4) unsigned NOT NULL COMMENT '总取点中所含的空闲点数（速度为0的）',
  `add_dot` smallint(4) unsigned NOT NULL COMMENT '不足288点时，补足的次数',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `device_disk_uuid` (`device_disk_uuid`,`year_month`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_95_dxlt
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_95_yd
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_95_yd`;
CREATE TABLE `fa_traffic_network_counts_95_yd` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `device_disk_uuid` varchar(64) NOT NULL COMMENT '设备编号',
  `total_dot` smallint(4) unsigned NOT NULL COMMENT '总取点次数',
  `posi` smallint(4) unsigned NOT NULL COMMENT '排序后 95取点的位置',
  `speed_byte` bigint(16) unsigned NOT NULL COMMENT '95点位的速度，为字节速度（不是bit）',
  `free_dot` smallint(4) unsigned NOT NULL COMMENT '总取点中所含的空闲点数（速度为0的）',
  `add_dot` smallint(4) unsigned NOT NULL COMMENT '不足288点时，补足的次数',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `device_disk_uuid` (`device_disk_uuid`,`year_month`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_95_yd
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_dxlt
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_dxlt`;
CREATE TABLE `fa_traffic_network_counts_dxlt` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `source` enum('system_ware','iqiyi') NOT NULL DEFAULT 'system_ware',
  `count_n_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '未被计入的下载流量',
  `count_n_u` bigint(16) NOT NULL DEFAULT '0' COMMENT '未被计入的上传流量',
  `count_y_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的下载流量',
  `count_y_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的上传流量',
  `total_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计下载流量',
  `total_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计上传流量',
  `log_upload_time` datetime NOT NULL COMMENT '日志时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '建入时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `log_upload_time` (`log_upload_time`,`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_dxlt
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_dxlt_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_dxlt_user`;
CREATE TABLE `fa_traffic_network_counts_dxlt_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `source` enum('system_ware','iqiyi') NOT NULL DEFAULT 'system_ware',
  `count_n_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '未被计入的下载流量',
  `count_n_u` bigint(16) NOT NULL DEFAULT '0' COMMENT '未被计入的上传流量',
  `count_y_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的下载流量',
  `count_y_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的上传流量',
  `total_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计下载流量',
  `total_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计上传流量',
  `log_upload_time` datetime NOT NULL COMMENT '日志时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '建入时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `log_upload_time` (`user_id`,`log_upload_time`,`source`) USING BTREE,
  KEY `log_upload_time_2` (`log_upload_time`,`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_dxlt_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_yd
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_yd`;
CREATE TABLE `fa_traffic_network_counts_yd` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `source` enum('system_ware','iqiyi') NOT NULL DEFAULT 'system_ware',
  `count_n_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '未被计入的下载流量',
  `count_n_u` bigint(16) NOT NULL DEFAULT '0' COMMENT '未被计入的上传流量',
  `count_y_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的下载流量',
  `count_y_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的上传流量',
  `total_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计下载流量',
  `total_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计上传流量',
  `log_upload_time` datetime NOT NULL COMMENT '日志时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '建入时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `log_upload_time` (`log_upload_time`,`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_yd
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_counts_yd_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_counts_yd_user`;
CREATE TABLE `fa_traffic_network_counts_yd_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL COMMENT '用户编号',
  `year_month` date NOT NULL COMMENT '统计的年月日',
  `source` enum('system_ware','iqiyi') NOT NULL DEFAULT 'system_ware',
  `count_n_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '未被计入的下载流量',
  `count_n_u` bigint(16) NOT NULL DEFAULT '0' COMMENT '未被计入的上传流量',
  `count_y_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的下载流量',
  `count_y_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的上传流量',
  `total_d` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计下载流量',
  `total_u` bigint(16) unsigned NOT NULL DEFAULT '0' COMMENT '总计上传流量',
  `log_upload_time` datetime NOT NULL COMMENT '日志时间',
  `updated_at` datetime NOT NULL COMMENT '修改时间',
  `created_at` datetime NOT NULL COMMENT '建入时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `log_upload_time` (`user_id`,`log_upload_time`,`source`) USING BTREE,
  KEY `log_upload_time_2` (`log_upload_time`,`source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_counts_yd_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_network_logs
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_network_logs`;
CREATE TABLE `fa_traffic_network_logs` (
  `id` bigint(16) unsigned NOT NULL AUTO_INCREMENT,
  `device_disk_uuid` varchar(64) NOT NULL COMMENT '设备的硬盘编号',
  `count_n_d` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '未被计入的下载流量',
  `count_n_u` int(10) NOT NULL DEFAULT '0' COMMENT '未被计入的上传流量',
  `count_y_d` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的下载流量',
  `count_y_u` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已被计入的上传流量',
  `total_d` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总计下载流量',
  `total_u` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '总计上传流量',
  `log_offset` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日志的起始位置',
  `log_length` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '日志的长度',
  `log_date` date NOT NULL COMMENT '日志归属日期',
  `log_upload_time` datetime DEFAULT NULL COMMENT '日志上传时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `user_id_5` (`device_disk_uuid`,`log_upload_time`) USING BTREE,
  KEY `used_device_disk_uuid` (`device_disk_uuid`,`log_date`) USING BTREE,
  KEY `log_date` (`device_disk_uuid`,`log_date`,`log_upload_time`) USING BTREE,
  KEY `user_id_3` (`device_disk_uuid`) USING BTREE,
  KEY `user_id_4` (`log_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_network_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_user_apps
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_user_apps`;
CREATE TABLE `fa_traffic_user_apps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `secret_key` varchar(128) NOT NULL,
  `disabled` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '是否禁用',
  `online_device_max` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '最大设备数量',
  `created_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '加入时间',
  `updated_at` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_user_apps
-- ----------------------------
BEGIN;
INSERT INTO `fa_traffic_user_apps` VALUES (1, 1, 'xx', 'N', 3, '2020-11-23 16:35:46', '2020-11-23 16:35:46', NULL);
INSERT INTO `fa_traffic_user_apps` VALUES (2, 2, 'bb', 'N', 0, '2020-11-23 16:35:28', '2020-11-23 16:35:28', NULL);
INSERT INTO `fa_traffic_user_apps` VALUES (3, 1, 'YN3V6MFLCEQ0KYH0FEKUYV1DVVXLJ8NRV', 'N', 3, '2020-11-26 10:26:17', '2020-11-26 10:26:17', '2020-11-26 10:26:17');
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_user_device_logs
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_user_device_logs`;
CREATE TABLE `fa_traffic_user_device_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_ip` varchar(64) NOT NULL DEFAULT '' COMMENT '客户端IP',
  `user_id` int(10) unsigned NOT NULL,
  `device_id` int(10) unsigned NOT NULL,
  `status` enum('connected','disconnect','unknown','rejected','write_error','read_error','abnormal','lock','collect_fail') NOT NULL DEFAULT 'unknown' COMMENT '状态',
  `message` varchar(128) NOT NULL COMMENT '消息',
  `report_date` date NOT NULL COMMENT '报告日期',
  `report_datetime` datetime NOT NULL COMMENT '报告日期时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `device_id` (`device_id`,`report_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_user_device_logs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_traffic_user_devices
-- ----------------------------
DROP TABLE IF EXISTS `fa_traffic_user_devices`;
CREATE TABLE `fa_traffic_user_devices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source` enum('system_ware','iqiyi') NOT NULL DEFAULT 'system_ware',
  `user_id` int(10) unsigned NOT NULL COMMENT '归属账号',
  `ip` varchar(64) NOT NULL COMMENT 'SSH设备IP地址',
  `ip_address` varchar(64) NOT NULL COMMENT 'ip归属地',
  `isp` varchar(64) NOT NULL COMMENT '网络服务提供商\n\n',
  `ssh_connect_method` enum('direct','hidden','later') NOT NULL DEFAULT 'later' COMMENT 'SSH连接方式',
  `ssh_port` varchar(64) NOT NULL COMMENT 'SSH设备端口地址',
  `ssh_username` varchar(64) NOT NULL COMMENT 'SSH设备账号',
  `ssh_password` varchar(64) NOT NULL COMMENT 'SSH设备密码',
  `status_review` enum('waiting','rejected','pass') NOT NULL DEFAULT 'waiting' COMMENT '审核状态\r\nwaiting    待审\r\nrejected   驳回\r\npass        通过',
  `status_device` enum('wait_handshake','online','offline','abnormal','lock') NOT NULL DEFAULT 'offline' COMMENT '设备状态\r\nonline      在线\r\noffline      离线\r\nabnormal 异常\r\nlock         锁定 ',
  `broadband_down` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下行带宽大小，byte计',
  `broadband_up` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上行带宽大小，byte计',
  `disk_uuid` varchar(64) NOT NULL COMMENT '硬盘uuid',
  `network_card_speed` varchar(32) NOT NULL DEFAULT '' COMMENT '网卡速测',
  `cpu_desc` varchar(64) NOT NULL DEFAULT '' COMMENT 'cpu名称',
  `cpu_core` varchar(32) NOT NULL DEFAULT '' COMMENT 'cpu核心数',
  `cpu_core_thread` varchar(32) NOT NULL DEFAULT '' COMMENT 'cpu每个核心的线程数',
  `cpu_core_frequency` varchar(32) NOT NULL DEFAULT '' COMMENT 'cpu每个核心的频率',
  `today_95` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当日95速度，每5分钟更新',
  `month_95` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当月95速度，每天更新，不记入当天',
  `up_month_95` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上月95速度，每个月更新一次',
  `up_month_average` bigint(16) unsigned NOT NULL COMMENT '上月平台速度，每个月更新一次',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `statistics_enable_time` datetime NOT NULL COMMENT '统计启用时间\n\n',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `disk_uuid` (`disk_uuid`) USING BTREE,
  KEY `ip` (`ip`) USING BTREE,
  KEY `used_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of fa_traffic_user_devices
-- ----------------------------
BEGIN;
INSERT INTO `fa_traffic_user_devices` VALUES (1, 'iqiyi', 3, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '3296CF2705402F40', '', '', '', '', '', 472033964, 575722304, 0, 0, '2021-01-16 15:56:22', '2021-01-17 13:57:19', NULL, '2020-12-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (2, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '046EC3224A6DC155', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (3, 'iqiyi', 3, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0F92D19408D0F695', '', '', '', '', '', 404963384, 391798731, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (4, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1A7BC5E56123FD56', '', '', '', '', '', 107047851, 110582523, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (5, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '28B11A1A0A32DC30', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (6, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '4AD8D512E3CA93C2', '', '', '', '', '', 0, 40192818, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (7, 'iqiyi', 3, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '5F750BD256E70199', '', '', '', '', '', 364715089, 395468921, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (8, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '62E0C0F2AF6A77E4', '', '', '', '', '', 75512123, 103111521, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (9, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A332EF47F631F92C', '', '', '', '', '', 67773692, 104189496, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (10, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C9ADFBBB51AF9C01', '', '', '', '', '', 86662370, 105884793, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (11, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F3FB36209AD0095B', '', '', '', '', '', 44781615, 69982583, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (12, 'iqiyi', 3, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F802E5EE067E602E', '', '', '', '', '', 496804595, 509014386, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (13, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'FB0F0C937FF1602E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (14, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0078267ABEA13B95', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (15, 'iqiyi', 8, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '014113160EFD06A1', '', '', '', '', '', 88961426, 82482496, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (16, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '014CD0FDEC4430E5', '', '', '', '', '', 22168018, 31452989, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (17, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '01EE94A93DC102EA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (18, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '023A5FA0ACD54A2A', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (19, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0275A10DC624CB6C', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (20, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '03024434EAF6FFE2', '', '', '', '', '', 83174167, 77292683, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (21, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0337F2DB1D0F00C3', '', '', '', '', '', 144974629, 120835619, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (22, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '034964FAC1A5DD01', '', '', '', '', '', 0, 26356817, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (23, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0370A7273E191AAF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (24, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0392B7D7D416D55F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (25, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '040FBBEFF3BD0D32', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (26, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '041651680918CB79', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (27, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '041AEE6138D8ACEE', '', '', '', '', '', 147277323, 155034075, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (28, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0499E31346E7D301', '', '', '', '', '', 103968323, 115177939, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (29, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '04E961B1FDF406B4', '', '', '', '', '', 104806457, 144666093, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (30, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '05E39ECF0F0CAC67', '', '', '', '', '', 79567422, 112270160, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (31, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '06053D6B5F4FB00F', '', '', '', '', '', 56112223, 157842364, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (32, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0662486001E161E0', '', '', '', '', '', 75646394, 78523608, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (33, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0676F0931894AA18', '', '', '', '', '', 121857574, 152057872, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (34, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '06B22A1C012402C9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (35, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '06F9E19F2A0D4A5E', '', '', '', '', '', 107335006, 172727182, 0, 0, '2021-01-16 16:44:57', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (36, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '070021670BF66D38', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (37, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '07201E630A4BB459', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (38, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '075E9F2F969AD424', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (39, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '077E477998C0DD34', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (40, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '077F34D1CEA60B1A', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (41, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '07EBB663707BC574', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (42, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '080074CE6B0043A6', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (43, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0832CDC895A6E101', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:57', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (44, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '08A9CFE5687C0371', '', '', '', '', '', 46844329, 52952440, 0, 0, '2021-01-16 16:44:58', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (45, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '091C537B14C1FCD6', '', '', '', '', '', 134303584, 177649526, 0, 0, '2021-01-16 16:44:58', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (46, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0961EADFA5C746E2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:58', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (47, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '09B565BADA9E0466', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:44:58', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (48, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0A5D0EEE50E7289A', '', '', '', '', '', 101251361, 120100468, 0, 0, '2021-01-16 16:44:58', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (49, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0AA36A49955DC564', '', '', '', '', '', 91588124, 102071245, 0, 0, '2021-01-16 16:44:58', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (50, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0AA63E367B6A3CC4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (51, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0AF0DA9630AFBF54', '', '', '', '', '', 59104525, 79001810, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (52, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0B4B906DD312B8F4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (53, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0B6E561C45582DD8', '', '', '', '', '', 0, 26306377, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (54, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0BD40761B2CE9366', '', '', '', '', '', 0, 138791592, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (55, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0BF4B23B040CDAF7', '', '', '', '', '', 30588918, 34830482, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (56, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0C98223FBB906F9E', '', '', '', '', '', 30509367, 119038829, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (57, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0D494F0ACF660FBB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (58, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0DD78005CF0F4223', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (59, 'iqiyi', 6, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0DE8670ECF45695F', '', '', '', '', '', 0, 4589268, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (60, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0E0BD8D537693E73', '', '', '', '', '', 130676023, 164986899, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (61, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0ECAD7D1983FCD19', '', '', '', '', '', 0, 33733091, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (62, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0EDC4CA9D5A154A9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (63, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '0FA1C07ED354C638', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (64, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '0FEBA51AF1FC05D2', '', '', '', '', '', 113710048, 125267560, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (65, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '10059D46F1B30A7D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (66, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1134F16FE1D61E6F', '', '', '', '', '', 144705818, 173553081, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (67, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '13A109CC5E321DFC', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (68, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '13A6372EAFFC2928', '', '', '', '', '', 26269033, 107025306, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (69, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '14430D0FE4BBC339', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (70, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '145AB61B156B4C07', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (71, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '1471AC930C5B97EA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (72, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '15607595D514A4A7', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (73, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '15CBFB0313BE6D9A', '', '', '', '', '', 75575707, 112092602, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (74, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '167B44AF1318E095', '', '', '', '', '', 18231682, 34770964, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (75, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '1775E7F2036A0EA9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (76, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1777CFAB47F0BCDF', '', '', '', '', '', 211808849, 250453205, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (77, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '17F937714175F3AF', '', '', '', '', '', 63410791, 78671231, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (78, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1813A2609F6C4D9D', '', '', '', '', '', 109903732, 237580619, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (79, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1816A71863D6ECC9', '', '', '', '', '', 0, 72445022, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (80, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '184EB07701A65A79', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (81, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '18C9DC7F0B3DEF54', '', '', '', '', '', 35523977, 35762608, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (82, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '18E5CA580D9A77D8', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (83, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '1B2BAC9DACBBA144', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (84, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '1C47CF9D3AFA0FF4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (85, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1E06F255A30C7A16', '', '', '', '', '', 244718497, 43949777, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (86, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '1F04081A27DD76D1', '', '', '', '', '', 11531822, 4010562, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (87, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '1F0793B2A71D25D9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (88, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '202CEEFC0AF9FF3D', '', '', '', '', '', 88910789, 119952436, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (89, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '205A315F3F42B1A9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (90, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '21F0F3C3716B37E0', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (91, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '229CA54A020A722C', '', '', '', '', '', 102681711, 104884004, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (92, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '22E4CB090CD4EC09', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (93, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '25060EFF102DD768', '', '', '', '', '', 86313979, 130817451, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (94, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '256D9FADB9B7A52A', '', '', '', '', '', 45578229, 53943106, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (95, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2570AA0E143310C3', '', '', '', '', '', 98908003, 119098109, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (96, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '25D80099923BEEDD', '', '', '', '', '', 334622083, 356663769, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (97, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '266B61770CC5CA12', '', '', '', '', '', 0, 39953467, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (98, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '26E5EBB0F7F80B18', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (99, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '26F294A2D05B01C3', '', '', '', '', '', 129533715, 170951837, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (100, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '27D013D9ABFD71E5', '', '', '', '', '', 40137956, 45366691, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (101, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '284446D75B57FFED', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (102, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '2874A848C924E45D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (103, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '289C140C45697708', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (104, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '28AE077538A63C71', '', '', '', '', '', 57737440, 68992087, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (105, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '295B0FBC39740AA6', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (106, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2A1A99C9CCB719D9', '', '', '', '', '', 25479198, 146148729, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (107, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '2A357F45FE31C3FF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (108, 'iqiyi', 5, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2CAE0A03390B422F', '', '', '', '', '', 71340002, 96093358, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (109, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2CE094DE0830222D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (110, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2D6E56DC010C0DF5', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (111, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '2E059B09CD6F711F', '', '', '', '', '', 25115353, 30900533, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (112, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '2E592DEFF021525F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (113, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '309B43710931CA19', '', '', '', '', '', 153109462, 129959560, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (114, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '30DE16EBBF4A55EE', '', '', '', '', '', 108728683, 127025086, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (115, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3146712655EF920F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (116, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '317450DD0F3D33C5', '', '', '', '', '', 24541137, 25417175, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (117, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '31DFAAB8321F46D8', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (118, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '32A963E243A3DE6F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (119, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '32E1A8F1C6662D07', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (120, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '32E6F6531C0F4BA7', '', '', '', '', '', 0, 147077613, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (121, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '32FF6EA62C93A9A9', '', '', '', '', '', 72221527, 89825042, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (122, 'iqiyi', 8, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '330C0208BFDEA0CB', '', '', '', '', '', 128995811, 125367823, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (123, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '330DB876D1C89529', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (124, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '34449DB457C35960', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (125, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '352253DE420B0021', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (126, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '35CC09A6D5BA7E67', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (127, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '367AE0081B634DE4', '', '', '', '', '', 111433500, 143208884, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (128, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '36BF46DE0BB728C3', '', '', '', '', '', 304339655, 343086932, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (129, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '375B799EB47B2FE0', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (130, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '37A9A8F2F84EADF7', '', '', '', '', '', 0, 22270365, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (131, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '3819E6F1A1170ACB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (132, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '382766F72F145106', '', '', '', '', '', 48244303, 59431309, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (133, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '38C907F7C9AFE8FA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (134, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '390B5459A2065EAF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (135, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '39471150A0F14923', '', '', '', '', '', 0, 11565079, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (136, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3AE4653645637FC3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (137, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3CEFEC60049708F4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (138, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '3D251A3AC32415B2', '', '', '', '', '', 74868862, 285608489, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (139, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3D39CC6950461719', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (140, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '3D4EEB4436281A3B', '', '', '', '', '', 83690015, 70001165, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (141, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3EE1D80ACFB80878', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (142, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '3F0D0F49AE6B3446', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:09', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (143, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '40A5073CCDDE42AD', '', '', '', '', '', 153572875, 160597822, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (144, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '40BFEBDD66E90F80', '', '', '', '', '', 40707955, 114459005, 0, 0, '2021-01-16 16:49:09', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (145, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '411B052F18D62DEB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:49:10', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (146, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '41ACC1AD709EF8C8', '', '', '', '', '', 0, 15717889, 0, 0, '2021-01-16 16:49:10', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (147, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '41D1B49E5099D651', '', '', '', '', '', 14558943, 19872927, 0, 0, '2021-01-16 16:49:10', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (148, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '422C989A0AA1A1E6', '', '', '', '', '', 35540007, 42459094, 0, 0, '2021-01-16 16:49:10', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (149, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '430E0A2504CE0397', '', '', '', '', '', 115926724, 144627267, 0, 0, '2021-01-16 16:49:10', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (150, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '45047E460AF00AAC', '', '', '', '', '', 143484701, 216391498, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:19', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (151, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '45E4FE43F0D5696C', '', '', '', '', '', 77473100, 76018421, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (152, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '466F775A312240E2', '', '', '', '', '', 106815030, 130928579, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (153, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '4790AE3FEB030846', '', '', '', '', '', 3612573, 151249245, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (154, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '480924B7DF25FEA2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (155, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '48D33AFDCCD92757', '', '', '', '', '', 119287807, 183627288, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (156, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '49013F092A72ED5F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (157, 'iqiyi', 7, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '4C08ABEDB5010201', '', '', '', '', '', 49720247, 115821215, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (158, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '4CD902123DB037DA', '', '', '', '', '', 68001448, 211827649, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (159, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '4DEC0B6ECCADF5A4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (160, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '4E395B5D1C050D48', '', '', '', '', '', 157377801, 171517773, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (161, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '50E2199F0C000BAF', '', '', '', '', '', 54610049, 53651829, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (162, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5114F709BFB346B3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (163, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '513252500CD5E13A', '', '', '', '', '', 0, 16359702, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (164, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '53A5BD5D690E615D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (165, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '53AC3ACEC9970D66', '', '', '', '', '', 32829308, 47936110, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (166, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '53F209D6E4F550B0', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (167, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '547E0E002C0B5604', '', '', '', '', '', 41734637, 60346167, 0, 0, '2021-01-16 16:53:41', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (168, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '54EC790864CEB054', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (169, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '550B535ADA31D851', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (170, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '550FF1A1A831C8CB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (171, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '5637C84D90AEE96C', '', '', '', '', '', 39199224, 82597746, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (172, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '575BB155A2120F41', '', '', '', '', '', 96895253, 115596712, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (173, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '57A60780FA0F4449', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (174, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '57E0646C07543095', '', '', '', '', '', 67246260, 89697920, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (175, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5848671C1DB67203', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (176, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '59014DC7244E67FA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (177, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '5B2706292747BA9F', '', '', '', '', '', 14767297, 25768480, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (178, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '5BDDFFBE66ED1892', '', '', '', '', '', 117167397, 144394583, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (179, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5C79BD0E620DD9AB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (180, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5CF81978D82ABC0D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (181, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5D9831A79DA723EA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (182, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5E13FE42574CD97D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (183, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5E40FC7397590836', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (184, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '5F0E9A7FB10707CF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (185, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '60091179349FBA39', '', '', '', '', '', 53610687, 79076142, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (186, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '60E738E29E736BE2', '', '', '', '', '', 280034119, 325454832, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (187, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '6179B42602751904', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (188, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '61B9444D753BED73', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (189, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '61C645F4BE133507', '', '', '', '', '', 103657293, 116668426, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (190, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '62804C757255FC39', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (191, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '62CEFC50A366A073', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (192, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '65152BEB96D8B864', '', '', '', '', '', 120471378, 172388891, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (193, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '667453EDBAE00829', '', '', '', '', '', 156301223, 163931144, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (194, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '67E507A27C0A5374', '', '', '', '', '', 16318819, 11761848, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (195, 'iqiyi', 8, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '68AA1C3F3CF2542B', '', '', '', '', '', 111829946, 119915923, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (196, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '694B1543C9015B29', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (197, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '69E05F40BE22EF07', '', '', '', '', '', 55059731, 87207028, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (198, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6A65014DD9B00E92', '', '', '', '', '', 0, 130083808, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (199, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6B0B7BACB0997E47', '', '', '', '', '', 158453337, 202009035, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (200, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6B9B30A893337565', '', '', '', '', '', 0, 24796336, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (201, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '6C0214480BC0479A', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (202, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6C0C589D05C30CA5', '', '', '', '', '', 103741878, 104848935, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (203, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6CC43916B7CF0CEE', '', '', '', '', '', 111339410, 125530694, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (204, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6CEBE80A1FA5BB2F', '', '', '', '', '', 116446062, 136174611, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (205, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '6DBD92B05FA75D2C', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (206, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6E07150925AFCEF6', '', '', '', '', '', 45851385, 48259574, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (207, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6E4E1AB839730549', '', '', '', '', '', 60674741, 100247635, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (208, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6EAFA280EB30284C', '', '', '', '', '', 100560413, 129112916, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (209, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '6F0D3244C72D7A07', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (210, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6F6CB90D5B94CEF8', '', '', '', '', '', 106504732, 126784595, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (211, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '6FC375351A2B5716', '', '', '', '', '', 12150530, 11056463, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (212, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7138779FB7327B58', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (213, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '713BF8A8AACCBA5B', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (214, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '719C08B00CEC100F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (215, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7211E62954A4E964', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (216, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '734FFE9ADE13BA3C', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (217, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '73529A1D80386392', '', '', '', '', '', 151060335, 210278716, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (218, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '73553C623B7D5916', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (219, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '73D44F5020FF1320', '', '', '', '', '', 0, 81647958, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (220, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '73E6A157D674CA07', '', '', '', '', '', 93817959, 127892500, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (221, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7456C8B222FD73EB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (222, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '773F030DA95E6E27', '', '', '', '', '', 30554107, 90212376, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (223, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '78DE59ED0C0FE301', '', '', '', '', '', 36967625, 75763437, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (224, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '79A5D294C72DB4A6', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (225, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '79D10F0656ED5808', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (226, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7AC7234ABC91F418', '', '', '', '', '', 146056123, 256076777, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (227, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7ACBF21A090C0AC2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (228, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7B13B033536DFCF9', '', '', '', '', '', 118335848, 122000998, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (229, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7B33BCCB657017E0', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (230, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7BB66099DC0F976F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (231, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7BB950C6C0725862', '', '', '', '', '', 0, 27398796, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (232, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7C9A3D137C921309', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (233, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7D0CF9E403BC164C', '', '', '', '', '', 71979429, 85581179, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (234, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7D56A50830090037', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (235, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7D9C48EDA42A7C1A', '', '', '', '', '', 103093170, 24080156, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (236, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '7DFAE6D0034D00EE', '', '', '', '', '', 57020288, 72143272, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (237, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7EE939D46ADCB0A2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (238, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '7FF3140325E95FA4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (239, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '800861E7AED4C0EC', '', '', '', '', '', 119724365, 120335272, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (240, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '8010C5D807AC3711', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (241, 'iqiyi', 7, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '924ED0019E752294', '', '', '', '', '', 59392029, 125178497, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (242, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9413CA11EE2CB9ED', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (243, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '94485906EEFEEA08', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (244, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '946665559955B827', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (245, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '94F3564C5B9F0BE3', '', '', '', '', '', 311734158, 332352431, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (246, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '95EFE12631E5B563', '', '', '', '', '', 31513706, 63790011, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (247, 'iqiyi', 5, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '96AAF4EB79CB2B04', '', '', '', '', '', 49602094, 110763542, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (248, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '96C0BAED32336FF7', '', '', '', '', '', 71836907, 30371451, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (249, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '96EB0D21FD3439E7', '', '', '', '', '', 0, 62265350, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (250, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '96FBF3B974AFBED3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (251, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '96FF057FB1C84118', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (252, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9730B52A95CD0F95', '', '', '', '', '', 54736298, 63684072, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (253, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9760D0F179752B4F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (254, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '98FB6354A413DEC2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (255, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '992653BC2D4EC709', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (256, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '99272ACC2075951B', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (257, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9AE9B9BEA10B1B33', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (258, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9B4CEDD8B6AF295D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (259, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9B59C979DAE93E0F', '', '', '', '', '', 71831670, 86453413, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (260, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9BCC4547C471DCF8', '', '', '', '', '', 282034297, 422199248, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (261, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9BFEA8EAB866FCB0', '', '', '', '', '', 118751511, 206660680, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (262, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9C52C4F9F44042E4', '', '', '', '', '', 0, 45254889, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (263, 'iqiyi', 6, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9D0DFBDC1739E04C', '', '', '', '', '', 0, 5960202, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (264, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9D2DBA0162013EF5', '', '', '', '', '', 491774, 145799181, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (265, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9DD5AC3DFA1D199E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (266, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9EC0635FB7A835D0', '', '', '', '', '', 39522716, 51689069, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (267, 'iqiyi', 7, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9F44373C5A0225F4', '', '', '', '', '', 3061162, 144824252, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (268, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9F924B020B6D356E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (269, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, '9FA5C97470251711', '', '', '', '', '', 0, 16671074, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (270, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, '9FEE95AA3AF763F7', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (271, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A02B05BCE268C3A9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (272, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A31CDA1369ABE66E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (273, 'iqiyi', 5, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A3E7A280BCE637C3', '', '', '', '', '', 42737414, 83523231, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (274, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A3FD0D9B255E0F03', '', '', '', '', '', 0, 40063007, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (275, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A457C85DE8674EB1', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (276, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A5121E0B7750E769', '', '', '', '', '', 98851281, 116141631, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (277, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A51307BBE018B442', '', '', '', '', '', 21381806, 50348597, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (278, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A5527722F2A66F42', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (279, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A6B6A348FF386F3B', '', '', '', '', '', 0, 16250365, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (280, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A7733C4A93E22C47', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (281, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A80B4BD3A6E94EA7', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (282, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'A8B33BDF0D5B0E24', '', '', '', '', '', 103346367, 115600713, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (283, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A8E1AA145EDEAA0D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (284, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'A97E104E32DBB3BB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (285, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AA5402A8E9027367', '', '', '', '', '', 115262566, 126271331, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (286, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AACF52D0F1C49E9F', '', '', '', '', '', 51014556, 59791312, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (287, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'ABCE0BF7439EF0E3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (288, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'AD0507C009D13208', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (289, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'ADD7C292C640B5AB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (290, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AE57B50DAFF6CE34', '', '', '', '', '', 28042825, 32417034, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (291, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'AE5E7275FC42444F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (292, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AF91620D50BE671F', '', '', '', '', '', 0, 116578913, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (293, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AF9BC509CE9E4E68', '', '', '', '', '', 145812245, 201372389, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (294, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'AFAD0860F07F0F7C', '', '', '', '', '', 102576347, 324543704, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (295, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B0BB00CFEC6A36D4', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (296, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B20E0D55F2361805', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (297, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B263DBF11A04621F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (298, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B2D6DDF31340FE65', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:53:42', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (299, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B4E80974BD430F0A', '', '', '', '', '', 44987929, 45190060, 0, 0, '2021-01-16 16:53:42', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (300, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B534FBDB4CAFC228', '', '', '', '', '', 0, 70049537, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (301, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B568FDF0B41C4E67', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (302, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B64721CDB4A8306F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (303, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B64A303E72C2CA49', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (304, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B70341A40DCE0E3D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (305, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B73220AA0F481E3B', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (306, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B7526ED05D06B51E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (307, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B85F6AEE3302060D', '', '', '', '', '', 83521954, 107771793, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (308, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'B90C0E2B5A12A86D', '', '', '', '', '', 55695700, 10495228, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (309, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B99A775B097003D6', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (310, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'B9D62FE5F8A9029C', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (311, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BA0E15AB687B76AE', '', '', '', '', '', 189177962, 405681365, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (312, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'BACB0C6DCF95359D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (313, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BAD74204F3970F09', '', '', '', '', '', 0, 49169606, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (314, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BAE0B03FD22E09DE', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (315, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'BB70B9D2D39E7A14', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (316, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BB93B1B8E3B223FA', '', '', '', '', '', 105500967, 125985400, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (317, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BD6FC7BF742904E0', '', '', '', '', '', 93723423, 139195488, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (318, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BD7E103E6739309D', '', '', '', '', '', 56208412, 80427886, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (319, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BE70B1E40C223FE5', '', '', '', '', '', 45529601, 42432954, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (320, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BEA00DEB576EA263', '', '', '', '', '', 136043206, 222201760, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (321, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'BF610FCE9FDF5AD1', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (322, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BF797CEE7CF9D4D3', '', '', '', '', '', 107089161, 113491687, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (323, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'BFAD502B46C352F5', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (324, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BFC978DFD8D5A845', '', '', '', '', '', 73094916, 117998575, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (325, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'BFD0BA029969E177', '', '', '', '', '', 107159963, 129585271, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (326, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C062E8BE5657CD0D', '', '', '', '', '', 102041270, 117258181, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (327, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'C12BBF77EF6D96CA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (328, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C1DD95E210682C13', '', '', '', '', '', 150640079, 197374175, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (329, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C240B734783AE2A8', '', '', '', '', '', 87824725, 103643812, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (330, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C295FF703D187960', '', '', '', '', '', 0, 56942792, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (331, 'iqiyi', 7, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C32DBD9297677D0D', '', '', '', '', '', 64938826, 161894310, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (332, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C343B9E69F5AFD49', '', '', '', '', '', 42394824, 100742187, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (333, 'iqiyi', 7, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C3BC2DB0540979DF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (334, 'iqiyi', 5, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C403D839D7A2900F', '', '', '', '', '', 160064901, 176728044, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (335, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C4782701D8771378', '', '', '', '', '', 130360585, 157387373, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (336, 'iqiyi', 8, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C4BEA411DEB392AF', '', '', '', '', '', 120327437, 95117905, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (337, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'C6142EAA980908EC', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (338, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'C6440F22E022F664', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (339, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'C67013F8C9EDE3B7', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (340, 'iqiyi', 4, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C750E00EE1069BF7', '', '', '', '', '', 57960794, 81962332, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (341, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'C7550791CAE0AF16', '', '', '', '', '', 35524376, 55693751, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (342, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'C774D0427D17119E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (343, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'CA18320D0FD3AD14', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (344, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'CC1B0DF4FC3CFAB0', '', '', '', '', '', 41145725, 2377285, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (345, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'CC351FE5E3C0E9B4', '', '', '', '', '', 104259053, 126208427, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (346, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'CC98780B91A8C730', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (347, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'CE09750B3DBC6AF6', '', '', '', '', '', 1282626, 102958587, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (348, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'CF484B9D52794E24', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (349, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D00DAF696402A53E', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (350, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D0143C06BBDB1158', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (351, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D06CFE17BE98D56F', '', '', '', '', '', 21285576, 1890296, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (352, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D0A84A6F26E292E6', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:20', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (353, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D17AFF1CE11EA7E3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (354, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D1E31F020A40E480', '', '', '', '', '', 70939769, 114782114, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (355, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D232140C391114DA', '', '', '', '', '', 0, 72642155, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (356, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D29418AB75142427', '', '', '', '', '', 61151256, 72771606, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (357, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D2F9E2F7F704662D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (358, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D308A601F76197E1', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (359, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D3D3434C05915B72', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (360, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D47EED9EDB0D41AB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (361, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D50A53E1B764C00A', '', '', '', '', '', 0, 107974218, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (362, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D6B54129A5143EDB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (363, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'D7C363271F75786F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (364, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'D82773B916F7DC0D', '', '', '', '', '', 173325035, 206314812, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (365, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'DABA2B3A01C62548', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (366, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DAF96A1339F90D6D', '', '', '', '', '', 0, 164204283, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (367, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'DB55F01DE6C35661', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (368, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'DB5EC6A10CFF9D62', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (369, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DB69F13315CB6BFB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (370, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DBF2039E3C544166', '', '', '', '', '', 54458199, 62188505, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (371, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DC371541C3AAB8EC', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (372, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DCE56EA0487EC9E9', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (373, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'DDF3051BD96B780A', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:01', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (374, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DEC802A845F435DB', '', '', '', '', '', 96497666, 8329941, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (375, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DED8E92B499B014D', '', '', '', '', '', 93572961, 99257356, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (376, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'DF0EDAF7EF1AD671', '', '', '', '', '', 0, 186636384, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (377, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'DF69CF620791E697', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (378, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E00667BDBC40D6F2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (379, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E02944E7071128E5', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (380, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E047E94DB3C623A5', '', '', '', '', '', 106116709, 78835100, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (381, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E0D406DBDEE0F1F2', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (382, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E0E4BCB13074D652', '', '', '', '', '', 53260428, 132238035, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (383, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E15BC625541D3B4D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (384, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E1B0C8AD0E0E4563', '', '', '', '', '', 119912643, 304505945, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (385, 'iqiyi', 7, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E1ECB6D0FC0E08BD', '', '', '', '', '', 59415560, 117042920, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (386, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E24F4C98A42EF801', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (387, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E30401D9E4B55298', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (388, 'iqiyi', 8, '127.0.0.1', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E3BAC3043B4A72E8', '', '', '', '', '', 110675912, 101060181, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (389, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E50DB92136E1EECB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (390, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E615BB483B2D2724', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (391, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E7A55D27D51330BC', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (392, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E8312CD7B67F342D', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (393, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'E85BC20D5AB49FDF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (394, 'iqiyi', 7, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'E8E32CB06454B8E3', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (395, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'EA020F4D775354B0', '', '', '', '', '', 110574684, 121833403, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (396, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'EA97151A7C73490C', '', '', '', '', '', 33172792, 35049389, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (397, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'EC0A5BA0DAF9093F', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (398, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'EC61EFB73F41136F', '', '', '', '', '', 138117310, 166205699, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (399, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'EC6FE4073DAC4ADA', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (400, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'ECF6580F01C1E2EF', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (401, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'ED5B2230EC6199B7', '', '', '', '', '', 49837969, 44432136, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (402, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'EDBD3407A4682952', '', '', '', '', '', 184519440, 157130061, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (403, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'EEF33DE607E917D5', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (404, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'EF0BF13DA9D80470', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (405, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'EF3A637F7869EE21', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (406, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'EFA5F439E042EFC1', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:45', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (407, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F115EF027A1FB712', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (408, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F1379EC20A2D3A3B', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (409, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F2AF4722D4546E17', '', '', '', '', '', 47800478, 60749021, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (410, 'iqiyi', 1, '', '', '移动', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F3A9A22A11500F9D', '', '', '', '', '', 0, 114680927, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (411, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F50FF0FFEA7DE566', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:47', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (412, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F5D0CAF41A120ECE', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (413, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F60619D8C43C5919', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (414, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F6E053C90F115856', '', '', '', '', '', 107503491, 129938350, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (415, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F6F243E8576EAFBE', '', '', '', '', '', 178987871, 184961221, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (416, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F79942F1AB2B081B', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (417, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'F8AFE1D9C302ACAA', '', '', '', '', '', 0, 99577526, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (418, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F8B716807F7445DB', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:46', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (419, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'F976A47DC79F4104', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:48', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (420, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'FB9B7202091E3390', '', '', '', '', '', 109782922, 135345646, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (421, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'FBE0085BAEC9D90E', '', '', '', '', '', 80143350, 90009745, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (422, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'FBF9793ECCFB09E4', '', '', '', '', '', 74730955, 94865637, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (423, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'FD23B67A7FC4ADC1', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (424, 'iqiyi', 2, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'FE719327C80B2B36', '', '', '', '', '', 121608423, 147728386, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (425, 'iqiyi', 1, '', '', '电信', 'later', '22', 'root', 'root', 'pass', 'wait_handshake', 0, 0, 'FED722DAB76EF417', '', '', '', '', '', 0, 10889302, 0, 0, '2021-01-16 16:59:02', '2021-01-17 13:57:21', NULL, '2021-01-01 00:00:00');
INSERT INTO `fa_traffic_user_devices` VALUES (426, 'iqiyi', 1, '', '', '联通', 'later', '22', 'root', 'root', 'pass', 'lock', 0, 0, 'FFE0C603090E7B4A', '', '', '', '', '', 0, 0, 0, 0, '2021-01-16 16:59:02', '2021-01-17 12:35:49', NULL, '2021-01-01 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for fa_user
-- ----------------------------
DROP TABLE IF EXISTS `fa_user`;
CREATE TABLE `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '昵称',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` int(10) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` int(10) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `joinip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '加入IP',
  `jointime` int(10) DEFAULT NULL COMMENT '加入时间',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'Token',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  `verification` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `email` (`email`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员表';

-- ----------------------------
-- Records of fa_user
-- ----------------------------
BEGIN;
INSERT INTO `fa_user` VALUES (1, 1, 'admin', 'admin', 'e37e7191cbac52dbca9bf0fd5cf33ade', 'V8gfXJ', 'admin@163.com', '13888888888', '', 0, 0, '2017-04-15', '', 0.00, 0, 1, 1, 1603178876, 1603178890, '192.168.184.1', 0, '127.0.0.1', 1491461418, 0, 1603178890, '', 'normal', '');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_group`;
CREATE TABLE `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `createtime` int(10) DEFAULT NULL COMMENT '添加时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员组表';

-- ----------------------------
-- Records of fa_user_group
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_group` VALUES (1, '默认组', '1,2,3,4,5,6,7,8,9,10,11,12', 1515386468, 1516168298, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_money_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_money_log`;
CREATE TABLE `fa_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员余额变动表';

-- ----------------------------
-- Records of fa_user_money_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for fa_user_rule
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_rule`;
CREATE TABLE `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题',
  `remark` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员规则表';

-- ----------------------------
-- Records of fa_user_rule
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_rule` VALUES (1, 0, 'index', 'Frontend', '', 1, 1516168079, 1516168079, 1, 'normal');
INSERT INTO `fa_user_rule` VALUES (2, 0, 'api', 'API Interface', '', 1, 1516168062, 1516168062, 2, 'normal');
INSERT INTO `fa_user_rule` VALUES (3, 1, 'user', 'User Module', '', 1, 1515386221, 1516168103, 12, 'normal');
INSERT INTO `fa_user_rule` VALUES (4, 2, 'user', 'User Module', '', 1, 1515386221, 1516168092, 11, 'normal');
INSERT INTO `fa_user_rule` VALUES (5, 3, 'index/user/login', 'Login', '', 0, 1515386247, 1515386247, 5, 'normal');
INSERT INTO `fa_user_rule` VALUES (6, 3, 'index/user/register', 'Register', '', 0, 1515386262, 1516015236, 7, 'normal');
INSERT INTO `fa_user_rule` VALUES (7, 3, 'index/user/index', 'User Center', '', 0, 1516015012, 1516015012, 9, 'normal');
INSERT INTO `fa_user_rule` VALUES (8, 3, 'index/user/profile', 'Profile', '', 0, 1516015012, 1516015012, 4, 'normal');
INSERT INTO `fa_user_rule` VALUES (9, 4, 'api/user/login', 'Login', '', 0, 1515386247, 1515386247, 6, 'normal');
INSERT INTO `fa_user_rule` VALUES (10, 4, 'api/user/register', 'Register', '', 0, 1515386262, 1516015236, 8, 'normal');
INSERT INTO `fa_user_rule` VALUES (11, 4, 'api/user/index', 'User Center', '', 0, 1516015012, 1516015012, 10, 'normal');
INSERT INTO `fa_user_rule` VALUES (12, 4, 'api/user/profile', 'Profile', '', 0, 1516015012, 1516015012, 3, 'normal');
COMMIT;

-- ----------------------------
-- Table structure for fa_user_score_log
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_score_log`;
CREATE TABLE `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '备注',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员积分变动表';

-- ----------------------------
-- Records of fa_user_score_log
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_score_log` VALUES (1, 1, 0, 0, 0, '管理员变更积分', 1602912437);
COMMIT;

-- ----------------------------
-- Table structure for fa_user_token
-- ----------------------------
DROP TABLE IF EXISTS `fa_user_token`;
CREATE TABLE `fa_user_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `expiretime` int(10) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员Token表';

-- ----------------------------
-- Records of fa_user_token
-- ----------------------------
BEGIN;
INSERT INTO `fa_user_token` VALUES ('af282a94f7493b4f49375eab5a192d0803cde2a2', 1, 1603178890, 1605770890);
COMMIT;

-- ----------------------------
-- Table structure for fa_version
-- ----------------------------
DROP TABLE IF EXISTS `fa_version`;
CREATE TABLE `fa_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '包大小',
  `content` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='版本表';

-- ----------------------------
-- Records of fa_version
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Procedure structure for NETWORK_ALL_COUNT_95
-- ----------------------------
DROP PROCEDURE IF EXISTS `NETWORK_ALL_COUNT_95`;
delimiter ;;
CREATE PROCEDURE `NETWORK_ALL_COUNT_95`(IN isp VARCHAR(64), IN st DATE, IN et DATE, IN src VARCHAR(16), IN uid int(10))
BEGIN
	IF isp = 'dx' OR isp = 'lt' THEN 
		SET isp  = 'dxlt';
	ELSE
		SET isp  = 'yd';
	END IF;
	SET @tn = CONCAT('fa_traffic_network_counts_', isp);
	IF uid != 0 THEN
		SET @tn = CONCAT(@tn, '_user');
	END IF;
	-- 必须要重置
	SET @ID = 0;
	SET @CNT = 0;
	SET @TM = "0000-00-00 00:00:00";
	IF uid = 0 THEN
		SET @SQL1 = CONCAT('SELECT id, count_y_u, log_upload_time INTO @ID, @CNT, @TM FROM `' , @tn , '` WHERE `source`="' , src , '" AND `year_month` BETWEEN "' , st , '" AND "' , et , '" ORDER BY count_y_u DESC LIMIT ?, 1;');
	ELSE
		SET @SQL1 = CONCAT('SELECT id, count_y_u, log_upload_time INTO @ID, @CNT, @TM FROM `' , @tn , '` WHERE `user_id`="',uid,'" AND `source`="' , src , '" AND `year_month` BETWEEN "' , st , '" AND "' , et , '" ORDER BY count_y_u DESC LIMIT ?, 1;');
	END IF;
	PREPARE PRESQL1 FROM @SQL1;
	SET @POS = ROUND ( ( DATEDIFF(et, st) + 1 ) * 288 * 0.05 );
	EXECUTE PRESQL1 USING @POS;
	SELECT @tn AS table_name, @ID AS get_id, @TM AS log_datetime, @POS AS posi, @CNT AS speed;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for NETWORK_CDN_COUNT_95
-- ----------------------------
DROP PROCEDURE IF EXISTS `NETWORK_CDN_COUNT_95`;
delimiter ;;
CREATE PROCEDURE `NETWORK_CDN_COUNT_95`(IN uuid VARCHAR(64), IN st DATE, IN et DATE)
BEGIN
	SET @tn = CONCAT('tmpTable_', REPLACE(uuid, '-', ''));
	SET @_uuid = uuid;
	SET @_st = st;
	SET @_et = et;
	SET @_dy = 0;
	SET @SQL0 = CONCAT('DROP TABLE IF EXISTS `' , @tn , '`;');
	SET @SQL1 = '';
	SET @SQL6 = CONCAT(
		'CREATE TEMPORARY TABLE `' , @tn , '`(',
			'`id` int(10) unsigned NOT NULL AUTO_INCREMENT,',
			'`count_y_u` int(10) unsigned NOT NULL DEFAULT 0,',
			'`log_date` date NOT NULL,',
			'`log_upload_time` datetime DEFAULT NULL,',
			'PRIMARY KEY (`id`)',
		') ENGINE = MEMORY;');
	IF ISNULL(st) AND ISNULL(et) THEN
		SET @SQL1 = 'log_date = CURDATE();';
		SET @_dy = 1;
	ELSEIF !ISNULL(st) AND ISNULL(et) THEN
		SET @SQL1 = CONCAT('log_date = "' , st , '";');
		SET @_dy = 1;
	ELSEIF !ISNULL(st) AND !ISNULL(et) THEN
		SET @SQL1 = CONCAT('log_date BETWEEN "' , st , '" AND "' , et , '";');
		SET @_dy = DATEDIFF(et, st) + 1;
	ELSE
		SET @cur = CURDATE(); 
		SET @first_date = DATE_ADD( @cur, INTERVAL - DAY ( @cur ) + 1 DAY );
		SET @SQL1 = CONCAT('log_date BETWEEN "' , @first_date , '" AND "' , et , '";');
		SET @_dy = DATEDIFF(et, @first_date) + 1;
	END IF;
	SET @TOL = 0;
	SET @IDLE = 0;
	SET @SPET = 0;
	SET @CNT = 0;
	SET @DAT = "0000-00-00";
	SET @SQL1 = CONCAT(
		'INSERT INTO `' , @tn , '`(count_y_u, log_date, log_upload_time)  ',
		'SELECT count_y_u, log_date, log_upload_time FROM `fa_traffic_network_logs` WHERE device_disk_uuid=? AND ', @SQL1
	);
	SET @SQL2 = CONCAT('SET @TOL = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '`);');
	SET @SQL3 = CONCAT('SET @IDLE = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '` WHERE `count_y_u` = 0 AND `log_upload_time` IS NOT NULL);');
	SET @SQL4 = CONCAT('SET @SPET = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '` WHERE `count_y_u` = 0 AND `log_upload_time` IS NULL);');
	SET @SQL5 = CONCAT('SELECT COALESCE( `count_y_u`, 0 ), log_date INTO @CNT, @DAT FROM `' , @tn , '` ORDER BY count_y_u DESC LIMIT ?, 1;');
	PREPARE PRESQL0 FROM @SQL0; -- 删除临时表
	EXECUTE PRESQL0;
	PREPARE PRESQL6 FROM @SQL6; -- 创建临时表
	EXECUTE PRESQL6;
 	PREPARE PRESQL1 FROM @SQL1; -- 查数据
	PREPARE PRESQL2 FROM @SQL2; -- @TOL 总取点数
	PREPARE PRESQL3 FROM @SQL3; -- @IDLE 取点为0的次数
	PREPARE PRESQL4 FROM @SQL4; -- @SPET 补点的次数
	PREPARE PRESQL5 FROM @SQL5; -- @CNT 95速度
	EXECUTE PRESQL1 USING @_uuid;
	EXECUTE PRESQL2; -- @TOL 总取点数
	EXECUTE PRESQL3; -- @IDLE 取点为0的次数
	EXECUTE PRESQL4; -- @SPET 补点的次数
	-- SET @POS = ROUND ( @TOL * 0.05 ); -- 95取点位置
	SET @POS = ROUND ( @_dy * 288 * 0.05 ); -- 95取点位置
	EXECUTE PRESQL5 USING @POS; 			-- @CNT 95速度
	IF ISNULL(@CNT) THEN SET @CNT  = 0;END IF;
	SELECT @TOL AS total, @POS AS posi, @CNT AS traffic, @IDLE AS idle, @SPET AS spet, @DAT AS posi_date;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for NETWORK_CDN_COUNT_95_DATE
-- ----------------------------
DROP PROCEDURE IF EXISTS `NETWORK_CDN_COUNT_95_DATE`;
delimiter ;;
CREATE PROCEDURE `NETWORK_CDN_COUNT_95_DATE`(IN uuid VARCHAR(64), IN dt DATE, IN isp varchar(16))
BEGIN
	IF isp = 'dx' OR isp = 'lt' THEN 
		SET isp  = 'dxlt';
	ELSE
		SET isp  = 'yd';
	END IF;
	SET @tn = CONCAT('tmpTable_', REPLACE(uuid, '-', ''));
	SET @_uuid = uuid;
	SET @_dt = dt;
	SET @SQL0 = CONCAT('DROP TABLE IF EXISTS `' , @tn , '`;');
	SET @SQL6 = CONCAT(
		'CREATE TEMPORARY TABLE `' , @tn , '`(',
			'`id` int(10) unsigned NOT NULL AUTO_INCREMENT,',
			'`count_y_u` int(10) unsigned NOT NULL DEFAULT 0,',
			'`log_upload_time` datetime DEFAULT NULL,',
			'PRIMARY KEY (`id`)',
		') ENGINE = MEMORY;');
	SET @TOL = 0;
	SET @IDLE = 0;
	SET @SPET = 0;
	SET @CNT = 0;
	SET @SQL1 = CONCAT(
	'INSERT INTO `' , @tn , '`(count_y_u, log_upload_time)  ',
	'SELECT count_y_u, log_upload_time FROM `fa_traffic_network_logs` WHERE device_disk_uuid=? AND log_date=?;');
	SET @SQL2 = CONCAT('SET @TOL = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '`);');
	SET @SQL3 = CONCAT('SET @IDLE = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '` WHERE `count_y_u` = 0 AND `log_upload_time` IS NOT NULL);');
	SET @SQL4 = CONCAT('SET @SPET = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `' , @tn , '` WHERE `count_y_u` = 0 AND `log_upload_time` IS NULL);');
	SET @SQL5 = CONCAT('SET @CNT = (SELECT COALESCE(`count_y_u`, 0 ) FROM `' , @tn , '` ORDER BY count_y_u DESC LIMIT ?, 1);');
	PREPARE PRESQL0 FROM @SQL0; -- 删除临时表
	EXECUTE PRESQL0;
	PREPARE PRESQL6 FROM @SQL6; -- 创建临时表
	EXECUTE PRESQL6;
 	PREPARE PRESQL1 FROM @SQL1; -- 查数据
	PREPARE PRESQL2 FROM @SQL2; -- @TOL 总取点数
	PREPARE PRESQL3 FROM @SQL3; -- @IDLE 取点为0的次数
	PREPARE PRESQL4 FROM @SQL4; -- @SPET 补点的次数
	PREPARE PRESQL5 FROM @SQL5; -- @CNT 95速度
	IF ISNULL(dt) THEN SET @_dt = CURDATE(); END IF;
	EXECUTE PRESQL1 USING @_uuid, @_dt;
	EXECUTE PRESQL2; -- @TOL 总取点数
	EXECUTE PRESQL3; -- @IDLE 取点为0的次数
	EXECUTE PRESQL4; -- @SPET 补点的次数
	-- SET @POS = ROUND ( @TOL * 0.05 ); -- 95取点位置
	SET @POS = 14; -- 95取点位置
	EXECUTE PRESQL5 USING @POS; 			-- @CNT 95速度
	IF ISNULL(@CNT) THEN SET @CNT  = 0;END IF;
	SET @_cur  = NOW();
	SET @_SQL1 = CONCAT('SET @HAS = (SELECT COALESCE( COUNT(`id`), 0 ) FROM `fa_traffic_network_counts_95_',isp,'` WHERE `year_month`=? AND `device_disk_uuid`=? LIMIT 1);');
	SET @_SQL2 = CONCAT('UPDATE `fa_traffic_network_counts_95_',isp,'` SET `total_dot`=?,`posi`=?,`speed_byte`=?,`free_dot`=?,`add_dot`=?,`updated_at`=? WHERE `year_month`=? AND `device_disk_uuid`=? LIMIT 1;');
	SET @_SQL3 = CONCAT('INSERT INTO fa_traffic_network_counts_95_',isp,'(`year_month`, `device_disk_uuid`,`total_dot`,`posi`,`speed_byte`,`free_dot`,`add_dot`,`updated_at`,`created_at`) VALUES (?,?,?,?,?,?,?,?,?);');
	PREPARE PRESQL7 FROM @_SQL1;
	PREPARE PRESQL8 FROM @_SQL2;
	PREPARE PRESQL9 FROM @_SQL3;
	EXECUTE PRESQL7 USING @_dt, @_uuid;
	if @HAS = 1 THEN
		EXECUTE PRESQL8 USING @TOL, @POS, @CNT, @IDLE, @SPET, @_cur, @_dt, @_uuid;
	ELSE
		EXECUTE PRESQL9 USING @_dt, @_uuid, @TOL, @POS, @CNT, @IDLE, @SPET, @_cur, @_cur;
	END IF;
	SELECT @TOL AS total, @POS AS posi, @CNT AS traffic, @IDLE AS idle, @SPET AS spet;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
