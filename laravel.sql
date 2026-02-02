-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2026 at 01:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `image`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Nike', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(2, NULL, 'Adidas', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(3, NULL, 'Puma', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(4, NULL, 'Under Armour', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(5, NULL, 'Levi\'s', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(6, NULL, 'The North Face', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(7, NULL, 'Uniqlo', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(8, NULL, 'H&M', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(9, NULL, 'Zara', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(10, NULL, 'Gucci', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(11, NULL, 'Ralph Lauren', NULL, 1, '2026-02-02 11:18:48', '2026-02-02 11:18:48');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `image`, `name`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'T-Shirts', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(2, NULL, 'Jeans', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(3, NULL, 'Jackets', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(4, NULL, 'Dresses', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(5, NULL, 'Shoes', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(6, NULL, 'Hats', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(7, NULL, 'Sweaters', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(8, NULL, 'Shorts', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(9, NULL, 'Socks', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(10, NULL, 'Accessories', NULL, 1, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(11, NULL, 'Underwear', NULL, 1, '2026-02-02 11:18:08', '2026-02-02 11:18:08');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `symbol`, `active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', '$', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'Euro', 'EUR', '€', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(3, 'British Pound', 'GBP', '£', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(4, 'Japanese Yen', 'JPY', '¥', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(5, 'Australian Dollar', 'AUD', 'A$', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(6, 'Canadian Dollar', 'CAD', 'C$', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(7, 'Chinese Yuan', 'CNY', '¥', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(8, 'Indian Rupee', 'INR', '₹', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(9, 'Indonesian Rupiah', 'IDR', 'Rp', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(10, 'Pakistani Rupee', 'PKR', '₨', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(11, 'Bangladeshi Taka', 'BDT', '৳', 1, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(12, 'Vietnamese Dong', 'VND', '₫', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(13, 'Philippine Peso', 'PHP', '₱', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(14, 'Thai Baht', 'THB', '฿', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(15, 'South Korean Won', 'KRW', '₩', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(16, 'Malaysian Ringgit', 'MYR', 'RM', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(17, 'Singapore Dollar', 'SGD', 'S$', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(18, 'Sri Lankan Rupee', 'LKR', '₨', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(19, 'Nepalese Rupee', 'NPR', '₨', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(20, 'Afghan Afghani', 'AFN', '؋', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(21, 'Iraqi Dinar', 'IQD', 'ع.د', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(22, 'Iranian Rial', 'IRR', '﷼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(23, 'Saudi Riyal', 'SAR', '﷼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(24, 'Israeli New Shekel', 'ILS', '₪', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(25, 'Turkish Lira', 'TRY', '₺', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(26, 'Emirati Dirham', 'AED', 'د.إ', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(27, 'Qatari Riyal', 'QAR', '﷼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(28, 'Omani Rial', 'OMR', '﷼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(29, 'Kuwaiti Dinar', 'KWD', 'د.ك', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(30, 'Jordanian Dinar', 'JOD', 'د.ا', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(31, 'Lebanese Pound', 'LBP', 'ل.ل', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(32, 'Syrian Pound', 'SYP', '£', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(33, 'Yemeni Rial', 'YER', '﷼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(34, 'Armenian Dram', 'AMD', '֏', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(35, 'Azerbaijani Manat', 'AZN', '₼', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(36, 'Georgian Lari', 'GEL', '₾', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(37, 'Kazakhstani Tenge', 'KZT', '₸', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(38, 'Uzbekistani Som', 'UZS', 'лв', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(39, 'Turkmenistan Manat', 'TMT', 'm', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(40, 'Tajikistani Somoni', 'TJS', 'ЅМ', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(41, 'Kyrgyzstani Som', 'KGS', 'лв', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(42, 'Mongolian Tugrik', 'MNT', '₮', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(43, 'Bahraini Dinar', 'BHD', '.د.ب', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(44, 'Maldivian Rufiyaa', 'MVR', 'Rf', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(45, 'Bhutanese Ngultrum', 'BTN', 'Nu.', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(46, 'Myanmar Kyat', 'MMK', 'K', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(47, 'Laotian Kip', 'LAK', '₭', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(48, 'Cambodian Riel', 'KHR', '៛', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(49, 'Brunei Dollar', 'BND', 'B$', 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Walking Customer', '012345678', NULL, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'Jazmyn Reichert IV', '1-283-550-2619', '4966 White Plains Apt. 869\nJimmieview, WI 13070-0060', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(3, 'Mr. Dimitri Cartwright Jr.', '+1.351.888.4853', '805 Funk Circle Suite 752\nWest Madilynbury, CA 13022-3560', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(4, 'Tom Sipes', '+1-724-262-0704', '81164 Krajcik Walk Apt. 138\nNew Annalise, IN 56657', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(5, 'Miss Eula Aufderhar DDS', '+1 (281) 455-7436', '2868 Rowe Throughway\nMacejkovicville, FL 28518', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(6, 'Morris Barrows', '+1.720.602.7127', '41930 Schumm Skyway\nMaximillianbury, IL 54135', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(7, 'Laurianne Muller', '1-810-863-4550', '9585 Tremblay Rapid Apt. 690\nNew Brandonport, ID 72903', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(8, 'Eleanora Stehr', '475.518.5853', '83394 Kamren Unions\nSouth Cyrus, ME 49344', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(9, 'Mr. Julio Kuhn', '1-430-820-0949', '786 Marques Parks Suite 815\nFritschfort, CT 53116-9119', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(10, 'Prof. Rickie Prosacco', '+1-470-302-8444', '9872 Rodriguez Shoal Apt. 125\nEast Brendaburgh, IL 69363', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(11, 'Aliza Connelly', '+1 (321) 608-4545', '687 Streich Courts Suite 525\nLake Manuel, SD 51093', '2026-02-02 10:51:33', '2026-02-02 10:51:33');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forget_passwords`
--

CREATE TABLE `forget_passwords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `otp` int(11) DEFAULT NULL,
  `failed_attempt` smallint(6) NOT NULL DEFAULT 0,
  `token` varchar(255) DEFAULT NULL,
  `suspend_duration` varchar(255) NOT NULL DEFAULT '0',
  `resent_count` smallint(6) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_05_11_051813_create_forget_passwords_table', 1),
(6, '2023_07_18_170442_create_permission_tables', 1),
(7, '2024_09_10_161412_create_categories_table', 1),
(8, '2024_09_10_161420_create_brands_table', 1),
(9, '2024_09_10_161421_create_units_table', 1),
(10, '2024_09_10_161422_create_products_table', 1),
(11, '2024_09_10_161609_create_pos_carts_table', 1),
(12, '2024_09_10_161620_create_customers_table', 1),
(13, '2024_09_10_161625_create_orders_table', 1),
(14, '2024_09_10_161633_create_order_products_table', 1),
(15, '2024_10_15_144038_create_order_transactions_table', 1),
(16, '2024_10_16_123030_create_suppliers_table', 1),
(17, '2024_10_16_173030_create_purchases_table', 1),
(18, '2024_10_16_190049_create_purchase_items_table', 1),
(19, '2024_10_31_105132_create_currencies_table', 1),
(20, '2025_03_24_105855_modify_discount_columns_in_products_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 2),
(3, 'App\\Models\\User', 3);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `sub_total` double NOT NULL DEFAULT 0 COMMENT 'sumOf(total) from order_products table',
  `total` double NOT NULL DEFAULT 0 COMMENT 'sub_total - discount',
  `paid` double NOT NULL DEFAULT 0 COMMENT 'customer paid amount',
  `due` double NOT NULL DEFAULT 0 COMMENT 'total - paid',
  `note` text DEFAULT NULL,
  `is_returned` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `customer_id`, `discount`, `sub_total`, `total`, `paid`, `due`, `note`, `is_returned`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, 120, 120, 0, 120, NULL, 0, 0, '2026-02-02 11:22:38', '2026-02-02 11:22:39');

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` double NOT NULL DEFAULT 0,
  `purchase_price` double NOT NULL DEFAULT 0,
  `discount` double NOT NULL DEFAULT 0,
  `sub_total` double NOT NULL DEFAULT 0,
  `total` double NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `quantity`, `price`, `purchase_price`, `discount`, `sub_total`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 51, 1, 120, 120, 0, 120, 120, '2026-02-02 11:22:39', '2026-02-02 11:22:39');

-- --------------------------------------------------------

--
-- Table structure for table `order_transactions`
--

CREATE TABLE `order_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `amount` double(10,2) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `paid_by` varchar(255) NOT NULL COMMENT 'bank,cash,card',
  `transaction_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'dashboard_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'customer_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(3, 'customer_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(4, 'customer_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(5, 'customer_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(6, 'customer_sales', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(7, 'supplier_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(8, 'supplier_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(9, 'supplier_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(10, 'supplier_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(11, 'product_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(12, 'product_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(13, 'product_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(14, 'product_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(15, 'product_import', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(16, 'brand_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(17, 'brand_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(18, 'brand_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(19, 'brand_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(20, 'category_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(21, 'category_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(22, 'category_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(23, 'category_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(24, 'unit_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(25, 'unit_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(26, 'unit_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(27, 'unit_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(28, 'sale_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(29, 'sale_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(30, 'sale_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(31, 'sale_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(32, 'purchase_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(33, 'purchase_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(34, 'purchase_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(35, 'purchase_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(36, 'reports_summary', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(37, 'reports_sales', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(38, 'reports_inventory', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(39, 'currency_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(40, 'currency_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(41, 'currency_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(42, 'currency_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(43, 'currency_set_default', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(44, 'role_create', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(45, 'role_view', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(46, 'role_update', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(47, 'role_delete', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(48, 'permission_view', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(49, 'user_create', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(50, 'user_view', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(51, 'user_update', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(52, 'user_delete', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(53, 'user_suspend', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(54, 'website_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(55, 'contact_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(56, 'socials_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(57, 'style_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(58, 'custom_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(59, 'notification_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(60, 'website_status_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(61, 'invoice_settings', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(62, 'product_purchase', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(63, 'sale_edit', 'web', '2026-02-02 10:51:31', '2026-02-02 10:51:31');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pos_carts`
--

CREATE TABLE `pos_carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `unit_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price` double(10,2) NOT NULL DEFAULT 0.00,
  `discount` double(10,2) DEFAULT NULL,
  `discount_type` varchar(255) DEFAULT NULL,
  `purchase_price` double(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `expire_date` date DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `image`, `name`, `slug`, `sku`, `description`, `category_id`, `brand_id`, `unit_id`, `price`, `discount`, `discount_type`, `purchase_price`, `quantity`, `expire_date`, `status`, `created_at`, `updated_at`) VALUES
(1, '', 'Cotton Crewneck T-Shirt', 'cotton-crewneck-t-shirt', '5edfa10f-17cf-36fa-adaf-9e43002aca3c', 'High-quality cotton crewneck t-shirt designed for comfort and style. Perfect for everyday wear.', 9, 8, 6, 281.00, 6.00, 'fixed', 541.00, 0, '2026-10-03', 0, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(2, '', 'Slim Fit Denim Jeans', 'slim-fit-denim-jeans', '5110ed90-1d1b-3f24-8252-adfe0aefaca4', 'High-quality slim fit denim jeans designed for comfort and style. Perfect for everyday wear.', 5, 7, 3, 935.00, 51.00, 'percentage', 718.00, 0, '2027-01-01', 0, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(3, '', 'Oversized Knit Sweater', 'oversized-knit-sweater', 'a4c6cc6d-06de-38d1-af75-1070994beb17', 'High-quality oversized knit sweater designed for comfort and style. Perfect for everyday wear.', 10, 8, 3, 251.00, 60.00, 'percentage', 817.00, 0, '2026-11-08', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(4, '', 'Water-Resistant Windbreaker', 'water-resistant-windbreaker', 'fe58adde-843e-33c5-9c9f-ff074f45b23a', 'High-quality water-resistant windbreaker designed for comfort and style. Perfect for everyday wear.', 2, 9, 2, 621.00, 30.00, 'percentage', 497.00, 5, '2026-10-03', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(5, '', 'Classic Chino Shorts', 'classic-chino-shorts', '2c2aa73a-6477-3d89-b5aa-212ae2b0ce74', 'High-quality classic chino shorts designed for comfort and style. Perfect for everyday wear.', 2, 5, 3, 920.00, 26.00, 'percentage', 587.00, 0, '2026-07-21', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(6, '', 'Floral Print Maxi Dress', 'floral-print-maxi-dress', 'bdf09aa0-0748-37c0-a4ca-7917bf95a864', 'High-quality floral print maxi dress designed for comfort and style. Perfect for everyday wear.', 1, 3, 3, 372.00, 40.00, 'percentage', 379.00, 0, '2026-12-18', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(7, '', 'Leather Biker Jacket', 'leather-biker-jacket', 'e92ea679-0c50-3fda-871d-391ad3a1bc72', 'High-quality leather biker jacket designed for comfort and style. Perfect for everyday wear.', 5, 2, 6, 283.00, 74.00, 'fixed', 518.00, 0, '2026-09-01', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(8, '', 'Graphic Urban Hoodie', 'graphic-urban-hoodie', '3489c49b-2632-3670-bf37-e851e3de98a7', 'High-quality graphic urban hoodie designed for comfort and style. Perfect for everyday wear.', 5, 6, 4, 646.00, 26.00, 'percentage', 238.00, 1, '2026-09-05', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(9, '', 'Straight Leg Cargo Pants', 'straight-leg-cargo-pants', '6cd7f387-e23f-3784-82e3-d2ad1b4d5e72', 'High-quality straight leg cargo pants designed for comfort and style. Perfect for everyday wear.', 10, 9, 5, 355.00, 43.00, 'fixed', 341.00, 0, '2026-09-29', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(10, '', 'Button-Down Flannel Shirt', 'button-down-flannel-shirt', 'f16cf6bf-243e-3f57-bd9a-d982685af22e', 'High-quality button-down flannel shirt designed for comfort and style. Perfect for everyday wear.', 1, 2, 3, 886.00, 93.00, 'fixed', 167.00, 0, '2026-03-14', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(11, '', 'Merino Wool Cardigan', 'merino-wool-cardigan', '310808b8-37a6-3778-9c0e-24cfdb36a39e', 'High-quality merino wool cardigan designed for comfort and style. Perfect for everyday wear.', 4, 5, 3, 887.00, 92.00, 'percentage', 718.00, 4, '2026-04-03', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(12, '', 'High-Waisted Leggings', 'high-waisted-leggings', 'b0c9ff81-f890-34b6-af08-42530bce4fd2', 'High-quality high-waisted leggings designed for comfort and style. Perfect for everyday wear.', 8, 9, 5, 790.00, 70.00, 'fixed', 197.00, 0, '2026-03-27', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(13, '', 'Quilted Puffer Vest', 'quilted-puffer-vest', 'f1b6df81-dad7-3fc0-bce7-c8760ee0e708', 'High-quality quilted puffer vest designed for comfort and style. Perfect for everyday wear.', 8, 8, 4, 837.00, 62.00, 'fixed', 790.00, 0, '2026-09-07', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(14, '', 'Silk Evening Blouse', 'silk-evening-blouse', 'aac867fd-b9b0-3508-80c3-efa2a2aa4946', 'High-quality silk evening blouse designed for comfort and style. Perfect for everyday wear.', 3, 4, 6, 572.00, 88.00, 'percentage', 518.00, 7, '2027-01-20', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(15, '', 'Tailored Navy Blazer', 'tailored-navy-blazer', '6b59397b-6a23-3d9f-835a-5abce0fb2df3', 'High-quality tailored navy blazer designed for comfort and style. Perfect for everyday wear.', 6, 5, 4, 531.00, 89.00, 'fixed', 108.00, 0, '2026-05-31', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(16, '', 'Ribbed Tank Top', 'ribbed-tank-top', '87e7599f-ade3-3833-8012-d9a13df97873', 'High-quality ribbed tank top designed for comfort and style. Perfect for everyday wear.', 2, 10, 1, 432.00, 28.00, 'fixed', 311.00, 0, '2026-03-26', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(17, '', 'Athletic Performance Shorts', 'athletic-performance-shorts', '42ead25f-89ea-39fc-b179-945774409cf4', 'High-quality athletic performance shorts designed for comfort and style. Perfect for everyday wear.', 2, 1, 4, 529.00, 34.00, 'percentage', 139.00, 0, '2026-02-21', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(18, '', 'Distressed Denim Skirt', 'distressed-denim-skirt', '6b91e863-5b53-3ab5-89d5-d48b76cf2f11', 'High-quality distressed denim skirt designed for comfort and style. Perfect for everyday wear.', 9, 3, 1, 675.00, 7.00, 'percentage', 771.00, 16, '2027-01-30', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(19, '', 'Fleece-Lined Joggers', 'fleece-lined-joggers', '639e3f44-64f5-36c9-bb8c-937cd668e27c', 'High-quality fleece-lined joggers designed for comfort and style. Perfect for everyday wear.', 10, 3, 1, 990.00, 6.00, 'fixed', 542.00, 0, '2026-04-03', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(20, '', 'Oxford Cotton Shirt', 'oxford-cotton-shirt', '81a98951-d530-307d-b72b-090464a33f53', 'High-quality oxford cotton shirt designed for comfort and style. Perfect for everyday wear.', 1, 4, 4, 623.00, 88.00, 'fixed', 106.00, 0, '2026-02-09', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(21, '', 'Bohemian Embroidered Top', 'bohemian-embroidered-top', '5a6195f9-990e-34a9-b022-35d4004c306f', 'High-quality bohemian embroidered top designed for comfort and style. Perfect for everyday wear.', 3, 3, 1, 894.00, 6.00, 'fixed', 538.00, 0, '2026-06-20', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(22, '', 'Corduroy Trucker Jacket', 'corduroy-trucker-jacket', 'b2087edc-96e9-3438-862d-369ff8c70c86', 'High-quality corduroy trucker jacket designed for comfort and style. Perfect for everyday wear.', 2, 5, 3, 804.00, 77.00, 'fixed', 97.00, 0, '2026-09-17', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(23, '', 'Lightweight Linen Trousers', 'lightweight-linen-trousers', 'c48fb488-089c-36fc-b40c-13eeafec829b', 'High-quality lightweight linen trousers designed for comfort and style. Perfect for everyday wear.', 10, 1, 4, 137.00, 83.00, 'fixed', 524.00, 0, '2026-08-29', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(24, '', 'Sleeveless Summer Romper', 'sleeveless-summer-romper', '5f0dd128-f5ce-3695-a68b-911e162a0654', 'High-quality sleeveless summer romper designed for comfort and style. Perfect for everyday wear.', 3, 6, 1, 232.00, 100.00, 'fixed', 167.00, 0, '2026-11-29', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(25, '', 'Cashmere V-Neck Pullover', 'cashmere-v-neck-pullover', 'ed228885-9ff1-34c1-a017-b59549f2b00d', 'High-quality cashmere v-neck pullover designed for comfort and style. Perfect for everyday wear.', 5, 3, 5, 493.00, 51.00, 'fixed', 158.00, 5, '2026-10-15', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(26, '', 'Heavyweight Boxy Tee', 'heavyweight-boxy-tee', 'fe5bd9f0-3f71-3a99-859c-45d50b8346c2', 'High-quality heavyweight boxy tee designed for comfort and style. Perfect for everyday wear.', 5, 2, 6, 261.00, 11.00, 'fixed', 588.00, 9, '2026-11-04', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(27, '', 'Tapered Sweatpants', 'tapered-sweatpants', 'e5db262f-b347-316a-9731-ac485ff7ff20', 'High-quality tapered sweatpants designed for comfort and style. Perfect for everyday wear.', 3, 10, 3, 627.00, 24.00, 'fixed', 213.00, 0, '2026-08-29', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(28, '', 'Vintage Wash Denim Jacket', 'vintage-wash-denim-jacket', '0c2c8409-d21f-3675-969d-46f583f664be', 'High-quality vintage wash denim jacket designed for comfort and style. Perfect for everyday wear.', 6, 8, 1, 851.00, 63.00, 'fixed', 755.00, 5, '2026-08-29', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(29, '', 'Checkered Midi Skirt', 'checkered-midi-skirt', 'd65d3dfd-b6b8-37f8-ab8e-a751da6a967b', 'High-quality checkered midi skirt designed for comfort and style. Perfect for everyday wear.', 2, 4, 4, 754.00, 85.00, 'percentage', 212.00, 0, '2026-06-30', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(30, '', 'Polo Sport Shirt', 'polo-sport-shirt', 'e1b464de-7b31-38e5-a5fb-8bc2ed1ee90a', 'High-quality polo sport shirt designed for comfort and style. Perfect for everyday wear.', 6, 5, 5, 111.00, 56.00, 'fixed', 78.00, 0, '2026-03-22', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(31, '', 'Activewear Compression Top', 'activewear-compression-top', '65577d37-ad1a-33ac-a801-8d7e77e6ecc2', 'High-quality activewear compression top designed for comfort and style. Perfect for everyday wear.', 6, 4, 4, 648.00, 95.00, 'fixed', 846.00, 7, '2026-07-31', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(32, '', 'Canvas Utility Jacket', 'canvas-utility-jacket', '0ad099df-b72c-3cda-ab1a-b9f48824c4ed', 'High-quality canvas utility jacket designed for comfort and style. Perfect for everyday wear.', 6, 9, 3, 486.00, 70.00, 'percentage', 63.00, 0, '2026-06-08', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(33, '', 'Velvet Party Dress', 'velvet-party-dress', 'e08e17bf-3be0-3ad7-a469-7e046be059ef', 'High-quality velvet party dress designed for comfort and style. Perfect for everyday wear.', 2, 10, 6, 516.00, 38.00, 'percentage', 753.00, 0, '2026-10-28', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(34, '', 'Minimalist Rain Mac', 'minimalist-rain-mac', 'f90d13ff-df52-39f7-99a1-fa0d0cff71c2', 'High-quality minimalist rain mac designed for comfort and style. Perfect for everyday wear.', 3, 9, 1, 756.00, 11.00, 'fixed', 235.00, 6, '2026-08-23', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(35, '', 'Breathable Mesh Sneakers', 'breathable-mesh-sneakers', '9556b9e4-a278-3978-a0ad-6c1c2158cd43', 'High-quality breathable mesh sneakers designed for comfort and style. Perfect for everyday wear.', 2, 10, 1, 389.00, 97.00, 'percentage', 766.00, 0, '2026-05-05', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(36, '', 'Suede Chelsea Boots', 'suede-chelsea-boots', '71408c51-67a3-3403-b2e1-c3a8e15ce83d', 'High-quality suede chelsea boots designed for comfort and style. Perfect for everyday wear.', 4, 3, 6, 332.00, 21.00, 'percentage', 311.00, 0, '2026-07-03', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(37, '', 'Wide-Brim Straw Hat', 'wide-brim-straw-hat', 'e96db82f-fdb4-36e9-989e-1c7035bef8d4', 'High-quality wide-brim straw hat designed for comfort and style. Perfect for everyday wear.', 8, 2, 6, 891.00, 65.00, 'percentage', 490.00, 0, '2026-03-26', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(38, '', 'Leather Braided Belt', 'leather-braided-belt', '40564e5b-018b-3857-ba2e-39efaa119a45', 'High-quality leather braided belt designed for comfort and style. Perfect for everyday wear.', 10, 4, 2, 131.00, 1.00, 'percentage', 885.00, 5, '2026-03-14', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(39, '', 'Wool Blend Overcoat', 'wool-blend-overcoat', 'cf1ebec0-94b3-3377-895d-fd89d361a18b', 'High-quality wool blend overcoat designed for comfort and style. Perfect for everyday wear.', 10, 9, 2, 495.00, 15.00, 'percentage', 230.00, 8, '2026-02-14', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(40, '', 'Striped Breton Top', 'striped-breton-top', '652deeae-b5a4-3e1c-8b94-6e961ba489d6', 'High-quality striped breton top designed for comfort and style. Perfect for everyday wear.', 7, 2, 4, 743.00, 96.00, 'percentage', 529.00, 14, '2027-01-14', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(41, '', 'Yoga Flare Pants', 'yoga-flare-pants', '3057d11b-b0ba-3b30-890c-be5c25207762', 'High-quality yoga flare pants designed for comfort and style. Perfect for everyday wear.', 10, 9, 4, 784.00, 38.00, 'percentage', 371.00, 22, '2026-08-06', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(42, '', 'Denim Overalls', 'denim-overalls', '1ed8d12f-8a50-3b4b-9d55-618978118af0', 'High-quality denim overalls designed for comfort and style. Perfect for everyday wear.', 9, 2, 4, 742.00, 16.00, 'fixed', 186.00, 0, '2026-07-24', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(43, '', 'Sheer Chiffon Scarf', 'sheer-chiffon-scarf', '770d0649-d6cf-32f9-ad49-1b5245510a5a', 'High-quality sheer chiffon scarf designed for comfort and style. Perfect for everyday wear.', 10, 10, 3, 284.00, 74.00, 'fixed', 527.00, 2, '2026-08-13', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(44, '', 'Knitted Beanie Hat', 'knitted-beanie-hat', '60ed8ab1-b160-3783-8dc7-c4d6471175db', 'High-quality knitted beanie hat designed for comfort and style. Perfect for everyday wear.', 3, 1, 2, 489.00, 85.00, 'percentage', 582.00, 22, '2026-04-09', 0, '2026-02-02 10:51:32', '2026-02-02 10:51:33'),
(45, '', 'Padded Bomber Jacket', 'padded-bomber-jacket', 'bc62cb2b-ba72-3e29-9920-d2492d8f58f3', 'High-quality padded bomber jacket designed for comfort and style. Perfect for everyday wear.', 5, 1, 5, 886.00, 76.00, 'fixed', 47.00, 0, '2027-01-24', 1, '2026-02-02 10:51:32', '2026-02-02 10:51:32'),
(46, '', 'Satin Slip Dress', 'satin-slip-dress', '0074ffc6-2903-356c-8ad3-5ada60366a19', 'High-quality satin slip dress designed for comfort and style. Perfect for everyday wear.', 2, 9, 6, 812.00, 80.00, 'percentage', 653.00, 5, '2027-01-07', 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(47, '', 'Performance Running Tee', 'performance-running-tee', '62a08722-da21-3892-b7c9-98d8f7f65b60', 'High-quality performance running tee designed for comfort and style. Perfect for everyday wear.', 2, 8, 2, 481.00, 85.00, 'fixed', 87.00, 0, '2026-07-06', 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(48, '', 'Wide Leg Culottes', 'wide-leg-culottes', 'd7f8a2a5-c59e-3f25-bb7f-84e7e31642cc', 'High-quality wide leg culottes designed for comfort and style. Perfect for everyday wear.', 4, 2, 4, 949.00, 23.00, 'percentage', 49.00, 0, '2026-10-04', 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(49, '', 'Faux Fur Trim Parka', 'faux-fur-trim-parka', 'c6bd9599-a68e-35b0-8d89-e5ef8ea84b38', 'High-quality faux fur trim parka designed for comfort and style. Perfect for everyday wear.', 2, 1, 4, 650.00, 55.00, 'percentage', 372.00, 0, '2026-02-14', 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(50, '', 'Woven Leather Sandals', 'woven-leather-sandals', '9fadbf09-eedd-3855-8163-aca8cba60c35', 'High-quality woven leather sandals designed for comfort and style. Perfect for everyday wear.', 5, 7, 4, 244.00, 81.00, 'percentage', 488.00, 1, '2026-06-17', 0, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(51, NULL, 'Canvas Tote Bag', 'canvas-tote-bag', 'ABX-123', 'High-quality canvas tote bag designed for comfort and style. Perfect for everyday wear.', 11, 11, 1, 120.00, NULL, NULL, 120.00, 9, NULL, 1, '2026-02-02 11:15:06', '2026-02-02 11:22:39');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `sub_total` double(10,2) NOT NULL DEFAULT 0.00,
  `tax` double(10,2) NOT NULL DEFAULT 0.00,
  `discount_value` double(10,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(255) NOT NULL DEFAULT 'fixed',
  `shipping` double(10,2) NOT NULL DEFAULT 0.00,
  `grand_total` double(10,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(4) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `supplier_id`, `user_id`, `sub_total`, `tax`, `discount_value`, `discount_type`, `shipping`, `grand_total`, `status`, `date`, `created_at`, `updated_at`) VALUES
(1, 11, 3, 2116.00, 6.00, 33.00, 'fixed', 21.00, 2230.96, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(2, 3, 3, 10794.00, 12.00, 32.00, 'fixed', 17.00, 12074.28, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(3, 9, 1, 6292.00, 14.00, 7.00, 'fixed', 16.00, 7181.88, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(4, 3, 1, 16597.00, 6.00, 17.00, 'fixed', 27.00, 17602.82, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(5, 3, 2, 7777.00, 7.00, 15.00, 'fixed', 12.00, 8318.39, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(6, 11, 1, 9172.00, 6.00, 17.00, 'fixed', 11.00, 9716.32, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(7, 6, 3, 7687.00, 13.00, 20.00, 'fixed', 28.00, 8694.31, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(8, 5, 1, 6058.00, 14.00, 2.00, 'fixed', 13.00, 6917.12, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(9, 3, 1, 9100.00, 12.00, 31.00, 'fixed', 19.00, 10180.00, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(10, 7, 1, 2597.00, 7.00, 18.00, 'fixed', 20.00, 2780.79, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(11, 1, 1, 1200.00, 0.00, 0.00, 'fixed', 0.00, 1200.00, 1, '2026-01-31 18:30:00', '2026-02-02 11:19:54', '2026-02-02 11:19:54');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_price` double(10,2) NOT NULL DEFAULT 0.00,
  `price` double(10,2) NOT NULL DEFAULT 0.00,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_items`
--

INSERT INTO `purchase_items` (`id`, `purchase_id`, `product_id`, `purchase_price`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 40, 529.00, 743.00, 4, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(2, 2, 39, 230.00, 495.00, 8, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(3, 2, 25, 158.00, 493.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(4, 2, 26, 588.00, 261.00, 9, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(5, 2, 11, 718.00, 887.00, 4, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(6, 3, 44, 582.00, 489.00, 9, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(7, 3, 43, 527.00, 284.00, 2, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(8, 4, 18, 771.00, 675.00, 9, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(9, 4, 41, 371.00, 784.00, 2, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(10, 4, 40, 529.00, 743.00, 10, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(11, 4, 14, 518.00, 572.00, 7, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(12, 5, 31, 846.00, 648.00, 7, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(13, 5, 41, 371.00, 784.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(14, 6, 18, 771.00, 675.00, 7, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(15, 6, 28, 755.00, 851.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(16, 7, 50, 488.00, 244.00, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(17, 7, 44, 582.00, 489.00, 3, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(18, 7, 41, 371.00, 784.00, 8, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(19, 7, 4, 497.00, 621.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(20, 8, 44, 582.00, 489.00, 10, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(21, 8, 8, 238.00, 646.00, 1, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(22, 9, 38, 885.00, 131.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(23, 9, 46, 653.00, 812.00, 5, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(24, 9, 34, 235.00, 756.00, 6, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(25, 10, 41, 371.00, 784.00, 7, '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(26, 11, 51, 120.00, 120.00, 10, '2026-02-02 11:19:54', '2026-02-02 11:19:54');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'cashier', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(3, 'sales_associate', 'web', '2026-02-02 10:51:30', '2026-02-02 10:51:30');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(3, 2),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(13, 1),
(13, 2),
(14, 1),
(14, 2),
(15, 1),
(15, 2),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(28, 2),
(28, 3),
(29, 1),
(29, 2),
(29, 3),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 2),
(63, 3);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `address`, `created_at`, `updated_at`) VALUES
(1, 'Own Supplier', '012345678', NULL, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'Davonte McDermott', '+1.484.221.0583', '23080 Kirlin Plaza\nNorth Rebeccaside, RI 14252', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(3, 'Mr. Erick McKenzie DDS', '989-240-8557', '480 Jayden Rue\nEast Sophiehaven, NY 27479-4620', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(4, 'Henriette Rosenbaum', '+1-469-934-1980', '11441 Augustus Ways\nSwiftville, MI 17560', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(5, 'Dr. Tomas Torp', '(321) 835-4527', '451 Layla Stream\nLabadiehaven, CA 38309-6573', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(6, 'Gloria Wisoky', '1-786-246-7756', '34075 Lori Lock Suite 378\nWest Wileyshire, WI 82057', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(7, 'Frances Kuhlman', '(724) 966-9946', '913 Yundt Hill\nNew Elyse, SC 20977-0629', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(8, 'Dawson Mohr', '+1-380-227-1429', '9700 Bryana Valley\nStanfordburgh, MD 78169', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(9, 'Emile Hessel', '+1 (904) 304-1734', '7607 Eugene Crest\nPort Salvatore, VA 72428-1643', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(10, 'Larry Reinger', '973-360-3008', '966 Von Ville Apt. 835\nLeonieberg, MO 96041-2972', '2026-02-02 10:51:33', '2026-02-02 10:51:33'),
(11, 'Zachariah Wilderman', '952-445-8274', '6454 Fausto Dale\nCartwrighthaven, CA 82936-1095', '2026-02-02 10:51:33', '2026-02-02 10:51:33');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `short_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `title`, `short_name`, `created_at`, `updated_at`) VALUES
(1, 'Piece', 'pcs', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'Kilogram', 'kg', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(3, 'Liter', 'L', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(4, 'Meter', 'm', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(5, 'Dozen', 'dz', '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(6, 'Box', 'box', '2026-02-02 10:51:30', '2026-02-02 10:51:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `is_google_registered` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspended` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `username`, `profile_image`, `google_id`, `is_google_registered`, `is_suspended`, `created_at`, `updated_at`) VALUES
(1, 'Mr Admin', 'demo@qtecsolution.net', NULL, '$2y$10$ADbYUWOdfx6LkusXIAO3ZeMWjcImjX1R6HsSPf/OsLbMhntuWtmTO', NULL, '69807aaa099f5', NULL, NULL, 0, 0, '2026-02-02 10:51:30', '2026-02-02 10:51:30'),
(2, 'Mr Cashier', 'cashier@gmail.com', NULL, '$2y$10$ixMgYkSvaN/u.kxYmbmRMunW7uoCO/hB.PbzRz53uxddyK78YYCIa', NULL, '69807aab70cf8', NULL, NULL, 0, 0, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(3, 'Mr Sales', 'sales@gmail.com', NULL, '$2y$10$x0Wn3UM8nq3V.D3M6pxTueIV0j7Q3rNLjTuVbT8mKvnUslDjeLGKm', NULL, '69807aab94c35', NULL, NULL, 0, 0, '2026-02-02 10:51:31', '2026-02-02 10:51:31'),
(4, 'Admin', 'demo@buildcodechain.com', NULL, '$2y$10$NfYRbQVxI9KjkbzjTG1XYuPw8jEzlqa4HW4wi9ktrUnjUYmGts0jm', NULL, '69808de223e2e', NULL, NULL, 0, 0, '2026-02-02 12:13:30', '2026-02-02 12:13:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `currencies_code_unique` (`code`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_phone_unique` (`phone`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `forget_passwords`
--
ALTER TABLE `forget_passwords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forget_passwords_user_id_unique` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_products_order_id_foreign` (`order_id`),
  ADD KEY `order_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `order_transactions`
--
ALTER TABLE `order_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_transactions_order_id_foreign` (`order_id`),
  ADD KEY `order_transactions_customer_id_foreign` (`customer_id`),
  ADD KEY `order_transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pos_carts`
--
ALTER TABLE `pos_carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pos_carts_product_id_foreign` (`product_id`),
  ADD KEY `pos_carts_user_id_foreign` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`),
  ADD KEY `products_unit_id_foreign` (`unit_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchases_supplier_id_foreign` (`supplier_id`),
  ADD KEY `purchases_user_id_foreign` (`user_id`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_items_purchase_id_foreign` (`purchase_id`),
  ADD KEY `purchase_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `suppliers_phone_unique` (`phone`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forget_passwords`
--
ALTER TABLE `forget_passwords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_transactions`
--
ALTER TABLE `order_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pos_carts`
--
ALTER TABLE `pos_carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_transactions`
--
ALTER TABLE `order_transactions`
  ADD CONSTRAINT `order_transactions_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pos_carts`
--
ALTER TABLE `pos_carts`
  ADD CONSTRAINT `pos_carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pos_carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
