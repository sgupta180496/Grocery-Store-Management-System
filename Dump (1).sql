-- MySQL dump 10.13  Distrib 5.7.23, for Win64 (x86_64)
--
-- Host: dbprojectteam8.cmz0qyzslt7e.us-east-2.rds.amazonaws.com    Database: Grocery
-- ------------------------------------------------------
-- Server version	5.7.23-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='';

--
-- Temporary table structure for view `Catalog`
--

DROP TABLE IF EXISTS `Catalog`;
/*!50001 DROP VIEW IF EXISTS `Catalog`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Catalog` AS SELECT 
 1 AS `Product`,
 1 AS `Category`,
 1 AS `Price`,
 1 AS `Location`,
 1 AS `#Available`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `aisle_number` int(11) NOT NULL,
  `category_name` varchar(20) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name_UNIQUE` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,1,'Soup'),(2,2,'Salad'),(3,3,'Cereals'),(4,4,'Seafood'),(5,5,'Meat'),(6,6,'Pies'),(7,7,'Dairy'),(8,8,'Fruit'),(9,9,'Vegetables'),(10,10,'Frozen');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Checkout`
--

DROP TABLE IF EXISTS `Checkout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Checkout` (
  `checkout_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`checkout_id`),
  KEY `user id_idx` (`user_id`),
  KEY `date_idx` (`date`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Checkout`
--

LOCK TABLES `Checkout` WRITE;
/*!40000 ALTER TABLE `Checkout` DISABLE KEYS */;
INSERT INTO `Checkout` VALUES (1,11,'2018-11-24'),(2,14,'2018-11-29'),(3,19,'2018-11-27'),(4,11,'2018-11-29'),(5,15,'2018-11-30');
/*!40000 ALTER TABLE `Checkout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Checkout_Details`
--

DROP TABLE IF EXISTS `Checkout_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Checkout_Details` (
  `checkout_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`checkout_id`,`product_id`),
  CONSTRAINT `checkout Id` FOREIGN KEY (`checkout_id`) REFERENCES `Checkout` (`checkout_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Checkout_Details`
--

LOCK TABLES `Checkout_Details` WRITE;
/*!40000 ALTER TABLE `Checkout_Details` DISABLE KEYS */;
INSERT INTO `Checkout_Details` VALUES (1,1,2),(1,3,1),(1,4,2),(2,1,1),(2,2,2),(3,5,1),(4,1,2),(4,2,2),(4,3,2),(4,5,1),(5,6,1);
/*!40000 ALTER TABLE `Checkout_Details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBProjectTeam8`@`%`*/ /*!50003 trigger after_Checkout_Details_insert after insert on Checkout_Details
	for each row
    begin
    update Product inner join Checkout_Details using(product_id)
		set quantity_available = quantity_available - NEW.quantity
        where Product.product_id = NEW.product_id;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employee` (
  `user_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `ssn` char(9) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `ssn_UNIQUE` (`ssn`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (1,1,'261872525'),(2,2,'987654323'),(3,3,'987654321'),(4,4,'987652452'),(5,5,'987654623'),(6,6,'997654324'),(7,7,'986654325'),(8,8,'985654326'),(9,9,'967654327'),(10,10,'987654628');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `Employee_Pay`
--

DROP TABLE IF EXISTS `Employee_Pay`;
/*!50001 DROP VIEW IF EXISTS `Employee_Pay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Employee_Pay` AS SELECT 
 1 AS `Employee ID`,
 1 AS `Name`,
 1 AS `Hours worked`,
 1 AS `Pay for Week`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Login` (
  `employee_id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(25) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  CONSTRAINT `FK_LoginEmployee` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Login`
--

LOCK TABLES `Login` WRITE;
/*!40000 ALTER TABLE `Login` DISABLE KEYS */;
INSERT INTO `Login` VALUES (1,'Channing18','hdjfjkdf'),(2,'Wylie384','hsdhhdhf'),(3,'Kenneth34','hdsjdfhj'),(4,'Beck475','tjfbhdf'),(5,'Natalie85','hdjhgshjfd'),(6,'Cameron8575','tebdf'),(7,'Kyra75758','ndbdhjgbn'),(8,'Kibo785','hfjfsj'),(9,'Jane4658','ysfjjjfjj'),(10,'Theodore445','hjdfhdgjbkj');
/*!40000 ALTER TABLE `Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Managed_by`
--

DROP TABLE IF EXISTS `Managed_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Managed_by` (
  `employee_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`manager_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `Managed_by_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`),
  CONSTRAINT `Managed_by_ibfk_2` FOREIGN KEY (`manager_id`) REFERENCES `Manager` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Managed_by`
--

LOCK TABLES `Managed_by` WRITE;
/*!40000 ALTER TABLE `Managed_by` DISABLE KEYS */;
INSERT INTO `Managed_by` VALUES (1,7),(2,7),(3,7),(4,9),(5,9),(6,9),(8,9);
/*!40000 ALTER TABLE `Managed_by` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manager`
--

DROP TABLE IF EXISTS `Manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manager` (
  `employee_id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `M1` (`department`),
  CONSTRAINT `Manager_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manager`
--

LOCK TABLES `Manager` WRITE;
/*!40000 ALTER TABLE `Manager` DISABLE KEYS */;
INSERT INTO `Manager` VALUES (7,'Store Manager','Store'),(9,'Bakery Manager','Bakery'),(10,'Head Butcher','Meats');
/*!40000 ALTER TABLE `Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manager_Login`
--

DROP TABLE IF EXISTS `Manager_Login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manager_Login` (
  `manager_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`manager_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  CONSTRAINT `Manager_Login_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `Manager` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manager_Login`
--

LOCK TABLES `Manager_Login` WRITE;
/*!40000 ALTER TABLE `Manager_Login` DISABLE KEYS */;
INSERT INTO `Manager_Login` VALUES (7,'Kyra75758','ndbdhjgbn'),(9,'Jane4658','ysfjjjfjj'),(10,'Theodore445','hjdfhdgjbkj');
/*!40000 ALTER TABLE `Manager_Login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_details`
--

DROP TABLE IF EXISTS `Order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order_details` (
  `order_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `order_date` date DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `details_order_date_delivery_date` (`order_date`,`delivery_date`),
  CONSTRAINT `Order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `Order_table` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_details`
--

LOCK TABLES `Order_details` WRITE;
/*!40000 ALTER TABLE `Order_details` DISABLE KEYS */;
INSERT INTO `Order_details` VALUES (1,100,'2018-09-03','2018-10-24','Delivered'),(2,80,'2018-10-08','2018-10-28','Delivered'),(3,100,'2018-11-23','2099-12-31','Not Delivered'),(4,70,'2018-11-08','2018-11-26','Delivered'),(5,90,'2018-11-08','2018-11-28','Delivered'),(6,100,'2018-11-23','2099-12-31','Not Delivered'),(7,110,'2018-10-08','2018-11-18','Delivered'),(8,100,'2018-11-20','2018-11-20','Not Delivered'),(9,80,'2018-11-20','2018-12-03','Delivered'),(10,90,'2018-11-07','2018-11-27','Delivered');
/*!40000 ALTER TABLE `Order_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBProjectTeam8`@`%`*/ /*!50003 trigger after_order_update  
	AFTER UPDATE ON Order_details
    for each row
    BEGIN
    declare x int;
    declare y int;
    set x= old.order_id;
    set y= old.quantity;
	call product_update(x,y);
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order_table`
--

DROP TABLE IF EXISTS `Order_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Order_table` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `vp_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `vp_id` (`vp_id`),
  KEY `product_id` (`product_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `Order_table_ibfk_1` FOREIGN KEY (`vp_id`) REFERENCES `Vendor_product_price` (`vp_id`),
  CONSTRAINT `Order_table_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  CONSTRAINT `Order_table_ibfk_3` FOREIGN KEY (`manager_id`) REFERENCES `Manager` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_table`
--

LOCK TABLES `Order_table` WRITE;
/*!40000 ALTER TABLE `Order_table` DISABLE KEYS */;
INSERT INTO `Order_table` VALUES (1,1,1,7),(2,3,4,7),(3,4,1,7),(4,15,6,9),(5,13,4,9),(6,11,5,9),(7,8,5,10),(8,10,4,10),(9,7,4,7),(10,8,5,7);
/*!40000 ALTER TABLE `Order_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Payrate`
--

DROP TABLE IF EXISTS `Payrate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Payrate` (
  `employee_id` int(11) NOT NULL,
  `pay_rate` float DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `Payrate_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Payrate`
--

LOCK TABLES `Payrate` WRITE;
/*!40000 ALTER TABLE `Payrate` DISABLE KEYS */;
INSERT INTO `Payrate` VALUES (1,8),(2,8.1),(3,7.9),(4,7),(5,7),(6,8),(7,40),(8,7),(9,28),(10,30);
/*!40000 ALTER TABLE `Payrate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `quantity_available` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `P1` (`product_name`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES (1,'Chicken soup',5,110),(2,'Veggie soup',5,11),(3,'Corn soup',4,10),(4,'Chicken salad',3,183),(5,'Veggie salad',3,123),(6,'Caesar salad',3,23),(7,'Honey oats',4,20),(8,'Corn flakes',4,23),(9,'Fruit loops',4,24),(10,'prawns',5,23),(11,'Fish',5,24),(12,'Lobster',5,14),(13,'Turkey',6,13),(14,'Steak',6,26),(15,'Chicken',3,19),(16,'Apple pie',5,12),(17,'Pumpkin pie',5,23),(18,'Shepherds pie',6,30),(19,'Milk',4,13),(20,'Cheese',6,23),(21,'Yogurt',3,11),(22,'Apple',4,12),(23,'Mango',5,23),(24,'Banana',3,12),(25,'Potato',4,16),(26,'Onion',3,15),(27,'Bell Peppers',4,16),(28,'Corn',3,50),(29,'Peas',4,30),(30,'Veggies',5,20);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBProjectTeam8`@`%`*/ /*!50003 trigger after_Product_update after update on Product
	for each row
    begin
    declare vp_id_var int default 0;
    declare product_id_var int default 0;
    declare manager_id_var int default 7;
    if(NEW.quantity_available < 10) then
		select vp_id, product_id into vp_id_var, product_id_var
        from Vendor_product_price vp1
		where vendor_price = (select max(vendor_price) from Vendor_product_price as vp2
		where vp2.product_id = vp1.product_id) and product_id = NEW.product_id;
        insert into Order_table(vp_id,product_id,manager_id)
			values(vp_id_var, product_id_var, manager_id_var);
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ProductCategory`
--

DROP TABLE IF EXISTS `ProductCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProductCategory` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `ProductCategory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`),
  CONSTRAINT `ProductCategory_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategory`
--

LOCK TABLES `ProductCategory` WRITE;
/*!40000 ALTER TABLE `ProductCategory` DISABLE KEYS */;
INSERT INTO `ProductCategory` VALUES (1,1),(2,1),(3,1),(4,2),(5,2),(6,2),(7,3),(8,3),(9,3),(10,4),(11,4),(12,4),(13,5),(14,5),(15,5),(16,6),(17,6),(18,6),(19,7),(20,7),(21,7),(22,8),(23,8),(24,8),(25,9),(26,9),(27,9),(28,10),(29,10),(30,10);
/*!40000 ALTER TABLE `ProductCategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `Salaried_Employees`
--

DROP TABLE IF EXISTS `Salaried_Employees`;
/*!50001 DROP VIEW IF EXISTS `Salaried_Employees`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `Salaried_Employees` AS SELECT 
 1 AS `Salaried Employee ID`,
 1 AS `Name`,
 1 AS `Annual Salary`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Timesheet`
--

DROP TABLE IF EXISTS `Timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Timesheet` (
  `employee_id` int(11) DEFAULT NULL,
  `ts_id` int(11) NOT NULL AUTO_INCREMENT,
  `clock_in_time` datetime DEFAULT NULL,
  `clock_out_time` datetime DEFAULT NULL,
  PRIMARY KEY (`ts_id`),
  KEY `fk_1` (`employee_id`),
  CONSTRAINT `Timesheet_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Timesheet`
--

LOCK TABLES `Timesheet` WRITE;
/*!40000 ALTER TABLE `Timesheet` DISABLE KEYS */;
INSERT INTO `Timesheet` VALUES (1,1,'2018-11-02 08:00:38','2018-11-02 16:00:38'),(1,2,'2018-11-03 07:14:07','2018-11-03 16:14:07'),(1,3,'2018-11-04 07:47:32','2018-11-04 15:47:32'),(1,4,'2018-11-05 07:26:25','2018-11-05 15:56:25'),(1,5,'2018-11-06 07:21:17','2018-11-06 14:21:17'),(1,6,'2018-11-07 07:18:45','2018-11-07 16:48:45'),(1,7,'2018-11-08 07:20:46','2018-11-08 17:50:46'),(2,8,'2018-11-02 08:00:00','2018-11-02 16:00:00'),(2,9,'2018-11-03 08:14:07','2018-11-03 16:14:07'),(2,10,'2018-11-04 08:40:32','2018-11-04 16:40:32'),(2,11,'2018-11-05 07:26:25','2018-11-05 14:56:25'),(2,12,'2018-11-06 07:20:17','2018-11-06 14:21:17'),(2,13,'2018-11-07 06:18:45','2018-11-07 15:48:45'),(2,14,'2018-11-08 07:10:00','2018-11-08 17:40:00'),(3,15,'2018-11-02 08:30:38','2018-11-02 16:30:38'),(3,16,'2018-11-03 08:14:07','2018-11-03 15:14:07'),(3,17,'2018-11-04 07:40:32','2018-11-04 15:40:32'),(3,18,'2018-11-05 08:26:25','2018-11-05 13:56:25'),(3,19,'2018-11-06 08:20:17','2018-11-06 14:21:17'),(3,20,'2018-11-07 06:18:45','2018-11-07 14:48:45'),(3,21,'2018-11-08 07:10:00','2018-11-08 17:40:00'),(4,22,'2018-11-02 09:00:38','2018-11-02 16:00:38'),(4,23,'2018-11-03 09:14:07','2018-11-03 17:14:07'),(4,24,'2018-11-04 07:40:32','2018-11-04 17:40:32'),(4,25,'2018-11-05 07:26:25','2018-11-05 12:56:25'),(4,26,'2018-11-06 07:20:17','2018-11-06 14:21:17'),(4,27,'2018-11-07 08:18:45','2018-11-07 14:48:45'),(4,28,'2018-11-08 07:10:00','2018-11-08 17:40:00'),(5,29,'2018-11-02 09:30:38','2018-11-02 17:30:38'),(5,30,'2018-11-03 09:14:07','2018-11-03 17:14:07'),(5,31,'2018-11-04 08:47:32','2018-11-04 19:47:32'),(5,32,'2018-11-05 09:26:25','2018-11-05 14:56:25'),(5,33,'2018-11-06 09:20:17','2018-11-06 14:21:17'),(5,34,'2018-11-07 09:18:45','2018-11-07 14:48:45'),(5,35,'2018-11-08 07:10:20','2018-11-08 17:40:20'),(6,36,'2018-11-02 09:30:38','2018-11-02 16:30:38'),(6,37,'2018-11-03 08:14:07','2018-11-03 18:14:07'),(6,38,'2018-11-04 09:47:32','2018-11-04 16:47:32'),(6,39,'2018-11-05 06:26:25','2018-11-05 13:56:25'),(6,40,'2018-11-06 07:20:17','2018-11-06 14:21:17'),(6,41,'2018-11-07 08:18:45','2018-11-07 16:48:45'),(6,42,'2018-11-08 07:10:00','2018-11-08 17:40:00'),(7,43,'2018-11-02 08:00:38','2018-11-02 16:00:38'),(7,44,'2018-11-03 09:14:07','2018-11-03 15:14:07'),(7,45,'2018-11-04 07:47:32','2018-11-04 15:47:32'),(7,46,'2018-11-05 07:26:25','2018-11-05 12:56:25'),(7,47,'2018-11-06 06:20:17','2018-11-06 14:21:17'),(7,48,'2018-11-07 07:18:45','2018-11-07 15:48:45'),(7,49,'2018-11-08 07:10:40','2018-11-08 17:40:40'),(8,50,'2018-11-02 08:00:38','2018-11-02 16:00:38'),(8,51,'2018-11-03 08:14:07','2018-11-03 16:14:07'),(8,52,'2018-11-04 09:48:32','2018-11-04 14:48:32'),(8,53,'2018-11-05 07:26:25','2018-11-05 15:56:25'),(8,54,'2018-11-06 07:20:17','2018-11-06 14:21:17'),(8,55,'2018-11-07 07:18:45','2018-11-07 16:48:45'),(8,56,'2018-11-08 07:10:50','2018-11-08 17:40:50'),(9,57,'2018-11-02 07:00:38','2018-11-02 14:00:38'),(9,58,'2018-11-03 09:14:07','2018-11-03 18:14:07'),(9,59,'2018-11-04 07:47:32','2018-11-04 15:47:32'),(9,60,'2018-11-05 08:26:25','2018-11-05 14:56:25'),(9,61,'2018-11-06 08:30:17','2018-11-06 14:21:17'),(9,62,'2018-11-07 07:18:45','2018-11-07 16:48:45'),(9,63,'2018-11-08 07:10:10','2018-11-08 17:40:10'),(10,64,'2018-11-02 08:20:38','2018-11-02 16:50:38'),(10,65,'2018-11-03 07:14:07','2018-11-03 16:14:07'),(10,66,'2018-11-04 07:47:32','2018-11-04 19:47:32'),(10,67,'2018-11-05 07:26:25','2018-11-05 13:56:25'),(10,68,'2018-11-06 07:21:17','2018-11-06 14:21:17'),(10,69,'2018-11-07 08:18:45','2018-11-07 15:48:45'),(10,70,'2018-11-08 07:10:46','2018-11-08 17:40:46');
/*!40000 ALTER TABLE `Timesheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(13) DEFAULT NULL,
  `address_line1` varchar(255) DEFAULT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `U1` (`last_name`,`first_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Channing','Curtis','1628050944999','270-3917 Donec Road','Concord','Alençon','Basse-Normandie','9141','ipsum.Phasellus@Cumsociisnatoque.ca','2017-12-22 18:22:05'),(2,'Wylie','Olsen','1692012647499','676-874 Nulla Ave','P.O. Box 203, 4681 Ullamcorper','Vienna','Wie','9909','tristique@vulputatenisisem.com','2018-12-30 14:54:26'),(3,'Kenneth','Deleon','1682040690899','926-2313 Aenean Rd','Ap #901-6824 Consectetuer, Avenue','Wilmington','DE','90461','In.at.pede@magnaUttincidunt.ca','2019-03-01 03:33:57'),(4,'Beck','Kim','1632021999099','811-8775 Nec Ave','399-9408 Neque St.','Vienna','Wie','9906','malesuada.id.erat@lobortis.com','2018-10-24 06:55:27'),(5,'Natalie','Graves','1680122573099','1075 Lacus Street','Ap #979-7377 Facilisis Avenue','Oxford County','Ontario','712523','diam@loremDonec.org','2019-04-09 19:31:45'),(6,'Cameron','Navarro','1681072582499','3963 Amet, Av.','6181 Pede, Avenue','Lacombe County','AB','876065','sed@Nullatempor.co.uk','2019-04-16 19:10:11'),(7,'Kyra','Vargas','1682020957199','1534 Sapien, Avenue','P.O. Box 262, 2818 Aliquam Avenue','Täby','AB','1855','neque.non@nisl.net','2017-12-03 13:24:52'),(8,'Kibo','Christensen','1608112797399','Ap #646-7552 Proin Ave','Ap #290-9540 A','Reus','Catalunya','12-105','eu.tellus.eu@nonummyultriciesornare.com','22018-08-09 01:33:03'),(9,'Jane','Harrell','1619052727499','570-497 Elementum, Road','Ap #185-3023 Proin St.','Brisbane','Queensland','78612-963','dolor.sit@Nuncmauriselit.edu','2019-10-01 05:29:00'),(10,'Theodore','Franklin','1637111785299','1855 Proin Av.','824-8300 Nec Avenue','Gullegem','WV','5502','a@Sed.co.uk','2018-11-21 13:37:34'),(11,'Amir','West','1699020900399','Ap #510-7424 Leo. Road','P.O. Box 956, 5484 Mi St.','Jefferson City','MO','6268','auctor@justoProinnon.com','2019-08-12 20:08:48'),(12,'Ryder','Patel','1667071716499','907-8543 Sit Av.','P.O. Box 306, 2167 In, Street','Karacabey','Bursa','712523','Vivamus@elitEtiamlaoreet.co.uk','2018-04-21 03:14:24'),(13,'Ruth','Newton','1687110328799','6917 Dolor Ave','537-4478 Velit. St.','Ödemi','zm','3406','ultrices.iaculis@hendreritidante.ca','2018-07-20 18:48:06'),(14,'Ainsley','Stone','1626052263199','Ap #395-5161 Vitae, Ave','8411 Augue Rd.','Terrance','BC','3044','consequat@aauctornon.com','2019-05-31 10:57:59'),(15,'Daphne','Cote','1608112798509','P.O. Box 858, 1570 Facilisi. Street','790-2965 Tellus Rd.','Ajax','ON','9378','Nulla.aliquet.Proin@nullaDonec.ca','2018-08-16 14:49:50'),(16,'Herrod','Mcneil','1623752727499','141-8711 Blandit Av.','3652 Sed Av.','Barghe','Lombardia','84-844	','interdum.ligula@id.ca','2019-09-06 20:27:49'),(17,'Garrett','Stanley','1629082203199','466-5302 Enim St.','8374 Proin Avenue','Portezuelo','VII','55603','mauris@eleifend.com','2019-06-20 08:48:50'),(18,'Elliott','Pate','1689032567899','269-9794 Rhoncus. Street','996-4549 At, Av.','Nanco','Lorraine','992931','est@viverraDonectempus.co.uk','2019-04-25 00:15:40'),(19,'Hyacinth','Gallagher','1603090507499','479-5965 Interdum. Street','Ap #586-4571 Lorem Avenue','Warwick','ON','9591','Integer.id.magna@dapibus.org','2018-03-10 '),(20,'Irma','Jordan','1677050173799','P.O. Box 206, 4416 Enim Ave','P.O. Box 200, 3184 Egestas Ave','Parramatta','New South Wales','11349','dolor.Fusce@egetipsumSuspendisse.ca','2018-08-15 08:09:05');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendor`
--

DROP TABLE IF EXISTS `Vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vendor` (
  `vendor_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(30) NOT NULL,
  `phone_number` bigint(10) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `zipcode` varchar(10) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `vendor_name_UNIQUE` (`vendor_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendor`
--

LOCK TABLES `Vendor` WRITE;
/*!40000 ALTER TABLE `Vendor` DISABLE KEYS */;
INSERT INTO `Vendor` VALUES (1,'KN Logistics',2309569825,'95 Hawthorne Village','21st Ave','Charlotte','North Carolina','27486'),(2,'Whole Wharehouse Foods',9834873476,'769 Moorseville Street','41st Ave','Charlotte','North Carolina','36486'),(3,'Food Shipping Co',2435674567,'6398 Ashville','51st Ave','Raleigh','North Carolina','54826'),(4,'Trusty Food Shipper',5678934567,'757 Colleville Gardens','71st Street','Chapel Hill','North Carolina','38576'),(5,'United States Food Shipper (US',1749364958,'54 Ashford Greens','','Charlotte','North Carolina','36502'),(6,'Farmer Joe\'s Produce and Meats',9364862759,'32 UT Drive','','Charlotte','North Carolina','29637'),(7,'Secure Sustenance Shipper',9385526475,'44 University Terrace North','61st Street','Raleigh','North Carolina','65432');
/*!40000 ALTER TABLE `Vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendor_product_price`
--

DROP TABLE IF EXISTS `Vendor_product_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vendor_product_price` (
  `vp_id` int(11) NOT NULL AUTO_INCREMENT,
  `vendor_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `vendor_price` float NOT NULL,
  PRIMARY KEY (`vp_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Vendor_product_price_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `Vendor` (`vendor_id`),
  CONSTRAINT `Vendor_product_price_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendor_product_price`
--

LOCK TABLES `Vendor_product_price` WRITE;
/*!40000 ALTER TABLE `Vendor_product_price` DISABLE KEYS */;
INSERT INTO `Vendor_product_price` VALUES (1,1,1,2),(2,1,2,2),(3,1,3,1),(4,2,1,1),(5,2,2,1.5),(6,2,3,1),(7,3,4,1.5),(8,3,5,2.5),(9,3,6,1.25),(10,4,4,2.5),(11,4,5,2),(12,4,6,2.15),(13,5,4,3),(14,5,5,2.15),(15,5,6,1.75);
/*!40000 ALTER TABLE `Vendor_product_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `View_CheckoutDetails`
--

DROP TABLE IF EXISTS `View_CheckoutDetails`;
/*!50001 DROP VIEW IF EXISTS `View_CheckoutDetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `View_CheckoutDetails` AS SELECT 
 1 AS `Checkout ID`,
 1 AS `Product`,
 1 AS `Price Per Item`,
 1 AS `Quantity`,
 1 AS `Total Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Weekly_pay`
--

DROP TABLE IF EXISTS `Weekly_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Weekly_pay` (
  `employee_id` int(11) NOT NULL,
  `week_start_date` date DEFAULT NULL,
  `week_end_date` date DEFAULT NULL,
  `hours_worked` float DEFAULT NULL,
  `total pay` float DEFAULT NULL,
  `weekly_pay_ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`weekly_pay_ID`),
  KEY `WP1` (`employee_id`),
  KEY `WP2` (`week_start_date`,`week_end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Weekly_pay`
--

LOCK TABLES `Weekly_pay` WRITE;
/*!40000 ALTER TABLE `Weekly_pay` DISABLE KEYS */;
/*!40000 ALTER TABLE `Weekly_pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_CheckoutDetails`
--

DROP TABLE IF EXISTS `v_CheckoutDetails`;
/*!50001 DROP VIEW IF EXISTS `v_CheckoutDetails`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_CheckoutDetails` AS SELECT 
 1 AS `Checkout ID`,
 1 AS `Name`,
 1 AS `Order Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'Grocery'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `delete_timesheet_event` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`DBProjectTeam8`@`%`*/ /*!50106 EVENT `delete_timesheet_event` ON SCHEDULE EVERY 1 WEEK STARTS '2018-12-10 00:00:05' ON COMPLETION NOT PRESERVE ENABLE DO call delete_timesheet() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `weekly_payroll_event` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`DBProjectTeam8`@`%`*/ /*!50106 EVENT `weekly_payroll_event` ON SCHEDULE EVERY 1 WEEK STARTS '2018-12-10 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO call weekly_payroll() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'Grocery'
--
/*!50003 DROP PROCEDURE IF EXISTS `delete_timesheet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `delete_timesheet`()
begin
    declare n int default 0;
	declare i int default 1;
    select count(*) from Timesheet into n;
        while i <= n do
        delete from Timesheet where Timesheet.ts_id = i;
        set i = i + 1;
        end while;
	truncate table Grocery_Test.Timesheet;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fire_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `fire_employee`(in employee_id_var int)
begin
delete from Managed_by where (employee_id = employee_id_var);
delete from Payrate where (employee_id = employee_id_var);
delete from Employee where (employee_id = employee_id_var);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_PurchaseHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `get_PurchaseHistory`(IN userId int(11))
BEGIN  
select Checkout.checkout_id, Checkout.date, CONCAT_WS(', ',
                `User`.`last_name`,
                `User`.`first_name`) AS `Name`,
                CONCAT('$',
                ROUND(SUM((`Checkout_Details`.`quantity` * `Product`.`price`)),
                        2)) AS `Total Price` from Checkout
inner join Checkout_Details on Checkout.checkout_id = Checkout_Details.checkout_id
inner join Product on Checkout_Details.product_id = Product.product_id
inner join User on Checkout.user_id = User.user_id where Checkout.user_id = userId
group by Checkout.checkout_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hire_employee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `hire_employee`(in user_id_var int, in employee_ssn char(9),in employee_pay_rate double, in employee_manager_id int)
begin
declare employee_id_var int;
insert into Employee(user_id, ssn) values (user_id_var, employee_ssn);
select employee_id into employee_id_var
from Employee
where user_id = user_id_var;
insert into Payrate values(employee_id_var, employee_pay_rate);
insert into Managed_by values(employee_id_var, employee_manager_id);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `orderdetails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `orderdetails`(IN orderID int(11))
BEGIN
declare delivery_date date;
declare status varchar(50); 
update Order_details
set delivery_date = curdate(), status = 'Delivered'
where order_id=orderID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `product_update` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `product_update`(IN orderID int(11),IN Quantity int(11))
BEGIN
declare prdt_id int;
declare x int(11) default 0;
declare y int(11) default 0;

case when exists(select p.product_id from Product p
inner join Order_table o on o.product_id=p.product_id
inner join Order_details od on od.order_id=o.order_id
where od.order_id=orderID)
then
    begin

    select p.product_id into prdt_id from Product p
	inner join Order_table o on o.product_id=p.product_id
	inner join Order_details od on od.order_id=o.order_id
	where od.order_id=orderID;
    
    select quantity_available into x from Product p
	inner join Order_table o on o.product_id=p.product_id
	inner join Order_details od on od.order_id=o.order_id
	where od.order_id=orderID;

	set y = x + Quantity;
    
    update Product set quantity_available = y where product_id = prdt_id;
end;
end case;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `weekly_payroll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`DBProjectTeam8`@`%` PROCEDURE `weekly_payroll`()
begin
		declare week_start date;
        declare week_end date;
		declare hours_worked float default 0;
        declare pay float default 0;
        declare n int default 0;
        declare i int default 1;
        select count(*) from Employee into n;
        while i <= n do
        select (sum(timestampdiff(hour,Timesheet.clock_in_time,Timesheet.clock_out_time))),
        round(Payrate.pay_rate*(sum(timestampdiff(hour,Timesheet.clock_in_time,Timesheet.clock_out_time))),2),
        date(min(Timesheet.clock_in_time)), date(max(Timesheet.clock_out_time))
			into hours_worked, pay, week_start, week_end from Timesheet
			inner join Payrate on Timesheet.employee_id=Payrate.employee_id
			where Timesheet.employee_id = i;
		insert into Weekly_pay(employee_id, week_start_date, week_end_date, hours_worked,`total pay`) values (i, week_start, week_end, hours_worked, pay);
		set i = i + 1;
        end while;
    end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `Catalog`
--

/*!50001 DROP VIEW IF EXISTS `Catalog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DBProjectTeam8`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Catalog` AS select `Product`.`product_name` AS `Product`,`Category`.`category_name` AS `Category`,concat('$',round(`Product`.`price`,2)) AS `Price`,`Category`.`aisle_number` AS `Location`,`Product`.`quantity_available` AS `#Available` from ((`Product` join `ProductCategory` on((`Product`.`product_id` = `ProductCategory`.`product_id`))) join `Category` on((`ProductCategory`.`category_id` = `Category`.`category_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Employee_Pay`
--

/*!50001 DROP VIEW IF EXISTS `Employee_Pay`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DBProjectTeam8`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Employee_Pay` AS select `Weekly_pay`.`employee_id` AS `Employee ID`,concat_ws(', ',`User`.`last_name`,`User`.`first_name`) AS `Name`,`Weekly_pay`.`hours_worked` AS `Hours worked`,concat('$',round((`Payrate`.`pay_rate` * `Weekly_pay`.`hours_worked`),2)) AS `Pay for Week` from (((`Weekly_pay` join `Payrate` on((`Weekly_pay`.`employee_id` = `Payrate`.`employee_id`))) join `Employee` on((`Weekly_pay`.`employee_id` = `Employee`.`user_id`))) join `User` on((`Employee`.`user_id` = `User`.`user_id`))) group by `Weekly_pay`.`employee_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `Salaried_Employees`
--

/*!50001 DROP VIEW IF EXISTS `Salaried_Employees`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DBProjectTeam8`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `Salaried_Employees` AS select `Weekly_pay`.`employee_id` AS `Salaried Employee ID`,concat_ws(', ',`User`.`last_name`,`User`.`first_name`) AS `Name`,concat('$',round((`Payrate`.`pay_rate` * 2080),2)) AS `Annual Salary` from (((`Weekly_pay` join `Payrate` on((`Weekly_pay`.`employee_id` = `Payrate`.`employee_id`))) join `Employee` on((`Weekly_pay`.`employee_id` = `Employee`.`user_id`))) join `User` on((`Employee`.`user_id` = `User`.`user_id`))) where `Weekly_pay`.`employee_id` in (select `Manager`.`employee_id` from `Manager`) group by `Weekly_pay`.`employee_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `View_CheckoutDetails`
--

/*!50001 DROP VIEW IF EXISTS `View_CheckoutDetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DBProjectTeam8`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `View_CheckoutDetails` AS select `c`.`checkout_id` AS `Checkout ID`,`p`.`product_name` AS `Product`,concat('$',round(`p`.`price`,2)) AS `Price Per Item`,`cd`.`quantity` AS `Quantity`,concat('$',(`p`.`price` * `cd`.`quantity`)) AS `Total Price` from (((`Checkout` `c` join `Checkout_Details` `cd` on((`c`.`checkout_id` = `cd`.`checkout_id`))) join `Product` `p` on((`cd`.`product_id` = `p`.`product_id`))) join `User` `u` on((`c`.`user_id` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_CheckoutDetails`
--

/*!50001 DROP VIEW IF EXISTS `v_CheckoutDetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`DBProjectTeam8`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_CheckoutDetails` AS select `Checkout`.`checkout_id` AS `Checkout ID`,concat_ws(', ',`User`.`last_name`,`User`.`first_name`) AS `Name`,concat('$',round(sum((`Checkout_Details`.`quantity` * `Product`.`price`)),2)) AS `Order Price` from (((`Checkout` join `Checkout_Details` on((`Checkout`.`checkout_id` = `Checkout_Details`.`checkout_id`))) join `Product` on((`Checkout_Details`.`product_id` = `Product`.`product_id`))) join `User` on((`Checkout`.`user_id` = `User`.`user_id`))) group by `Checkout`.`checkout_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-02 23:22:17
