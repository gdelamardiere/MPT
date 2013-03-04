-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Lun 04 Mars 2013 à 21:59
-- Version du serveur: 5.5.29
-- Version de PHP: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données: `lmpt`
--

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_actions`
--

CREATE TABLE `lmpt_dev_actions` (
  `id_action` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `lmpt_dev_actions`
--

INSERT INTO `lmpt_dev_actions` (`id_action`, `action`, `actif`) VALUES
(1, 'Tracter', '1'),
(2, 'Participer à des actions ponctuelles', '1'),
(3, 'Être bénévole le jour de la manifestation', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_competences`
--

CREATE TABLE `lmpt_dev_competences` (
  `id_competences` int(11) NOT NULL AUTO_INCREMENT,
  `competence` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_competences`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `lmpt_dev_competences`
--

INSERT INTO `lmpt_dev_competences` (`id_competences`, `competence`, `actif`) VALUES
(2, 'Communication', '1'),
(3, 'Audiovisuel (cameraman, monteur video)', '1'),
(5, 'Relation publique (attaché de presse...)', '1'),
(7, 'Gestion de projet', '1'),
(9, 'Graphisme', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_disponibilites`
--

CREATE TABLE `lmpt_dev_disponibilites` (
  `id_dispo` int(11) NOT NULL AUTO_INCREMENT,
  `dispo` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_dispo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `lmpt_dev_disponibilites`
--

INSERT INTO `lmpt_dev_disponibilites` (`id_dispo`, `dispo`, `actif`) VALUES
(1, 'Le matin', '1'),
(2, 'L''après-midi', '1'),
(3, 'Le soir', '1'),
(4, 'La semaine précédant la manif', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_equipe`
--

CREATE TABLE `lmpt_dev_equipe` (
  `id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(200) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_dev_equipe`
--

INSERT INTO `lmpt_dev_equipe` (`id_equipe`, `valeur`, `actif`) VALUES
(2, 'Logistique (Disponibilité dès le samedi et/ou le dimanche matin tôt)', '1'),
(3, 'Sécurité (Homme uniquement)', '1'),
(4, 'Accueil', '1'),
(5, 'Je tracte seulement', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_historiques`
--

CREATE TABLE `lmpt_dev_historiques` (
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
-- Structure de la table `lmpt_dev_personnes`
--

CREATE TABLE `lmpt_dev_personnes` (
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
  `autre_competences` varchar(100) NOT NULL,
  `date_form` datetime NOT NULL,
  `date_activation` datetime DEFAULT NULL,
  `cle_activation` varchar(50) NOT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `id_parain` (`id_parrain`),
  KEY `id_statut` (`id_statut`),
  KEY `id_temps` (`id_temps`),
  KEY `id_equipe` (`id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `lmpt_dev_personnes`
--

INSERT INTO `lmpt_dev_personnes` (`id_personne`, `nom`, `prenom`, `tel_port`, `email`, `cp`, `date_naissance`, `sexe`, `chef_equipe`, `RQ`, `id_parrain`, `nom_parrain`, `prenom_parrain`, `email_parrain`, `email_equipe`, `id_equipe`, `id_statut`, `id_temps`, `autre_competences`, `date_form`, `date_activation`, `cle_activation`) VALUES
(1, 'poi', 'poi', '0123456789', 'bastien.famillepaul@gmail.com', '12345', '1999-12-12', 'Homme', 'oui', '', NULL, 'aze', 'aze', 'aze@aze.fr', '', 2, 1, 5, '', '2013-03-04 21:06:17', NULL, '3cabb391e3fa176aa272fa42b8616af7');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_actions_personnes`
--

CREATE TABLE `lmpt_dev_r_actions_personnes` (
  `id_personne` int(11) NOT NULL,
  `id_action` int(11) NOT NULL,
  KEY `id_personne` (`id_personne`,`id_action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_actions_personnes`
--

INSERT INTO `lmpt_dev_r_actions_personnes` (`id_personne`, `id_action`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_competences_personnes`
--

CREATE TABLE `lmpt_dev_r_competences_personnes` (
  `id_competence` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_competence` (`id_competence`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_competences_personnes`
--

INSERT INTO `lmpt_dev_r_competences_personnes` (`id_competence`, `id_personne`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_db_gd`
--

CREATE TABLE `lmpt_dev_r_db_gd` (
  `id_r_db_gd` int(11) NOT NULL AUTO_INCREMENT,
  `name_gd` varchar(80) NOT NULL,
  `position_gd` int(11) NOT NULL,
  `name_db` varchar(50) DEFAULT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_r_db_gd`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Contenu de la table `lmpt_dev_r_db_gd`
--

INSERT INTO `lmpt_dev_r_db_gd` (`id_r_db_gd`, `name_gd`, `position_gd`, `name_db`, `actif`) VALUES
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
-- Structure de la table `lmpt_dev_r_disponibilites_personnes`
--

CREATE TABLE `lmpt_dev_r_disponibilites_personnes` (
  `id_dispo` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_dispo` (`id_dispo`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_disponibilites_personnes`
--

INSERT INTO `lmpt_dev_r_disponibilites_personnes` (`id_dispo`, `id_personne`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_statuts`
--

CREATE TABLE `lmpt_dev_statuts` (
  `id_statut` int(11) NOT NULL AUTO_INCREMENT,
  `statut` varchar(20) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_statut`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_dev_statuts`
--

INSERT INTO `lmpt_dev_statuts` (`id_statut`, `statut`, `actif`) VALUES
(1, 'WAIT_ACTIVATION', '1'),
(2, 'WAIT_VALIDATION', '1'),
(3, 'VALIDATE', '1'),
(4, 'ERROR_VALIDATION', '1'),
(5, 'ERROR_ACTIVATION', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_temps`
--

CREATE TABLE `lmpt_dev_temps` (
  `id_temps` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_temps`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_dev_temps`
--

INSERT INTO `lmpt_dev_temps` (`id_temps`, `valeur`, `actif`) VALUES
(1, 'Moins de 3h par semaine', '1'),
(2, 'Entre 3 et 5h par semaine', '1'),
(3, 'Entre 5 et 10h par semaine', '1'),
(4, 'Plus de 10h par semaine', '1'),
(5, 'Je ne suis pas disponible', '1');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `lmpt_dev_personnes`
--
ALTER TABLE `lmpt_dev_personnes`
  ADD CONSTRAINT `lmpt_dev_personnes_ibfk_26` FOREIGN KEY (`id_parrain`) REFERENCES `lmpt_dev_personnes` (`id_personne`),
  ADD CONSTRAINT `lmpt_dev_personnes_ibfk_27` FOREIGN KEY (`id_statut`) REFERENCES `lmpt_dev_statuts` (`id_statut`);
