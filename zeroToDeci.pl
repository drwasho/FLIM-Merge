#!/usr/bin/perl 
# use strict;
use Term::ANSIColor;

################################################################################################################################################################
# mergeorama.sh - this script does something awful.
# By Inge Seim
# 10/2013
#
#  this script parses converts 0 to dashes/- (or whatever you want)
# 
################################################################################################################################################################

system("clear");

my $filename = $ARGV[0] ;
my @data = "" ;

open (FILE, $filename) or die "usage: uniqueAAv2.pl [filename] [hg19 # in MSA] [target # in MSA]     \n";
chomp (@data = (<FILE>));
close(FILE);


################################################################################################################################################################
# Here comes the actual parsing etc
# $#array gives the index of the last array element 
foreach my $index (0 .. $#data) { 
if ($data[$index] =~ /\s0\s/) {         # so 9):  to  +0 (positive digit)
    print "ZERO HERE, SIR" . "\n" ;
my ($number, $target) = split /\s/, $data[$index];
$target = "-" ;
print $number . " " . $target . "\n" ;
$data[$index] = $number . " " . $target ;
    
    print $data[$index] . "\n" ;
    
}
else 
{    
	print $data[$index] . "\n" ; 
  print "YO!" ;
}


# now time to write
open (FILE, ">>./nozero.txt") ;  # open for write, append 
    print FILE $data[$index] . "\n" ; 

   close(FILE);

}
# print "#############" . "\n" ;
# print $data[0] . "\n" ; 
# print $data[1] . "\n" ; 

