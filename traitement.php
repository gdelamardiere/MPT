<?php
$path = 'J:\EasyPHP-5.3.8.1\www\MPT\gdata\library';
set_include_path(get_include_path() . PATH_SEPARATOR . $path);

require_once 'Zend/Loader.php';
Zend_Loader::loadClass('database',"classes");
Zend_Loader::loadClass('personne',"classes");
var_dump($_POST);
if(empty($_POST)){
	exit;
}

$aPost=array_map($_POST,"trim");
$personne=new personne();
$verif=$personne->verif_value($aPost);
if($verif===true){
	$personne->insert_personne($aPost);
	$personne->send_mail_activation();
}
else{
	var_dump($verif);
}


?>



