#!/bin/bash

################################################################################################################################################################
# mergeorama.sh - this script does something awful.
# By Inge Seim
# 10/2013 v3
#
#  this script parses files and batches a dodgy Perl script
# 
################################################################################################################################################################



# fix file name's first!
#convert data files spaces to _/underscore if you have weird Windows file names etc.
cd ./data ;  
ls *.asc | while read -r FILE  
do
    mv -v "$FILE" `echo $FILE | tr ' ' '_' `
done


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# convert all *.asc (data files) to files where 0 is replaced with a dash/-)
for i in *.asc ; do
perl -pi -e 's/\s0\s/\ \-\n/g' $i ;
done

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# dummy run. Use the x-values from the first file in the directory as a guide
FILE=$(ls | sort -n | head -1)
cp $FILE ../input.txt ; 
# \rm `ls | sort -n | head -1` 
cd ../ ;
# add header
perl -pi -le 'print "PixelID dummy" if $. == 1' input.txt ;   #  ; # Add this line to the top\n";
# Dummy run
perl mergefiles.pl input.txt input.txt ;
cp largerfile.txt ./data ;
rm ./temp.txt ; # get rid of your temp files
rm ./largerfile.txt ; # get rid of your temp files
cd ./data ;

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# run the script on all your datafiles 
for j in *.asc ; do
perl ../mergefiles.pl largerfile.txt $j ;
rm ./temp.txt ; # get rid of your temp files
done
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# get rid of the dummy columns
cut -f1,4- ./largerfile.txt >../output.csv ;  # column 1 and 2 contain "dummy" 
rm ./largerfile.txt ; # get rid of your temp files
rm ../input.txt ;
# use the unix command cut for this
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
# convert dashes back to zero
perl -pi -e 's/-/0/g' ../output.csv ;
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`


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

