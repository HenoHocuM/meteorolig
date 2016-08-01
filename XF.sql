-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 
-- Версия на сървъра: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `XF`
--
create database if not exists XF;
use XF;
-- --------------------------------------------------------

--
-- Структура на таблица `building`
--

CREATE TABLE `building` (
  `BuildingID` int(12) NOT NULL,
  `CityID` int(12) NOT NULL,
  `Name` varchar(8) NOT NULL,
  `Floors` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Схема на данните от таблица `building`
--

INSERT INTO `building` (`BuildingID`, `CityID`, `Name`, `Floors`) VALUES
(2, 1, 'Bilding2', 4),
(3, 1, 'Building', 2),
(4, 2, 'Building', 2),
(5, 2, 'Building', 3);

-- --------------------------------------------------------

--
-- Структура на таблица `city`
--

CREATE TABLE `city` (
  `CityID` int(12) NOT NULL,
  `CountryID` int(12) NOT NULL,
  `Name` varchar(8) NOT NULL,
  `Population` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Схема на данните от таблица `city`
--

INSERT INTO `city` (`CityID`, `CountryID`, `Name`, `Population`) VALUES
(1, 4, 'Pazardji', 60000),
(2, 4, 'Plovdiv', 1000000),
(3, 4, 'Varna', 800000),
(4, 1, 'Abadan', 300);

-- --------------------------------------------------------

--
-- Структура на таблица `country`
--

CREATE TABLE `country` (
  `CountryID` int(12) NOT NULL,
  `Name` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Схема на данните от таблица `country`
--

INSERT INTO `country` (`CountryID`, `Name`) VALUES
(1, 'Iran'),
(2, 'Irak'),
(3, 'Butan'),
(4, 'Bulgaria');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `building`
--
ALTER TABLE `building`
  ADD PRIMARY KEY (`BuildingID`),
  ADD KEY `CityID` (`CityID`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`CityID`),
  ADD KEY `CountryID` (`CountryID`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`CountryID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `building`
--
ALTER TABLE `building`
  MODIFY `BuildingID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `CityID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `CountryID` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Ограничения за дъмпнати таблици
--

--
-- Ограничения за таблица `building`
--
ALTER TABLE `building`
  ADD CONSTRAINT `building_ibfk_1` FOREIGN KEY (`CityID`) REFERENCES `city` (`CityID`);

--
-- Ограничения за таблица `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_ibfk_1` FOREIGN KEY (`CountryID`) REFERENCES `country` (`CountryID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*Task 1*/
SELECT ctr.Name, sum(ct.Population) as sumpop
	FROM country as ctr
	inner join city as ct
	on ctr.CountryID = ct.CountryID
	group by ctr.Name
	having sumpop < 400
/*__________________________________________________________*/
/*Task 2*/
select cnt.CountryID, cnt.Name
	from country as cnt 
	left join
	(SELECT ct.CountryID, COUNT(bd.BuildingID) as CountBuildings FROM 
	city as ct 
	inner join building as bd
	on bd.CityID = ct.CityID
	group by ct.CountryID) tmp
	on cnt.CountryID = tmp.CountryID
	where CountBuildings is NULL
/*__________________________________________________________*/