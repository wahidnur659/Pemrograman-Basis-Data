-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 07, 2025 at 03:52 PM
-- Server version: 8.0.42-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel_management`
--
CREATE DATABASE IF NOT EXISTS `hotel_management` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `hotel_management`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetHotelStatistics` ()   BEGIN
    SELECT 
        'Total Hotels' AS statistic,
        COUNT(*) AS value
    FROM hotels
    UNION ALL
    SELECT 
        'Total Rooms' AS statistic,
        COUNT(*) AS value
    FROM rooms
    UNION ALL
    SELECT 
        'Total Customers' AS statistic,
        COUNT(*) AS value
    FROM customers
    UNION ALL
    SELECT 
        'Total Bookings' AS statistic,
        COUNT(*) AS value
    FROM bookings$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRoomStatus` (IN `p_room_id` INT, IN `p_new_status` VARCHAR(20))   BEGIN
    DECLARE room_exists INT DEFAULT 0$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetRevenueByDateRange` (`start_date` DATE, `end_date` DATE) RETURNS DECIMAL(15,2) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE revenue DECIMAL(15,2)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `GetTotalRevenue` () RETURNS DECIMAL(15,2) DETERMINISTIC READS SQL DATA BEGIN
    DECLARE total_revenue DECIMAL(15,2)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `operation_type` enum('INSERT','UPDATE','DELETE') NOT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `table_name`, `operation_type`, `old_values`, `new_values`, `user_name`, `timestamp`) VALUES
(1, 'customers', 'INSERT', NULL, '{\"email\": \"test@email.com\", \"last_name\": \"User\", \"first_name\": \"Test\", \"customer_id\": 6}', 'root@localhost', '2025-07-07 04:51:10'),
(2, 'rooms', 'UPDATE', '{\"status\": \"available\", \"room_id\": 2}', '{\"status\": \"cleaning\", \"room_id\": 2}', 'root@localhost', '2025-07-07 04:52:01'),
(3, 'bookings', 'UPDATE', '{\"booking_id\": 1, \"booking_status\": \"checked_in\"}', '{\"booking_id\": 1, \"booking_status\": \"checked_out\"}', 'root@localhost', '2025-07-07 04:54:47'),
(4, 'bookings', 'UPDATE', '{\"booking_id\": 5, \"booking_status\": \"checked_out\"}', '{\"booking_id\": 5, \"booking_status\": \"cancelled\"}', 'root@localhost', '2025-07-07 10:22:48'),
(5, 'customers', 'INSERT', NULL, '{\"email\": \"rizky.pratama@email.com\", \"last_name\": \"Pratama\", \"first_name\": \"Rizky\", \"customer_id\": 7}', 'root@localhost', '2025-07-07 10:44:14'),
(6, 'customers', 'INSERT', NULL, '{\"email\": \"indah.permatasari@email.com\", \"last_name\": \"Permatasari\", \"first_name\": \"Indah\", \"customer_id\": 8}', 'root@localhost', '2025-07-07 10:44:14'),
(7, 'customers', 'INSERT', NULL, '{\"email\": \"agus.salim@email.com\", \"last_name\": \"Salim\", \"first_name\": \"Agus\", \"customer_id\": 9}', 'root@localhost', '2025-07-07 10:44:14'),
(8, 'customers', 'INSERT', NULL, '{\"email\": \"dewi.lestari@email.com\", \"last_name\": \"Lestari\", \"first_name\": \"Dewi\", \"customer_id\": 10}', 'root@localhost', '2025-07-07 10:44:14'),
(9, 'customers', 'INSERT', NULL, '{\"email\": \"eko.prasetyo@email.com\", \"last_name\": \"Prasetyo\", \"first_name\": \"Eko\", \"customer_id\": 11}', 'root@localhost', '2025-07-07 10:44:14'),
(10, 'bookings', 'INSERT', NULL, '{\"room_id\": 11, \"customer_id\": 6, \"check_in_date\": \"2025-07-15\", \"check_out_date\": \"2025-07-18\"}', 'root@localhost', '2025-07-07 10:45:58'),
(11, 'bookings', 'INSERT', NULL, '{\"room_id\": 12, \"customer_id\": 7, \"check_in_date\": \"2025-08-01\", \"check_out_date\": \"2025-08-05\"}', 'root@localhost', '2025-07-07 10:45:58'),
(12, 'bookings', 'INSERT', NULL, '{\"room_id\": 13, \"customer_id\": 8, \"check_in_date\": \"2025-07-20\", \"check_out_date\": \"2025-07-22\"}', 'root@localhost', '2025-07-07 10:45:58'),
(13, 'bookings', 'INSERT', NULL, '{\"room_id\": 14, \"customer_id\": 9, \"check_in_date\": \"2025-09-10\", \"check_out_date\": \"2025-09-12\"}', 'root@localhost', '2025-07-07 10:45:58'),
(14, 'bookings', 'INSERT', NULL, '{\"room_id\": 15, \"customer_id\": 10, \"check_in_date\": \"2025-07-12\", \"check_out_date\": \"2025-07-14\"}', 'root@localhost', '2025-07-07 10:45:58'),
(15, 'rooms', 'UPDATE', '{\"status\": \"available\", \"room_id\": 1}', '{\"status\": \"occupied\", \"room_id\": 1}', 'root@localhost', '2025-07-07 11:26:21'),
(16, 'rooms', 'UPDATE', '{\"status\": \"occupied\", \"room_id\": 1}', '{\"status\": \"cleaning\", \"room_id\": 1}', 'housekeeping@localhost', '2025-07-07 13:31:54');

