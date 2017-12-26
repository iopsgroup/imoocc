-- MySQL dump 10.11
--
-- Host: 127.0.0.1    Database: imoocc
-- ------------------------------------------------------
-- Server version	5.0.95

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add permission',3,'add_permission'),(8,'Can change permission',3,'change_permission'),(9,'Can delete permission',3,'delete_permission'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add 机柜信息表',7,'add_cabinetinfo'),(20,'Can change 机柜信息表',7,'change_cabinetinfo'),(21,'Can delete 机柜信息表',7,'delete_cabinetinfo'),(22,'Can add 用户登录信息表',8,'add_connectioninfo'),(23,'Can change 用户登录信息表',8,'change_connectioninfo'),(24,'Can delete 用户登录信息表',8,'delete_connectioninfo'),(25,'Can add 扫描后的汇总硬件统计信息',9,'add_statisticsrecord'),(26,'Can change 扫描后的汇总硬件统计信息',9,'change_statisticsrecord'),(27,'Can delete 扫描后的汇总硬件统计信息',9,'delete_statisticsrecord'),(28,'Can add 网络设备用户登录信息',10,'add_netconnectioninfo'),(29,'Can change 网络设备用户登录信息',10,'change_netconnectioninfo'),(30,'Can delete 网络设备用户登录信息',10,'delete_netconnectioninfo'),(31,'Can add 其它设备表',11,'add_othermachineinfo'),(32,'Can change 其它设备表',11,'change_othermachineinfo'),(33,'Can delete 其它设备表',11,'delete_othermachineinfo'),(34,'Can add 物理服务器信息表',12,'add_physicalserverinfo'),(35,'Can change 物理服务器信息表',12,'change_physicalserverinfo'),(36,'Can delete 物理服务器信息表',12,'delete_physicalserverinfo'),(37,'Can add 虚拟设备表',13,'add_virtualserverinfo'),(38,'Can change 虚拟设备表',13,'change_virtualserverinfo'),(39,'Can delete 虚拟设备表',13,'delete_virtualserverinfo'),(40,'Can add 网络设备表',14,'add_networkinfo'),(41,'Can change 网络设备表',14,'change_networkinfo'),(42,'Can delete 网络设备表',14,'delete_networkinfo'),(43,'Can add 注册用户表',15,'add_userinfo'),(44,'Can change 注册用户表',15,'change_userinfo'),(45,'Can delete 注册用户表',15,'delete_userinfo'),(46,'Can add 设备操作记录表',16,'add_machineoperationsinfo'),(47,'Can change 设备操作记录表',16,'change_machineoperationsinfo'),(48,'Can delete 设备操作记录表',16,'delete_machineoperationsinfo'),(49,'Can add 初始化扫描信息表',17,'add_hostloginifo'),(50,'Can change 初始化扫描信息表',17,'change_hostloginifo'),(51,'Can delete 初始化扫描信息表',17,'delete_hostloginifo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
  `password` varchar(128) NOT NULL,
  `last_login` datetime default NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cabinetinfo`
--

DROP TABLE IF EXISTS `cabinetinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cabinetinfo` (
  `id` int(11) NOT NULL auto_increment,
  `cab_name` varchar(10) NOT NULL,
  `cab_lever` varchar(2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cabinetinfo`
--

LOCK TABLES `cabinetinfo` WRITE;
/*!40000 ALTER TABLE `cabinetinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `cabinetinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connectioninfo`
--

DROP TABLE IF EXISTS `connectioninfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `connectioninfo` (
  `id` int(11) NOT NULL auto_increment,
  `ssh_username` varchar(10) default NULL,
  `ssh_userpasswd` varchar(40) default NULL,
  `ssh_hostip` varchar(40) default NULL,
  `ssh_host_port` varchar(10) default NULL,
  `ssh_rsa` varchar(64) NOT NULL,
  `rsa_pass` varchar(64) NOT NULL,
  `ssh_status` int(11) NOT NULL,
  `ssh_type` int(11) NOT NULL,
  `sn_key` varchar(256) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connectioninfo`
--

LOCK TABLES `connectioninfo` WRITE;
/*!40000 ALTER TABLE `connectioninfo` DISABLE KEYS */;
INSERT INTO `connectioninfo` VALUES (1,'root','f996507c288173f7c84587742bca0663','10.16.8.14','9922','','',1,0,'VMware-422e30cf90c1a828-e1ef7067ef1b8985'),(2,'root','263ec4e65d0acf34c378fb778a4d1e15','10.16.6.61','22','','',1,0,'VMware-422e2076c4a0b936-5771455ffd3c24b0'),(3,'root','dc68417a1a506f228968133b60cd4972','10.16.8.224','9922','','',1,0,'CN7R83X'),(4,'root','dce51893afec63201d1a7a7e01d561a7','10.16.8.57','9922','','',1,0,'VMware-564d93d81c849b5d-18d47406a1a2e583'),(5,'root','d1f9015e6b0fadbb4ccb8a2debde8c7a','10.16.8.117','22','','',1,0,'VMware-423b563a81369822-6f67804b9e269900'),(6,'root','ae6481135f1202170ee4d9a3eed59f73','10.16.8.98','9922','','',1,0,'VMware-4203406e70dffd92-828cfe4ac0f369e2'),(7,'root','e9bd6cc5bf5c037c83c285abef87d706','10.16.8.99','9922','','',1,0,'VMware-42035515cf659a9b-3728af4256b74a1d'),(8,'root','3e8910c32011e19735b603522787e412','10.16.6.23','9922','','',1,0,'VMware-422e5388bc83a7e5-f057cd1e9adfe148'),(9,'root','e559616da4fef711e8849654097b2d1f','10.16.8.58','9922','','',1,0,'VMware-422e877e5dfa4c16-448c8f2dc99e5e3f'),(10,'root','e3613ea2e632d6d71af43f586b9942ee','10.16.8.12','22','','',1,0,'VMware-564d7749a37a5ace-90a0d82d67a86e24'),(11,'root','7a59a5118b873eed38f2fa42e7a2d6cf','10.16.6.30','22','','',1,0,'VMware-422e374abbc1456e-2b14251f13c216d5'),(12,'root','770d9cad8ca7125ddc1685b268db3b1b','10.16.8.32','9922','','',1,0,'VMware-422eb1c561c4cae8-1dec74ceba40de7b'),(13,'root','f4443499d08d648a4e3e9ae1d2c60c9e','10.16.8.115','9922','','',1,0,'VMware-422e64d6742be65e-b715b607e9b7afa7'),(14,'root','131537704376867a32a7161e56087cf6','10.16.8.11','9922','','',1,0,'VMware-564d4eaa56de8bf3-d43beeb95ffb1383'),(15,'root','36898fc95ea0ce5a9c94b0524f530d82','10.16.8.18','9922','','',1,0,'VMware-422e01ed4eca9c2a-c40445afdcbf0fc0'),(16,'root','49bb7938306aab088e837bc169bc47d6','10.16.8.212','9922','','',1,0,'2R7R83X'),(17,'root','e5b048c7a278b515cebee30b153e8542','10.16.8.64','9922','','',1,0,'VMware-420361ef69ce15e8-89cbf3d43dd8ab5f'),(18,'root','cae5469c16a12fe4bdfd4d70a098a5e6','10.16.8.248,10.16.8.228','9922','','',1,0,'VMware-4203b7b4251441e3-e981474c9b2d516b'),(19,'root','0283f9f9834b5bb46be979620c77048c','10.16.8.107','22','','',1,0,'002481e1f5f8'),(20,'root','ba29f5c5be6cd6b4fac4d01cd576f5c2','10.16.8.233','9922','','',1,0,'VMware-42035adc8c0bae70-8ecaa357cc771e82'),(21,'root','7e746b30daf5022b1be2821e187f3187','10.16.8.217','9922','','',1,0,'VMware-42031a3caed94b2d-c50f8e31720c5af0'),(22,'root','40077711b04488c3de5e33173d6beede','10.16.8.35','9922','','',1,0,'005056ae5e51'),(23,'root','e23303be52ec5e9901d0e757feed502e','10.16.8.132','9922','','',1,0,'VMware-4203a9acc860e53f-574f2f899197f72a'),(24,'root','c00c8416fa8f9fcf0f5603766de92336','10.16.8.177,10.16.8.214','9922','','',1,0,'VMware-564d93e4770164e4-25401e811e7ee5c8'),(25,'root','90ae03411b57564aa825412a10d69c49','10.16.8.145','22','','',1,0,'VMware-422e49f6ac6e627f-3d05a39458a4745d'),(26,'root','eeeca3b6107e3ba95b1cfa3bdad9fe94','10.16.8.205','9922','','',1,0,'VMware-42035d71db0a59e7-8f7b98fd3d1ed8af'),(27,'root','4c333f7a12157779b9e1096db31da82c','10.16.8.103','22','','',1,0,'4GLP63X'),(28,'root','ec916ef94a55676e28c2437cc87d2c9b','10.16.6.124','9922','','',1,0,'VMware-564d6ff75d23ee78-b8248af73970d026'),(29,'root','b51538d5c998f5f5cc9938441e8ffb0e','10.16.8.209','9922','','',1,0,'VMware-420369be12300559-511c40124a1bc417'),(30,'root','270bf3b50803a1d5935ca5db278ddc41','10.16.8.174','9922','','',1,0,'VMware-564d15614158f955-106d7158ffc1d124'),(31,'root','a9224da15fb5e2eca4a70a7ee99b2870','10.16.8.108','22','','',1,0,'005056461f08'),(32,'root','6c0f8a3617a0ef161e02f68476126101','10.16.8.175','9922','','',1,0,'VMware-564da470d811b63b-9e8891557f382c3e'),(33,'root','cc16ae6d36666eed0d19b95b92080355','10.16.6.42','9922','','',1,0,'VMware-423b48b2c79a82ba-8bb8fe476d5395bc'),(34,'root','dbf33510150d7042efdce738f92ac228','10.16.8.235','9922','','',1,0,'VMware-42032f3b1490ab66-62fdcae2eac91e64'),(35,'root','726299eb3c7ae9288a3cd8d7c78e9c5b','10.16.6.70','9922','','',1,0,'VMware-422e293df092379a-6db00215857d599d'),(36,'root','16f760251de7a9fef435124e9b3e08ff','10.16.8.118','22','','',1,0,'VMware-423ba7606f7071fd-44c6a57be488d9a5'),(37,'root','da7561f5ecb2bffe77820aa143701887','10.16.8.95','9922','','',1,0,'VMware-423b91bb8cfb80e1-b950f48c8605ca66'),(38,'root','f801ff9bcb6da3dd12c8b2c0a58736b6','10.16.8.123','9922','','',1,0,'VMware-564d964e8f8ce104-b37b1d7d28ae47c2'),(39,'root','5691a9f81f40d26377fc2a061170916c','10.16.6.56','9922','','',1,0,'VMware-423b7fd2c1261f5c-7eeafb2837bce9da'),(40,'root','9e0136ca19c46b80677a7a2ec82ae57a','10.16.6.51','9922','','',1,0,'VMware-423be9dc2fb2dea8-8518f3b73f9e594d'),(41,'root','aba96b1ba5fa95f07540728cc27b31b6','10.16.8.199','9922','','',1,0,'VMware-422ef3a84f832654-34593f0680857a13'),(42,'root','9afc9fb786df97840a50c28afbe18903','10.16.8.10','9922','','',1,0,'VMware-564d52f5804cac82-4ae726b80d3bbe1a'),(43,'root','c675a9456c32b4d744f48d8d48bbdf46','10.16.8.104','22','','',1,0,'5GLP63X'),(44,'root','5f8165770422aa0776276783c72a3f6f','10.16.8.17','9922','','',1,0,'VMware-422e180a67aacd72-32261d4d41dbd85a'),(45,'root','f54a03fa96c81e611f96161bb25be45b','10.16.8.119','9922','','',1,0,'VMware-42037e0baff42006-d8f7313d672409b6'),(46,'root','611836b8621e54edbfc6931549571d7e','10.16.8.227','22','','',1,0,'VMware-564d8890bbfaa5dd-96166cc568a9a059'),(47,'root','6cdcd5569f19e9b7000146db8d0ec33d','10.16.8.196','9922','','',1,0,'VMware-422ebb4829f3227a-04fb640d6d2b89dc'),(48,'root','210931689f065fe2432faba5f02a1c5c','10.16.8.130','22','','',1,0,'b82a72d169ba'),(49,'root','04712735f5f40fc86823623687656d72','10.16.6.21','9922','','',1,0,'VMware-422e391dc910658a-6a8aefbe4cd0ca5b'),(50,'root','6a10be981dc78edb3386b605429e1a4d','10.16.6.22','9922','','',1,0,'VMware-422ece4a4f8035e6-2c044dd2c52857e4'),(51,'root','187a2298032a7d0a7fc0887b2df1195a','10.16.8.110','9922','','',1,0,'VMware-42033ed5240a5ab2-05b405e800071c98'),(52,'root','4e4787f3d88a1333479be0a8bc9041e8','10.16.8.70','9922','','',1,0,'VMware-423bda6f56639b6c-3a35ff3cc8430198'),(53,'root','34b4a69bc993701f02e0846699d9e442','10.16.8.16','9922','','',1,0,'VMware-422e67e0adc7361c-c68a3d702bdd272e'),(54,'root','f303a5f6a4db8123260a1124ef5bc0f4','10.16.8.85','9922','','',1,0,'VMware-423bb38ec3b17c0f-d1530b8c06ae68f6'),(55,'root','1cf1a0fa980ac7827efdd8d52b4fd41f','10.16.8.207','9922','','',1,0,'VMware-420343f3e82928a4-827b63ac955b8653'),(56,'root','d9c15ca0e3f57c4f2a0032d2e17d92fc','10.16.6.43','9922','','',1,0,'J154R12'),(57,'root','2da7250f802cf97bad86e5cd166bf6fb','10.16.8.223','9922','','',1,0,'8N7R83X'),(58,'root','91b75b4104f4ff1982a3a329fee0776a','10.16.8.137','9922','','',1,0,'VMware-422ee0b865ebe653-927792038644e161'),(59,'root','b0be3cde7b538a54276033476fe6dc32','10.16.8.106','9922','','',1,0,'VMware-422eb57fccb89c3d-8c1c4949eb2f05d6'),(60,'root','6692484f9581e5fcba3eb269d8e20fe7','10.16.8.178,10.16.8.215','9922','','',1,0,'VMware-564d2b8605a4ac83-0568a322b4849387'),(61,'root','61b02424d5c130ea2f4dbc2ffe6bef08','10.16.8.25','20022','','',1,0,'VMware-422e8a150aa4ce19-c6b632e28d93d696'),(62,'root','a954d64dc6e7a6b2ca0227ab31883f23','10.16.8.144','9922','','',1,0,'VMware-423fcf1fa53456bd-97e0548cf2cd4721'),(63,'root','a16ef8c059efd55f7c79c4a5ced8fcdf','10.16.8.176,10.16.8.213','9922','','',1,0,'VMware-564d19f5c536220e-dd202641e166dfc2'),(64,'root','b1d99f4592eff565f464b4a0c7aa8ff3','10.16.8.63','9922','','',1,0,'VMware-423b12cf25f1c868-bc44ef6e360cac0c'),(65,'root','61a64699bd36740a0b57bf909b482c17','10.16.8.59','9922','','',1,0,'VMware-423bb86549e9be2e-c9e6c035a8b967ef'),(66,'root','8d345acc0ca23f33174e1c9351247029','10.16.6.29','9922','','',1,0,'VMware-422e4c9bbcd19b70-1a27b9e46d44c380'),(67,NULL,'b2c0df91edb359b2e12fbceb7faa41fc','10.17.1.1',NULL,'','',0,0,'FGL1949116Y'),(68,'root','703180def6655e7b2e72840b1afb4bc1','10.16.8.125','9922','','',1,0,'5254003ee8df'),(69,'root','0284dcf525613617cacd0abc19b7dafd','10.16.8.198','9922','','',1,0,'VMware-4203e8dbc356a5af-a700cbb60504f4c0'),(70,'root','2f42a8c31d822583b7c68918bb7fbd70','10.16.8.195','9922','','',1,0,'VMware-423fb31969002f7d-76ea48c4abfde16a'),(71,'root','f7038a728c6f42e3b005cfa9cf520c3a','10.16.8.120','22','','',1,0,'VMware-423b98328c8881d4-da0c46c0b1c6c8e9'),(72,'root','63b45051258c7ef4f7da64c2c487dc9a','10.16.8.116','9922','','',1,0,'005056ae70a1'),(73,'root','9f77823c5a8f50aac01a2aff550959f5','10.16.8.24','9922','','',1,0,'VMware-422e95b36e180ad9-617a19332bf446b3'),(74,'root','678dcca4920536b776358ccd1b9c3731','10.16.8.134','22','','',1,0,'f8bc1246dc14'),(75,'root','1f5539455ee1f2ea878dd60f401037b9','10.16.8.81','9922','','',1,0,'VMware-423b80ce410d0547-42317d76dd9a9314'),(76,'root','ea131386b680ef34f635a48377ebd3fa','10.16.8.15','9922','','',1,0,'VMware-422e86f91deb5a02-3fbe5484c33d4725'),(77,'root','7848aa9e0fbf47625d58cf5495a18de5','10.16.8.128','9922','','',1,0,'VMware-4203a057e60962e3-aff3264f9d512ff0'),(78,'root','863532eab37a9e03981570b7864adb7e','10.16.8.124','9922','','',1,0,'VMware-564de93068013b35-4886473a8f672e6d'),(79,'root','2795af0d55352c11b72485c0ff6dc373','10.16.6.24','9922','','',1,0,'VMware-422ebae74f83596b-eb66dfbc17d49be9'),(80,'root','8c80105f876c31e1d82652b4e4cc256d','10.16.8.131,10.16.6.44','22','','',1,0,'549f350168f0'),(81,'root','204f1e49d1e3a28ee734fce0d121b927','10.16.8.79','9922','','',1,0,'VMware-423bc84d2995588e-fecd9b5c6f2821c3'),(82,'root','c8d4cc5f1ede959778826a2de3462f4c','10.16.6.31','9922','','',1,0,'VMware-422eeaff7c6d00be-d3af5503eb71a41a'),(83,'root','3c7f8632c49192cec8e054d5c5e0352c','10.16.8.84','9922','','',1,0,'VMware-423bd21f7e8110aa-fabd46784eb3f86b'),(84,'root','bdc78e500b315a41f9af44ffa8918f1b','10.16.8.47,10.16.8.61','9922','','',1,0,'VMware-423b1fc0c52b74af-d1a6f48903948dcf'),(85,'root','0944e5c0ec36120beb6a8790b1d9d100','10.16.6.54','9922','','',1,0,'VMware-423b59762e80072c-d61b56bbb9eed573'),(86,'root','1140756b14e64949dc18a261871db066','10.16.8.129','9922','','',1,0,'VMware-420353df218dbca8-16dd30c51ce022cc'),(87,'root','d873ca11d8997b4ca14a0cff4bcb6cd6','10.16.6.25','9922','','',1,0,'VMware-422ea601abf9c844-c224418be55ad9b8'),(88,'root','e35bbecfbd20bfc835976f394eab6947','10.16.8.33','9922','','',1,0,'VMware-422e299d98c7e298-2f2e6c38d4702551'),(89,NULL,'ec2079a65f3ade7903b14ebf1604ad36','10.17.1.2',NULL,'','',0,0,'FDO1533P1WN'),(90,'root','cca4c6dfd5a2316b46c161e5e0c31869','10.16.8.122','20022','','',1,0,'005056832d39'),(91,'root','1999226dd1dc8d80789143987ebe4cc7','10.16.8.109','9922','','',1,0,'VMware-422e1b7ecbd4521a-7efd748abd3bb5ce'),(92,'root','6f77a51d656d3f75066db33a2ee8eed6','10.16.8.211','9922','','',1,0,'VMware-4203c1a2cbed1f9d-d6c323e37d0d9809'),(93,'root','3e18e8ecbb45d8b3b87eec12f4fc9815','10.16.8.237','9922','','',1,0,'VMware-423b91afc13282a6-1f984eb55c8ad3e6'),(94,'root','2dcfcb65818b2881a7962aa91629f3f5','10.16.8.127','9922','','',1,0,'VMware-42034a1d24097e4d-10f36f5f4a858300'),(95,'root','1a43e081b88d6dd69e9c53c8edffd05b','10.16.8.244,10.16.8.226,10.16.8.22','9922','','',1,0,'VMware-4203395da0284be1-8b06f432f4f3b5d7'),(96,'root','11c65d58fe3b70281eeaf1ffcc82ff28','10.16.8.13','22','','',1,0,'VMware-422ee9da59339155-e88fcc913e9ac91d'),(97,'root','bcae4edba86d6ba097c2e14743d3678e','10.16.6.11','9922','','',1,0,'VMware-422ef709de67df68-50ab12e90d41c2e7'),(98,'root','53e74ec4f9a487fc9c7318a6e5052779','10.16.8.138','9922','','',1,0,'525400cd4105'),(99,'root','4f0cfee04e35bf9112b8522a295a3c65','10.16.6.49','9922','','',1,0,'VMware-423bc2d29918eb2a-acdffc753a40b740'),(100,'root','af08a814346a1d42e2a9081e691e36c9','10.16.8.76','9922','','',1,0,'VMware-423b5036f51e4a04-1e5794e9afc38fa2'),(101,'root','a2727a0cd7c7dce75c3d224dd24c8bb5','10.16.8.247','22','','',1,0,'VMware-422e01aab8dc82fd-86001dc2a08ef87a'),(102,'root','7a6ab277a85464eb2ebb73e319477d41','10.16.8.212','10004','','',1,4,'7a8a783d456cdocker.imoocc.net/phpdaemon'),(103,'root','a14a74a6ba6197e2ca0a91fe8d127d25','10.16.8.212','10004','','',1,4,'778da6a023b7docker.imoocc.net/webenv'),(104,'root','e7d8269b371c694d4e1a7740b238a63f','10.16.8.212','10004','','',1,4,'3302c4312652docker.imoocc.net/webenv'),(105,'root','3b7fdc34109f9b888d59034eddd78a21','10.16.8.212','10004','','',1,4,'16c06291d6b0docker.imoocc.net/webenv'),(106,'root','dd77bd8e1a59c9c4b7cd89ca7dc9a333','10.16.8.212','10004','','',1,4,'8057a6fc5479docker.imoocc.net/phpdaemon'),(107,'root','fd4eb6eb9a24db145f5a1d7ccdc4e835','10.16.8.212','10004','','',1,4,'5bf99756ac3adocker.imoocc.net/phpdaemon'),(108,'root','c9afdc1dcc1cba5ad86049789652f8d0','10.16.8.212','10004','','',1,4,'c2ac6d1d5ba4docker.imoocc.net/phpdaemon'),(109,'root','2e31a0fc5824437bb1ac9479f898cc30','10.16.8.212','10004','','',1,4,'d3eb2cd13ca4docker.imoocc.net/phpdaemon'),(110,'root','e4e2be9b64659224ad5e49ee2715b499','10.16.8.212','10004','','',1,4,'248dbc0fb40edocker.imoocc.net/phpdaemon'),(111,'root','93c34854d5592b983e7235b8571ee990','10.16.8.212','10004','','',1,4,'232de6a6580edocker.imoocc.net/phpdaemon'),(112,'root','9ef817bae976362132876b975408f911','10.16.8.212','10004','','',1,4,'8de6f9a4e11e5af44d361bf4'),(113,'root','28ef7dfc8b9eaecb5fa92618a11fe919','10.16.8.212','10004','','',1,4,'e7a3bf8e3e69docker.imoocc.net/webenv'),(114,'root','b1998704393270bb1e577d13b12070f7','10.16.8.212','10004','','',1,4,'f973dccdb019docker.imoocc.net/webenv'),(115,'root','70650a15a94ea903f754a930b6b37bf1','10.16.8.212','10004','','',1,4,'e6fa31eecf4edocker.imoocc.net/webenv'),(116,'root','18f7713138a6b66090ce5e8aeaa6f965','10.16.8.212','10004','','',1,4,'2488c2464b5cdocker.imoocc.net/phpdaemon'),(117,'root','0f845d753cc6856f1ac44e883625ca25','10.16.8.212','10004','','',1,4,'cfea85e82f81docker.imoocc.net/webenv'),(118,'root','49a2088395614ba8dbd43df4432d8d69','10.16.8.212','10004','','',1,4,'025ec2b3a66adocker.imoocc.net/webenv'),(119,'root','b3b81cc53efaf6e3d2d807d38ed96dad','10.16.8.212','10004','','',1,4,'8ddf4db66012docker.imoocc.net/webenv'),(120,'root','71f07aa39d71b5419ba22f4178eaccef','10.16.8.212','10004','','',1,4,'98b3fd2b7e36docker.imoocc.net/webenv'),(121,'root','f9d37bab8847a73682ae10b07ee7a42b','10.16.8.212','10004','','',1,4,'06b1e006b0d2docker.imoocc.net/mariadb-galera'),(122,'root','325388832399a2d16ba483a354d70621','10.16.8.224','10067','','',1,4,'81d1afccf13ddocker.imoocc.net/webenv'),(123,'root','901d1747125e240765182850a130e604','10.16.8.224','10067','','',1,4,'8c1857265528docker.imoocc.net/webenv'),(124,'root','b016f71c91c7bc322d5ac45a0ae13910','10.16.8.224','10067','','',1,4,'894d03116ea3docker.imoocc.net/mongodb'),(125,'root','16f7e9048453bddd2ece530a8d515a5f','10.16.8.224','10067','','',1,4,'39a7a07404a8docker.imoocc.net/webenv'),(126,'root','a136fae77e1dbf7c158fd08b456ed258','10.16.8.224','10067','','',1,4,'9a8e12de65b8docker.imoocc.net/webenv'),(127,'root','afcef3b9fccb34f0fd8e404fff093549','10.16.8.224','10067','','',1,4,'113ed0fbc1a2docker.imoocc.net/webenv'),(128,'root','742224e16bb4011ef2ded32db6e2739a','10.16.8.224','10067','','',1,4,'ba1ec5e79093docker.imoocc.net/webenv'),(129,'root','1bdca078df8c2f4e697fbdf9f64691f0','10.16.8.224','10067','','',1,4,'391ee60de44fdocker.imoocc.net/phpdaemon'),(130,'root','3f1ad47cc8e007625d692d1c3fff9d2a','10.16.8.224','10067','','',1,4,'703525ea98dddocker.imoocc.net/webenv'),(131,'root','fdae420b9d1381f3577f93c549c7fa20','10.16.8.224','10067','','',1,4,'5db584144baadocker.imoocc.net/mariadb-galera'),(132,'root','7e76f08f21e8b299fe9675ec0b115b2c','10.16.8.224','10067','','',1,4,'62aaddeba21edocker.imoocc.net/phpdaemon'),(133,'root','d74e98926f39a4449c7b7cea38193a4d','10.16.8.224','10067','','',1,4,'7a0643078a05docker.imoocc.net/phpdaemon'),(134,'root','559a0293fcf3fa2898453919f538f2f3','10.16.8.224','10067','','',1,4,'9a8c2ff0b5fadocker.imoocc.net/webenv'),(135,'root','baeef098baa86ef16279f4aa5ec60c6e','10.16.8.224','10067','','',1,4,'71111ecab8e8docker.imoocc.net/webenv'),(136,'root','669c3bb7543a6278342a580a1a04abf9','10.16.8.224','10067','','',1,4,'f0839168cd89docker.imoocc.net/webenv'),(137,'root','124cbb115cf0ea0eeb92b6aabfafe749','10.16.8.224','10067','','',1,4,'770d90e023c5docker.imoocc.net/webenv'),(138,'root','4ed010d772793034f57b838fc9738df1','10.16.8.224','10067','','',1,4,'09a8974196b3docker.imoocc.net/webenv'),(139,'root','ee397876c8dc41da4775def37371babb','10.16.8.224','10067','','',1,4,'2f729d50dc56docker.imoocc.net/webenv'),(140,'root','ef845407e58c08fb6e34ea3b4e7ab68b','10.16.8.224','10067','','',1,4,'af93e791d05edocker.imoocc.net/webenv'),(141,'root','51f2b0a49f6679883fa3ee77e6426066','10.16.8.224','10067','','',1,4,'72c26661761ddocker.imoocc.net/phpdaemon'),(142,'root','e458ad090a067337c6750376c1f973dc','10.16.8.224','10067','','',1,4,'0b62f3382e70docker.imoocc.net/webenv'),(143,'root','17237aa4fa3b2bb19e8dad3cc5cb37d7','10.16.8.224','10067','','',1,4,'3758e95c42a9docker.imoocc.net/webenv'),(144,'root','860368e05800c80a0c78f17048d5d426','10.16.8.224','10067','','',1,4,'c7539cc083d8docker.imoocc.net/webenv'),(145,'root','2f83f93aab5145a2ad3ae12a21b9bc76','10.16.8.224','10067','','',1,4,'94a1648d7718docker.imoocc.net/phpdaemon'),(146,'root','9fe663314054171ec4c45225e463bc52','10.16.8.224','10067','','',1,4,'5e4aa945d9fedocker.imoocc.net/webenv'),(147,'root','3f4bba09308c5560479cc831f37dcf5a','10.16.8.224','10067','','',1,4,'b5b1ca405580docker.imoocc.net/mariadb-galera'),(148,'root','9315babb911833ed76bbcf3debe973da','10.16.8.224','10067','','',1,4,'a0463313008bdocker.imoocc.net/phpdaemon'),(149,'root','00040bc3476623584df672040b6a7bf1','10.16.8.224','10067','','',1,4,'6037c0db38e4docker.imoocc.net/phpdaemon'),(150,'root','12f8301f42442139390dc429994a9ab7','10.16.8.224','10067','','',1,4,'9d82bb8236ccdocker.imoocc.net/phpdaemon'),(151,'root','9573d13c9b26f09d913d72c334b71b60','10.16.8.224','10067','','',1,4,'1771f675d6b8docker.imoocc.net/webenv'),(152,'root','18e012943aeed16d31ec6d1760ad75ab','10.16.8.224','10067','','',1,4,'b5b8f9f8152fdocker.imoocc.net/webenv'),(153,'root','b5650f09e4e795dcb61ac5393ea195ea','10.16.8.223','10060','','',1,4,'e918393ae992docker.imoocc.net/phpdaemon'),(154,'root','68ba650ca17a93d181a67410f9f6daf6','10.16.8.223','10060','','',1,4,'5717d202f3e0docker.imoocc.net/phpdaemon'),(155,'root','a9996263b747808fd2156d40fa676790','10.16.8.223','10060','','',1,4,'420a8bacd8f85af44d361bf4'),(156,'root','fb639ac26926698415da91ef740aa756','10.16.8.223','10060','','',1,4,'7b555e843db7docker.imoocc.net/phpdaemon'),(157,'root','f3e6f8d7beedc150eb207da082105e31','10.16.8.223','10060','','',1,4,'9873ed835a2edocker.imoocc.net/phpdaemon'),(158,'root','5cd31f6eaa126b99f01133c6c517795f','10.16.8.223','10060','','',1,4,'36afb341626cdocker.imoocc.net/webenv'),(159,'root','95eb6ea26c3ad62207b67db2c1aa44bf','10.16.8.223','10060','','',1,4,'926da9efbe11docker.imoocc.net/phpdaemon'),(160,'root','7b42d9f6038bff59877fb28438f9e431','10.16.8.223','10060','','',1,4,'da0dcf1b6014docker.imoocc.net/mongodb'),(161,'root','33b159149a856499efdafc5abcaa477e','10.16.8.223','10060','','',1,4,'6a118ea5a6c6docker.imoocc.net/webenv'),(162,'root','f77774440799e6907dfc7a41d7d88c0a','10.16.8.223','10060','','',1,4,'23faf89a058cdocker.imoocc.net/phpdaemon'),(163,'root','5fae4938472adf6f3c78c90d87559230','10.16.8.223','10060','','',1,4,'217b808f19f3docker.imoocc.net/webenv'),(164,'root','4eeb89e3170a72384f8f172d399931b5','10.16.8.223','10060','','',1,4,'0f050661b4efdocker.imoocc.net/mariadb-galera'),(165,'root','8d53576d532bf7be1880050e86a9a7ff','10.16.8.223','10060','','',1,4,'0411ae6f4127docker.imoocc.net/webenv'),(166,'root','17b15a7c72f560e24bdb6603c1b4a120','10.16.8.223','10060','','',1,4,'e2ecf7dcdb50docker.imoocc.net/webenv'),(167,'root','9434ed9582861c2b178ad137e261af11','10.16.8.223','10060','','',1,4,'fa925ae99080docker.imoocc.net/webenv'),(168,'root','155ad1ebea982a63961188db0c6e33af','10.16.8.223','10060','','',1,4,'7096e2a8393fdocker.imoocc.net/phpdaemon'),(169,'root','881fe53946c0177cf705370392ab61e2','10.16.8.223','10060','','',1,4,'c4418d9bb6cbdocker.imoocc.net/webenv'),(170,'root','2fbccfeee729dfdbd938bf7b8ba26edd','10.16.8.223','10060','','',1,4,'01ce30f1c2a7docker.imoocc.net/phpdaemon'),(171,'root','bb18c3aa438e7c6e3dcf362086485c17','10.16.8.223','10060','','',1,4,'3f03ee0a9201docker.imoocc.net/mariadb-galera'),(172,'root','112504830c5b47a54ee15b4bc7ba6361','10.16.8.223','10060','','',1,4,'8bced4b15174docker.imoocc.net/mariadb-galera'),(173,'root','0ea33bd22fd73497e5261f717f8e5fc3','10.16.8.223','10060','','',1,4,'8cf37371f76ddocker.imoocc.net/webenv'),(174,'root','d7ff0313735916035fc5840800b9878d','10.16.8.223','10060','','',1,4,'5ad32f9a726c5af44d361bf4'),(175,'root','91907ace2aa3721763f224a51aa14f24','10.16.8.223','10060','','',1,4,'7797b79be23adocker.imoocc.net/mariadb-galera'),(176,'root','22da400640def1207796836f4325cba2','10.16.8.223','10060','','',1,4,'35a73b1d7520docker.imoocc.net/mariadb-galera'),(177,'root','8c563f7ab423fc9e266577ae9965ba49','10.16.8.223','10060','','',1,4,'bb1df5c1d41edocker.imoocc.net/webenv'),(178,'root','efb8e52579f64c77a1f1d7d9645ad963','10.16.8.223','10060','','',1,4,'970c6b2350f3docker.imoocc.net/mariadb-galera'),(179,'root','2e392eeda97d39fe911c45133d5a1fcd','10.16.8.223','10060','','',1,4,'cf1180a6b86cdocker.imoocc.net/webenv'),(180,'root','c7408b4f4e151a6a86fff6275005bf6b','10.16.8.223','10060','','',1,4,'0c1841523819docker.imoocc.net/webenv'),(181,'root','6acae7565e0b6cab8ae0dff38c562e49','10.16.8.223','10060','','',1,4,'c39c1e1f6a77docker.imoocc.net/phpdaemon'),(182,'root','9d5328d01070e6fe774be6ceb5d69da9','10.16.8.223','10060','','',1,4,'f08ee9c6416fdocker.imoocc.net/phpdaemon'),(183,'root','c62785463543d5823e7d1e37a00e12ee','10.16.8.223','10060','','',1,4,'a9fbfead8d47docker.imoocc.net/mariadb-galera'),(184,'root','9e1e7b109694dbe0a26e0f9a04349ef4','10.16.8.223','10060','','',1,4,'41ccd219e1dedocker.imoocc.net/mariadb-galera'),(185,'root','90e1e1463c81cb7f22722eb564839639','10.16.8.223','10060','','',1,4,'6105dd4a8fb3docker.imoocc.net/mariadb-galera'),(186,'root','dda761d517cc7ce2aec697c5ae5e848b','10.16.8.223','10060','','',1,4,'0ee6dfa166b9docker.imoocc.net/phpdaemon'),(187,'root','8896d9d21fad3a110a7b2afe1c58b25c','10.16.8.223','10060','','',1,4,'87bf8ffa5727docker.imoocc.net/mariadb-galera'),(188,'root','8cd4ac5e8571f77451ed4963d70b85d9','10.16.8.223','10060','','',1,4,'b4384e36b0185af44d361bf4'),(189,'root','77753c74bccca7395ed2c0c8ad056eb4','10.16.8.223','10060','','',1,4,'ffe24b3e7fefdocker.imoocc.net/phpdaemon'),(190,'root','ab76fcc1954a12c61f3f239cd5b81541','10.16.8.223','10060','','',1,4,'9550e94003c1docker.imoocc.net/webenv'),(191,'root','80d50eff8f26f0bec95bde4a1d654d31','10.16.8.223','10060','','',1,4,'bc2b4623d356docker.imoocc.net/phpdaemon'),(192,'root','2368619b7decffe2ba1dd8197f0c7095','10.16.8.223','10060','','',1,4,'0a73510d6b8adocker.imoocc.net/webenv'),(193,'root','b4e8c3050f7dd3498d64b01e040f9f96','10.16.8.223','10060','','',1,4,'8b350a7865a15af44d361bf4'),(194,'root','2942d86a05201de2563d6e0788793c28','10.16.8.223','10060','','',1,4,'80bef5da040c5af44d361bf4'),(195,'root','506c34eabeb1e2ce9b53e7c45f63cd64','10.16.8.223','10060','','',1,4,'efbeaad70fd0docker.imoocc.net/webenv'),(196,'root','50d73efa0023ab2cfb320ba1373c99b7','10.16.8.223','10060','','',1,4,'b120d81054ecdocker.imoocc.net/mariadb-galera'),(197,'root','6425f0ca760df82b216c8756a7396cb0','10.16.8.223','10060','','',1,4,'b2014244968adocker.imoocc.net/mariadb-galera'),(198,'root','e0050d49096144dbb8205bbd54eb32b6','10.16.8.223','10060','','',1,4,'2231d37fb743docker.imoocc.net/phpdaemon'),(199,'root','ace2c61e74c2404dd6a0d3c753513ba5','10.16.8.223','10060','','',1,4,'b957ce1b2b135af44d361bf4'),(200,'root','f6cc4448a0519860f56c6af7ef6a8cd4','10.16.8.223','10060','','',1,4,'c6d4cfe4739a5af44d361bf4'),(201,'root','3ec349bfa47231625c8f7556326df32a','10.16.8.223','10060','','',1,4,'e5574e24d80fdocker.imoocc.net/webenv'),(202,'root','29219f1c0cafb39a26569b693e0e117f','10.16.8.223','10060','','',1,4,'f330779435dfdocker.imoocc.net/mariadb-galera'),(203,'root','304e53dd8f0db28f12fe8160c88e98b3','10.16.8.223','10060','','',1,4,'52d49e3044d2docker.imoocc.net/mariadb-galera'),(204,'root','b748349d75ea1559193bddb38b70de7b','10.16.8.223','10060','','',1,4,'1fa6e364c06fdocker.imoocc.net/phpdaemon'),(205,'root','02f69febdf11184adf23901e93289035','10.16.8.223','10060','','',1,4,'80826f5ac8c5docker.imoocc.net/mariadb-galera'),(206,'root','2d9940556df5d48aff220fb51124e90d','10.16.8.223','10060','','',1,4,'669e5bbd5196docker.imoocc.net/mariadb-galera'),(207,'root','9b7c771f42f6ab9b9d698226895f4a1b','10.16.8.223','10060','','',1,4,'b3a135ac783bdocker.imoocc.net/phpdaemon'),(208,'root','6c9460eb9f829b58b4f3735a2e123b82','10.16.8.223','10060','','',1,4,'0f7d4184e594docker.imoocc.net/mariadb-galera'),(209,'root','b648a560db16a4515bc801a72925c590','10.16.8.223','10060','','',1,4,'c59b2a24b3abdocker.imoocc.net/mariadb-galera'),(210,'root','e06348f714e1c4943d508301353002b5','10.16.8.223','10060','','',1,4,'53bb6489f25adocker.imoocc.net/webenv'),(211,'root','75f6b289459defd08ad7c97f92327491','10.16.8.223','10060','','',1,4,'b4fcdb5313b0docker.imoocc.net/webenv'),(212,'root','831e23e23a14cfec3b62089720026b64','10.16.8.223','10060','','',1,4,'0f1031ae9cc3docker.imoocc.net/phpdaemon'),(213,'root','16679935df8a3516d540bab9528fc589','10.16.8.223','10060','','',1,4,'bdc25c4933105af44d361bf4'),(214,'root','815c0daf797e9c3f9e924c4579e0642c','10.16.8.223','10060','','',1,4,'b4bc05d3783ddocker.imoocc.net/mongodb'),(215,'root','940b99401d62f864e5075cc2aa1bc6ba','10.16.8.223','10060','','',1,4,'d4daf84258a25af44d361bf4'),(216,'root','3daebfc57c1f82391d9ec83920cad5cb','10.16.8.223','10060','','',1,4,'88b3af647cfddocker.imoocc.net/phpdaemon'),(217,'root','6a84cf216d1a1d55c8b93c975918bc5e','10.16.8.223','10060','','',1,4,'afb9bf194735docker.imoocc.net/mariadb-galera'),(218,'root','e9ef7e8193343a9dfff9795549230e86','10.16.8.223','10060','','',1,4,'ec35bc203c9cdocker.imoocc.net/mongodb'),(219,'root','ee55dd5d93838697542e992e6ff0334f','10.16.8.223','10060','','',1,4,'3ec18e29fde8docker.imoocc.net/mariadb-galera'),(220,'root','a8363d01ee0b43a41ed645f353b52d62','10.16.8.223','10060','','',1,4,'c78fa1b995b35af44d361bf4'),(221,'root','1c3500a128942f7a200b079c880199ca','10.16.8.223','10060','','',1,4,'e248ceb44db4docker.imoocc.net/phpdaemon'),(222,'root','47b9b3a36020533893be32e597d67253','10.16.8.223','10060','','',1,4,'b0e1e04f3c715af44d361bf4'),(223,'root','8ab3ea7ada2f697191ed38a1014560a7','10.16.8.223','10060','','',1,4,'27c63dc40001docker.imoocc.net/mariadb-galera'),(224,'root','b4ab3ed5fc70e6988fa30ac1fc971f76','10.16.8.223','10060','','',1,4,'76533ce61e2cdocker.imoocc.net/webenv'),(225,'root','68d6d6b79433f89abda6a2e1784a733e','10.16.8.223','10060','','',1,4,'db6599b55befdocker.imoocc.net/webenv'),(226,'root','4ca32a4bb1022a7653ca3dadd146cdbc','10.16.8.223','10060','','',1,4,'9154d0c206bcdocker.imoocc.net/webenv'),(227,'root','41858f5a21736916d5e799486463a9ee','10.16.8.223','10060','','',1,4,'a2428c074b5cdocker.imoocc.net/phpdaemon'),(228,'root','9d70c9e049a3e80a204e65f2f0879c2b','10.16.8.223','10060','','',1,4,'fd47ef96ce60docker.imoocc.net/mariadb-galera'),(229,'root','ba7e3522eb1efc50925b41ce076badd3','10.16.8.223','10060','','',1,4,'de9fb2bbb207docker.imoocc.net/jdk1.7'),(230,'root','3752d5d39086c951c87661457893dcea','10.16.8.223','10060','','',1,4,'568d99fd1532docker.imoocc.net/phpdaemon'),(231,'root','7bdec6a00a4c1758ae4d041f4efba4d7','10.16.8.223','10060','','',1,4,'9330251b96e5docker.imoocc.net/mariadb-galera'),(232,'root','58bb8091ba0cf134bc6e5d24faa3c58f','10.16.8.223','10060','','',1,4,'462f48465cc3docker.imoocc.net/mariadb-galera'),(233,'root','8c1353b9113a7a504f23ce0dbb62ee2c','10.16.8.223','10060','','',1,4,'7f3f8975280e5af44d361bf4'),(234,'root','c35c3003320f90fbbbe2943fdf0d6594','10.16.8.223','10060','','',1,4,'3e330ae9aa635af44d361bf4'),(235,'root','52020dc6502bce5e2abd4cb618be6d46','10.16.8.223','10060','','',1,4,'939aeeeaefc1docker.imoocc.net/phpdaemon'),(236,'root','8390988cbf65ce30d2054af88b442ab1','10.16.8.223','10060','','',1,4,'e65a410777685af44d361bf4'),(237,'root','8167e9d3a35405f9d84e5bfe2acf97cc','10.16.8.223','10060','','',1,4,'8966695d5894docker.imoocc.net/phpdaemon'),(238,'root','c3ccdfbfd08f03f3e444a930061ffa90','10.16.8.223','10060','','',1,4,'fa6dc63ddee15af44d361bf4'),(239,'root','f84eb4cad28686e2e5eedcbd44c86012','10.16.8.223','10060','','',1,4,'1099f06a4763docker.imoocc.net/phpdaemon'),(240,'root','d55c82a64fbad180261980bd58359161','10.16.8.223','10060','','',1,4,'69a769bc979adocker.imoocc.net/phpdaemon'),(241,'root','58eff13b09dd34aa0f2dd0f426caaf07','10.16.8.223','10060','','',1,4,'5771e424a3b4docker.imoocc.net/jdk1.7'),(242,'root','c86ccddc5a815443b5545594b8c35a89','10.16.8.223','10060','','',1,4,'f3174e57024edocker.imoocc.net/mariadb-galera'),(243,'root','abe859679565e1d1f0a2b852df7556d0','10.16.8.223','10060','','',1,4,'3fb89be7c0eadocker.imoocc.net/phpdaemon'),(244,'root','9790973176ab9fc8db8753e11e047cb1','10.16.8.223','10060','','',1,4,'30f67cc388d1docker.imoocc.net/phpdaemon'),(245,'root','385f1b782012f520ac74b9830db3a595','10.16.8.223','10060','','',1,4,'2d3872b44845docker.imoocc.net/phpdaemon'),(246,'root','ede38418c0e0853450f8001bca410dae','10.16.8.223','10060','','',1,4,'34380dbfa02ddocker.imoocc.net/mariadb-galera'),(247,'root','556bfb5f19063877725ed15dca36eb7b','10.16.8.223','10060','','',1,4,'fd991b3aa63b5af44d361bf4'),(248,'root','1f83bb453a5e9e6fbb18adcb61d5d111','10.16.8.223','10060','','',1,4,'4c2399c8fa8cdocker.imoocc.net/mariadb-galera'),(249,'root','eaa1ac0c08a6ba60aebc2dcddfc5964c','10.16.8.223','10060','','',1,4,'70b6924a646adocker.imoocc.net/phpdaemon'),(250,'root','b3db5a536dd4655805215352381403e9','10.16.8.223','10060','','',1,4,'0a24e27bbaf4docker.imoocc.net/phpdaemon'),(251,'root','5887aeedb2a9613182c5091878894990','10.16.8.223','10060','','',1,4,'95b60129362bdocker.imoocc.net/phpdaemon'),(252,'root','13273b5284e2883baf48b92f55638527','10.16.8.223','10060','','',1,4,'a1ff4f46de0cdocker.imoocc.net/mariadb-galera'),(253,'root','572111b534f0d4006c4282bf6addd955','10.16.8.223','10060','','',1,4,'b0335838dd0bdocker.imoocc.net/mariadb-galera'),(254,'root','8ceaa54b65200e1163aaa24dcf6feb5a','10.16.8.223','10060','','',1,4,'d268c47a8702docker.imoocc.net/phpdaemon'),(255,'root','825b4f988b87f8135398fdd9ddf6f92d','10.16.8.223','10060','','',1,4,'59b1cfa8e482docker.imoocc.net/mongodb'),(256,'root','d7ea4b1ad9c87a848b17e7589f2dbe2a','10.16.8.223','10060','','',1,4,'cc2cc3e2c79fdocker.imoocc.net/php-nginx');
/*!40000 ALTER TABLE `connectioninfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'detail','cabinetinfo'),(8,'detail','connectioninfo'),(10,'detail','netconnectioninfo'),(14,'detail','networkinfo'),(11,'detail','othermachineinfo'),(12,'detail','physicalserverinfo'),(9,'detail','statisticsrecord'),(13,'detail','virtualserverinfo'),(16,'operations','machineoperationsinfo'),(17,'scanhosts','hostloginifo'),(6,'sessions','session'),(15,'users','userinfo');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL auto_increment,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-11-01 08:59:54'),(2,'auth','0001_initial','2017-11-01 08:59:58'),(3,'admin','0001_initial','2017-11-01 08:59:59'),(4,'admin','0002_logentry_remove_auto_add','2017-11-01 08:59:59'),(5,'contenttypes','0002_remove_content_type_name','2017-11-01 09:00:00'),(6,'auth','0002_alter_permission_name_max_length','2017-11-01 09:00:01'),(7,'auth','0003_alter_user_email_max_length','2017-11-01 09:00:01'),(8,'auth','0004_alter_user_username_opts','2017-11-01 09:00:01'),(9,'auth','0005_alter_user_last_login_null','2017-11-01 09:00:02'),(10,'auth','0006_require_contenttypes_0002','2017-11-01 09:00:02'),(11,'auth','0007_alter_validators_add_error_messages','2017-11-01 09:00:02'),(12,'auth','0008_alter_user_username_max_length','2017-11-01 09:00:02'),(13,'detail','0001_initial','2017-11-01 09:00:06'),(14,'detail','0002_auto_20171101_0858','2017-11-01 09:00:06'),(15,'operations','0001_initial','2017-11-01 09:00:06'),(16,'scanhosts','0001_initial','2017-11-01 09:00:07'),(17,'sessions','0001_initial','2017-11-01 09:00:07'),(18,'users','0001_initial','2017-11-01 09:00:08');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0mbujo90s27jowz5a024d1eai7gh6czx','ZTFlMTk5ZTNiZDhiZjJmYzk2MGM3ODM2MDhiZGQwMmM4MjhjMTllNTp7InBhdGgiOiIvIn0=','2017-11-27 21:00:23'),('6q8fuwrbl7tgfl0849ajyz5xe8e6f4pr','ZDk4MmIxNDUyOGRlZTk0MzdmMDkwYzBlMDA1ODViYWE2NmUxOGFiZTp7InVzZXJfbGV2ZWwiOiIyIiwidXNlcl9uYW1lIjoiYWRtaW4iLCJ1aWQiOjEsInBhdGgiOiIvIn0=','2017-11-26 11:08:28'),('pxt4eld5sf18k05iayfle604la17a1hn','ZTFlMTk5ZTNiZDhiZjJmYzk2MGM3ODM2MDhiZGQwMmM4MjhjMTllNTp7InBhdGgiOiIvIn0=','2017-11-25 16:10:23'),('tzn5s6lf3lwmdbscy30c7s4x9iv28sda','ZjgwOGZmYjlmZjViNjc0Y2NjYWI3NzNiOWU5ZTdhYTdkMzBhODY1NTp7InBhdGgiOiIvIiwidXNlcl9sZXZlbCI6IjIiLCJ1aWQiOjEsInVzZXJfbmFtZSI6ImFkbWluIn0=','2017-11-27 13:16:13'),('uvda0p4fh3kjkhlfqfbo7v8qu2up6i3g','ZTA0NmZjNGFkYTViNjQxY2MxODc1MTExOTBhODVjOTZlNjhkOGE2OTp7InBhdGgiOiIvZGV0YWlsX24vP2RJRD0yNiIsInVzZXJfbGV2ZWwiOiIyIiwidWlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiJ9','2017-12-03 13:01:47');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostloginifo`
--

DROP TABLE IF EXISTS `hostloginifo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostloginifo` (
  `id` int(11) NOT NULL auto_increment,
  `ip` varchar(64) NOT NULL,
  `ssh_port` varchar(32) default NULL,
  `ssh_user` varchar(32) default NULL,
  `ssh_passwd` varchar(64) default NULL,
  `ssh_rsa` varchar(64) default NULL,
  `rsa_pass` varchar(64) default NULL,
  `system_ver` varchar(256) default NULL,
  `hostname` varchar(256) default NULL,
  `ssh_status` int(11) NOT NULL,
  `ssh_type` int(11) NOT NULL,
  `mac_address` varchar(512) NOT NULL,
  `sn` varchar(256) NOT NULL,
  `mathine_type` varchar(256) NOT NULL,
  `sn_key` varchar(256) NOT NULL,
  `host_type` varchar(256) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostloginifo`
--

LOCK TABLES `hostloginifo` WRITE;
/*!40000 ALTER TABLE `hostloginifo` DISABLE KEYS */;
INSERT INTO `hostloginifo` VALUES (61,'192.168.8.137','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','localhost\n',1,0,'005056ae2fbc_','VMware-422ee0b865ebe653-927792038644e161\n','VMware, Inc.VMware Virtual Platform','',''),(62,'192.168.8.47','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.9','zabbix01.imoocc.cn\n',1,0,'005056bb6849_','VMware-423b1fc0c52b74af-d1a6f48903948dcf\n','VMware, Inc.VMware Virtual Platform','',''),(63,'192.168.8.248','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','test2\n',1,0,'005056830fc3_','VMware-4203b7b4251441e3-e981474c9b2d516b\n','VMware, Inc.VMware Virtual Platform','',''),(64,'192.168.8.132','9922','root','850a2534dd27594810092a7b5ac459f1','','','Ubuntu 14.04','ubuntu-docker\n',1,0,'0242893da23c_005056831164_','VMware-4203a9acc860e53f-574f2f899197f72a\n','VMware, Inc.VMware Virtual Platform','',''),(65,'192.168.8.247','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','controller\n',1,0,'56847afe9799_005056ae0055_005056ae0056_005056ae0057_','VMware-422e01aab8dc82fd-86001dc2a08ef87a\n','VMware, Inc.VMware Virtual Platform','',''),(66,'192.168.8.244','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','test1\n',1,0,'005056830546_','VMware-4203395da0284be1-8b06f432f4f3b5d7\n','VMware, Inc.VMware Virtual Platform','',''),(67,'192.168.8.109','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-109\n',1,0,'005056ae002d_','VMware-422e1b7ecbd4521a-7efd748abd3bb5ce\n','VMware, Inc.VMware Virtual Platform','',''),(68,'192.168.8.108','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','','ESX102.\n',1,0,'005056461f08_','','未知(需要安装dmidecode工具)','','2'),(69,'192.168.8.79','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','k8s-master\n',1,0,'0242250aa2c6_005056bb5c8c__','VMware-423bc84d2995588e-fecd9b5c6f2821c3\n','VMware, Inc.VMware Virtual Platform','',''),(70,'192.168.8.76','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','localhost.localdomain\n',1,0,'005056bb6902_','VMware-423b5036f51e4a04-1e5794e9afc38fa2\n','VMware, Inc.VMware Virtual Platform','',''),(71,'192.168.8.104','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','VMware 4.1','esx104\n',1,0,'','5GLP63X\n','Dell Inc.PowerEdge R410','','2'),(72,'192.168.8.107','22','root','850a2534dd27594810092a7b5ac459f1','','','','esx-107\n',1,0,'002481e1f5f8_','','未知(需要安装dmidecode工具)','','2'),(73,'192.168.8.106','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-106\n',1,0,'005056ae7d28_','VMware-422eb57fccb89c3d-8c1c4949eb2f05d6\n','VMware, Inc.VMware Virtual Platform','',''),(74,'192.168.8.103','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','VMware 4.1','esx103\n',1,0,'','4GLP63X\n','Dell Inc.PowerEdge R410','','2'),(75,'192.168.8.178','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-178\n',1,0,'005056910031_','VMware-564d2b8605a4ac83-0568a322b4849387\n','VMware, Inc.VMware Virtual Platform','',''),(76,'192.168.8.174','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-174\n',1,0,'00505691001b_','VMware-564d15614158f955-106d7158ffc1d124\n','VMware, Inc.VMware Virtual Platform','',''),(77,'192.168.8.175','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-175\n',1,0,'005056910022_','VMware-564da470d811b63b-9e8891557f382c3e\n','VMware, Inc.VMware Virtual Platform','',''),(78,'192.168.8.176','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-176\n',1,0,'005056910024_','VMware-564d19f5c536220e-dd202641e166dfc2\n','VMware, Inc.VMware Virtual Platform','',''),(79,'192.168.8.177','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-177\n',1,0,'005056910027_005056ae0015_','VMware-564d93e4770164e4-25401e811e7ee5c8\n','VMware, Inc.VMware Virtual Platform','',''),(80,'192.168.8.118','22','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.9','zbx02.imoocc.cn\n',1,0,'005056bb5d85_','VMware-423ba7606f7071fd-44c6a57be488d9a5\n','VMware, Inc.VMware Virtual Platform','',''),(81,'192.168.8.119','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.8','scm-local\n',1,0,'005056836886_','VMware-42037e0baff42006-d8f7313d672409b6\n','VMware, Inc.VMware Virtual Platform','',''),(82,'192.168.8.61','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.9','zabbix01.imoocc.cn\n',1,0,'005056bb6849_','VMware-423b1fc0c52b74af-d1a6f48903948dcf\n','VMware, Inc.VMware Virtual Platform','',''),(83,'192.168.8.117','22','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.9','zbx01.imoocc.cn\n',1,0,'005056bb039e_','VMware-423b563a81369822-6f67804b9e269900\n','VMware, Inc.VMware Virtual Platform','',''),(84,'192.168.8.63','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','zabbix02.imoocc.cn\n',1,0,'005056bb0e9a_','VMware-423b12cf25f1c868-bc44ef6e360cac0c\n','VMware, Inc.VMware Virtual Platform','',''),(85,'192.168.8.115','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','mongo04\n',1,0,'005056ae714b_','VMware-422e64d6742be65e-b715b607e9b7afa7\n','VMware, Inc.VMware Virtual Platform','',''),(86,'192.168.8.64','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','nexus\n',1,0,'005056831589_','VMware-420361ef69ce15e8-89cbf3d43dd8ab5f\n','VMware, Inc.VMware Virtual Platform','',''),(87,'192.168.8.110','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','localhost\n',1,0,'0050568337d6_','VMware-42033ed5240a5ab2-05b405e800071c98\n','VMware, Inc.VMware Virtual Platform','',''),(88,'192.168.8.116','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','vmlb01\n',1,0,'005056ae70a1_','','未知(需要安装dmidecode工具)','',''),(89,'192.168.8.95','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','localhost.localdomain\n',1,0,'005056bb5912_','VMware-423b91bb8cfb80e1-b950f48c8605ca66\n','VMware, Inc.VMware Virtual Platform','',''),(90,'192.168.8.129','9922','root','aa16364508f515f01bdece19ab853bb5','','','Ubuntu 14.04','oae-test01\n',1,0,'1266138ae83b_005056833029_','VMware-420353df218dbca8-16dd30c51ce022cc\n','VMware, Inc.VMware Virtual Platform','',''),(91,'192.168.8.128','9922','root','aa16364508f515f01bdece19ab853bb5','','','Ubuntu 14.04','oae-test02\n',1,0,'024278062d01_005056837bb6_','VMware-4203a057e60962e3-aff3264f9d512ff0\n','VMware, Inc.VMware Virtual Platform','',''),(92,'192.168.8.127','9922','root','8cfc1bcea0840c8c9ab5a92bb66740b6','','','Ubuntu 14.04','docker-v2-dev-01\n',1,0,'0242cde20690_0050568306c4_','VMware-42034a1d24097e4d-10f36f5f4a858300\n','VMware, Inc.VMware Virtual Platform','',''),(93,'192.168.8.123','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','123-Test\n',1,0,'000c29ae47c2_','VMware-564d964e8f8ce104-b37b1d7d28ae47c2\n','VMware, Inc.VMware Virtual Platform','',''),(94,'192.168.8.122','20022','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','oae-server-local\n',1,0,'005056832d39_','','未知(需要安装dmidecode工具)','',''),(95,'192.168.8.120','22','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.9','zbxdb.imoocc.cn\n',1,0,'005056bb7d11_','VMware-423b98328c8881d4-da0c46c0b1c6c8e9\n','VMware, Inc.VMware Virtual Platform','',''),(96,'192.168.8.98','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','Slave-01\n',1,0,'005056831de2_','VMware-4203406e70dffd92-828cfe4ac0f369e2\n','VMware, Inc.VMware Virtual Platform','',''),(97,'192.168.8.99','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','weekreport\n',1,0,'005056837d93_','VMware-42035515cf659a9b-3728af4256b74a1d\n','VMware, Inc.VMware Virtual Platform','',''),(98,'192.168.8.125','9922','root','0fbcbba386e9d9a9ea329ab12b135024','','','CentOS 6.7','vpn\n',1,0,'5254003ee8df_','NotSpecified\n','Red HatKVM','',''),(99,'192.168.8.124','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','124-Test\n',1,0,'000c29672e6d_','VMware-564de93068013b35-4886473a8f672e6d\n','VMware, Inc.VMware Virtual Platform','',''),(100,'192.168.8.18','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','mongo03\n',1,0,'005056ae0028_','VMware-422e01ed4eca9c2a-c40445afdcbf0fc0\n','VMware, Inc.VMware Virtual Platform','',''),(101,'192.168.8.14','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','mongo02\n',1,0,'005056ae0025_','VMware-422e30cf90c1a828-e1ef7067ef1b8985\n','VMware, Inc.VMware Virtual Platform','',''),(102,'192.168.8.15','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','dns_m\n',1,0,'005056ae1f94_','VMware-422e86f91deb5a02-3fbe5484c33d4725\n','VMware, Inc.VMware Virtual Platform','',''),(103,'192.168.8.16','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','dns_s\n',1,0,'005056ae0a7d_','VMware-422e67e0adc7361c-c68a3d702bdd272e\n','VMware, Inc.VMware Virtual Platform','',''),(104,'192.168.8.17','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','dev-mt03\n',1,0,'005056ae0069_','VMware-422e180a67aacd72-32261d4d41dbd85a\n','VMware, Inc.VMware Virtual Platform','',''),(105,'192.168.8.10','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.6','test01\n',1,0,'005056ae0033_','VMware-564d52f5804cac82-4ae726b80d3bbe1a\n','VMware, Inc.VMware Virtual Platform','',''),(106,'192.168.8.11','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','mongo01\n',1,0,'005056ae0023_','VMware-564d4eaa56de8bf3-d43beeb95ffb1383\n','VMware, Inc.VMware Virtual Platform','',''),(107,'192.168.8.12','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','dev-mt01\n',1,0,'005056ae0066_','VMware-564d7749a37a5ace-90a0d82d67a86e24\n','VMware, Inc.VMware Virtual Platform','',''),(108,'192.168.8.13','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','dev-mt02\n',1,0,'005056ae0068_','VMware-422ee9da59339155-e88fcc913e9ac91d\n','VMware, Inc.VMware Virtual Platform','',''),(109,'192.168.8.215','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-178\n',1,0,'005056910031_','VMware-564d2b8605a4ac83-0568a322b4849387\n','VMware, Inc.VMware Virtual Platform','',''),(110,'192.168.8.214','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-177\n',1,0,'005056910027_005056ae0015_','VMware-564d93e4770164e4-25401e811e7ee5c8\n','VMware, Inc.VMware Virtual Platform','',''),(111,'192.168.8.217','9922','root','8cfc1bcea0840c8c9ab5a92bb66740b6','','','Ubuntu 14.04','ubuntu\n',1,0,'005056835b4d_','VMware-42031a3caed94b2d-c50f8e31720c5af0\n','VMware, Inc.VMware Virtual Platform','',''),(112,'192.168.8.195','9922','root','f7158b776530610aba692101da91cc47','','','CentOS 5.4','vm-195\n',1,0,'005056bf2ea3_','VMware-423fb31969002f7d-76ea48c4abfde16a\n','VMware, Inc.VMware Virtual Platform','',''),(113,'192.168.8.211','9922','root','8cfc1bcea0840c8c9ab5a92bb66740b6','','','Ubuntu 14.04','ubuntu\n',1,0,'0242afef8aad_005056836045_','VMware-4203c1a2cbed1f9d-d6c323e37d0d9809\n','VMware, Inc.VMware Virtual Platform','',''),(114,'192.168.8.213','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-176\n',1,0,'005056910024_','VMware-564d19f5c536220e-dd202641e166dfc2\n','VMware, Inc.VMware Virtual Platform','',''),(115,'192.168.8.212','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','kube01.imoocc.cn\n',1,0,'56847afe9799_782bcb71f2d3_782bcb71f2d4_','2R7R83X\n','Dell Inc.PowerEdge R510','','1'),(116,'192.168.8.198','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','OPUse\n',1,0,'00505683177c_','VMware-4203e8dbc356a5af-a700cbb60504f4c0\n','VMware, Inc.VMware Virtual Platform','',''),(117,'192.168.8.199','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','huangwp-136\n',1,0,'005056ae0027_','VMware-422ef3a84f832654-34593f0680857a13\n','VMware, Inc.VMware Virtual Platform','',''),(118,'192.168.8.134','22','root','850a2534dd27594810092a7b5ac459f1','','','','localhost\n',1,0,'f8bc1246dc14_','','未知(需要安装dmidecode工具)','','2'),(119,'192.168.8.85','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','k8s-node-2\n',1,0,'02426ea880e2_005056bb7c1d__','VMware-423bb38ec3b17c0f-d1530b8c06ae68f6\n','VMware, Inc.VMware Virtual Platform','',''),(120,'192.168.8.84','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','kube04\n',1,0,'005056bb5cd0_','VMware-423bd21f7e8110aa-fabd46784eb3f86b\n','VMware, Inc.VMware Virtual Platform','',''),(121,'192.168.8.130','22','root','850a2534dd27594810092a7b5ac459f1','','','','ESX-130\n',1,0,'b82a72d169ba_','','未知(需要安装dmidecode工具)','','2'),(122,'192.168.8.131','22','root','850a2534dd27594810092a7b5ac459f1','','','','ESX-131\n',1,0,'549f350168f0_','','未知(需要安装dmidecode工具)','','2'),(123,'192.168.8.81','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','k8s-node-1\n',1,0,'0242af53b61f_005056bb075b__','VMware-423b80ce410d0547-42317d76dd9a9314\n','VMware, Inc.VMware Virtual Platform','',''),(124,'192.168.8.138','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.7','tlinux\n',1,0,'525400cd4105_','NotSpecified\n','Red HatKVM','',''),(125,'192.168.8.207','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','localhost.localdomain\n',1,0,'00505683104a_','VMware-420343f3e82928a4-827b63ac955b8653\n','VMware, Inc.VMware Virtual Platform','',''),(126,'192.168.8.205','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','mysql_205\n',1,0,'00505683150c_','VMware-42035d71db0a59e7-8f7b98fd3d1ed8af\n','VMware, Inc.VMware Virtual Platform','',''),(127,'192.168.8.209','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','localhost.localdomain\n',1,0,'005056834fff_','VMware-420369be12300559-511c40124a1bc417\n','VMware, Inc.VMware Virtual Platform','',''),(128,'192.168.8.145','22','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','pd-145\n',1,0,'005056ae0040_','VMware-422e49f6ac6e627f-3d05a39458a4745d\n','VMware, Inc.VMware Virtual Platform','',''),(129,'192.168.8.144','9922','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.4','vm-144\n',1,0,'005056bf18bb_','VMware-423fcf1fa53456bd-97e0548cf2cd4721\n','VMware, Inc.VMware Virtual Platform','',''),(130,'192.168.8.32','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','mfsmaster\n',1,0,'005056ae0f52_','VMware-422eb1c561c4cae8-1dec74ceba40de7b\n','VMware, Inc.VMware Virtual Platform','',''),(131,'192.168.8.33','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','localhost\n',1,0,'005056ae31db_','VMware-422e299d98c7e298-2f2e6c38d4702551\n','VMware, Inc.VMware Virtual Platform','',''),(132,'192.168.8.35','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','log\n',1,0,'005056ae5e51_','','未知(需要安装dmidecode工具)','',''),(133,'192.168.8.233','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','python1.imoocc.cn\n',1,0,'005056832643_005056bb292b_','VMware-42035adc8c0bae70-8ecaa357cc771e82\n','VMware, Inc.VMware Virtual Platform','',''),(134,'192.168.8.237','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','localhost.localdomain\n',1,0,'005056bb4732_','VMware-423b91afc13282a6-1f984eb55c8ad3e6\n','VMware, Inc.VMware Virtual Platform','',''),(135,'192.168.8.235','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','yf02\n',1,0,'005056837362_005056bb3e3f_','VMware-42032f3b1490ab66-62fdcae2eac91e64\n','VMware, Inc.VMware Virtual Platform','',''),(136,'192.168.8.25','20022','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','vmlb02\n',1,0,'005056ae160a_','VMware-422e8a150aa4ce19-c6b632e28d93d696\n','VMware, Inc.VMware Virtual Platform','',''),(137,'192.168.8.24','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','svn-backup\n',1,0,'005056ae6c92_','VMware-422e95b36e180ad9-617a19332bf446b3\n','VMware, Inc.VMware Virtual Platform','',''),(138,'192.168.8.196','9922','root','f7158b776530610aba692101da91cc47','','','CentOS 5.4','vm-196\n',1,0,'005056ae0004_','VMware-422ebb4829f3227a-04fb640d6d2b89dc\n','VMware, Inc.VMware Virtual Platform','',''),(139,'192.168.8.228','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','test2\n',1,0,'005056830fc3_','VMware-4203b7b4251441e3-e981474c9b2d516b\n','VMware, Inc.VMware Virtual Platform','',''),(140,'192.168.8.224','9922','root','850a2534dd27594810092a7b5ac459f1','','','Ubuntu 12.04','kube03.imoocc.cn\n',1,0,'56847afe9799_782bcb6c2994_782bcb6c2995_','CN7R83X\n','Dell Inc.PowerEdge R510','','1'),(141,'192.168.8.226','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','test1\n',1,0,'005056830546_','VMware-4203395da0284be1-8b06f432f4f3b5d7\n','VMware, Inc.VMware Virtual Platform','',''),(142,'192.168.8.227','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','controller\n',1,0,'d2366d7f5740_005056ae00a3_005056ae00a4_005056ae00a5_','VMware-564d8890bbfaa5dd-96166cc568a9a059\n','VMware, Inc.VMware Virtual Platform','',''),(143,'192.168.8.220','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','test1\n',1,0,'005056830546_','VMware-4203395da0284be1-8b06f432f4f3b5d7\n','VMware, Inc.VMware Virtual Platform','',''),(144,'192.168.8.223','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','Ubuntu 12.04','kube02.imoocc.cn\n',1,0,'56847afe9799_782bcb6ff541_782bcb6ff542_','8N7R83X\n','Dell Inc.PowerEdge R510','','1'),(145,'192.168.8.70','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','localhost.localdomain\n',1,0,'005056bb6b92_','VMware-423bda6f56639b6c-3a35ff3cc8430198\n','VMware, Inc.VMware Virtual Platform','',''),(146,'192.168.8.57','9922','root','0d0bd4d00fe270cd4c6189a0ad03d2ae','','','CentOS 5.2','web57\n',1,0,'005056ae0006_005056ae0008_','VMware-564d93d81c849b5d-18d47406a1a2e583\n','VMware, Inc.VMware Virtual Platform','',''),(147,'192.168.8.58','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','db00\n',1,0,'005056ae52d9_','VMware-422e877e5dfa4c16-448c8f2dc99e5e3f\n','VMware, Inc.VMware Virtual Platform','',''),(148,'192.168.8.59','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','zbxclu\n',1,0,'005056bb3fea_','VMware-423bb86549e9be2e-c9e6c035a8b967ef\n','VMware, Inc.VMware Virtual Platform','',''),(149,'192.168.6.51','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','localhost.localdomain\n',1,0,'005056bb0da0_','VMware-423be9dc2fb2dea8-8518f3b73f9e594d\n','VMware, Inc.VMware Virtual Platform','',''),(150,'192.168.6.56','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 6.8','yf02\n',1,0,'005056bb3a73_','VMware-423b7fd2c1261f5c-7eeafb2837bce9da\n','VMware, Inc.VMware Virtual Platform','',''),(151,'192.168.6.61','22','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','ztest00\n',1,0,'005056ae0024_','VMware-422e2076c4a0b936-5771455ffd3c24b0\n','VMware, Inc.VMware Virtual Platform','',''),(152,'192.168.6.54','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','localhost.localdomain\n',1,0,'005056bb5a2d_','VMware-423b59762e80072c-d61b56bbb9eed573\n','VMware, Inc.VMware Virtual Platform','',''),(153,'192.168.6.11','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','db00\n',1,0,'005056ae003b_','VMware-422ef709de67df68-50ab12e90d41c2e7\n','VMware, Inc.VMware Virtual Platform','',''),(154,'192.168.6.70','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS 5.4','localhost\n',1,0,'005056ae0037_','VMware-422e293df092379a-6db00215857d599d\n','VMware, Inc.VMware Virtual Platform','',''),(155,'192.168.6.23','9922','root','3fade6ca4252a360f128696ab7434e9c','','','CentOS 5.6','test03\n',1,0,'005056ae0007_','VMware-422e5388bc83a7e5-f057cd1e9adfe148\n','VMware, Inc.VMware Virtual Platform','',''),(156,'192.168.6.124','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','svn\n',1,0,'005056ae06e7_','VMware-564d6ff75d23ee78-b8248af73970d026\n','VMware, Inc.VMware Virtual Platform','',''),(157,'192.168.6.29','9922','root','3fade6ca4252a360f128696ab7434e9c','','','CentOS 5.6','test29\n',1,0,'005056ae0039_','VMware-422e4c9bbcd19b70-1a27b9e46d44c380\n','VMware, Inc.VMware Virtual Platform','',''),(158,'192.168.6.49','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','fpm7.2\n',1,0,'005056bb78c1_','VMware-423bc2d29918eb2a-acdffc753a40b740\n','VMware, Inc.VMware Virtual Platform','',''),(159,'192.168.6.25','9922','root','f8fa21d8c2c85e082256522d6efb9fa0','','','CentOS 5.6','jenkins\n',1,0,'005056ae0005_','VMware-422ea601abf9c844-c224418be55ad9b8\n','VMware, Inc.VMware Virtual Platform','',''),(160,'192.168.6.31','9922','root','0d0bd4d00fe270cd4c6189a0ad03d2ae','','','CentOS 5.4','web\n',1,0,'005056ae003e_','VMware-422eeaff7c6d00be-d3af5503eb71a41a\n','VMware, Inc.VMware Virtual Platform','',''),(161,'192.168.6.30','22','root','af66f4874ef0ce5856392cc1263c06f5','','','CentOS 5.6','app\n',1,0,'005056ae0017_005056ae0046_','VMware-422e374abbc1456e-2b14251f13c216d5\n','VMware, Inc.VMware Virtual Platform','',''),(162,'192.168.6.44','22','root','850a2534dd27594810092a7b5ac459f1','','','','ESX-131\n',1,0,'549f350168f0_','','未知(需要安装dmidecode工具)','',''),(163,'192.168.6.21','9922','root','3fade6ca4252a360f128696ab7434e9c','','','CentOS 5.6','test01\n',1,0,'005056ae001e_','VMware-422e391dc910658a-6a8aefbe4cd0ca5b\n','VMware, Inc.VMware Virtual Platform','',''),(164,'192.168.6.24','9922','root','850a2534dd27594810092a7b5ac459f1','','','CentOS 6.7','imoocc-svn\n',1,0,'005056ae5ac1_','VMware-422ebae74f83596b-eb66dfbc17d49be9\n','VMware, Inc.VMware Virtual Platform','',''),(165,'192.168.6.22','9922','root','3fade6ca4252a360f128696ab7434e9c','','','CentOS 5.6','test02\n',1,0,'005056ae0003_','VMware-422ece4a4f8035e6-2c044dd2c52857e4\n','VMware, Inc.VMware Virtual Platform','',''),(166,'192.168.6.43','9922','root','8cfc1bcea0840c8c9ab5a92bb66740b6','','','CentOS 6.7','kvm01\n',1,0,'f8bc12469654_f8bc12469655_f8bc12469656_f8bc12469657_','J154R12\n','Dell Inc.PowerEdge R620','','0'),(167,'192.168.6.42','9922','root','0f5ac4be26e5a5584f4159469f4e90d4','','','CentOS Linux 7.2','localhost.localdomain\n',1,0,'0242c6ffcc8f_005056bb2767_','VMware-423b48b2c79a82ba-8bb8fe476d5395bc\n','VMware, Inc.VMware Virtual Platform','',''),(210,'172.16.1.2',NULL,NULL,'','','','','Cisco_3560P',0,0,'','FDO1533P1WN','Network device','',''),(211,'172.16.1.3','20022',NULL,'','','','','',0,0,'','','','',''),(212,'172.16.1.1',NULL,NULL,'','','','','Cisco_2921',0,0,'','FGL1949116Y','Network device','','');
/*!40000 ALTER TABLE `hostloginifo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `machineoperationsinfo`
--

DROP TABLE IF EXISTS `machineoperationsinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `machineoperationsinfo` (
  `id` int(11) NOT NULL auto_increment,
  `number` int(11) NOT NULL,
  `person` varchar(20) NOT NULL,
  `time` datetime NOT NULL,
  `sn_key` varchar(250) NOT NULL,
  `machine_type` varchar(20) NOT NULL,
  `operation` longtext NOT NULL,
  `state` int(11) NOT NULL,
  `remark` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `sn_key` (`sn_key`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `machineoperationsinfo`
--

LOCK TABLES `machineoperationsinfo` WRITE;
/*!40000 ALTER TABLE `machineoperationsinfo` DISABLE KEYS */;
INSERT INTO `machineoperationsinfo` VALUES (1,0,'','2017-11-01 09:07:53','VMware-422ebae74f83596b-eb66dfbc17837331','','',2,''),(2,0,'','2017-11-01 09:07:53','VMware-422e293df092379a-6db0021585789154','','',2,''),(3,0,'','2017-11-12 17:25:50','VMware-422e391dc910658a-6a8aefbe4c432171','','',3,''),(4,0,'','2017-11-01 09:07:54','VMware-422ef709de67df68-50ab12e90d814885','','',2,''),(5,0,'','2017-11-01 09:07:54','VMware-422ea601abf9c844-c224418be5990063','','',2,''),(6,0,'','2017-11-01 09:07:54','VMware-422e5388bc83a7e5-f057cd1e9a677125','','',2,''),(7,0,'','2017-11-01 09:07:54','549f35565177','','',2,''),(8,0,'','2017-11-01 09:07:54','VMware-422e2076c4a0b936-5771455ffd538825','','',2,''),(9,0,'','2017-11-01 09:07:54','VMware-422ece4a4f8035e6-2c044dd2c5983440','','',2,''),(10,0,'','2017-11-01 09:07:54','VMware-423bc2d29918eb2a-acdffc753a802202','','',2,''),(11,0,'','2017-11-01 09:07:54','VMware-422e374abbc1456e-2b14251f13964733','','',2,''),(12,0,'','2017-11-01 09:07:54','VMware-422eeaff7c6d00be-d3af5503eb382914','','',2,''),(13,0,'','2017-11-01 09:07:54','VMware-423be9dc2fb2dea8-8518f3b73f831744','','',2,''),(14,0,'','2017-11-01 09:07:54','VMware-422e4c9bbcd19b70-1a27b9e46d465203','','',2,''),(15,0,'','2017-11-01 09:07:54','VMware-564d6ff75d23ee78-b8248af739713175','','',2,''),(16,0,'','2017-11-01 09:07:54','VMware-423b7fd2c1261f5c-7eeafb2837903339','','',2,''),(17,0,'','2017-11-01 09:07:54','192168612','','',2,''),(18,0,'','2017-11-01 09:07:54','J560353','','',2,''),(19,0,'','2017-11-01 09:07:54','VMware-423b59762e80072c-d61b56bbb9226910','','',2,''),(20,0,'','2017-11-01 09:07:54','VMware-423b48b2c79a82ba-8bb8fe476d397008','','',2,''),(21,0,'','2017-11-02 07:48:14','98b3fd2b7e36dockernet/713727','','',2,''),(22,0,'','2017-11-02 07:48:14','VMware-422e30cf90c1a828-e1ef7067ef771779','','',2,''),(23,0,'','2017-11-02 07:48:14','8b350a7865a15af44d864759','','',2,''),(24,0,'','2017-11-02 07:48:14','0ee6dfa166b9dockernet/php257187','','',2,''),(25,0,'','2017-11-02 07:48:14','C916168','','',2,''),(26,0,'','2017-11-02 07:48:14','894d03116ea3dockernet/m682689','','',2,''),(27,0,'','2017-11-02 07:48:14','53bb6489f25adockernet/568247','','',2,''),(28,0,'','2017-11-02 07:48:14','VMware-564d93d81c849b5d-18d47406a1663954','','',2,''),(29,0,'','2017-11-02 07:48:14','VMware-423b563a81369822-6f67804b9e504843','','',2,''),(30,0,'','2017-11-02 07:48:14','e6fa31eecf4edockernet/698275','','',2,''),(31,0,'','2017-11-02 07:48:14','420a8bacd8f85af44d189216','','',2,''),(32,0,'','2017-11-02 07:48:14','VMware-4203406e70dffd92-828cfe4ac0606349','','',2,''),(33,0,'','2017-11-02 07:48:14','8bced4b15174dockernet/mariadb-805311','','',2,''),(34,0,'','2017-11-02 07:48:14','9873ed835a2edockernet/php494826','','',2,''),(35,0,'','2017-11-02 07:48:14','b5b8f9f8152fdockernet/124758','','',2,''),(36,0,'','2017-11-02 07:48:14','fa6dc63ddee15af44d229483','','',2,''),(37,0,'','2017-11-02 07:48:14','025ec2b3a66adockernet/544614','','',2,''),(38,0,'','2017-11-02 07:48:14','b0335838dd0bdockernet/mariadb-126064','','',2,''),(39,0,'','2017-11-02 07:48:14','27c63dc40001dockernet/mariadb-712033','','',2,''),(40,0,'','2017-11-02 07:48:15','VMware-42035515cf659a9b-3728af4256475742','','',2,''),(41,0,'','2017-11-02 07:48:15','568d99fd1532dockernet/php398970','','',2,''),(42,0,'','2017-11-02 07:48:15','VMware-422e877e5dfa4c16-448c8f2dc9540354','','',2,''),(43,0,'','2017-11-02 07:48:15','VMware-564d7749a37a5ace-90a0d82d67803645','','',2,''),(44,0,'','2017-11-02 07:48:15','59b1cfa8e482dockernet/m157025','','',2,''),(45,0,'','2017-11-02 07:48:15','c4418d9bb6cbdockernet/648094','','',2,''),(46,0,'','2017-11-02 07:48:15','e7a3bf8e3e69dockernet/258880','','',2,''),(47,0,'','2017-11-02 07:48:15','8c1857265528dockernet/381493','','',2,''),(48,0,'','2017-11-02 07:48:15','4c2399c8fa8cdockernet/mariadb-622093','','',2,''),(49,0,'','2017-11-02 07:48:15','94a1648d7718dockernet/php334232','','',2,''),(50,0,'','2017-11-02 07:48:15','23faf89a058cdockernet/php882623','','',2,''),(51,0,'','2017-11-02 07:48:15','30f67cc388d1dockernet/php939747','','',2,''),(52,0,'','2017-11-02 07:48:15','VMware-422eb1c561c4cae8-1dec74ceba895442','','',2,''),(53,0,'','2017-11-02 07:48:15','16c06291d6b0dockernet/941832','','',2,''),(54,0,'','2017-11-02 07:48:15','e5574e24d80fdockernet/716120','','',2,''),(55,0,'','2017-11-02 07:48:15','0f050661b4efdockernet/mariadb-195361','','',2,''),(56,0,'','2017-11-02 07:48:15','770d90e023c5dockernet/975724','','',2,''),(57,0,'','2017-11-02 07:48:15','VMware-422e64d6742be65e-b715b607e9723357','','',2,''),(58,0,'','2017-11-02 07:48:15','VMware-564d4eaa56de8bf3-d43beeb95f623585','','',2,''),(59,0,'','2017-11-02 07:48:15','7b555e843db7dockernet/php574707','','',2,''),(60,0,'','2017-11-02 07:48:15','b5b1ca405580dockernet/mariadb-861807','','',2,''),(61,0,'','2017-11-02 07:48:15','VMware-422e01ed4eca9c2a-c40445afdc640520','','',2,''),(62,0,'','2017-11-02 07:48:15','bb1df5c1d41edockernet/744786','','',2,''),(63,0,'','2017-11-02 07:48:15','9a8e12de65b8dockernet/785482','','',2,''),(64,0,'','2017-11-02 07:48:15','36afb341626cdockernet/570692','','',2,''),(65,0,'','2017-11-02 07:48:16','2623608','','',2,''),(66,0,'','2017-11-02 07:48:16','703525ea98dddockernet/917480','','',2,''),(67,0,'','2017-11-02 07:48:16','VMware-420361ef69ce15e8-89cbf3d43d130647','','',2,''),(68,0,'','2017-11-02 07:48:16','e248ceb44db4dockernet/php406174','','',2,''),(69,0,'','2017-11-02 07:48:16','VMware-4203b7b4251441e3-e981474c9b517350','','',2,''),(70,0,'','2017-11-02 07:48:16','9330251b96e5dockernet/mariadb-427511','','',2,''),(71,0,'','2017-11-02 07:48:16','002481573523','','',2,''),(72,0,'','2017-11-02 07:48:16','VMware-42035adc8c0bae70-8ecaa357cc900254','','',2,''),(73,0,'','2017-11-02 07:48:16','VMware-42031a3caed94b2d-c50f8e3172798012','','',2,''),(74,0,'','2017-11-02 07:48:16','005056400897','','',2,''),(75,0,'','2017-11-02 07:48:16','VMware-4203a9acc860e53f-574f2f8991445441','','',2,''),(76,0,'','2017-11-02 07:48:16','ba1ec5e79093dockernet/181439','','',2,''),(77,0,'','2017-11-02 07:48:16','bdc25c4933105af44d967428','','',2,''),(78,0,'','2017-11-02 07:48:16','1fa6e364c06fdockernet/php221270','','',2,''),(79,0,'','2017-11-02 07:48:16','9d82bb8236ccdockernet/php308235','','',2,''),(80,0,'','2017-11-02 07:48:16','ec35bc203c9cdockernet/m610307','','',2,''),(81,0,'','2017-11-02 07:48:16','09a8974196b3dockernet/586546','','',2,''),(82,0,'','2017-11-02 07:48:16','88b3af647cfddockernet/php796356','','',2,''),(83,0,'','2017-11-02 07:48:16','248dbc0fb40edockernet/php734299','','',2,''),(84,0,'','2017-11-02 07:48:16','113ed0fbc1a2dockernet/257238','','',2,''),(85,0,'','2017-11-02 07:48:16','72c26661761ddockernet/php121787','','',2,''),(86,0,'','2017-11-02 07:48:16','VMware-564d93e4770164e4-25401e811e273006','','',2,''),(87,0,'','2017-11-02 07:48:16','80826f5ac8c5dockernet/mariadb-748646','','',2,''),(88,0,'','2017-11-02 07:48:16','d3eb2cd13ca4dockernet/php339199','','',2,''),(89,0,'','2017-11-02 07:48:16','VMware-422e49f6ac6e627f-3d05a39458279022','','',2,''),(90,0,'','2017-11-02 07:48:16','7797b79be23adockernet/mariadb-920282','','',2,''),(91,0,'','2017-11-02 07:48:16','VMware-42035d71db0a59e7-8f7b98fd3d732507','','',2,''),(92,0,'','2017-11-02 07:48:16','fd47ef96ce60dockernet/mariadb-790729','','',2,''),(93,0,'','2017-11-02 07:48:16','4635369','','',2,''),(94,0,'','2017-11-02 07:48:17','b4fcdb5313b0dockernet/304742','','',2,''),(95,0,'','2017-11-02 07:48:17','f08ee9c6416fdockernet/php564614','','',2,''),(96,0,'','2017-11-02 07:48:17','ffe24b3e7fefdockernet/php229239','','',2,''),(97,0,'','2017-11-02 07:48:17','f3174e57024edockernet/mariadb-139737','','',2,''),(98,0,'','2017-11-02 07:48:17','80bef5da040c5af44d584602','','',2,''),(99,0,'','2017-11-02 07:48:17','7f3f8975280e5af44d844657','','',2,''),(100,0,'','2017-11-02 07:48:17','e918393ae992dockernet/php472010','','',2,''),(101,0,'','2017-11-02 07:48:17','939aeeeaefc1dockernet/php617142','','',2,''),(102,0,'','2017-11-02 07:48:17','VMware-420369be12300559-511c40124a642521','','',2,''),(103,0,'','2017-11-02 07:48:17','232de6a6580edockernet/php345709','','',2,''),(104,0,'','2017-11-02 07:48:17','cc2cc3e2c79fdockernet/php544285','','',2,''),(105,0,'','2017-11-02 07:48:17','8de6f9a4e11e5af44d134816','','',2,''),(106,0,'','2017-11-02 07:48:17','926da9efbe11dockernet/php255547','','',2,''),(107,0,'','2017-11-02 07:48:17','70b6924a646adockernet/php276414','','',2,''),(108,0,'','2017-11-02 07:48:17','VMware-564d15614158f955-106d7158ff784910','','',2,''),(109,0,'','2017-11-02 07:48:17','e65a410777685af44d139459','','',2,''),(110,0,'','2017-11-02 07:48:17','005056252684','','',2,''),(111,0,'','2017-11-02 07:48:17','35a73b1d7520dockernet/mariadb-844510','','',2,''),(112,0,'','2017-11-02 07:48:17','VMware-564da470d811b63b-9e8891557f726448','','',2,''),(113,0,'','2017-11-02 07:48:17','VMware-42032f3b1490ab66-62fdcae2ea948581','','',2,''),(114,0,'','2017-11-02 07:48:17','VMware-423ba7606f7071fd-44c6a57be4404743','','',2,''),(115,0,'','2017-11-02 07:48:17','VMware-423b91bb8cfb80e1-b950f48c86409938','','',2,''),(116,0,'','2017-11-02 07:48:17','0a73510d6b8adockernet/111836','','',2,''),(117,0,'','2017-11-02 07:48:17','de9fb2bbb207dockernet/732743','','',2,''),(118,0,'','2017-11-02 07:48:17','5771e424a3b4dockernet/543713','','',2,''),(119,0,'','2017-11-02 07:48:17','9550e94003c1dockernet/834893','','',2,''),(120,0,'','2017-11-02 07:48:17','3fb89be7c0eadockernet/php742962','','',2,''),(121,0,'','2017-11-02 07:48:17','970c6b2350f3dockernet/mariadb-954013','','',2,''),(122,0,'','2017-11-02 07:48:17','2f729d50dc56dockernet/806897','','',2,''),(123,0,'','2017-11-02 07:48:17','VMware-564d964e8f8ce104-b37b1d7d28794715','','',2,''),(124,0,'','2017-11-02 07:48:17','a1ff4f46de0cdockernet/mariadb-720844','','',2,''),(125,0,'','2017-11-02 07:48:17','01ce30f1c2a7dockernet/php955552','','',2,''),(126,0,'','2017-11-02 07:48:17','391ee60de44fdockernet/php244882','','',2,''),(127,0,'','2017-11-02 07:48:18','VMware-422e67e0adc7361c-c68a3d702b565856','','',2,''),(128,0,'','2017-11-02 07:48:18','VMware-564d2b8605a4ac83-0568a322b4671308','','',2,''),(129,0,'','2017-11-02 07:48:18','VMware-564d52f5804cac82-4ae726b80d120504','','',2,''),(130,0,'','2017-11-02 07:48:18','5883589','','',2,''),(131,0,'','2017-11-02 07:48:18','VMware-422e180a67aacd72-32261d4d41975351','','',2,''),(132,0,'','2017-11-02 07:48:18','2231d37fb743dockernet/php701807','','',2,''),(133,0,'','2017-11-02 07:48:18','VMware-42037e0baff42006-d8f7313d67763419','','',2,''),(134,0,'','2017-11-02 07:48:18','0b62f3382e70dockernet/307699','','',2,''),(135,0,'','2017-11-02 07:48:18','VMware-564d8890bbfaa5dd-96166cc568713550','','',2,''),(136,0,'','2017-11-02 07:48:18','c78fa1b995b35af44d435278','','',2,''),(137,0,'','2017-11-02 07:48:18','1771f675d6b8dockernet/680384','','',2,''),(138,0,'','2017-11-02 07:48:18','b82a72547483','','',2,''),(139,0,'','2017-11-02 07:48:18','76533ce61e2cdockernet/608261','','',2,''),(140,0,'','2017-11-02 07:48:18','71111ecab8e8dockernet/571613','','',2,''),(141,0,'','2017-11-02 07:48:18','fd991b3aa63b5af44d921670','','',2,''),(142,0,'','2017-11-02 07:48:18','87bf8ffa5727dockernet/mariadb-319469','','',2,''),(143,0,'','2017-11-02 07:48:18','5db584144baadockernet/mariadb-201894','','',2,''),(144,0,'','2017-11-02 07:48:18','8966695d5894dockernet/php854230','','',2,''),(145,0,'','2017-11-02 07:48:18','efbeaad70fd0dockernet/888481','','',2,''),(146,0,'','2017-11-02 07:48:18','3f03ee0a9201dockernet/mariadb-841009','','',2,''),(147,0,'','2017-11-02 07:48:18','VMware-42033ed5240a5ab2-05b405e800882556','','',2,''),(148,0,'','2017-11-02 07:48:18','VMware-423bda6f56639b6c-3a35ff3cc8865049','','',2,''),(149,0,'','2017-11-02 07:48:18','VMware-423bb38ec3b17c0f-d1530b8c06694548','','',2,''),(150,0,'','2017-11-02 07:48:18','VMware-420343f3e82928a4-827b63ac95395348','','',2,''),(151,0,'','2017-11-02 07:48:18','34380dbfa02ddockernet/mariadb-577910','','',2,''),(152,0,'','2017-11-02 07:48:18','5bf99756ac3adockernet/php972761','','',2,''),(153,0,'','2017-11-02 07:48:18','c7539cc083d8dockernet/146947','','',2,''),(154,0,'','2017-11-02 07:48:18','b4bc05d3783ddockernet/m831655','','',2,''),(155,0,'','2017-11-02 07:48:19','b3a135ac783bdockernet/php471643','','',2,''),(156,0,'','2017-11-02 07:48:19','8529176','','',2,''),(157,0,'','2017-11-02 07:48:19','0f7d4184e594dockernet/mariadb-911938','','',2,''),(158,0,'','2017-11-02 07:48:19','6a118ea5a6c6dockernet/967859','','',2,''),(159,0,'','2017-11-02 07:48:19','669e5bbd5196dockernet/mariadb-225149','','',2,''),(160,0,'','2017-11-02 07:48:19','VMware-422ee0b865ebe653-9277920386399320','','',2,''),(161,0,'','2017-11-02 07:48:19','VMware-422eb57fccb89c3d-8c1c4949eb608625','','',2,''),(162,0,'','2017-11-02 07:48:19','9a8c2ff0b5fadockernet/416780','','',2,''),(163,0,'','2017-11-02 07:48:19','c39c1e1f6a77dockernet/php205249','','',2,''),(164,0,'','2017-11-02 07:48:19','VMware-422ef3a84f832654-34593f0680532734','','',2,''),(165,0,'','2017-11-02 07:48:19','VMware-422e8a150aa4ce19-c6b632e28d637830','','',2,''),(166,0,'','2017-11-02 07:48:19','VMware-423fcf1fa53456bd-97e0548cf2628747','','',2,''),(167,0,'','2017-11-02 07:48:19','VMware-564d19f5c536220e-dd202641e1727235','','',2,''),(168,0,'','2017-11-02 07:48:19','VMware-423b12cf25f1c868-bc44ef6e36166615','','',2,''),(169,0,'','2017-11-02 07:48:19','VMware-423bb86549e9be2e-c9e6c035a8210726','','',2,''),(170,0,'','2017-11-02 07:48:19','b4384e36b0185af44d761793','','',2,''),(171,0,'','2017-11-02 07:48:19','a9fbfead8d47dockernet/mariadb-293431','','',2,''),(172,0,'','2017-11-02 07:48:19','c6d4cfe4739a5af44d849184','','',2,''),(173,0,'','2017-11-02 07:48:19','8cf37371f76ddockernet/272116','','',2,''),(174,0,'','2017-11-02 07:48:19','db6599b55befdockernet/669592','','',2,''),(175,0,'','2017-11-02 07:48:19','778da6a023b7dockernet/210790','','',2,''),(176,0,'','2017-11-02 07:48:19','1721613','','',2,''),(177,0,'','2017-11-02 07:48:19','1721611','','',2,''),(178,0,'','2017-11-02 07:48:19','d4daf84258a25af44d222636','','',2,''),(179,0,'','2017-11-02 07:48:19','3e330ae9aa635af44d507242','','',2,''),(180,0,'','2017-11-02 07:48:19','a2428c074b5cdockernet/php923127','','',2,''),(181,0,'','2017-11-02 07:48:19','bc2b4623d356dockernet/php944236','','',2,''),(182,0,'','2017-11-02 07:48:19','525400502722','','',2,''),(183,0,'','2017-11-02 07:48:19','5717d202f3e0dockernet/php923456','','',2,''),(184,0,'','2017-11-02 07:48:20','217b808f19f3dockernet/316869','','',2,''),(185,0,'','2017-11-02 07:48:20','b0e1e04f3c715af44d932769','','',2,''),(186,0,'','2017-11-02 07:48:20','b2014244968adockernet/mariadb-366040','','',2,''),(187,0,'','2017-11-02 07:48:20','8ddf4db66012dockernet/979328','','',2,''),(188,0,'','2017-11-02 07:48:20','VMware-4203e8dbc356a5af-a700cbb605409860','','',2,''),(189,0,'','2017-11-02 07:48:20','52d49e3044d2dockernet/mariadb-305720','','',2,''),(190,0,'','2017-11-02 07:48:20','VMware-423fb31969002f7d-76ea48c4ab844647','','',2,''),(191,0,'','2017-11-02 07:48:20','VMware-423b98328c8881d4-da0c46c0b1496306','','',2,''),(192,0,'','2017-11-02 07:48:20','f0839168cd89dockernet/726626','','',2,''),(193,0,'','2017-11-02 07:48:20','005056839215','','',2,''),(194,0,'','2017-11-02 07:48:20','VMware-422e95b36e180ad9-617a19332b163749','','',2,''),(195,0,'','2017-11-02 07:48:20','f8bc12140506','','',2,''),(196,0,'','2017-11-02 07:48:20','VMware-423b80ce410d0547-42317d76dd415784','','',2,''),(197,0,'','2017-11-02 07:48:20','462f48465cc3dockernet/mariadb-682508','','',2,''),(198,0,'','2017-11-02 07:48:20','VMware-422e86f91deb5a02-3fbe5484c3506804','','',2,''),(199,0,'','2017-11-02 07:48:20','5e4aa945d9fedockernet/524257','','',2,''),(200,0,'','2017-11-02 07:48:20','VMware-4203a057e60962e3-aff3264f9d630350','','',2,''),(201,0,'','2017-11-02 07:48:20','39a7a07404a8dockernet/975843','','',2,''),(202,0,'','2017-11-02 07:48:20','VMware-564de93068013b35-4886473a8f447773','','',2,''),(203,0,'','2017-11-02 07:48:20','0f1031ae9cc3dockernet/php563386','','',2,''),(204,0,'','2017-11-02 07:48:20','a0463313008bdockernet/php597750','','',2,''),(205,0,'','2017-11-02 07:48:20','06b1e006b0d2dockernet/mariadb-920668','','',2,''),(206,0,'','2017-11-02 07:48:20','fa925ae99080dockernet/442954','','',2,''),(207,0,'','2017-11-02 07:48:20','c2ac6d1d5ba4dockernet/php155538','','',2,''),(208,0,'','2017-11-02 07:48:20','e2ecf7dcdb50dockernet/623438','','',2,''),(209,0,'','2017-11-02 07:48:20','VMware-423bc84d2995588e-fecd9b5c6f279893','','',2,''),(210,0,'','2017-11-02 07:48:20','6037c0db38e4dockernet/php273490','','',2,''),(211,0,'','2017-11-02 07:48:20','VMware-423bd21f7e8110aa-fabd46784e115436','','',2,''),(212,0,'','2017-11-02 07:48:20','81d1afccf13ddockernet/877815','','',2,''),(213,0,'','2017-11-02 07:48:21','VMware-423b1fc0c52b74af-d1a6f48903335992','','',2,''),(214,0,'','2017-11-02 07:48:21','1099f06a4763dockernet/php999705','','',2,''),(215,0,'','2017-11-02 07:48:21','VMware-420353df218dbca8-16dd30c51c459172','','',2,''),(216,0,'','2017-11-02 07:48:21','9154d0c206bcdockernet/893298','','',2,''),(217,0,'','2017-11-02 07:48:21','VMware-422ebb4829f3227a-04fb640d6d411960','','',2,''),(218,0,'','2017-11-02 07:48:21','VMware-422e299d98c7e298-2f2e6c38d4785613','','',2,''),(219,0,'','2017-11-02 07:48:21','69a769bc979adockernet/php658058','','',2,''),(220,0,'','2017-11-02 07:48:21','f330779435dfdockernet/mariadb-766646','','',2,''),(221,0,'','2017-11-02 07:48:21','5ad32f9a726c5af44d966006','','',2,''),(222,0,'','2017-11-02 07:48:21','da0dcf1b6014dockernet/m111680','','',2,''),(223,0,'','2017-11-02 07:48:21','7096e2a8393fdockernet/php939293','','',2,''),(224,0,'','2017-11-02 07:48:21','3302c4312652dockernet/218391','','',2,''),(225,0,'','2017-11-02 07:48:21','FDO1533P1WN','','',2,''),(226,0,'','2017-11-02 07:48:21','005056300015','','',2,''),(227,0,'','2017-11-02 07:48:21','2488c2464b5cdockernet/php734684','','',2,''),(228,0,'','2017-11-02 07:48:21','0c1841523819dockernet/579192','','',2,''),(229,0,'','2017-11-02 07:48:21','VMware-422e1b7ecbd4521a-7efd748abd495942','','',2,''),(230,0,'','2017-11-02 07:48:21','c59b2a24b3abdockernet/mariadb-233311','','',2,''),(231,0,'','2017-11-02 07:48:21','d268c47a8702dockernet/php605207','','',2,''),(232,0,'','2017-11-02 07:48:21','41ccd219e1dedockernet/mariadb-815676','','',2,''),(233,0,'','2017-11-02 07:48:21','VMware-4203c1a2cbed1f9d-d6c323e37d117283','','',2,''),(234,0,'','2017-11-02 07:48:21','VMware-423b91afc13282a6-1f984eb55c577086','','',2,''),(235,0,'','2017-11-02 07:48:21','0411ae6f4127dockernet/635173','','',2,''),(236,0,'','2017-11-02 07:48:21','VMware-42034a1d24097e4d-10f36f5f4a292181','','',2,''),(237,0,'','2017-11-02 07:48:21','VMware-4203395da0284be1-8b06f432f4786991','','',2,''),(238,0,'','2017-11-02 07:48:21','b957ce1b2b135af44d223617','','',2,''),(239,0,'','2017-11-02 07:48:21','f973dccdb019dockernet/968200','','',2,''),(240,0,'','2017-11-02 07:48:21','6105dd4a8fb3dockernet/mariadb-411163','','',2,''),(241,0,'','2017-11-02 07:48:21','af93e791d05edockernet/450397','','',2,''),(242,0,'','2017-11-02 07:48:21','cf1180a6b86cdockernet/386817','','',2,''),(243,0,'','2017-11-02 07:48:21','7a8a783d456cdockernet/php877537','','',2,''),(244,0,'','2017-11-02 07:48:21','cfea85e82f81dockernet/656597','','',2,''),(245,0,'','2017-11-02 07:48:21','VMware-422ee9da59339155-e88fcc913e471621','','',2,''),(246,0,'','2017-11-02 07:48:21','525400853303','','',2,''),(247,0,'','2017-11-02 07:48:21','afb9bf194735dockernet/mariadb-949421','','',2,''),(248,0,'','2017-11-02 07:48:22','VMware-423b5036f51e4a04-1e5794e9af305238','','',2,''),(249,0,'','2017-11-02 07:48:22','VMware-422e01aab8dc82fd-86001dc2a0878860','','',2,''),(250,0,'','2017-11-02 07:48:22','3ec18e29fde8dockernet/mariadb-164419','','',2,''),(251,0,'','2017-11-02 07:48:22','2d3872b44845dockernet/php672836','','',2,''),(252,0,'','2017-11-02 07:48:22','95b60129362bdockernet/php778129','','',2,''),(253,0,'','2017-11-02 07:48:22','62aaddeba21edockernet/php689883','','',2,''),(254,0,'','2017-11-02 07:48:22','b120d81054ecdockernet/mariadb-344514','','',2,''),(255,0,'','2017-11-02 07:48:22','0a24e27bbaf4dockernet/php461636','','',2,''),(256,0,'','2017-11-02 07:48:22','8057a6fc5479dockernet/php787778','','',2,''),(257,0,'','2017-11-02 07:48:22','7a0643078a05dockernet/php539788','','',2,''),(258,0,'','2017-11-03 14:57:44','1721612','','',2,''),(259,0,'','2017-11-03 15:56:16','FGL1949116Y','','',2,''),(260,0,'','2017-11-10 01:13:33','3758e95c42a9dockernet/549198','','',2,'');
/*!40000 ALTER TABLE `machineoperationsinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `netconnectioninfo`
--

DROP TABLE IF EXISTS `netconnectioninfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `netconnectioninfo` (
  `id` int(11) NOT NULL auto_increment,
  `tel_username` varchar(10) default NULL,
  `tel_userpasswd` varchar(40) default NULL,
  `tel_enpasswd` varchar(40) default NULL,
  `tel_host_port` varchar(10) default NULL,
  `tel_hostip` varchar(40) default NULL,
  `tel_status` int(11) NOT NULL,
  `tel_type` int(11) NOT NULL,
  `sn_key` varchar(256) NOT NULL,
  `dev_info_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `netconnectioninfo_dev_info_id_3b08beed_fk_networkinfo_id` (`dev_info_id`),
  CONSTRAINT `netconnectioninfo_dev_info_id_3b08beed_fk_networkinfo_id` FOREIGN KEY (`dev_info_id`) REFERENCES `networkinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netconnectioninfo`
--

LOCK TABLES `netconnectioninfo` WRITE;
/*!40000 ALTER TABLE `netconnectioninfo` DISABLE KEYS */;
INSERT INTO `netconnectioninfo` VALUES (24,'','8cfc1bcea0840c8c9ab5a92bb66740b6','8cfc1bcea0840c8c9ab5a92bb66740b6','21','172.16.1.2',1,2,'FDO1533P1WN',27),(25,'imoocc','8cfc1bcea0840c8c9ab5a92bb66740b6','8cfc1bcea0840c8c9ab5a92bb66740b6','21','172.16.1.1',1,2,'FGL1949116Y',26);
/*!40000 ALTER TABLE `netconnectioninfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkinfo`
--

DROP TABLE IF EXISTS `networkinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkinfo` (
  `id` int(11) NOT NULL auto_increment,
  `host_ip` varchar(40) NOT NULL,
  `host_name` varchar(10) NOT NULL,
  `sn` varchar(256) NOT NULL,
  `net_cab_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `networkinfo_net_cab_id_003e32bf_fk_cabinetinfo_id` (`net_cab_id`),
  CONSTRAINT `networkinfo_net_cab_id_003e32bf_fk_cabinetinfo_id` FOREIGN KEY (`net_cab_id`) REFERENCES `cabinetinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkinfo`
--

LOCK TABLES `networkinfo` WRITE;
/*!40000 ALTER TABLE `networkinfo` DISABLE KEYS */;
INSERT INTO `networkinfo` VALUES (26,'172.16.1.1','Cisco_2921','FGL1949116Y',1),(27,'172.16.1.2','Cisco_3560','FDO1533P1WN',1);
/*!40000 ALTER TABLE `networkinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `othermachineinfo`
--

DROP TABLE IF EXISTS `othermachineinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `othermachineinfo` (
  `id` int(11) NOT NULL auto_increment,
  `ip` varchar(40) NOT NULL,
  `sn_key` varchar(256) NOT NULL,
  `machine_name` varchar(20) NOT NULL,
  `remark` longtext NOT NULL,
  `reson_str` varchar(128) NOT NULL,
  `oth_cab_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `othermachineinfo_oth_cab_id_bb1d61c8_fk_cabinetinfo_id` (`oth_cab_id`),
  CONSTRAINT `othermachineinfo_oth_cab_id_bb1d61c8_fk_cabinetinfo_id` FOREIGN KEY (`oth_cab_id`) REFERENCES `cabinetinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `othermachineinfo`
--

LOCK TABLES `othermachineinfo` WRITE;
/*!40000 ALTER TABLE `othermachineinfo` DISABLE KEYS */;
INSERT INTO `othermachineinfo` VALUES (1,'192.168.6.12','192168612','','','IP存活，非Linux服务器',1),(2,'172.16.1.3','1721613','','','SSH端口存活，无法登录',1),(3,'172.16.1.1','1721611','','','SSH端口存活，无法登录',1),(4,'172.16.1.2','1721612','','','SSH端口存活，无法登录',1);
/*!40000 ALTER TABLE `othermachineinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physicalserverinfo`
--

DROP TABLE IF EXISTS `physicalserverinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physicalserverinfo` (
  `id` int(11) NOT NULL auto_increment,
  `server_ip` varchar(40) NOT NULL,
  `machine_brand` varchar(60) NOT NULL,
  `system_ver` varchar(30) NOT NULL,
  `sys_hostname` varchar(15) NOT NULL,
  `mac` varchar(512) NOT NULL,
  `sn` varchar(256) NOT NULL,
  `vir_type` varchar(2) NOT NULL,
  `conn_phy_id` int(11) NOT NULL,
  `ser_cabin_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `physicalserverinfo_conn_phy_id_c7c129e9_fk_connectioninfo_id` (`conn_phy_id`),
  KEY `physicalserverinfo_ser_cabin_id_db760568_fk_cabinetinfo_id` (`ser_cabin_id`),
  CONSTRAINT `physicalserverinfo_conn_phy_id_c7c129e9_fk_connectioninfo_id` FOREIGN KEY (`conn_phy_id`) REFERENCES `connectioninfo` (`id`),
  CONSTRAINT `physicalserverinfo_ser_cabin_id_db760568_fk_cabinetinfo_id` FOREIGN KEY (`ser_cabin_id`) REFERENCES `cabinetinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physicalserverinfo`
--

LOCK TABLES `physicalserverinfo` WRITE;
/*!40000 ALTER TABLE `physicalserverinfo` DISABLE KEYS */;
INSERT INTO `physicalserverinfo` VALUES (203,'10.16.8.224','Dell Inc.PowerEdge R510','Ubuntu 12.04','app3','56847afe9799_782bcb6c2994_782bcb6c2995_','C916168','1',3,1),(204,'10.16.8.212','Dell Inc.PowerEdge R510','Ubuntu 12.04','db16','56847afe9799_782bcb71f2d3_782bcb71f2d4_','2623608','1',16,1),(205,'10.16.8.107','ESXI宿主机(未知型号)','','db19','002481e1f5f8_','002481573523','2',19,1),(206,'10.16.8.35','未知(需要安装dmidecode工具)','CentOS 6.7','db22','005056ae5e51_','005056400897','',22,1),(207,'10.16.8.103','ESXI宿主机(未知型号)','VMware 4.1','redis27','','4635369','2',27,1),(208,'10.16.8.108','ESXI宿主机(未知型号)','','apache31','005056461f08_','005056252684','2',31,1),(209,'10.16.8.104','ESXI宿主机(未知型号)','VMware 4.1','store43','','5883589','2',43,1),(210,'10.16.8.130','ESXI宿主机(未知型号)','','redis48','b82a72d169ba_','b82a72547483','2',48,1),(211,'10.16.6.43','Dell Inc.PowerEdge R620','CentOS 6.7','cache56','f8bc12469654_f8bc12469655_f8bc12469656_f8bc12469657_','J560353','0',56,1),(212,'10.16.8.223','Dell Inc.PowerEdge R510','Ubuntu 12.04','3g57','56847afe9799_782bcb6ff541_782bcb6ff542_','8529176','1',57,1),(213,'10.16.8.116','未知(需要安装dmidecode工具)','CentOS 6.7','3g72','005056ae70a1_','005056839215','',72,1),(214,'10.16.8.134','ESXI宿主机(未知型号)','','3g74','f8bc1246dc14_','f8bc12140506','2',74,1),(215,'10.16.8.131,10.16.6.44','ESXI宿主机(未知型号)','','3g80','549f350168f0_','549f35565177','2',80,1),(216,'10.16.8.122','未知(需要安装dmidecode工具)','CentOS 6.7','redis90','005056832d39_','005056300015','',90,1);
/*!40000 ALTER TABLE `physicalserverinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statisticsrecord`
--

DROP TABLE IF EXISTS `statisticsrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statisticsrecord` (
  `id` int(11) NOT NULL auto_increment,
  `datatime` datetime NOT NULL,
  `all_count` int(11) NOT NULL,
  `pyh_count` int(11) NOT NULL,
  `net_count` int(11) NOT NULL,
  `other_count` int(11) NOT NULL,
  `kvm_count` int(11) NOT NULL,
  `docker_count` int(11) NOT NULL,
  `vmx_count` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statisticsrecord`
--

LOCK TABLES `statisticsrecord` WRITE;
/*!40000 ALTER TABLE `statisticsrecord` DISABLE KEYS */;
INSERT INTO `statisticsrecord` VALUES (1,'2017-11-01 00:00:00',3,2,0,1,0,0,0),(2,'2017-11-01 00:00:00',3,2,0,1,0,0,0),(3,'2017-11-02 00:00:00',213,14,1,3,2,154,40),(4,'2017-11-03 00:00:00',257,14,0,4,2,154,83),(5,'2017-11-03 00:00:00',257,14,2,4,2,154,83),(6,'2017-11-03 00:00:00',257,14,2,4,2,154,83),(7,'2017-11-03 00:00:00',257,14,2,4,2,154,83),(8,'2017-11-03 00:00:00',257,14,2,4,2,154,83),(9,'2017-11-03 00:00:00',214,14,2,4,2,154,40),(10,'2017-11-04 00:00:00',214,14,2,4,2,154,40),(11,'2017-11-05 00:00:00',214,14,2,4,2,154,40),(12,'2017-11-06 00:00:00',214,14,2,4,2,154,40),(13,'2017-11-07 00:00:00',214,14,2,4,2,154,40),(14,'2017-11-08 00:00:00',214,14,2,4,2,154,40),(15,'2017-11-09 00:00:00',257,14,2,4,2,154,83),(16,'2017-11-10 00:00:00',258,14,2,4,2,155,83),(17,'2017-11-11 00:00:00',258,14,2,4,2,155,83);
/*!40000 ALTER TABLE `statisticsrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userinfo` (
  `id` int(11) NOT NULL auto_increment,
  `user_name` varchar(15) NOT NULL,
  `user_passwd` varchar(40) NOT NULL,
  `user_level` varchar(2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES (1,'admin','7c4a8d09ca3762af61e59520943dc26494f8941b','2');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualserverinfo`
--

DROP TABLE IF EXISTS `virtualserverinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualserverinfo` (
  `id` int(11) NOT NULL auto_increment,
  `server_ip` varchar(40) NOT NULL,
  `server_type` varchar(80) NOT NULL,
  `system_ver` varchar(30) NOT NULL,
  `sys_hostname` varchar(15) NOT NULL,
  `mac` varchar(512) NOT NULL,
  `sn` varchar(256) NOT NULL,
  `conn_vir_id` int(11) NOT NULL,
  `vir_phy_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `virtualserverinfo_conn_vir_id_d94c8b88_fk_connectioninfo_id` (`conn_vir_id`),
  KEY `virtualserverinfo_vir_phy_id_3cbeda76_fk_physicalserverinfo_id` (`vir_phy_id`),
  CONSTRAINT `virtualserverinfo_conn_vir_id_d94c8b88_fk_connectioninfo_id` FOREIGN KEY (`conn_vir_id`) REFERENCES `connectioninfo` (`id`),
  CONSTRAINT `virtualserverinfo_vir_phy_id_3cbeda76_fk_physicalserverinfo_id` FOREIGN KEY (`vir_phy_id`) REFERENCES `physicalserverinfo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3639 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualserverinfo`
--

LOCK TABLES `virtualserverinfo` WRITE;
/*!40000 ALTER TABLE `virtualserverinfo` DISABLE KEYS */;
INSERT INTO `virtualserverinfo` VALUES (3399,'10.16.8.14','VMX:redis1','CentOS 5.6','redis1','005056ae0025_','VMware-422e30cf90c1a828-e1ef7067ef771779',1,207),(3400,'10.16.6.61','VMX:cache2','CentOS 5.6','cache2','005056ae0024_','VMware-422e2076c4a0b936-5771455ffd538825',2,207),(3401,'10.16.8.57','VMX:app4','CentOS 5.2','app4','005056ae0006_005056ae0008_','VMware-564d93d81c849b5d-18d47406a1663954',4,208),(3402,'10.16.8.117','VMX:apache5','CentOS 6.9','apache5','005056bb039e_','VMware-423b563a81369822-6f67804b9e504843',5,205),(3403,'10.16.8.98','VMX:3g6','CentOS 6.7','3g6','005056831de2_','VMware-4203406e70dffd92-828cfe4ac0606349',6,215),(3404,'10.16.8.99','VMX:store7','CentOS 6.7','store7','005056837d93_','VMware-42035515cf659a9b-3728af4256475742',7,215),(3405,'10.16.6.23','VMX:store8','CentOS 5.6','store8','005056ae0007_','VMware-422e5388bc83a7e5-f057cd1e9a677125',8,207),(3406,'10.16.8.58','VMX:app9','CentOS 5.6','app9','005056ae52d9_','VMware-422e877e5dfa4c16-448c8f2dc9540354',9,210),(3407,'10.16.8.12','VMX:redis10','Ubuntu 12.04','redis10','005056ae0066_','VMware-564d7749a37a5ace-90a0d82d67803645',10,208),(3408,'10.16.6.30','VMX:db11','CentOS 5.6','db11','005056ae0017_005056ae0046_','VMware-422e374abbc1456e-2b14251f13964733',11,207),(3409,'10.16.8.32','VMX:api12','CentOS 6.7','api12','005056ae0f52_','VMware-422eb1c561c4cae8-1dec74ceba895442',12,205),(3410,'10.16.8.115','VMX:redis13','CentOS 5.6','redis13','005056ae714b_','VMware-422e64d6742be65e-b715b607e9723357',13,210),(3411,'10.16.8.11','VMX:redis14','CentOS 5.6','redis14','005056ae0023_','VMware-564d4eaa56de8bf3-d43beeb95f623585',14,208),(3412,'10.16.8.18','VMX:redis15','CentOS 5.6','redis15','005056ae0028_','VMware-422e01ed4eca9c2a-c40445afdc640520',15,209),(3413,'10.16.8.64','VMX:api17','CentOS 6.7','api17','005056831589_','VMware-420361ef69ce15e8-89cbf3d43d130647',17,215),(3414,'10.16.8.248,10.16.8.228','VMX:db18','CentOS 6.8','db18','005056830fc3_','VMware-4203b7b4251441e3-e981474c9b517350',18,208),(3415,'10.16.8.233','VMX:apache20','CentOS 6.8','apache20','005056832643_005056bb292b_','VMware-42035adc8c0bae70-8ecaa357cc900254',20,205),(3416,'10.16.8.217','VMX:redis21','Ubuntu 14.04','redis21','005056835b4d_','VMware-42031a3caed94b2d-c50f8e3172798012',21,205),(3417,'10.16.8.132','VMX:api23','Ubuntu 14.04','api23','0242893da23c_005056831164_','VMware-4203a9acc860e53f-574f2f8991445441',23,214),(3418,'10.16.8.177,10.16.8.214','VMX:app24','CentOS 5.4','app24','005056910027_005056ae0015_','VMware-564d93e4770164e4-25401e811e273006',24,208),(3419,'10.16.8.145','VMX:3g25','CentOS 5.4','3g25','005056ae0040_','VMware-422e49f6ac6e627f-3d05a39458279022',25,209),(3420,'10.16.8.205','VMX:nginx26','CentOS 6.8','nginx26','00505683150c_','VMware-42035d71db0a59e7-8f7b98fd3d732507',26,214),(3421,'10.16.6.124','VMX:redis28','CentOS 5.6','redis28','005056ae06e7_','VMware-564d6ff75d23ee78-b8248af739713175',28,210),(3422,'10.16.8.209','VMX:redis29','CentOS 6.8','redis29','005056834fff_','VMware-420369be12300559-511c40124a642521',29,205),(3423,'10.16.8.174','VMX:app30','CentOS 5.4','app30','00505691001b_','VMware-564d15614158f955-106d7158ff784910',30,208),(3424,'10.16.8.175','VMX:app32','CentOS 5.4','app32','005056910022_','VMware-564da470d811b63b-9e8891557f726448',32,208),(3425,'10.16.6.42','VMX:redis33','CentOS Linux 7.2','redis33','0242c6ffcc8f_005056bb2767_','VMware-423b48b2c79a82ba-8bb8fe476d397008',33,210),(3426,'10.16.8.235','VMX:redis34','CentOS 6.8','redis34','005056837362_005056bb3e3f_','VMware-42032f3b1490ab66-62fdcae2ea948581',34,205),(3427,'10.16.6.70','VMX:api35','CentOS 5.4','api35','005056ae0037_','VMware-422e293df092379a-6db0021585789154',35,209),(3428,'10.16.8.118','VMX:store36','CentOS 6.9','store36','005056bb5d85_','VMware-423ba7606f7071fd-44c6a57be4404743',36,205),(3429,'10.16.8.95','VMX:redis37','CentOS Linux 7.2','redis37','005056bb5912_','VMware-423b91bb8cfb80e1-b950f48c86409938',37,205),(3430,'10.16.8.123','VMX:redis38','CentOS 6.7','redis38','000c29ae47c2_','VMware-564d964e8f8ce104-b37b1d7d28794715',38,205),(3431,'10.16.6.56','VMX:3g39','CentOS 6.8','3g39','005056bb3a73_','VMware-423b7fd2c1261f5c-7eeafb2837903339',39,205),(3432,'10.16.6.51','VMX:3g40','CentOS 6.8','3g40','005056bb0da0_','VMware-423be9dc2fb2dea8-8518f3b73f831744',40,208),(3433,'10.16.8.199','VMX:redis41','CentOS 5.4','redis41','005056ae0027_','VMware-422ef3a84f832654-34593f0680532734',41,209),(3434,'10.16.8.10','VMX:cache42','CentOS 5.6','cache42','005056ae0033_','VMware-564d52f5804cac82-4ae726b80d120504',42,208),(3435,'10.16.8.17','VMX:api44','Ubuntu 12.04','api44','005056ae0069_','VMware-422e180a67aacd72-32261d4d41975351',44,209),(3436,'10.16.8.119','VMX:store45','CentOS 6.8','store45','005056836886_','VMware-42037e0baff42006-d8f7313d67763419',45,205),(3437,'10.16.8.227','VMX:redis46','Ubuntu 12.04','redis46','d2366d7f5740_005056ae00a3_005056ae00a4_005056ae00a5_','VMware-564d8890bbfaa5dd-96166cc568713550',46,208),(3438,'10.16.8.196','VMX:app47','CentOS 5.4','app47','005056ae0004_','VMware-422ebb4829f3227a-04fb640d6d411960',47,207),(3439,'10.16.6.21','VMX:nginx49','CentOS 5.6','nginx49','005056ae001e_','VMware-422e391dc910658a-6a8aefbe4c432171',49,207),(3440,'10.16.6.22','VMX:api50','CentOS 5.6','api50','005056ae0003_','VMware-422ece4a4f8035e6-2c044dd2c5983440',50,207),(3441,'10.16.8.110','VMX:app51','CentOS 6.7','app51','0050568337d6_','VMware-42033ed5240a5ab2-05b405e800882556',51,214),(3442,'10.16.8.70','VMX:cache52','CentOS 6.8','cache52','005056bb6b92_','VMware-423bda6f56639b6c-3a35ff3cc8865049',52,205),(3443,'10.16.8.16','VMX:apache53','CentOS 6.7','apache53','005056ae0a7d_','VMware-422e67e0adc7361c-c68a3d702b565856',53,215),(3444,'10.16.8.85','VMX:apache54','CentOS Linux 7.2','apache54','02426ea880e2_005056bb7c1d__','VMware-423bb38ec3b17c0f-d1530b8c06694548',54,208),(3445,'10.16.8.207','VMX:apache55','CentOS 6.8','apache55','00505683104a_','VMware-420343f3e82928a4-827b63ac95395348',55,214),(3446,'10.16.8.137','VMX:3g58','CentOS 6.7','3g58','005056ae2fbc_','VMware-422ee0b865ebe653-9277920386399320',58,210),(3447,'10.16.8.106','VMX:redis59','CentOS 5.4','redis59','005056ae7d28_','VMware-422eb57fccb89c3d-8c1c4949eb608625',59,210),(3448,'10.16.8.178,10.16.8.215','VMX:apache60','CentOS 5.4','apache60','005056910031_','VMware-564d2b8605a4ac83-0568a322b4671308',60,208),(3449,'10.16.8.25','VMX:nginx61','CentOS 6.7','nginx61','005056ae160a_','VMware-422e8a150aa4ce19-c6b632e28d637830',61,210),(3450,'10.16.8.144','VMX:3g62','CentOS 5.4','3g62','005056bf18bb_','VMware-423fcf1fa53456bd-97e0548cf2628747',62,209),(3451,'10.16.8.176,10.16.8.213','VMX:3g63','CentOS 5.4','3g63','005056910024_','VMware-564d19f5c536220e-dd202641e1727235',63,208),(3452,'10.16.8.63','VMX:api64','CentOS 6.8','api64','005056bb0e9a_','VMware-423b12cf25f1c868-bc44ef6e36166615',64,215),(3453,'10.16.8.59','VMX:apache65','CentOS 6.8','apache65','005056bb3fea_','VMware-423bb86549e9be2e-c9e6c035a8210726',65,215),(3454,'10.16.6.29','VMX:apache66','CentOS 5.6','apache66','005056ae0039_','VMware-422e4c9bbcd19b70-1a27b9e46d465203',66,207),(3455,'10.16.8.125','KVM:3g68','CentOS 6.7','3g68','5254003ee8df_','525400502722',68,211),(3456,'10.16.8.198','VMX:redis69','CentOS 6.8','redis69','00505683177c_','VMware-4203e8dbc356a5af-a700cbb605409860',69,215),(3457,'10.16.8.195','VMX:redis70','CentOS 5.4','redis70','005056bf2ea3_','VMware-423fb31969002f7d-76ea48c4ab844647',70,209),(3458,'10.16.8.120','VMX:db71','CentOS 6.9','db71','005056bb7d11_','VMware-423b98328c8881d4-da0c46c0b1496306',71,205),(3459,'10.16.8.24','VMX:3g73','CentOS 6.7','3g73','005056ae6c92_','VMware-422e95b36e180ad9-617a19332b163749',73,215),(3460,'10.16.8.81','VMX:store75','CentOS Linux 7.2','store75','0242af53b61f_005056bb075b__','VMware-423b80ce410d0547-42317d76dd415784',75,208),(3461,'10.16.8.15','VMX:cache76','CentOS 6.7','cache76','005056ae1f94_','VMware-422e86f91deb5a02-3fbe5484c3506804',76,210),(3462,'10.16.8.128','VMX:db77','Ubuntu 14.04','db77','024278062d01_005056837bb6_','VMware-4203a057e60962e3-aff3264f9d630350',77,205),(3463,'10.16.8.124','VMX:3g78','CentOS 6.7','3g78','000c29672e6d_','VMware-564de93068013b35-4886473a8f447773',78,205),(3464,'10.16.6.24','VMX:redis79','CentOS 6.7','redis79','005056ae5ac1_','VMware-422ebae74f83596b-eb66dfbc17837331',79,210),(3465,'10.16.8.79','VMX:app81','CentOS Linux 7.2','app81','0242250aa2c6_005056bb5c8c__','VMware-423bc84d2995588e-fecd9b5c6f279893',81,208),(3466,'10.16.6.31','VMX:redis82','CentOS 5.4','redis82','005056ae003e_','VMware-422eeaff7c6d00be-d3af5503eb382914',82,209),(3467,'10.16.8.84','VMX:nginx83','CentOS Linux 7.2','nginx83','005056bb5cd0_','VMware-423bd21f7e8110aa-fabd46784e115436',83,208),(3468,'10.16.8.47,10.16.8.61','VMX:apache84','CentOS 6.9','apache84','005056bb6849_','VMware-423b1fc0c52b74af-d1a6f48903335992',84,215),(3469,'10.16.6.54','VMX:redis85','CentOS Linux 7.2','redis85','005056bb5a2d_','VMware-423b59762e80072c-d61b56bbb9226910',85,205),(3470,'10.16.8.129','VMX:apache86','Ubuntu 14.04','apache86','1266138ae83b_005056833029_','VMware-420353df218dbca8-16dd30c51c459172',86,205),(3471,'10.16.6.25','VMX:db87','CentOS 5.6','db87','005056ae0005_','VMware-422ea601abf9c844-c224418be5990063',87,207),(3472,'10.16.8.33','VMX:store88','CentOS 6.7','store88','005056ae31db_','VMware-422e299d98c7e298-2f2e6c38d4785613',88,205),(3473,'10.16.8.109','VMX:app91','CentOS 5.4','app91','005056ae002d_','VMware-422e1b7ecbd4521a-7efd748abd495942',91,214),(3474,'10.16.8.211','VMX:db92','Ubuntu 14.04','db92','0242afef8aad_005056836045_','VMware-4203c1a2cbed1f9d-d6c323e37d117283',92,205),(3475,'10.16.8.237','VMX:redis93','CentOS Linux 7.2','redis93','005056bb4732_','VMware-423b91afc13282a6-1f984eb55c577086',93,215),(3476,'10.16.8.127','VMX:redis94','Ubuntu 14.04','redis94','0242cde20690_0050568306c4_','VMware-42034a1d24097e4d-10f36f5f4a292181',94,205),(3477,'10.16.8.244,10.16.8.226,10.16.8.22','VMX:apache95','CentOS 6.8','apache95','005056830546_','VMware-4203395da0284be1-8b06f432f4786991',95,208),(3478,'10.16.8.13','VMX:store96','Ubuntu 12.04','store96','005056ae0068_','VMware-422ee9da59339155-e88fcc913e471621',96,207),(3479,'10.16.6.11','VMX:api97','CentOS 5.6','api97','005056ae003b_','VMware-422ef709de67df68-50ab12e90d814885',97,207),(3480,'10.16.8.138','KVM:app98','CentOS 6.7','app98','525400cd4105_','525400853303',98,211),(3481,'10.16.6.49','VMX:nginx99','CentOS Linux 7.2','nginx99','005056bb78c1_','VMware-423bc2d29918eb2a-acdffc753a802202',99,208),(3482,'10.16.8.76','VMX:api100','CentOS 6.8','api100','005056bb6902_','VMware-423b5036f51e4a04-1e5794e9af305238',100,205),(3483,'10.16.8.247','VMX:apache101','Ubuntu 12.04','apache101','56847afe9799_005056ae0055_005056ae0056_005056ae0057_','VMware-422e01aab8dc82fd-86001dc2a0878860',101,215),(3484,'10.16.8.212','Docker Contianer:3g102','Ubuntu 12.04','3g102','be082490f89f_','7a8a783d456cdockernet/php877537',102,204),(3485,'10.16.8.212','Docker Contianer:3g103','Ubuntu 12.04','3g103','be082490f89f_','778da6a023b7dockernet/210790',103,204),(3486,'10.16.8.212','Docker Contianer:db104','Ubuntu 12.04','db104','be082490f89f_','3302c4312652dockernet/218391',104,204),(3487,'10.16.8.212','Docker Contianer:redis105','Ubuntu 12.04','redis105','be082490f89f_','16c06291d6b0dockernet/941832',105,204),(3488,'10.16.8.212','Docker Contianer:app106','Ubuntu 12.04','app106','be082490f89f_','8057a6fc5479dockernet/php787778',106,204),(3489,'10.16.8.212','Docker Contianer:app107','Ubuntu 12.04','app107','be082490f89f_','5bf99756ac3adockernet/php972761',107,204),(3490,'10.16.8.212','Docker Contianer:store108','Ubuntu 12.04','store108','be082490f89f_','c2ac6d1d5ba4dockernet/php155538',108,204),(3491,'10.16.8.212','Docker Contianer:nginx109','Ubuntu 12.04','nginx109','be082490f89f_','d3eb2cd13ca4dockernet/php339199',109,204),(3492,'10.16.8.212','Docker Contianer:app110','Ubuntu 12.04','app110','be082490f89f_','248dbc0fb40edockernet/php734299',110,204),(3493,'10.16.8.212','Docker Contianer:apache111','Ubuntu 12.04','apache111','be082490f89f_','232de6a6580edockernet/php345709',111,204),(3494,'10.16.8.212','Docker Contianer:api112','Ubuntu 12.04','api112','be082490f89f_','8de6f9a4e11e5af44d134816',112,204),(3495,'10.16.8.212','Docker Contianer:nginx113','Ubuntu 12.04','nginx113','be082490f89f_','e7a3bf8e3e69dockernet/258880',113,204),(3496,'10.16.8.212','Docker Contianer:app114','Ubuntu 12.04','app114','be082490f89f_','f973dccdb019dockernet/968200',114,204),(3497,'10.16.8.212','Docker Contianer:cache115','Ubuntu 12.04','cache115','be082490f89f_','e6fa31eecf4edockernet/698275',115,204),(3498,'10.16.8.212','Docker Contianer:cache116','Ubuntu 12.04','cache116','be082490f89f_','2488c2464b5cdockernet/php734684',116,204),(3499,'10.16.8.212','Docker Contianer:cache117','Ubuntu 12.04','cache117','be082490f89f_','cfea85e82f81dockernet/656597',117,204),(3500,'10.16.8.212','Docker Contianer:api118','Ubuntu 12.04','api118','be082490f89f_','025ec2b3a66adockernet/544614',118,204),(3501,'10.16.8.212','Docker Contianer:api119','Ubuntu 12.04','api119','be082490f89f_','8ddf4db66012dockernet/979328',119,204),(3502,'10.16.8.212','Docker Contianer:apache120','Ubuntu 12.04','apache120','be082490f89f_','98b3fd2b7e36dockernet/713727',120,204),(3503,'10.16.8.212','Docker Contianer:nginx121','Ubuntu 12.04','nginx121','be082490f89f_','06b1e006b0d2dockernet/mariadb-920668',121,204),(3504,'10.16.8.224','Docker Contianer:app122','Ubuntu 12.04','app122','06ee74b9c42d_','81d1afccf13ddockernet/877815',122,203),(3505,'10.16.8.224','Docker Contianer:cache123','Ubuntu 12.04','cache123','06ee74b9c42d_','8c1857265528dockernet/381493',123,203),(3506,'10.16.8.224','Docker Contianer:api124','Ubuntu 12.04','api124','06ee74b9c42d_','894d03116ea3dockernet/m682689',124,203),(3507,'10.16.8.224','Docker Contianer:cache125','Ubuntu 12.04','cache125','06ee74b9c42d_','39a7a07404a8dockernet/975843',125,203),(3508,'10.16.8.224','Docker Contianer:cache126','Ubuntu 12.04','cache126','06ee74b9c42d_','9a8e12de65b8dockernet/785482',126,203),(3509,'10.16.8.224','Docker Contianer:nginx127','Ubuntu 12.04','nginx127','06ee74b9c42d_','113ed0fbc1a2dockernet/257238',127,203),(3510,'10.16.8.224','Docker Contianer:apache128','Ubuntu 12.04','apache128','06ee74b9c42d_','ba1ec5e79093dockernet/181439',128,203),(3511,'10.16.8.224','Docker Contianer:redis129','Ubuntu 12.04','redis129','06ee74b9c42d_','391ee60de44fdockernet/php244882',129,203),(3512,'10.16.8.224','Docker Contianer:api130','Ubuntu 12.04','api130','06ee74b9c42d_','703525ea98dddockernet/917480',130,203),(3513,'10.16.8.224','Docker Contianer:app131','Ubuntu 12.04','app131','06ee74b9c42d_','5db584144baadockernet/mariadb-201894',131,203),(3514,'10.16.8.224','Docker Contianer:app132','Ubuntu 12.04','app132','06ee74b9c42d_','62aaddeba21edockernet/php689883',132,203),(3515,'10.16.8.224','Docker Contianer:redis133','Ubuntu 12.04','redis133','06ee74b9c42d_','7a0643078a05dockernet/php539788',133,203),(3516,'10.16.8.224','Docker Contianer:apache134','Ubuntu 12.04','apache134','06ee74b9c42d_','9a8c2ff0b5fadockernet/416780',134,203),(3517,'10.16.8.224','Docker Contianer:redis135','Ubuntu 12.04','redis135','06ee74b9c42d_','71111ecab8e8dockernet/571613',135,203),(3518,'10.16.8.224','Docker Contianer:3g136','Ubuntu 12.04','3g136','06ee74b9c42d_','f0839168cd89dockernet/726626',136,203),(3519,'10.16.8.224','Docker Contianer:db137','Ubuntu 12.04','db137','06ee74b9c42d_','770d90e023c5dockernet/975724',137,203),(3520,'10.16.8.224','Docker Contianer:apache138','Ubuntu 12.04','apache138','06ee74b9c42d_','09a8974196b3dockernet/586546',138,203),(3521,'10.16.8.224','Docker Contianer:store139','Ubuntu 12.04','store139','06ee74b9c42d_','2f729d50dc56dockernet/806897',139,203),(3522,'10.16.8.224','Docker Contianer:api140','Ubuntu 12.04','api140','06ee74b9c42d_','af93e791d05edockernet/450397',140,203),(3523,'10.16.8.224','Docker Contianer:cache141','Ubuntu 12.04','cache141','06ee74b9c42d_','72c26661761ddockernet/php121787',141,203),(3524,'10.16.8.224','Docker Contianer:store142','Ubuntu 12.04','store142','06ee74b9c42d_','0b62f3382e70dockernet/307699',142,203),(3525,'10.16.8.224','Docker Contianer:store143','Ubuntu 12.04','store143','06ee74b9c42d_','3758e95c42a9dockernet/549198',143,203),(3526,'10.16.8.224','Docker Contianer:api144','Ubuntu 12.04','api144','06ee74b9c42d_','c7539cc083d8dockernet/146947',144,203),(3527,'10.16.8.224','Docker Contianer:nginx145','Ubuntu 12.04','nginx145','06ee74b9c42d_','94a1648d7718dockernet/php334232',145,203),(3528,'10.16.8.224','Docker Contianer:apache146','Ubuntu 12.04','apache146','06ee74b9c42d_','5e4aa945d9fedockernet/524257',146,203),(3529,'10.16.8.224','Docker Contianer:apache147','Ubuntu 12.04','apache147','06ee74b9c42d_','b5b1ca405580dockernet/mariadb-861807',147,203),(3530,'10.16.8.224','Docker Contianer:apache148','Ubuntu 12.04','apache148','06ee74b9c42d_','a0463313008bdockernet/php597750',148,203),(3531,'10.16.8.224','Docker Contianer:redis149','Ubuntu 12.04','redis149','06ee74b9c42d_','6037c0db38e4dockernet/php273490',149,203),(3532,'10.16.8.224','Docker Contianer:cache150','Ubuntu 12.04','cache150','06ee74b9c42d_','9d82bb8236ccdockernet/php308235',150,203),(3533,'10.16.8.224','Docker Contianer:3g151','Ubuntu 12.04','3g151','06ee74b9c42d_','1771f675d6b8dockernet/680384',151,203),(3534,'10.16.8.224','Docker Contianer:redis152','Ubuntu 12.04','redis152','06ee74b9c42d_','b5b8f9f8152fdockernet/124758',152,203),(3535,'10.16.8.223','Docker Contianer:3g153','Ubuntu 12.04','3g153','6a7595531e47_','e918393ae992dockernet/php472010',153,212),(3536,'10.16.8.223','Docker Contianer:redis154','Ubuntu 12.04','redis154','6a7595531e47_','5717d202f3e0dockernet/php923456',154,212),(3537,'10.16.8.223','Docker Contianer:redis155','Ubuntu 12.04','redis155','6a7595531e47_','420a8bacd8f85af44d189216',155,212),(3538,'10.16.8.223','Docker Contianer:app156','Ubuntu 12.04','app156','6a7595531e47_','7b555e843db7dockernet/php574707',156,212),(3539,'10.16.8.223','Docker Contianer:apache157','Ubuntu 12.04','apache157','6a7595531e47_','9873ed835a2edockernet/php494826',157,212),(3540,'10.16.8.223','Docker Contianer:apache158','Ubuntu 12.04','apache158','6a7595531e47_','36afb341626cdockernet/570692',158,212),(3541,'10.16.8.223','Docker Contianer:3g159','Ubuntu 12.04','3g159','6a7595531e47_','926da9efbe11dockernet/php255547',159,212),(3542,'10.16.8.223','Docker Contianer:app160','Ubuntu 12.04','app160','6a7595531e47_','da0dcf1b6014dockernet/m111680',160,212),(3543,'10.16.8.223','Docker Contianer:db161','Ubuntu 12.04','db161','6a7595531e47_','6a118ea5a6c6dockernet/967859',161,212),(3544,'10.16.8.223','Docker Contianer:3g162','Ubuntu 12.04','3g162','6a7595531e47_','23faf89a058cdockernet/php882623',162,212),(3545,'10.16.8.223','Docker Contianer:nginx163','Ubuntu 12.04','nginx163','6a7595531e47_','217b808f19f3dockernet/316869',163,212),(3546,'10.16.8.223','Docker Contianer:redis164','Ubuntu 12.04','redis164','6a7595531e47_','0f050661b4efdockernet/mariadb-195361',164,212),(3547,'10.16.8.223','Docker Contianer:api165','Ubuntu 12.04','api165','6a7595531e47_','0411ae6f4127dockernet/635173',165,212),(3548,'10.16.8.223','Docker Contianer:apache166','Ubuntu 12.04','apache166','6a7595531e47_','e2ecf7dcdb50dockernet/623438',166,212),(3549,'10.16.8.223','Docker Contianer:redis167','Ubuntu 12.04','redis167','6a7595531e47_','fa925ae99080dockernet/442954',167,212),(3550,'10.16.8.223','Docker Contianer:redis168','Ubuntu 12.04','redis168','6a7595531e47_','7096e2a8393fdockernet/php939293',168,212),(3551,'10.16.8.223','Docker Contianer:db169','Ubuntu 12.04','db169','6a7595531e47_','c4418d9bb6cbdockernet/648094',169,212),(3552,'10.16.8.223','Docker Contianer:3g170','Ubuntu 12.04','3g170','6a7595531e47_','01ce30f1c2a7dockernet/php955552',170,212),(3553,'10.16.8.223','Docker Contianer:3g171','Ubuntu 12.04','3g171','6a7595531e47_','3f03ee0a9201dockernet/mariadb-841009',171,212),(3554,'10.16.8.223','Docker Contianer:cache172','Ubuntu 12.04','cache172','6a7595531e47_','8bced4b15174dockernet/mariadb-805311',172,212),(3555,'10.16.8.223','Docker Contianer:store173','Ubuntu 12.04','store173','6a7595531e47_','8cf37371f76ddockernet/272116',173,212),(3556,'10.16.8.223','Docker Contianer:store174','Ubuntu 12.04','store174','6a7595531e47_','5ad32f9a726c5af44d966006',174,212),(3557,'10.16.8.223','Docker Contianer:nginx175','Ubuntu 12.04','nginx175','6a7595531e47_','7797b79be23adockernet/mariadb-920282',175,212),(3558,'10.16.8.223','Docker Contianer:app176','Ubuntu 12.04','app176','6a7595531e47_','35a73b1d7520dockernet/mariadb-844510',176,212),(3559,'10.16.8.223','Docker Contianer:api177','Ubuntu 12.04','api177','6a7595531e47_','bb1df5c1d41edockernet/744786',177,212),(3560,'10.16.8.223','Docker Contianer:db178','Ubuntu 12.04','db178','6a7595531e47_','970c6b2350f3dockernet/mariadb-954013',178,212),(3561,'10.16.8.223','Docker Contianer:redis179','Ubuntu 12.04','redis179','6a7595531e47_','cf1180a6b86cdockernet/386817',179,212),(3562,'10.16.8.223','Docker Contianer:store180','Ubuntu 12.04','store180','6a7595531e47_','0c1841523819dockernet/579192',180,212),(3563,'10.16.8.223','Docker Contianer:redis181','Ubuntu 12.04','redis181','6a7595531e47_','c39c1e1f6a77dockernet/php205249',181,212),(3564,'10.16.8.223','Docker Contianer:redis182','Ubuntu 12.04','redis182','6a7595531e47_','f08ee9c6416fdockernet/php564614',182,212),(3565,'10.16.8.223','Docker Contianer:apache183','Ubuntu 12.04','apache183','6a7595531e47_','a9fbfead8d47dockernet/mariadb-293431',183,212),(3566,'10.16.8.223','Docker Contianer:store184','Ubuntu 12.04','store184','6a7595531e47_','41ccd219e1dedockernet/mariadb-815676',184,212),(3567,'10.16.8.223','Docker Contianer:redis185','Ubuntu 12.04','redis185','6a7595531e47_','6105dd4a8fb3dockernet/mariadb-411163',185,212),(3568,'10.16.8.223','Docker Contianer:app186','Ubuntu 12.04','app186','6a7595531e47_','0ee6dfa166b9dockernet/php257187',186,212),(3569,'10.16.8.223','Docker Contianer:app187','Ubuntu 12.04','app187','6a7595531e47_','87bf8ffa5727dockernet/mariadb-319469',187,212),(3570,'10.16.8.223','Docker Contianer:nginx188','Ubuntu 12.04','nginx188','6a7595531e47_','b4384e36b0185af44d761793',188,212),(3571,'10.16.8.223','Docker Contianer:store189','Ubuntu 12.04','store189','6a7595531e47_','ffe24b3e7fefdockernet/php229239',189,212),(3572,'10.16.8.223','Docker Contianer:api190','Ubuntu 12.04','api190','6a7595531e47_','9550e94003c1dockernet/834893',190,212),(3573,'10.16.8.223','Docker Contianer:redis191','Ubuntu 12.04','redis191','6a7595531e47_','bc2b4623d356dockernet/php944236',191,212),(3574,'10.16.8.223','Docker Contianer:3g192','Ubuntu 12.04','3g192','6a7595531e47_','0a73510d6b8adockernet/111836',192,212),(3575,'10.16.8.223','Docker Contianer:db193','Ubuntu 12.04','db193','6a7595531e47_','8b350a7865a15af44d864759',193,212),(3576,'10.16.8.223','Docker Contianer:redis194','Ubuntu 12.04','redis194','6a7595531e47_','80bef5da040c5af44d584602',194,212),(3577,'10.16.8.223','Docker Contianer:apache195','Ubuntu 12.04','apache195','6a7595531e47_','efbeaad70fd0dockernet/888481',195,212),(3578,'10.16.8.223','Docker Contianer:app196','Ubuntu 12.04','app196','6a7595531e47_','b120d81054ecdockernet/mariadb-344514',196,212),(3579,'10.16.8.223','Docker Contianer:redis197','Ubuntu 12.04','redis197','6a7595531e47_','b2014244968adockernet/mariadb-366040',197,212),(3580,'10.16.8.223','Docker Contianer:3g198','Ubuntu 12.04','3g198','6a7595531e47_','2231d37fb743dockernet/php701807',198,212),(3581,'10.16.8.223','Docker Contianer:redis199','Ubuntu 12.04','redis199','6a7595531e47_','b957ce1b2b135af44d223617',199,212),(3582,'10.16.8.223','Docker Contianer:store200','Ubuntu 12.04','store200','6a7595531e47_','c6d4cfe4739a5af44d849184',200,212),(3583,'10.16.8.223','Docker Contianer:app201','Ubuntu 12.04','app201','6a7595531e47_','e5574e24d80fdockernet/716120',201,212),(3584,'10.16.8.223','Docker Contianer:db202','Ubuntu 12.04','db202','6a7595531e47_','f330779435dfdockernet/mariadb-766646',202,212),(3585,'10.16.8.223','Docker Contianer:apache203','Ubuntu 12.04','apache203','6a7595531e47_','52d49e3044d2dockernet/mariadb-305720',203,212),(3586,'10.16.8.223','Docker Contianer:3g204','Ubuntu 12.04','3g204','6a7595531e47_','1fa6e364c06fdockernet/php221270',204,212),(3587,'10.16.8.223','Docker Contianer:3g205','Ubuntu 12.04','3g205','6a7595531e47_','80826f5ac8c5dockernet/mariadb-748646',205,212),(3588,'10.16.8.223','Docker Contianer:db206','Ubuntu 12.04','db206','6a7595531e47_','669e5bbd5196dockernet/mariadb-225149',206,212),(3589,'10.16.8.223','Docker Contianer:nginx207','Ubuntu 12.04','nginx207','6a7595531e47_','b3a135ac783bdockernet/php471643',207,212),(3590,'10.16.8.223','Docker Contianer:cache208','Ubuntu 12.04','cache208','6a7595531e47_','0f7d4184e594dockernet/mariadb-911938',208,212),(3591,'10.16.8.223','Docker Contianer:apache209','Ubuntu 12.04','apache209','6a7595531e47_','c59b2a24b3abdockernet/mariadb-233311',209,212),(3592,'10.16.8.223','Docker Contianer:apache210','Ubuntu 12.04','apache210','6a7595531e47_','53bb6489f25adockernet/568247',210,212),(3593,'10.16.8.223','Docker Contianer:apache211','Ubuntu 12.04','apache211','6a7595531e47_','b4fcdb5313b0dockernet/304742',211,212),(3594,'10.16.8.223','Docker Contianer:redis212','Ubuntu 12.04','redis212','6a7595531e47_','0f1031ae9cc3dockernet/php563386',212,212),(3595,'10.16.8.223','Docker Contianer:store213','Ubuntu 12.04','store213','6a7595531e47_','bdc25c4933105af44d967428',213,212),(3596,'10.16.8.223','Docker Contianer:redis214','Ubuntu 12.04','redis214','6a7595531e47_','b4bc05d3783ddockernet/m831655',214,212),(3597,'10.16.8.223','Docker Contianer:store215','Ubuntu 12.04','store215','6a7595531e47_','d4daf84258a25af44d222636',215,212),(3598,'10.16.8.223','Docker Contianer:redis216','Ubuntu 12.04','redis216','6a7595531e47_','88b3af647cfddockernet/php796356',216,212),(3599,'10.16.8.223','Docker Contianer:redis217','Ubuntu 12.04','redis217','6a7595531e47_','afb9bf194735dockernet/mariadb-949421',217,212),(3600,'10.16.8.223','Docker Contianer:redis218','Ubuntu 12.04','redis218','6a7595531e47_','ec35bc203c9cdockernet/m610307',218,212),(3601,'10.16.8.223','Docker Contianer:3g219','Ubuntu 12.04','3g219','6a7595531e47_','3ec18e29fde8dockernet/mariadb-164419',219,212),(3602,'10.16.8.223','Docker Contianer:store220','Ubuntu 12.04','store220','6a7595531e47_','c78fa1b995b35af44d435278',220,212),(3603,'10.16.8.223','Docker Contianer:app221','Ubuntu 12.04','app221','6a7595531e47_','e248ceb44db4dockernet/php406174',221,212),(3604,'10.16.8.223','Docker Contianer:3g222','Ubuntu 12.04','3g222','6a7595531e47_','b0e1e04f3c715af44d932769',222,212),(3605,'10.16.8.223','Docker Contianer:app223','Ubuntu 12.04','app223','6a7595531e47_','27c63dc40001dockernet/mariadb-712033',223,212),(3606,'10.16.8.223','Docker Contianer:db224','Ubuntu 12.04','db224','6a7595531e47_','76533ce61e2cdockernet/608261',224,212),(3607,'10.16.8.223','Docker Contianer:cache225','Ubuntu 12.04','cache225','6a7595531e47_','db6599b55befdockernet/669592',225,212),(3608,'10.16.8.223','Docker Contianer:app226','Ubuntu 12.04','app226','6a7595531e47_','9154d0c206bcdockernet/893298',226,212),(3609,'10.16.8.223','Docker Contianer:api227','Ubuntu 12.04','api227','6a7595531e47_','a2428c074b5cdockernet/php923127',227,212),(3610,'10.16.8.223','Docker Contianer:redis228','Ubuntu 12.04','redis228','6a7595531e47_','fd47ef96ce60dockernet/mariadb-790729',228,212),(3611,'10.16.8.223','Docker Contianer:nginx229','Ubuntu 12.04','nginx229','6a7595531e47_','de9fb2bbb207dockernet/732743',229,212),(3612,'10.16.8.223','Docker Contianer:api230','Ubuntu 12.04','api230','6a7595531e47_','568d99fd1532dockernet/php398970',230,212),(3613,'10.16.8.223','Docker Contianer:nginx231','Ubuntu 12.04','nginx231','6a7595531e47_','9330251b96e5dockernet/mariadb-427511',231,212),(3614,'10.16.8.223','Docker Contianer:db232','Ubuntu 12.04','db232','6a7595531e47_','462f48465cc3dockernet/mariadb-682508',232,212),(3615,'10.16.8.223','Docker Contianer:api233','Ubuntu 12.04','api233','6a7595531e47_','7f3f8975280e5af44d844657',233,212),(3616,'10.16.8.223','Docker Contianer:app234','Ubuntu 12.04','app234','6a7595531e47_','3e330ae9aa635af44d507242',234,212),(3617,'10.16.8.223','Docker Contianer:redis235','Ubuntu 12.04','redis235','6a7595531e47_','939aeeeaefc1dockernet/php617142',235,212),(3618,'10.16.8.223','Docker Contianer:apache236','Ubuntu 12.04','apache236','6a7595531e47_','e65a410777685af44d139459',236,212),(3619,'10.16.8.223','Docker Contianer:apache237','Ubuntu 12.04','apache237','6a7595531e47_','8966695d5894dockernet/php854230',237,212),(3620,'10.16.8.223','Docker Contianer:3g238','Ubuntu 12.04','3g238','6a7595531e47_','fa6dc63ddee15af44d229483',238,212),(3621,'10.16.8.223','Docker Contianer:nginx239','Ubuntu 12.04','nginx239','6a7595531e47_','1099f06a4763dockernet/php999705',239,212),(3622,'10.16.8.223','Docker Contianer:api240','Ubuntu 12.04','api240','6a7595531e47_','69a769bc979adockernet/php658058',240,212),(3623,'10.16.8.223','Docker Contianer:nginx241','Ubuntu 12.04','nginx241','6a7595531e47_','5771e424a3b4dockernet/543713',241,212),(3624,'10.16.8.223','Docker Contianer:redis242','Ubuntu 12.04','redis242','6a7595531e47_','f3174e57024edockernet/mariadb-139737',242,212),(3625,'10.16.8.223','Docker Contianer:api243','Ubuntu 12.04','api243','6a7595531e47_','3fb89be7c0eadockernet/php742962',243,212),(3626,'10.16.8.223','Docker Contianer:apache244','Ubuntu 12.04','apache244','6a7595531e47_','30f67cc388d1dockernet/php939747',244,212),(3627,'10.16.8.223','Docker Contianer:redis245','Ubuntu 12.04','redis245','6a7595531e47_','2d3872b44845dockernet/php672836',245,212),(3628,'10.16.8.223','Docker Contianer:nginx246','Ubuntu 12.04','nginx246','6a7595531e47_','34380dbfa02ddockernet/mariadb-577910',246,212),(3629,'10.16.8.223','Docker Contianer:nginx247','Ubuntu 12.04','nginx247','6a7595531e47_','fd991b3aa63b5af44d921670',247,212),(3630,'10.16.8.223','Docker Contianer:redis248','Ubuntu 12.04','redis248','6a7595531e47_','4c2399c8fa8cdockernet/mariadb-622093',248,212),(3631,'10.16.8.223','Docker Contianer:cache249','Ubuntu 12.04','cache249','6a7595531e47_','70b6924a646adockernet/php276414',249,212),(3632,'10.16.8.223','Docker Contianer:api250','Ubuntu 12.04','api250','6a7595531e47_','0a24e27bbaf4dockernet/php461636',250,212),(3633,'10.16.8.223','Docker Contianer:redis251','Ubuntu 12.04','redis251','6a7595531e47_','95b60129362bdockernet/php778129',251,212),(3634,'10.16.8.223','Docker Contianer:db252','Ubuntu 12.04','db252','6a7595531e47_','a1ff4f46de0cdockernet/mariadb-720844',252,212),(3635,'10.16.8.223','Docker Contianer:nginx253','Ubuntu 12.04','nginx253','6a7595531e47_','b0335838dd0bdockernet/mariadb-126064',253,212),(3636,'10.16.8.223','Docker Contianer:redis254','Ubuntu 12.04','redis254','6a7595531e47_','d268c47a8702dockernet/php605207',254,212),(3637,'10.16.8.223','Docker Contianer:cache255','Ubuntu 12.04','cache255','6a7595531e47_','59b1cfa8e482dockernet/m157025',255,212),(3638,'10.16.8.223','Docker Contianer:store256','Ubuntu 12.04','store256','6a7595531e47_','cc2cc3e2c79fdockernet/php544285',256,212);
/*!40000 ALTER TABLE `virtualserverinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `ip_addr` char(39) default NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) default NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2017-11-03 02:31:40','10.10.1.148','290','VirtualServerInfo object','change','修改 sys_hostname',20,4);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL auto_increment,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',4);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL auto_increment,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `xadmin_userwidget_user_id_c159233a` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-19 13:02:37
