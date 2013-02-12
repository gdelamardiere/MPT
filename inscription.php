<?php
header('Content-Type: text/html; charset=utf-8');
require_once('conf.php'); 
require_once 'Zend/Loader.php';
Zend_Loader::loadClass('database',"classes");
Zend_Loader::loadClass('personne',"classes");
$personne=new personne();
$actions=$personne->getActions();
$dispo=$personne->getDisponibilites();
$competences=$personne->getCompetences();
$liste_champ=$personne->listChampPersonne();
	foreach($liste_champ as $key){
		$value=$key["COLUMN_NAME"];
		${$value}="";
		${"erreur_".$value}="";
	}
if(!empty($_POST)){
	$aPost=array_map("trim",$_POST);
	$verif=$personne->verif_value($aPost);
	if($verif===true){
		$personne->insert_personne($aPost);
		$personne->send_mail_activation();
	}
	else{
		foreach($_POST as $key=>$value){
			${$key}=$value;
			${"erreur_".$key}="";
		}
		foreach($verif['vide'] as $value){
			${"erreur_".$value}="Ce champ est obligatoire";
		}
		foreach($verif['nCorrect'] as $value){
			${"erreur_".$value}="Attention cette valeur est incorecte";
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
		<h1>Incription des b&eacute;n&eacute;voles &agrave; la Manif Pour Tous du 24 Mars 2013</h1>
		<div class="introduction">Bonjour,
			<p>Merci de vous inscrire pour la Manif Pour Tous du 24 Mars, nous avons besoin de vous.</p>
			<p>Prenez bien soin de bien écrire votre adresse email. Si l&#39;envoi de formulaire ne fonctionne pas, pensez à la vérifier.</p>
			<p>Pour tous renseignements, vous pouvez envoyer un mail à <a href="mailto:recrutement@lamanifpourtous.fr">recrutement@lamanifpourtous.fr</a></p>
		</div>

		<div>* Required</div>
	
		<form action="inscription.php" method="POST" id="form-inscription" target="_self" onsubmit="">
			<h2>Information de base</h2>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="nom">Nom :</label>
					<input type="text" name="nom" value="<?php echo $nom;?>" id="nom" class="required-input">
				</p>
				<p class="erreur" id="erreur_nom" style="display:<?php echo ($erreur_nom=="")?"display:none":"";?>">
					<?php echo $erreur_nom;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="prenom">Prénom :</label>
					<input type="text" name="prenom" value="<?php echo $prenom;?>" id="prenom" class="required-input">
				</p>
				<p class="erreur" id="erreur_prenom" style="display:<?php echo ($erreur_prenom=="")?"display:none":"";?>">
					<?php echo $erreur_prenom;?>
				</p>
			</div>
			<div class="champ">
				<div class="radio">
					<label class="label">Sexe :</label>
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
				<p class="input">
					<label class="label-input" for="date_naissance">Année de naissance :</label>
					<input type="text" name="date_naissance" value="<?php echo $date_naissance;?>" id="date_naissance" class="required-input">
				</p>
				<p class="erreur" id="erreur_date_naissance" style="display:<?php echo ($erreur_date_naissance=="")?"display:none":"";?>">
					<?php echo $erreur_date_naissance;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="email">Email :</label>
					<input type="text" name="email" value="<?php echo $email;?>" id="email" class="required-input">
				</p>
				<p class="erreur" id="erreur_email" style="display:<?php echo ($erreur_email=="")?"display:none":"";?>">
					<?php echo $erreur_email;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="tel_port">Numéro de téléphone :</label>
					<input type="text" name="tel_port" value="<?php echo $tel_port;?>" id="tel_port" class="required-input">
				</p>
				<p class="erreur" id="erreur_tel_port" style="display:<?php echo ($erreur_tel_port=="")?"display:none":"";?>">
					<?php echo $erreur_tel_port;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="cp">Code Postal :</label>
					<input type="text" name="cp" value="<?php echo $cp;?>" id="cp" class="required-input">
				</p>
				<p class="erreur" id="erreur_cp" style="display:<?php echo ($erreur_cp=="")?"display:none":"";?>">
					<?php echo $erreur_cp;?>
				</p>
			</div>

			<h2>Information de la personne qui vous a contacté</h2>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="nom_parrain">Nom du parrain :</label>
					<input type="text" name="nom_parrain" value="<?php echo $nom_parrain;?>" id="nom_parrain" class="required-input">
				</p>
				<p class="erreur" id="erreur_nom_parrain" style="display:<?php echo ($erreur_nom_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_nom_parrain;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="prenom_parrain">Prénom du parrain :</label>
					<input type="text" name="prenom_parrain" value="<?php echo $prenom_parrain;?>" id="prenom_parrain" class="required-input">
				</p>
				<p class="erreur" id="erreur_prenom_parrain" style="display:<?php echo ($erreur_prenom_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_prenom_parrain;?>
				</p>
			</div>
			<div class="champ">
				<p class="input">
					<label class="label-input" for="email_parrain">Email du parrain :</label>
					<input type="text" name="email_parrain" value="<?php echo $email_parrain;?>" id="email_parrain" class="required-input">
				</p>
				<p class="erreur" id="erreur_email_parrain" style="display:<?php echo ($erreur_email_parrain=="")?"display:none":"";?>">
					<?php echo $erreur_email_parrain;?>
				</p>
			</div>



			<h2>Que voulez-vous faire ?</h2>
			<div class="champ">
				<div class="checkbox">
					<label class="label">Je suis motivé pour :</label>
					<ul>
						<?php foreach($actions as $array){
							$key=$array['id_action'];
							$value=$array['action'];
							?>
							<li>
								<input type="checkbox" name="id_action" value="<?php echo $key;?>" id="id_action_<?php echo $key;?>" class="required-checbox" <?php if($id_action==$key){echo 'checked="checked"';}?>>
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
					<div class="checkbox">
						<label class="label">Je suis disponible :</label>
						<ul>
							<?php foreach($dispo as $array){
								$key=$array['id_dispo'];
								$value=$array['dispo'];
								?>
								<li>
									<input type="checkbox" name="id_dispo" value="<?php echo $key;?>" id="id_dispo_<?php echo $key;?>" class="required-checbox"  <?php if($id_dispo==$key){echo 'checked="checked"';}?>>
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
							<label class="label">Je voudrais être chef d&#39;équipe :</label>
							<ul>
								<li>
									<input type="radio" name="chef_equipe" value="1" id="chef_equipe_Oui" class="required-radio"  <?php if($chef_equipe=='1'){echo 'checked="checked"';}?>>
									<label class="label-radio" for="chef_equipe_Oui">Oui</label>
								</li>
								<li>
									<input type="radio" name="chef_equipe" value="0" id="chef_equipe_Non" class="required-radio"   <?php if($chef_equipe=='0'){echo 'checked="checked"';}?>>
									<label class="label-radio" for="chef_equipe_Non">Non</label>
								</li>
							</ul>
						</div>
						<p class="erreur" id="erreur_chef_equipe" style="display:<?php echo ($erreur_chef_equipe=="")?"display:none":"";?>">
							<?php echo $erreur_chef_equipe;?>
						</p>
					</div>			
					<div class="champ">
						<div class="checkbox">
							<label class="label">J&#39;ai les compétences suivantes :</label>
							<ul>
								<?php foreach($competences as $array){
									$key=$array['id_competences'];
									$value=$array['competence'];
									?>
									<li>
										<input type="checkbox" name="id_competences" value="<?php echo $key;?>" id="id_competences_<?php echo $key;?>" class="required-checbox"  <?php if($id_competences==$key){echo 'checked="checked"';}?>>
										<label class="label-checkbox" for="id_competences_<?php echo $key;?>"><?php echo utf8_encode($value);?></label>
									</li>
									<?php }?>
								</ul>
							</div>
							<p class="erreur" id="erreur_id_competences" style="display:<?php echo ($erreur_id_competences=="")?"display:none":"";?>">
								<?php echo $erreur_id_competences;?>
							</p>
						</div>	
						<div class="champ">
							<p class="textarea">
								<label class="label-textarea" for="RQ">Remarques :</label>
								<textarea name="RQ" id="RQ" rows="5" cols="50"><?php echo $RQ;?></textarea>
							</p>
						</div>


						<input type="submit" name="submit_inscription" value="Valider" id="ss-submit">
					</form>
				</div>
			</body>
			</html>