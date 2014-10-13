#!/usr/bin/perl -w

use POSIX;
use strict;
use warnings;

# David Jimenez Morales
# @ davidjm scripts
# Release date: 12/22/2013

# ------Description ---------------------------------------#
# Adpated for PreLysCar from 
# euclideandistancesprelyscar.pl
#
# FINAL VERSION. This script will take only the side chain 
# of the amino acids 
# (either lysine or KCX, but it can be any other amino acid), 
# and it will measure the euclidean distances within a radious 
# of the given distance.
#
# ---------------------------------------------------------#

my $command = "eudisprelyscar.pl";
if (@ARGV != 1)
{
	print "<br/>FATAL ERROR !!!!!!!!!!!!!!!<br/>\n";
	print "$command requires 1 argument (PDB file)<br/>\n";
	print "Please, contact developer at prelyscar\@gmail.com <br/>\n";
	exit;
}

#INPUT 1

my $filename = $ARGV[0];
my $PDB = '';
if ( ($filename =~ /^(\w{4}).pdb$/) || ($filename =~ /^(\w{4}.chain\w).pdb$/) || ($filename =~ /^(\w{4}.sub\w).pdb$/) )
{
	$PDB = $1;
}
else
{
	print "<br/>FATAL ERROR !!!!!!!!!!!!!!! <br/>\n";
	print "Error:$command<br/>\n";
	print "Please, contact developer at prelyscar\@gmail.com <br/>\n";
	exit;
}

my $pdb = $PDB;
my $aatofind = "LYS";
my $distance = 5;

# INCREASE DISTANCE?
my $extradistance = $distance;

#~~Info zone~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GETTING INFO ABOUT THE INPUT PDB
my @opdb = get_file_data($filename);

my %pdbnumres = ();
# Control
my $initialchain = ''; #Just to make sure we only have one chain;
my $c = 0;

foreach my $pdbline (@opdb)
{
	chomp($pdbline);
	# GETTING THE PROTEIN SEQUENCE
	if ($pdbline =~ /^ATOM/)
	{
		$c++;
		my $chain = substr($pdbline,21,1);
		if ($c == 1)
		{
			$initialchain = $chain;
			next;
		}
		
		if($chain ne $initialchain)
		{
			print "<br/>FATAL ERROR !!!!!!!!!!!!!!! <br/>\n";
			print "Error:$command<br/>\n";
			print "Please, contact developer at prelyscar\@gmail.com <br/>\n";
			exit;
		}
		
		my $resnum = substr ($pdbline,22,4);
		$resnum =~ s/\s//g;
		
		my $aa3 = substr($pdbline,17,3);
		
		if(!$pdbnumres{$resnum})
		{
			$pdbnumres{$resnum} = $aa3
		}
	} #if it's an ATOM
	
}#foreach


# PROTEIN LENGTH:
my $protlen = keys %pdbnumres;
my $protlencode = 0;

if ($protlen >= 200)
{
	$protlencode = 2;
#	print "Protein Length: ".$protlen." (more than 200)\n\n";
}
elsif ($protlen < 199)
{
	$protlencode = 1;
#	print "Protein Length: ".$protlen." (less than 200)\n\n";
}
else
{
	print "<br/>FATAL ERROR !!!!!!!!!!!!!!! <br/>\n";
	print "Error:$command<br/>\n";
	print "Please, contact developer at prelyscar\@gmail.com <br/>\n";
	exit;
}


# LOADPDB COORDINATES FOR THE SELECTED AA + ALL THE OTHER
my ($aacoor, $allothercoor) = get_pdbsidechain_coordinateskcxcase($filename,$aatofind);
my %aacoordinates = %$aacoor;
my %alltheothercoordinates = %$allothercoor;


my $naa = keys %aacoordinates;
my $not = keys %alltheothercoordinates;

if ( ($naa == 0) | ($not == 0) )
{
	print "<br>There is no $aatofind in this subunit ($pdb)<br/>\n";
	print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$pdb)' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
	exit;
}

# GETTING THE ATOMIC COORDINATES OF IONS AND WATER
my ($ionhetatmcoor, $watercoor) = Get_PDBHETATM_Coordinates_Ion_Water($filename);
my %ionhetatmcoor = %$ionhetatmcoor;
my %watercoordinates = %$watercoor;

#print "Total: $naa $aatofind and $not other amino acids in the $pdb protein\n";
my %listofaasandnames = ();

# $listofaasandnames{AANUMBER} = AANAME;
my %listofnearaminoacidstothechoseone = ();
# $listofnearaminoacidstothechoseone{CHOSEN AA NUMBER}{UNIQUE AA CLOSE BY} = BFACTOR;
my %averageeuclideans = ();
# $averageeuclideans{AANUMBER} = AVEEUCLIDEAN

