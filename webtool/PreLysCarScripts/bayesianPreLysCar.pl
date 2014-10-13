#!/usr/bin/perl -w

use POSIX;
use strict;
use warnings;

# David Jimenez Morales
# @ davidjm scripts
# Release date: 12/22/2013

# ------Description ---------------------------------------#
# bayesianPreLysCar.pl > Calculate Posterior probability of
# both LYS and KCX.
#
# Input: 
# - prior
# - list of csv files with the LYS vectors
#
# Original script bayesiankcxpredictorlargedataset.pl
#
# ---------------------------------------------------------#

my $command = "bayesianPreLysCar.pl";
if (@ARGV != 2)
{
	print "\n\t!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n";
	print "\t Two ARGUMENTS NEEDED ------------------\n";
	print "\tUsage: $command PRIOR list_of_euclideanfiles\n";
	print "\t!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n";
	exit;
}

###########################################################
# MAP of FEATURES 
# ~~~~~~~Old version
# 3  4 5  6  7 8 9  10   11     12   13 14 15  16  17  18  19  20 21  22  23     24        25  26     27         28                             
#LEN D E NEG K R H POS POSHIS NONCH CHA ST NQ POL OTH ARO HYD KCX EC RES BFA AVEEUCLIDEAN ION WAT PROTLENCODE PROTLEN

# ~~~~~~~New version
# 3  4 5  6  7 8 9  10   11     12   13 14 15  16  17  18  19 20  21  22          23                             
#LEN D E NEG K R H POS POSHIS NONCH CHA ST NQ POL OTH ARO HYD ION WAT PROTLENCODE PROTLEN

# Using the Features giving the BEST performance in the 
# leave-one-out cross validation test with the training 
# data set.
my @chosenfeatures = (3,6,11,14,15,18,19,20,21); #BEST performance

# TAKE SELECTED FEATURES
my %ilikehash = ();
foreach my $ele (@chosenfeatures)
{
	$ilikehash{$ele} = 1;
}


###########################################################
# KCX frequencies
my $kcxfile = "../PreLysCarScripts/ds251-kcx-prelyscarmodern-eu5tip.csv";
# LYS frequencies
my $lysfile = "../PreLysCarScripts/ds251-lys-prelyscarmodern-eu5tip.csv";

#INPUT 1: PRIOR PROBABILITY (user selected)
my $prior = $ARGV[0];

#INPUT 2: LIST of CSV files with the VECTORS
my $pdblist = $ARGV[1];
chomp($pdblist);

# Getting job ID.
my $jobid = '';
if ($pdblist =~ /(.*)\.csvlist/)
{
	$jobid = $1;
}


###########################################################

my ($kcxhashofarrays_h) = open_file_in_hash_of_arrays($kcxfile);
my %kcxhashofarrays = %$kcxhashofarrays_h;
my $kcxtotalnumber = keys %kcxhashofarrays;

my ($lyshashofarrays_h) = open_file_in_hash_of_arrays($lysfile);
my %lyshashofarrays = %$lyshashofarrays_h;
my $lystotalnumber = keys %lyshashofarrays;

########################################################
#  FREQUENCIES FOR EACH AMINO ACID
########################################################

#T HE FREQUENCIES FOR LYS RESIDUES
my %frequencieslys = Calculate_Probability_Event(\%lyshashofarrays,\%ilikehash);
#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	
#	for my $bins (sort {$a<=>$b} keys %frequencieslys)
#	{
#		for my $feature (sort keys %{$frequencieslys{$bins}})
#		{
#			my $valor = $frequencieslys{$bins}{$feature};
#			print $bins." ".$feature." ".$valor."\n";
#		}
#		print "\n";
#	}
#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	