-- --------------------------------------------------------

--
-- Stand-in structure for view `available_rooms`
-- (See below for the actual view)
--
CREATE TABLE `available_rooms` (
`floor_number` int
,`room_id` int
,`room_number` varchar(20)
,`status` enum('available','occupied','maintenance','cleaning')
);

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `room_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `booking_status` enum('confirmed','checked_in','checked_out','cancelled') DEFAULT 'confirmed',
  `booking_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `special_requests` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `customer_id`, `room_id`, `check_in_date`, `check_out_date`, `total_amount`, `booking_status`, `booking_date`, `special_requests`) VALUES
(1, 1, 3, '2024-02-15', '2024-02-18', 3600000.00, 'checked_out', '2025-07-07 04:42:14', 'Anniversary celebration'),
(2, 2, 4, '2024-02-20', '2024-02-25', 10000000.00, 'confirmed', '2025-07-07 04:42:14', 'Business meeting'),
(3, 3, 6, '2024-02-10', '2024-02-12', 1000000.00, 'checked_out', '2025-07-07 04:42:14', 'Family vacation'),
(4, 4, 8, '2024-02-25', '2024-02-28', 3600000.00, 'confirmed', '2025-07-07 04:42:14', 'Honeymoon'),
(5, 5, 9, '2024-02-12', '2024-02-14', 1000000.00, 'cancelled', '2025-07-07 04:42:14', 'Business trip'),
(6, 6, 11, '2025-07-15', '2025-07-18', 3600000.00, 'confirmed', '2025-07-07 10:45:58', 'Need extra towels'),
(7, 7, 12, '2025-08-01', '2025-08-05', 8000000.00, 'confirmed', '2025-07-07 10:45:58', 'Quiet room away from elevator'),
(8, 8, 13, '2025-07-20', '2025-07-22', 1500000.00, 'checked_in', '2025-07-07 10:45:58', NULL),
(9, 9, 14, '2025-09-10', '2025-09-12', 10000000.00, 'confirmed', '2025-07-07 10:45:58', 'Celebrating anniversary'),
(10, 10, 15, '2025-07-12', '2025-07-14', 1500000.00, 'checked_out', '2025-07-07 10:45:58', 'Business trip');

--
-- Triggers `bookings`
--
DELIMITER $$
CREATE TRIGGER `before_booking_delete` BEFORE DELETE ON `bookings` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, old_values, user_name)
    VALUES ('bookings', 'DELETE', 
            JSON_OBJECT('booking_id', OLD.booking_id, 'customer_id', OLD.customer_id),
            USER())$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_booking_insert` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, new_values, user_name)
    VALUES ('bookings', 'INSERT', 
            JSON_OBJECT('customer_id', NEW.customer_id, 'room_id', NEW.room_id, 
                       'check_in_date', NEW.check_in_date, 'check_out_date', NEW.check_out_date),
            USER())$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_booking_update` BEFORE UPDATE ON `bookings` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, old_values, new_values, user_name)
    VALUES ('bookings', 'UPDATE', 
            JSON_OBJECT('booking_id', OLD.booking_id, 'booking_status', OLD.booking_status),
            JSON_OBJECT('booking_id', NEW.booking_id, 'booking_status', NEW.booking_status),
            USER())$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `booking_details`
