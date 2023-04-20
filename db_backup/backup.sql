-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.8.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- tt 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `tt` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `tt`;

-- 테이블 tt.bucket 구조 내보내기
CREATE TABLE IF NOT EXISTS `bucket` (
  `BUCKET_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`BUCKET_ID`) USING BTREE,
  KEY `FK_tbucket_tuser` (`USER_ID`) USING BTREE,
  CONSTRAINT `FK_tbucket_tuser` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`USER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 tt.bucket:~0 rows (대략적) 내보내기
DELETE FROM `bucket`;
/*!40000 ALTER TABLE `bucket` DISABLE KEYS */;
INSERT INTO `bucket` (`BUCKET_ID`, `USER_ID`, `name`, `create_date`, `update_date`) VALUES
	(1, 2, '버킷1', '2023-04-20 00:29:35', '2023-04-20 00:29:37'),
	(3, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52'),
	(4, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52'),
	(5, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52'),
	(6, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52'),
	(7, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52'),
	(8, 2, '노예쉑', '2023-04-20 00:29:52', '2023-04-20 00:29:52');
/*!40000 ALTER TABLE `bucket` ENABLE KEYS */;

-- 테이블 tt.product 구조 내보내기
CREATE TABLE IF NOT EXISTS `product` (
  `PRODUCT_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `BUCKET_ID` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `bar_cd` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`PRODUCT_ID`) USING BTREE,
  KEY `FK_product_bucket` (`BUCKET_ID`) USING BTREE,
  CONSTRAINT `FK_product_bucket` FOREIGN KEY (`BUCKET_ID`) REFERENCES `bucket` (`BUCKET_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 tt.product:~3 rows (대략적) 내보내기
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`PRODUCT_ID`, `BUCKET_ID`, `name`, `bar_cd`, `create_date`, `update_date`) VALUES
	(1, 1, '노예쉑', NULL, '2023-04-20 00:29:52', '2023-04-20 00:29:53'),
	(3, 1, '노예쉑', NULL, '2023-04-20 00:54:01', '2023-04-20 00:54:01'),
	(4, 1, '노예쉑', NULL, '2023-04-20 00:54:52', '2023-04-20 00:54:52'),
	(5, 1, '노예쉑', NULL, '2023-04-20 00:55:44', '2023-04-20 00:55:44'),
	(6, 1, '노예쉑', NULL, '2023-04-20 00:56:17', '2023-04-20 00:56:17'),
	(7, 1, '노예쉑', 'test', '2023-04-20 00:29:52', '2023-04-20 00:29:52');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- 테이블 tt.user 구조 내보내기
CREATE TABLE IF NOT EXISTS `user` (
  `USER_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '고유 ID',
  `role` varchar(50) DEFAULT NULL COMMENT '회원종류 : admin-관리자, ',
  `name` varchar(50) NOT NULL COMMENT '이름 or 아이디',
  `pw` varchar(50) DEFAULT NULL COMMENT '비밀번호',
  `pw_token` varchar(50) DEFAULT NULL COMMENT '비밀번호 토큰',
  `email` varchar(50) DEFAULT NULL COMMENT '이메일',
  `phone_num` varchar(50) DEFAULT NULL COMMENT '휴대폰 번호',
  `address` varchar(50) DEFAULT NULL COMMENT '주소',
  `join_date` varchar(50) DEFAULT NULL COMMENT '가입일',
  `leaving_date` varchar(50) DEFAULT NULL COMMENT '탈퇴일',
  `platform_type` varchar(50) DEFAULT NULL COMMENT 'SNS로그인 타입',
  `platform_token` varchar(50) DEFAULT NULL COMMENT 'SNS로그인 토큰',
  `create_date` datetime DEFAULT current_timestamp(),
  `update_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`USER_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='회원관리';

-- 테이블 데이터 tt.user:~0 rows (대략적) 내보내기
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`USER_ID`, `role`, `name`, `pw`, `pw_token`, `email`, `phone_num`, `address`, `join_date`, `leaving_date`, `platform_type`, `platform_token`, `create_date`, `update_date`) VALUES
	(2, 'admin', '관리자', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-04-20 00:31:45', '2023-04-20 00:31:45');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
