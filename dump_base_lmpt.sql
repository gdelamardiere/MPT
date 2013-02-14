-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Client: 127.0.0.1
-- Généré le : Jeu 14 Février 2013 à 13:25
-- Version du serveur: 5.5.16
-- Version de PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `lmpt`
--
DROP DATABASE `lmpt`;
CREATE DATABASE `lmpt` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `lmpt`;

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
  `id_action` int(11) NOT NULL,
  `id_dispo` int(11) NOT NULL,
  `id_competences` int(11) NOT NULL,
  `chef_equipe` enum('0','1') NOT NULL,
  `RQ` text NOT NULL,
  `id_parrain` int(11) DEFAULT NULL,
  `nom_parrain` varchar(50) NOT NULL,
  `prenom_parrain` varchar(30) NOT NULL,
  `email_parrain` varchar(50) NOT NULL,
  `id_statut` int(11) NOT NULL,
  `date_form` datetime NOT NULL,
  `date_activation` datetime DEFAULT NULL,
  `cle_activation` varchar(50) NOT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `id_dispo` (`id_dispo`),
  KEY `id_competence` (`id_competences`),
  KEY `id_parain` (`id_parrain`),
  KEY `id_statut` (`id_statut`),
  KEY `id_action` (`id_action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `personnes`
--

INSERT INTO `personnes` (`id_personne`, `nom`, `prenom`, `tel_port`, `email`, `cp`, `date_naissance`, `sexe`, `id_action`, `id_dispo`, `id_competences`, `chef_equipe`, `RQ`, `id_parrain`, `nom_parrain`, `prenom_parrain`, `email_parrain`, `id_statut`, `date_form`, `date_activation`, `cle_activation`) VALUES
(1, 'de la mardire', 'prénom', '0232325445', 'test@test.com', '65', '2012-02-12', 'Homme', 1, 1, 1, '0', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', 1, '2013-02-13 18:56:16', NULL, '33f9776898f3e19f30942933e604d0d1'),
(2, 'de la mardire', 'prénom2', '0232325445', 'test2@test.com', '65', '2012-02-12', 'Femme', 1, 1, 1, '0', '', NULL, 'test', 'test', 'gdelamardiere@gmail.com', 1, '2013-02-13 18:56:44', NULL, '5b40749143c1f2e9adebee4d622a9b07'),
(3, 'de la mardire', 'prénom', '0232325445', 'gdelamardiere@gmail.com', '65987', '2012-02-12', 'Homme', 1, 2, 4, '1', 'yter', NULL, 'test', 'test', 'test@test.com', 2, '2013-02-13 19:19:37', '2013-02-13 19:57:16', '5a941d0d5b11b724d0f15603cb5772af');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `statuts`
--

INSERT INTO `statuts` (`id_statut`, `statut`, `actif`) VALUES
(1, 'WAIT_ACTIVATION', '1'),
(2, 'WAIT_VALIDATION', '1'),
(3, 'VALIDATE', '1');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `personnes`
--
ALTER TABLE `personnes`
  ADD CONSTRAINT `personnes_ibfk_23` FOREIGN KEY (`id_action`) REFERENCES `actions` (`id_action`),
  ADD CONSTRAINT `personnes_ibfk_24` FOREIGN KEY (`id_dispo`) REFERENCES `disponibilites` (`id_dispo`),
  ADD CONSTRAINT `personnes_ibfk_25` FOREIGN KEY (`id_competences`) REFERENCES `competences` (`id_competences`),
  ADD CONSTRAINT `personnes_ibfk_26` FOREIGN KEY (`id_parrain`) REFERENCES `personnes` (`id_personne`),
  ADD CONSTRAINT `personnes_ibfk_27` FOREIGN KEY (`id_statut`) REFERENCES `statuts` (`id_statut`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
