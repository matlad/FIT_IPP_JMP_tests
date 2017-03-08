#!/bin/bash

INTERPRET=php # php5.6 pro merlin
EXTENSION=php
MYPATH="../FIT_IPP_1_MakroProcesor" #cesta k *adresáři* v němž je váš skript JMP.php
FULLPATH=$(pwd)/$MYPATH
 
echo -e "\e[44m#################################################################################################################"
echo -e "#                                               ŠKOLNÍ TESTY                                                    #"
echo -e "#################################################################################################################\e[0m"
cd jmp-supplementary-tests
./_stud_tests.sh $FULLPATH $INTERPRET $EXTENSION
cd ..
echo -e "\e[44m#################################################################################################################"
echo -e "#                                           FITUŠKA - Andrej Kovac                                              #"
echo -e "#################################################################################################################\e[0m"
cd fituska
./run.sh $INTERPRET $FULLPATH/jmp.$EXTENSION
cd ..
echo -e "\e[44m#################################################################################################################"
echo -e "#                                                    MATLA                                                      #"
echo -e "#################################################################################################################\e[0m"
cd matla
./run.sh $FULLPATH $INTERPRET $EXTENSION
cd ..
echo -e "\e[44m#################################################################################################################"
echo -e "#                                                    KONEC                                                      #"
echo -e "#################################################################################################################\e[0m"
