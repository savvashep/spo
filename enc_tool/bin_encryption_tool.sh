#!/bin/bash

decimal_int_regex='^[0-9]+$'
binary_int_regex='^[0-1]+$'

if [[ $1 == "--help" ]]; then
	for i in {1..40}; do echo -ne "- "; done
	echo ""
	echo "This bash script encrypts given integer number with \"-code\" modificator"
	echo "With \"-decode\" modificator it decodes given number. If there is no "
	echo "argument it decodes the default file - coded_number.txt"
	echo "Coded number is storaged in coded_number.txt"
	echo "Decoded number is storaged in decoded_number.txt"
	for i in {1..40}; do echo -ne "- "; done
	exit 0
fi

if [[ $1 == "-code" ]]; then
	
	if ! [[ $2 =~ $decimal_int_regex ]]; then
		echo "ERROR: argument must be integer"
		exit 1
	fi
	
	echo -ne "" > coded_number.txt # clearing the file
	number=$2
	number_of_digits="${#number}"
	for ((cnt=0;$cnt<$number_of_digits;cnt++))
		{
		extracted_number=${number:$cnt:1}
		number_base_two=$(echo "obase=2;$extracted_number" | bc)
		k=$((${#number_base_two}-1))	
		for ((cntk=0;cntk<k;cntk++))
			{
			echo -ne "0" >> coded_number.txt
			}
		echo -ne "1"$number_base_two >> coded_number.txt
		}
	
	echo -ne "Coded number: "
	echo $(cat coded_number.txt)
	
	exit 0
		
fi

if [[ $1 == "-decode" ]]; then

	if [ "$#" = "1" ]; then
		path_to_file=coded_number.txt
		coded_number=$(cat $path_to_file)
	elif ! [[ $2 =~ $binary_int_regex ]]; then
		echo "ERROR: argument must be binary"
		exit 1
	else
		coded_number=$2
	fi
	
	cnt_zero=1
	echo -ne "" > decoded_number.txt # clearing the file 
	while [[ $cnt != ${#coded_number} ]]
	do
		if [[ ${coded_number:$cnt:1} == "0" ]]; then
			((cnt_zero++))
			((cnt++))
		else
		((cnt++))
		echo -ne $((2#${coded_number:$cnt:$cnt_zero})) >> decoded_number.txt
		cnt=$(($cnt_zero+$cnt))
		cnt_zero=1
		fi
	done
	
	echo -ne "Decoded number: "
	echo $(cat decoded_number.txt)
	
	exit 0
	
fi