-- (See below for the actual view)
--
CREATE TABLE `booking_details` (
`booking_id` int
,`booking_status` enum('confirmed','checked_in','checked_out','cancelled')
,`check_in_date` date
,`check_out_date` date
,`customer_name` varchar(101)
,`email` varchar(100)
,`phone` varchar(20)
,`total_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `booking_services`
--

CREATE TABLE `booking_services` (
  `booking_service_id` int NOT NULL,
  `booking_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `service_date` date DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking_services`
--

INSERT INTO `booking_services` (`booking_service_id`, `booking_id`, `service_id`, `quantity`, `service_date`, `subtotal`, `created_at`) VALUES
(1, 1, 1, 2, '2024-02-16', 600000.00, '2025-07-07 04:42:40'),
(2, 1, 4, 1, '2024-02-17', 500000.00, '2025-07-07 04:42:40'),
(3, 2, 2, 1, '2024-02-20', 150000.00, '2025-07-07 04:42:40'),
(4, 2, 4, 2, '2024-02-22', 1000000.00, '2025-07-07 04:42:40'),
(5, 3, 3, 1, '2024-02-11', 50000.00, '2025-07-07 04:42:40'),
(6, 4, 1, 1, '2024-02-26', 300000.00, '2025-07-07 04:42:40'),
(7, 5, 5, 2, '2024-02-13', 200000.00, '2025-07-07 04:42:40'),
(8, 6, 1, 1, '2025-07-16', 300000.00, '2025-07-07 10:46:36'),
(9, 6, 2, 2, '2025-07-15', 300000.00, '2025-07-07 10:46:36'),
(10, 7, 4, 1, '2025-08-02', 500000.00, '2025-07-07 10:46:36'),
(11, 9, 5, 2, '2025-09-11', 200000.00, '2025-07-07 10:46:36'),
(12, 10, 3, 1, '2025-07-13', 50000.00, '2025-07-07 10:46:36');

-- --------------------------------------------------------

--
-- Stand-in structure for view `confirmed_premium_bookings`
-- (See below for the actual view)
--
CREATE TABLE `confirmed_premium_bookings` (
`booking_id` int
,`customer_name` varchar(101)
,`email` varchar(100)
,`total_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `date_of_birth` date DEFAULT NULL,
  `id_card_number` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `date_of_birth`, `id_card_number`, `created_at`) VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '+62-888-999-000', 'Jl. Kebon Jeruk No. 1', '1985-05-15', '3171051505850001', '2025-07-07 04:41:50'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '+62-813-9876543', 'Jl. Menteng No. 2', '1990-08-22', '3171052208900002', '2025-07-07 04:41:50'),
