<?php
require_once('conf.php'); 
require_once 'Zend/Loader.php';
Zend_Loader::loadClass('database',"classes");
Zend_Loader::loadClass('personne',"classes");
Zend_Loader::loadClass('spreedsheet',"classes");

if(empty($_GET['key'])){
	exit;
}

$personne=new personne();
$verif=$personne->activate($_GET['key']);
if($verif===true){
	echo "merci";
}
else{
	echo "erreur";
}


?>



