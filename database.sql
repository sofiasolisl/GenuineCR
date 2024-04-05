CREATE DATABASE  IF NOT EXISTS `oaerflmy_crauthentic` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `oaerflmy_crauthentic`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: oaerflmy_crauthentic
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `cellphone` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Sofia','Solis Loaiciga','sofis64@gmail.com',87055124,'2023-11-01 16:14:12','2024-03-14 10:52:10'),(2,'Pablo','Fallas Florian','pafaflo18@gmail.com',87055124,'2023-11-04 21:53:05','2023-11-04 22:05:50'),(3,'Sofia','Solis Loaiciga','sofis64.developer@gmail.com',87055124,'2023-11-06 18:00:01','2023-11-06 18:00:01');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `id` int NOT NULL,
  `location` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Airport Daniel Oduber (LIR)','2023-10-30 13:54:20','2023-10-30 13:54:20'),(2,'Papagayo ','2023-10-30 13:54:40','2023-10-30 13:54:40'),(3,'Hermosa Beach/Panama Beach','2023-10-30 13:54:53','2023-10-30 13:54:53'),(4,'Coco Beach','2023-10-30 13:55:22','2023-10-30 13:55:22'),(5,'Conchal Beach','2023-10-30 13:55:38','2023-10-30 13:55:38'),(6,'Flamingo Beach','2023-10-30 13:56:14','2023-10-30 13:56:14'),(7,'Potrero Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(8,'Las Catalinas Town','2024-01-24 13:36:19','2024-01-24 13:36:19'),(9,'Hacienda Pinilla','2024-01-24 13:36:19','2024-01-24 13:36:19'),(10,'Dreams Las Mareas','2024-01-24 13:36:19','2024-01-24 13:36:19'),(11,'Sámara Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(12,'Carrillo Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(13,'Nosara Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(14,'Tamarindo Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(15,'Riu Hotel','2024-01-24 13:36:19','2024-01-24 13:36:19'),(16,'Conchal Beach','2024-01-24 13:36:19','2024-01-24 13:36:19'),(17,'Punta Islita','2024-01-24 13:36:19','2024-01-24 13:36:19'),(19,'Airport Juan Santamaria (SJO)','2024-01-24 15:53:43','2024-01-24 15:53:43');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL,
  `pickup_details` varchar(255) DEFAULT NULL,
  `dropoff_details` varchar(255) DEFAULT NULL,
  `passengers` int DEFAULT NULL,
  `suitcases` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `hour` time DEFAULT NULL,
  `prices_idprices` int NOT NULL,
  `prices_routes_id` int NOT NULL,
  `customers_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`prices_idprices`,`prices_routes_id`,`customers_id`),
  KEY `fk_orders_prices1_idx` (`prices_idprices`,`prices_routes_id`),
  KEY `fk_orders_customers1_idx` (`customers_id`),
  CONSTRAINT `fk_orders_customers1` FOREIGN KEY (`customers_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `fk_orders_prices1` FOREIGN KEY (`prices_idprices`, `prices_routes_id`) REFERENCES `prices` (`id`, `route_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'hola','hola',1,1,'2023-11-08','21:47:00',1,1,1,'2023-11-04 21:48:14','2023-11-04 21:48:14'),(2,'hola','hola',1,1,'2023-11-08','21:47:00',1,1,1,'2023-11-04 21:49:06','2023-11-04 21:49:06'),(3,'hola','hola',1,1,'2023-11-08','21:47:00',1,1,1,'2023-11-04 21:49:25','2023-11-04 21:49:25'),(4,'hola','hola',1,1,'2023-11-08','21:47:00',1,1,1,'2023-11-04 21:50:47','2023-11-04 21:50:47'),(5,'hola','hola',1,1,'2023-11-28','21:52:00',2,2,2,'2023-11-04 21:53:17','2023-11-04 21:53:17'),(6,'hola','hola',1,1,'2023-11-09','22:10:00',1,1,2,'2023-11-04 22:06:00','2023-11-04 22:06:00'),(7,'hola','hola',1,1,'2023-11-06','23:52:00',1,1,1,'2023-11-05 11:53:24','2023-11-05 11:53:24'),(8,'hola','hola',1,1,'2023-11-06','23:52:00',1,1,1,'2023-11-05 12:05:01','2023-11-05 12:05:01'),(9,'hola','hola',1,1,'2023-11-06','23:52:00',1,1,1,'2023-11-05 12:05:25','2023-11-05 12:05:25'),(10,'  ','  ',2,0,'2023-11-24','21:04:00',2,2,1,'2023-11-05 21:02:49','2023-11-05 21:02:49'),(11,'','',2,1,'2023-11-09','17:59:00',1,1,3,'2023-11-06 18:01:02','2023-11-06 18:01:02'),(12,'hola','hola',2,2,'2023-11-09','21:59:00',1,1,1,'2023-11-06 22:06:47','2023-11-06 22:06:47'),(13,'','',2,2,'2023-11-09','15:34:00',3,3,1,'2023-11-10 15:36:12','2023-11-10 15:36:12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `id` int NOT NULL,
  `price` int DEFAULT NULL,
  `route_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`,`route_id`),
  KEY `fk_prices_routes1_idx` (`route_id`),
  CONSTRAINT `fk_prices_routes1` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,60,1,'2023-10-30 14:10:22','2023-10-30 14:10:22'),(2,60,2,'2023-10-30 14:10:57','2023-10-30 14:10:57'),(3,60,3,'2023-10-30 14:11:07','2023-10-30 14:11:07'),(4,145,4,'2023-10-30 14:11:33','2023-10-30 14:11:33'),(5,145,5,'2023-10-30 14:12:25','2023-10-30 14:12:25'),(6,145,6,'2023-10-30 14:12:36','2023-10-30 14:12:36'),(7,145,7,'2023-10-30 14:12:42','2023-10-30 14:12:42'),(8,160,8,'2023-10-30 14:12:51','2023-10-30 14:12:51'),(9,160,9,'2023-10-30 14:13:41','2023-10-30 14:13:41'),(10,190,10,'2023-10-30 14:13:50','2023-10-30 14:13:50'),(11,190,11,'2024-01-24 16:43:11','2024-01-24 16:43:11'),(12,205,12,'2024-01-24 16:43:11','2024-01-24 16:43:11'),(13,260,13,'2024-01-24 16:43:11','2024-01-24 16:43:11'),(14,260,14,'2024-01-24 16:43:11','2024-01-24 16:43:11'),(15,260,15,'2024-01-24 16:43:12','2024-01-24 16:43:12'),(16,290,16,'2024-01-24 16:43:12','2024-01-24 16:43:12'),(17,290,17,'2024-01-24 16:43:12','2024-01-24 16:43:12'),(18,290,18,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(19,290,19,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(20,290,20,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(21,280,21,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(22,280,22,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(23,280,23,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(24,280,24,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(25,320,25,'2024-01-24 16:44:05','2024-01-24 16:44:05'),(26,320,26,'2024-01-24 16:55:26','2024-01-24 16:55:26'),(27,290,27,'2024-01-24 16:55:26','2024-01-24 16:55:26');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routes` (
  `id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `from_location_id` int NOT NULL,
  `to_location_id` int NOT NULL,
  PRIMARY KEY (`id`,`from_location_id`,`to_location_id`),
  KEY `fk_routes_locations1_idx` (`from_location_id`),
  KEY `fk_routes_locations2_idx` (`to_location_id`),
  CONSTRAINT `fk_routes_locations1` FOREIGN KEY (`from_location_id`) REFERENCES `locations` (`id`),
  CONSTRAINT `fk_routes_locations2` FOREIGN KEY (`to_location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
INSERT INTO `routes` VALUES (1,'2023-10-30 13:57:23','2023-10-30 13:57:23',1,2),(2,'2023-10-30 13:58:18','2023-10-30 13:58:18',1,3),(3,'2023-10-30 13:58:43','2023-10-30 13:58:43',1,4),(4,'2023-10-30 13:59:00','2023-10-30 13:59:00',1,5),(5,'2023-10-30 13:59:36','2023-10-30 13:59:36',1,6),(6,'2023-10-30 14:00:07','2023-10-30 14:00:07',1,7),(7,'2023-10-30 14:00:37','2023-10-30 14:00:37',1,8),(8,'2023-10-30 14:00:47','2023-10-30 14:00:47',1,9),(9,'2023-10-30 14:00:58','2023-10-30 14:00:58',1,10),(10,'2023-10-30 14:01:16','2023-10-30 14:01:16',1,11),(11,'2024-01-24 16:12:02','2024-01-24 16:12:02',1,12),(12,'2024-01-24 16:12:02','2024-01-24 16:12:02',1,13),(13,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,2),(14,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,3),(15,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,4),(16,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,5),(17,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,6),(18,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,7),(19,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,17),(20,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,13),(21,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,11),(22,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,12),(23,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,14),(24,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,15),(25,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,9),(26,'2024-01-24 16:12:02','2024-01-24 16:12:02',19,10),(27,'2024-01-24 16:49:38','2024-01-24 16:49:38',19,8);
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_orders`
--

DROP TABLE IF EXISTS `tour_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `tour_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `people_qty` int DEFAULT NULL,
  `tour_date` date DEFAULT NULL,
  PRIMARY KEY (`id`,`customer_id`,`tour_id`),
  KEY `fk_tour_orders_customers1_idx` (`customer_id`),
  KEY `fk_tour_orders_tours1_idx` (`tour_id`),
  CONSTRAINT `fk_tour_orders_customers1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `fk_tour_orders_tours1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_orders`
--

LOCK TABLES `tour_orders` WRITE;
/*!40000 ALTER TABLE `tour_orders` DISABLE KEYS */;
INSERT INTO `tour_orders` VALUES (1,1,1,'2024-02-06 15:57:42','2024-02-06 15:57:42',1,NULL),(2,1,1,'2024-02-06 16:13:39','2024-02-06 16:13:39',5,'2024-02-22'),(3,1,1,'2024-02-06 16:16:56','2024-02-06 16:16:56',5,'2024-02-22'),(4,1,1,'2024-02-06 16:20:23','2024-02-06 16:20:23',5,'2024-02-22'),(5,1,1,'2024-02-06 16:22:38','2024-02-06 16:22:38',5,'2024-02-22'),(6,1,1,'2024-02-06 16:24:01','2024-02-06 16:24:01',5,'2024-02-22'),(7,1,1,'2024-02-06 16:24:50','2024-02-06 16:24:50',5,'2024-02-22'),(8,1,1,'2024-02-06 16:27:40','2024-02-06 16:27:40',5,'2024-02-22'),(9,1,1,'2024-02-06 16:29:28','2024-02-06 16:29:28',5,'2024-02-22'),(10,1,1,'2024-02-06 16:29:51','2024-02-06 16:29:51',5,'2024-02-22'),(11,1,1,'2024-02-06 16:31:04','2024-02-06 16:31:04',5,'2024-02-22'),(12,1,1,'2024-02-06 16:41:48','2024-02-06 16:41:48',5,'2024-02-21'),(13,1,1,'2024-02-06 17:38:02','2024-02-06 17:38:02',1,'2024-02-28'),(14,1,1,'2024-03-11 15:32:29','2024-03-11 15:32:29',2,'2024-03-12'),(15,1,1,'2024-03-11 15:33:51','2024-03-11 15:33:51',2,'2024-03-12'),(16,1,5,'2024-03-14 10:52:10','2024-03-14 10:52:10',1,'2024-03-21');
/*!40000 ALTER TABLE `tour_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tour_type`
--

DROP TABLE IF EXISTS `tour_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tour_type` (
  `id` int NOT NULL,
  `type_name` varchar(45) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tour_type`
--

LOCK TABLES `tour_type` WRITE;
/*!40000 ALTER TABLE `tour_type` DISABLE KEYS */;
INSERT INTO `tour_type` VALUES (1,'Love Nature Experiences','Love Nature Experiences invites you to explore Costa Rica\'s commitment to conservation, with over 25% of its land protected in national parks, wildlife refuges, biological stations, and private reserves. While nature walks offer a captivating introduction to a world teeming with insects, mammals, and reptiles, the true heartbeat of the rainforest lies above the forest floor—in the canopy. Each level of the canopy supports its unique array of plant and animal life.| For avid birdwatchers, Costa Rica is a renowned destination, boasting more than 920 recorded bird species. From the diminutive hummingbird to the vibrant Scarlet Macaws, Toucans, and elusive Quetzals, birding enthusiasts will find themselves captivated. Our night tours delve into the depths of the jungle immediately after sunset, unveiling the magical world of countless creatures that come to life in the darkness. Join us on Love Nature Experiences and immerse yourself in the wonders of Costa Rica\'s rich biodiversity.'),(2,'Ocean Adventures','Immerse yourself in the warm waters of the great pacific ocean! Enjoy the beauty of the Pacific on boat about: snorkelling, beach hopping, whale & dolphins watching tour. Get on board of the fishing adventure in Costa Rica, deep sea fishing charter experience of a lifetime');
/*!40000 ALTER TABLE `tour_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tours`
--

DROP TABLE IF EXISTS `tours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `description` longtext,
  `price` int DEFAULT NULL,
  `person_min` int DEFAULT NULL,
  `includes` longtext,
  `bring` longtext,
  `departure` time DEFAULT NULL,
  `return` time DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `img` varchar(45) DEFAULT NULL,
  `min_age` int DEFAULT NULL,
  `tour_type_id1` int NOT NULL,
  PRIMARY KEY (`id`,`tour_type_id1`),
  KEY `fk_tours_tour_type1_idx` (`tour_type_id1`),
  CONSTRAINT `fk_tours_tour_type1` FOREIGN KEY (`tour_type_id1`) REFERENCES `tour_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tours`
--

LOCK TABLES `tours` WRITE;
/*!40000 ALTER TABLE `tours` DISABLE KEYS */;
INSERT INTO `tours` VALUES (1,'Genuine Blue River & Sloths Spotting Park','Tenorio Volcano National Park ','Located in the Guanacaste Volcanic Mountain Range, this park has a rainforest that protects species of wildlife of regional importance. Within the area, the Tenorio Volcano, with its four cones, it offers natural scenic overlooks that allow appreciate the plains of the Pacific and Caribbean. The color of the Celeste River, surrounded by a lush forest, offers a stunning landscape worthy to be known and admired.\nSloths are part of a local farm, in a natural setting without having to hike deep into the jungle. ',150,2,'Round-trip, air-conditioned transportation| Professional bilingual guide| Lunch| Drinks| Park & Farm fee','Wear comfortable clothes and footwear| Bring insect repellent, sunglasses, sunscreen and a camera| Bring plastic bag, rain jacket, an extra change of clothes and cap or hat | Bring cash for souvenirs and others| Not recommended for pregnant women and people with mobility problems or physical limitations| Weather conditions can impact the activities and overall experience.','08:00:00','16:00:00','2024-02-05 15:44:23','2024-02-05 15:44:23','celeste2.jpg',6,1),(2,'Rincón de la Vieja Adventures & Hot Springs','Rincon de la Vieja Volcano','The Buena Vista Mega Combo Tour Costa Rica is a breathtaking destination located in the heart of Rincon de la Vieja Volcano. This enchanting region offers a plethora of thrilling activities and natural wonders to explore. ',240,2,'Canopy Zip Line Tour|Jungle Water Slide|Horseback Riding |Buffet Lunch|Cultural Tour (Sugar Cane, Pottery and Traditional food)|Hot Springs, Mud Bath, and Sauna| Round-trip, air-conditioned transportation|Professional bilingual guide|Lunch and Drinks|Entrance fee','Wear comfortable clothes and footwear | Bring insect repellent, sunglasses, sunscreen and a camera | Bring plastic bag, sandals, shorts, an extra change of clothes, bathing suit and cap or hat|Bring cash for souvenirs and others|Not recommended for pregnant women and people with mobility problems or physical limitations|Children 4 years and younger are not recommended|Weather conditions can impact the activities and overall experience.','07:30:00','16:00:00','2024-02-05 15:47:54','2024-02-05 15:47:54','bridge.jpg',4,1),(3,'The Beauty of La Bajura Waterfalls','La Leona Waterfall','Waterfalls stand as captivating wonders of nature, typically gracing the upper reaches of rivers in steep mountainous terrain. Despite Guanacaste\'s reputation for its flat landscape, hidden within some canyons are stunning waterfalls, known and undiscovered treasures awaiting exploration.|Llanos de Cortes Waterfall is undeniably impressive, especially during the rainy season when it overflows with the abundance of rainfall. A true oasis in the desert, the refreshing waters offer a delightful respite from the heat. While La Leona Waterfall has long been a hidden gem, its recent surge in popularity attests to its undeniable beauty. Nestled within a canyon, this picturesque waterfall features turquoise-blue waters that create a tranquil oasis. La Leona is a unique waterfall, distinguished by its deep blue hue set between two canyons. It stands as one of the few, if not the only, waterfalls in Costa Rica with this distinct characteristic. Sourced from the \"white river\" or \"Rio Blanco,\" originating in the slopes of the Rincon de la Vieja Volcano, the water\'s incredible color, a blend of blue and turquoise, is attributed to the presence of sulfur. A definite must-see in the region!',140,2,'Round-trip, air-conditioned transportation |Professional bilingual guide|Lunch |Drinks|Waterfalls fee','Wear comfortable clothes and footwear|Bring insect repellent, sunglasses, sunscreen and a camera|Bring plastic bag, shorts, an extra change of clothes, bathing suit and cap or hat|Bring cash for souvenirs and others|Not recommended for pregnant women and people with mobility problems or physical limitations|Children 6 years and younger are not recommended|Weather conditions can impact the activities and overall experience.','08:00:00','14:00:00','2024-02-05 15:52:11','2024-02-05 15:52:11','leona.jpg',6,1),(4,'Genuine Sunset Catamarán',NULL,'Don’t miss the opportunity to discover a paradise that is reachable only by boat! Relax, snorkel & explore caves, visit secluded beaches, and enjoy a breathtaking sunset. Contact us to know more about this adventure!',100,2,NULL,NULL,NULL,NULL,'2024-03-11 15:41:13','2024-03-11 15:41:13','sunset.jpg',6,2),(5,'Fishing Experience',NULL,'Enjoy world class inshore and offshore Costa Rica fishing in one of the world’s most amazing sport fishing destinations. Fishing species such as marlin, sailfish, mahi-mahi, yellowfin tuna, wahoo, roosterfish, red snapper and more. Enjoy our Half Day or Full Day Ocean Experience\r. Contact us to know more about boat preferences and duration.',550,2,NULL,NULL,NULL,NULL,'2024-03-11 16:34:19','2024-03-11 16:34:19','fishing.jpg',6,2);
/*!40000 ALTER TABLE `tours` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-05 10:57:39
