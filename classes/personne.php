<?php
class personne{
	private $pdo;
	private $aInfos;


	private $aObligatedValue=array("nom"=>"verif_string" ,"prenom"=>"verif_string" ,
							"tel_port"=>"verif_tel" ,"email"=>"verif_email" ,
							"cp"=>"verif_cp" ,"date_naissance"=>"verif_date" ,
							"sexe"=>"verif_sexe" ,"id_action"=>"verif_action" ,"id_dispo"=>"verif_dispo" ,
							"id_competence"=>"verif_competence" ,"chef_equipe"=>"verif_yn" ,
							"nom_parain"=>"verif_string" ,"prenom_parain"=>"verif_string" ,
							"email_parain"=>"verif_email");
	
	function __construct(){
		$this->pdo=database::getInstance();
	}



	public function insert_personne($aValue){
		$stmt = $this->pdo->prepare("INSERT INTO  `lmpt`.`personnes` (
								`id_personne` ,`nom` ,`prenom` ,`tel_port` ,`email` ,
								`cp` ,`date_naissance` ,`sexe` ,`id_action` ,`id_dispo` ,
								`id_competence` ,`chef_equipe` ,`RQ` ,`id_parain` ,
								`nom_parain` ,`prenom_parain` ,`email_parain` ,`id_statut` ,
								`date_form` ,`date_activation` ,`cle_activation`
								)
								VALUES (
								NULL ,  :nom,  :prenom,  :tel_port, 
								:email,  :cp,  :date,  :sexe, 
								:id_action,  :id_dispo,  :id_competence,  :chef_equipe, 
								:req,  :id_parain,  :nom_parain, 
								:prenom_parain,  :email_parain,  
								:id_statut,  :date_form,  null,  
								:cle)"
			);
		$stmt->execute($aValue);
	}

	public function verif_string($value){
		$regex="#^$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_tel($value){
		$regex="#^0[1-9][0-9]{8}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_cp($value){
		$regex="#^[0-9]{2,5}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_date($value){
		$regex="#^[0-9]{4}/[0-9]{2}/[0-9]{2}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_sexe($value){
		$regex="#^[h,f]$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_action($id){
		$aVal=$this->getCompetences();
		return in_array($id,$aVal);
	}

	public function verif_dispo($id){
		$aVal=$this->getDisponibilites();
		return in_array($id,$aVal);
	}
	public function verif_competence($id){
		$aVal=$this->getCompetences();
		return in_array($id,$aVal);
	}

	public function verif_yn($value){
		$regex="#^[0-1]$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_regex($regex,$value){
		return preg_match($regex,$value);
	}


	public function verif_value($aPost){
		$return=true;
		$aListeVide=array();
		$aListeNonCorrect=array();
		$parain=verif_parrain($aPost);
		foreach($this->aObligatedValue as $key=>$fnct){
			if(empty($aPost[$key])){
				$aListeVide[]=$key;
			}
			else if(!$this->$fnct($aPost[$key])){
				$aListeNonCorrect[]=$key;
			}
		}
		if(!empty($aListeVide) || !empty($aListeNonCorrect || !$parain)){
			$return=array("vide"=>$aListeVide,"nCorrect"=>$aListeNonCorrect,"parain"=>$parain);
		}
		return $return;
	}

	public function verif_parain($aPost){
		$return=true;
	}

	public function prepare_value($aPost){
		$aValue=$aPost;
		$aValue['date_form']=date("Y-m-d H:i:s"); 
		$aValue['cle_activation']=md5(time());
		$aValue['id_statut']=$this->getIdStatut("WAIT_ACTIVATION");
		$aValue['RQ']=(!empty($aPost['RQ']))?$aPost['RQ']:"";
		$this->aInfos=$aValue;
		return $aValue;
	}

	public function getCompetences(){
		$stmt = $this->pdo->prepare("SELECT id_competences,	competence FROM `competences`  WHERE actif='1'");
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getIdCompetences($value){
		$stmt = $this->pdo->prepare("SELECT id_competences, FROM `competences`  WHERE actif='1' AND competence=:value");
		$stmt->execute(array("competence"=>$value)) ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getDisponibilites(){
		$stmt = $this->pdo->prepare("SELECT id_dispo,dispo FROM `disponibilites`  WHERE actif='1'");
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getIdDisponibilites($value){
		$stmt = $this->pdo->prepare("SELECT id_dispo, FROM `disponibilites`  WHERE actif='1' AND dispo=:value");
		$stmt->execute(array("dispo"=>$value)) ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getActions(){
		$stmt = $this->pdo->prepare("SELECT id_action,	action FROM `actions`  WHERE actif='1'");
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getIdAction($value){
		$stmt = $this->pdo->prepare("SELECT id_action,	action FROM `actions`  WHERE actif='1' AND action=:value");
		$stmt->execute(array("action"=>$value)) ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getStatuts(){
		$stmt = $this->pdo->prepare("SELECT id_statut,	statut FROM `statuts`  WHERE actif='1'");
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function getIdStatut($value){
		$stmt = $this->pdo->prepare("SELECT id_statut,	statut FROM `statuts`  WHERE actif='1' AND statut=:value");
		$stmt->execute(array("statut"=>$value)) ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function send_mail_activation(){
		$lien=SITE_FRONT."activate.php?key=".$this->aInfos['cle_activation'];
		echo $lien;
	}

	public function activate($cle_activation){

	}


}



?>