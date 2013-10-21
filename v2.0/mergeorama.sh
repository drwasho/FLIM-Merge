#!/bin/bash

################################################################################################################################################################
# mergeorama.sh - this script does something awful.
# By Inge Seim
# 10/2013 v2
#
#  this script parses files and batches a dodgy Perl script
# 
################################################################################################################################################################

# Dummy run. This way you can add whatever dummy X axis you want
perl mergefiles.pl pixelID.txt pixelID.txt ;
cp largerfile.txt ./data ;
rm ./largerfile.txt ; # get rid of your temp files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
#convert data files spaces to _/underscore if you have weird Windows file names etc.
cd ./data ;  #~
ls *.asc | while read -r FILE  
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' `
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# convert all *.asc (data files) to files where 0 is replaced with a dash/-)
for i in *.asc ; do
perl -pi -e 's/\s0\s/\ \-\n/g' $i ;
# perl ../zeroToDeci.pl $i ;
#@ cp $i $i.bac ;
#@ rm $i ;
#@ cp $i $i.input ;  # your input data files no longer contains just zeros! 
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
for j in *.asc ; do
perl ../mergefiles.pl largerfile.txt $j ;
rm ./temp.txt ; # get rid of your temp files
rm ../temp.txt ; # get rid of your temp files
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# get rid of the dummy columns
cut -f1,4- ./largerfile.txt >../output.csv ;  # column 2 and 3 contain "dummy" 
rm ./largerfile.txt ; # get rid of your temp files
# use the unix command cut for this
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# convert dashes back to zero
perl -pi -e 's/-/0/g' ../output.csv ;
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# unnecessary echo here 
clear ;
echo -en '\E[47;31m'"\033[1mall done! Your output will be in the tabulated file output.csv \033[0m"   # Red
echo -e "\e[00;37m" ;

echo '
   ,---.
   CO-|| Y  
   O  || |
   |   D J
  // /"""'