for my $thechosenaa (sort {$a<=>$b} keys %aacoordinates)
{
#	print "Close by $aatofind:".$thechosenaa."--->\n";
	my $euclideanaverage = 0;
	my $eutotal = 0;
	for my $atomoftheone (keys %{$aacoordinates{$thechosenaa}})
	{
		#@tmp = ($resnum,$aa3,$x,$y,$z,$bfactor,$atomname);
		my $aasN = $aacoordinates{$thechosenaa}{$atomoftheone}[0];
		my $aa3 = $aacoordinates{$thechosenaa}{$atomoftheone}[1];
		my $kx = $aacoordinates{$thechosenaa}{$atomoftheone}[2];
		my $ky = $aacoordinates{$thechosenaa}{$atomoftheone}[3];
		my $kz = $aacoordinates{$thechosenaa}{$atomoftheone}[4];
		my $atomname = $aacoordinates{$thechosenaa}{$atomoftheone}[6];
		
		#FIRST GO AROUND ALL THE OTHER RESIDUES IN THE PROTEIN
		for my $theotheraanumber (sort {$a<=>$b} keys %alltheothercoordinates)
		{
			for my $theotheratom (keys %{$alltheothercoordinates{$theotheraanumber}})
			{
				my $oaan = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[0];
				my $oaa3 = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[1];
				my $ox = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[2];
				my $oy = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[3];
				my $oz = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[4];
				my $bfactor = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[5];
				my $otheratom = $alltheothercoordinates{$theotheraanumber}{$theotheratom}[6];
				my $eudistance = EuclideanDistance($kx,$ky,$kz,$ox,$oy,$oz);
				if ($atomname eq "PCX")
				{
					if ($eudistance <= $extradistance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{			
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
							if (!$listofaasandnames{$oaan})
							{
#								print "Atom $atomname: ".$theotheratom." ";
								$listofaasandnames{$oaan} = $oaa3;
#								print "the closest amino acids are $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							$euclideanaverage += $eudistance;
							$eutotal++;
							last;	
						}
					}

				}
				else
				{
					if ($eudistance <= $distance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
#							print "\tAnd the closest amino acids are $oaa3 ($oaan) $ox, $oy, $oz, and with a befactor $bfactor\n";
							if (!$listofaasandnames{$oaan})
							{
								$listofaasandnames{$oaan} = $oaa3;
#								print "Atom $atomname ".$theotheratom." ";
#								print "close to $extradistance the closest amino acids are $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							$euclideanaverage += $eudistance;
							$eutotal++;
							last;	
						}
					}
				}

			}
		}#END OF CHECKING AROUND "ALL" THE OTHER RESIDUES
		
		#TIME TO CHECK AROUND YOUR OWN RESIDUES
		for my $thechosenaa2 (sort {$a<=>$b} keys %aacoordinates)
		{
			if ($thechosenaa2 == $thechosenaa)
			{
				# We don't want to compare the same Chosen Amino Acid
				next;
			}
			else
			{
#				print "$aatofind:".$thechosenaa2."\n";
				for my $atomoftheone2 (keys %{$aacoordinates{$thechosenaa2}})
				{
					my $aasN2 = $aacoordinates{$thechosenaa2}{$atomoftheone2}[0];
					my $aa32 = $aacoordinates{$thechosenaa2}{$atomoftheone2}[1];
					my $kx2 = $aacoordinates{$thechosenaa2}{$atomoftheone2}[2];
					my $ky2 = $aacoordinates{$thechosenaa2}{$atomoftheone2}[3];
					my $kz2 = $aacoordinates{$thechosenaa2}{$atomoftheone2}[4];
					my $bfactor = $aacoordinates{$thechosenaa2}{$atomoftheone2}[5];
					my $otheratom = $aacoordinates{$thechosenaa2}{$atomoftheone2}[6];
					
					my $eudistance = EuclideanDistance($kx,$ky,$kz,$kx2,$ky2,$kz2);
					
					
						if ($atomname eq "NZ")
						{
							if ($eudistance <= $extradistance)
							{
								if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$thechosenaa2})
								{			
									$listofnearaminoacidstothechoseone{$thechosenaa}{$thechosenaa2} = $bfactor;
									if (!$listofaasandnames{$aasN2})
									{
										$listofaasandnames{$aasN2} = $aa32;
#										print "\tTHANKS TO $extradistance the closest amino acids are $aa32 ($aasN2) $kx2, $ky2, $kz2, and with a bfactor $bfactor\n";
									}
									$euclideanaverage += $eudistance;
									$eutotal++;
									last;	
								}
							}
		
						}
						else
						{
							if ($eudistance <= $distance)
							{
								if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$thechosenaa2})
								{
									$listofnearaminoacidstothechoseone{$thechosenaa}{$thechosenaa2} = $bfactor;
		#							print "\tAnd the closest amino acids are $oaa3 ($oaan) $ox, $oy, $oz, and with a befactor $bfactor\n";
									if (!$listofaasandnames{$aasN2})
									{
										$listofaasandnames{$aasN2} = $aa32;
		#								print "\tTHANKS TO $extradistance the closest amino acids are $oaa3 ($oaan) $ox, $oy, $oz, and with a befactor $bfactor\n";
									}
									$euclideanaverage += $eudistance;
									$eutotal++;
									last;	
								}
							}					
						}
				
				
				} # for my $atomoftheone2 (keys %{$aacoordinates{$thechosenaa2}})
			}
