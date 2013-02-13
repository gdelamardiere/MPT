<?php
Zend_Loader::loadClass('Zend_Gdata_AuthSub');
Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
Zend_Loader::loadClass('Zend_Gdata_Spreadsheets');
Zend_Loader::loadClass('Zend_Gdata_Docs');
Zend_Loader::loadClass('database','classes');

class spreedsheet {
	private $columns = array();
	private $columnCount=0;
	private $spreadSheetService;


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

		$this->getColumn();
	}

	public function add_personne($aData=null){
		foreach ($this->columns as $col) {
			$testData[$col] = "Dynamically added " . date("Y-m-d H:i:s") . " in column " . $col;
		}
		$ret = $this->spreadSheetService->insertRow($testData, KEY);
	}

	public function getColumn(){
		$query = new Zend_Gdata_Spreadsheets_CellQuery();
		$query->setSpreadsheetKey(KEY);
		$feed = $this->spreadSheetService->getCellFeed($query);
		for ($i = 0; $i < $this->columnCount; $i++) {
			if(isset($feed->entries[$i])){
				$columnName = $feed->entries[$i]->getCell()->getText();
				$this->columns[$i] = strtolower(str_replace(' ', '', $columnName));
			}    
		}
	}





}



?>
