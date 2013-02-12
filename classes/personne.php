<?php
class personne{
	private $pdo;
	public $aInfos;


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
		$regex="#^[0-9]{4}/[0-9]{2}/[0-9]{2}$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_sexe($value){
		$regex="#^[Homme,Femme]$#";
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
		$regex="#^[Oui-Non]$#";
		return $this->verif_regex($regex,$value);
	}

	public function verif_regex($regex,$value){
		return preg_match($regex,$value);
	}

	public function verif_parrain($aPost){
		$stmt = $this->pdo->prepare("SELECT count (id_personne), FROM `personnes`  WHERE nom_parain LIKE :nom_parrain AND prenom_parain LIKE :prenom_parrain AND email_parain LIKE :email_parrain");
		$stmt->execute(array("nom_parrain"=>$aPost['nom_parrain'],"prenom_parrain"=>$aPost['prenom_parrain'],"email_parrain"=>$aPost['email_parrain'])) ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}


	public function verif_value($aPost){
		$return=true;
		$aListeVide=array();
		$aListeNonCorrect=array();
		foreach($this->aObligatedValue as $key=>$fnct){
			if(empty($aPost[$key])){
				$aListeVide[]=$key;
			}
			else if(!$this->$fnct($aPost[$key])){
				$aListeNonCorrect[]=$key;
			}
		}
		if(!empty($aListeVide) || !empty($aListeNonCorrect)){
			$return=array("vide"=>$aListeVide,"nCorrect"=>$aListeNonCorrect);
		}
		else {
			$parain=$this->verif_parrain($aPost);
			if(!$parrain){				
				$return["parrain"]=$parrain;
			}
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
		$mail=$lien.": \n";
		$this->send_mail(utf8_decode($mail), $this->aInfos['email'], "activation aide pour La Manif Pour Tous", "gdelamardiere@test.com", "gdelamardiere@test.com");
	}

	public function activate($cle_activation){

	}

	public function listChampPersonne(){
		$sql="SELECT COLUMN_NAME
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME='personnes'";

		$stmt = $this->pdo->prepare($sql);
		$stmt->execute() ;
		return $stmt->fetchAll(PDO::FETCH_ASSOC);
	}

	public function send_mail($txt, $to, $subject, $from, $from_addr, $cc = null, $bcc = null, $rel_path = null) {
		$srvr = $this->get_path(false, $rel_path);
		$mime_type = (strpos($txt, '<html>') === false) ? "text/plain" : "text/html";

		$txt = preg_replace(
			array("/\"img\//",
				"/href=\"(?!(http|mailto))/",
				"/url\(/"
					),
			array("\"" . $srvr . "img/",
				"href=\"" . $srvr,
				"url(" . $srvr
					),
			$txt
			);

		$from_hdr = strpos($_SERVER["SERVER_SOFTWARE"], "IIS") ? $from_addr : $this->filter_chars($from) . " <" . $from_addr . ">";
		$headers = "MIME-Version: 1.0\n"
		. "Content-type: " . $mime_type . "; charset: iso-8859-1\n"
		. "Content-Transfer-Encoding: 8bit\n"
		. "From: " . $from_hdr . "\n"
		. "Reply-To: " . $from_addr . "\n"
		. "Return-Path: " . $from_addr . "\n"
		. "X-Mailer: PHP/" . phpversion() . "\n";

		if ($cc)
			$headers .= "Cc: " . $cc . "\n";
		if ($bcc == null && defined("BCC_EMAILS_TO"))
			$bcc = BCC_EMAILS_TO;
		if ($bcc)
			$headers .= "Bcc: " . $bcc . "\n";

		return mail($to, filter_chars($subject), $txt, $headers . "\n", "-f" . $from_addr);
	}

// filter_chars
	public function filter_chars($str) {
		return strtr($str,
			"\xe1\xc1\xe0\xc0\xe2\xc2\xe4\xc4\xe3\xc3\xe5\xc5" .
			"\xaa\xe7\xc7\xe9\xc9\xe8\xc8\xea\xca\xeb\xcb\xed" .
			"\xcd\xec\xcc\xee\xce\xef\xcf\xf1\xd1\xf3\xd3\xf2" .
			"\xd2\xf4\xd4\xf6\xd6\xf5\xd5\x8\xd8\xba\xf0\xfa\xda" .
			"\xf9\xd9\xfb\xdb\xfc\xdc\xfd\xdd\xff\xe6\xc6\xdf\xf8",
			"aAaAaAaAaAaAacCeEeEeEeEiIiIiIiInNoOoOoOoOoOoOoouUuUuUuUyYyaAso"
			);
	}

// get_path
	public function get_path($use_https = false, $rel_path = null) {
		$url = dirname($_SERVER["SCRIPT_NAME"]);
		if ($rel_path){
			$url .= '/' . $rel_path;
		}			
		if ($url == "\\"){ // patch pour PHP:IIS
			$url = "/";
		}
		else if ($url != "/"){
			$url .= "/";
		}			
		return ($use_https ? "https" : "http") . "://" . $_SERVER["SERVER_NAME"] . $url;
	}


}



?>