(3, 'Ahmad', 'Wijaya', 'ahmad.wijaya@email.com', '+62-814-5555666', 'Jl. Kebayoran No. 3', '1988-12-10', '3171051012880003', '2025-07-07 04:41:50'),
(4, 'Maria', 'Gonzalez', 'maria.gonzalez@email.com', '+62-815-1111222', 'Jl. Senayan No. 4', '1992-03-28', '3171052803920004', '2025-07-07 04:41:50'),
(5, 'David', 'Johnson', 'david.johnson@email.com', '+62-816-7777888', 'Jl. Kemang No. 5', '1987-11-05', '3171050511870005', '2025-07-07 04:41:50'),
(6, 'Test', 'User', 'test@email.com', '+62-800-000000', NULL, NULL, NULL, '2025-07-07 04:51:10'),
(7, 'Rizky', 'Pratama', 'rizky.pratama@email.com', '+62-812-1111-2222', 'Jl. Merdeka No. 10, Bandung', '1995-02-20', '3273012002950001', '2025-07-07 10:44:14'),
(8, 'Indah', 'Permatasari', 'indah.permatasari@email.com', '+62-813-2222-3333', 'Jl. Gatot Subroto No. 25, Medan', '1993-07-11', '1271021107930002', '2025-07-07 10:44:14'),
(9, 'Agus', 'Salim', 'agus.salim@email.com', '+62-814-3333-4444', 'Jl. Pahlawan No. 5, Surabaya', '1989-08-17', '3578011708890003', '2025-07-07 10:44:14'),
(10, 'Dewi', 'Lestari', 'dewi.lestari@email.com', '+62-815-4444-5555', 'Jl. Sunset Road No. 88, Kuta', '1998-11-30', '5103013011980004', '2025-07-07 10:44:14'),
(11, 'Eko', 'Prasetyo', 'eko.prasetyo@email.com', '+62-816-5555-6666', 'Jl. Gajah Mada No. 101, Jakarta', '1991-04-05', '3174010504910005', '2025-07-07 10:44:14');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `after_customer_delete` AFTER DELETE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, old_values, user_name)
    VALUES ('customers', 'DELETE', 
            JSON_OBJECT('customer_id', OLD.customer_id, 'first_name', OLD.first_name, 
                       'last_name', OLD.last_name),
            USER())$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_customer_insert` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, new_values, user_name)
    VALUES ('customers', 'INSERT', 
            JSON_OBJECT('customer_id', NEW.customer_id, 'first_name', NEW.first_name, 
                       'last_name', NEW.last_name, 'email', NEW.email),
            USER())$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_preferences`
--

CREATE TABLE `customer_preferences` (
  `preference_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `preferred_room_type` varchar(50) DEFAULT NULL,
  `dietary_restrictions` text,
  `special_requests` text,
  `newsletter_subscription` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer_preferences`
--

INSERT INTO `customer_preferences` (`preference_id`, `customer_id`, `preferred_room_type`, `dietary_restrictions`, `special_requests`, `newsletter_subscription`, `created_at`) VALUES
(1, 1, 'Deluxe Room', 'Vegetarian', 'Extra pillows', 1, '2025-07-07 04:42:02'),
(2, 2, 'Suite', 'No seafood', 'Late check-out', 0, '2025-07-07 04:42:02'),
(3, 3, 'Standard Double', 'Halal food only', 'Non-smoking room', 1, '2025-07-07 04:42:02'),
(4, 4, 'Presidential Suite', 'Gluten-free', 'City view room', 1, '2025-07-07 04:42:02'),
(5, 5, 'Standard Single', 'No restrictions', 'Quiet room', 0, '2025-07-07 04:42:02'),
(6, 6, 'Standard Double', 'No spicy food', 'High floor', 1, '2025-07-07 10:44:44'),
(7, 7, 'Suite', 'Vegan', 'Early check-in', 1, '2025-07-07 10:44:44'),
(8, 8, 'Deluxe Room', 'No nuts', 'Extra bed', 0, '2025-07-07 10:44:44'),
(9, 9, 'Suite', 'No beef', 'Honeymoon setup', 1, '2025-07-07 10:44:44'),
(10, 10, 'Standard Single', 'No restrictions', 'Airport pickup', 0, '2025-07-07 10:44:44');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone`, `position`, `department`, `hire_date`, `salary`, `is_active`, `created_at`) VALUES
(1, 'Siti', 'Nurhaliza', 'siti.nurhaliza@hotel.com', '+62-817-1111111', 'Manager', 'Management', '2020-01-15', 15000000.00, 1, '2025-07-07 04:42:53'),
(2, 'Budi', 'Santoso', 'budi.santoso@hotel.com', '+62-818-2222222', 'Receptionist', 'Front Office', '2021-03-20', 5000000.00, 1, '2025-07-07 04:42:53'),
(3, 'Rina', 'Kartika', 'rina.kartika@hotel.com', '+62-819-3333333', 'Housekeeper', 'Housekeeping', '2021-06-10', 4000000.00, 1, '2025-07-07 04:42:53'),
(4, 'Dedi', 'Kurniawan', 'dedi.kurniawan@hotel.com', '+62-820-4444444', 'Chef', 'Kitchen', '2020-08-05', 8000000.00, 1, '2025-07-07 04:42:53'),
(5, 'Lisa', 'Permata', 'lisa.permata@hotel.com', '+62-821-5555555', 'Spa Therapist', 'Spa', '2022-02-14', 6000000.00, 1, '2025-07-07 04:42:53'),
(6, 'Sari', 'Dewi', 'sari.dewi@hotel.com', '+62-822-6666-7777', 'Accountant', 'Finance', '2022-05-10', 9000000.00, 1, '2025-07-07 10:44:58'),
(7, 'Andi', 'Wijaya', 'andi.wijaya@hotel.com', '+62-823-7777-8888', 'IT Support', 'IT', '2023-01-15', 7500000.00, 1, '2025-07-07 10:44:58'),
(8, 'Citra', 'Ayu', 'citra.ayu@hotel.com', '+62-824-8888-9999', 'Marketing Executive', 'Marketing', '2022-08-20', 8500000.00, 1, '2025-07-07 10:44:58'),
(9, 'Fajar', 'Nugroho', 'fajar.nugroho@hotel.com', '+62-825-9999-0000', 'Head of Security', 'Security', '2019-11-01', 12000000.00, 1, '2025-07-07 10:44:58');

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `hotel_id` int NOT NULL,
  `hotel_name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `star_rating` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`hotel_id`, `hotel_name`, `address`, `city`, `phone`, `email`, `star_rating`, `created_at`) VALUES