#			print ",";
		} # END OF CHECKING AROUND SIMILAR RESIDUES
		
		
		
		#-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		# CHECKING WATER MOLECULES AROUND:
		for my $theotheraanumber (sort {$a<=>$b} keys %watercoordinates)
		{
			for my $theotheratom (keys %{$watercoordinates{$theotheraanumber}})
			{
				my $oaan = $watercoordinates{$theotheraanumber}{$theotheratom}[0];
				my $oaa3 = $watercoordinates{$theotheraanumber}{$theotheratom}[1];
				my $ox = $watercoordinates{$theotheraanumber}{$theotheratom}[2];
				my $oy = $watercoordinates{$theotheraanumber}{$theotheratom}[3];
				my $oz = $watercoordinates{$theotheraanumber}{$theotheratom}[4];
				my $bfactor = $watercoordinates{$theotheraanumber}{$theotheratom}[5];
				my $otheratom = $watercoordinates{$theotheraanumber}{$theotheratom}[6];
				my $eudistance = EuclideanDistance($kx,$ky,$kz,$ox,$oy,$oz);
				if ($atomname eq "PCX")
				{
					if ($eudistance <= $extradistance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{			
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
							if (!$listofaasandnames{$oaan})
							{
#								print "Atom $atomname: ".$theotheratom." ";
								$listofaasandnames{$oaan} = $oaa3;
#								print "the closest water molecules are $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							last;	
						}
					}

				}
				else
				{
					if ($eudistance <= $distance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
#							print "\tAnd the closest amino acids are $oaa3 ($oaan) $ox, $oy, $oz, and with a befactor $bfactor\n";
							if (!$listofaasandnames{$oaan})
							{
								$listofaasandnames{$oaan} = $oaa3;
#								print "Atom $atomname ".$theotheratom." ";
#								print "close to $extradistance the closest amino acids are $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							last;	
						}
					}
				}

			}
		}#END OF CHECKING AROUND "ALL" THE WATER MOLECULES!!
		#-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		
		
		#-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		# CHECKING AROUND IONS:
		for my $theotheraanumber (sort {$a<=>$b} keys %ionhetatmcoor)
		{
			for my $theotheratom (keys %{$ionhetatmcoor{$theotheraanumber}})
			{
				my $oaan = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[0];
				my $oaa3 = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[1];
				my $ox = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[2];
				my $oy = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[3];
				my $oz = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[4];
				my $bfactor = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[5];
				my $otheratom = $ionhetatmcoor{$theotheraanumber}{$theotheratom}[6];
				my $eudistance = EuclideanDistance($kx,$ky,$kz,$ox,$oy,$oz);
				if ($atomname eq "PCX")
				{
					if ($eudistance <= $extradistance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{			
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
							if (!$listofaasandnames{$oaan})
							{
#								print "Atom $atomname: ".$theotheratom." ";
								$listofaasandnames{$oaan} = $oaa3;
#								print "the closest ION is $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							last;	
						}
					}

				}
				else
				{
					if ($eudistance <= $distance)
					{
						if (!$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber})
						{
							$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber} = $bfactor;
#							print "\tAnd the closest amino acids are $oaa3 ($oaan) $ox, $oy, $oz, and with a befactor $bfactor\n";
							if (!$listofaasandnames{$oaan})
							{
								$listofaasandnames{$oaan} = $oaa3;
#								print "Atom $atomname ".$theotheratom." ";
#								print "close to $extradistance the closest amino acids are $oaa3 ($oaan) $kx $ky $kz --> $ox, $oy, $oz, and with a befactor $bfactor\n";
							}
							last;	
						}
					}
				}

			}
		}#END OF CHECKING AROUND "ALL" THE IONSSSSS!!
		#-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
			
		
#		print "\n";
	}#for my $atomoftheone (keys %{$aacoordinates{$thechosenaa}})

	if ( ($euclideanaverage>0) & ($eutotal>0) )
	{
		my $euavevalue = ($euclideanaverage/$eutotal);
		$averageeuclideans{$thechosenaa} = $euavevalue;
	}
#	else
#	{
#		print "\t-Forget about $aatofind $thechosenaa euclidean distance. Nobody seems to be close by it.\n";
#	}
}

