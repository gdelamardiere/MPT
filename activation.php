<?php
require_once('conf.php'); 
require_once(ROOT.'classes/database.php');
require_once(ROOT.'classes/personne.php');
require_once(ROOT.'classes/spreedsheet.php');

if(empty($_GET['key'])){
	exit;
}

$personne=new personne();
$image=SITE_FRONT."bannieresit24mars.jpg";
$verif=$personne->activate($_GET['key']);

?>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=utf-8" /> 
	<title>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</title>
	<link href='css/form.css' type='text/css' rel='stylesheet'>
  <link rel="icon" href="http://lamanifpourtous.fr/squelettes/interface/favicon.ico" />
</head>
<body>
	<div class="form">
		<h1>Activation de votre mail</h1>
		<div class="introduction">Bonjour,
			<?php if($verif){?>
			Votre compte a bien été activé, vous serez contacté prochainement par la manif pour tous <br/>
			Encore merci
			<?php } else{?>
			Le lien d'activation n'est pas valide.<br/>
			veuillez nous contacter à <a href="mailto:recrutement@lamanifpourtous.fr">recrutement@lamanifpourtous.fr</a>
			<?php }?>
		</div>
		<div class="image">
			<img src="<?php echo $image;?>"/>
		</div>
	</div>
</body>
</html>



