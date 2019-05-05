-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: nursing
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.04.1

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

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `dept_name` varchar(45) NOT NULL,
  `facility_name` varchar(45) NOT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('caridiac','Eden'),('general_physician','John George'),('neurology','Alameda'),('orthopedic','John George'),('paediatric','Eden'),('Psychiatry','John Hopkins'),('radiology','John Hopkins'),('trauma','Alameda');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facilities`
--

DROP TABLE IF EXISTS `facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facilities` (
  `facility_name` varchar(45) NOT NULL,
  `region_name` varchar(45) NOT NULL,
  PRIMARY KEY (`facility_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facilities`
--

LOCK TABLES `facilities` WRITE;
/*!40000 ALTER TABLE `facilities` DISABLE KEYS */;
INSERT INTO `facilities` VALUES ('Alameda','Chico'),('Alta Bates','Chico'),('Eden','Fresno'),('Fairmont','Fresno'),('Highland','Fresno'),('John George','Long Beach'),('John Hopkins','Long Beach'),('Kaiser','Chico');
/*!40000 ALTER TABLE `facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurses`
--

DROP TABLE IF EXISTS `nurses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nurse_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `supervisor_name` varchar(45) NOT NULL,
  `dept_name` varchar(45) NOT NULL,
  `facility_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurses`
--

LOCK TABLES `nurses` WRITE;
/*!40000 ALTER TABLE `nurses` DISABLE KEYS */;
INSERT INTO `nurses` VALUES (1,'Gloria','password-gloria','Tyrion','orthopedic','John George'),(2,'Jessica','password_jessica','Sophie','cardiac','Eden'),(3,'Monica','password-monia','Eric','trauma','Alameda'),(4,'Natasha','password_natasha','Arya','Psychitary','John Hopkins'),(5,'Victoria','password_victoria','Arya','Psychiatry','John Hopkins');
/*!40000 ALTER TABLE `nurses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regions` (
  `region_name` varchar(45) NOT NULL,
  PRIMARY KEY (`region_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES ('Chico'),('Fresno'),('Long Beach'),('Los Angeles'),('Marin'),('Sacramento'),('San Diego'),('San Francisco'),('Santa Clara'),('Sunnyvale');
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisors`
--

DROP TABLE IF EXISTS `supervisors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervisors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supervisor_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `facility_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisors`
--

LOCK TABLES `supervisors` WRITE;
/*!40000 ALTER TABLE `supervisors` DISABLE KEYS */;
INSERT INTO `supervisors` VALUES (1,'Arya','no_one','John Hopkins'),(2,'Eric','eric_password','Alameda'),(3,'Sophie','sophie_password','Eden'),(4,'Tyrion','genius','John George');
/*!40000 ALTER TABLE `supervisors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasksassigned`
--

DROP TABLE IF EXISTS `tasksassigned`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tasksassigned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskname` varchar(45) NOT NULL,
  `status` varchar(20) NOT NULL,
  `dept_name` varchar(45) NOT NULL,
  `facility_name` varchar(45) NOT NULL,
  `nurse_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`,`taskname`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasksassigned`
--

LOCK TABLES `tasksassigned` WRITE;
/*!40000 ALTER TABLE `tasksassigned` DISABLE KEYS */;
INSERT INTO `tasksassigned` VALUES (1,'cleaning','in progress','Psychiatry','John Hopkins','Natasha'),(2,'Change IV','Done','cardiac','Eden','Jessica'),(3,'food serving','done','Psychiatry','John Hopkins','Victoria'),(4,'giving medicines','in progress','trauma','Alameda','Monica'),(5,'preparing for surgery','delayed','cardiac','Eden','Jessica');
/*!40000 ALTER TABLE `tasksassigned` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worklog`
--

DROP TABLE IF EXISTS `worklog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worklog` (
  `nurse_name` varchar(45) NOT NULL,
  `dept_name` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  `hours` int(11) NOT NULL,
  `task_name` varchar(280) NOT NULL,
  `shift` varchar(20) NOT NULL,
  `facility_name` varchar(45) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worklog`
--

LOCK TABLES `worklog` WRITE;
/*!40000 ALTER TABLE `worklog` DISABLE KEYS */;
INSERT INTO `worklog` VALUES ('Jessica','cardiac','2019-05-03 03:47:09',2,'Others','Evening','Eden',1),('Jessica','cardiac','2019-05-03 03:55:25',1,'Billing, maintainance','morning','Eden',2);
/*!40000 ALTER TABLE `worklog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-03 17:14:32
