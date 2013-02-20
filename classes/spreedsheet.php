<?php
Zend_Loader::loadClass('Zend_Gdata_AuthSub');
Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
Zend_Loader::loadClass('Zend_Gdata_Spreadsheets');
Zend_Loader::loadClass('Zend_Gdata_Docs');
Zend_Loader::loadClass('database','classes');

class spreedsheet {
	private $columns = array(
		'jepeuxêtrechefdequipe',
		'col2',
		'col3',
		'haha',
		);
	private $columnCount=0;
	private $spreadSheetService;
	private $rel_bdd_google=array(
	"nom"=>array("colonne"=>"0",),
	"prenom"=>array("colonne"=>'1',),
	"tel_port" =>array("colonne"=>'2',),
	 "email" =>array("colonne"=>'3',),
	 /*"cp" =>array("colonne"=>4,),
	 "date_naissance" =>array("colonne"=>5,),
	 "sexe" =>array("colonne"=>6,),
	 "chef_equipe"=>array("colonne"=>7,),
	"date_activation"=>array("colonne"=>8,),
	"id_statut"=>array("colonne"=>9,),
	"nom_parrain"=>array("colonne"=>10,),
	"prenom_parrain"=>array("colonne"=>11,),
	"tel_parrain"=>array("colonne"=>12,),
	"email_parrain"=>array("colonne"=>13,),



	 "id_action"=>array("colonne"=>7,),
	 "id_dispo"=>array("colonne"=>7,),
	 "id_competences"=>array("colonne"=>7,),
	 
	 "RQ"=>array("colonne"=>7,),
	 "id_parrain"=>array("colonne"=>7,),
	 
	
	 
	 "date_form"=>array("colonne"=>7,),*/
	 
	);




	public function __construct(){
		$service = Zend_Gdata_Spreadsheets::AUTH_SERVICE_NAME;
		$client = Zend_Gdata_ClientLogin::getHttpClient(USERNAME, PASSWORD, $service);
		$this->spreadSheetService = new Zend_Gdata_Spreadsheets($client);
		/*$query = new Zend_Gdata_Spreadsheets_DocumentQuery();
		$query->setSpreadsheetKey(KEY);
		$feed = $this->spreadSheetService->getWorksheetFeed($query);
		$entries = $feed->entries[0]->getContentsAsRows();
		$this->columnCount=(isset($entries[0]))?sizeof($entries[0]):0;//verifier si nécéssaire*/
		$this->columnCount=4;

		//$this->getColumn();
	}

	public function add_personne($aData=null){
		/*var_dump($this->columns);
		$this->getColumn();
		var_dump($this->columns);*/
		$aDataSend=array();
		foreach ($aData as $key=>$value) {
			if(array_key_exists($key, $this->rel_bdd_google)){
				$aDataSend[$this->columns[$this->rel_bdd_google[$key]["colonne"]]]=utf8_encode($value);
			}
		}
		var_dump($aDataSend);
		$this->spreadSheetService->insertRow($aDataSend, KEY);
	}

	/*public function add_personne($aData=null){
		foreach ($this->columns as $col) {
			$testData[$col] = "Dynamically added " . date("Y-m-d H:i:s") . " in column " . $col;
		}
		var_dump($testData);
		$ret = $this->spreadSheetService->insertRow($testData, KEY);
	}*/

	public function getColumn(){
		$this->columns=array();
		$query = new Zend_Gdata_Spreadsheets_CellQuery();
		$query->setSpreadsheetKey(KEY);
		$feed = $this->spreadSheetService->getCellFeed($query);
		for ($i = 0; $i < $this->columnCount; $i++) {
			if(isset($feed->entries[$i])){
				$columnName = $feed->entries[$i]->getCell()->getText();
				$this->columns[$i] = $this->filtreName($columnName);
			}    
		}
	}


	public function filtreName($columnName){
		return str_replace("'","",strtolower(str_replace(' ', '', $columnName)));//rajouter :
	}





}



?>