(1, 'Grand Hotel Jakarta', 'Jl. Sudirman No. 123', 'Jakarta', '+62-21-12345678', 'info@grandhoteljakarta.com', 5, '2025-07-07 04:41:05'),
(2, 'Bali Beach Resort', 'Jl. Pantai Kuta No. 456', 'Denpasar', '+62-361-987654', 'reservation@balibeachresort.com', 4, '2025-07-07 04:41:05'),
(3, 'Yogya Heritage Hotel', 'Jl. Malioboro No. 789', 'Yogyakarta', '+62-274-555666', 'contact@yogyaheritage.com', 3, '2025-07-07 04:41:05'),
(4, 'Surabaya Business Hotel', 'Jl. Pemuda No. 321', 'Surabaya', '+62-31-444555', 'info@surabayabusiness.com', 4, '2025-07-07 04:41:05'),
(5, 'Bandung Mountain View', 'Jl. Braga No. 654', 'Bandung', '+62-22-777888', 'reservation@bandungmountain.com', 3, '2025-07-07 04:41:05'),
(6, 'Grand Hyatt Bali', 'Kawasan Wisata Nusa Dua BTDC', 'Denpasar', '+62-361-771234', 'bali.grand@hyatt.com', 5, '2025-07-07 10:43:34'),
(7, 'Sheraton Bandung Hotel & Towers', 'Jl. Ir. H. Juanda No. 390', 'Bandung', '+62-22-2500303', 'sheraton.bandung@sheraton.com', 5, '2025-07-07 10:43:34'),
(8, 'JW Marriott Hotel Medan', 'Jl. Putri Hijau No. 10', 'Medan', '+62-61-4553333', 'mhrs.mesmc.reservation@marriotthotels.com', 5, '2025-07-07 10:43:34'),
(9, 'The Ritz-Carlton Surabaya', 'Jl. Basuki Rahmat No. 67-69', 'Surabaya', '+62-31-5482000', 'rc.subrz.reservation@ritzcarlton.com', 5, '2025-07-07 10:43:34'),
(10, 'Four Seasons Resort Lombok', 'Jl. Raya Jati No. 1', 'Lombok', '+62-370-6128888', 'contactus.lombok@fourseasons.com', 5, '2025-07-07 10:43:34');

-- --------------------------------------------------------

--
-- Stand-in structure for view `premium_bookings`
-- (See below for the actual view)
--
CREATE TABLE `premium_bookings` (
`booking_id` int
,`booking_status` enum('confirmed','checked_in','checked_out','cancelled')
,`customer_name` varchar(101)
,`email` varchar(100)
,`total_amount` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `room_type_id` int NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `floor_number` int DEFAULT NULL,
  `status` enum('available','occupied','maintenance','cleaning') DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`room_id`, `hotel_id`, `room_type_id`, `room_number`, `floor_number`, `status`, `created_at`) VALUES
