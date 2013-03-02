<?php
require_once(ROOT.'classes/lib.php');
class personne{
	private $pdo;
	public $aInfos;


	private $aObligatedValue=array("nom"=>"verif_string" ,"prenom"=>"verif_string" ,
		"tel_port"=>"verif_tel" ,"email"=>"verif_email" ,
		"cp"=>"verif_cp" ,"date_naissance"=>"verif_date" ,
		"sexe"=>"verif_sexe" ,"id_action"=>"verif_action" ,"id_temps"=>"verif_temps",
		"chef_equipe"=>"verif_yn" ,
		"nom_parrain"=>"verif_string" ,"prenom_parrain"=>"verif_string" ,
		"email_parrain"=>"verif_email");
	
	private $aOtherValue=array("id_dispo"=>"verif_dispo" ,
		"id_competences"=>"verif_competence"  ,
		"RQ"=>"verif_string" ,"id_equipe"=>"verif_equipe",
		"email_equipe"=>"verif_email");

	function __construct(){
		$this->pdo=database::getInstance();
	}



	public function insert_personne($aValue){
		// echo "<pre>";
		// var_dump($aValue);
		// echo "</pre>";
		$stmt = $this->pdo->prepare("INSERT INTO  `personnes` (
			`id_personne` ,`nom` ,`prenom` ,`tel_port` ,`email` ,
			`cp` ,`date_naissance` ,`sexe` ,`chef_equipe` ,`RQ` ,`id_parrain` ,
			`nom_parrain` ,`prenom_parrain` ,`email_parrain` ,`email_equipe` ,
			`id_equipe` ,`id_statut` ,`id_temps` ,
			`date_form` ,`date_activation` ,
			`cle_activation`
			)
		VALUES (
			NULL ,  :nom,  :prenom,  :tel_port, 
			:email,  
			:cp,  :date_naissance,  :sexe, 
			:chef_equipe, :RQ,  :id_parrain,  :nom_parrain, 
			:prenom_parrain,  :email_parrain,  :email_equipe,
			:id_equipe, :id_statut,  :id_temps,  :date_form,  null,  
			:cle_activation)"
		);
		$stmt->execute($aValue['personne']);
		$id_personne=$this->pdo->lastInsertId();

