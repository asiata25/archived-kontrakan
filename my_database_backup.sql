-- MySQL dump 10.13  Distrib 9.4.0, for Linux (aarch64)
--
-- Host: localhost    Database: pembukuan_kontrakan
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_fullname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `identity_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rental_block_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rental_block_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `entry_date` timestamp NOT NULL,
  `price` int NOT NULL,
  `deposit` int NOT NULL,
  `status` enum('paid','pending','debt','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `billing_month` timestamp NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_user_id_foreign` (`user_id`),
  KEY `invoices_rental_block_id_foreign` (`rental_block_id`),
  CONSTRAINT `invoices_rental_block_id_foreign` FOREIGN KEY (`rental_block_id`) REFERENCES `rental_blocks` (`id`),
  CONSTRAINT `invoices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES ('0025c1f5-b65b-3ea9-85eb-9349fc137435','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-06-17 23:19:06','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('008723a3-7fc2-390f-acbe-22e7a64f83ee','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-05-11 01:08:29','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('034c7646-e38c-3ba6-98f8-8db96ec6e870','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-06-26 21:26:37','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('044b22ec-efd9-3f82-aa7d-7f1770ef7765','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-07-18 19:51:27','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('044d0475-c987-3628-b642-f2c0ffbe2694','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-07-08 01:34:41','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('048ff286-3bd1-3929-a088-48b913376da5','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-07-19 05:38:28','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('04aeeb2d-23ae-30da-9c76-2847da8736a3','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-05-23 11:38:43','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('075d99b0-a3b1-3266-9969-8f7a8665de5a','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-06-18 11:16:23','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('07ef07de-36c8-3d50-aa77-102600ddf2d0','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'pending','2025-07-30 21:34:09','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('0929efff-2afb-335f-8b78-6839384ecb0e','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'pending','2025-06-09 11:14:31','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('0af2e391-92dd-34a1-8dde-3519014633af','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-06-03 22:55:12','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('0cc06698-0cac-33fc-bb55-47322b66dff1','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-05-19 18:41:35','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('15f25099-8dca-3346-8b22-67a3619aba76','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-07-03 06:11:17','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('1be5516b-4502-3748-a17c-5bbd78cc1dcf','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-08-07 02:46:19','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('1dd03745-25a9-3e38-937a-43d23d337e7c','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-05-23 19:28:37','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('2291275c-3e2f-3af0-971e-62d3403b81c9','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-05-26 08:40:25','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('232da507-ed89-340d-a5a6-29ea2bd36a60','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'pending','2025-07-08 07:03:06','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('2815f7f3-8fd0-350d-aac1-bbd371b279ff','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-07-11 10:32:05','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('2a2fc7be-37b8-3ac5-9434-f8c028b2870c','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,550000,'debt','2025-07-18 23:44:45','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('306dc5d0-00d2-3765-a8f4-182e72504560','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'pending','2025-06-15 10:58:33','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('3183b43d-8f18-3acd-91b8-dcfa7d50bdb3','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'pending','2025-07-12 15:07:35','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('33b5a1b7-e2bf-3093-b1f5-44f84287cb4b','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-06-11 07:07:40','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('35406a73-6e5a-361b-a30c-f66c2e57277b','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'pending','2025-05-24 05:29:53','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('37761142-cb31-3bb5-ac6d-488bf1962f28','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-07-05 00:55:19','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('3aa7d2ca-c684-33c9-bbca-b52f1adce2c8','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-27 08:04:30','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('4de9258d-a358-3e1d-b9af-acb821d304e6','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-07-30 19:55:43','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('54c2cf76-5812-3cea-9dbe-8c0563ec7a59','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-05-28 14:07:55','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('572c4448-36da-3169-b27a-677633d4e626','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,925000,'debt','2025-07-25 03:30:31','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('578f62a1-f89b-353f-9d92-ce86c9e564ec','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-06-16 08:23:54','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('5b23af77-7d43-31b7-9f6c-064419034890','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'pending','2025-05-13 08:59:40','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('5b251b87-7715-3e19-b6a1-976fb75313fb','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-06-01 06:28:39','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('5bddfc85-dde7-319a-a9f3-40491f3bf91d','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-07-07 19:33:09','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('5f8785a0-d82f-30fa-958a-43e22b6cd70f','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-06-11 14:59:01','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('61e0bdf3-8009-3fc5-a630-20c5667201cb','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-07-18 20:11:12','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('6295e5df-b03c-3758-a805-363141e3ea81','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-05-23 19:50:59','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('632485aa-b084-336a-b291-b96c7e0067d9','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-12 21:16:42','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('6697c774-8f39-3a1f-9825-b8ffce0fd94a','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-27 17:37:38','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('6c99b70c-0524-3b0e-8260-bcb3bdd0db14','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-06-15 02:11:51','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('72d61670-761a-3c4e-9978-05badf76a257','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-06-18 16:45:20','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('767f9b1b-2b8d-3a69-9c2c-b3c080fbf453','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'pending','2025-07-25 04:31:09','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('7d9d66be-1160-37d5-922b-2a1e73ae76be','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-06-13 21:33:42','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('834e2031-2ba2-32d0-895d-c8b613c491b4','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,1150000,'debt','2025-06-26 02:31:02','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('8533d4ff-ec79-3978-b227-7abe9e4aa38e','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'pending','2025-06-12 15:33:39','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('859de187-ca2d-3c97-b06e-770522280b65','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-05-31 15:37:03','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('874453c0-50b3-3586-bce4-14e777f3b120','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'pending','2025-05-16 13:48:31','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('894ecab8-8118-31f4-a0e6-9014c80acbbe','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-07-22 19:43:45','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('8de1cf73-395b-3232-b0fd-a53111bf986a','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'pending','2025-06-18 21:12:08','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('905af6eb-db75-3d32-aa7f-c579ee570c5b','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'pending','2025-05-22 09:44:07','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('96a64e99-193c-3a5a-b1d6-5bbf9fe0bbae','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'pending','2025-06-08 02:09:18','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('9904930d-dfcd-38ea-9aed-1202e5d97a94','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-06-22 07:53:09','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('9d3179b4-1e89-3244-b1a2-a4fc76cf990f','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-07-18 02:48:29','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('9d86f0f4-c3b6-38c7-979f-06e994471e6c','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-29 04:31:33','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a2bb242a-09e5-3cfd-9e03-e3b9a2c9bda9','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'pending','2025-07-03 12:55:44','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a4caf21b-5b9d-3d15-ba06-6843005de7a1','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-06-24 04:53:20','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a4fb291d-7599-30cd-a730-2848f7a819a4','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-03 04:35:44','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a6b4383c-fafc-3c87-b15b-478357e57dc2','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-06-12 02:22:16','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a86f820d-a1d6-38fc-96a6-fd63bfe70ed7','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-06-29 14:26:07','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('a9f5150b-aa93-3b61-956f-876bcbd7b1e2','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,400000,'debt','2025-06-14 06:28:27','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('aa9f0464-251a-39e3-b479-89cc843d3481','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-07-31 01:35:51','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('adb08498-f839-35c9-ade3-34648e661e09','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-06-01 02:40:51','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('b043a912-b3a7-3480-88b9-661a5b1fd5e8','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'pending','2025-07-14 09:38:55','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('b7ddd0f0-35a3-385f-a280-ed94ec64e297','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-06-13 09:52:40','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('b8c56e3a-078d-3b6f-8e7a-4454c550ab0e','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-06-02 10:13:39','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('bbfb0501-a451-33f8-a63a-dcaec2cd5274','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-05-28 16:59:40','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('be324ea3-d4ee-3d95-b454-8fcca6eb0c1b','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'pending','2025-06-29 23:59:21','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('c69cecfe-55a7-3bbb-97cc-7d0b25d7cc5b','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'pending','2025-05-24 14:32:41','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cbe9c0e9-47d9-3522-a0a8-bf853b42400c','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'pending','2025-06-01 00:33:39','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cbfaa426-b491-324d-9912-7aaf85b91086','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,475000,'debt','2025-08-04 22:57:38','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cd286707-954f-3297-934a-c594fd37513f','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-08-05 17:36:54','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cecbcffe-f6fe-31aa-88ca-6762ad76cba8','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-05-07 13:13:45','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cee0ff63-7c9e-30f0-898f-42d6a6978df0','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-06-18 17:54:19','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('d1339999-baf7-3288-8d16-e6f5b45ae74d','22278895-09b5-3b60-8a78-23dea2c8e408','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051','2025-05-28 05:06:21',2300000,2300000,'paid','2025-06-07 03:36:31','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('d475daf7-382b-3486-8b8f-1162030680ca','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-07-20 10:09:50','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('d49928d7-1377-33f8-8c59-20e5a4c934a1','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-05-17 07:03:39','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('d5622167-b9a9-3c3c-aa1b-5e4b260116cf','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,775000,'debt','2025-07-12 17:29:41','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('da14c8ae-1443-3e9b-b8e8-bbe898ee6f42','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'pending','2025-07-17 07:35:58','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('da985fef-7824-38a1-94e5-d3a48dafc009','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'pending','2025-07-27 19:29:11','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('dd10bcb4-c47f-3707-92ed-269d5d3aa754','387c64a5-cc35-300d-bbd8-4969f86e0dee','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237','2025-05-19 22:24:38',1550000,1550000,'paid','2025-06-15 05:53:27','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('dde9fccf-03e9-3397-9fb4-4780355a2c82','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-05-25 12:38:14','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('e0a27ba3-392f-344b-8e86-d1179cd1e024','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-06-02 04:19:12','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('e4f71f44-9040-37e1-8341-afcb4eb916a0','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-07-26 12:50:17','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('e83a789f-20d1-35cf-a878-c52b312318f0','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-07-13 15:20:20','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('e91fd7e6-40ea-3b55-b5cb-372070a8f934','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,1850000,'paid','2025-07-09 18:40:11','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('e9d54d92-0a64-33c4-90bc-66528b8c9418','e320958c-0ebf-3f89-82c4-70a73fef5931','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544','2025-05-24 14:03:07',1850000,925000,'debt','2025-07-12 02:31:37','harap segera melunasi pemayaran','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('ed762844-7fde-3e23-be35-bd4f74dc69bf','eb9934a3-f147-3bae-bb55-40bbb9601410','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','eec50d89-7893-312c-b08d-0810e731abfa','BLK-097','2025-06-06 12:46:13',1850000,1850000,'paid','2025-06-22 21:48:11','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('ef01f3be-e1c9-3172-b299-a43589625eef','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'pending','2025-07-30 10:35:29','menunggu untuk ditinjau oleh admin','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('f28a1177-ff97-3f31-9762-3e76d1000bd7','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-06-25 01:19:08','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('f6c5eaca-1139-3c55-a2e4-88a4aa90dd30','77394aad-5c4f-3f4d-8b13-acb08b99a898','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091','2025-06-02 02:15:35',800000,800000,'paid','2025-06-03 03:11:29','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('fc833f06-1470-3d16-b0a5-70b22c8e0944','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-06-03 01:16:47','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('fe424e73-6a33-3ad6-818e-cbf5c4ec9e75','1cca430b-c8b8-34f3-984d-6dcd59f8729c','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090','2025-07-19 22:18:26',950000,950000,'paid','2025-06-04 05:27:34','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('ff0b08dd-50f7-3d69-bcba-8ced01f4a462','5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359','2025-06-17 21:25:58',1100000,1100000,'paid','2025-07-25 14:22:50','pembayaran telah lunas','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL);
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2025_07_10_144314_create_rental_blocks_table_and_invoices',1),(5,'2025_07_11_141738_create_receipts_table',1),(6,'2025_07_11_143727_create_personal_access_tokens_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipts`
--

