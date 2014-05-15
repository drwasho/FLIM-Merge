# FLIM-Merge

These scripts will parse multiple data files (with the same x column values, different y column values) into a csv file that can be easily imported into Excel or Graphpad. Originally developed for data created by SPCImage (http://www.becker-hickl.com/ | http://www.becker-hickl.com/software/tcspc/softwaretcspcspecial.htm), but will work for any .asc file (or anything with a few edits).

Latest version is 2.0

How to make this work
=====================

1. Copy in your data files (.asc) into a folder called 'data' (e.g. C://Work/FLIM/data). IMPORTANT: this data will be renamed and modified, so make sure the data is copied and not your only copy in case anything goes wrong... you have been warned!!!
2. Make sure that FLIMerge.pl and FLIMerge.sh are all in a folder a level up from 'data' (e.g. C://Work/FLIM/).
3. Open up the terminal and navigate to your working folder where the scripts are located
4. Run the script by entering 'bash FLIMerge.sh' in the terminal.
5. Your data will be in the output.csv file
6. When you open the .csv file in Excel or LibreOffice, indicate that the data is delimited by a **tab** in order for the data to be imported neatly into parallel columns

Who to thank
============

This script was written by Dr Inge Seim... bug tested and GitHub'd by me. 

Send your Bitcoins to Inge at: 1Hvsw4SYYbofjbyZA4BxdYEM31Kta3y1vY
