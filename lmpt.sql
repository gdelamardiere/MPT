-- phpMyAdmin SQL Dump
-- version 3.4.9
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le : Dim 24 Février 2013 à 19:46
-- Version du serveur: 5.5.28
-- Version de PHP: 5.3.15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `lmpt`
--

-- --------------------------------------------------------

--
-- Structure de la table `actions`
--

DROP TABLE IF EXISTS `actions`;
CREATE TABLE IF NOT EXISTS `actions` (
  `id_action` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `actions`
--

INSERT INTO `actions` (`id_action`, `action`, `actif`) VALUES
(1, 'Tracter', '1'),
(2, 'Participer à des actions ponctuelles', '1'),
(3, 'Aider à la manifestation du 24', '1');

-- --------------------------------------------------------

--
-- Structure de la table `competences`
--

DROP TABLE IF EXISTS `competences`;
CREATE TABLE IF NOT EXISTS `competences` (
  `id_competences` int(11) NOT NULL AUTO_INCREMENT,
  `competence` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_competences`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `competences`
--

INSERT INTO `competences` (`id_competences`, `competence`, `actif`) VALUES
(1, 'Web', '1'),
(2, 'Communication', '1'),
(3, 'Audiovisuel', '1'),
(4, 'Encadrement', '1'),
(5, 'Relation publique', '1'),
(6, 'Logistique', '1'),
(7, 'Gestion de projet', '1');

-- --------------------------------------------------------

--
-- Structure de la table `disponibilites`
--

DROP TABLE IF EXISTS `disponibilites`;
CREATE TABLE IF NOT EXISTS `disponibilites` (
  `id_dispo` int(11) NOT NULL AUTO_INCREMENT,
  `dispo` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_dispo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `disponibilites`
--

INSERT INTO `disponibilites` (`id_dispo`, `dispo`, `actif`) VALUES
(1, 'Le matin', '1'),
(2, 'Le soir', '1'),
(3, 'En journée', '1'),
(4, 'Toute la semaine précédant la manif', '1');

-- --------------------------------------------------------

--
-- Structure de la table `equipe`
--

DROP TABLE IF EXISTS `equipe`;
CREATE TABLE IF NOT EXISTS `equipe` (
  `id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `equipe`
--

INSERT INTO `equipe` (`id_equipe`, `valeur`, `actif`) VALUES
(1, '', '1'),
(2, 'Logistique', '1'),
(3, 'Sécurité (Homme uniquement)', '1'),
(4, 'Accueil', '1');

-- --------------------------------------------------------

--
-- Structure de la table `historiques`
--

DROP TABLE IF EXISTS `historiques`;
CREATE TABLE IF NOT EXISTS `historiques` (
  `id_histo` int(11) NOT NULL AUTO_INCREMENT,
  `id_personne` int(11) NOT NULL,
  `champ` varchar(50) NOT NULL,
  `old_value` varchar(50) NOT NULL,
  `new_value` varchar(50) NOT NULL,
  `date_modif` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_histo`),
  KEY `id_personne` (`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `personnes`
--

DROP TABLE IF EXISTS `personnes`;
CREATE TABLE IF NOT EXISTS `personnes` (
  `id_personne` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `tel_port` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `cp` varchar(5) NOT NULL,
  `date_naissance` date NOT NULL,
  `sexe` enum('Homme','Femme') NOT NULL,
  `chef_equipe` enum('non','oui') NOT NULL,
  `RQ` text NOT NULL,
  `id_parrain` int(11) DEFAULT NULL,
  `nom_parrain` varchar(50) NOT NULL,
  `prenom_parrain` varchar(30) NOT NULL,
  `email_parrain` varchar(50) NOT NULL,
  `email_equipe` varchar(50) DEFAULT NULL,
  `id_equipe` int(11) NOT NULL,
  `id_statut` int(11) NOT NULL,
  `id_temps` int(11) NOT NULL,
  `date_form` datetime NOT NULL,
  `date_activation` datetime DEFAULT NULL,
  `cle_activation` varchar(50) NOT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `id_parain` (`id_parrain`),
  KEY `id_statut` (`id_statut`),
  KEY `id_temps` (`id_temps`),
  KEY `id_equipe` (`id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

--
-- Contenu de la table `personnes`
--

INSERT INTO `personnes` (`id_personne`, `nom`, `prenom`, `tel_port`, `email`, `cp`, `date_naissance`, `sexe`, `chef_equipe`, `RQ`, `id_parrain`, `nom_parrain`, `prenom_parrain`, `email_parrain`, `email_equipe`, `id_equipe`, `id_statut`, `id_temps`, `date_form`, `date_activation`, `cle_activation`) VALUES
(1, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 2, 0, '2013-02-13 18:56:16', '2013-02-23 13:38:08', '33f9776898f3e19f30942933e604d0d1'),
(2, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Femme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 18:56:44', NULL, '5b40749143c1f2e9adebee4d622a9b07'),
(3, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:09:20', NULL, 'b8508330b7b0e2663091cce49c65b481'),
(4, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:09:32', NULL, 'aba0842baf3d447c4fbd5c088202aa06'),
(5, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:14:26', NULL, '8e4414ed54173f681d00db07ca4da637'),
(6, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:14:35', NULL, 'a7cc173bbf6bb898eddd778efca6048c'),
(7, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:18:06', NULL, '4b3f82bf335c0e2b8f5a03480ebf992d'),
(8, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', '', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 1, 0, '2013-02-13 19:18:54', NULL, '6e8b378bf71d70b320e6b11e0bdfe280'),
(9, 'de la mardire', 'prénom', '0232325445', 'gdelamardiere@gmail.com', '65987', '2012-02-12', 'Homme', '', 'yter', NULL, 'test', 'test', 'gdelamardiere@gmail.com', NULL, 0, 2, 0, '2013-02-13 19:19:37', '2013-02-23 13:17:51', '5a941d0d5b11b724d0f15603cb5772af'),
(11, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', 1, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:55:21', NULL, '8a2c94fc0c80104d47459ccb2acd785f'),
(12, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:56:48', NULL, '4ffccdc5a7fd61041c23c3f8dde08f35'),
(13, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:57:25', NULL, '155f0259f7ae58e10cb1af38ce7d14e5'),
(14, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:57:39', NULL, 'fc3756eb94e84f7f1cf4714193cdf914'),
(15, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:57:51', NULL, '90d6f581afbf3c08e9bf538664131972'),
(16, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:58:05', NULL, '80d5d914dd3a43081994d0e17937d948'),
(17, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:58:34', NULL, 'f73bd6d131bda8c4b7c7da9622b33396'),
(18, 'nom', 'prÃ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 14:59:24', NULL, 'b2da6c2b30075f957eae1b38bb6082da'),
(19, 'nom', 'prÃƒÂ©nom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 15:00:32', NULL, 'acfdaad052f7fe9b51e70a6019e581ec'),
(20, 'nom', 'prénom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 15:00:49', NULL, '33d98703eb950396524ce2461072944c'),
(21, 'nom', 'prénom', '0234547887', 'gde@te.com', '75007', '1987-12-02', 'Homme', 'non', 'ere', NULL, 'npara', 'preparrain', 'parr@gma.co', 'aea@erzz.vr', 1, 1, 3, '2013-02-24 15:03:38', NULL, '3aa34df6062beb628d879d3ac78e1d45'),
(22, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 2, 5, '2013-02-24 15:05:57', '2013-02-24 15:18:14', 'cb35dccf3328d99da806f8b1f25e0fd5'),
(23, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 2, 5, '2013-02-24 15:19:53', '2013-02-24 15:20:13', 'be9115d65f4b9376952db48c80197ced'),
(24, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:34:22', NULL, 'aac3c76fc213d0254490a077717cf45b'),
(25, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:34:33', NULL, '788b2c13fb1bc418d8033badd22fad88'),
(26, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:34:58', NULL, 'cb4f18dc8b3dd476c096a5e072598b38'),
(27, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:35:48', NULL, 'b457a12636c7fb171d61953c86dcd192'),
(28, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:42:31', NULL, 'ed217671601160f8f9b4a26c1c20e285'),
(29, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:43:17', NULL, 'a6de8fff5a320ffe0435e4340d79cc4d'),
(30, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:45:21', NULL, 'a88b85c59e8c5c05cd3e30c42bad5856'),
(31, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 3, 1, 5, '2013-02-24 15:45:48', NULL, 'a528a265904212a5d3987a6fa7e387ff'),
(32, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:10:00', NULL, 'f152a729ee655b766fde6ffb3f46cc83'),
(33, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:11:21', NULL, 'c3ccf9d1f0861a208d0c72473e19fd84'),
(34, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:14:19', NULL, '260a60f8b4d7ef52de889750e564c745'),
(35, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:16:14', NULL, '1ea1d41f920319134ead626ac46a683b'),
(36, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:21:35', NULL, '7a1ddbcc76e9e60deda9adcc1ce9a38c'),
(37, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:23:24', NULL, 'e47e6afa1bd4924f112e53fca1522822'),
(38, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 1, 5, '2013-02-24 16:24:08', NULL, '30ebda6ed1f0b643603409dc25799dd9'),
(39, 'de la mardière', 'Guerric', '0234347145', 'gdelamardiere@gmail.com', '75007', '1987-02-02', 'Homme', 'oui', 'fdfd', NULL, 'terst', 'erer', 'rere@erer.vf', 'dffd@dfdf.fd', 1, 2, 5, '2013-02-24 16:26:16', '2013-02-24 16:40:30', '00fd126e69035b91ce01fe4cc0d78b68'),
(40, 'de la mardière', 'ere', '0623547878', 'gdelamardiere@gmail.com', '78554', '1587-02-12', 'Homme', 'oui', 'frd', NULL, 'df', 'dfd', 'gde@fd.vf', 're@re.com', 2, 1, 1, '2013-02-24 18:42:10', NULL, 'c83bdba7324ed82909be0a171f50605a'),
(41, 'de la mardière', 'ere', '0623547878', 'gdelamardiere@gmail.com', '78554', '1587-02-12', 'Homme', 'oui', 'frd', NULL, 'df', 'dfd', 'gde@fd.vf', 're@re.com', 2, 1, 1, '2013-02-24 18:42:38', NULL, 'a6676d2d2238bd9b24853b7132406035'),
(42, 'f', 'fgg', '0234347145', 'gdelamardiere@gmail.com', '78987', '1987-02-12', 'Homme', 'oui', '', NULL, 'df', 'df', 'tr@gf.vom', '', 2, 2, 5, '2013-02-24 18:45:22', '2013-02-24 19:04:00', '1ce76776f6e42f6eeed4a802974079f4'),
(43, 'fd', 'fd', '0623547878', 'gdelamardiere@gmail.com', '78007', '1587-02-12', 'Homme', 'oui', '', NULL, 'df', 'df', 'gde@fd.vf', '', 3, 1, 2, '2013-02-24 19:22:12', NULL, '2b1dae966d2eb78491d94e1af1e3015c');

-- --------------------------------------------------------

--
-- Structure de la table `r_actions_personnes`
--

DROP TABLE IF EXISTS `r_actions_personnes`;
CREATE TABLE IF NOT EXISTS `r_actions_personnes` (
  `id_personne` int(11) NOT NULL,
  `id_action` int(11) NOT NULL,
  KEY `id_personne` (`id_personne`,`id_action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `r_actions_personnes`
--

INSERT INTO `r_actions_personnes` (`id_personne`, `id_action`) VALUES
(1, 1),
(1, 3),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 3),
(23, 3),
(24, 3),
(25, 3),
(26, 3),
(27, 3),
(28, 3),
(29, 3),
(30, 3),
(31, 3),
(32, 3),
(33, 3),
(34, 3),
(35, 3),
(36, 3),
(37, 3),
(38, 3),
(39, 3),
(40, 1),
(41, 1),
(42, 1),
(43, 1);

-- --------------------------------------------------------

--
-- Structure de la table `r_competences_personnes`
--

DROP TABLE IF EXISTS `r_competences_personnes`;
CREATE TABLE IF NOT EXISTS `r_competences_personnes` (
  `id_competence` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_competence` (`id_competence`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `r_competences_personnes`
--

INSERT INTO `r_competences_personnes` (`id_competence`, `id_personne`) VALUES
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 40),
(2, 17),
(2, 18),
(2, 19),
(2, 20),
(2, 21),
(3, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 26),
(3, 27),
(3, 28),
(3, 29),
(3, 30),
(3, 31),
(4, 17),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(5, 26),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(5, 31),
(7, 22),
(7, 23),
(7, 24),
(7, 25),
(7, 32),
(7, 33),
(7, 34),
(7, 35),
(7, 36),
(7, 37),
(7, 38),
(7, 39);

-- --------------------------------------------------------

--
-- Structure de la table `r_db_gd`
--

DROP TABLE IF EXISTS `r_db_gd`;
CREATE TABLE IF NOT EXISTS `r_db_gd` (
  `id_r_db_gd` int(11) NOT NULL AUTO_INCREMENT,
  `name_gd` varchar(80) NOT NULL,
  `position_gd` int(11) NOT NULL,
  `name_db` varchar(50) DEFAULT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_r_db_gd`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Contenu de la table `r_db_gd`
--

INSERT INTO `r_db_gd` (`id_r_db_gd`, `name_gd`, `position_gd`, `name_db`, `actif`) VALUES
(1, 'timestamp', 0, '', '0'),
(2, 'nom', 1, 'nom', '1'),
(3, 'prÃ©nom', 2, 'prenom', '1'),
(4, 'sexe', 3, 'sexe', '1'),
(5, 'datedenaissance', 4, 'date_naissance', '1'),
(6, 'email', 5, 'email', '1'),
(7, 'numÃ©rodetÃ©lÃ©phonemobile', 6, 'tel_port', '1'),
(8, 'codepostal', 7, 'cp', '1'),
(9, 'nomduparrain', 8, 'nom_parrain', '1'),
(10, 'prÃ©nomduparrain', 9, 'prenom_parrain', '1'),
(11, 'emailduparrain', 10, 'email_parrain', '1'),
(12, 'jesuismotivÃ©pour', 11, 'action', '1'),
(13, 'jevoudraisÃªtrechefdÃ©quipe', 12, 'chef_equipe', '1'),
(14, 'jevoudraisÃªtredanslesÃ©quipesde', 13, 'equipe', '1'),
(15, 'jesuisdisponible', 14, 'dispo', '1'),
(16, 'jepeuxconsacrerdemontemps', 15, 'temps', '1'),
(17, 'jailescompÃ©tencessuivantes', 16, 'competence', '1'),
(18, 'emaildelapersonnedontjesouhaiterejoindrelÃ©quipe', 17, 'email_equipe', '1'),
(19, 'remarques', 18, 'RQ', '1');

-- --------------------------------------------------------

--
-- Structure de la table `r_disponibilites_personnes`
--

DROP TABLE IF EXISTS `r_disponibilites_personnes`;
CREATE TABLE IF NOT EXISTS `r_disponibilites_personnes` (
  `id_dispo` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_dispo` (`id_dispo`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `r_disponibilites_personnes`
--

INSERT INTO `r_disponibilites_personnes` (`id_dispo`, `id_personne`) VALUES
(1, 18),
(1, 19),
(1, 20),
(1, 21),
(1, 22),
(1, 23),
(1, 24),
(1, 25),
(1, 26),
(1, 27),
(1, 28),
(1, 29),
(1, 30),
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(2, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 39);

-- --------------------------------------------------------

--
-- Structure de la table `statuts`
--

DROP TABLE IF EXISTS `statuts`;
CREATE TABLE IF NOT EXISTS `statuts` (
  `id_statut` int(11) NOT NULL AUTO_INCREMENT,
  `statut` varchar(20) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_statut`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `statuts`
--

INSERT INTO `statuts` (`id_statut`, `statut`, `actif`) VALUES
(1, 'WAIT_ACTIVATION', '1'),
(2, 'WAIT_VALIDATION', '1'),
(3, 'VALIDATE', '1'),
(4, 'ERROR_VALIDATION', '1'),
(5, 'ERROR_ACTIVATION', '1');

-- --------------------------------------------------------

--
-- Structure de la table `temps`
--

DROP TABLE IF EXISTS `temps`;
CREATE TABLE IF NOT EXISTS `temps` (
  `id_temps` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_temps`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `temps`
--

INSERT INTO `temps` (`id_temps`, `valeur`, `actif`) VALUES
(1, 'Moins de 3h par semaine', '1'),
(2, 'Entre 3 et 5h par semaine', '1'),
(3, 'Entre 5 et 10h par semaine', '1'),
(4, 'Plus de 10h par semaine', '1'),
(5, 'Je ne suis pas disponible', '1');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD CONSTRAINT `personnes_ibfk_26` FOREIGN KEY (`id_parrain`) REFERENCES `personnes` (`id_personne`),
  ADD CONSTRAINT `personnes_ibfk_27` FOREIGN KEY (`id_statut`) REFERENCES `statuts` (`id_statut`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
