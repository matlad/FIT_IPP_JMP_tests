#!/bin/bash

IFS=$'\n' read -d '' -r -a codes < returncodes
IFS=$'\n' read -d '' -r -a testname < testnames
IFS=$'\n' read -d '' -r -a into < input
IFS=$'\n' read -d '' -r -a ref < output


#echo "${testname[@]}"
#echo "${codes[0]}"
#echo "${into[@]}"
#echo "${ref[@]}"


if [ -z $1 ]; then
	echo "Usage ./run.sh INTERPRET FILENAME"
	exit 1
fi

type $1 > /dev/null 2>&1;

if  $?; then
	echo "First argument must be an INTERPRET: php or python3"
	exit 1
fi
if [ -z $2 ]; then
	echo "Missing second argument: FILENAME"
	exit 1
fi

mkdir "contains space"
pwd=$(pwd)
echo "asd" > "./contains space/in"
echo "asd asd" > "./contains space/refout2"
cd ..

#Test opening folder contains space
$1 $2 "--input=$pwd/contains space/in" "--output=$pwd/contains space/out" 2>/dev/null
returncode=$?
if [ $returncode -eq 0 ]; then
	echo -e "Folder with space...........: \e[32mPASS\e[39m"
else
	echo -e "Folder with space...........: \e[31mFAILED\e[39m"
fi

#Test opening folder contains space
$1 $2 --input=$pwd/contains space/in "--output=$pwd/contains space/out" 2>/dev/null
returncode=$?
if [ $returncode -eq 4 ]; then
	echo -e "Input with space............: \e[32mPASS\e[39m"
else
	echo -e "Input with space............: \e[31mFAILED\e[39m"
fi

#Test opening folder contains space
$1 $2 "--input=$pwd/contains space/in" --output=$pwd/contains space/out 2>/dev/null
returncode=$?
if [ $returncode -eq 4 ]; then
	echo -e "Output with space...........: \e[32mPASS\e[39m"
else
	echo -e "Output with space...........: \e[31mFAILED\e[39m"
fi

#Test CMD with space
$1 $2 "--cmd=asd " "--input=$pwd/contains space/in" "--output=$pwd/contains space/out2" 2>/dev/null
diff "$pwd/contains space/out2" "$pwd/contains space/refout2" 
returncode=$?
if [ $returncode -eq 0 ]; then
	echo -e "CMD with space..............: \e[32mPASS\e[39m"
else
	echo -e "CMD with space..............: \e[31mFAILED\e[39m"
fi

for i in {0..36}
do
	out=$(echo "${into[$i]}" | $1 $2 2>/dev/null)
	returncode=$?
	#echo $out
	#echo "${ref[$i]}"
	if [ $returncode -eq "${codes[$i]}" ]; then
		if [ "${codes[$i]}" -eq 0 ];then
			if [ "${ref[$i]}" == "$out" ]; then
				echo -e "${testname[$i]} \e[32mPASS\e[39m"
			else
				echo -e "$i:${testname[$i]} \e[31mFAILED\e[39m"
				echo "Input: ${into[$i]}"
				echo "Expected output:${ref[$i]}"
				echo "Actual output..:$out"
			fi
		else
			echo -e "${testname[$i]} \e[32mPASS\e[39m"
		fi
	else 
		echo -e "${testname[$i]} \e[31mFAILED\e[39m"
		echo "Input: ${into[$i]}"
		echo "Expected return code:${codes[$i]}"
		echo "Actual return code..:$returncode"
	fi
done
cd "$pwd"
rm -r "contains space"
