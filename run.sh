#!/bin/bash

INTERPRET=php
EXTENSION=php
MYPATH="../FIT_IPP_1_MakroProcesor"
FULLPATH=$(pwd)/$MYPATH
 
echo -e "\e[44m#################################################################################################################"
echo -e "#                                               ŠKOLNÍ TESTY                                                    #"
echo -e "#################################################################################################################\e[0m"
cd jmp-supplementary-tests
./_stud_tests.sh $FULLPATH $INTERPRET $EXTENSION
cd ..
echo -e "\e[44m#################################################################################################################"
echo -e "#                                                 FITUŠKA                                                       #"
echo -e "#################################################################################################################\e[0m"
cd fituska
./run.sh $INTERPRET $FULLPATH/jmp.$EXTENSION
cd ..
