/*
SQLyog Ultimate v10.00 Beta1
MySQL - 8.0.33 : Database - shopping
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`shopping` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `shopping`;

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `number` int DEFAULT NULL,
  `picture` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

/*Data for the table `goods` */

insert  into `goods`(`id`,`name`,`city`,`price`,`number`,`picture`) values (1,'沃特篮球鞋','佛山',180,500,'001.jpg'),(2,'安踏运动鞋','福州',120,800,'002.jpg'),(3,'耐克运动鞋','广州',500,1000,'003.jpg'),(4,'阿迪达斯T血衫','上海',388,600,'004.jpg'),(5,'李宁文化衫','广州',180,900,'005.jpg'),(6,'小米3','北京',1999,3000,'006.jpg'),(7,'小米2S','北京',1299,1000,'007.jpg'),(8,'thinkpad笔记本','北京',6999,500,'008.jpg'),(9,'dell笔记本','北京',3999,500,'009.jpg'),(10,'ipad5','北京',5999,500,'010.jpg');

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` varchar(100) NOT NULL,
  `total_price` float DEFAULT NULL,
  `num` int DEFAULT NULL,
  `state` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_user_id_fk` (`user_id`),
  CONSTRAINT `orders_user_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `orders` */

insert  into `orders`(`id`,`total_price`,`num`,`state`,`user_id`,`time`) values ('170359147051669',41989,2,0,2,'2023-12-26'),('170359170451464',5196,1,0,2,'2023-12-26'),('170359305621298',600,1,0,2,'2023-12-26'),('170366212912576',5916,2,0,2,'2023-12-27'),('170366552502315',47990,3,0,4,'2023-12-27'),('170381236016418',9995,1,0,4,'2023-12-29'),('170381472399223',10595,2,0,7,'2023-12-29');

/*Table structure for table `ordersitem` */

DROP TABLE IF EXISTS `ordersitem`;

CREATE TABLE `ordersitem` (
  `id` varchar(100) NOT NULL,
  `num` int DEFAULT NULL,
  `price` float DEFAULT NULL,
  `good_id` int DEFAULT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ordersitem_goods_id_fk` (`good_id`),
  KEY `ordersitem_orders_id_fk` (`order_id`),
  CONSTRAINT `ordersitem_goods_id_fk` FOREIGN KEY (`good_id`) REFERENCES `goods` (`id`),
  CONSTRAINT `ordersitem_orders_id_fk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `ordersitem` */

insert  into `ordersitem`(`id`,`num`,`price`,`good_id`,`order_id`) values ('170359147051622',6,11994,6,'170359147051669'),('170359147051652',5,29995,10,'170359147051669'),('170359170451444',4,5196,7,'170359170451464'),('170359305621302',5,600,2,'170359305621298'),('170366212913206',4,720,5,'170366212912576'),('170366212913232',4,5196,7,'170366212912576'),('170366552502443',4,7996,6,'170366552502315'),('170366552502464',2,11998,10,'170366552502315'),('170366552502489',4,27996,8,'170366552502315'),('170381236016597',5,9995,6,'170381236016418'),('170381472399246',5,600,2,'170381472399223'),('170381472399268',5,9995,6,'170381472399223');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) DEFAULT NULL COMMENT 'password',
  `password` varchar(100) DEFAULT NULL,
  `islogin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`user_id`,`username`,`password`,`islogin`) values (2,'lyb','lyb',0),(4,'admin','123',0),(5,'abc','123',0),(6,'qqq','123',1),(7,'asd','123',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
