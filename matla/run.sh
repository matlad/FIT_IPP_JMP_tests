#!/bin/bash

#---------------------------------------------------------------------------------------#
#Testy pro JMP z IPP na FIT VUT
#@author xmatla00                      
#---------------------------------------------------------------------------------------#

COUNT=0
F_COUNT=0
MAX=1

function clean {
	rm *.!!!
	rm *.out
	rm *.err
}

function format {
	if [ $1 != 0 ]; then
               echo -e "\e[33mDIFF\e[0m"
            else
               echo -e "\e[32mSAME\e[0m"
            fi
} 

function getResult { #$all $code $ref.!!! 
	if [ $3 != 0 ]; then #referenční .!!! není 0 => test chyby
       if [ $2 == 0 ]; then #porovnání pouze chybového kodu
			echo -e "\e[32m[OK]\e[0m";
			COUNT=$(( $COUNT + 1));
		else
			 echo -e "\e[31m[FAIL]\e[0m";
			F_COUNT=$(( $F_COUNT + 1));
		fi
    else
       if [ $1 == 0 ]; then #všechny výstupy jsou stejné
			echo -e "\e[32m[OK]\e[0m";
			COUNT=$(( $COUNT + 1));
		else
			 echo -e "\e[31m[FAIL]\e[0m";
			F_COUNT=$(( $F_COUNT + 1));
		fi
    fi

} 

function comper {  
	`diff -N "./$1.out" "./ref-out/$1.out" > /dev/null`;
	out=$?

	`diff -N "./$1.err" "./ref-out/$1.err" > /dev/null`;
	err=$?

	`diff -N "./$1.!!!" "./ref-out/$1.!!!" > /dev/null`;
	cod=$?

	all=$(( $out + $err ))
	all=$(( $all + $cod ))
	all=$(getResult $all $cod `cat "./ref-out/$1.!!!"`)
	echo -e "$1 $all [out="$(format $out)" err="$(format $err)" e_cod="$(format $cod)"]\n";
}


#########################################################################################

TASK="$1/jmp"
INTERPRETER=$2
EXTENSION=$3
#INTERPRETER="python3.6"
#EXTENSION=py

# cesty ke vstupním a výstupním souborům
LOCAL_IN_PATH="./" # (simple relative path)
LOCAL_IN_PATH2="" #Alternative 1 (primitive relative path)
LOCAL_IN_PATH3="`pwd`/" #Alternative 2 (absolute path)
LOCAL_OUT_PATH="./" # (simple relative path)
LOCAL_OUT_PATH2="" #Alternative 1 (primitive relative path)
LOCAL_OUT_PATH3="`pwd`/" #Alternative 2 (absolute path)
# cesta pro ukládání chybového výstupu studentského skriptu
LOG_PATH="./"

#########################################################################################

echo "#test01: Chybné parametry u def"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}test01.in --output=${LOCAL_OUT_PATH2}test01.out 2> ${LOG_PATH}test01.err
echo -n $? > test01.!!!
comper "test01" 


TEST_NAME="test02"
echo "#$TEST_NAME: @undef@undef"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}$TEST_NAME.in --output=${LOCAL_OUT_PATH2}$TEST_NAME.out 2> ${LOG_PATH}$TEST_NAME.err
echo -n $? > $TEST_NAME.!!!
comper $TEST_NAME

TEST_NAME="test03"
echo "#$TEST_NAME: Svět na ruby"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}$TEST_NAME.in --output=${LOCAL_OUT_PATH2}$TEST_NAME.out 2> ${LOG_PATH}$TEST_NAME.err
echo -n $? > $TEST_NAME.!!!
comper $TEST_NAME

TEST_NAME="test04"
echo "#$TEST_NAME: překrývající se názvy parametrů"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}$TEST_NAME.in --output=${LOCAL_OUT_PATH2}$TEST_NAME.out 2> ${LOG_PATH}$TEST_NAME.err
echo -n $? > $TEST_NAME.!!!
comper $TEST_NAME

TEST_NAME="test05"
echo "#$TEST_NAME: překryvající se názvy maker"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}$TEST_NAME.in --output=${LOCAL_OUT_PATH2}$TEST_NAME.out 2> ${LOG_PATH}$TEST_NAME.err
echo -n $? > $TEST_NAME.!!!
comper $TEST_NAME

TEST_NAME="test06"
echo "#$TEST_NAME: překryvající se názvy maker"
$INTERPRETER $TASK.$EXTENSION --input=${LOCAL_IN_PATH2}$TEST_NAME.in --output=${LOCAL_OUT_PATH2}$TEST_NAME.out 2> ${LOG_PATH}$TEST_NAME.err
echo -n $? > $TEST_NAME.!!!
comper $TEST_NAME

########################################################################################
#echo "$COUNT testu bylo OK a $F_COUNT testů bylo špatně"
clean 
