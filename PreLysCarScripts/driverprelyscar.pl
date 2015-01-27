#!/usr/bin/perl -w

use POSIX;
use strict;
use warnings;

# David Jimenez Morales
# @ davidjm scripts
# Release date: 12/22/2013

# ------Description ---------------------------------------#
#
# driverprelyscar.pl
#
# Check the right format in a PDB file.
#
# ---------------------------------------------------------#

my $command = "driverprelyscar";
# OPTION 2: THE INPUT IS PDB_CHAIN or PDBCHAIN
if (@ARGV != 2) 
{
	print "<br/>FATAL ERROR !!!!!!!!!!!!!!!<br/>\n";
	print "$command requires 2 arguments (PDB+prior)<br/>\n";
	print "Please, contact developer at prelyscar\@gmail.com <br/>\n";
	exit;
}

#FIRST ARGUMENT
my $filename = $ARGV[0];
my $prior = $ARGV[1];

# Generate PDB code to the temporal file:
my $keystorage = "keykeeper.txt";
my @key = get_file_data($keystorage);
my $numbercode = $key[0];
#print $numbercode;
my $newnumcode = $numbercode+1;
print "> Job ID: ";
my $formatcode = sprintf("%04d", $newnumcode);
print $formatcode."<br/>\n";

open (CODE,">".$keystorage);
print CODE $formatcode;
close CODE;

my $PDB = $formatcode;


#Open PDB FILE
my @ofile = get_file_data($filename);

# Check the ATOM line and find ALL what PreLysCar needs
my $numberatoms = 0;
foreach my $linea (@ofile)
{
	chomp($linea);
	if ($linea =~ /^ATOM/)
	{
		$numberatoms++;
		my $chain = substr($linea,21,1);
		
		unless ($chain =~ /^\w$/)
		{
			print "ERROR with the chain id <br/>\n";
			print "<p align='center'><b>PDB format required</b></p><br/>\n";
			exit;
		}
	}
}

# Length control
if ($numberatoms == 0)
{
	print "<p align='center'><b>PDB format required</b></p>\n";
	exit;
}
#elsif (($numberatoms <= 400)&($numberatoms > 0))
#{
#	print "PROBLEM: insufficient number of ATOM lines in this PDB file ($numberatoms)<br/>\n";
#	print "<p align='center'><a href='index.html' target='parent'> Please, try again</a></p>\n";
#	exit;
#}

#1. Get the number of chains
my %allthechains = ();
foreach my $line (@ofile)
{
	chomp($line);
	
	#Getting the number of chains (and the names)
	if ($line =~ /^ATOM/)
	{
		my $chain = substr($line,21,1);
		
		unless ($chain =~ /^\w$/)
		{
			print $chain."ERROR: there is a problem with the chain id <br/>\n";
			print "<p align='center'><b>ERROR: PDB format required</b></p><br/>\n";
			exit;
		}
				
		if (!$allthechains{$chain})
		{
			$allthechains{$chain} = 1;
		}

	}#if $line
	
}#foreach

my $nchains = keys %allthechains;
print " > Number of chains in PDB: <span class='style43'>".$nchains."</span><br/><br/>";

print "<strong> Checking LYS microenvironments in each PDB chain</strong><br>";
print "*************************************************<br/>";
print "<i><small>Please, wait...</i></small><br/>";

#Keep the total number of chains, to use later on
my @pdbstopredict = ();

#CSV FILES
my $listofcsvfiles = $PDB.".csvlist";
open (CSV,">".$listofcsvfiles);
my $ncsvlist = 0;