#  p r e l y s c a r oooooooooooooooooooooooooooooooout
# OUTPUT FILE: Pymol script
my $outpymol = $pdb.".euclidean".$distance."-prelyscar-".$aatofind.".pml";
open(PYMOL,">".$outpymol);
#
## OUTPUT FILE: AMINO ACID VECTOR
my $outeuclideanoutvector = $pdb.".euclidean".$distance."-prelyscar-".$aatofind.".csv";
open (VECTOR,">".$outeuclideanoutvector);
#  p r e l y s c a r oooooooooooooooooooooooooooooooout

# VECTOR LABELS:
# AAS AA# PDB NAA ASP GLU NEG LYS ARG HIS POS PyH NON CHA ST NQ POL OTH ARO HYD k EC1 RES
#print VECTOR $aatofind." AA# PDB NAA ASP GLU NEG LYS ARG HIS POS PyH NON CHA ST NQ POL OTH ARO HYD k EC1 RES BFA\n";


##General stuff
print PYMOL "bg_color white\n";
print PYMOL "hide all\n";
print PYMOL "show cartoon, all\n";
print PYMOL "set cartoon_transparency, 0.7\n";
print PYMOL "color gray85, all\n";
print PYMOL "select heteroatoms, (hetatm and not resn HOH)\n";
print PYMOL "show sticks, heteroatoms\n";
print PYMOL "color magenta, heteroatoms\n";

for my $thechosenaa (sort {$a<=>$b} keys %listofnearaminoacidstothechoseone)
{
#	print "Seq around $aatofind ".$thechosenaa." ";
	##PRINTING OUT RESIDUES AROUND THE MODLYS
	print PYMOL "select $aatofind$thechosenaa, resi $thechosenaa\n";
	print PYMOL "select around$aatofind$thechosenaa, resi ";
	my $number = keys %{$listofnearaminoacidstothechoseone{$thechosenaa}};
#	print "(we have $number):\n";
	my $sumbfactor = 0;
	my $sequencearound = '';
	for my $theotheraanumber (sort {$a<=>$b} keys %{$listofnearaminoacidstothechoseone{$thechosenaa}})
	{
		print PYMOL $theotheraanumber."+";
		my $aa3 = $listofaasandnames{$theotheraanumber};
		my $aa1 = iubjust3to1($aa3);
		if ($aa1)
		{
			$sequencearound .= $aa1;
		}
#		print $theotheraanumber."($aa3 - $aa1) ".$listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber}." $sequencearound\n";
		$sumbfactor += $listofnearaminoacidstothechoseone{$thechosenaa}{$theotheraanumber};
	}
	
	my($averagebfactor) =  sprintf("%.4f",($sumbfactor/$number));
#	print "average b-factor ".$averagebfactor."\n";
	my ($R,$D,$E,$H,$K,$pNoncharged,$pCharged,$ST,$NQ,$pPolar,$pOthers,$pAromatics,$pHydrophobics, $pk,$i,$o) = AminoAcidFrequenciesBayesian($sequencearound);
	my $positives = $R+$K;
	my $posandhis = $R+$K+$H;
	my $negatives = $D+$E;
	
	my $seqNOwaterandions = $sequencearound;
	$seqNOwaterandions =~ s/o//g;
	$seqNOwaterandions =~ s/i//g;
	my $seqlen = length($sequencearound);
	my $seqlennowater = length($seqNOwaterandions);
	
	my $aveeuclideanprint = sprintf("%.4f",($averageeuclideans{$thechosenaa}));
	# LABELS
	# AA NUM PDB LEN D E NEG K R H POS POSHIS NONCH CHA ST NQ POL OTH ARO HYD KCX EC RES BFA AVEEUCLIDEAN ION WAT PROTLENCODE PROTLEN
	print VECTOR $aatofind." $thechosenaa $PDB $seqlennowater $D $E $negatives $K $R $H $positives $posandhis $pNoncharged $pCharged $ST $NQ $pPolar $pOthers $pAromatics $pHydrophobics $i $o $protlencode $protlen\n";
	print PYMOL "\n";
#	print $sequencearound." AveEuclidean:".$aveeuclideanprint."\n";
}
	
print PYMOL "show sticks, $aatofind*\n";
print PYMOL "color red, $aatofind*\n";
print PYMOL "color tv_blue, around*\n";

print PYMOL "select histidines, resn his\n";
print PYMOL "show sticks, histidines\n";
print PYMOL "show spheres, heteroatoms\n";
print PYMOL "deselect\n";

close PYMOL;
close VECTOR;
print " ...done!<br/>\n";

#while ( my ($key, $value) = each(%averageeuclideans) ) 
#{
#	print "$key => $value\n";
#}

exit;

###############################################################
# # ~ ~ s u b r o u t i n e s ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ # #
###############################################################
sub get_file_data 
{
    my($filename) = @_;

    # Initialize variables
    my @filedata = ();
    
    unless( open(GET_FILE_DATA, $filename) ) 
    {
        print "<br/>Cannot open file \"$filename\"<br/>";
        print "<p align='center'><b>PDB format required</b></p>\n";
        print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$PDB)' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
        exit;
    }
	@filedata = <GET_FILE_DATA>;
	close GET_FILE_DATA;
    return @filedata;
}

