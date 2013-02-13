<?php
require_once('conf.php'); 
// ini_set('display_errors', 1); 
//  error_reporting(E_ALL);


// /**
//  * @see Zend_Loader
//  */
// require_once 'Zend/Loader.php';

// /**
//  * @see Zend_Gdata
//  */
// Zend_Loader::loadClass('Zend_Gdata');

// /**
//  * @see Zend_Gdata_ClientLogin
//  */
// Zend_Loader::loadClass('Zend_Gdata_ClientLogin');

// /**
//  * @see Zend_Gdata_Spreadsheets
//  */
// Zend_Loader::loadClass('Zend_Gdata_Spreadsheets');

// /**
//  * @see Zend_Gdata_App_AuthException
//  */
// Zend_Loader::loadClass('Zend_Gdata_App_AuthException');

// /**
//  * @see Zend_Http_Client
//  */
// Zend_Loader::loadClass('Zend_Http_Client');


// require_once('Zend/Gdata/Spreadsheets.php');
// $email="gdelamardiere@gmail.com";
// $pass="Dam5ep7$";
// try {
//     $client = Zend_Gdata_ClientLogin::getHttpClient($email, $pass,
//      Zend_Gdata_Spreadsheets::AUTH_SERVICE_NAME);
// } catch (Zend_Gdata_App_AuthException $ae) {
//   exit("Error: ". $ae->getMessage() ."\nCredentials provided were email: [$email] and password [$password].\n");
// }
// // $test=new Zend_Gdata_Spreadsheets($client);
// // var_dump("ok");
// // $url = "http://spreadsheets.google.com/feeds/list/0AmGreq0d2wLTdDQ5UmE4UUJkSW1CRW5OVHlTY3Z2V2c/od6/public/values?sq=current=true";
// // // $test->getSpreadsheetListFeedContents("https://docs.google.com/spreadsheet/ccc?key=0AmGreq0d2wLTdDQ5UmE4UUJkSW1CRW5OVHlTY3Z2V2c");
// // $test->getSpreadsheetListFeedContents($url);
// // // var_dump($test);
// // 

// $spreadsheetService = new Zend_Gdata_Spreadsheets($client);
// $feed = $spreadsheetService->getSpreadsheetFeed();

// // print_r ($feed);
// $i = 0;
//         foreach($feed->entries as $entry) {
//             // if ($entry instanceof Zend_Gdata_Spreadsheets_CellEntry) {
//             //     print "00000".$entry->title->text .' '. $entry->content->text . "<br>";
//             // } else if ($entry instanceof Zend_Gdata_Spreadsheets_ListEntry) {
//             //     print "11111".$i .' '. $entry->title->text .' | '. $entry->content->text . "<br>";
//             // } else {
//             //     print "22222".$i .' '. $entry->title->text . "<br>";
//             // }

//             if($entry->title->text=="test_guerric"){
//                 $goole_doc=$entry;
//             }

//             $i++;
//         }

//         $rowData = $goole_doc->getWorksheets ();
//         var_dump($rowData);
// // foreach($rowData as $customEntry) {
// //   echo $customEntry->getColumnName() . " = " . $customEntry->getText();
// // }
// 
// 
// 






require_once 'Zend/Loader.php';
Zend_Loader::loadClass('Zend_Gdata_AuthSub');
Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
Zend_Loader::loadClass('Zend_Gdata_Spreadsheets');
Zend_Loader::loadClass('Zend_Gdata_Docs');
Zend_Loader::loadClass('database','classes');
echo "<pre>";


//---------------------------------------------------------------------------------
// Init Zend Gdata service

$service = Zend_Gdata_Spreadsheets::AUTH_SERVICE_NAME;
$client = Zend_Gdata_ClientLogin::getHttpClient(USERNAME, PASSWORD, $service);
$spreadSheetService = new Zend_Gdata_Spreadsheets($client);

//--------------------------------------------------------------------------------
// Example 1: Get cell data

$query = new Zend_Gdata_Spreadsheets_DocumentQuery();
$query->setSpreadsheetKey(KEY);
$feed = $spreadSheetService->getWorksheetFeed($query);
$entries = $feed->entries[0]->getContentsAsRows();
echo "<hr><h3>Example 1: Get cell data</h3>";
echo var_export($entries, true);

$columnCount=(isset($entries[0]))?sizeof($entries[0]):0;

//----------------------------------------------------------------------------------
// Example 2: Get column information

$query = new Zend_Gdata_Spreadsheets_CellQuery();
$query->setSpreadsheetKey(KEY);
$feed = $spreadSheetService->getCellFeed($query);

//$columnCount = $feed->getColumnCount()->getText();
//$columnCount = 18;
$columns = array();
echo $columnCount;
for ($i = 0; $i < $columnCount; $i++) {
    if(isset($feed->entries[$i])){
        $columnName = $feed->entries[$i]->getCell()->getText();
    $columns[$i] = strtolower(str_replace(' ', '', $columnName));
    }    
}
echo "<hr><h3>Example 2: Get column information</h3>";
echo "Nr of columns: $columnCount";
echo "<br>Columns: ";
echo var_export($columns, true);

//-------------------------------------------------------------------------------------------------
// // Example 3: Add cell data

// $testData = array();
// foreach ($columns as $col) {
//     $testData[$col] = "Dynamically added " . date("Y-m-d H:i:s") . " in column " . $col;
// }
// $ret = $spreadSheetService->insertRow($testData, KEY);
// // echo var_export($ret, true);



?>



