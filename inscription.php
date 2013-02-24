<?php
session_start(); 
header('Content-Type: text/html; charset=utf-8');
require_once('conf.php'); 
require_once 'Zend/Loader.php';
Zend_Loader::loadClass('database',"classes");
Zend_Loader::loadClass('personne',"classes");
Zend_Loader::loadClass('lib',"classes");
$personne=new personne();
$actions=$personne->getActions();
$dispo=$personne->getDisponibilites();
$competences=$personne->getCompetences();
$temps=$personne->getTemps();
$equipe=$personne->getEquipe();
$liste_champ=$personne->listChampPersonne();
foreach($liste_champ as $value){
	${$value}="";
	${"erreur_".$value}="";
}
${"erreur_captcha_code"}="";
if(!empty($_POST)){
	include_once ROOT . '/securimage/securimage.php';
	$securimage = new Securimage();
	$aPost=array_map("lib::trim_array",$_POST);
	$verif=$personne->verif_value($aPost);
	$captcha=true;
	if ($securimage->check($_POST['captcha_code']) == false) {
		$captcha=false;
	}
	if($verif===true && $captcha){
		$aValue=$personne->prepare_value($aPost);
		$personne->insert_personne($aValue);
		$personne->send_mail_activation();
		?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html>
	<head>
		<meta http-equiv=Content-Type content="text/html; charset=utf-8" /> 
		<title>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</title>
		<link href='css/form.css' type='text/css' rel='stylesheet'>
	</head>
	<body>
		<div class="form">
			<h1>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</h1>
			<div class="introduction">Bonjour,
				<p>Merci de vous &ecirc;tre inscrit comme b&eacute;n&eacute;vole pour la Manif Pour Tous.</p>
				<p>Prenez bien soin de bien écrire votre adresse email. Si l&#39;envoi du mail d'activation ne fonctionne pas, pensez à la vérifier.</p>
				<p>Pour tous renseignements, vous pouvez envoyer un mail à <a href="mailto:recrutement@lamanifpourtous.fr">recrutement@lamanifpourtous.fr</a></p>
			</div>
		</div>


	</body>
</html>


<?php
exit;
	}
	else{
		foreach($_POST as $key=>$value){
			${$key}=$value;
			${"erreur_".$key}="";
		}
		if(!empty($verif['vide'])){
			foreach($verif['vide'] as $value){
				${"erreur_".$value}="Ce champ est obligatoire";
			}
		}
		if(!empty($verif['nCorrect'])){
			foreach($verif['nCorrect'] as $value){
				${"erreur_".$value}="Attention cette valeur est incorecte";
			}
		}
		if (!$captcha) {
			$erreur_captcha_code="La valeur du captcha n'est pas correcte";
		}
	}
}



?>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html>
<head>
	<meta http-equiv=Content-Type content="text/html; charset=utf-8" /> 
	<title>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</title>
	<link href='css/form.css' type='text/css' rel='stylesheet'>