sub EuclideanDistance
{
	my ($x1,$y1,$z1,$x2,$y2,$z2) = @_;
	
	my $x = ($x1-$x2)**2;
	my $y = ($y1-$y2)**2;
	my $z = ($z1-$z2)**2;
	my $sum = $x+$y+$z;
	my $sqrtsum = sqrt($sum);
	
	return $sqrtsum;
	# my $euclidean = EuclideanDistance($x,$y,$z,$x2,$y2,$z2);
}

sub get_pdbsidechain_coordinateskcxcase
{
	my ($pdbfile,$aatofind) = @_;
	
	my @openfile = get_file_data($pdbfile);
	
	my %aacoordinates = ();
	my %alltheother = ();
	# $COORDINTATES{AANUMBER}{ATOM} = [AA3][X][Y][X][BFACTOR]

	# Control
	my $initialchain = ''; #Just to make sure we only have one chain;
	my $c = 0;

	foreach my $line (@openfile)
	{
		chomp($line);
		
		if ($line =~ /^ATOM/)
		{
			$c++;
			my $chain = substr($line,21,1);
			if ($c == 1)
			{
				$initialchain = $chain;
				next;
			}
			else
			{
				if ($initialchain ne $chain)
				{
					print "\n\n#################### FATAL ERROR <br/>\n";
			        print "<small>Please, contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$pdb)' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
					print "\t#####################<br/>\n\n";
					exit;
				}
			}
			
			my $resnum = substr ($line,22,4);
			$resnum =~ s/\s//g;
			
			my $aa3 = substr($line,17,3);
			
			my $atomnumber = substr($line,6,5);
			$atomnumber =~ s/\s//g;
			
			my $atomname = substr($line,12,4); 
			$atomname =~ s/\s//g;
			
			my $bfactor = substr($line,60,5);
			$bfactor =~ s/\s//g;
			
			my $x = substr($line,30,8);
			$x =~ s/\s//g;
			my $y = substr($line,38,8);
			$y  =~ s/\s//g;
			my $z = substr($line,46,8);
			$z  =~ s/\s//g;
		
			my @tmp = ();	
			@tmp = ($resnum,$aa3,$x,$y,$z,$bfactor,$atomname);
			
			if ($aa3 eq $aatofind)
			{		
				# NOT TAKING atoms from the BACKBONE AND CARBOXYL GROUP OF KCX AND LYS
				unless ( ($atomname =~ /^N$/) | ($atomname =~ /^CA$/) | ($atomname =~ /^C$/) | ($atomname =~ /^O$/) | ($atomname =~ /^CX$/) | ($atomname =~ /^OQ1$/) | ($atomname =~ /^OQ2$/) ) 
				{
#					print $line."\n";
					$aacoordinates{$resnum}{$atomnumber} = [@tmp];
					# print $line."\n";
#					print "\tATOM:".$atomnumber." AA#:".$resnum." AA3:".$aa3." X:$x Y:$y Z:$z BFACTOR:$bfactor\n";
				}#unless
				if ($atomname =~ /^NZ$/)
				{
					my ($xcxx,$ycxx,$zcxx) = GiveMeTheLysTip($pdbfile,$resnum);
					my $bfactortip = 0;
					my $atomcxname = "PCX"; #PROYECTED PCX
					my $atomnumber = 9999;
					my @temp = ($resnum,$aa3,$xcxx,$ycxx,$zcxx,$bfactortip,$atomcxname);
					$aacoordinates{$resnum}{$atomnumber} = [@tmp];
#					print "\t$resnum,$aa3,$xcxx,$ycxx,$zcxx... in!\n"
				}
			}
			# ALL THE OTHER AMINO ACIDS, TAKE THE WHOLE THING
			else
			{
				$alltheother{$resnum}{$atomnumber} = [@tmp];
			} #else
		} #if it's an ATOM
	}
	
	return (\%aacoordinates,\%alltheother);
#	It is sent as reference, therefore you should write in the main script:
#	my ($aacoor, $allothercoor) = get_pdbsidechain_coordinates($filename,$theaa);
#	my %aacoordinates = %$aacoor;
#	my %alltheothercoordinates = %$allothercoor;

} #END OF GET_POC_COORDINATESKCXCASE

