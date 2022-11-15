#!/bin/bash

if [[ $# != 2 ]]; then
	echo "ERROR: wrong number of arguments"
	echo "This bash script is using command line arguments."
	echo "Syntax example: ./task3.sh \"Hello, world 123\" 4"
	exit 0
fi



text=$1
shift_num=$2

num_regex='^[0-9]+$'
letter_regex='^[a-zA-Z]+$'
shifted_phrase=''

#step 1, 2, 3, 4
for ((i=0;i<${#text};i++))
{
	if [[ ${text:$i:1} =~ $letter_regex ]]; then #if letter
	
		register_indicator=$(($i % 2))
		ascii_num=$(($(echo -n ${text:$i:1} | od -An -tuC)-64))
		
		if (( "$ascii_num" >= "33" )); then #Changing reigster to upper. There is no need for the original register, because
						    #it will be determinated by the index
			ascii_num=$(($ascii_num-32))
		fi
		
		ascii_num=$((shift_num + ascii_num)) # shifting
				
		if [ $((ascii_num % 26)) -eq "0" ]; then
			shifted_phrase+=$(printf "\x$(printf %x $((90 + $register_indicator * 32)))")
		else
			shifted_phrase+=$(printf "\x$(printf %x $(($ascii_num % 26 + 64 + $register_indicator * 32)))")
		
		fi
			
	elif [[ ${text:$i:1} =~ $num_regex ]]; then   #if number
		shifted_phrase+="$((9-${text:$i:1}))"
	elif [[ ${text:$i:1} == ' ' ]]; then   #if whitespace
		shifted_phrase+=$(printf "\x$(printf %x "32")")
	else					      #not number, not letter, not whitespace
		shifted_phrase+=${text:$i:1}
	fi
}

#step 5
reversed_shifted_phrase=''
for ((i=${#shifted_phrase};i>=0;i--)) 
{
	reversed_shifted_phrase+=${shifted_phrase:$i:1}
}

echo $reversed_shifted_phrase

exit 0