for my $chain (sort keys %allthechains)
{
	#2. Process the numb
	# Variables necesary:
	my $preresnum = 0; #Yeah, we will ignore amino acids starting by 0;
	my $firstchain = '';
	my $eachsequence = '';
	my %hashsubunitseq = ();
	# This flag allows to grap any amino acid annotated as HETEROATOM within the ATOM section. Usually these are the "PTM residues"
	my $flag = 0; 
	my $secondflag = 0;
	my $outfile = '';
	$outfile = $PDB.".chain".$chain.".pdb";
	my $outfilesub = $PDB.".chain".$chain;
	
	my %pdbsequence = (); # for the fastasequence
	
	open (NEWPDB,">".$outfile);
	foreach my $line (@ofile)
	{
		chomp($line);
		if ( ( $flag == 0) & ($line !~ /^ATOM/) )
		{
			if (($line =~ /^TER/) | ($line =~ /^ANISOU/) ) 
			{
				next;
			}
			else
			{
#				print NEWPDB $line."\n";
			}
		}
	
		if ( ($flag == 0) & ($line =~ /^ATOM/) )  
		{
			my $chainin = substr($line,21,1);
			my $aa3 = substr($line,17,3);
			my $resnum = substr ($line,22,4);
			if ($chainin eq $chain)
			{
				print NEWPDB $line."\n";
				# And for the fasta sequence:
				if(!$pdbsequence{$resnum})
				{
					$pdbsequence{$resnum} = $aa3;
				}
				$flag = 1;
			}
			next;
		}
	
		if ( ($line =~ /^ATOM/) & ($flag == 1) & ($secondflag == 0))
		{
			my $chainin = substr($line,21,1);
			my $aa3 = substr($line,17,3);
			my $resnum = substr ($line,22,4);
			if ($chainin eq $chain)
			{
				print NEWPDB $line."\n";
				# And for the fasta sequence:
				if(!$pdbsequence{$resnum})
				{
					$pdbsequence{$resnum} = $aa3;
				}
				next;
			}
			else
			{
				next;
			}
		}

		if ( ($line =~ /^HETATM/) & ($flag == 1) & ($secondflag == 0) )
		{
			my $chainin = substr($line,21,1);
			if ($chainin eq $chain)
			{
				$line =~ s/HETATM/ATOM  /;# Key step for conversion
				print NEWPDB $line."\n";
				next;
			}
			else
			{
				next;
			}
		}
		
		if ( ($flag == 1) & ($line =~ /^TER/) & ($secondflag == 0))
		{
			my $chainin = substr($line,21,1);
			if ($chainin eq $chain)
			{
				print NEWPDB $line."\n";
				$secondflag = 1;
				next;
			}
			else
			{
				next;
			}
		}
		
		if ( ($line =~ /^HETATM/) & ($flag == 1) & ($secondflag == 1) )
		{
			my $chainin = substr($line,21,1);
			if ($chainin eq $chain)
			{
				print NEWPDB $line."\n";
				next;
			}
			else
			{
				next;
			}
		}
		if ( ($line =~ /^ANISOU/) & ($flag == 1) )
		{
			my $chainin = substr($line,21,1);
			if ($chainin eq $chain)
			{
				print NEWPDB $line."\n";
				next;
			}
			else
			{
				next;
			}
		}
		if ( ($line =~ /^CONECT/) & ($flag == 1) )
		{
			print NEWPDB $line."\n";
		}
		if ( ($line =~ /^MASTER/) & ($flag == 1) )
		{
			print NEWPDB $line."\n";
		}
		if ( ($line =~ /^END/) & ($flag == 1) )
		{
			print NEWPDB $line."\n";
		}
	}
	close NEWPDB;
	
	# Checking if this subunit is a PROTEIN!
	# I required to have common amino acids, at least 100
	if (!keys %pdbsequence)
	{
		print "<p align='center'><b>ERROR: No amino acids found in this pdb file?!</b></p><br/>\n";
		exit;
	}
		
	my $seq = '';
	for my $aan (sort {$a<=>$b} keys  %pdbsequence)
	{
		my $aa3 = $pdbsequence{$aan};
		my $aa1 = isaprotein($aa3);
		$seq .= $aa1;	
	}
	
	my $ncsvlist = length $seq;
#	print "AA in ".$outfile." ".$ncsvlist."\n";
	if ($ncsvlist < 100)
	{
		print "<blockquote><small><b>Chain $chain </b>does not contain enough amino acids ($ncsvlist aa).<br/>&nbsp;&nbsp;&nbsp;&nbsp;More than 100 amino acids required.</small></blockquote>\n";
#		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
		
	}
	else
	{
		push(@pdbstopredict, $outfile);
		print CSV $outfilesub.".euclidean5-prelyscar-LYS.csv\n"; 
	}
	
#	Just in case I want to provide FASTA sequence.
#	#my $outfasta = $pdb.".pdb.fasta";
#	my $outfasta = $PDB.".chain".$chain.".fasta";
##	$outfasta = "output/".$outfasta;
#	open (PDBFASTA,">".$outfasta);
#			
#	#	print PDBFASTA ">".$thepdb."-".$thesub."\n";
#	print PDBFASTA ">".$PDB."-$chain-PDBfasta\n";
#	print PDBFASTA $seq."\n";
#	
##	print "\t>".$outfile." && ".$outfasta." is out\n";
#	close PDBFASTA;
#	
##	my $outpymol = $PDB.".euclidean5-prelyscar-LYS.pml";

}

close CSV;

if (@pdbstopredict == 0)
{
	print "<p align='center'><b>Ooops! No enough PDB chains to predict</b></p><br/>\n";
	print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$formatcode)' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
	exit;
}
else
{
	my $cn = 1;
	foreach my $pdbfile (@pdbstopredict)
	{
		print $cn." -----> ".$pdbfile."\n";
		system("/usr/bin/perl ../PreLysCarScripts/eudisprelyscar.pl $pdbfile");
		$cn++;
	}
	
	print "<br/><strong><b>Running the Predictor</b></strong><br/>";
	print "*************************************************";
	system("/usr/bin/perl ../PreLysCarScripts/bayesianPreLysCar.pl 0.009 $listofcsvfiles");

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
        print "<p align='center'><b>PDB format required</b></p>\n";
        print "<small>For any question/suggestion/comment contact us at <a href='mailto:prelyscar\@gmail.com?Subject=User comments (job id=$formatcode)' target='_top'>prelyscar\@gmail.com</a></small> <br/>\n";
        exit;
    }
	@filedata = <GET_FILE_DATA>;
	close GET_FILE_DATA;
    return @filedata;
}

sub iubjust3to1 {

    my($input) = @_;
    
    my ($seq);
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
    
	if(not defined $three2one{$input}) 
	{
#		print "\t[SUB iubjust3to1] Code $input not defined\n";
#		$seq = "bad";
	}
	else
	{
		$seq = $three2one{$input};
	}
    return $seq;
}

sub isaprotein {

    my($input) = @_;
    
    my ($aa);
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
    ); #END OF THE ARRAY
    
	if(not defined $three2one{$input}) 
	{
#		print "\t[SUB iubjust3to1] Code $input not defined\n";
		$aa = "";
	}
	else
	{
		$aa = $three2one{$input};
	}
    return $aa;
}