		//actions
		if(!empty($aValue['action'])){
			$stmt = $this->pdo->prepare("INSERT INTO  `r_actions_personnes` (
				`id_personne` ,`id_action`
				)
			VALUES (
				:id_personne,:id)"
			);
			foreach($aValue['action'] as $value){
				$stmt->execute(array("id_personne"=>$id_personne,"id"=>$value));
			}
		}
		

		//competences
		if(!empty($aValue['competences'])){
			$stmt = $this->pdo->prepare("INSERT INTO  `r_competences_personnes` (
				`id_personne` ,`id_competence`
				)
			VALUES (
				:id_personne,:id)"
			);
			foreach($aValue['competences'] as $value){
				$stmt->execute(array("id_personne"=>$id_personne,"id"=>$value));
			}
		}

		//dispo
		if(!empty($aValue['dispo'])){
			$stmt = $this->pdo->prepare("INSERT INTO  `r_disponibilites_personnes` (
				`id_personne` ,`id_dispo`
				)
			VALUES (
				:id_personne,:id)"
			);
			foreach($aValue['dispo'] as $value){
				$stmt->execute(array("id_personne"=>$id_personne,"id"=>$value));
			}
		}
		
		
	}

	public function verif_string($value){
		$regex="#^[^<>]+$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_tel($value){
		$regex="#^0[1-9][0-9]{8}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_email($value){
		$regex="#^[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_cp($value){
		$regex="#^[0-9]{2,5}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_date($value){
		$regex="#^[0-9]{2}[0-9]{2}[0-9]{4}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_sexe($value){
		$regex="#^(Homme|Femme)$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_action($aId){
		$aVal=$this->getActions();
		$ret=true;
		foreach($aId as $id){
			if(!array_key_exists($id,$aVal)){
				$ret=false;
				break;
			}
		}
		return $ret;
	}

	public function verif_dispo($aId){
		$aVal=$this->getDisponibilites();		
		$ret=true;
		foreach($aId as $id){
			if(!array_key_exists($id,$aVal)){
				$ret=false;
				break;
			}
		}
		return $ret;
	}
	public function verif_competence($aId){
		$aVal=$this->getCompetences();
		$ret=true;
		foreach($aId as $id){
			if(!array_key_exists($id,$aVal)){
				$ret=false;
				break;
			}
		}
		
		return $ret;
	}

	public function verif_temps($id){
		$aVal=$this->getTemps();
		$ret=true;
		if(!array_key_exists($id,$aVal)){
			$ret=false;
		}		
		return $ret;
	}

	public function verif_equipe($id){
		$aVal=$this->getEquipe();
		$ret=true;
		if(!array_key_exists($id,$aVal)){
			$ret=false;
		}		
		return $ret;
	}

	public function verif_yn($value){
		$regex="#^(oui|non)$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_regex($regex,$value){
		return preg_match($regex,$value);
	}

	public function getIdParrain(){
		$stmt = $this->pdo->prepare("SELECT id_personne FROM `personnes`  WHERE nom LIKE :nom_parrain AND prenom LIKE :prenom_parrain AND email LIKE :email_parrain");
		$stmt->execute(array("nom_parrain"=>$this->aInfos['personne']['nom_parrain'],"prenom_parrain"=>$this->aInfos['personne']['prenom_parrain'],"email_parrain"=>$this->aInfos['personne']['email_parrain'])) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return ($ret===false)?NULL:$ret['id_competences'];
	}


	public function verif_value($aPost){
		$return=true;
		$aListeVide=array();
		$aListeNonCorrect=array();
		foreach($this->aObligatedValue as $key=>$fnct){
			if(!isset($aPost[$key])){
				$aListeVide[]=$key;
			}
			else if(!$this->$fnct($aPost[$key])){
				$aListeNonCorrect[]=$key;
			}
		}
		foreach($this->aOtherValue as $key=>$fnct){
			if(!empty($aPost[$key]) && !$this->$fnct($aPost[$key])){
				$aListeNonCorrect[]=$key;
			}
		}
		if(!empty($aListeVide) || !empty($aListeNonCorrect)){
			$return=array("vide"=>$aListeVide,"nCorrect"=>$aListeNonCorrect);
		}/*
		else {
			$parrain=$this->verif_parrain($aPost);
			if(!$parrain){				
				$return["parrain"]=$parrain;
			}
		}*/
		return $return;
	}

	

	public function prepare_value($aPost){
		$aValue['personne']=$aPost;		
		unset($aValue['personne']['submit_inscription']);
		unset($aValue['personne']['captcha_code']);
		$aValue['personne']['date_naissance']=preg_replace("#^([0-9]{2})([0-9]{2})([0-9]{4})$#","$3/$2/$1",$aValue['personne']['date_naissance']);; 
		$aValue['personne']['date_form']=date("Y-m-d H:i:s"); 
		$aValue['personne']['cle_activation']=md5(time());
		$aValue['personne']['id_statut']=$this->getIdStatut("WAIT_ACTIVATION");
		$aValue['personne']['id_parrain']=$this->getIdParrain();
		$aValue['personne']['RQ']=(!empty($aPost['RQ']))?$aPost['RQ']:"";
		$aValue['action']=(!empty($aPost['id_action']))?$aPost['id_action']:array();
		$aValue['competences']=(!empty($aPost['id_competences']))?$aPost['id_competences']:array();
		$aValue['dispo']=(!empty($aPost['id_dispo']))?$aPost['id_dispo']:array();
		unset($aValue['personne']['id_action']);
		unset($aValue['personne']['id_competences']);
		unset($aValue['personne']['id_dispo']);
		$this->aInfos=$aValue;
		return $aValue;
	}

	public function getCompetences(){
		$stmt = $this->pdo->prepare("SELECT id_competences,	competence FROM `competences`  WHERE actif='1'");
		$stmt->execute() ;
		$ret=array();
		while($competence=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[$competence['id_competences']]=$competence['competence'];
		}
		return $ret;
	}

	public function getIdCompetences($value){
		$stmt = $this->pdo->prepare("SELECT id_competences, FROM `competences`  WHERE actif='1' AND competence=:value");
		$stmt->execute(array("value"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_competences'];
	}

	public function getDisponibilites(){
		$stmt = $this->pdo->prepare("SELECT id_dispo,dispo FROM `disponibilites`  WHERE actif='1'");
		$stmt->execute() ;
		$ret=array();
		while($dispo=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[$dispo['id_dispo']]=$dispo['dispo'];
		}
		return $ret;
	}

	public function getIdDisponibilites($value){
		$stmt = $this->pdo->prepare("SELECT id_dispo, FROM `disponibilites`  WHERE actif='1' AND dispo=:value");
		$stmt->execute(array("dispo"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_dispo'];
	}

	public function getActions(){
		$stmt = $this->pdo->prepare("SELECT id_action,	action FROM `actions`  WHERE actif='1'");
		$stmt->execute() ;
		$ret=array();
		while($action=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[$action['id_action']]=$action['action'];
		}
		return $ret;
	}

	public function getIdAction($value){
		$stmt = $this->pdo->prepare("SELECT id_action,	action FROM `actions`  WHERE actif='1' AND action=:value");
		$stmt->execute(array("value"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_action'];
	}

	public function getTemps(){
		$stmt = $this->pdo->prepare("SELECT id_temps,valeur FROM `temps`  WHERE actif='1'");
		$stmt->execute() ;
		$ret=array();
		while($temps=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[$temps['id_temps']]=$temps['valeur'];
		}
		return $ret;
	}

	public function getIdTemps($value){
		$stmt = $this->pdo->prepare("SELECT id_temps,valeur FROM `temps`  WHERE actif='1' AND valeur=:value");
		$stmt->execute(array("value"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_temps'];
	}

	public function getEquipe(){
		$stmt = $this->pdo->prepare("SELECT id_equipe,valeur FROM `equipe`  WHERE actif='1'");
		$stmt->execute() ;
		$ret=array();
		while($equipe=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[$equipe['id_equipe']]=$equipe['valeur'];
		}
		return $ret;
	}

	public function getIdEquipe($value){
		$stmt = $this->pdo->prepare("SELECT id_equipe,valeur FROM `equipe`  WHERE actif='1' AND valeur=:value");
		$stmt->execute(array("value"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_equipe'];
	}

	

	public function getStatuts(){
		$stmt = $this->pdo->prepare("SELECT id_statut,	statut FROM `statuts`  WHERE actif='1'");
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getIdStatut($value){
		$stmt = $this->pdo->prepare("SELECT id_statut,	statut FROM `statuts`  WHERE actif='1' AND statut=:statut");
		$stmt->execute(array("statut"=>$value)) ;
		$ret=$stmt->fetch(PDO::FETCH_ASSOC);
		return $ret['id_statut'];
	}

	public function send_mail_activation(){
		$lien="activation.php?key=".$this->aInfos['personne']['cle_activation'];
		$prenom=utf8_encode($this->aInfos['personne']['prenom']);
		$nom=utf8_encode($this->aInfos['personne']['nom']);
		$image=SITE_FRONT."entete.jpg";
		$mail = <<<EOF
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html>
	<head>
		<meta http-equiv=Content-Type content="text/html; charset=utf-8" /> 
	</head>
	<body>
		<div>
		Bonjour $prenom $nom 
		<p>Merci de vous etre inscrit.</p>
		<a href="$lien">Activation:</a> 
		</div>
		<div class="image">
		<img src="$image"/>
		</div>
	</body>
</html>
		
EOF;
		
		lib::send_mail(utf8_decode($mail), $this->aInfos['personne']['email'], "activation aide pour La Manif Pour Tous", EMAIL_MANIF, EMAIL_MANIF);
	}

	public function activate($cle_activation){
		$ret=false;
		$stmt = $this->pdo->prepare("UPDATE `personnes`  SET date_activation=:date_activation,id_statut=:id_statut WHERE cle_activation=:cle_activation");
		$stmt->execute(array("date_activation"=>date("Y-m-d H:i:s"),"id_statut"=>$this->getIdStatut("WAIT_VALIDATION"),"cle_activation"=>$cle_activation)) ;
		if($stmt->rowCount()==1){		
			$ret=true;	
			$spreedsheet= new spreedsheet();
			try {
				$spreedsheet->add_personne($this->getInfosPersonne($cle_activation));
				
			} catch (Exception $e) {
				$stmt->execute(array("date_activation"=>date("Y-m-d H:i:s"),"id_statut"=>$this->getIdStatut("ERROR_ACTIVATION"),"cle_activation"=>$cle_activation)) ;
				lib::send_mail("erreur d'enregistrement cle=".$cle_activation, EMAIL_ADMIN, "erreur activation aide pour La Manif Pour Tous", EMAIL_MANIF, EMAIL_MANIF);
			}
			
		}
		return $ret;
	}

	public function listChampPersonne(){
		$sql="SELECT COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME='personnes'";
		$stmt = $this->pdo->prepare($sql);
		$stmt->execute() ;
		$ret=array();
		while($champ=$stmt->fetch(PDO::FETCH_ASSOC)){
			$ret[]=$champ['COLUMN_NAME'];
		}
		$ret[]="id_dispo";
		$ret[]="id_actions";
		$ret[]="id_competences";
		return $ret;
	}

	public function getInfosPersonne($cle_activation){
		$stmt = $this->pdo->prepare(
			"SELECT  GROUP_CONCAT(DISTINCT action SEPARATOR ';') as action,
					GROUP_CONCAT(DISTINCT competence SEPARATOR ';') as competence,
					GROUP_CONCAT(DISTINCT dispo SEPARATOR ';') as dispo,
					t.valeur as temps,
					e.valeur as equipe,
					p . * 
			FROM `personnes` p 
				left join( r_actions_personnes rap) 
					on p.id_personne=rap.id_personne
				left join(actions a) 
					on rap.id_action = a.id_action
				left join( r_competences_personnes rcp) 
					on p.id_personne=rcp.id_personne
				left join(competences c) 
					on rcp.id_competence = c.id_competences
				left join( r_disponibilites_personnes rdp) 
					on p.id_personne=rdp.id_personne
				left join(disponibilites d) 
					on rdp.id_dispo = d.id_dispo
				left join( temps t) 
					on p.id_temps=t.id_temps
				left join( equipe e) 
					on p.id_equipe=e.id_equipe
			WHERE cle_activation=:cle_activation
			GROUP BY id_personne"
			);
		$stmt->execute(array("cle_activation"=>$cle_activation)) ;
		return $stmt->fetch(PDO::FETCH_ASSOC);
	}



}



?>
