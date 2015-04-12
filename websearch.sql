-- phpMyAdmin SQL Dump
-- version 3.5.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 12, 2015 at 02:25 PM
-- Server version: 5.5.29
-- PHP Version: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `websearch`
--

-- --------------------------------------------------------

--
-- Table structure for table `affixes`
--

CREATE TABLE `affixes` (
  `affix_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) CHARACTER SET latin1 NOT NULL,
  `count` int(11) NOT NULL,
  `last_referenced` int(11) NOT NULL,
  PRIMARY KEY (`affix_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `affixes_keywords`
--

CREATE TABLE `affixes_keywords` (
  `affix_id` mediumint(8) unsigned NOT NULL,
  `keyword_id` mediumint(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cached_image_urls`
--

CREATE TABLE `cached_image_urls` (
  `cached_image_url_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` mediumint(8) NOT NULL,
  `path` varchar(255) NOT NULL,
  `query` varchar(255) DEFAULT NULL,
  `cached_time` int(11) NOT NULL,
  PRIMARY KEY (`cached_image_url_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cached_image_urls_keywords`
--

CREATE TABLE `cached_image_urls_keywords` (
  `cached_image_url_id` mediumint(8) unsigned NOT NULL,
  `keyword_id` mediumint(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cached_image_urls_queries`
--

CREATE TABLE `cached_image_urls_queries` (
  `cached_image_urls_queries_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cached_image_url_id` mediumint(8) unsigned NOT NULL,
  `query_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`cached_image_urls_queries_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cached_image_urls_utterances`
--

CREATE TABLE `cached_image_urls_utterances` (
  `cached_image_url_id` mediumint(8) unsigned NOT NULL,
  `utterance_id` mediumint(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `cached_urls`
--

CREATE TABLE `cached_urls` (
  `cached_url_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` mediumint(8) NOT NULL,
  `path` varchar(255) NOT NULL,
  `query` varchar(255) DEFAULT NULL,
  `cached_time` int(11) NOT NULL,
  PRIMARY KEY (`cached_url_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `cached_urls`
--

INSERT INTO `cached_urls` (`cached_url_id`, `domain_id`, `path`, `query`, `cached_time`) VALUES
(1, 1, '/', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `cached_urls_keywords`
--

CREATE TABLE `cached_urls_keywords` (
  `cached_urls_keyword_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cached_url_id` mediumint(8) unsigned NOT NULL,
  `keyword_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`cached_urls_keyword_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cached_urls_queries`
--

CREATE TABLE `cached_urls_queries` (
  `cached_urls_queries_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cached_url_id` mediumint(8) unsigned NOT NULL,
  `query_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`cached_urls_queries_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cached_urls_utterances`
--

CREATE TABLE `cached_urls_utterances` (
  `cached_urls_utterance_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `cached_url_id` mediumint(8) unsigned NOT NULL,
  `utterance_id` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`cached_urls_utterance_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `closed_morphemes`
--

CREATE TABLE `closed_morphemes` (
  `closed_morpheme_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`closed_morpheme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `closed_morphemes_keywords`
--

CREATE TABLE `closed_morphemes_keywords` (
  `closed_morpheme_id` mediumint(8) unsigned NOT NULL,
  `keyword_id` mediumint(8) unsigned NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE `domains` (
  `domain_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `scheme` varchar(10) NOT NULL DEFAULT 'http',
  `host` varchar(255) NOT NULL,
  `port` int(4) DEFAULT NULL,
  `cached_time` int(11) NOT NULL,
  PRIMARY KEY (`domain_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`domain_id`, `scheme`, `host`, `port`, `cached_time`) VALUES
(1, 'http', 'www.theage.com.au', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `keyword_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` mediumint(8) unsigned DEFAULT NULL,
  `keyword` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `last_referenced` int(11) NOT NULL,
  PRIMARY KEY (`keyword_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `language_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `iso3letter` char(3) NOT NULL COMMENT 'ISO 639-2 Code',
  `iso2letter` varchar(2) DEFAULT NULL COMMENT 'ISO 639-1 Code',
  `english_name` varchar(255) DEFAULT NULL,
  `french_name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`language_id`),
  KEY `2letter` (`iso2letter`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=486 ;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`language_id`, `iso3letter`, `iso2letter`, `english_name`, `french_name`, `active`) VALUES
(1, 'aar', 'aa', 'Afar', 'afar', 0),
(2, 'abk', 'ab', 'Abkhazian', 'abkhaze', 0),
(3, 'ace', NULL, 'Achinese', 'aceh', 0),
(4, 'ach', NULL, 'Acoli', 'acoli', 0),
(5, 'ada', NULL, 'Adangme', 'adangme', 0),
(6, 'ady', NULL, 'Adyghe; Adygei', 'adyghé', 0),
(7, 'afa', NULL, 'Afro-Asiatic languages', 'afro-asiatiques, langues', 0),
(8, 'afh', NULL, 'Afrihili', 'afrihili', 0),
(9, 'afr', 'af', 'Afrikaans', 'afrikaans', 0),
(10, 'ain', NULL, 'Ainu', 'aïnou', 0),
(11, 'aka', 'ak', 'Akan', 'akan', 0),
(12, 'akk', NULL, 'Akkadian', 'akkadien', 0),
(13, 'alb', 'sq', 'Albanian', 'albanais', 0),
(14, 'ale', NULL, 'Aleut', 'aléoute', 0),
(15, 'alg', NULL, 'Algonquian languages', 'algonquines, langues', 0),
(16, 'alt', NULL, 'Southern Altai', 'altai du Sud', 0),
(17, 'amh', 'am', 'Amharic', 'amharique', 0),
(18, 'ang', NULL, 'English, Old (ca.450-1100)', 'anglo-saxon (ca.450-1100)', 0),
(19, 'anp', NULL, 'Angika', 'angika', 0),
(20, 'apa', NULL, 'Apache languages', 'apaches, langues', 0),
(21, 'ara', 'ar', 'Arabic', 'arabe', 0),
(22, 'arc', NULL, 'Official Aramaic (700-300 BCE); Imperial Aramaic (700-300 BCE)', 'araméen d''empire (700-300 BCE)', 0),
(23, 'arg', 'an', 'Aragonese', 'aragonais', 0),
(24, 'arm', 'hy', 'Armenian', 'arménien', 0),
(25, 'arn', NULL, 'Mapudungun; Mapuche', 'mapudungun; mapuche; mapuce', 0),
(26, 'arp', NULL, 'Arapaho', 'arapaho', 0),
(27, 'art', NULL, 'Artificial languages', 'artificielles, langues', 0),
(28, 'arw', NULL, 'Arawak', 'arawak', 0),
(29, 'asm', 'as', 'Assamese', 'assamais', 0),
(30, 'ast', NULL, 'Asturian; Bable; Leonese; Asturleonese', 'asturien; bable; léonais; asturoléonais', 0),
(31, 'ath', NULL, 'Athapascan languages', 'athapascanes, langues', 0),
(32, 'aus', NULL, 'Australian languages', 'australiennes, langues', 0),
(33, 'ava', 'av', 'Avaric', 'avar', 0),
(34, 'ave', 'ae', 'Avestan', 'avestique', 0),
(35, 'awa', NULL, 'Awadhi', 'awadhi', 0),
(36, 'aym', 'ay', 'Aymara', 'aymara', 0),
(37, 'aze', 'az', 'Azerbaijani', 'azéri', 0),
(38, 'bad', NULL, 'Banda languages', 'banda, langues', 0),
(39, 'bai', NULL, 'Bamileke languages', 'bamiléké, langues', 0),
(40, 'bak', 'ba', 'Bashkir', 'bachkir', 0),
(41, 'bal', NULL, 'Baluchi', 'baloutchi', 0),
(42, 'bam', 'bm', 'Bambara', 'bambara', 0),
(43, 'ban', NULL, 'Balinese', 'balinais', 0),
(44, 'baq', 'eu', 'Basque', 'basque', 0),
(45, 'bas', NULL, 'Basa', 'basa', 0),
(46, 'bat', NULL, 'Baltic languages', 'baltes, langues', 0),
(47, 'bej', NULL, 'Beja; Bedawiyet', 'bedja', 0),
(48, 'bel', 'be', 'Belarusian', 'biélorusse', 0),
(49, 'bem', NULL, 'Bemba', 'bemba', 0),
(50, 'ben', 'bn', 'Bengali', 'bengali', 0),
(51, 'ber', NULL, 'Berber languages', 'berbères, langues', 0),
(52, 'bho', NULL, 'Bhojpuri', 'bhojpuri', 0),
(53, 'bih', 'bh', 'Bihari', 'bihari', 0),
(54, 'bik', NULL, 'Bikol', 'bikol', 0),
(55, 'bin', NULL, 'Bini; Edo', 'bini; edo', 0),
(56, 'bis', 'bi', 'Bislama', 'bichlamar', 0),
(57, 'bla', NULL, 'Siksika', 'blackfoot', 0),
(58, 'bnt', NULL, 'Bantu languages', 'bantou, langues', 0),
(59, 'bos', 'bs', 'Bosnian', 'bosniaque', 0),
(60, 'bra', NULL, 'Braj', 'braj', 0),
(61, 'bre', 'br', 'Breton', 'breton', 0),
(62, 'btk', NULL, 'Batak languages', 'batak, langues', 0),
(63, 'bua', NULL, 'Buriat', 'bouriate', 0),
(64, 'bug', NULL, 'Buginese', 'bugi', 0),
(65, 'bul', 'bg', 'Bulgarian', 'bulgare', 0),
(66, 'bur', 'my', 'Burmese', 'birman', 0),
(67, 'byn', NULL, 'Blin; Bilin', 'blin; bilen', 0),
(68, 'cad', NULL, 'Caddo', 'caddo', 0),
(69, 'cai', NULL, 'Central American Indian languages', 'amérindiennes de l''Amérique centrale,  langues', 0),
(70, 'car', NULL, 'Galibi Carib', 'karib; galibi; carib', 0),
(71, 'cat', 'ca', 'Catalan; Valencian', 'catalan; valencien', 0),
(72, 'cau', NULL, 'Caucasian languages', 'caucasiennes, langues', 0),
(73, 'ceb', NULL, 'Cebuano', 'cebuano', 0),
(74, 'cel', NULL, 'Celtic languages', 'celtiques, langues; celtes, langues', 0),
(75, 'cha', 'ch', 'Chamorro', 'chamorro', 0),
(76, 'chb', NULL, 'Chibcha', 'chibcha', 0),
(77, 'che', 'ce', 'Chechen', 'tchétchène', 0),
(78, 'chg', NULL, 'Chagatai', 'djaghataï', 0),
(79, 'chi', 'zh', 'Chinese', 'chinois', 0),
(80, 'chk', NULL, 'Chuukese', 'chuuk', 0),
(81, 'chm', NULL, 'Mari', 'mari', 0),
(82, 'chn', NULL, 'Chinook jargon', 'chinook, jargon', 0),
(83, 'cho', NULL, 'Choctaw', 'choctaw', 0),
(84, 'chp', NULL, 'Chipewyan; Dene Suline', 'chipewyan', 0),
(85, 'chr', NULL, 'Cherokee', 'cherokee', 0),
(86, 'chu', 'cu', 'Church Slavic; Old Slavonic; Church Slavonic; Old Bulgarian; Old Church Slavonic', 'slavon d''église; vieux slave; slavon liturgique; vieux bulgare', 0),
(87, 'chv', 'cv', 'Chuvash', 'tchouvache', 0),
(88, 'chy', NULL, 'Cheyenne', 'cheyenne', 0),
(89, 'cmc', NULL, 'Chamic languages', 'chames, langues', 0),
(90, 'cop', NULL, 'Coptic', 'copte', 0),
(91, 'cor', 'kw', 'Cornish', 'cornique', 0),
(92, 'cos', 'co', 'Corsican', 'corse', 0),
(93, 'cpe', NULL, 'Creoles and pidgins, English based', 'créoles et pidgins basés sur l''anglais', 0),
(94, 'cpf', NULL, 'Creoles and pidgins, French-based', 'créoles et pidgins basés sur le français', 0),
(95, 'cpp', NULL, 'Creoles and pidgins, Portuguese-based', 'créoles et pidgins basés sur le portugais', 0),
(96, 'cre', 'cr', 'Cree', 'cree', 0),
(97, 'crh', NULL, 'Crimean Tatar; Crimean Turkish', 'tatar de Crimé', 0),
(98, 'crp', NULL, 'Creoles and pidgins', 'créoles et pidgins', 0),
(99, 'csb', NULL, 'Kashubian', 'kachoube', 0),
(100, 'cus', NULL, 'Cushitic languages', 'couchitiques,  langues', 0),
(101, 'cze', 'cs', 'Czech', 'tchèque', 0),
(102, 'dak', NULL, 'Dakota', 'dakota', 0),
(103, 'dan', 'da', 'Danish', 'danois', 0),
(104, 'dar', NULL, 'Dargwa', 'dargwa', 0),
(105, 'day', NULL, 'Land Dayak languages', 'dayak, langues', 0),
(106, 'del', NULL, 'Delaware', 'delaware', 0),
(107, 'den', NULL, 'Slave (Athapascan)', 'esclave (athapascan)', 0),
(108, 'dgr', NULL, 'Dogrib', 'dogrib', 0),
(109, 'din', NULL, 'Dinka', 'dinka', 0),
(110, 'div', 'dv', 'Divehi; Dhivehi; Maldivian', 'maldivien', 0),
(111, 'doi', NULL, 'Dogri', 'dogri', 0),
(112, 'dra', NULL, 'Dravidian languages', 'dravidiennes,  langues', 0),
(113, 'dsb', NULL, 'Lower Sorbian', 'bas-sorabe', 0),
(114, 'dua', NULL, 'Duala', 'douala', 0),
(115, 'dum', NULL, 'Dutch, Middle (ca.1050-1350)', 'néerlandais moyen (ca. 1050-1350)', 0),
(116, 'dut', 'nl', 'Dutch; Flemish', 'néerlandais; flamand', 0),
(117, 'dyu', NULL, 'Dyula', 'dioula', 0),
(118, 'dzo', 'dz', 'Dzongkha', 'dzongkha', 0),
(119, 'efi', NULL, 'Efik', 'efik', 0),
(120, 'egy', NULL, 'Egyptian (Ancient)', 'égyptien', 0),
(121, 'eka', NULL, 'Ekajuk', 'ekajuk', 0),
(122, 'elx', NULL, 'Elamite', 'élamite', 0),
(123, 'eng', 'en', 'English', 'anglais', 1),
(124, 'enm', NULL, 'English, Middle (1100-1500)', 'anglais moyen (1100-1500)', 0),
(125, 'epo', 'eo', 'Esperanto', 'espéranto', 0),
(126, 'est', 'et', 'Estonian', 'estonien', 0),
(127, 'ewe', 'ee', 'Ewe', 'éwé', 0),
(128, 'ewo', NULL, 'Ewondo', 'éwondo', 0),
(129, 'fan', NULL, 'Fang', 'fang', 0),
(130, 'fao', 'fo', 'Faroese', 'féroïen', 0),
(131, 'fat', NULL, 'Fanti', 'fanti', 0),
(132, 'fij', 'fj', 'Fijian', 'fidjien', 0),
(133, 'fil', NULL, 'Filipino; Pilipino', 'filipino; pilipino', 0),
(134, 'fin', 'fi', 'Finnish', 'finnois', 0),
(135, 'fiu', NULL, 'Finno-Ugrian languages', 'finno-ougriennes,  langues', 0),
(136, 'fon', NULL, 'Fon', 'fon', 0),
(137, 'fre', 'fr', 'French', 'français', 0),
(138, 'frm', NULL, 'French, Middle (ca.1400-1600)', 'français moyen (1400-1600)', 0),
(139, 'fro', NULL, 'French, Old (842-ca.1400)', 'français ancien (842-ca.1400)', 0),
(140, 'frr', NULL, 'Northern Frisian', 'frison septentrional', 0),
(141, 'frs', NULL, 'Eastern Frisian', 'frison oriental', 0),
(142, 'fry', 'fy', 'Western Frisian', 'frison occidental', 0),
(143, 'ful', 'ff', 'Fulah', 'peul', 0),
(144, 'fur', NULL, 'Friulian', 'frioulan', 0),
(145, 'gaa', NULL, 'Ga', 'ga', 0),
(146, 'gay', NULL, 'Gayo', 'gayo', 0),
(147, 'gba', NULL, 'Gbaya', 'gbaya', 0),
(148, 'gem', NULL, 'Germanic languages', 'germaniques, langues', 0),
(149, 'geo', 'ka', 'Georgian', 'géorgien', 0),
(150, 'ger', 'de', 'German', 'allemand', 0),
(151, 'gez', NULL, 'Geez', 'guèze', 0),
(152, 'gil', NULL, 'Gilbertese', 'kiribati', 0),
(153, 'gla', 'gd', 'Gaelic; Scottish Gaelic', 'gaélique; gaélique écossais', 0),
(154, 'gle', 'ga', 'Irish', 'irlandais', 0),
(155, 'glg', 'gl', 'Galician', 'galicien', 0),
(156, 'glv', 'gv', 'Manx', 'manx; mannois', 0),
(157, 'gmh', NULL, 'German, Middle High (ca.1050-1500)', 'allemand, moyen haut (ca. 1050-1500)', 0),
(158, 'goh', NULL, 'German, Old High (ca.750-1050)', 'allemand, vieux haut (ca. 750-1050)', 0),
(159, 'gon', NULL, 'Gondi', 'gond', 0),
(160, 'gor', NULL, 'Gorontalo', 'gorontalo', 0),
(161, 'got', NULL, 'Gothic', 'gothique', 0),
(162, 'grb', NULL, 'Grebo', 'grebo', 0),
(163, 'grc', NULL, 'Greek, Ancient (to 1453)', 'grec ancien (jusqu''à 1453)', 0),
(164, 'gre', 'el', 'Greek, Modern (1453-)', 'grec moderne (après 1453)', 0),
(165, 'grn', 'gn', 'Guarani', 'guarani', 0),
(166, 'gsw', NULL, 'Swiss German; Alemannic; Alsatian', 'suisse alémanique; alémanique; alsacien', 0),
(167, 'guj', 'gu', 'Gujarati', 'goudjrati', 0),
(168, 'gwi', NULL, 'Gwich''in', 'gwich''in', 0),
(169, 'hai', NULL, 'Haida', 'haida', 0),
(170, 'hat', 'ht', 'Haitian; Haitian Creole', 'haïtien; créole haïtien', 0),
(171, 'hau', 'ha', 'Hausa', 'haoussa', 0),
(172, 'haw', NULL, 'Hawaiian', 'hawaïen', 0),
(173, 'heb', 'he', 'Hebrew', 'hébreu', 0),
(174, 'her', 'hz', 'Herero', 'herero', 0),
(175, 'hil', NULL, 'Hiligaynon', 'hiligaynon', 0),
(176, 'him', NULL, 'Himachali', 'himachali', 0),
(177, 'hin', 'hi', 'Hindi', 'hindi', 0),
(178, 'hit', NULL, 'Hittite', 'hittite', 0),
(179, 'hmn', NULL, 'Hmong', 'hmong', 0),
(180, 'hmo', 'ho', 'Hiri Motu', 'hiri motu', 0),
(181, 'hrv', 'hr', 'Croatian', 'croate', 0),
(182, 'hsb', NULL, 'Upper Sorbian', 'haut-sorabe', 0),
(183, 'hun', 'hu', 'Hungarian', 'hongrois', 0),
(184, 'hup', NULL, 'Hupa', 'hupa', 0),
(185, 'iba', NULL, 'Iban', 'iban', 0),
(186, 'ibo', 'ig', 'Igbo', 'igbo', 0),
(187, 'ice', 'is', 'Icelandic', 'islandais', 0),
(188, 'ido', 'io', 'Ido', 'ido', 0),
(189, 'iii', 'ii', 'Sichuan Yi; Nuosu', 'yi de Sichuan', 0),
(190, 'ijo', NULL, 'Ijo languages', 'ijo, langues', 0),
(191, 'iku', 'iu', 'Inuktitut', 'inuktitut', 0),
(192, 'ile', 'ie', 'Interlingue; Occidental', 'interlingue', 0),
(193, 'ilo', NULL, 'Iloko', 'ilocano', 0),
(194, 'ina', 'ia', 'Interlingua (International Auxiliary Language Association)', 'interlingua (langue auxiliaire internationale)', 0),
(195, 'inc', NULL, 'Indic languages', 'indo-aryennes, langues', 0),
(196, 'ind', 'id', 'Indonesian', 'indonésien', 0),
(197, 'ine', NULL, 'Indo-European languages', 'indo-européennes, langues', 0),
(198, 'inh', NULL, 'Ingush', 'ingouche', 0),
(199, 'ipk', 'ik', 'Inupiaq', 'inupiaq', 0),
(200, 'ira', NULL, 'Iranian languages', 'iraniennes, langues', 0),
(201, 'iro', NULL, 'Iroquoian languages', 'iroquoises, langues', 0),
(202, 'ita', 'it', 'Italian', 'italien', 0),
(203, 'jav', 'jv', 'Javanese', 'javanais', 0),
(204, 'jbo', NULL, 'Lojban', 'lojban', 0),
(205, 'jpn', 'ja', 'Japanese', 'japonais', 0),
(206, 'jpr', NULL, 'Judeo-Persian', 'judéo-persan', 0),
(207, 'jrb', NULL, 'Judeo-Arabic', 'judéo-arabe', 0),
(208, 'kaa', NULL, 'Kara-Kalpak', 'karakalpak', 0),
(209, 'kab', NULL, 'Kabyle', 'kabyle', 0),
(210, 'kac', NULL, 'Kachin; Jingpho', 'kachin; jingpho', 0),
(211, 'kal', 'kl', 'Kalaallisut; Greenlandic', 'groenlandais', 0),
(212, 'kam', NULL, 'Kamba', 'kamba', 0),
(213, 'kan', 'kn', 'Kannada', 'kannada', 0),
(214, 'kar', NULL, 'Karen languages', 'karen, langues', 0),
(215, 'kas', 'ks', 'Kashmiri', 'kashmiri', 0),
(216, 'kau', 'kr', 'Kanuri', 'kanouri', 0),
(217, 'kaw', NULL, 'Kawi', 'kawi', 0),
(218, 'kaz', 'kk', 'Kazakh', 'kazakh', 0),
(219, 'kbd', NULL, 'Kabardian', 'kabardien', 0),
(220, 'kha', NULL, 'Khasi', 'khasi', 0),
(221, 'khi', NULL, 'Khoisan languages', 'khoïsan, langues', 0),
(222, 'khm', 'km', 'Central Khmer', 'khmer central', 0),
(223, 'kho', NULL, 'Khotanese; Sakan', 'khotanais; sakan', 0),
(224, 'kik', 'ki', 'Kikuyu; Gikuyu', 'kikuyu', 0),
(225, 'kin', 'rw', 'Kinyarwanda', 'rwanda', 0),
(226, 'kir', 'ky', 'Kirghiz; Kyrgyz', 'kirghiz', 0),
(227, 'kmb', NULL, 'Kimbundu', 'kimbundu', 0),
(228, 'kok', NULL, 'Konkani', 'konkani', 0),
(229, 'kom', 'kv', 'Komi', 'kom', 0),
(230, 'kon', 'kg', 'Kongo', 'kongo', 0),
(231, 'kor', 'ko', 'Korean', 'coréen', 0),
(232, 'kos', NULL, 'Kosraean', 'kosrae', 0),
(233, 'kpe', NULL, 'Kpelle', 'kpellé', 0),
(234, 'krc', NULL, 'Karachay-Balkar', 'karatchai balkar', 0),
(235, 'krl', NULL, 'Karelian', 'carélien', 0),
(236, 'kro', NULL, 'Kru languages', 'krou, langues', 0),
(237, 'kru', NULL, 'Kurukh', 'kurukh', 0),
(238, 'kua', 'kj', 'Kuanyama; Kwanyama', 'kuanyama; kwanyama', 0),
(239, 'kum', NULL, 'Kumyk', 'koumyk', 0),
(240, 'kur', 'ku', 'Kurdish', 'kurde', 0),
(241, 'kut', NULL, 'Kutenai', 'kutenai', 0),
(242, 'lad', NULL, 'Ladino', 'judéo-espagnol', 0),
(243, 'lah', NULL, 'Lahnda', 'lahnda', 0),
(244, 'lam', NULL, 'Lamba', 'lamba', 0),
(245, 'lao', 'lo', 'Lao', 'lao', 0),
(246, 'lat', 'la', 'Latin', 'latin', 0),
(247, 'lav', 'lv', 'Latvian', 'letton', 0),
(248, 'lez', NULL, 'Lezghian', 'lezghien', 0),
(249, 'lim', 'li', 'Limburgan; Limburger; Limburgish', 'limbourgeois', 0),
(250, 'lin', 'ln', 'Lingala', 'lingala', 0),
(251, 'lit', 'lt', 'Lithuanian', 'lituanien', 0),
(252, 'lol', NULL, 'Mongo', 'mongo', 0),
(253, 'loz', NULL, 'Lozi', 'lozi', 0),
(254, 'ltz', 'lb', 'Luxembourgish; Letzeburgesch', 'luxembourgeois', 0),
(255, 'lua', NULL, 'Luba-Lulua', 'luba-lulua', 0),
(256, 'lub', 'lu', 'Luba-Katanga', 'luba-katanga', 0),
(257, 'lug', 'lg', 'Ganda', 'ganda', 0),
(258, 'lui', NULL, 'Luiseno', 'luiseno', 0),
(259, 'lun', NULL, 'Lunda', 'lunda', 0),
(260, 'luo', NULL, 'Luo (Kenya and Tanzania)', 'luo (Kenya et Tanzanie)', 0),
(261, 'lus', NULL, 'Lushai', 'lushai', 0),
(262, 'mac', 'mk', 'Macedonian', 'macédonien', 0),
(263, 'mad', NULL, 'Madurese', 'madourais', 0),
(264, 'mag', NULL, 'Magahi', 'magahi', 0),
(265, 'mah', 'mh', 'Marshallese', 'marshall', 0),
(266, 'mai', NULL, 'Maithili', 'maithili', 0),
(267, 'mak', NULL, 'Makasar', 'makassar', 0),
(268, 'mal', 'ml', 'Malayalam', 'malayalam', 0),
(269, 'man', NULL, 'Mandingo', 'mandingue', 0),
(270, 'mao', 'mi', 'Maori', 'maori', 0),
(271, 'map', NULL, 'Austronesian languages', 'austronésiennes, langues', 0),
(272, 'mar', 'mr', 'Marathi', 'marathe', 0),
(273, 'mas', NULL, 'Masai', 'massaï', 0),
(274, 'may', 'ms', 'Malay', 'malais', 0),
(275, 'mdf', NULL, 'Moksha', 'moksa', 0),
(276, 'mdr', NULL, 'Mandar', 'mandar', 0),
(277, 'men', NULL, 'Mende', 'mendé', 0),
(278, 'mga', NULL, 'Irish, Middle (900-1200)', 'irlandais moyen (900-1200)', 0),
(279, 'mic', NULL, 'Mi''kmaq; Micmac', 'mi''kmaq; micmac', 0),
(280, 'min', NULL, 'Minangkabau', 'minangkabau', 0),
(281, 'mis', NULL, 'Uncoded languages', 'langues non codées', 0),
(282, 'mkh', NULL, 'Mon-Khmer languages', 'môn-khmer, langues', 0),
(283, 'mlg', 'mg', 'Malagasy', 'malgache', 0),
(284, 'mlt', 'mt', 'Maltese', 'maltais', 0),
(285, 'mnc', NULL, 'Manchu', 'mandchou', 0),
(286, 'mni', NULL, 'Manipuri', 'manipuri', 0),
(287, 'mno', NULL, 'Manobo languages', 'manobo, langues', 0),
(288, 'moh', NULL, 'Mohawk', 'mohawk', 0),
(289, 'mon', 'mn', 'Mongolian', 'mongol', 0),
(290, 'mos', NULL, 'Mossi', 'moré', 0),
(291, 'mul', NULL, 'Multiple languages', 'multilingue', 0),
(292, 'mun', NULL, 'Munda languages', 'mounda, langues', 0),
(293, 'mus', NULL, 'Creek', 'muskogee', 0),
(294, 'mwl', NULL, 'Mirandese', 'mirandais', 0),
(295, 'mwr', NULL, 'Marwari', 'marvari', 0),
(296, 'myn', NULL, 'Mayan languages', 'maya, langues', 0),
(297, 'myv', NULL, 'Erzya', 'erza', 0),
(298, 'nah', NULL, 'Nahuatl languages', 'nahuatl, langues', 0),
(299, 'nai', NULL, 'North American Indian languages', 'nord-amérindiennes, langues', 0),
(300, 'nap', NULL, 'Neapolitan', 'napolitain', 0),
(301, 'nau', 'na', 'Nauru', 'nauruan', 0),
(302, 'nav', 'nv', 'Navajo; Navaho', 'navaho', 0),
(303, 'nbl', 'nr', 'Ndebele, South; South Ndebele', 'ndébélé du Sud', 0),
(304, 'nde', 'nd', 'Ndebele, North; North Ndebele', 'ndébélé du Nord', 0),
(305, 'ndo', 'ng', 'Ndonga', 'ndonga', 0),
(306, 'nds', NULL, 'Low German; Low Saxon; German, Low; Saxon, Low', 'bas allemand; bas saxon; allemand, bas; saxon, bas', 0),
(307, 'nep', 'ne', 'Nepali', 'népalais', 0),
(308, 'new', NULL, 'Nepal Bhasa; Newari', 'nepal bhasa; newari', 0),
(309, 'nia', NULL, 'Nias', 'nias', 0),
(310, 'nic', NULL, 'Niger-Kordofanian languages', 'nigéro-kordofaniennes, langues', 0),
(311, 'niu', NULL, 'Niuean', 'niué', 0),
(312, 'nno', 'nn', 'Norwegian Nynorsk; Nynorsk, Norwegian', 'norvégien nynorsk; nynorsk, norvégien', 0),
(313, 'nob', 'nb', 'Bokmål, Norwegian; Norwegian Bokmål', 'norvégien bokmål', 0),
(314, 'nog', NULL, 'Nogai', 'nogaï; nogay', 0),
(315, 'non', NULL, 'Norse, Old', 'norrois, vieux', 0),
(316, 'nor', 'no', 'Norwegian', 'norvégien', 0),
(317, 'nqo', NULL, 'N''Ko', 'n''ko', 0),
(318, 'nso', NULL, 'Pedi; Sepedi; Northern Sotho', 'pedi; sepedi; sotho du Nord', 0),
(319, 'nub', NULL, 'Nubian languages', 'nubiennes, langues', 0),
(320, 'nwc', NULL, 'Classical Newari; Old Newari; Classical Nepal Bhasa', 'newari classique', 0),
(321, 'nya', 'ny', 'Chichewa; Chewa; Nyanja', 'chichewa; chewa; nyanja', 0),
(322, 'nym', NULL, 'Nyamwezi', 'nyamwezi', 0),
(323, 'nyn', NULL, 'Nyankole', 'nyankolé', 0),
(324, 'nyo', NULL, 'Nyoro', 'nyoro', 0),
(325, 'nzi', NULL, 'Nzima', 'nzema', 0),
(326, 'oci', 'oc', 'Occitan (post 1500)', 'occitan (après 1500)', 0),
(327, 'oji', 'oj', 'Ojibwa', 'ojibwa', 0),
(328, 'ori', 'or', 'Oriya', 'oriya', 0),
(329, 'orm', 'om', 'Oromo', 'galla', 0),
(330, 'osa', NULL, 'Osage', 'osage', 0),
(331, 'oss', 'os', 'Ossetian; Ossetic', 'ossète', 0),
(332, 'ota', NULL, 'Turkish, Ottoman (1500-1928)', 'turc ottoman (1500-1928)', 0),
(333, 'oto', NULL, 'Otomian languages', 'otomi, langues', 0),
(334, 'paa', NULL, 'Papuan languages', 'papoues, langues', 0),
(335, 'pag', NULL, 'Pangasinan', 'pangasinan', 0),
(336, 'pal', NULL, 'Pahlavi', 'pahlavi', 0),
(337, 'pam', NULL, 'Pampanga; Kapampangan', 'pampangan', 0),
(338, 'pan', 'pa', 'Panjabi; Punjabi', 'pendjabi', 0),
(339, 'pap', NULL, 'Papiamento', 'papiamento', 0),
(340, 'pau', NULL, 'Palauan', 'palau', 0),
(341, 'peo', NULL, 'Persian, Old (ca.600-400 B.C.)', 'perse, vieux (ca. 600-400 av. J.-C.)', 0),
(342, 'per', 'fa', 'Persian', 'persan', 0),
(343, 'phi', NULL, 'Philippine languages', 'philippines, langues', 0),
(344, 'phn', NULL, 'Phoenician', 'phénicien', 0),
(345, 'pli', 'pi', 'Pali', 'pali', 0),
(346, 'pol', 'pl', 'Polish', 'polonais', 0),
(347, 'pon', NULL, 'Pohnpeian', 'pohnpei', 0),
(348, 'por', 'pt', 'Portuguese', 'portugais', 0),
(349, 'pra', NULL, 'Prakrit languages', 'prâkrit, langues', 0),
(350, 'pro', NULL, 'Provençal, Old (to 1500);Occitan, Old (to 1500)', 'provençal ancien (jusqu''à 1500); occitan ancien (jusqu''à 1500)', 0),
(351, 'pus', 'ps', 'Pushto; Pashto', 'pachto', 0),
(352, 'qaa', NULL, 'Reserved for local use', 'réservée à l''usage local', 0),
(353, 'que', 'qu', 'Quechua', 'quechua', 0),
(354, 'raj', NULL, 'Rajasthani', 'rajasthani', 0),
(355, 'rap', NULL, 'Rapanui', 'rapanui', 0),
(356, 'rar', NULL, 'Rarotongan; Cook Islands Maori', 'rarotonga; maori des îles Cook', 0),
(357, 'roa', NULL, 'Romance languages', 'romanes, langues', 0),
(358, 'roh', 'rm', 'Romansh', 'romanche', 0),
(359, 'rom', NULL, 'Romany', 'tsigane', 0),
(360, 'rum', 'ro', 'Romanian; Moldavian; Moldovan', 'roumain; moldave', 0),
(361, 'run', 'rn', 'Rundi', 'rundi', 0),
(362, 'rup', NULL, 'Aromanian; Arumanian; Macedo-Romanian', 'aroumain; macédo-roumain', 0),
(363, 'rus', 'ru', 'Russian', 'russe', 1),
(364, 'sad', NULL, 'Sandawe', 'sandawe', 0),
(365, 'sag', 'sg', 'Sango', 'sango', 0),
(366, 'sah', NULL, 'Yakut', 'iakoute', 0),
(367, 'sai', NULL, 'South American Indian languages', 'sud-amérindiennes, langues', 0),
(368, 'sal', NULL, 'Salishan languages', 'salishennes, langues', 0),
(369, 'sam', NULL, 'Samaritan Aramaic', 'samaritain', 0),
(370, 'san', 'sa', 'Sanskrit', 'sanskrit', 0),
(371, 'sas', NULL, 'Sasak', 'sasak', 0),
(372, 'sat', NULL, 'Santali', 'santal', 0),
(373, 'scn', NULL, 'Sicilian', 'sicilien', 0),
(374, 'sco', NULL, 'Scots', 'écossais', 0),
(375, 'sel', NULL, 'Selkup', 'selkoupe', 0),
(376, 'sem', NULL, 'Semitic languages', 'sémitiques, langues', 0),
(377, 'sga', NULL, 'Irish, Old (to 900)', 'irlandais ancien (jusqu''à 900)', 0),
(378, 'sgn', NULL, 'Sign Languages', 'langues des signes', 0),
(379, 'shn', NULL, 'Shan', 'chan', 0),
(380, 'sid', NULL, 'Sidamo', 'sidamo', 0),
(381, 'sin', 'si', 'Sinhala; Sinhalese', 'singhalais', 0),
(382, 'sio', NULL, 'Siouan languages', 'sioux, langues', 0),
(383, 'sit', NULL, 'Sino-Tibetan languages', 'sino-tibétaines, langues', 0),
(384, 'sla', NULL, 'Slavic languages', 'slaves, langues', 0),
(385, 'slo', 'sk', 'Slovak', 'slovaque', 0),
(386, 'slv', 'sl', 'Slovenian', 'slovène', 0),
(387, 'sma', NULL, 'Southern Sami', 'sami du Sud', 0),
(388, 'sme', 'se', 'Northern Sami', 'sami du Nord', 0),
(389, 'smi', NULL, 'Sami languages', 'sames, langues', 0),
(390, 'smj', NULL, 'Lule Sami', 'sami de Lule', 0),
(391, 'smn', NULL, 'Inari Sami', 'sami d''Inari', 0),
(392, 'smo', 'sm', 'Samoan', 'samoan', 0),
(393, 'sms', NULL, 'Skolt Sami', 'sami skolt', 0),
(394, 'sna', 'sn', 'Shona', 'shona', 0),
(395, 'snd', 'sd', 'Sindhi', 'sindhi', 0),
(396, 'snk', NULL, 'Soninke', 'soninké', 0),
(397, 'sog', NULL, 'Sogdian', 'sogdien', 0),
(398, 'som', 'so', 'Somali', 'somali', 0),
(399, 'son', NULL, 'Songhai languages', 'songhai, langues', 0),
(400, 'sot', 'st', 'Sotho, Southern', 'sotho du Sud', 0),
(401, 'spa', 'es', 'Spanish; Castilian', 'espagnol; castillan', 0),
(402, 'srd', 'sc', 'Sardinian', 'sarde', 0),
(403, 'srn', NULL, 'Sranan Tongo', 'sranan tongo', 0),
(404, 'srp', 'sr', 'Serbian', 'serbe', 0),
(405, 'srr', NULL, 'Serer', 'sérère', 0),
(406, 'ssa', NULL, 'Nilo-Saharan languages', 'nilo-sahariennes, langues', 0),
(407, 'ssw', 'ss', 'Swati', 'swati', 0),
(408, 'suk', NULL, 'Sukuma', 'sukuma', 0),
(409, 'sun', 'su', 'Sundanese', 'soundanais', 0),
(410, 'sus', NULL, 'Susu', 'soussou', 0),
(411, 'sux', NULL, 'Sumerian', 'sumérien', 0),
(412, 'swa', 'sw', 'Swahili', 'swahili', 0),
(413, 'swe', 'sv', 'Swedish', 'suédois', 0),
(414, 'syc', NULL, 'Classical Syriac', 'syriaque classique', 0),
(415, 'syr', NULL, 'Syriac', 'syriaque', 0),
(416, 'tah', 'ty', 'Tahitian', 'tahitien', 0),
(417, 'tai', NULL, 'Tai languages', 'tai, langues', 0),
(418, 'tam', 'ta', 'Tamil', 'tamoul', 0),
(419, 'tat', 'tt', 'Tatar', 'tatar', 0),
(420, 'tel', 'te', 'Telugu', 'télougou', 0),
(421, 'tem', NULL, 'Timne', 'temne', 0),
(422, 'ter', NULL, 'Tereno', 'tereno', 0),
(423, 'tet', NULL, 'Tetum', 'tetum', 0),
(424, 'tgk', 'tg', 'Tajik', 'tadjik', 0),
(425, 'tgl', 'tl', 'Tagalog', 'tagalog', 0),
(426, 'tha', 'th', 'Thai', 'thaï', 0),
(427, 'tib', 'bo', 'Tibetan', 'tibétain', 0),
(428, 'tig', NULL, 'Tigre', 'tigré', 0),
(429, 'tir', 'ti', 'Tigrinya', 'tigrigna', 0),
(430, 'tiv', NULL, 'Tiv', 'tiv', 0),
(431, 'tkl', NULL, 'Tokelau', 'tokelau', 0),
(432, 'tlh', NULL, 'Klingon; tlhIngan-Hol', 'klingon', 0),
(433, 'tli', NULL, 'Tlingit', 'tlingit', 0),
(434, 'tmh', NULL, 'Tamashek', 'tamacheq', 0),
(435, 'tog', NULL, 'Tonga (Nyasa)', 'tonga (Nyasa)', 0),
(436, 'ton', 'to', 'Tonga (Tonga Islands)', 'tongan (Îles Tonga)', 0),
(437, 'tpi', NULL, 'Tok Pisin', 'tok pisin', 0),
(438, 'tsi', NULL, 'Tsimshian', 'tsimshian', 0),
(439, 'tsn', 'tn', 'Tswana', 'tswana', 0),
(440, 'tso', 'ts', 'Tsonga', 'tsonga', 0),
(441, 'tuk', 'tk', 'Turkmen', 'turkmène', 0),
(442, 'tum', NULL, 'Tumbuka', 'tumbuka', 0),
(443, 'tup', NULL, 'Tupi languages', 'tupi, langues', 0),
(444, 'tur', 'tr', 'Turkish', 'turc', 0),
(445, 'tut', NULL, 'Altaic languages', 'altaïques, langues', 0),
(446, 'tvl', NULL, 'Tuvalu', 'tuvalu', 0),
(447, 'twi', 'tw', 'Twi', 'twi', 0),
(448, 'tyv', NULL, 'Tuvinian', 'touva', 0),
(449, 'udm', NULL, 'Udmurt', 'oudmourte', 0),
(450, 'uga', NULL, 'Ugaritic', 'ougaritique', 0),
(451, 'uig', 'ug', 'Uighur; Uyghur', 'ouïgour', 0),
(452, 'ukr', 'uk', 'Ukrainian', 'ukrainien', 0),
(453, 'umb', NULL, 'Umbundu', 'umbundu', 0),
(454, 'und', NULL, 'Undetermined', 'indéterminée', 0),
(455, 'urd', 'ur', 'Urdu', 'ourdou', 0),
(456, 'uzb', 'uz', 'Uzbek', 'ouszbek', 0),
(457, 'vai', NULL, 'Vai', 'vaï', 0),
(458, 'ven', 've', 'Venda', 'venda', 0),
(459, 'vie', 'vi', 'Vietnamese', 'vietnamien', 0),
(460, 'vol', 'vo', 'Volapük', 'volapük', 0),
(461, 'vot', NULL, 'Votic', 'vote', 0),
(462, 'wak', NULL, 'Wakashan languages', 'wakashanes, langues', 0),
(463, 'wal', NULL, 'Wolaitta; Wolaytta', 'wolaitta; wolaytta', 0),
(464, 'war', NULL, 'Waray', 'waray', 0),
(465, 'was', NULL, 'Washo', 'washo', 0),
(466, 'wel', 'cy', 'Welsh', 'gallois', 0),
(467, 'wen', NULL, 'Sorbian languages', 'sorabes, langues', 0),
(468, 'wln', 'wa', 'Walloon', 'wallon', 0),
(469, 'wol', 'wo', 'Wolof', 'wolof', 0),
(470, 'xal', NULL, 'Kalmyk; Oirat', 'kalmouk; oïrat', 0),
(471, 'xho', 'xh', 'Xhosa', 'xhosa', 0),
(472, 'yao', NULL, 'Yao', 'yao', 0),
(473, 'yap', NULL, 'Yapese', 'yapois', 0),
(474, 'yid', 'yi', 'Yiddish', 'yiddish', 0),
(475, 'yor', 'yo', 'Yoruba', 'yoruba', 0),
(476, 'ypk', NULL, 'Yupik languages', 'yupik, langues', 0),
(477, 'zap', NULL, 'Zapotec', 'zapotèque', 0),
(478, 'zbl', NULL, 'Blissymbols; Blissymbolics; Bliss', 'symboles Bliss; Bliss', 0),
(479, 'zen', NULL, 'Zenaga', 'zenaga', 0),
(480, 'zha', 'za', 'Zhuang; Chuang', 'zhuang; chuang', 0),
(481, 'znd', NULL, 'Zande languages', 'zandé, langues', 0),
(482, 'zul', 'zu', 'Zulu', 'zoulou', 0),
(483, 'zun', NULL, 'Zuni', 'zuni', 0),
(484, 'zxx', NULL, 'No linguistic content; Not applicable', 'pas de contenu linguistique; non applicable', 0),
(485, 'zza', NULL, 'Zaza; Dimili; Dimli; Kirdki; Kirmanjki; Zazaki', 'zaza; dimili; dimli; kirdki; kirmanjki; zazaki', 0);

-- --------------------------------------------------------

--
-- Table structure for table `morphemes`
--

CREATE TABLE `morphemes` (
  `morpheme_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `keyword_id` mediumint(8) unsigned NOT NULL,
  `linked_keyword_id` mediumint(8) unsigned NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`morpheme_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `queries`
--

CREATE TABLE `queries` (
  `query_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `utterances`
--

CREATE TABLE `utterances` (
  `utterance_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `language_id` mediumint(8) unsigned DEFAULT NULL,
  `format` enum('title','heading','paragraph','alt') DEFAULT NULL,
  `utterance` text NOT NULL,
  PRIMARY KEY (`utterance_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
