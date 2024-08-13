CREATE DATABASE `supplychaindb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `dist_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `distEmail` varchar(45) DEFAULT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT NULL,
  `totalAmt` varchar(45) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `dist_product_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `distEmail` varchar(45) DEFAULT NULL,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `expdate` varchar(45) DEFAULT NULL,
  `mfgdate` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `disttable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emailId` varchar(45) DEFAULT NULL,
  `distPassword` varchar(45) DEFAULT NULL,
  `distName` varchar(45) DEFAULT NULL,
  `distAddress` varchar(80) DEFAULT NULL,
  `distMobile` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_dist_req` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `distName` varchar(45) DEFAULT NULL,
  `distEmail` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT '00-00-00',
  `quantity` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_table` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `mfd` varchar(20) DEFAULT NULL,
  `exp` varchar(20) DEFAULT NULL,
  `quantity` varchar(20) DEFAULT NULL,
  `price` varchar(20) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`productId`),
  UNIQUE KEY `productId_UNIQUE` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `product_user_req` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `userEmail` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT '00-00-00',
  `quantity` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transaction_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `src` varchar(45) DEFAULT NULL,
  `dst` varchar(45) DEFAULT NULL,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT NULL,
  `address` longtext,
  `quantity` varchar(12) DEFAULT NULL,
  `amount` varchar(45) DEFAULT NULL,
  `product_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `timestamp_UNIQUE` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(45) DEFAULT NULL,
  `distEmail` varchar(45) DEFAULT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  `productName` varchar(45) DEFAULT NULL,
  `companyName` varchar(45) DEFAULT NULL,
  `expdate` varchar(45) DEFAULT NULL,
  `timestamp` varchar(45) DEFAULT NULL,
  `totalAmt` varchar(45) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usertable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emailId` varchar(45) DEFAULT NULL,
  `userName` varchar(45) DEFAULT NULL,
  `userPassword` varchar(45) DEFAULT NULL,
  `userMobile` varchar(45) DEFAULT NULL,
  `userAddress` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
