<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link REL="SHORTCUT ICON" HREF="http://tanto.bioe.uic.edu/prelyscar/prelyscar.ico">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>PreLysCar - Predictor of Lysine Carboxylation</title>
<style type="text/css">
<!--
.style37 {font-size: 12px; color: #000066;}
.style38 {font-size: 12px; color: #CCCCCC;}
body,td,th {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
}
.style39 {
	font-size: 36px;
	font-weight: bold;
}
.style40 {
	font-size: 12px;
	font-style: italic;
}
.style41 {font-size: 12px; color: #FF0000; }
.style42 {font-size: 12px; color: #0099CC; }
.style43 {font-size: 14px; color: #FF0000; font-weight: bold;}
.style46 {font-size: 9px}
.style60 {
	font-size: 16px;
	font-weight: bold;
	color: #003366;
}
-->
</style>

<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-26635029-2']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

</head>
<?php
flush();
ob_implicit_flush(1);
@ob_end_flush(); // set an end to the php-output-buffer!
?>

<body>


<?php
if (!isset($_SERVER['HTTP_REFERER']))
{
   echo "<meta http-equiv='refresh' content='0;url=http://tanto.bioe.uic.edu/prelyscar/'>";
   exit;
   
}
else
{
	ob_implicit_flush(1);
	@ob_end_flush(); // set an end to the php-output-buffer!
	#flush();
}
?>

<table width="600" border="0" align="center" cellpadding="0" cellspacing="5">
  <tr>
    <td>
	<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="30%"><a href="http://www.uic.edu/uic/" target="_blank" class="style38 style41">University of Illinos at Chicago </a></td>
        <td width="41%"><div align="center"><a href="http://gila.bioe.uic.edu/lab/" target="_blank" class="style37">Jie Liang Lab</a></div></td>
        <td width="30%"><div align="right"><a href="http://www.bioe.uic.edu/BIOE/WebHome" target="_blank" class="style42">Department of Bioengineering</a></div></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <th width="52%" scope="row"><div align="left"><span class="style39">PreLysCar<br />
          <span class="style40"><strong>Pre</strong>dictor of <strong>Lys</strong>ine <strong>Car</strong>boxylation</span></span></div></th>
        <td width="48%"><img src="images/rubisco200.jpg" width="200" height="200" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="75%" border="2" align="center" cellpadding="10" cellspacing="10" bordercolor="#FF6600" bgcolor="#FFFFFF">
      <tr>
        
		<td width="100%">
			<span class="style60">OUTPUT DATA</span><br/><br>


<?php

ob_implicit_flush(1);
@ob_end_flush(); // set an end to the php-output-buffer!
#********************************#********************************
# runprelyscar.php
# Take PDB file and PRIOR probability from the user
# Check the format of the PDB file (checkpdb.pl)
# Get LYS vectors 
# Run PreLysCar

# A error function
function errorfinish()
{
	echo"<br/><p align='center'><a href='index.html' target='parent'> Please, try again</a></p>
	</td>
    </tr>
	</table></td></tr>
	
	<tr><td></td></tr>
  <tr>
    <td>
	<blockquote>
      <div align='center'><span class='style46'>PreLysCar, website, and interface developed by <a href='http://gila.bioe.uic.edu/~davidjm/' target='_blank'>David Jimenez-Morales</a></span> <br />
      <strong>Jimenez-Morales D, et.al. (2014). Acta Cryst. D 70, 48-57.</strong><br />
      <span class='style46'><a href='mailto:prelyscar@gmail.com?Subject=Comments about PreLysCar' target='_top'>Contact PreLysCar</a></span><br/>
      </div>
    </blockquote></td></tr>
</table>

</body>
</html>";

}

flush();

#********************************
# Variables coming from index
# uppdb
# prior
$prior = $_POST['prior'];

# Handeling errors
ini_set('log_errors','0');
ini_set('display_errors','1');
#error_reporting(2047); # Show all when developing
error_reporting(0);

# Variables
$pdbid = "";
$result = "";
$uploaddirectory = "";
$uploadfile = "";
$filesize = "";


$dir = "userfiles";
	
if ($_FILES["uppdb"]["error"] > 0) 
{

	echo "<p align='center'><span class='style51'><b>ERROR:</b> File not provided (only PDB format)</span><br/><br/></p>";
	errorfinish();
	exit();

}
elseif (strpos($_FILES["uppdb"]["name"], ".pdb") == 0) 
	{
		echo "<p align='center'><span class='style51'><b>ERROR:</b> The extension of the file is not '.pdb'<br/>(Example: whateveryouwant.pdb)</span><br/><br/>";
		errorfinish();
		exit();
	}
else 
{
		#new code
		//-----------------------------------------
		//  Upload file
		$filename = $_FILES['uppdb']['name'];
		$pdbid = $filename;
		
		// Move the file
		$uploaddirectory = $dir;	
		$uploadfile = $uploaddirectory ."/". basename($_FILES['uppdb']['name']);
		
		if (move_uploaded_file($_FILES['uppdb']['tmp_name'], $uploadfile)) 
		{

			#echo "<b>Processing the submitted file</b><br/>";
			#echo "*************************************************<br/>";
			
			echo "- File name: ".$filename."<br/> ";
			
			
			$filesize = round (filesize($uploadfile)/1024);
			
			echo "- File size: ".$filesize." Kb <br/><br/>";
			flush();
		
		} 
		else 
		{
			echo "ERROR: Cannot upload this file! <br />Only PDB format accepted<br/>";
			errorfinish();
			exit();
		}
		
}


# RUNNING PRELYSCAR
#----------------------------------------------------------------
chdir("userfiles"); # Go there and store the files from users

echo "<strong> Processing the submitted file </strong><br/>";
echo "*************************************************<br/>";
echo "<small><i>Note: Each task should take just a few seconds, depending on the number of total amino acids and number of lysine residues.</i></small><br/><br/>";

# Buffer out!
ob_implicit_flush(1);
@ob_end_flush(); // set an end to the php-output-buffer!

$cmd = "../PreLysCarScripts/driverprelyscar.pl $pdbid $prior";	#first part of program
$result = system($cmd);				#store output as result

#echo $result;


?>
		<br/><p align='center'><small><a href='index.html' target='parent'> Back to main page</a></small></p>	    </td>
        </tr>
		
    </table></td>
  </tr>
  <tr>
    <td>	</td>
  </tr>
  <tr>
    <td><blockquote>
      <div align='center'><span class='style46'>PreLysCar, website, and interface developed by <a href='http://gila.bioe.uic.edu/~davidjm/' target='_blank'>David Jimenez-Morales</a></span> <br />
        <strong><a href="http://journals.iucr.org/d/issues/2014/01/00/lv5045/index.html" target="_blank" class="style42">Jimenez-Morales D, et.al. (2014). Acta Cryst. D 70, 48-57</a></strong><br />
      <span class='style46'><a href='mailto:prelyscar@gmail.com?Subject=Comments about PreLysCar' target='_top'>Contact PreLysCar</a></span><br/>
      </div>
    </blockquote></td></tr>
</table>



</body>
</html>