# EXACTLY THE SAME AS THE PREVIOUS ONE, BUT WE DON'T TAKE THE CARBOXYL GROUP OF A CARBOXYLATED LYSINE.
sub Get_PDBHETATM_Coordinates_Ion_Water
{
	my ($pdbfile) = @_;
	
	my @openfile = get_file_data($pdbfile);
	
	# Load the list of accepted ions

	#################################################
	# OPERATING SYSTEM ?
	my $os = $^O;
	my $ionfile = '';
	#print "Running in: $os\n";	
	$ionfile = "../PreLysCarScripts/zmetalioncenters.list";
	#################################################

	my @oionfile = get_file_data($ionfile);
	my %listofions = ();
	foreach my $line (@oionfile)
	{
		chomp($line);
		if (!$listofions{$line})
		{
			$listofions{$line} = 1;
#			print $line."<\n";
		}
	}
	
	my %ionhetatmcoordinates = ();
	my %watercoordinates = ();
	# $COORDINTATES{AANUMBER}{ATOM} = [AA3][X][Y][X][BFACTOR]

	# Control
	my $initialchain = ''; #Just to make sure we only have one chain;
	my $c = 0;

	foreach my $line (@openfile)
	{
		chomp($line);
		
		if ($line =~ /^HETATM/)
		{	
			my $resnum = substr ($line,22,4);
			$resnum =~ s/\s//g;
			
			my $aa3 = substr($line,17,3);
			$aa3 =~ s/\s//g;
	
			my $atomnumber = substr($line,6,5);
			$atomnumber =~ s/\s//g;
			
			my $atomname = substr($line,12,4); 
			$atomname =~ s/\s//g;
			
			my $bfactor = substr($line,60,5);
			$bfactor =~ s/\s//g;
			
			my $x = substr($line,30,8);
			$x =~ s/\s//g;
			my $y = substr($line,38,8);
			$y  =~ s/\s//g;
			my $z = substr($line,46,8);
			$z  =~ s/\s//g;
		
			my @tmp = ();	
			@tmp = ($resnum,$aa3,$x,$y,$z,$bfactor,$atomname);
#			print $aa3.",";
			if ($listofions{$aa3})
			{		
				$ionhetatmcoordinates{$resnum}{$atomnumber} = [@tmp];
#				print "\tHETATM:".$atomnumber." AA#:".$resnum." AA3:".$aa3." X:$x Y:$y Z:$z BFACTOR:$bfactor\n";
			}
			
			if ($aa3 =~/HOH/)
			{
				$watercoordinates{$resnum}{$atomnumber} = [@tmp];
#				print "\tHETATM:".$atomnumber." AA#:".$resnum." AA3:".$aa3." X:$x Y:$y Z:$z BFACTOR:$bfactor\n";
			}
		} #if it's an ATOM
	}
	
	return (\%ionhetatmcoordinates,\%watercoordinates);
#	It is sent as reference, therefore you should write in the main script:
#	my ($ionhetatmcoor, $watercoor) = Get_PDBHETATM_Coordinates_Ion_Water($pdbfile);
#	my %ionhetatmcoor = %$ionhetatmcoor;
#	my %watercoordinates = %$watercoor;

} #END OF Get_PDBHETATM_Coordinates_Ion_Water

sub GiveMeTheLysTip
{
	my ($pdbfile,$aanumber) = @_;

	my @oinput = get_file_data($pdbfile);
	
	my ($xca,$xcb,$xcg,$xcd,$xce,$xnz,$xcx) = '';
	my ($yca,$ycb,$ycg,$ycd,$yce,$ynz,$ycx) = '';
	my ($zca,$zcb,$zcg,$zcd,$zce,$znz,$zcx) = '';
	
	foreach my $linea (@oinput)
	{
		chomp($linea);
		
		if ($linea =~ /^ATOM/)
		{
			my $aa3 = substr($linea,17,3);
			my $aan = substr($linea,22,4);
			$aan =~ s/\s//g;
			
			my $atomserialnumber = substr($linea,6,5);
			$atomserialnumber =~ s/\s//g;
			
			my $atomname = substr($linea,12,4); 
			$atomname =~ s/\s//g;
		
			my $x = substr($linea,30,8);
			$x =~ s/\s//g;
			my $y = substr($linea,38,8);
			$y  =~ s/\s//g;
			my $z = substr($linea,46,8);
			$z  =~ s/\s//g;
			
			if ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "CA"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xca = $x;
				$yca = $y;
				$zca = $z;
			}
			elsif ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "CB"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xcb = $x;
				$ycb = $y;
				$zcb = $z;
			}
			elsif ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "CG"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xcg = $x;
				$ycg = $y;
				$zcg = $z;
			}
			elsif ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "CD"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xcd = $x;
				$ycd = $y;
				$zcd = $z;
			}
			elsif ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "CE"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xce = $x;
				$yce = $y;
				$zce = $z;
			}
			elsif ( ($linea =~ /^ATOM/) & ($aan eq $aanumber) & ($atomname eq "NZ"))
			{
		#		print $x." ".$y." ".$z."\n";
				$xnz = $x;
				$ynz = $y;
				$znz = $z;
			}
		}# if ($line)
	} #foreach my $linea (@oinput)
	
	#Trying to get here an average direction vector
	my ($dx1,$dy1,$dz1) = VectorDirection($xca,$yca,$zca,$xcb,$ycb,$zcb);
	my ($dx2,$dy2,$dz2) = VectorDirection($xcb,$ycb,$zcb,$xcg,$ycg,$zcg);
	my ($dx3,$dy3,$dz3) = VectorDirection($xcg,$ycg,$zcg,$xcd,$ycd,$zcd);
	my ($dx4,$dy4,$dz4) = VectorDirection($xcd,$ycd,$zcd,$xce,$yce,$zce);
	my ($dx5,$dy5,$dz5) = VectorDirection($xce,$yce,$zce,$xnz,$ynz,$znz);
	
	my $avedx = ($dx1+$dx2+$dx3+$dx4+$dx5)/5;
	my $avedy = ($dy1+$dy2+$dy3+$dy4+$dy5)/5;
	my $avedz = ($dz1+$dz2+$dz3+$dz4+$dz5)/5;
	
	# GET DIRECTION OF A HYPOTHETICAL TIP ON NZ
	my $xcxx = $xnz+($avedx);
	my $ycxx = $ynz+($avedy);
	my $zcxx = $znz+($avedz);

	return ($xcxx,$ycxx,$zcxx);