#THE FREQUENCIES FOR KCX RESIDUES
my %frequencieskcx = Calculate_Probability_Event(\%kcxhashofarrays,\%ilikehash);
#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	
#	for my $bins (sort {$a<=>$b} keys %frequencieskcx)
#	{
#		for my $feature (sort keys %{$frequencieskcx{$bins}})
#		{
#			my $valor = $frequencieskcx{$bins}{$feature};
#			print $bins." ".$feature." ".$valor."\n";
#		}
#		print "\n";
#	}
#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	

# Go through a whole list of PDB(.csv) files
my @opdblist = get_file_data($pdblist);
my $hits = 0;
foreach my $pdb (@opdblist)
{
	my ($pdbtopredict_h) = open_file_in_hash_of_arrays($pdb);
	my %pdbtopredict = %$pdbtopredict_h;
#	my $vectorsinthepdb = keys %pdbtopredict; # I think it is not necessary
	# GRAVING THE VECTORS FROM THE PDB
	my @allkeys= keys %pdbtopredict; 
	
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# LENCONTROL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# Control: this number only can be 0, 1 or 2
	my $sizecheck = '';
	$sizecheck = $pdbtopredict{0}[22];
	if ($sizecheck !~ /[0,1,2]/)
	{
		print "FATAL ERROR PROBLEM<br/>\n";
		print $command." error 139<br/>\n";
		print "<small>Please, contact us at <a href='mailto:prelyscar\@gmail.com?Subject=Fatal error $command 139' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";

		exit;
	}
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# LENCONTROL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	foreach my $therandomkey (@allkeys)
	{
	#	print "V:$therandomkey ";
	
		# EXTRACTING ONE AT RANDOM
		my %onevectorrandom = ();
		my %alltheothervectors = ();
		

		my @yep = @{$pdbtopredict{$therandomkey} };
		$onevectorrandom{$therandomkey} = [@yep];
		
		my $aan = $onevectorrandom{$therandomkey}[1];
		my $pdb = $onevectorrandom{$therandomkey}[2];
		
		my $id = $aan."-".$pdb;
		
		# Get the chain ID:
		my $chainid = '';
		
		if ($pdb =~ /.*\.(chain.*)/)
		{
			$chainid = $1;	
		}
		
		# I am doing this just because of the original lysloocv version
		my %kckminusone = %pdbtopredict;

		
		# STRUCTURE OF THE REDUCED RANDOM VECTOR:
		# $reducedrandomvector{FEATURE} = NUMBEROFTIMES (also call, the BINS of the prob matrices);
		my %reducedrandomvector = ();
		for my $features (sort {$a<=>$b} keys (%ilikehash))
		{
			$reducedrandomvector{$features} = $onevectorrandom{$therandomkey}[$features];
	#		print $features." ".$onevectorrandom{$therandomkey}[$features]." ".$reducedrandomvector{$features}."\n";
		}
		
		my ($posteriorC1,$posteriorC2) = Calculate_Posterior_Probability($prior,\%reducedrandomvector,\%frequencieskcx,\%frequencieslys);
	
		if ($posteriorC1>$posteriorC2)
		{
			$hits++;
			# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			# LENCONTROL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#			my $diffkey = $posteriorC1-$posteriorC2;
			
			if ($sizecheck == 1)
			{
				print "<table width='99%' border='2' align='center' cellpadding='5' cellspacing='5' bordercolor='#FF3333' bgcolor='#FFFF00'><tr><td width='100%'>";
				print "<b><span class='style58'>Lysine $aan $chainid predicted as carboxylated (probability=";
				printf ("%.5f ",$posteriorC1);
				print ") although is a small protein!</span></b><br/>\n";
				print "</td></tr></table>";
			}
			else
			{
				print "<table width='99%' border='2' align='center' cellpadding='2' cellspacing='2' bordercolor='#FF3333' bgcolor='#FFFF00'><tr><td width='100%'>";
				print "<b><span class='style58'>Lysine $aan $chainid predicted as carboxylated<br/><small>(probability=";
				printf ("%.5f ",$posteriorC1);
				print ")</small></span></b><br/>\n";
				print "</td></tr></table>";
			}
			# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			# LENCONTROL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		}
#		else
#		{
#			print "No lysine predicted as carboxyated in chain $pdb <br/>\n";
#		}
	}	
}

if ($hits == 0)
{
	print "<br/><span class='style43'><b>----> NO carboxylated lysines predicted in this protein</b></span><br/><br/>\n";
	print "<small>Please, cite:</small><br/> <b>Jimenez-Morales D, et.al. (2014). Acta Cryst. D 70, 48-57.</b><br/><br/>";
	print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$jobid)' target='_top'>prelyscar\@gmail.com</a> <br/>\n";
	print "<p align='center'><i>Thanks for using PreLysCar</i></p></small><br/>\n";
}
else
{
	print "<br><small>Please, cite:</small><br/> <b>Jimenez-Morales D, et.al. (2014). Acta Cryst. D 70, 48-57.</b><br/><br/>";
	print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$jobid)' target='_top'>prelyscar\@gmail.com</a> <br/>\n";
	print "<p align='center'><i>Thanks for using PreLysCar</i></p></small><br/>\n";
}

