CREATE DATABASE  IF NOT EXISTS `starwarswangs` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `starwarswangs`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: starwarswangs
-- ------------------------------------------------------
-- Server version	5.7.10-log

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
-- Table structure for table `affiliation`
--

DROP TABLE IF EXISTS `affiliation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `affiliation` (
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data of affiliation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `affiliation`
--

LOCK TABLES `affiliation` WRITE;
/*!40000 ALTER TABLE `affiliation` DISABLE KEYS */;
INSERT INTO `affiliation` VALUES ('empire'),('free-lancer'),('neutral'),('rebels');
/*!40000 ALTER TABLE `affiliation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `characters`
--

DROP TABLE IF EXISTS `characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `characters` (
  `Name` varchar(45) NOT NULL,
  `Race` varchar(45) DEFAULT NULL,
  `Homeworld` varchar(45) DEFAULT NULL,
  `Affiliation` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `affiliation_idx` (`Affiliation`),
  KEY `home_idx` (`Homeworld`),
  CONSTRAINT `affiliation` FOREIGN KEY (`Affiliation`) REFERENCES `affiliation` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `home` FOREIGN KEY (`Homeworld`) REFERENCES `planets` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='data on the characters in the movie';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `characters`
--

LOCK TABLES `characters` WRITE;
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` VALUES ('C-3 PO','Droid',NULL,'rebels'),('Chewbacca','Wookie','Kashyyyk','rebels'),('Darth Vader','Human',NULL,'empire'),('Han Solo','Human','Corellia','rebels'),('Jabba the Hutt','Hutt',NULL,'neutral'),('Lando Calrissian','Human',NULL,'rebels'),('Luke Skywalker','Human','Tatooine','rebels'),('Obi-Wan Kanobi','Human','Tatooine','rebels'),('Owen Lars','Human','Tatooine','neutral'),('Princess Leia','Human','Alderaan','rebels'),('R2-D2','Droid',NULL,'rebels'),('Rancor','Rancor',NULL,'neutral'),('Yoda',NULL,NULL,'neutral');
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movies` (
  `ID` int(11) NOT NULL,
  `Title` varchar(45) NOT NULL,
  `ScenesinDB` int(11) DEFAULT NULL,
  `ScenesinMovies` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The names of the movies you are tracking';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Episode IV: A New Hope',10,13),(2,'Episode V: The Empire Strikes Back',10,17),(3,'Episode VI: Return of the Jedi',10,15);
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planets`
--

DROP TABLE IF EXISTS `planets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planets` (
  `Name` varchar(45) NOT NULL,
  `Type` varchar(45) DEFAULT NULL,
  `Affiliation` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `affiliation_idx` (`Affiliation`),
  CONSTRAINT `AffiliationPlanet` FOREIGN KEY (`Affiliation`) REFERENCES `affiliation` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='data on the planets appearing in the movies';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planets`
--

LOCK TABLES `planets` WRITE;
/*!40000 ALTER TABLE `planets` DISABLE KEYS */;
INSERT INTO `planets` VALUES ('Alderaan','temperate','rebels'),('Bespin','gas','neutral'),('Corellia','temperate','rebels'),('Dagobah','swamp','neutral'),('Death Star','artificial','empire'),('Endor','forest','neutral'),('Hoth','ice','rebels'),('Kashyyyk','forest','rebels'),('Star Destroyer','artificial','empire'),('Tatooine','desert','neutral');
/*!40000 ALTER TABLE `planets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timetable` (
  `TimeID` int(11) NOT NULL AUTO_INCREMENT,
  `CharactersName` varchar(45) NOT NULL,
  `PlanetsName` varchar(45) NOT NULL,
  `Movie` int(11) NOT NULL,
  `TimeOfArrival` int(11) NOT NULL,
  `TimeOfDeparture` int(11) DEFAULT NULL,
  PRIMARY KEY (`TimeID`),
  KEY `Character_idx` (`CharactersName`),
  KEY `Planet_idx` (`PlanetsName`),
  KEY `Movie_idx` (`Movie`),
  CONSTRAINT `Character` FOREIGN KEY (`CharactersName`) REFERENCES `characters` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Movie` FOREIGN KEY (`Movie`) REFERENCES `movies` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `Planet` FOREIGN KEY (`PlanetsName`) REFERENCES `planets` (`Name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` VALUES (1,'C-3 PO','Bespin',2,5,9),(2,'C-3 PO','Hoth',2,0,2),(3,'C-3 PO','Tatooine',1,0,2),(4,'C-3 PO','Tatooine',3,0,2),(5,'Chewbacca','Bespin',2,5,9),(6,'Chewbacca','Endor',3,5,10),(7,'Chewbacca','Hoth',2,0,2),(8,'Chewbacca','Tatooine',1,0,2),(9,'Chewbacca','Tatooine',3,0,2),(10,'Darth Vader','Bespin',2,5,10),(11,'Darth Vader','Death Star',1,9,10),(12,'Darth Vader','Death Star',3,1,9),(13,'Darth Vader','Hoth',2,3,4),(14,'Darth Vader','Star Destroyer',1,0,9),(15,'Han Solo','Bespin',2,5,9),(16,'Han Solo','Endor',3,5,10),(17,'Han Solo','Hoth',2,0,4),(18,'Han Solo','Star Destroyer',1,3,5),(19,'Han Solo','Tatooine',1,0,2),(20,'Han Solo','Tatooine',3,0,2),(21,'Jabba the Hutt','Tatooine',1,0,10),(22,'Jabba the Hutt','Tatooine',2,0,10),(23,'Jabba the Hutt','Tatooine',3,0,2),(24,'Lando Calrissian','Bespin',2,0,9),(25,'Lando Calrissian','Endor',3,9,10),(26,'Lando Calrissian','Tatooine',3,0,2),(27,'Luke Skywalker','Bespin',2,8,10),(28,'Luke Skywalker','Dagobah',2,4,8),(29,'Luke Skywalker','Dagobah',3,4,5),(30,'Luke Skywalker','Death Star',1,9,10),(31,'Luke Skywalker','Death Star',3,8,10),(32,'Luke Skywalker','Endor',3,5,8),(33,'Luke Skywalker','Hoth',2,0,2),(34,'Luke Skywalker','Star Destroyer',1,3,5),(35,'Luke Skywalker','Tatooine',1,0,2),(36,'Luke Skywalker','Tatooine',3,1,2),(37,'Obi-Wan Kanobi','Star Destroyer',1,3,5),(38,'Obi-Wan Kanobi','Tatooine',1,0,2),(39,'Owen Lars','Tatooine',1,0,1),(40,'Princess Leia','Bespin',2,5,9),(41,'Princess Leia','Endor',3,5,10),(42,'Princess Leia','Hoth',2,0,4),(43,'Princess Leia','Star Destroyer',1,1,5),(44,'Princess Leia','Tatooine',3,0,2),(45,'R2-D2','Bespin',2,8,10),(46,'R2-D2','Dagobah',2,4,8),(47,'R2-D2','Dagobah',3,4,5),(48,'R2-D2','Endor',3,5,8),(49,'R2-D2','Hoth',2,0,2),(50,'R2-D2','Tatooine',1,0,10),(51,'Rancor','Tatooine',1,0,10),(52,'Rancor','Tatooine',2,0,10),(53,'Rancor','Tatooine',3,0,3),(54,'Yoda','Dagobah',1,0,10),(55,'Yoda','Dagobah',2,0,10),(56,'Yoda','Dagobah',3,0,5);
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-10 19:02:58
