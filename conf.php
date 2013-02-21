<?php
$path = dirname(__FILE__).'\gdata\library';
set_include_path(get_include_path() . PATH_SEPARATOR . $path);
//-------------------------------------------------------------------------------
// compte gmail:
define("USERNAME" , 'gdelamardiere@gmail.com'); // Your google account username
define("PASSWORD" , 'mzlluhgycwrzcare'); // Your google account password

//-------------------------------------------------------------------------------
// Document key - get it from browser addres bar query key for your open spreadsheet

//define("KEY" , '0AmGreq0d2wLTdDQ5UmE4UUJkSW1CRW5OVHlTY3Z2V2c');
define("KEY" , '0Ah2z2NTLfq2bdDJQMmtQTVZXNnBSTXJYR3FfcGg1bFE');

//-------------------------------------------------------------------------------
// base
define("HOSTNAME_BASE", "localhost");
define("DATABASE_BASE", "lmpt");
define("USERNAME_BASE", "root");
define("PASSWORD_BASE", "");

define("SITE_FRONT","localhost/MPT/");

?>