exit;


###############################################################
# # ~ ~ s u b r o u t i n e s ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ # #
###############################################################
sub get_file_data 
{
    my($filename) = @_;

    use strict;
    use warnings;

    # Initialize variables
    my @filedata = ();
    
    unless( open(GET_FILE_DATA, $filename) ) 
    {
#    	print STDERR "<br/>Cannot open file \"$filename\"<br/><br/>";
        print "<br/>Cannot open file \"$filename\"<br/>";
		print $command." error 257<br/>\n";
		print "<small>Please, contact us at <a href='mailto:prelyscar\@gmail.com?Subject=Fatal error $command 257' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
        exit;
    }
	@filedata = <GET_FILE_DATA>;
	close GET_FILE_DATA;
    return @filedata;
}


#################################################
# CALCULTATE PROBABILITY OF AN EVENT
sub Calculate_Probability_Event
{
	my ($allaaafeatures_h,$hashoffeatures_h) = @_;
	
	my %allaaafeatures = %$allaaafeatures_h;
	my %hashoffeatures = %$hashoffeatures_h;

	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	
#	while ( my($joder,$suputa) = each (%hashoffeatures) )
#	{
#		print $joder." and ".$suputa."\n";
#	}
#	
#	for $family (sort {$a<=>$b} keys %allaaafeatures ) 
#	{
#		print "$family: @{ $allaaafeatures{$family} }\n";
#	}
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp

	########################################################
	#FREQUENCIES FOR EACH AMINO ACID
	# $aaafeaturesfrequencies{PREINDEX FROM 0 to 15?}{feature1} = number of observations for this value for this feature
	my %aaafeaturesfrequencies = ();
	
	# INITIALIZE THE HASH %aaafeaturesfrequencies
	# I need to create the frequencies indexes (I choose 15 by now):
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	for (my $i = 0;$i<=30;$i++)
	{
		for my $v (sort {$a<=>$b} keys %hashoffeatures) 
		{
#			print $i." ".$v." = 0\n";
			$aaafeaturesfrequencies{$i}{$v} = 0;
		}
	}
	
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
#	for my $joder (sort {$a<=>$b} keys %aaafeaturesfrequencies)
#	{
#		print $joder."\n";
#		for my $laputa (keys %{$aaafeaturesfrequencies{$joder}})
#		{
#			print "\t".$laputa." ".$aaafeaturesfrequencies{$joder}{$laputa}."\n";
#		}
#	}
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
		
	#FILLING UP THE HASH FOR FREQUENCIES:
	for my $k (sort {$a<=>$b} keys %allaaafeatures ) 
	{
		for my $v (sort {$a<=>$b} keys %hashoffeatures) 
		{
#			print "Vector:".$k." ".$v.": has the value ";
			my $featurevalue = $allaaafeatures{$k}[$v];
#			print $featurevalue."\n";
			# SUMMING UP THIS ELEMENT FOR THIS FEATURE
			if (!$aaafeaturesfrequencies{$featurevalue}{$v})
			{
				$aaafeaturesfrequencies{$featurevalue}{$v} = 1;
#				print "\t".$featurevalue." ".$v." ".$aaafeaturesfrequencies{$featurevalue}{$v}."\n";
			}
			else
			{
				$aaafeaturesfrequencies{$featurevalue}{$v}++;
#				print "\t".$featurevalue." ".$v." ".$aaafeaturesfrequencies{$featurevalue}{$v}."\n";
			}
		}
#	    print "\n";
	}

	##ppppppppppppppppppepppppppppppppppppppppppppppppppppppppppp
	# PRINTING OUT FREQUENCIES
#	for my $joder (sort {$a<=>$b} keys %aaafeaturesfrequencies)
#	{
#		print $joder."\n";
#		for my $laputa (keys %{$aaafeaturesfrequencies{$joder}})
#		{
#			print "\t".$laputa." ".$aaafeaturesfrequencies{$joder}{$laputa}."\n";
#		}
#	}
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp

	# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
	# TAKE THE SUM PER COLUM, and at the same time, CHECK POINT
	# It's a check point because I make sure that all the columns 
	# has exactly the same value, all of them, because it does not make
	# sense otherwise. This is because in my training data I don't miss
	# even one single value, therefore all the feature must sum up to 
	# the exact same value for all of them
	my $totalcheckpoint = 0;
	my $ctcp = 1;
	for my $venga (keys %hashoffeatures)
	{
		my $totalhere = 0;
		for my $vamos (sort {$a<=>$b} keys %aaafeaturesfrequencies)
		{
#			print $venga." ".$vamos." ".$aaafeaturesfrequencies{$vamos}{$venga}."\n";
			$totalhere += $aaafeaturesfrequencies{$vamos}{$venga};
		}
			if ($totalhere == 0)
			{
				print "Oh no!\n";
				exit;
			}
#		print "--------\n";
#		print "total = $totalhere\n";
		if ($ctcp == 1)
		{
			$totalcheckpoint = $totalhere;
		}
		else
		{
			if ($totalcheckpoint != $totalhere)
			{ 
				print "<br/>FATAL ERROR PROBLEM<br/>\n";
				print $command." error 385<br/>\n";
				print "<small>Please, contact us at <a href='mailto:prelyscar\@gmail.com?Subject=Fatal error $command 385' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
				exit;
			}
		}
		$ctcp++;
	}
	
	# FREQUENCY MATRIX (Fx|C)
	my %frequenciesaaa = ();
	
	for my $bins (sort {$a<=>$b} keys %aaafeaturesfrequencies)
	{
	#	print $oh." = ";
		for my $feature (sort keys %{$aaafeaturesfrequencies{$bins}})
		{
			my $valor = $aaafeaturesfrequencies{$bins}{$feature};
#			print $bins." ".$feature." ".$valor." ";
#			print "\nTOTALCHECKPOINT:".$totalcheckpoint." ";
			my ($probability) =  sprintf("%.4f",(($valor/$totalcheckpoint)));
		
			if ($probability == 0)
			{
				$frequenciesaaa{$bins}{$feature} = 0.0001;
			}
			else
			{
				$frequenciesaaa{$bins}{$feature} = $probability;
#				print $probability."\n";
			}
		}
#		print "\n";
	}
	
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
	# PRINTING OUT PROBABILITIES
#	for my $bins (sort {$a<=>$b} keys %frequenciesaaa)
#	{
#		for my $feature (sort keys %{$frequenciesaaa{$bins}})
#		{
#			my $valor = $frequenciesaaa{$bins}{$feature};
#			print $bins." ".$feature." ".$valor."\n";
#		}
#		print "\n";
#	}
	##pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp
#	exit;
	return(%frequenciesaaa);
#	my %frequenciesaaa = Calculate_Probability_Event(%aaafeaturesfrequencies);
} #Calculate_Probability_Event



