#!/bin/bash

################################################################################################################################################################
# mergeorama.sh - this script does something awful.
# By Inge Seim
# 10/2013
#
#  this script parses files and batches a dodgy Perl script
# 
################################################################################################################################################################

# Dummy run. This way you can add whatever dummy X axis you want
perl mergefiles.pl pixelID.txt pixelID.txt ;
cp largerfile.txt ./data ;
rm ./largerfile.txt ; # get rid of your temp files
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
#convert data files spaces to _/underscore!
cd ./data ;  #~
ls *.asc | while read -r FILE  
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' `
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# convert all *.asc (data files) to files where 0 is replaced with a dash/- (or whatever you want, just edit zeroToDeci.pl)
for i in *.asc ; do
perl ../zeroToDeci.pl $i ;
cp $i $i.bac ;
rm $i ;
cp nozero.txt $i.input ;  # your input data files no longer contains just zeros! 
rm nozero.txt ; 
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
for j in *.input ; do
perl ../mergefiles.pl largerfile.txt $j ;
rm ./temp.txt ; # get rid of your temp files
rm ../temp.txt ; # get rid of your temp files
done

# get rid of the dummy columns
cut -f1,4- ./largerfile.txt >../output.csv ;  # column 2 and 3 contain "dummy" 
rm ./largerfile.txt ; # get rid of your temp files
# use the unix command cut for this

clear ;

echo -en '\E[47;31m'"\033[1mall done! Your output will be in the tabulated file finaloutput.csv \033[0m"   # Red
echo -e "\e[00;37m" ;

echo '
   ,---.
   CO-|| Y  
   O  || |
   |   D J
  // /"""'
  






