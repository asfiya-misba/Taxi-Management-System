-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2021 at 07:11 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `carrental`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelled_bookings` ()  SELECT * FROM tblbooking
WHERE STATUS=2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `confirmed_bookings` ()  SELECT * FROM tblbooking
WHERE STATUS=1$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `updationDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `UserName`, `Password`, `updationDate`) VALUES
(1, 'admin', '5c428d8875d2948607f3e3fe134d71b4', '2020-12-28 12:22:38');

-- --------------------------------------------------------

--
-- Table structure for table `tblbackup`
--

CREATE TABLE `tblbackup` (
  `id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `action` varchar(20) NOT NULL,
  `cdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblbackup`
--

INSERT INTO `tblbackup` (`id`, `booking_id`, `action`, `cdate`) VALUES
(1, 15, 'Inserted', '2021-01-13'),
(2, 7, 'Deleted', '2021-01-13');

-- --------------------------------------------------------

--
-- Table structure for table `tblbooking`
--

CREATE TABLE `tblbooking` (
  `id` int(11) NOT NULL,
  `userEmail` varchar(100) DEFAULT NULL,
  `VehicleId` int(11) DEFAULT NULL,
  `FromDate` varchar(20) DEFAULT NULL,
  `ToDate` varchar(20) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `Status` int(11) DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbooking`
--

INSERT INTO `tblbooking` (`id`, `userEmail`, `VehicleId`, `FromDate`, `ToDate`, `message`, `Status`, `PostingDate`) VALUES
(8, 'test@gmail.com', 6, '01/02/2021', '04/02/2021', 'Make sure the taxi is well sanitized.', 0, '2021-01-12 17:47:50'),
(10, 'test@gmail.com', 10, '15/01/2021', '25/01/2021', 'Procedure testing', 2, '2021-01-13 15:16:06'),
(11, 'test@gmail.com', 7, '26/01/2021', '28/01/2021', 'Procedure testing', 2, '2021-01-13 15:16:42'),
(15, 'ayaan@gmail.com', 9, '28/01/2021', '30/01/2021', 'Airport Drop', 0, '2021-01-13 18:06:31'),
(18, 'test@gmail.com', 9, '01/02/2021', '05/02/2021', 'Sight-seeing', 0, '2021-01-13 17:42:14');

--
-- Triggers `tblbooking`
--
DELIMITER $$
CREATE TRIGGER `delete_backup` BEFORE DELETE ON `tblbooking` FOR EACH ROW INSERT INTO tblbackup VALUES(null,OLD.id,"Deleted",NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_backup` BEFORE INSERT ON `tblbooking` FOR EACH ROW INSERT INTO tblbackup VALUES(null,NEW.id,"Inserted",NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblbrands`
--

CREATE TABLE `tblbrands` (
  `id` int(11) NOT NULL,
  `BrandName` varchar(120) NOT NULL,
  `CreationDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblbrands`
--

INSERT INTO `tblbrands` (`id`, `BrandName`, `CreationDate`, `UpdationDate`) VALUES
(8, 'Toyota', '2021-01-12 09:18:36', NULL),
(9, 'Maruti Suzuki', '2021-01-12 10:27:37', NULL),
(10, 'Mahindra', '2021-01-12 14:09:00', NULL),
(11, 'Tata', '2021-01-12 16:09:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblcontactusinfo`
--

CREATE TABLE `tblcontactusinfo` (
  `id` int(11) NOT NULL,
  `Address` tinytext DEFAULT NULL,
  `EmailId` varchar(255) DEFAULT NULL,
  `ContactNo` char(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblcontactusinfo`
--

INSERT INTO `tblcontactusinfo` (`id`, `Address`, `EmailId`, `ContactNo`) VALUES
(1, 'RNSIT, Bengaluru																								', 'test@test.com', '1234567890');

-- --------------------------------------------------------

--
-- Table structure for table `tblcontactusquery`
--

CREATE TABLE `tblcontactusquery` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `EmailId` varchar(120) DEFAULT NULL,
  `ContactNumber` char(11) DEFAULT NULL,
  `Message` longtext DEFAULT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblcontactusquery`
--

INSERT INTO `tblcontactusquery` (`id`, `name`, `EmailId`, `ContactNumber`, `Message`, `PostingDate`, `status`) VALUES
(1, 'Elena', 'elena@gmail.com', '2147483647', 'Is the service available on national holidays?', '2021-01-12 10:03:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblpages`
--

CREATE TABLE `tblpages` (
  `id` int(11) NOT NULL,
  `PageName` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `detail` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblpages`
--

INSERT INTO `tblpages` (`id`, `PageName`, `type`, `detail`) VALUES
(1, 'Terms and Conditions', 'terms', '																				<div><img alt=\"RNSIT - MBA Official | Facebook\" class=\"n3VNCb\" src=\"data:image/jpeg;base64,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\" data-iml=\"5447\" style=\"width: 403.125px; height: 430px; margin: 0px;\"></div><div><br></div><div><br></div><div><br></div><div>This is a DBMS Project developed by Asfiya Misba &amp; Bhavana G</div><div>Dept. of CSE, RNSIT Bengaluru<br></div><div><br></div>\r\n										\r\n										'),
(2, 'Privacy Policy', 'privacy', '<span style=\"color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif; font-size: 14px; text-align: justify;\">This is developed by Asfiya Misba & Bhavana G of RNSIT, Bangalore for demonstration purpose only.</span>'),
(3, 'About Us ', 'aboutus', '																				<div>Developed by:</div><div><br></div><div><span style=\"font-weight: bold;\">NAME&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-weight: bold;\"> USN</span></div><div>Asfiya Misba&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1RN18CS021</div><div>Bhavana G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1RN18CS029</div><div><br></div><div><span style=\"font-weight: bold;\">Dept. of CSE, RNSIT Bengaluru</span><br></div>\r\n										\r\n										');

-- --------------------------------------------------------

--
-- Table structure for table `tblsubscribers`
--

CREATE TABLE `tblsubscribers` (
  `id` int(11) NOT NULL,
  `SubscriberEmail` varchar(120) DEFAULT NULL,
  `PostingDate` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblsubscribers`
--

INSERT INTO `tblsubscribers` (`id`, `SubscriberEmail`, `PostingDate`) VALUES
(1, 'clay@gmail.com', '2021-01-10 16:35:32');

-- --------------------------------------------------------

--
-- Table structure for table `tbltestimonial`
--

CREATE TABLE `tbltestimonial` (
  `id` int(11) NOT NULL,
  `UserEmail` varchar(100) NOT NULL,
  `Testimonial` mediumtext NOT NULL,
  `PostingDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbltestimonial`
--

INSERT INTO `tbltestimonial` (`id`, `UserEmail`, `Testimonial`, `PostingDate`, `status`) VALUES
(1, 'ayaan@gmail.com', 'Wonderful experience! ', '2021-01-10 07:44:31', 1),
(2, 'test@gmail.com', 'Great service. Looking forward to book another ride!', '2021-01-05 07:46:05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `id` int(11) NOT NULL,
  `FullName` varchar(120) DEFAULT NULL,
  `EmailId` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `ContactNo` char(11) DEFAULT NULL,
  `dob` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `Country` varchar(100) DEFAULT NULL,
  `RegDate` timestamp NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`id`, `FullName`, `EmailId`, `Password`, `ContactNo`, `dob`, `Address`, `City`, `Country`, `RegDate`, `UpdationDate`) VALUES
(1, 'Clay', 'clay@gmail.com', 'f925916e2754e5e03f75dd58a5733251', '2147483647', '03/08/1994', 'Chandra Layout', 'Bangalore', 'India', '2021-01-04 19:59:27', '2021-01-07 21:02:58'),
(2, 'Ayaan', 'ayaan@gmail.com', 'f925916e2754e5e03f75dd58a5733251', '8285703354', '29/08/1998', 'Falaknuma', 'Hyderabad', 'India', '2021-01-04 20:00:49', '2021-01-07 21:03:09'),
(3, 'Elena', 'elena@gmail.com', 'f09df7868d52e12bba658982dbd79821', '09999857868', '25/07/1990', 'Powai', 'Mumbai', 'India', '2021-01-04 20:01:43', '2021-01-07 21:07:41'),
(4, 'Penguin', 'test@gmail.com', '5c428d8875d2948607f3e3fe134d71b4', '9999857868', '28/09/2000', 'RNSIT', 'Bangalore', 'Bangalore', '2017-06-17 20:03:36', '2021-01-12 14:34:25');

-- --------------------------------------------------------

--
-- Table structure for table `tblvehicles`
--

CREATE TABLE `tblvehicles` (
  `id` int(11) NOT NULL,
  `VehiclesTitle` varchar(150) DEFAULT NULL,
  `VehiclesBrand` int(11) DEFAULT NULL,
  `VehiclesOverview` longtext DEFAULT NULL,
  `PricePerDay` int(11) DEFAULT NULL,
  `FuelType` varchar(100) DEFAULT NULL,
  `ModelYear` int(6) DEFAULT NULL,
  `SeatingCapacity` int(11) DEFAULT NULL,
  `Vimage1` varchar(120) DEFAULT NULL,
  `Vimage2` varchar(120) DEFAULT NULL,
  `Vimage3` varchar(120) DEFAULT NULL,
  `Vimage4` varchar(120) DEFAULT NULL,
  `Vimage5` varchar(120) DEFAULT NULL,
  `AirConditioner` int(11) DEFAULT NULL,
  `PowerDoorLocks` int(11) DEFAULT NULL,
  `AntiLockBrakingSystem` int(11) DEFAULT NULL,
  `BrakeAssist` int(11) DEFAULT NULL,
  `PowerSteering` int(11) DEFAULT NULL,
  `DriverAirbag` int(11) DEFAULT NULL,
  `PassengerAirbag` int(11) DEFAULT NULL,
  `PowerWindows` int(11) DEFAULT NULL,
  `CDPlayer` int(11) DEFAULT NULL,
  `CentralLocking` int(11) DEFAULT NULL,
  `CrashSensor` int(11) DEFAULT NULL,
  `LeatherSeats` int(11) DEFAULT NULL,
  `RegDate` timestamp NOT NULL DEFAULT current_timestamp(),
  `UpdationDate` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblvehicles`
--

INSERT INTO `tblvehicles` (`id`, `VehiclesTitle`, `VehiclesBrand`, `VehiclesOverview`, `PricePerDay`, `FuelType`, `ModelYear`, `SeatingCapacity`, `Vimage1`, `Vimage2`, `Vimage3`, `Vimage4`, `Vimage5`, `AirConditioner`, `PowerDoorLocks`, `AntiLockBrakingSystem`, `BrakeAssist`, `PowerSteering`, `DriverAirbag`, `PassengerAirbag`, `PowerWindows`, `CDPlayer`, `CentralLocking`, `CrashSensor`, `LeatherSeats`, `RegDate`, `UpdationDate`) VALUES
(6, 'Etios', 8, 'Toyota Platinum Etios is a 5 seater Sedan', 10, 'Petrol', 2018, 4, 'Etios 1.jpg', 'Etios 2.jpg', 'Etios 3.jpg', 'Etios 4.jpg', '', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '2021-01-12 09:31:49', NULL),
(7, 'Swift Dzire', 9, '4 seater sedan', 9, 'Diesel', 2020, 4, 'dzire 1.jpg', 'dzire 2.jpg', 'dzire 3.jpg', 'dzire 4.jpg', 'dzire 5.jpg', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '2021-01-12 10:34:31', NULL),
(8, 'Innova', 8, '8 seater car', 13, 'Petrol', 2019, 8, 'innova 1.jpg', 'innova 2.jpg', 'innova 3.jpg', 'innova 4.jpg', 'iinova 5.jpg', 1, NULL, NULL, NULL, 1, NULL, 1, 1, 1, NULL, NULL, NULL, '2021-01-12 14:04:00', NULL),
(9, 'Mahindra Xuv 500', 10, '8 seater SUV', 14, 'Petrol', 2019, 8, 'xuv 1.jpg', 'xuv 2.jpeg', 'xuv 3.jpeg', 'xuv 4.jpg', 'xuv 5.jpg', 1, 1, NULL, NULL, 1, 1, 1, 1, 1, NULL, NULL, NULL, '2021-01-12 14:14:30', NULL),
(10, 'Indica', 11, '4 seater car', 8, 'Diesel', 2017, 4, 'indica 1.jpg', 'indica 2.jpg', 'indica 3.jpg', 'indica 4.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '2021-01-12 16:17:22', NULL),
(11, 'WagonR', 9, '4 seater car', 9, 'Diesel', 2016, 4, 'wagonr1.png', 'wagonr2.jpg', 'wagonr3.jpeg', 'wagonr4.png', '', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, '2021-01-12 16:27:25', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbackup`
--
ALTER TABLE `tblbackup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbooking`
--
ALTER TABLE `tblbooking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblbrands`
--
ALTER TABLE `tblbrands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcontactusinfo`
--
ALTER TABLE `tblcontactusinfo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcontactusquery`
--
ALTER TABLE `tblcontactusquery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblpages`
--
ALTER TABLE `tblpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblsubscribers`
--
ALTER TABLE `tblsubscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbltestimonial`
--
ALTER TABLE `tbltestimonial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblvehicles`
--
ALTER TABLE `tblvehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblbackup`
--
ALTER TABLE `tblbackup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblbooking`
--
ALTER TABLE `tblbooking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `tblbrands`
--
ALTER TABLE `tblbrands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tblcontactusinfo`
--
ALTER TABLE `tblcontactusinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblcontactusquery`
--
ALTER TABLE `tblcontactusquery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblpages`
--
ALTER TABLE `tblpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tblsubscribers`
--
ALTER TABLE `tblsubscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbltestimonial`
--
ALTER TABLE `tbltestimonial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblvehicles`
--
ALTER TABLE `tblvehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