#	my ($xcxx,$ycxx,$zcxx) = GiveMeTheLysTip($pdbfile,$aanumber);
}

sub VectorDirection 
{
	my($x1,$y1,$z1,$x2,$y2,$z2) = @_;
	
	my $dx = $x2-$x1;
	my $dy = $y2-$y1;
	my $dz = $z2-$z1;
	
	return ($dx,$dy,$dz);
#	my ($dx1,$dy1,$dz1) = VectorDirection($x1,$y1,$z1,$x2,$y2,$z2);
}

sub iubjust3to1 {

    my($input) = @_;
    
    my %three2one = (
		'ALA' => 'A',
		'VAL' => 'V',
		'LEU' => 'L',
		'ILE' => 'I',
		'PRO' => 'P',
		'TRP' => 'W',
		'PHE' => 'F',
		'MET' => 'M',
		'GLY' => 'G',
		'SER' => 'S',
		'THR' => 'T',
		'TYR' => 'Y',
		'CYS' => 'C',
		'ASN' => 'N',
		'GLN' => 'Q',
		'LYS' => 'K',
		'ARG' => 'R',
		'HIS' => 'H',
		'ASP' => 'D',
		'GLU' => 'E',
		'ASX' => 'B',
		'GLX' => 'Z',
		'XLE' => 'J',
		'XAA' => 'X',
		'UNK' => 'X',
		'MSE' => 'm',
		# MODIFIED RESIDUES
		'HYP' => 'p',	# PRO  4-HYDROXYPROLINE                                                       
		'KCX' => 'k',	# LYS  LYSINE NZ-CARBOXYLIC ACID                                            
		'SMC' => 'c',	# CYS  S-METHYLCYSTEINE                                   
		'MME' => 'm',	# MET  N-METHYL METHIONINE            
		'PTR' => 'y',	# TYR  O-PHOSPHOTYROSINE       
#		'LLP' => 'k',	# 2-LYSINE(3-HYDROXY-2-METHYL-5-PHOSPHONOOXYMETHYL
		'OCS' => 'c',	# CYS  CYSTEINE SULFONIC ACID      
#		'ALY' => 'k',	# LYS  MODIFIED LYSINE
		'LLP' => 'x',   # LLP 2-LYSINE(3-HYDROXY-2-METHYL-5-PHOSPHONOOXYMETHYL-PYRIDIN-4-YLMETHANE) N'-PYRIDOXYL-LYSINE-5'-MONOPHOSPHATE LLP    4(C14 H24 N3 O7 P)
		'CME' => 'c',	# S,S-(2-HYDROXYETHYL)THIOCYSTEINE
      

		# WATER MOLECULES
		'HOH' => 'o',	# WATER MOLECULE
		# IONS
		'MG'  => 'i', 	# MAGNESIUM ION
		'SO4' => 'i',	# SULFATE ION
		'CL'  => 'i',	# CHLORIDE ION
		'NI'  => 'i',	# NICKEL(II) ION
		'MN'  => 'i',	# MANGANESE(II) ION
		'ZN'  => 'i',	# ZINC ION
		'CO3' => 'i',	# CARBONATE ION
		'PO4' => 'i',	# PHOSPHATE ION
		'CD'  => 'i',	# CADMIUM ION
		'NA'  => 'i',	# SODIUM ION
		'CA'  => 'i',	# CALCIUM ION
		'CO'  => 'i',	# COBALT(II) ION
		'MLI' => 'i',	# MALONATE ION
		'CAC' => 'i',	# CACODYLATE ION
		'ACT' => 'i',	# ACETATE ION
		'FE2' => 'i',	# FE (II) ION
		'FE'  => 'i',	# FE(III) ION
		'AZI' => 'i',	# AZIDE ION
		'SO3' => 'i',	# SULFITE ION
		'BR'  => 'i',	# BROMIDE ION 		
    ); #END OF THE ARRAY
    
    my $seq = '';
	if(not defined $three2one{$input}) 
	{
		print "\t[SUB iubjust3to1] Code $input not defined\n";
#		$seq = "bad";
	}
	else
	{
		$seq = $three2one{$input};
	}
    return $seq;
}