</head>
<body>
	<div class="form">
		<p>
			<img src="<?php echo SITE_FRONT."entete_manif.png";?>"/>
		</p>
		<h1>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</h1>
		<div class="introduction">Bonjour,
			<p>Merci de vous inscrire pour la Manif Pour Tous du 24 Mars, nous avons besoin de vous.</p>
			<p>Prenez bien soin de bien écrire votre adresse email. Si l&#39;envoi de formulaire ne fonctionne pas, pensez à la vérifier.</p>
			<p>Pour tous renseignements, vous pouvez envoyer un mail à <a href="mailto:recrutement@lamanifpourtous.fr">recrutement@lamanifpourtous.fr</a></p>
		</div>

		<div class="red">* Required</div>
	
		<form action="inscription.php" method="POST" id="form-inscription" target="_self" onsubmit="">
			<h2>Information de base</h2>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="nom">Nom : <span class="red">*</span></label>
					<input type="text" name="nom" value="<?php echo $nom;?>" id="nom" class="required-input">
				</div>
				<p class="erreur" id="erreur_nom" style="display:<?php echo ($erreur_nom=="")?"display:none":"";?>">
					<?php echo $erreur_nom;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="prenom">Prénom : <span class="red">*</span></label>
					<input type="text" name="prenom" value="<?php echo $prenom;?>" id="prenom" class="required-input">
				</div>
				<p class="erreur" id="erreur_prenom" style="display:<?php echo ($erreur_prenom=="")?"display:none":"";?>">
					<?php echo $erreur_prenom;?>
				</p>
			</div>
			<div class="champ">
				<div class="radio">
					<label class="label">Sexe : <span class="red">*</span></label>
					<ul>
						<li>
							<input type="radio" name="sexe" value="Homme" id="sexe_homme" class="required-radio"   <?php if($sexe=='Homme'){echo 'checked="checked"';}?>>
							<label class="label-radio" for="sexe_homme">Homme</label>
						</li>
						<li>
							<input type="radio" name="sexe" value="Femme" id="sexe_femme" class="required-radio"   <?php if($sexe=='Femme'){echo 'checked="checked"';}?>>
							<label class="label-radio" for="sexe_femme">Femme</label>
						</li>
					</ul>
				</div>
				<p class="erreur" id="erreur_sexe" style="display:<?php echo ($erreur_sexe=="")?"display:none":"";?>">
					<?php echo $erreur_sexe;?>
				</p>
			</div>			
			<div class="champ">
				<div class="input">
					<label class="label-input" for="date_naissance">Date de naissance : <span class="red">*</span></label>
					<p class="message">De la forme JJMMAAAA, Exemple : 15021984 pour le 15 Février 1984</p>
					<input type="text" name="date_naissance" value="<?php echo $date_naissance;?>" id="date_naissance" class="required-input">
				</div>
				<p class="erreur" id="erreur_date_naissance" style="display:<?php echo ($erreur_date_naissance=="")?"display:none":"";?>">
					<?php echo $erreur_date_naissance;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="email">Email : <span class="red">*</span></label>
					<input type="text" name="email" value="<?php echo $email;?>" id="email" class="required-input">
				</div>
				<p class="erreur" id="erreur_email" style="display:<?php echo ($erreur_email=="")?"display:none":"";?>">
					<?php echo $erreur_email;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="tel_port">Numéro de téléphone : <span class="red">*</span></label>
					<p class="message">Exemple : 0601020304</p>
					<input type="text" name="tel_port" value="<?php echo $tel_port;?>" id="tel_port" class="required-input">
				</div>
				<p class="erreur" id="erreur_tel_port" style="display:<?php echo ($erreur_tel_port=="")?"display:none":"";?>">
					<?php echo $erreur_tel_port;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="cp">Code Postal : <span class="red">*</span></label>
					<input type="text" name="cp" value="<?php echo $cp;?>" id="cp" class="required-input">
				</div>
				<p class="erreur" id="erreur_cp" style="display:<?php echo ($erreur_cp=="")?"display:none":"";?>">
					<?php echo $erreur_cp;?>
				</p>
			</div>

			<h2>Information de la personne qui vous a contacté</h2>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="nom_parrain">Nom du parrain : <span class="red">*</span></label>
					<input type="text" name="nom_parrain" value="<?php echo $nom_parrain;?>" id="nom_parrain" class="required-input">
				</div>
				<p class="erreur" id="erreur_nom_parrain" style="display:<?php echo ($erreur_nom_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_nom_parrain;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="prenom_parrain">Prénom du parrain : <span class="red">*</span></label>
					<input type="text" name="prenom_parrain" value="<?php echo $prenom_parrain;?>" id="prenom_parrain" class="required-input">
				</div>
				<p class="erreur" id="erreur_prenom_parrain" style="display:<?php echo ($erreur_prenom_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_prenom_parrain;?>
				</p>
			</div>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="email_parrain">Email du parrain : <span class="red">*</span></label>
					<input type="text" name="email_parrain" value="<?php echo $email_parrain;?>" id="email_parrain" class="required-input">
				</div>
				<p class="erreur" id="erreur_email_parrain" style="display:<?php echo ($erreur_email_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_email_parrain;?>
				</p>
			</div>



			<h2>Que voulez-vous faire ?</h2>
			<div class="champ">
				<div class="checkbox">
					<label class="label">Je suis motivé pour : <span class="red">*</span></label>
					<ul>
						<?php foreach($actions as $key=>$value){?>
							<li>
								<input type="checkbox" name="id_action[]" value="<?php echo $key;?>" id="id_action_<?php echo $key;?>" class="required-checbox" <?php if(in_array($key,$id_action)){echo 'checked="checked"';}?>>
								<label class="label-checkbox" for="id_action_<?php echo $key;?>"><?php echo utf8_encode($value);?></label>
							</li>
							<?php }?>
						</ul>
					</div>
					<p class="erreur" id="erreur_id_action" style="display:<?php echo ($erreur_id_action=="")?"display:none":"";?>">
						<?php echo $erreur_id_action;?>
					</p>
				</div>	
				<div class="champ">
					<div class="radio">
						<label class="label">Je voudrais être chef d&#39;équipe : <span class="red">*</span></label>
						<ul>
							<li>
								<input type="radio" name="chef_equipe" value="oui" id="chef_equipe_Oui" class="required-radio"  <?php if($chef_equipe=='oui'){echo 'checked="checked"';}?>>
								<label class="label-radio" for="chef_equipe_Oui">Oui</label>
							</li>
							<li>
								<input type="radio" name="chef_equipe" value="non" id="chef_equipe_Non" class="required-radio"   <?php if($chef_equipe=='non'){echo 'checked="checked"';}?>>
								<label class="label-radio" for="chef_equipe_Non">Non</label>
							</li>
						</ul>
					</div>
					<p class="erreur" id="erreur_chef_equipe" style="display:<?php echo ($erreur_chef_equipe=="")?"display:none":"";?>">
						<?php echo $erreur_chef_equipe;?>
					</p>
				</div>	
				<div class="champ">
					<div class="select">
						<label class="label">Je voudrais être dans les équipes de : <span class="red">*</span></label>
						<select name="id_equipe">
						<?php foreach($equipe as $key=>$value){?>
							<option value="<?php echo $key;?>" <?php if($id_equipe==$key){echo 'selected="selected"';}?>><?php echo utf8_encode($value);?></option>
						<?php }?>
						</select>
						
					</div>
					<p class="erreur" id="erreur_chef_equipe" style="display:<?php echo ($erreur_chef_equipe=="")?"display:none":"";?>">
						<?php echo $erreur_chef_equipe;?>
					</p>
				</div>	
				<div class="champ">
					<div class="checkbox">
						<label class="label">Je suis disponible :</label>
						<p class="message">Pour des actions ponctuelles et du tractage</p>
						<ul>
							<?php foreach($dispo as $key=>$value){?>
								<li>
									<input type="checkbox" name="id_dispo[]" value="<?php echo $key;?>" id="id_dispo_<?php echo $key;?>" class="required-checbox"  <?php if(in_array($key,$id_dispo)){echo 'checked="checked"';}?>>
									<label class="label-checkbox" for="id_dispo_<?php echo $key;?>"><?php echo utf8_encode($value);?></label>
								</li>
								<?php }?>
							</ul>
						</div>
						<p class="erreur" id="erreur_id_dispo" style="display:<?php echo ($erreur_id_dispo=="")?"display:none":"";?>">
							<?php echo $erreur_id_dispo;?>
						</p>
					</div>	
					<div class="champ">
					<div class="radio">
						<label class="label">Je peux consacrer de mon temps :</label>
						<p class="message">Dans le cas ou vous êtes motivé pour effectuer des actions ponctuelles et du tractage.</p>
						<ul>
						<?php foreach($temps as $key=>$value){?>
							<li>
								<input type="radio" name="id_temps" value="<?php echo $key;?>" id="id_temps_<?php echo $key;?>" class="required-checbox"  <?php if($id_temps==$key){echo 'checked="checked"';}?>>
								<label class="label-radio" for="id_temps_<?php echo $key;?>"><?php echo utf8_encode($value);?></label>
							</li>
						<?php }?>
						</ul>
					</div>
					<p class="erreur" id="erreur_id_temps" style="display:<?php echo ($erreur_id_temps=="")?"display:none":"";?>">
						<?php echo $erreur_id_temps;?>
					</p>
				</div>			
					<div class="champ">
						<div class="checkbox">
							<label class="label">J&#39;ai les compétences suivantes :</label>
							<ul>
								<?php foreach($competences as $key=>$value){?>
									<li>
										<input type="checkbox" name="id_competences[]" value="<?php echo $key;?>" id="id_competences_<?php echo $key;?>" class="required-checbox"  <?php if(in_array($key,$id_competences)){echo 'checked="checked"';}?>>
										<label class="label-checkbox" for="id_competences_<?php echo $key;?>"><?php echo utf8_encode($value);?></label>
									</li>
									<?php }?>
								</ul>
							</div>
							<p class="erreur" id="erreur_id_competences" style="display:<?php echo ($erreur_id_competences=="")?"display:none":"";?>">
								<?php echo $erreur_id_competences;?>
							</p>
						</div>	
			<h2>Informations complémentaires</h2>
			<div class="champ">
				<div class="input">
					<label class="label-input" for="email_equipe">Email du parrain :</label>
					<p class="message">Nous faisons notre possible pour regrouper les amis entre eux, 
						mais nous ne sommes pas des magiciens, la garantie à 100% est impossible. 
						Nous comptons sur votre engagement pour la cause.</p>
					<input type="text" name="email_equipe" value="<?php echo $email_equipe;?>" id="email_equipe" class="required-input">
				</div>
				<p class="erreur" id="erreur_email_equipe" style="display:<?php echo ($erreur_email_equipe=="")?"display:none":"";?>">
					<?php echo $erreur_email_equipe;?>
				</p>
			</div>
						<div class="champ">
							<p class="textarea">
								<label class="label-textarea" for="RQ">Remarques :</label>
								<textarea name="RQ" id="RQ" rows="8" cols="80"><?php echo $RQ;?></textarea>
							</p>
						</div>
			<div class="captcha">
				<img id="captcha" src="<?php echo SITE_FRONT;?>securimage/securimage_show.php" alt="CAPTCHA Image" align="left"/>
				<div class="input">
					<label class="label" for="captcha_code">Veuillez rentrer le code captcha ci-contre:</label>
					<input type="text" name="captcha_code" id="captcha_code" class="required-input" size="10" maxlength="6" >

				<a href="#" onclick="document.getElementById('captcha').src = '<?php echo SITE_FRONT;?>securimage/securimage_show.php?' + Math.random(); return false">
					<img src="<?php echo SITE_FRONT;?>securimage/images/refresh.png" height="32" width="32" alt="Reload Image" align="bottom" border="0">
				</a>
				</div>
				<p class="erreur" id="erreur_captcha_code" style="display:<?php echo ($erreur_captcha_code=="")?"display:none":"";?>">
					<?php echo $erreur_captcha_code;?>
				</p>
			</div>
						<input type="submit" name="submit_inscription" value="Valider" id="ss-submit">
					</form>
				</div>
			</body>
			</html>