DROP TABLE IF EXISTS `receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipts` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` timestamp NOT NULL,
  `amount` int NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `receipts_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `receipts_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipts`
--

LOCK TABLES `receipts` WRITE;
/*!40000 ALTER TABLE `receipts` DISABLE KEYS */;
INSERT INTO `receipts` VALUES ('00369a8a-1a88-3630-af78-621b8095c4df','0af2e391-92dd-34a1-8dde-3519014633af','2025-08-01 23:55:19',505332,'http://price.com/non-debitis-odit-molestias-cumque.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('05e2c25b-bc90-316e-b5a9-52c12650ddd7','008723a3-7fc2-390f-acbe-22e7a64f83ee','2025-08-05 12:57:14',942783,'https://www.mckenzie.com/saepe-qui-nisi-iste-corporis-ut-nihil-voluptate','2025-08-07 09:49:54','2025-08-07 09:49:54'),('0b704143-8176-3bfa-9c55-b9064fd0a7b9','3183b43d-8f18-3acd-91b8-dcfa7d50bdb3','2025-08-03 23:41:16',1461608,'http://www.johns.com/quam-et-necessitatibus-aut-animi-ut-et','2025-08-07 09:49:54','2025-08-07 09:49:54'),('11881c44-2faa-3a58-9e39-18b22b1b7f7b','9d86f0f4-c3b6-38c7-979f-06e994471e6c','2025-08-02 08:56:21',885501,'http://www.turner.org/magni-pariatur-odit-commodi-voluptatem-molestiae-quo-provident','2025-08-07 09:49:54','2025-08-07 09:49:54'),('1300c0db-9706-3862-a01a-177b158f48e4','5b23af77-7d43-31b7-9f6c-064419034890','2025-08-02 18:19:38',1143020,'http://rowe.biz/blanditiis-est-ducimus-quo-dolores-assumenda-et','2025-08-07 09:49:54','2025-08-07 09:49:54'),('14f14252-f39d-3db0-bfcd-fcd833c3f562','61e0bdf3-8009-3fc5-a630-20c5667201cb','2025-08-01 20:18:58',812581,'http://okeefe.net/tempora-dolore-quo-velit-nam.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('15da438b-94eb-3853-bb63-501cfa4bd327','54c2cf76-5812-3cea-9dbe-8c0563ec7a59','2025-08-06 10:36:20',2371872,'https://www.weissnat.com/blanditiis-enim-sed-eos-dicta','2025-08-07 09:49:54','2025-08-07 09:49:54'),('1f56cbcc-aa8f-3206-bf61-3e5be0bfd31c','894ecab8-8118-31f4-a0e6-9014c80acbbe','2025-07-31 13:19:10',684140,'https://www.nader.net/porro-amet-maiores-rerum-velit-quasi-quam','2025-08-07 09:49:54','2025-08-07 09:49:54'),('209330da-f5a5-3884-805d-d9c3916c6b45','e9d54d92-0a64-33c4-90bc-66528b8c9418','2025-08-03 15:08:01',925000,'http://hegmann.com/magni-commodi-hic-quos-illo-modi-sed','2025-08-07 09:49:54','2025-08-07 09:49:54'),('267e9590-9a92-3226-b660-45872e8446b3','0929efff-2afb-335f-8b78-6839384ecb0e','2025-08-02 19:46:26',1159975,'http://koelpin.net/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('2781d9d3-2b24-3f2f-a33f-2a744bc2727c','a4caf21b-5b9d-3d15-ba06-6843005de7a1','2025-08-05 23:13:33',529866,'http://www.gleason.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('2cb57b0b-2728-35a1-8390-42a50a108936','96a64e99-193c-3a5a-b1d6-5bbf9fe0bbae','2025-08-04 13:02:32',542138,'http://www.prohaska.info/quia-libero-consequatur-doloribus','2025-08-07 09:49:54','2025-08-07 09:49:54'),('3358c9e3-8823-3b05-9975-ce84c77d10f8','034c7646-e38c-3ba6-98f8-8db96ec6e870','2025-07-31 11:18:24',824336,'http://www.christiansen.com/adipisci-eum-praesentium-minima-qui-nesciunt-veritatis-unde.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('34257e74-812e-36fc-a417-44f02c53606f','a2bb242a-09e5-3cfd-9e03-e3b9a2c9bda9','2025-08-01 14:23:11',1953776,'http://www.feest.org/dolorem-ducimus-nihil-eos-nihil-similique-omnis-autem-possimus.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('40837a63-fd83-33f6-9981-827b95580b7a','e83a789f-20d1-35cf-a878-c52b312318f0','2025-08-01 16:45:24',1484891,'http://pouros.info/nihil-sed-saepe-sit-fuga-voluptates-voluptatem.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('46958d01-098c-37d7-81ae-b06773d5ce67','044d0475-c987-3628-b642-f2c0ffbe2694','2025-08-01 13:41:06',536344,'https://murazik.com/perspiciatis-et-quis-commodi.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('4d2867ba-5359-32cf-b94f-a4dec1a563ec','9d3179b4-1e89-3244-b1a2-a4fc76cf990f','2025-08-06 12:20:08',1418930,'https://www.muller.com/et-amet-mollitia-nisi-inventore-corporis-debitis','2025-08-07 09:49:54','2025-08-07 09:49:54'),('4e245e66-174c-3118-9a25-451b5b7d3cb2','cee0ff63-7c9e-30f0-898f-42d6a6978df0','2025-08-03 00:46:06',911425,'https://vandervort.com/ut-ab-velit-blanditiis-exercitationem-ex-fugiat-vero.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('4fbe5b96-e062-32ec-ad1e-c5aecc47da81','b7ddd0f0-35a3-385f-a280-ed94ec64e297','2025-08-01 10:47:20',1435857,'http://www.ritchie.org/deleniti-voluptatem-qui-quae-quasi-delectus-et-praesentium','2025-08-07 09:49:54','2025-08-07 09:49:54'),('4fd08a72-3b2f-3dd7-8e55-06a816d3250e','2815f7f3-8fd0-350d-aac1-bbd371b279ff','2025-08-06 23:33:19',982955,'http://www.cassin.net/praesentium-quae-necessitatibus-hic-debitis','2025-08-07 09:49:54','2025-08-07 09:49:54'),('513398b6-3b53-3fe5-846d-6d27be1148b9','04aeeb2d-23ae-30da-9c76-2847da8736a3','2025-08-07 04:03:47',2091590,'https://mohr.biz/voluptas-culpa-officiis-illum-dolorum-quos.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('56191ebe-7e06-3abe-b69d-74b43a7f42db','044b22ec-efd9-3f82-aa7d-7f1770ef7765','2025-07-31 17:16:21',2010018,'http://www.feil.biz/commodi-repudiandae-ducimus-quaerat-consectetur','2025-08-07 09:49:54','2025-08-07 09:49:54'),('5bd4432f-28ad-3623-9bb2-e8cf73e93ad0','1dd03745-25a9-3e38-937a-43d23d337e7c','2025-08-01 09:22:11',1333108,'http://goyette.com/sit-odio-est-ut','2025-08-07 09:49:54','2025-08-07 09:49:54'),('612b81af-d4d9-3348-bd8c-ef02cb6b7659','8533d4ff-ec79-3978-b227-7abe9e4aa38e','2025-08-04 03:30:49',588353,'http://macejkovic.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('62c55326-c707-3be9-9e5e-d860aea4a051','bbfb0501-a451-33f8-a63a-dcaec2cd5274','2025-08-04 03:20:32',1895516,'https://cole.com/vero-magni-ut-totam-molestias.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('652218ff-7e04-31ea-a6f6-91bb958c3f9e','da14c8ae-1443-3e9b-b8e8-bbe898ee6f42','2025-08-01 00:38:38',1694751,'http://www.borer.com/distinctio-quo-nemo-sit-accusamus-eaque-pariatur-ad.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('67cbbab6-e541-37aa-a42f-690ef53e67e7','cbe9c0e9-47d9-3522-a0a8-bf853b42400c','2025-08-04 15:41:14',641889,'http://www.schaefer.org/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('6b049ba7-8ad4-348c-833f-74e7f4e34e53','075d99b0-a3b1-3266-9969-8f7a8665de5a','2025-08-07 08:55:35',697415,'https://www.rowe.com/quae-eius-aliquam-quia-provident-dignissimos','2025-08-07 09:49:54','2025-08-07 09:49:54'),('6bbbe8f7-db6b-31c7-ac6a-45dfbdefdaa6','767f9b1b-2b8d-3a69-9c2c-b3c080fbf453','2025-08-03 11:43:39',1795914,'http://www.hayes.com/incidunt-repudiandae-asperiores-harum','2025-08-07 09:49:54','2025-08-07 09:49:54'),('6f7fe67f-a9c7-3025-8eab-bc2ac3572310','7d9d66be-1160-37d5-922b-2a1e73ae76be','2025-08-04 03:28:45',2114320,'http://www.schaden.info/recusandae-ad-assumenda-doloremque-tempora-doloremque','2025-08-07 09:49:54','2025-08-07 09:49:54'),('70a68959-b541-3a6d-abc8-ecf36ab61837','a9f5150b-aa93-3b61-956f-876bcbd7b1e2','2025-08-05 13:35:16',400000,'https://powlowski.net/ut-nobis-nihil-quam-qui-neque-ad-nulla.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('718ff3a8-8fc7-3d1f-be1b-74a76ffa5288','be324ea3-d4ee-3d95-b454-8fcca6eb0c1b','2025-08-05 09:49:31',900509,'https://williamson.biz/corporis-consequatur-et-odit-natus-quia-corrupti-expedita.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('72deb97a-4d47-3a79-98b0-28b5eb3a7b0a','adb08498-f839-35c9-ade3-34648e661e09','2025-07-31 19:41:54',1372300,'http://torphy.com/dolor-dolore-accusamus-voluptatem-aut-a','2025-08-07 09:49:54','2025-08-07 09:49:54'),('73f2b4e5-758a-3dbb-afde-12f0a5292ed7','fe424e73-6a33-3ad6-818e-cbf5c4ec9e75','2025-08-02 02:57:26',1015611,'http://www.homenick.com/tempora-ipsum-facilis-similique','2025-08-07 09:49:54','2025-08-07 09:49:54'),('74764508-575c-3055-a4d0-2a13acfc775b','4de9258d-a358-3e1d-b9af-acb821d304e6','2025-08-04 05:55:44',1243327,'http://www.anderson.com/ea-quasi-aut-cum.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('7963eb84-4b0d-39e2-a093-af4171aeb0b9','1be5516b-4502-3748-a17c-5bbd78cc1dcf','2025-08-01 14:29:00',1595816,'http://howell.com/quos-aut-totam-eum-culpa-quis.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('7b4db1f3-a585-3f34-9cda-5ffeba2aa5e8','e91fd7e6-40ea-3b55-b5cb-372070a8f934','2025-08-03 13:38:21',1204486,'http://www.collier.org/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('7cfb860f-938b-3e37-9ecd-635aae3c35e6','37761142-cb31-3bb5-ac6d-488bf1962f28','2025-08-02 11:42:52',1001586,'http://morissette.biz/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('7ec01650-45a1-3eea-bdfa-84634a94b7e3','8de1cf73-395b-3232-b0fd-a53111bf986a','2025-08-04 12:41:38',1103326,'http://www.bode.org/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('7f8d28f7-c66c-3d28-8df8-4e290225004c','3aa7d2ca-c684-33c9-bbca-b52f1adce2c8','2025-08-04 08:56:17',1641987,'https://parker.org/nam-et-recusandae-cumque-voluptatem-dolorum-expedita-ut-et.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('8118442e-7084-3182-bbd2-04de66314716','a6b4383c-fafc-3c87-b15b-478357e57dc2','2025-08-01 05:24:14',1401203,'http://friesen.info/animi-exercitationem-ea-molestiae-neque-et-est-et-iusto','2025-08-07 09:49:54','2025-08-07 09:49:54'),('81f11edf-0f2d-37b0-b6c4-e4b06171c716','b8c56e3a-078d-3b6f-8e7a-4454c550ab0e','2025-08-06 14:13:31',860325,'https://www.jacobi.com/odio-numquam-sunt-aut-est-culpa-possimus-cum','2025-08-07 09:49:54','2025-08-07 09:49:54'),('86f59669-fc96-3e8b-9e02-58a2fb3d26ca','07ef07de-36c8-3d50-aa77-102600ddf2d0','2025-08-05 14:19:07',1730914,'http://dach.com/veritatis-ea-qui-assumenda','2025-08-07 09:49:54','2025-08-07 09:49:54'),('86fa6643-92ac-337f-9fd4-6e661ade7568','da985fef-7824-38a1-94e5-d3a48dafc009','2025-08-01 10:06:48',2360541,'http://www.schneider.com/ducimus-tempora-aut-sit-et-maiores','2025-08-07 09:49:54','2025-08-07 09:49:54'),('88d2d1e2-dcb5-3d7b-8736-2169636dbb90','fc833f06-1470-3d16-b0a5-70b22c8e0944','2025-08-04 20:47:31',902878,'http://www.miller.net/harum-et-dolore-et-omnis-omnis.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('897e937b-31ae-3628-9564-7a1ec8e9ddd4','874453c0-50b3-3586-bce4-14e777f3b120','2025-08-05 03:08:37',1149346,'http://kautzer.info/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('8f385a43-bc32-3194-a70c-a661dd589f88','632485aa-b084-336a-b291-b96c7e0067d9','2025-08-01 07:40:58',663152,'https://pfeffer.net/enim-suscipit-perspiciatis-est.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('94235c5a-92e9-3602-87e6-6e5226c6f75c','d1339999-baf7-3288-8d16-e6f5b45ae74d','2025-08-02 03:15:21',2323714,'https://hahn.com/impedit-rerum-qui-error-maxime-in-rerum-dicta.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('9b2135bf-ae8c-38d8-97ec-1d24f7b8cbdb','232da507-ed89-340d-a5a6-29ea2bd36a60','2025-08-01 04:48:32',1763008,'http://www.huels.net/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('9b7ab615-2ce2-30cb-9d69-849c6d016af4','d475daf7-382b-3486-8b8f-1162030680ca','2025-08-01 02:02:40',1358113,'http://www.gaylord.com/non-blanditiis-et-itaque-quia','2025-08-07 09:49:54','2025-08-07 09:49:54'),('9b934b91-c9ed-3160-ab71-e67c662615ce','6295e5df-b03c-3758-a805-363141e3ea81','2025-08-05 01:39:45',1375753,'http://www.mayert.com/perferendis-nostrum-veniam-sequi-inventore-architecto-optio','2025-08-07 09:49:54','2025-08-07 09:49:54'),('a45daf9f-bb04-3f27-b908-a7942218a3e3','cbfaa426-b491-324d-9912-7aaf85b91086','2025-08-04 09:10:08',475000,'http://towne.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('a536805c-7cfc-347b-9544-e6033d255908','72d61670-761a-3c4e-9978-05badf76a257','2025-08-05 14:36:36',1753660,'http://www.little.com/quas-corporis-ut-animi-exercitationem-saepe-harum-occaecati-quia.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('acba60c6-9f46-30f9-bf6f-0c834623ca66','5bddfc85-dde7-319a-a9f3-40491f3bf91d','2025-08-04 04:12:43',1945839,'http://oberbrunner.com/laborum-eum-quod-mollitia-iusto-magnam.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('ad4a6810-4d93-39f5-8476-3fcbeef60413','d5622167-b9a9-3c3c-aa1b-5e4b260116cf','2025-08-05 01:34:06',775000,'http://kerluke.info/in-repellendus-ipsum-optio-et','2025-08-07 09:49:54','2025-08-07 09:49:54'),('ad535839-b750-3e15-8962-8b07bb701cb1','e0a27ba3-392f-344b-8e86-d1179cd1e024','2025-08-03 02:38:40',659300,'https://www.romaguera.org/tempore-voluptate-assumenda-corporis-sunt-velit-facere-quos','2025-08-07 09:49:54','2025-08-07 09:49:54'),('ae8c79ec-0103-3d6b-b63e-ae6d41d02d14','306dc5d0-00d2-3765-a8f4-182e72504560','2025-08-06 10:37:46',2312922,'http://feil.com/eum-tempora-excepturi-ut-temporibus-blanditiis-maiores-rem','2025-08-07 09:49:54','2025-08-07 09:49:54'),('aed301d4-4626-36f5-834d-cdc8a75a50ff','048ff286-3bd1-3929-a088-48b913376da5','2025-08-04 00:04:37',903699,'http://www.abshire.org/libero-blanditiis-et-velit-voluptatibus-sit-nemo.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('b14889fb-e341-392c-b9d3-b41c2a9be266','f28a1177-ff97-3f31-9762-3e76d1000bd7','2025-08-06 11:33:33',518701,'http://www.halvorson.com/enim-facere-laborum-doloribus-nam-aut.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('b3f60085-d3fa-308c-8549-4b1b01f2b1fe','35406a73-6e5a-361b-a30c-f66c2e57277b','2025-08-02 08:00:04',1813462,'http://larson.com/est-occaecati-molestiae-sit-necessitatibus-est-porro-autem','2025-08-07 09:49:54','2025-08-07 09:49:54'),('b98fb0d3-d898-3e5a-97e6-53a634f77c5f','33b5a1b7-e2bf-3093-b1f5-44f84287cb4b','2025-08-06 23:13:41',685568,'http://www.hintz.org/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bb1526ac-63d2-3d03-9700-69a92d3d9180','dd10bcb4-c47f-3707-92ed-269d5d3aa754','2025-08-04 17:16:41',1471876,'http://www.okeefe.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bd134f7c-6252-31aa-9c97-114caa4ac5ce','dde9fccf-03e9-3397-9fb4-4780355a2c82','2025-08-06 10:44:26',1044267,'https://www.purdy.com/at-fuga-consequuntur-unde-nam-sed-necessitatibus-ut','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bd6baa3e-fdc8-3306-88a8-0370e778153e','578f62a1-f89b-353f-9d92-ce86c9e564ec','2025-07-31 17:55:34',715799,'http://walter.com/sit-harum-quia-odit-neque','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bdd4305a-cd1a-33a4-8a8e-e0e32cebc6ce','9904930d-dfcd-38ea-9aed-1202e5d97a94','2025-08-07 07:33:17',876471,'http://feil.info/assumenda-quod-aliquam-necessitatibus-quisquam-voluptatibus','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bdfb9858-b031-3ff2-8d68-1d9a7a70093f','aa9f0464-251a-39e3-b479-89cc843d3481','2025-08-05 07:07:07',2282523,'https://www.kuphal.com/placeat-velit-officiis-omnis-mollitia-enim-nihil-in-illum','2025-08-07 09:49:54','2025-08-07 09:49:54'),('bf41437b-dff3-3bc2-8bfe-ece48b1d1b8b','6697c774-8f39-3a1f-9825-b8ffce0fd94a','2025-08-05 11:48:58',1496853,'https://www.wuckert.com/alias-in-unde-praesentium-ut-ipsa-repudiandae-atque','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c0bbe78c-ea83-3ee1-a2a0-4c24301cb6be','b043a912-b3a7-3480-88b9-661a5b1fd5e8','2025-08-02 14:38:44',703611,'http://www.aufderhar.com/ullam-id-dolores-quisquam','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c154e20e-71e9-3f64-b966-8b9bcb817aa1','cd286707-954f-3297-934a-c594fd37513f','2025-08-02 19:48:16',771404,'http://www.shields.biz/accusantium-cupiditate-cumque-quasi-magnam-illum-explicabo-quia','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c361fe7c-51b4-33d0-8f6a-b7baf838afb7','c69cecfe-55a7-3bbb-97cc-7d0b25d7cc5b','2025-08-05 02:57:18',1960611,'https://www.emard.biz/necessitatibus-magni-et-nesciunt-soluta-qui-quia-culpa-nam','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c3fc3b2e-577e-34ba-8339-0250cf4617ce','905af6eb-db75-3d32-aa7f-c579ee570c5b','2025-08-01 13:53:01',2029904,'http://flatley.com/animi-adipisci-suscipit-et-architecto','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c4d66dd5-f222-34a7-988c-80a7070ea295','0cc06698-0cac-33fc-bb55-47322b66dff1','2025-08-07 08:31:34',2196268,'http://www.padberg.net/adipisci-et-nisi-sit-quae','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c696cc3c-1ab3-33bd-ab41-0cc7186ca49d','d49928d7-1377-33f8-8c59-20e5a4c934a1','2025-07-31 13:00:00',1778761,'http://watsica.com/illum-omnis-reprehenderit-quia-quasi-fugiat-quas-quidem.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c6fdc077-ff0b-3f6e-a8d1-f83584bc79cd','2291275c-3e2f-3af0-971e-62d3403b81c9','2025-08-03 15:01:31',2002680,'http://www.johnston.org/ea-voluptatem-doloremque-excepturi-repudiandae-voluptatem-doloribus-esse.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c76230e5-9fd6-3843-b89e-7abaa7b24f91','572c4448-36da-3169-b27a-677633d4e626','2025-08-03 11:25:51',925000,'http://www.stanton.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('c83047e7-dcf8-3af4-a65a-41c5436b994a','5f8785a0-d82f-30fa-958a-43e22b6cd70f','2025-08-01 02:13:52',2177381,'http://www.murphy.org/aliquam-quia-quia-magni-quod-et-nobis-eum','2025-08-07 09:49:54','2025-08-07 09:49:54'),('cddd4e2d-e8d9-3008-86c2-4dafe9df42be','a4fb291d-7599-30cd-a730-2848f7a819a4','2025-08-03 06:45:15',830659,'http://www.bogan.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('d0b3b9c3-ae4d-3a3d-96c3-04f4c26150d0','cecbcffe-f6fe-31aa-88ca-6762ad76cba8','2025-08-06 02:01:38',843306,'http://www.rice.net/dolore-cumque-iusto-nostrum-voluptatem-asperiores','2025-08-07 09:49:54','2025-08-07 09:49:54'),('d6046f53-4d83-3e0a-a009-58307a3d00df','e4f71f44-9040-37e1-8341-afcb4eb916a0','2025-08-05 02:30:37',1619990,'http://www.marquardt.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('dacb7929-1ad1-3ba5-b304-eff7a9653258','ff0b08dd-50f7-3d69-bcba-8ced01f4a462','2025-08-04 18:50:56',1583101,'http://mccullough.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('db9faac6-42c4-3506-920e-4dcb057576e6','859de187-ca2d-3c97-b06e-770522280b65','2025-08-01 13:54:43',1125339,'http://huel.com/quos-eligendi-enim-aut-aut-at-sed-doloribus-id','2025-08-07 09:49:54','2025-08-07 09:49:54'),('e5ce3e54-8456-3e1d-95e4-0056f9523db4','f6c5eaca-1139-3c55-a2e4-88a4aa90dd30','2025-08-06 06:00:23',711104,'http://www.damore.biz/ut-doloremque-voluptatem-rerum-aut','2025-08-07 09:49:54','2025-08-07 09:49:54'),('eaa23732-7454-3e79-9d35-a6022961ce9d','834e2031-2ba2-32d0-895d-c8b613c491b4','2025-08-04 20:53:28',1150000,'http://www.simonis.com/quia-velit-aut-veniam-aut-possimus-libero','2025-08-07 09:49:54','2025-08-07 09:49:54'),('ee513246-0ead-370f-8764-9f437e00fe17','2a2fc7be-37b8-3ac5-9434-f8c028b2870c','2025-08-05 01:47:56',550000,'http://www.lang.com/ullam-eos-iste-quo-ea-magni-doloribus-qui.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('ef2c2264-250c-3744-b905-c1a858a354fb','ed762844-7fde-3e23-be35-bd4f74dc69bf','2025-08-07 06:27:11',2308513,'http://www.west.com/suscipit-iure-non-qui-voluptate-officia-rerum-doloribus.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('f022c5fb-ef3b-3867-8923-2c076894e562','5b251b87-7715-3e19-b6a1-976fb75313fb','2025-07-31 14:41:59',1392549,'https://franecki.org/ratione-facere-provident-aut-voluptatem-aspernatur-similique-et.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('f420477e-f219-3709-acb1-c5be10b53105','ef01f3be-e1c9-3172-b299-a43589625eef','2025-08-01 21:42:27',1282059,'http://www.sporer.org/sit-aut-eos-aliquam-quasi-explicabo-natus-numquam-quia','2025-08-07 09:49:54','2025-08-07 09:49:54'),('f51e265d-31cb-3359-8006-d24e3d478525','a86f820d-a1d6-38fc-96a6-fd63bfe70ed7','2025-08-04 00:57:02',605053,'http://www.kirlin.com/','2025-08-07 09:49:54','2025-08-07 09:49:54'),('f6ed1dd6-a74d-317f-861e-78c4120fcb3e','15f25099-8dca-3346-8b22-67a3619aba76','2025-08-01 17:04:03',626453,'http://weimann.com/dolorem-quis-enim-qui-facilis-expedita.html','2025-08-07 09:49:54','2025-08-07 09:49:54'),('f77683a9-6bb9-3111-94b1-522e88cac988','6c99b70c-0524-3b0e-8260-bcb3bdd0db14','2025-07-31 11:36:32',2046657,'http://www.dibbert.com/tenetur-quia-quis-accusantium','2025-08-07 09:49:54','2025-08-07 09:49:54'),('fb5b7b08-0995-3557-ac75-fe1dc406a58f','0025c1f5-b65b-3ea9-85eb-9349fc137435','2025-08-05 13:12:40',2407367,'http://wolf.net/','2025-08-07 09:49:54','2025-08-07 09:49:54');
/*!40000 ALTER TABLE `receipts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rental_blocks`
--

DROP TABLE IF EXISTS `rental_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rental_blocks` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rental_blocks_user_id_unique` (`user_id`),
  CONSTRAINT `rental_blocks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_blocks`
--

LOCK TABLES `rental_blocks` WRITE;
/*!40000 ALTER TABLE `rental_blocks` DISABLE KEYS */;
INSERT INTO `rental_blocks` VALUES ('15c8a5cc-264e-342e-8936-a2cd66389e95','BLK-051',2300000,'22278895-09b5-3b60-8a78-23dea2c8e408','2025-05-28 05:06:21','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('1d938311-dd40-3518-99ac-a0260ffada66','BLK-808',2450000,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54','2025-08-06 09:49:54'),('72211b2d-af76-3e56-8c94-cbd0cf9dcd5d','BLK-359',1100000,'5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','2025-06-17 21:25:58','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('88853ff0-78f4-3a0e-93a7-2f23b7e32957','BLK-079',1700000,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('acbe5986-ee12-35de-9d24-62df13582cb3','BLK-049',1250000,'ae285eb9-51e4-3e8c-922a-8ba2ef99dd47','2025-07-26 20:14:46','2025-08-07 09:49:55','2025-08-07 09:49:55',NULL),('b1c70f8f-b2da-37ad-8b41-5b4f3b2c90fe','BLK-544',1850000,'e320958c-0ebf-3f89-82c4-70a73fef5931','2025-05-24 14:03:07','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('bd2c7324-d540-36ec-940a-19e88813048f','BLK-996',800000,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54','2025-08-06 09:49:54'),('bf7c946d-5487-36c8-8134-2d32b6263ea9','BLK-091',800000,'77394aad-5c4f-3f4d-8b13-acb08b99a898','2025-06-02 02:15:35','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('c8a0d1ab-0885-3923-bcdc-16b1a206043f','BLK-090',950000,'1cca430b-c8b8-34f3-984d-6dcd59f8729c','2025-07-19 22:18:26','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cae5afa9-5257-3485-a765-22db0d5c875a','BLK-963',2150000,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('cbd34857-6932-3f67-85be-836086f3d3d3','BLK-237',1550000,'387c64a5-cc35-300d-bbd8-4969f86e0dee','2025-05-19 22:24:38','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL),('eec50d89-7893-312c-b08d-0810e731abfa','BLK-097',1850000,'eb9934a3-f147-3bae-bb55-40bbb9601410','2025-06-06 12:46:13','2025-08-07 09:49:54','2025-08-07 09:49:54',NULL);
/*!40000 ALTER TABLE `rental_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `fullname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `identity_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `identity_image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('1cca430b-c8b8-34f3-984d-6dcd59f8729c','marlene31','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Jelita Maya Pudjiastuti M.Pd','984 Lisette Village\nPort Christina, HI 55175','3506351762122198','087997775808','https://via.placeholder.com/640x480.png/006655?text=eum',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('217a8056-7945-3230-823a-7e97d325f996','sarah.sanford','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user',NULL,NULL,NULL,NULL,NULL,'2025-08-06 09:49:55',NULL,'2025-08-07 09:49:55','2025-08-07 09:49:55'),('22278895-09b5-3b60-8a78-23dea2c8e408','murray.rafaela','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Najwa Almira Maryati S.T.','10337 Verona Spur Apt. 116\nSouth Peter, MA 77430','3506655969056588','086754455006','https://via.placeholder.com/640x480.png/00ff33?text=occaecati',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('387c64a5-cc35-300d-bbd8-4969f86e0dee','fiona.vandervort','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Ajiono Narpati S.Kom','25361 Jenkins Centers Apt. 393\nNorth Maximo, WA 87334','3506306346975063','088273558808','https://via.placeholder.com/640x480.png/00aa88?text=odit',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('5d62a6f6-8c7a-3e86-8bcb-d854d0e2b971','witting.dedrick','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Malik Hutasoit S.Pt','2803 Karelle Point\nHattieburgh, MD 96956','3506910903937361','087151674084','https://via.placeholder.com/640x480.png/0055aa?text=molestias',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('649bd769-88b0-3ec5-afec-fafb3f7afce4','sherwood65','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('766dc6c0-095c-3586-b642-1354ef754945','imogene.armstrong','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user',NULL,NULL,NULL,NULL,NULL,'2025-08-06 09:49:55',NULL,'2025-08-07 09:49:55','2025-08-07 09:49:55'),('77394aad-5c4f-3f4d-8b13-acb08b99a898','hermann.baby','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Kawaca Waskita','23156 Koepp Walks Apt. 656\nPort Uriel, NC 83791-6376','3506996743171463','089570659819','https://via.placeholder.com/640x480.png/0011bb?text=impedit',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('a23c6748-ef07-3a90-8f15-557631a814e5','admin','$2y$12$e5BcMMXrsrm62eQuukDBPOCQX9UDN3hN6DyYz.sXxiZYH3jhqJvv6','admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-07 09:49:55','2025-08-07 09:49:55'),('ae285eb9-51e4-3e8c-922a-8ba2ef99dd47','penyewa','$2y$12$SuhNSa/XTHDhwRhCvew2uOAJ6Dzee6RK6MiIlv7g7L3bdoIpq/zDK','user',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-07 09:49:55','2025-08-07 09:49:55'),('c947fc12-1552-3431-85fb-ca214f709473','crooks.marguerite','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('cc367b96-d742-3c7a-94fa-67d0371c8153','danial.rolfson','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user',NULL,NULL,NULL,NULL,NULL,'2025-08-06 09:49:55',NULL,'2025-08-07 09:49:55','2025-08-07 09:49:55'),('e320958c-0ebf-3f89-82c4-70a73fef5931','dare.dee','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Irwan Saptono','995 O\'Reilly Drive Apt. 623\nEichmannmouth, WI 62814-8327','3506556104349889','085977384543','https://via.placeholder.com/640x480.png/0044ff?text=quam',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54'),('eb9934a3-f147-3bae-bb55-40bbb9601410','taya04','$2y$12$XiHkTqFNAk.QHVVJ.WivZexrgWZ8yhTXPM2.YwvrMgJ/Ug/ucyWmO','user','Rahmi Ika Permata','15177 Aaron Parkways\nNorth Spencer, OH 41957','3506909753603078','088639323573','https://via.placeholder.com/640x480.png/00ccff?text=deserunt',NULL,NULL,'2025-08-07 09:49:54','2025-08-07 09:49:54');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-07  9:55:04
