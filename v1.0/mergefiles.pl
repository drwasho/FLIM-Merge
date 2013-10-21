#!/usr/bin/perl 
use strict;
use Term::ANSIColor;

################################################################################################################################################################
# mergefiles.pl - this script does something awful.
# By Inge Seim
# 10/2013
#
#  
# 
################################################################################################################################################################



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# Prepare the INPUT
my %col2;  #PixelID in column 1 to special column 2
my ($file1, $file2) = @ARGV;     # so in the bash script, one can call $i



my $filename = $ARGV[1] ;
# split
my ($filenameonly, $suffix) = split /\./, $filename;
# END OF FILENAME FUN ########################################################3
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


print color 'bold green' ;
print "# ###############################################################################" . "\n" ;
print color 'reset';


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# need to add PixelID space $filenameonly . "\n" to the top
# this is the sample files
open my $in,  '<',  $file2      or die "Can't read old file: $!";
open my $out, '>', "temp.txt" or die "Can't write new file: $!";
print $out "PixelID" . " " . $filenameonly . "\n" ; # Add this line to the top\n"; # <--- HERE'S THE MAGIC . NO TAB in Wash's files, just a space!


while( <$in> )
   {
   print $out $_;
   }

close $out;
# ############################################################################### 
# OK, now open your new file!
my $file2newheader ; 
# open (FILE, $fie) or die "feed me" . "\n";
if (1 == 1) { 
#print "yes" ;
local $/ = undef;  # important! Want to feed the entire file into a single string now!
open (FILE2, "temp.txt") or die "feed me" . "\n";
# open (FILE, $file2.new) or die "feed me" . "\n";
$file2newheader = (<FILE2>);
close(FILE2) ;
}
print $file2newheader . "\n" ; 
print "THIS IS THE ENTIRE FILE2 **INPUT FILE** WITH A NEW HEADER!" . "\n" ;
print color 'bold green' ;
print "# ###############################################################################" . "\n" ;
print color 'reset';
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 




# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
# ############################################################################### 
# Here comes the actual comparison of the two files!
#
# open (my $two_cols, '<', $file2) or die "unable to open $file2 $!";
# my $two_cols = $file2newheader ;
open (my $two_cols, '<', 'temp.txt') or die "unable to open $file2 $!";

# $two_cols = map {$_ eq "" ? 0 : $_} $two_cols;


# this is the big file that contains more and more values
open (my $big_file, '<', $file1) or die "unable to open $file1 $!";

 
# $big_file = map {$_ eq "" ? 0 : $_} $big_file;
# This will ensure that ...


%col2 = map{   s/\s+$//; #chomp + zap trailing white space   
               my ($gene, $v) = split(/\s/,$_,3);
            }<$two_cols>;

           
# delete the previous, largerfile.txt | PURGE IT
system("rm largerfile.txt") ;

while (<$big_file>)
{
   s/\s+$//;
   my ($gene, $rest) = split(/\s/,$_,2);
   if (my $lastcol = $col2{$gene})   
   {    
     print "$gene\t$rest\t$lastcol\n";
# now time to write
open (FILE, ">>./largerfile.txt") ;  #open for write, append 
    print FILE "$gene\t$rest\t$lastcol\n";

   }

close(FILE);

}

print "THIS IS THE ENTIRE OUTPUT FILE, WHICH WILL GROW LARGER AND LARGER AS THE SCRIPTS LOOPS!" . "\n" ;
print color 'bold green' ;
print "# ###############################################################################" . "\n" ;
print color 'reset';

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

