#!/usr/bin/perl -w
use strict;
if(scalar @ARGV !=1){
	print "\nUsage: perl OptCod.pl input.fa\n\n";
	exit;
}
unless ( open(File, "<$ARGV[0]") ) {
	print "Cannot open file \n\n";
	exit;
}
my$ON1=(split(".fa",$ARGV[0]))[0];
system("codonW $ARGV[0] -all_indices -coa_cu -nomenu -silent");
system("mv $ON1.out $ON1.enc");
system("perl Group.pl $ON1.enc");
system("perl ExtractSequence.pl $ARGV[0] $ARGV[0].M.fa $ON1.enc.Max.list");
system("perl ExtractSequence.pl $ARGV[0] $ARGV[0].N.fa $ON1.enc.Min.list");
system("perl RSCU.pl $ARGV[0].M.fa");
system("perl RSCU.pl $ARGV[0].N.fa");
system("perl RSCU.pl $ARGV[0]");
system("perl DeltRscu.pl $ARGV[0].M.fa.rscu $ARGV[0].N.fa.rscu $ARGV[0].delt");
system("perl DeltTotal.pl $ARGV[0].rscu $ARGV[0].delt $ON1.delt.txt");
close File;
print "\nDeltRSCU can be found in $ON1.delt.txt. \n";
print "\nThe best codon is marked by Y.\n";
print "\nUse the data obtained with OptCod, please cite in your paper:\n";
print "\nTaikui Zhang. 2017. OptCod. URL:https://github.com/Redpome/OptCod.\n";