# FREQUENCY OF EACH RESIDUE (INCLUDING DOUBLES, UNKNOWN, AND MODIFIED RESIDUES)
sub AminoAcidFrequenciesBayesian
{
	my($protein) = @_;
	
	#---------------------------------------------------------------------------
	my($A) = ($protein =~ tr/A//);	# Ala  	  Alanine
	my($R) = ($protein =~ tr/R//);	# Arg 	  Arginine
	my($N) = ($protein =~ tr/N//);	# Asn 	  Asparagine
	my($D) = ($protein =~ tr/D//);	# Asp 	  Aspartic acid
	my($C) = ($protein =~ tr/C//);	# Cys 	  Cysteine
	my($Q) = ($protein =~ tr/Q//);	# Gln 	  Glutamine
	my($E) = ($protein =~ tr/E//);	# Glu 	  Glutamic acid
	my($G) = ($protein =~ tr/G//);	# Gly 	  Glycine
	my($H) = ($protein =~ tr/H//);	# His 	  Histidine
	my($I) = ($protein =~ tr/I//);	# Ile 	  Isoleucine
	my($L) = ($protein =~ tr/L//);	# Leu 	  Leucine
	my($K) = ($protein =~ tr/K//);	# Lys 	  Lysine
	my($M) = ($protein =~ tr/M//);	# Met 	  Methionine
	my($F) = ($protein =~ tr/F//);	# Phe 	  Phenylalanine
	my($P) = ($protein =~ tr/P//);	# Pro 	  Proline
	my($S) = ($protein =~ tr/S//);	# Ser 	  Serine
	my($T) = ($protein =~ tr/T//);	# Thr 	  Threonine
	my($W) = ($protein =~ tr/W//);	# Trp 	  Tryptophan
	my($Y) = ($protein =~ tr/Y//);	# Tyr 	  Tyrosine
	my($V) = ($protein =~ tr/V//);	# Val 	  Valine
	my($B) = ($protein =~ tr/B//);	# Asx 	  Aspartic acid or Asparagine
	my($Z) = ($protein =~ tr/Z//);	# Glx 	  Glutamic acid or Glutamine
	my($X) = ($protein =~ tr/X//);	# Xaa 	  Any amino acid
	my($d) = ($protein =~ tr/-//);  # Dash  		NUMBER OF DASH (-)
	my($m) = ($protein =~ tr/m//);	# 'MSE' => 'm' || 'MME' => 'm',	# MET  N-METHYL METHIONINE     
	my($p) = ($protein =~ tr/p//);	# 'HYP' => 'p',	# PRO  4-HYDROXYPROLINE		
	my($k) = ($protein =~ tr/k//);	# 'KCX' => 'k',	# LYS  LYSINE NZ-CARBOXYLIC ACID | 'LLP' => 'k',	# 2-LYSINE(3-HYDROXY-2-METHYL-5-PHOSPHONOOXYMETHYL |'ALY' => 'k',	# LYS  MODIFIED LYSINE         
	my($c) = ($protein =~ tr/c//);	# 'SMC' => 'c',	# CYS  S-METHYLCYSTEINE | 		'OCS' => 'c',	# CYS  CYSTEINE SULFONIC ACID  
	my($y) = ($protein =~ tr/y//);	# 'PTR' => 'y',	# TYR  O-PHOSPHOTYROSINE
	my($i) = ($protein =~ tr/i//); # 'ION' => 'i',	# ION. IT CAN BE ANYTHING. CHECK iubjust3to1
	my($o) = ($protein =~ tr/o//); # 'HOH' => 'w',	# Wather Molecule
	#---------------------------------------------------------------------------
	
	my ($hydrophobics) = $M+$I+$L+$V;
	my ($others) = $C+$G+$P+$A;
	my ($aromatics) = $F+$W+$Y;
	my ($polar) = $S+$T+$Q+$N;
	my ($ST) = $S+$T;
	my ($QN) = $Q+$N;

	my ($charged) = $R+$D+$E+$H+$K+$B+$Z;
	my ($noncharged) = $A+$I+$L+$V+$M+$C+$G+$P+$F+$W+$Y+$S+$T+$Q+$N+$k;

	my ($total) = $A+$I+$L+$V+$M+$C+$G+$P+$F+$W+$Y+$S+$T+$Q+$N+$R+$D+$E+$H+$K+$B+$Z+$k;
	
	return ($R,$D,$E,$H,$K,$noncharged,$charged,$ST,$QN,$polar,$others,$aromatics,$hydrophobics,$k,$i,$o);
}
