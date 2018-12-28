<!DOCTYPE html>
<html>
<title>MAC_Allow</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body class="w3-content" style="max-width:1300px">
<!--Fonctions PHP-->


<!--#CHECKBOX Learned_eMAC#-->
    <?php
  function createSelectL($fic){
    $tabFic=file($fic); #Fichier --> Tableau
    $nbLigne=count($tabFic);
    $chaineSelect='<div> <form action="mac.php" method="post">';
    for ($i=0; $i<$nbLigne; $i++){ #Chaque ligne = Option
        $chaineSelect.='<br><input type="checkbox" id="'.$tabFic[$i].'" name="MACL[]" value="'.$tabFic[$i].'"';
        $chaineSelect.='>'.$tabFic[$i].'</label>';
    }
    $chaineSelect.=' <br> <input type="submit" value="Add to selected"> </form> </div>';
    return $chaineSelect;
}
?>
<!--#CHECKBOX BlackList#-->
    <?php
  function createSelectB($fic){
    $tabFic=file($fic); #Fichier --> Tableau
    $nbLigne=count($tabFic);
    $chaineSelect='<div><form action="mac.php" method="post">';
    for ($i=0; $i<$nbLigne; $i++){ #Chaque ligne = Option
        $chaineSelect.='<br><input type="checkbox" id="'.$tabFic[$i].'" name="MACB[]" value="'.$tabFic[$i].'"';
        $chaineSelect.='>'.$tabFic[$i].'</label>';
    }
    $chaineSelect.='<br><input type="submit" value="Add to selected"></form></div>';
    return $chaineSelect;
}
?>
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->
<!------------------------------------------------------------------------------------------------------------------------->


            <!--Barre Superieure-->
                <div class="w3-bar w3-black">
                    <a href="?click=1" class="w3-bar-item w3-button">Add To BlackList</a>
                    <a href="?clock=1" class="w3-bar-item w3-button">Add Blacklisted into Dictionary</a>
                    <a href="http://10.36.0.226/mac.php" class="w3-bar-item w3-button">Refresh</a>
                </div>


                <?php
                if (isset($_GET["click"])) {
		            $test = shell_exec("bash MAC/LearnToBlacklist.sh");
      		      }

                  if (isset($_GET["clock"])) {
                  $test = shell_exec("bash MAC/BlacklistToDictionnary.sh");
                  }
                ?>


            <!--------------------->

    <!-- Carré Learn Et BldackList -->
    <div class="w3-row">
        <div class="w3-half w3-blue w3-container w3-center" style="height:100%">
            <div class="w3-padding-64">
                <div class="w3-padding-64">
		<h1>Learn</h1>
		</div>
                <?php echo createSelectL("MAC/Learned_MAC.site");?>

    <?php
		if(isset($_POST['MACL'])) {
		$fp_L = fopen("Select_L.txt","a");
		ftruncate($fp_L,0);
		fclose($fp_L);
		}
    foreach($_POST['MACL'] as $valeur_L) {
    echo "<b> $valeur_L </b> is selected<br>";
    $fp_L = fopen("Select_L.txt","a");
		fputs($fp_L,"$valeur_L");
		}
    fclose($fp_L);
    ?>


		</div>
            </div>
        <div class="w3-half w3-blue-grey w3-container" style="height:100%">
     <div class="w3-padding-64 w3-center">
  <div class="w3-padding-64">
          <h1>BlackList</h1>

          </div>

                <?php echo createSelectB("MAC/Blacklist_MAC.txt", "test1", "2"); ?>

    <?php
    if(isset($_POST['MACB'])) {
		$fp_B = fopen("Select_B.txt","a");
		ftruncate($fp_B,0);
		fclose($fp_B);
		}
    foreach($_POST['MACB'] as $valeur_B){
    echo "<b> $valeur_B </b> is selected<br>";
    $fp_B = fopen("Select_B.txt","a");
    fputs($fp_B,"$valeur_B");
    }
    fclose($fp_B);
    ?>


            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="w3-container w3-black w3-padding-16">
        <p>Currently <b>
                <?php $contenu_fichier = file_get_contents('MAC/Trusted_MAC.txt'); echo substr_count($contenu_fichier, "\n");?> </b> MAC Address in the Dictionary </p>



    </footer>

</body>

</html>
