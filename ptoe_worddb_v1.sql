-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 30, 2014 at 08:27 AM
-- Server version: 5.5.37-0ubuntu0.13.10.1
-- PHP Version: 5.5.3-1ubuntu2.6

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ptoe_worddb`
--
CREATE DATABASE IF NOT EXISTS `ptoe_worddb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ptoe_worddb`;

-- --------------------------------------------------------

--
-- Table structure for table `antonyms`
--
-- Creation: Nov 25, 2014 at 07:15 AM
--

DROP TABLE IF EXISTS `antonyms`;
CREATE TABLE IF NOT EXISTS `antonyms` (
  `antonym_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `word_id` bigint(20) unsigned NOT NULL,
  `partofspeech` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`antonym_id`),
  UNIQUE KEY `antonym_id` (`antonym_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `antonyms`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `definitions`
--
-- Creation: Nov 30, 2014 at 08:24 AM
--

DROP TABLE IF EXISTS `definitions`;
CREATE TABLE IF NOT EXISTS `definitions` (
  `definition_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `definition` varchar(1024) NOT NULL,
  `word_id` bigint(20) unsigned NOT NULL,
  `partofspeech` int(11) NOT NULL,
  `pronunciation` varchar(128) NOT NULL,
  `audio_file` varchar(1024) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`definition_id`),
  UNIQUE KEY `definition_id` (`definition_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `definitions`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `homonyms`
--
-- Creation: Nov 25, 2014 at 07:09 AM
--

DROP TABLE IF EXISTS `homonyms`;
CREATE TABLE IF NOT EXISTS `homonyms` (
  `homonym_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `word_id` bigint(20) unsigned NOT NULL,
  `partofspeech` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`homonym_id`),
  UNIQUE KEY `homonym_id` (`homonym_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `homonyms`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--
-- Creation: Nov 25, 2014 at 07:15 AM
--

DROP TABLE IF EXISTS `scores`;
CREATE TABLE IF NOT EXISTS `scores` (
  `score_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_vocab_id` bigint(20) unsigned NOT NULL,
  `count` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`score_id`),
  UNIQUE KEY `score_id` (`score_id`),
  KEY `user_vocab_id` (`user_vocab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `scores`:
--   `user_vocab_id`
--       `user_vocab` -> `user_vocab_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `sentences`
--
-- Creation: Nov 30, 2014 at 05:57 AM
--

DROP TABLE IF EXISTS `sentences`;
CREATE TABLE IF NOT EXISTS `sentences` (
  `sentence_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sentence` varchar(1024) NOT NULL,
  `word_id` bigint(20) unsigned NOT NULL,
  `level` int(11) NOT NULL COMMENT 'difficulty level',
  `partofspeech` int(11) NOT NULL COMMENT 'parts of speech, noun, verb, etc',
  `state` int(11) NOT NULL COMMENT 'correct usage in sentence',
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sentence_id`),
  UNIQUE KEY `sentence_id` (`sentence_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `sentences`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `spellings`
--
-- Creation: Nov 30, 2014 at 07:38 AM
--

DROP TABLE IF EXISTS `spellings`;
CREATE TABLE IF NOT EXISTS `spellings` (
  `spelling_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `spelling` varchar(256) NOT NULL,
  `word_id` bigint(20) unsigned NOT NULL,
  `state` int(11) NOT NULL COMMENT 'state of the word',
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`spelling_id`),
  UNIQUE KEY `spelling_id` (`spelling_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `spellings`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `synonyms`
--
-- Creation: Nov 30, 2014 at 07:05 AM
--

DROP TABLE IF EXISTS `synonyms`;
CREATE TABLE IF NOT EXISTS `synonyms` (
  `synonym_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `synonym` varchar(256) NOT NULL,
  `word_id` bigint(20) unsigned NOT NULL,
  `partofspeech` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`synonym_id`),
  UNIQUE KEY `synomyn_id` (`synonym_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `synonyms`:
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `user_vocab`
--
-- Creation: Nov 25, 2014 at 07:29 AM
--

DROP TABLE IF EXISTS `user_vocab`;
CREATE TABLE IF NOT EXISTS `user_vocab` (
  `user_vocab_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `word_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `state` int(11) NOT NULL DEFAULT '0' COMMENT 'new,understood,failed',
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_vocab_id`),
  UNIQUE KEY `user_vocab_id` (`user_vocab_id`),
  KEY `user_id` (`user_id`),
  KEY `word_id` (`word_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `user_vocab`:
--   `user_id`
--       `users` -> `user_id`
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `vocab`
--
-- Creation: Nov 25, 2014 at 07:26 AM
--

DROP TABLE IF EXISTS `vocab`;
CREATE TABLE IF NOT EXISTS `vocab` (
  `vocab_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vocab_list_id` bigint(20) unsigned NOT NULL,
  `word_id` bigint(20) unsigned NOT NULL,
  `rank` int(11) NOT NULL COMMENT 'rank/order in list',
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vocab_id`),
  UNIQUE KEY `vocab_id` (`vocab_id`),
  KEY `word_id` (`word_id`),
  KEY `vocab_list_id` (`vocab_list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- RELATIONS FOR TABLE `vocab`:
--   `vocab_list_id`
--       `vocab_list` -> `vocab_list_id`
--   `word_id`
--       `vocab_words` -> `word_id`
--

-- --------------------------------------------------------

--
-- Table structure for table `vocab_list`
--
-- Creation: Nov 25, 2014 at 06:57 AM
--

DROP TABLE IF EXISTS `vocab_list`;
CREATE TABLE IF NOT EXISTS `vocab_list` (
  `vocab_list_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vocab_list_id`),
  UNIQUE KEY `vocab_list_id` (`vocab_list_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `vocab_words`
--
-- Creation: Nov 30, 2014 at 04:28 AM
--

DROP TABLE IF EXISTS `vocab_words`;
CREATE TABLE IF NOT EXISTS `vocab_words` (
  `word_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `level` int(11) NOT NULL COMMENT 'difficulty level',
  `language` int(11) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  `creation` timestamp NULL DEFAULT NULL,
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`word_id`),
  UNIQUE KEY `vocab_id` (`word_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='definition of vocabulary words' AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `antonyms`
--
ALTER TABLE `antonyms`
  ADD CONSTRAINT `antonyms_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `definitions`
--
ALTER TABLE `definitions`
  ADD CONSTRAINT `definitions_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `homonyms`
--
ALTER TABLE `homonyms`
  ADD CONSTRAINT `homonyms_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `scores`
--
ALTER TABLE `scores`
  ADD CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`user_vocab_id`) REFERENCES `user_vocab` (`user_vocab_id`) ON DELETE CASCADE;

--
-- Constraints for table `sentences`
--
ALTER TABLE `sentences`
  ADD CONSTRAINT `sentences_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `spellings`
--
ALTER TABLE `spellings`
  ADD CONSTRAINT `spellings_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `synonyms`
--
ALTER TABLE `synonyms`
  ADD CONSTRAINT `synonyms_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;

--
-- Constraints for table `vocab`
--
ALTER TABLE `vocab`
  ADD CONSTRAINT `vocab_ibfk_2` FOREIGN KEY (`vocab_list_id`) REFERENCES `vocab_list` (`vocab_list_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vocab_ibfk_1` FOREIGN KEY (`word_id`) REFERENCES `vocab_words` (`word_id`) ON DELETE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