#################################################
# CALCULTATE PROBABILITY OF AN EVENT
sub Calculate_Posterior_Probability
{
	my ($prior,$vector_h,$prob_matrix_a_h,$prob_matrix_b_h) = @_;

	my $otherprior = (1-$prior);
	my %vector = %$vector_h;
	my %prob_matrix_a = %$prob_matrix_a_h;
	my %prob_matrix_b = %$prob_matrix_b_h;

#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	
#	for my $bins (sort {$a<=>$b} keys %prob_matrix_a)
#	{
#		for my $feature (sort keys %{$prob_matrix_a{$bins}})
#		{
#			my $valor = $prob_matrix_a{$bins}{$feature};
#			print $bins." ".$feature." ".$valor."\n";
#		}
#		print "\n";
#	}
#pppppppppppppppppppppppppppppppppppppppppppppppppppppppppp	
		
	my $probabilityFC1 = 1;
	my $probabilityFC2 = 1;
	for my $f (sort {$a<=>$b} keys (%vector) )
	{
		my $bins = $vector{$f};
#		print $bins." ".$f." ";
		
		#Now KCX
		my $P_f1_if_C1 = $prob_matrix_a{$bins}{$f};
#		print " = ".$P_f1_if_C1." and ";
		$probabilityFC1 *= $P_f1_if_C1;

		#Now LYS
		my $P_f1_if_C2 = $prob_matrix_b{$bins}{$f};
#		print $P_f1_if_C2."\n";
		$probabilityFC2 *= $P_f1_if_C2;
	}
#	print "Likelihood KCX ".$probabilityFC1."\n";
#	print "Likelihood LYS ".$probabilityFC2."\n";
	
	my $priorMlikelihoodC1 = $prior*$probabilityFC1;
	my $priorMlikelihoodC2 = $otherprior*$probabilityFC2;
	my $evidence = $priorMlikelihoodC1+$priorMlikelihoodC2;
	my $posteriorC1 = ($priorMlikelihoodC1/$evidence);
	my $posteriorC2 = ($priorMlikelihoodC2/$evidence);
	
#	print "Now posteriors: C1: $posteriorC1 and $posteriorC2\n";
	return ($posteriorC1,$posteriorC2);
}


