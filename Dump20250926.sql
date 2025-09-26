-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: pbl4
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `__efmigrationshistory`
--

DROP TABLE IF EXISTS `__efmigrationshistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__efmigrationshistory`
--

LOCK TABLES `__efmigrationshistory` WRITE;
/*!40000 ALTER TABLE `__efmigrationshistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `__efmigrationshistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addressbuyers`
--

DROP TABLE IF EXISTS `addressbuyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addressbuyers` (
  `AddressId` int NOT NULL AUTO_INCREMENT,
  `Location` longtext NOT NULL,
  `IsDefault` tinyint(1) NOT NULL,
  `BuyerId` int NOT NULL,
  PRIMARY KEY (`AddressId`),
  KEY `IX_AddressBuyers_BuyerId` (`BuyerId`),
  CONSTRAINT `FK_AddressBuyers_Buyers_BuyerId` FOREIGN KEY (`BuyerId`) REFERENCES `buyers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addressbuyers`
--

LOCK TABLES `addressbuyers` WRITE;
/*!40000 ALTER TABLE `addressbuyers` DISABLE KEYS */;
/*!40000 ALTER TABLE `addressbuyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banks`
--

DROP TABLE IF EXISTS `banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banks` (
  `BankAccountId` int NOT NULL AUTO_INCREMENT,
  `BankNumber` longtext NOT NULL,
  `BankName` longtext NOT NULL,
  `WalletId` int NOT NULL,
  PRIMARY KEY (`BankAccountId`),
  KEY `IX_Banks_WalletId` (`WalletId`),
  CONSTRAINT `FK_Banks_PlatformWallets_WalletId` FOREIGN KEY (`WalletId`) REFERENCES `platformwallets` (`WalletId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banks`
--

LOCK TABLES `banks` WRITE;
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyers`
--

DROP TABLE IF EXISTS `buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyers` (
  `Id` int NOT NULL,
  `Avatar` longblob,
  `Location` longtext NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Buyers_Users_Id` FOREIGN KEY (`Id`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyers`
--

LOCK TABLES `buyers` WRITE;
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cartitems`
--

DROP TABLE IF EXISTS `cartitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitems` (
  `BuyerId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Quantity` int NOT NULL,
  `ProductName` longtext NOT NULL,
  `ProductImage` longblob,
  PRIMARY KEY (`ProductId`,`BuyerId`),
  KEY `IX_CartItems_BuyerId` (`BuyerId`),
  CONSTRAINT `FK_CartItems_Buyers_BuyerId` FOREIGN KEY (`BuyerId`) REFERENCES `buyers` (`Id`),
  CONSTRAINT `FK_CartItems_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `products` (`ProductId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitems`
--

LOCK TABLES `cartitems` WRITE;
/*!40000 ALTER TABLE `cartitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `cartitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `OrderId` int NOT NULL,
  `ProductId` int NOT NULL,
  `Productname` longtext NOT NULL,
  `Quantity` int NOT NULL,
  `Price` decimal(18,2) NOT NULL,
  `TotalNetProfit` decimal(18,2) NOT NULL,
  `Image` longblob,
  PRIMARY KEY (`OrderId`,`ProductId`),
  KEY `IX_OrderDetails_ProductId` (`ProductId`),
  CONSTRAINT `FK_OrderDetails_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`) ON DELETE CASCADE,
  CONSTRAINT `FK_OrderDetails_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `products` (`ProductId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `BuyerId` int NOT NULL,
  `SellerId` int NOT NULL,
  `OrderDate` datetime NOT NULL,
  `OrderPrice` decimal(18,2) NOT NULL,
  `OrderStatus` int NOT NULL,
  `PaymentMethod` int NOT NULL,
  `PaymentStatus` tinyint(1) NOT NULL,
  `Address` longtext NOT NULL,
  `Discount` decimal(18,2) NOT NULL,
  `QuantityTypeOfProduct` int NOT NULL,
  `OrderReceivedDate` datetime NOT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `IX_Orders_BuyerId` (`BuyerId`),
  KEY `IX_Orders_SellerId` (`SellerId`),
  CONSTRAINT `FK_Orders_Buyers_BuyerId` FOREIGN KEY (`BuyerId`) REFERENCES `buyers` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_Orders_Sellers_SellerId` FOREIGN KEY (`SellerId`) REFERENCES `sellers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platformwallets`
--

DROP TABLE IF EXISTS `platformwallets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platformwallets` (
  `WalletId` int NOT NULL AUTO_INCREMENT,
  `WalletBalance` decimal(18,2) NOT NULL,
  `UserId` int NOT NULL,
  `Pin` int NOT NULL,
  PRIMARY KEY (`WalletId`),
  UNIQUE KEY `IX_PlatformWallets_UserId` (`UserId`),
  CONSTRAINT `FK_PlatformWallets_Users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platformwallets`
--

LOCK TABLES `platformwallets` WRITE;
/*!40000 ALTER TABLE `platformwallets` DISABLE KEYS */;
/*!40000 ALTER TABLE `platformwallets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductId` int NOT NULL AUTO_INCREMENT,
  `ProductName` longtext NOT NULL,
  `ProductQuantity` int NOT NULL,
  `Price` decimal(18,2) NOT NULL,
  `ProductImage` longblob,
  `ProductType` int NOT NULL,
  `ProductDescription` longtext,
  `SellerId` int NOT NULL,
  `ProductStatus` int NOT NULL,
  `SoldProduct` int NOT NULL,
  PRIMARY KEY (`ProductId`),
  KEY `IX_Products_SellerId` (`SellerId`),
  CONSTRAINT `FK_Products_Sellers_SellerId` FOREIGN KEY (`SellerId`) REFERENCES `sellers` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `returnexchanges`
--

DROP TABLE IF EXISTS `returnexchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `returnexchanges` (
  `ReturnExchangeId` int NOT NULL AUTO_INCREMENT,
  `ProductId` int NOT NULL,
  `OrderId` int NOT NULL,
  `Reason` longtext NOT NULL,
  `Image` longblob,
  `RequestDate` datetime NOT NULL,
  `ResponseDate` datetime NOT NULL,
  `Status` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`ReturnExchangeId`),
  KEY `IX_ReturnExchanges_OrderId` (`OrderId`),
  KEY `IX_ReturnExchanges_ProductId` (`ProductId`),
  CONSTRAINT `FK_ReturnExchanges_Orders_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`),
  CONSTRAINT `FK_ReturnExchanges_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `products` (`ProductId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `returnexchanges`
--

LOCK TABLES `returnexchanges` WRITE;
/*!40000 ALTER TABLE `returnexchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `returnexchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `ReviewId` int NOT NULL AUTO_INCREMENT,
  `ProductId` int NOT NULL,
  `BuyerId` int NOT NULL,
  `Rating` int NOT NULL,
  `Comment` longtext,
  `DateReview` datetime NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`ReviewId`),
  KEY `IX_Reviews_BuyerId` (`BuyerId`),
  KEY `IX_Reviews_ProductId` (`ProductId`),
  CONSTRAINT `FK_Reviews_Buyers_BuyerId` FOREIGN KEY (`BuyerId`) REFERENCES `buyers` (`Id`),
  CONSTRAINT `FK_Reviews_Products_ProductId` FOREIGN KEY (`ProductId`) REFERENCES `products` (`ProductId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellers` (
  `Id` int NOT NULL,
  `Avatar` longblob,
  `StoreName` longtext NOT NULL,
  `JoinedDate` datetime NOT NULL,
  `EmailGeneral` longtext NOT NULL,
  `AddressSeller` longtext NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `FK_Sellers_Users_Id` FOREIGN KEY (`Id`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES (1,NULL,'Cua hang','2025-09-26 00:00:00','admin@example.com','Da Nang');
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Username` longtext NOT NULL,
  `Password` longtext NOT NULL,
  `Name` longtext NOT NULL,
  `Sex` int NOT NULL,
  `PhoneNumber` longtext NOT NULL,
  `Date` datetime NOT NULL,
  `RoleName` int NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','123456','admin',1,'0123456789','2025-09-26 00:00:00',1,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_buyers`
--

DROP TABLE IF EXISTS `voucher_buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher_buyers` (
  `VoucherId` varchar(450) NOT NULL,
  `BuyerId` int NOT NULL,
  `IsUsed` tinyint(1) NOT NULL,
  PRIMARY KEY (`BuyerId`,`VoucherId`),
  KEY `IX_Voucher_Buyers_VoucherId` (`VoucherId`),
  CONSTRAINT `FK_Voucher_Buyers_Buyers_BuyerId` FOREIGN KEY (`BuyerId`) REFERENCES `buyers` (`Id`),
  CONSTRAINT `FK_Voucher_Buyers_Vouchers_VoucherId` FOREIGN KEY (`VoucherId`) REFERENCES `vouchers` (`VoucherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_buyers`
--

LOCK TABLES `voucher_buyers` WRITE;
/*!40000 ALTER TABLE `voucher_buyers` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher_buyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `VoucherId` varchar(450) NOT NULL,
  `PercentDiscount` decimal(18,2) NOT NULL,
  `MaxDiscount` decimal(18,2) NOT NULL,
  `Description` longtext,
  `VoucherQuantity` int NOT NULL,
  `StartDate` datetime NOT NULL,
  `EndDate` datetime NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `SellerId` int NOT NULL,
  PRIMARY KEY (`VoucherId`),
  KEY `IX_Vouchers_SellerId` (`SellerId`),
  CONSTRAINT `FK_Vouchers_Sellers_SellerId` FOREIGN KEY (`SellerId`) REFERENCES `sellers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchers`
--

LOCK TABLES `vouchers` WRITE;
/*!40000 ALTER TABLE `vouchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `vouchers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-26 14:21:24
