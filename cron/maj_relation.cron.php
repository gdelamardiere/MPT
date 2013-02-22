<?php
require_once('../conf.php'); 
require_once 'Zend/Loader.php';
Zend_Loader::loadClass('database',ROOT."classes");
Zend_Loader::loadClass('personne',ROOT."classes");
Zend_Loader::loadClass('spreedsheet',ROOT."classes");


$spreedsheet=new spreedsheet();
$spreedsheet->majRelationDbGd();

?>