(1, 1, 1, '101', 1, 'cleaning', '2025-07-07 04:41:38'),
(2, 1, 2, '102', 1, 'cleaning', '2025-07-07 04:41:38'),
(3, 1, 3, '201', 2, 'occupied', '2025-07-07 04:41:38'),
(4, 1, 4, '301', 3, 'available', '2025-07-07 04:41:38'),
(5, 1, 5, '401', 4, 'maintenance', '2025-07-07 04:41:38'),
(6, 2, 1, '101', 1, 'available', '2025-07-07 04:41:38'),
(7, 2, 2, '102', 1, 'cleaning', '2025-07-07 04:41:38'),
(8, 2, 3, '201', 2, 'available', '2025-07-07 04:41:38'),
(9, 3, 1, '101', 1, 'available', '2025-07-07 04:41:38'),
(10, 3, 2, '102', 1, 'available', '2025-07-07 04:41:38'),
(11, 6, 3, 'D-501', 5, 'available', '2025-07-07 10:45:41'),
(12, 7, 4, 'S-808', 8, 'available', '2025-07-07 10:45:41'),
(13, 8, 2, 'DB-301', 3, 'cleaning', '2025-07-07 10:45:41'),
(14, 9, 5, 'PS-1501', 15, 'available', '2025-07-07 10:45:41'),
(15, 6, 2, 'DB-205', 2, 'maintenance', '2025-07-07 10:45:41');

--
-- Triggers `rooms`
--
DELIMITER $$
CREATE TRIGGER `after_room_update` AFTER UPDATE ON `rooms` FOR EACH ROW BEGIN
    INSERT INTO activity_logs (table_name, operation_type, old_values, new_values, user_name)
    VALUES ('rooms', 'UPDATE', 
            JSON_OBJECT('room_id', OLD.room_id, 'status', OLD.status),
            JSON_OBJECT('room_id', NEW.room_id, 'status', NEW.status),
            USER())$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `room_bookings_summary`
--

