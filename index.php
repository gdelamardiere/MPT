<?php
header('HTTP/1.1 301 Moved Permanently');
// Constantes to change according to the environment
include_once "conf.php";
header('Location: '.SITE_FRONT.'inscription.php');
?>