sub open_file_in_hash_of_arrays
{
	my($filename) = @_;
	my @ofilename = get_file_data($filename);
	
	my $sizecontrol = 0;
	my $c = 0;
	
	my %hashofarrays = ();
	
	foreach my $line (@ofilename)
	{
		chomp($line);
#		print $line."\n";
		my @temp = split(" ",$line);
		my $size = @temp;
		#Size control for the first one
		if ($c == 0)
		{
			$sizecontrol = $size;
		}
		
		#All the others - -- - - - -- ---
		if($size != $sizecontrol)
		{
			print "FATAL ERROR PROBLEM<br/>\n";
			print $command." error 518<br/>\n";
			print "<small>Please, contact us at <a href='mailto:prelyscar\@gmail.com?Subject=Fatal error $command 518' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
			exit;
		}
		#- - - - - - -- - -end of control
		
		$hashofarrays{$c} = [@temp];
		
		$c++;
	}
	#ppppppppppppppppppppppppppppppppppppppppppppppppp
#	for my $k (sort {$a<=>$b} keys %hashofarrays ) 
#	{
#		print "$k=>";
#		for my $v ( 0 .. $#{ $hashofarrays{$k} } ) 
#		{
#			print " $v:$hashofarrays{$k}[$v] ";
#		}
#	    print "\n";
#	}
	#ppppppppppppppppppppppppppppppppppppppppppppppppp
	return (\%hashofarrays);
} #open_file_in_hash_of_arrays