/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : jadwal_bimbingan

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 24/07/2024 09:33:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bimbingans
-- ----------------------------
DROP TABLE IF EXISTS `bimbingans`;
CREATE TABLE `bimbingans`  (
  `bimbingan_id` int NOT NULL AUTO_INCREMENT,
  `dosen_id` int NULL DEFAULT NULL,
  `mahasiswa_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`bimbingan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bimbingans
-- ----------------------------
INSERT INTO `bimbingans` VALUES (2, 1, 1);
INSERT INTO `bimbingans` VALUES (3, 1, 2);
INSERT INTO `bimbingans` VALUES (4, 1, 4);
INSERT INTO `bimbingans` VALUES (5, 1, 5);
INSERT INTO `bimbingans` VALUES (6, 1, 6);

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for dosens
-- ----------------------------
DROP TABLE IF EXISTS `dosens`;
CREATE TABLE `dosens`  (
  `dosen_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `dosen_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dosen_batas_bimbingan` int NULL DEFAULT NULL,
  PRIMARY KEY (`dosen_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dosens
-- ----------------------------
INSERT INTO `dosens` VALUES (1, 1, 'Samsul Bahri', 1);
INSERT INTO `dosens` VALUES (4, 12, 'Deny', NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for jadwal_dosens
-- ----------------------------
DROP TABLE IF EXISTS `jadwal_dosens`;
CREATE TABLE `jadwal_dosens`  (
  `jadwal_dosen_id` int NOT NULL AUTO_INCREMENT,
  `dosen_id` int NULL DEFAULT NULL,
  `dosen_tanggal_dari` datetime NULL DEFAULT NULL,
  `dosen_tanggal_selesai` datetime NULL DEFAULT NULL,
  `is_processed` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`jadwal_dosen_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jadwal_dosens
-- ----------------------------
INSERT INTO `jadwal_dosens` VALUES (31, 1, '2024-07-23 09:00:00', '2024-07-23 17:00:00', 1);

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for mahasiswas
-- ----------------------------
DROP TABLE IF EXISTS `mahasiswas`;
CREATE TABLE `mahasiswas`  (
  `mahasiswa_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `mahasiswa_nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `mahasiswa_start_bimbingan` date NULL DEFAULT NULL,
  `mahasiswa_end_bimbingan` date NULL DEFAULT NULL,
  `mahasiswa_total_bimbingan` int NULL DEFAULT NULL,
  `mahasiswa_status_bimbingan` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`mahasiswa_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mahasiswas
-- ----------------------------
INSERT INTO `mahasiswas` VALUES (0, 13, 'Adil', NULL, NULL, 10, 0);
INSERT INTO `mahasiswas` VALUES (1, 10, 'Helmy', NULL, NULL, 2, 1);
INSERT INTO `mahasiswas` VALUES (2, 11, 'Bobby', '2024-07-17', '2024-07-31', 7, 1);
INSERT INTO `mahasiswas` VALUES (4, 14, 'Afi', '2024-07-17', '2024-07-31', 5, 1);
INSERT INTO `mahasiswas` VALUES (5, 15, 'Ija', '2024-07-17', '2024-07-31', 12, 1);
INSERT INTO `mahasiswas` VALUES (6, 16, 'Ilham', '2024-07-17', '2024-07-31', 7, 1);
INSERT INTO `mahasiswas` VALUES (7, 17, 'Ardi', NULL, NULL, 4, 0);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (3, '2024_07_11_053947_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (4, '2024_07_13_143109_create_sessions_table', 2);

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token`) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type`, `tokenable_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for riwayat_bimbingans
-- ----------------------------
DROP TABLE IF EXISTS `riwayat_bimbingans`;
CREATE TABLE `riwayat_bimbingans`  (
  `riwayat_bimbingan_id` int NOT NULL AUTO_INCREMENT,
  `jadwal_dosen_id` int NULL DEFAULT NULL,
  `mahasiswa_id` int NULL DEFAULT NULL,
  `dosen_id` int NULL DEFAULT NULL,
  `tanggal` date NULL DEFAULT NULL,
  PRIMARY KEY (`riwayat_bimbingan_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of riwayat_bimbingans
-- ----------------------------
INSERT INTO `riwayat_bimbingans` VALUES (4, 31, 2, 1, '2024-07-23');
INSERT INTO `riwayat_bimbingans` VALUES (8, 31, 2, 1, '2024-07-23');
INSERT INTO `riwayat_bimbingans` VALUES (9, 31, 4, 1, '2024-07-23');
INSERT INTO `riwayat_bimbingans` VALUES (10, 31, 5, 1, '2024-07-23');
INSERT INTO `riwayat_bimbingans` VALUES (11, 31, 6, 1, '2024-07-23');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id`) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('teeFTVsGTSzYFJqBRXC6WSNbEMX0WOzPMI6wJFDV', NULL, '192.168.70.53', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 OPR/111.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFZIZXpkSndHT2tmVFExOExpZGR5SDhGQ1RhY2NSYW1qSWE3TGRhNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHA6Ly8xOTIuMTY4LjcwLjUzOjgwMDAvY2FrYXJhbi1tZXRvZGUtZ2VuZXRpYyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1721233974);
INSERT INTO `sessions` VALUES ('v3zIOif7wpMha2dAlbIu0UQKqVKqfakG5o9F3acr', NULL, '192.168.18.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36 OPR/111.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSDN4QkMzeHA3SGZJUVNEdXVQb05wemF5WUNUSm1Ia21NN0pyZndxZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHA6Ly8xOTIuMTY4LjE4Ljc2OjgwMDAvY2FrYXJhbi1tZXRvZGUtZ2VuZXRpYyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1721226096);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `level` enum('admin','dosen','mahasiswa') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'samsulbahri', '$2y$12$MJwXVaj4qRpotFw717ZQpuD1LDNkFuy/hkfi6Ii/Fa2dvGd7MdFHC', 'dosen', NULL);
INSERT INTO `users` VALUES (5, 'anureta', '$2y$12$nqs5Vf6FPY8odf6xLKvoS.S1ER4lqhOsBppIqNQwEXjMkQJpqEvTm', 'admin', NULL);

INSERT INTO `users` VALUES (10, 'helmyy', '$2y$12$0WAaTDtqd6fCwEumXtdzFO4nlhlxW65qoRHSWz.Sl7GZ.caOkuQ5S', 'mahasiswa', 'fmEQudqyS9-aJNasAQjyMq:APA91bEEqwfj382csAkDHb8TVJKgW50seoJu2FyjcoORfB1-7XzRNqsXyyjYOvCPCRnMjzw1D90-vuwCQSXzco2wTUdISIXy77zRqtKS5w46Tzmndc-9U7rocwA9r4FLYLJVh79JbGAF');
INSERT INTO `users` VALUES (11, 'bobbyy', '$2y$12$o5HLkycb1Q2qcbjyXetds.p/AXFp.3hVZhuoSH/wsvlq5GScdJF4O', 'mahasiswa', NULL);
INSERT INTO `users` VALUES (12, 'denyy', '$2y$12$TNB9bHC0HnwoR7QHG0jEHuTQ6Qyp060LdLDLF4gMKU01y5IbOvM22', 'dosen', NULL);
INSERT INTO `users` VALUES (13, 'plutoo', '$2y$12$hqLNs8sEagNc/VcSwAo14uIt9W2H9puww394B1S53bmWEGjA4kjCm', 'mahasiswa', NULL);
INSERT INTO `users` VALUES (14, 'afii', '$2y$12$IwaFuFPEUOlNeHO8nkwS1ubOWp.2Eq2Al3u.xce5vTXztrmKmhTi.', 'mahasiswa', NULL);
INSERT INTO `users` VALUES (15, 'ijaaa', '$2y$12$pVLQA2oCbD7Q5QGAoMUBTeTAauUx2LhqeQCymo7ZFqeoyvDSH722S', 'mahasiswa', NULL);
INSERT INTO `users` VALUES (16, 'ilhamm', '$2y$12$M8d5gEjpPL3Yr/WRasjIqejP8YOLqVMRf5g1OJ29Lj.R3EhXFPkpC', 'mahasiswa', NULL);
INSERT INTO `users` VALUES (17, 'ardii', '$2y$12$u.APPbfYIMERy4zRe.aK.uYXVBGR/UkpKvvQqFFB9M3/sfFHBpt4e', 'mahasiswa', NULL);

SET FOREIGN_KEY_CHECKS = 1;