CREATE TABLE `room_bookings_summary` (
  `summary_id` int NOT NULL,
  `hotel_id` int NOT NULL,
  `room_type_id` int NOT NULL,
  `booking_date` date NOT NULL,
  `total_bookings` int DEFAULT '0',
  `total_revenue` decimal(15,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room_types`
--

CREATE TABLE `room_types` (
  `room_type_id` int NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `base_price` decimal(10,2) NOT NULL,
  `max_occupancy` int NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `room_types`
--

INSERT INTO `room_types` (`room_type_id`, `type_name`, `base_price`, `max_occupancy`, `description`, `created_at`) VALUES
(1, 'Standard Single', 500000.00, 1, 'Kamar standar dengan tempat tidur single', '2025-07-07 04:41:22'),
(2, 'Standard Double', 750000.00, 2, 'Kamar standar dengan tempat tidur double', '2025-07-07 04:41:22'),
(3, 'Deluxe Room', 1200000.00, 2, 'Kamar deluxe dengan fasilitas lengkap', '2025-07-07 04:41:22'),
(4, 'Suite', 2000000.00, 4, 'Kamar suite dengan ruang tamu terpisah', '2025-07-07 04:41:22'),
(5, 'Presidential Suite', 5000000.00, 6, 'Kamar mewah dengan fasilitas premium', '2025-07-07 04:41:22');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `service_id` int NOT NULL,
  `service_name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `service_type` enum('spa','restaurant','laundry','transport','other') DEFAULT 'other',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`service_id`, `service_name`, `description`, `price`, `service_type`, `is_active`, `created_at`) VALUES
(1, 'Spa Treatment', 'Relaxing spa treatment', 300000.00, 'spa', 1, '2025-07-07 04:42:26'),
(2, 'Airport Transfer', 'Transportation to/from airport', 150000.00, 'transport', 1, '2025-07-07 04:42:26'),
(3, 'Laundry Service', 'Laundry and dry cleaning', 50000.00, 'laundry', 1, '2025-07-07 04:42:26'),
(4, 'Fine Dining', 'Gourmet dinner at hotel restaurant', 500000.00, 'restaurant', 1, '2025-07-07 04:42:26'),
(5, 'Room Service', '24-hour room service', 100000.00, 'other', 1, '2025-07-07 04:42:26');

-- --------------------------------------------------------

--
-- Structure for view `available_rooms`
--
DROP TABLE IF EXISTS `available_rooms`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `available_rooms`  AS SELECT `rooms`.`room_id` AS `room_id`, `rooms`.`room_number` AS `room_number`, `rooms`.`floor_number` AS `floor_number`, `rooms`.`status` AS `status` FROM `rooms` WHERE (`rooms`.`status` = 'available') ;

-- --------------------------------------------------------

--
-- Structure for view `booking_details`
--
DROP TABLE IF EXISTS `booking_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `booking_details`  AS SELECT `b`.`booking_id` AS `booking_id`, concat(`c`.`first_name`,' ',`c`.`last_name`) AS `customer_name`, `c`.`email` AS `email`, `c`.`phone` AS `phone`, `b`.`check_in_date` AS `check_in_date`, `b`.`check_out_date` AS `check_out_date`, `b`.`total_amount` AS `total_amount`, `b`.`booking_status` AS `booking_status` FROM (`bookings` `b` join `customers` `c` on((`b`.`customer_id` = `c`.`customer_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `confirmed_premium_bookings`
--
DROP TABLE IF EXISTS `confirmed_premium_bookings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `confirmed_premium_bookings`  AS SELECT `premium_bookings`.`booking_id` AS `booking_id`, `premium_bookings`.`customer_name` AS `customer_name`, `premium_bookings`.`email` AS `email`, `premium_bookings`.`total_amount` AS `total_amount` FROM `premium_bookings` WHERE (`premium_bookings`.`booking_status` = 'confirmed')WITH CASCADED CHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `premium_bookings`
--
DROP TABLE IF EXISTS `premium_bookings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `premium_bookings`  AS SELECT `booking_details`.`booking_id` AS `booking_id`, `booking_details`.`customer_name` AS `customer_name`, `booking_details`.`email` AS `email`, `booking_details`.`total_amount` AS `total_amount`, `booking_details`.`booking_status` AS `booking_status` FROM `booking_details` WHERE (`booking_details`.`total_amount` > 2000000)WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `idx_dates_status` (`check_in_date`,`check_out_date`,`booking_status`);

--
-- Indexes for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD PRIMARY KEY (`booking_service_id`),
  ADD KEY `booking_id` (`booking_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `id_card_number` (`id_card_number`),
  ADD KEY `idx_customer_email_phone` (`email`,`phone`);

--
-- Indexes for table `customer_preferences`
--
ALTER TABLE `customer_preferences`
  ADD PRIMARY KEY (`preference_id`),
  ADD UNIQUE KEY `customer_id` (`customer_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`hotel_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD UNIQUE KEY `unique_room` (`hotel_id`,`room_number`),
  ADD KEY `room_type_id` (`room_type_id`);

--
-- Indexes for table `room_bookings_summary`
--
ALTER TABLE `room_bookings_summary`
  ADD PRIMARY KEY (`summary_id`),
  ADD KEY `idx_hotel_roomtype_date` (`hotel_id`,`room_type_id`,`booking_date`);

--
-- Indexes for table `room_types`
--
ALTER TABLE `room_types`
  ADD PRIMARY KEY (`room_type_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `booking_services`
--
ALTER TABLE `booking_services`
  MODIFY `booking_service_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `customer_preferences`
--
ALTER TABLE `customer_preferences`
  MODIFY `preference_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `hotel_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `room_bookings_summary`
--
ALTER TABLE `room_bookings_summary`
  MODIFY `summary_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_types`
--
ALTER TABLE `room_types`
  MODIFY `room_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `service_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`);

--
-- Constraints for table `booking_services`
--
ALTER TABLE `booking_services`
  ADD CONSTRAINT `booking_services_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`),
  ADD CONSTRAINT `booking_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`);

--
-- Constraints for table `customer_preferences`
--
ALTER TABLE `customer_preferences`
  ADD CONSTRAINT `customer_preferences_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`),
  ADD CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
