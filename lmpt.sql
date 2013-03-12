-- phpMyAdmin SQL Dump
-- version OVH
-- http://www.phpmyadmin.net
--
-- Client: mysql51-79.perso
-- Généré le : Mar 12 Mars 2013 à 19:26
-- Version du serveur: 5.1.66
-- Version de PHP: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données: `recrutemclmpt`
--

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_actions`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_actions` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_competences` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_disponibilites` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_equipe` (
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
(3, 'Sécurité (Homme majeur uniquement)', '1'),
(4, 'Accueil', '1'),
(5, 'Je tracte seulement', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_historiques`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_historiques` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_personnes` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Contenu de la table `lmpt_dev_personnes`
--

INSERT INTO `lmpt_dev_personnes` (`id_personne`, `nom`, `prenom`, `tel_port`, `email`, `cp`, `date_naissance`, `sexe`, `chef_equipe`, `RQ`, `id_parrain`, `nom_parrain`, `prenom_parrain`, `email_parrain`, `email_equipe`, `id_equipe`, `id_statut`, `id_temps`, `autre_competences`, `date_form`, `date_activation`, `cle_activation`) VALUES
(1, 'poi', 'poi', '0123456789', 'bastien.famillepaul@gmail.com', '12345', '1999-12-12', 'Homme', 'oui', '', NULL, 'aze', 'aze', 'aze@aze.fr', '', 2, 1, 5, '', '2013-03-04 21:06:17', NULL, '3cabb391e3fa176aa272fa42b8616af7'),
(2, 'de la Mardière', 'Guerric', '0628231374', 'gdelamardiere@gmail.com', '75007', '0000-00-00', 'Homme', 'non', 'ceci est une remarque avec des \\'' et des \\" !!!', NULL, 'Paul', 'batien', 'b@stien-paul.fr', 'b@stien-paul.fr', 2, 2, 1, 'web \\'' test', '2013-03-06 10:08:58', '2013-03-06 10:09:34', 'c3180be8657c374bbe2b618ee785c0eb'),
(3, 'de la Mardière', 'Guerric', '0628231374', 'gdelamardiere@gmail.com', '65987', '0000-00-00', 'Homme', 'oui', 'commentaire avec des '' et des " !!! et même de s / et des \\', NULL, 'Paul', 'Bastien', 'b@stien-paul.fr', 'b@stien-paul.fr', 4, 2, 1, 'web '' test', '2013-03-06 10:19:16', '2013-03-06 10:20:03', '1f38ff6b924fb9c5ebde2f64483f533e'),
(4, 'de la Mardière', 'Guerric', '0628231374', 'gdelamardiere@gmail.com', '65987', '1987-02-12', 'Homme', 'oui', 'c''est un test pour les dates de naissance', NULL, 'de la Mardière', 'Guerric', 'gdelamardiere@gmail.com', 'b@stien-paul.fr', 4, 2, 1, 'web '' test', '2013-03-06 10:25:20', '2013-03-06 10:33:39', '02fe15a399707945636a8f599b298589'),
(5, 'PAUL', 'Bastien', '0678988888', 'bastien.famillepaul@gmail.com', '99999', '2999-12-12', 'Homme', 'oui', '', NULL, 'piou', 'piu', 'iup@iu.ff', '', 2, 2, 1, 'Poubelle', '2013-03-06 23:49:04', '2013-03-06 23:49:41', 'e32529191054ae4b400dbd55ccb2de59'),
(6, 'robert', 'redford', '0987654321', 'bastien.famillepaul@gmail.com', '12345', '1234-12-12', 'Homme', 'oui', '', NULL, 'poiu', 'piou', 'poiu@poiu.de', '', 4, 2, 2, '', '2013-03-07 00:14:53', '2013-03-07 00:15:43', '12d479b7d76462379663046063128c25'),
(7, 'robert', 'redford', '0987654321', 'bastien.famillepaul@gmail.com', '12345', '0000-00-00', 'Homme', 'oui', '', NULL, 'poiu', 'piou', 'poiu@poiu.de', '', 4, 2, 0, '', '2013-03-07 00:22:10', '2013-03-07 00:22:28', '1eacbcde8deb1ce9d5c93e67c1ffeeef'),
(8, 'Donald', 'Duck', '0600000000', 'h.delatour@lamanifpourtous.fr', '00000', '2001-01-01', 'Homme', 'oui', 'coin coin coin, coincoincoiin, coinnnnncoin !', NULL, 'Picsou', 'Geant', 'b.paul@lamanifpourtous.fr', '', 4, 2, 4, 'la danse des canards', '2013-03-07 02:17:51', '2013-03-07 02:18:26', '22b5afbcb20d6a5c3401f0c26b562a54'),
(9, 'Théry', 'Agnès', '0628253095', 'a.thery@lamanifpourtous.fr', '75008', '0000-00-00', 'Femme', 'non', '', NULL, 'Paul', 'Bastien', 'b.paul@lamanifpourtous.fr', 'e.matrot@lamanifpourtous.fr', 4, 2, 1, '', '2013-03-07 09:04:30', '2013-03-07 09:04:53', '9c783815ad9a4de27670afeb6548dda6'),
(10, 'Hollande', 'François', '0606060606', 'hollande@elysee.fr', '78900', '0000-00-00', 'Femme', 'non', 'Si je pouvais passer à l''échafaud après Taubira, ça serait cool, merci.', NULL, 'Valoche', 'Valoche', 'valoche@valoche.com', 'valoche@valoche.com', 5, 1, 4, '', '2013-03-07 09:22:34', NULL, 'd27fd6980c1831d38ca09a89ffe373fa'),
(11, 'Hollande', 'François', '0609060906', 'etienne.matrot@orange.fr', '00000', '0000-00-00', 'Femme', 'non', 'Si je pouvais passer à l''échafaud après Valoche, ça serait cool ! Merci !\r\nMerci pour tout ce que vous faîtes, vous êtes géniaux !', NULL, 'Valoche', 'Valoche', 'valoche@valoche.com', 'valoche@valoche.com', 2, 2, 3, '', '2013-03-07 09:25:18', '2013-03-07 09:27:03', '8c9714103d41530bc6cfe37a090f62ad'),
(12, 'Hollande', 'François', '0606060606', 'etienne.matrot@orange.fr', '95000', '0000-00-00', 'Femme', 'non', '', NULL, 'Valoche', 'Valoche', 'valoche@valoche.com', 'valoche@valoche.com', 2, 2, 1, '', '2013-03-07 09:31:21', '2013-03-07 09:31:57', 'af8002032fa403bde9b6dc995686cb13'),
(13, 'Hollande', 'François', '0606060606', 'etienne.matrot@orange.fr', '95000', '0000-00-00', 'Femme', 'oui', '', NULL, 'Valoche', 'Valoche', 'valoche@valoche.com', 'valoche@valoche.com', 2, 2, 2, '', '2013-03-07 09:33:25', '2013-03-07 09:34:33', 'ba3e7aac452832e73acb95cc0a7ba8a8'),
(14, 'van den Bossche', 'Domitille', '0674210570', 'domvandenbossche@gmail.com', '75015', '0000-00-00', 'Femme', 'oui', '', NULL, 'Paul', 'Bastien', 'b.paul@lamanifpourtous.fr', '', 4, 2, 4, '', '2013-03-07 09:47:31', '2013-03-07 09:50:06', '7f94a5b43def871ebc7a2911333b1040'),
(15, 'Dugas', 'Augustin', '0669114688', 'a.dugas@lamanifpourtous.fr', '78100', '0000-00-00', 'Homme', 'oui', 'j''aime bien le bandeau en haut, ca fait vraiment formulaire officiel!', NULL, 'augustin', 'dugas', 'a.dugas@lamanifpourtous.fr', '', 3, 2, 4, '', '2013-03-07 10:07:21', '2013-03-07 10:10:03', 'bd89a68f784df526063ca475a13ad858'),
(16, 'Marès', 'Aude', '0661259661', 'audedlm@yahoo.fr', '18220', '0000-00-00', 'Femme', 'non', '', NULL, 'Recrutement', 'Aude', 'recrutement@lamanifpourtous.fr', '', 5, 2, 4, 'je sais répondre aux mails qui arrivent sur la boîte recrutement', '2013-03-07 10:21:47', '2013-03-07 10:22:15', 'e80f9809a540cbda30a04798b5ba23bd'),
(17, 'Billod', 'Anne', '0628789157', 'annebillod@sfr.fr', '18110', '0000-00-00', 'Femme', 'non', '', NULL, 'Marès', 'Aude', 'audedlm@yahoo.fr', '', 4, 2, 1, 'Bonne humeur', '2013-03-07 10:38:11', '2013-03-07 10:59:49', 'a0d47e5793249069e10a1964713eeae3'),
(18, 'languille', 'anais', '0634097988', 'anais.languille@gmail.com', '75007', '0000-00-00', 'Femme', 'non', '', NULL, 'regrgqq', 'qqqrg', 'qrgq@sg.fr', '', 4, 2, 0, '', '2013-03-07 10:43:44', '2013-03-07 10:45:21', '117054ffff3aa1071d0bf0ed66b21f6f'),
(19, 'de MAGNEVAL', 'Constance', '0662126457', 'constance@lamanifpourtous.fr', '75009', '0000-00-00', 'Femme', 'non', '', NULL, 'recrutement', 'Aude', 'recrutement@lamanifpourtous.fr', '', 4, 2, 4, 'DG association', '2013-03-07 11:23:42', '2013-03-07 11:25:55', '95dec95b4c17e49c03524904b7ebe297'),
(20, 'Monclar', 'Lorraine', '0667442401', 'l.monclar@lamanifpourtous.fr', '75016', '0000-00-00', 'Femme', 'oui', 'Un truc stylé les gens svp!! :p\r\nsinon, big love et trop cool pour le nouveau formulaire :)', NULL, 'Taubira', 'Christiane', 'cricri@justice.gouv', 'elena@femen.org', 2, 2, 2, 'Pipeau et jargon', '2013-03-07 17:57:04', '2013-03-07 17:57:29', '9a109e014b97893dc1709dd252d024c2'),
(21, 'de Beauvoir', 'Simone', '0667442401', 'l.monclar@lamanifpourtous.fr', '75006', '0000-00-00', 'Femme', 'oui', 'Bon visiblement la date de naissance il a du mal hein... Et j''ai dû refaire trois fois le code captcha.', NULL, 'Taubira', 'Christiane', 'cricri@justice.gouv', 'jpsartre@existentialisme.com', 2, 2, 4, 'Pipeau et gender studies', '2013-03-07 18:05:17', '2013-03-07 18:05:50', '3efdd364764f50886b848aa670bd50fd'),
(22, 'Paul', 'Bastien', '0678888888', 'bastien.famillepaul@gmail.com', '12345', '0000-00-00', 'Homme', 'oui', '', NULL, 'poiu', 'piu', 'piou@piou.fr', '', 2, 2, 2, '', '2013-03-08 00:19:27', '2013-03-08 00:19:44', 'cb818ea05773f37548921d18af23c8ab'),
(23, 'Paul', 'Bastien', '0678888888', 'bastien.famillepaul@gmail.com', '12345', '0000-00-00', 'Homme', 'oui', '', NULL, 'poiu', 'piu', 'piou@piou.fr', '', 2, 2, 2, '', '2013-03-08 00:23:11', '2013-03-08 00:23:31', '3002ff8e7e9bfe37b45f7fc217b5cf69');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_actions_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_r_actions_personnes` (
  `id_personne` int(11) NOT NULL,
  `id_action` int(11) NOT NULL,
  KEY `id_personne` (`id_personne`,`id_action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_actions_personnes`
--

INSERT INTO `lmpt_dev_r_actions_personnes` (`id_personne`, `id_action`) VALUES
(1, 1),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(5, 3),
(6, 1),
(7, 1),
(8, 1),
(8, 2),
(8, 3),
(9, 3),
(10, 2),
(11, 1),
(11, 2),
(11, 3),
(12, 2),
(13, 1),
(14, 1),
(14, 2),
(14, 3),
(15, 1),
(16, 1),
(16, 2),
(17, 2),
(18, 3),
(19, 3),
(20, 1),
(20, 2),
(20, 3),
(21, 1),
(21, 2),
(21, 3),
(22, 2),
(23, 2);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_competences_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_r_competences_personnes` (
  `id_competence` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_competence` (`id_competence`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_competences_personnes`
--

INSERT INTO `lmpt_dev_r_competences_personnes` (`id_competence`, `id_personne`) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 15),
(2, 20),
(2, 21),
(3, 2),
(3, 5),
(3, 15),
(3, 20),
(3, 21),
(5, 5),
(5, 10),
(5, 13),
(5, 15),
(5, 20),
(5, 21),
(7, 5),
(7, 14),
(7, 15),
(7, 19),
(7, 20),
(7, 21),
(9, 5),
(9, 11),
(9, 12),
(9, 15),
(9, 20),
(9, 21);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_r_db_gd`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_r_db_gd` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_r_disponibilites_personnes` (
  `id_dispo` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_dispo` (`id_dispo`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_dev_r_disponibilites_personnes`
--

INSERT INTO `lmpt_dev_r_disponibilites_personnes` (`id_dispo`, `id_personne`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 8),
(1, 10),
(1, 14),
(1, 15),
(1, 16),
(1, 17),
(1, 19),
(1, 21),
(1, 22),
(1, 23),
(2, 1),
(2, 5),
(2, 8),
(2, 14),
(2, 15),
(2, 16),
(2, 19),
(2, 21),
(3, 5),
(3, 8),
(3, 11),
(3, 14),
(3, 15),
(3, 16),
(3, 19),
(3, 20),
(3, 21),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 8),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 19),
(4, 20),
(4, 21);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_dev_statuts`
--

CREATE TABLE IF NOT EXISTS `lmpt_dev_statuts` (
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

CREATE TABLE IF NOT EXISTS `lmpt_dev_temps` (
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

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_actions`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_actions` (
  `id_action` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(100) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `lmpt_prod_actions`
--

INSERT INTO `lmpt_prod_actions` (`id_action`, `action`, `actif`) VALUES
(1, 'Tracter', '1'),
(2, 'Participer à des actions ponctuelles', '1'),
(3, 'Être bénévole le jour de la manifestation', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_competences`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_competences` (
  `id_competences` int(11) NOT NULL AUTO_INCREMENT,
  `competence` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_competences`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Contenu de la table `lmpt_prod_competences`
--

INSERT INTO `lmpt_prod_competences` (`id_competences`, `competence`, `actif`) VALUES
(2, 'Communication', '1'),
(3, 'Audiovisuel (cameraman, monteur video)', '1'),
(5, 'Relation publique (attaché de presse...)', '1'),
(7, 'Gestion de projet', '1'),
(9, 'Graphisme', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_disponibilites`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_disponibilites` (
  `id_dispo` int(11) NOT NULL AUTO_INCREMENT,
  `dispo` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_dispo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `lmpt_prod_disponibilites`
--

INSERT INTO `lmpt_prod_disponibilites` (`id_dispo`, `dispo`, `actif`) VALUES
(1, 'Le matin', '1'),
(2, 'L''après-midi', '1'),
(3, 'Le soir', '1'),
(4, 'La semaine précédant la manif', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_equipe`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_equipe` (
  `id_equipe` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(200) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_equipe`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_prod_equipe`
--

INSERT INTO `lmpt_prod_equipe` (`id_equipe`, `valeur`, `actif`) VALUES
(2, 'Logistique (Disponibilité dès le samedi et/ou le dimanche matin tôt)', '1'),
(3, 'Sécurité (Homme majeur uniquement)', '1'),
(4, 'Accueil', '1'),
(5, 'Je tracte seulement', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_historiques`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_historiques` (
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
-- Structure de la table `lmpt_prod_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_personnes` (
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
-- Contenu de la table `lmpt_prod_personnes`
--

INSERT INTO `lmpt_prod_personnes` (`id_personne`, `nom`, `prenom`, `tel_port`, `email`, `cp`, `date_naissance`, `sexe`, `chef_equipe`, `RQ`, `id_parrain`, `nom_parrain`, `prenom_parrain`, `email_parrain`, `email_equipe`, `id_equipe`, `id_statut`, `id_temps`, `autre_competences`, `date_form`, `date_activation`, `cle_activation`) VALUES
(1, 'TRANNOY', 'FOUCAULD', '0695788626', 'foucauld21@hotmail.fr', '21000', '1996-09-09', 'Homme', 'non', 'étant mineur, merci de bien me mettre avec Delphine ROCHE-BRUYN', NULL, 'ROCHE-BRUYN', 'DELPHINE', 'del.roche.bruyn@gmail.com', 'del.roche.bruyn@gmail.com', 4, 1, 0, '', '2013-03-12 19:25:18', NULL, 'e741dcfc7c1099017f8236ce6579008b');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_r_actions_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_r_actions_personnes` (
  `id_personne` int(11) NOT NULL,
  `id_action` int(11) NOT NULL,
  KEY `id_personne` (`id_personne`,`id_action`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_prod_r_actions_personnes`
--

INSERT INTO `lmpt_prod_r_actions_personnes` (`id_personne`, `id_action`) VALUES
(1, 1),
(1, 3),
(2, 1),
(3, 1),
(4, 1),
(5, 3),
(6, 1);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_r_competences_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_r_competences_personnes` (
  `id_competence` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_competence` (`id_competence`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_prod_r_competences_personnes`
--

INSERT INTO `lmpt_prod_r_competences_personnes` (`id_competence`, `id_personne`) VALUES
(1, 1),
(9, 3),
(9, 4);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_r_db_gd`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_r_db_gd` (
  `id_r_db_gd` int(11) NOT NULL AUTO_INCREMENT,
  `name_gd` varchar(80) NOT NULL,
  `position_gd` int(11) NOT NULL,
  `name_db` varchar(50) DEFAULT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_r_db_gd`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Contenu de la table `lmpt_prod_r_db_gd`
--

INSERT INTO `lmpt_prod_r_db_gd` (`id_r_db_gd`, `name_gd`, `position_gd`, `name_db`, `actif`) VALUES
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
-- Structure de la table `lmpt_prod_r_disponibilites_personnes`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_r_disponibilites_personnes` (
  `id_dispo` int(11) NOT NULL,
  `id_personne` int(11) NOT NULL,
  KEY `id_dispo` (`id_dispo`,`id_personne`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `lmpt_prod_r_disponibilites_personnes`
--

INSERT INTO `lmpt_prod_r_disponibilites_personnes` (`id_dispo`, `id_personne`) VALUES
(1, 3),
(1, 4),
(2, 1),
(4, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_statuts`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_statuts` (
  `id_statut` int(11) NOT NULL AUTO_INCREMENT,
  `statut` varchar(20) NOT NULL,
  `actif` enum('0','1') NOT NULL,
  PRIMARY KEY (`id_statut`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_prod_statuts`
--

INSERT INTO `lmpt_prod_statuts` (`id_statut`, `statut`, `actif`) VALUES
(1, 'WAIT_ACTIVATION', '1'),
(2, 'WAIT_VALIDATION', '1'),
(3, 'VALIDATE', '1'),
(4, 'ERROR_VALIDATION', '1'),
(5, 'ERROR_ACTIVATION', '1');

-- --------------------------------------------------------

--
-- Structure de la table `lmpt_prod_temps`
--

CREATE TABLE IF NOT EXISTS `lmpt_prod_temps` (
  `id_temps` int(11) NOT NULL AUTO_INCREMENT,
  `valeur` varchar(50) NOT NULL,
  `actif` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_temps`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `lmpt_prod_temps`
--

INSERT INTO `lmpt_prod_temps` (`id_temps`, `valeur`, `actif`) VALUES
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

--
-- Contraintes pour la table `lmpt_prod_personnes`
--
ALTER TABLE `lmpt_prod_personnes`
  ADD CONSTRAINT `lmpt_prod_personnes_ibfk_26` FOREIGN KEY (`id_parrain`) REFERENCES `lmpt_prod_personnes` (`id_personne`),
  ADD CONSTRAINT `lmpt_prod_personnes_ibfk_27` FOREIGN KEY (`id_statut`) REFERENCES `lmpt_prod_statuts` (`id_statut`);
