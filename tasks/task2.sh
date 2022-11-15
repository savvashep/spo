#!/bin/bash

function add_letters()
	{
	IFS=" "
	read -a letters_array <<< "$letters"
	
	if [ ${#letters_array[@]} -eq "0" ]; then
		letters_num="122"
		return 0
	fi
		
	for ((i=0;i<${#letters_array[@]};i++))
		{
		ascii_num=$(($(echo -n ${letters_array[i]} | od -An -tuC)-96))
		letters_num=$(( ascii_num + letters_num ))
		}
	
	if [ $((letters_num % 26)) -eq "0" ]; then
		letters_num="122"
		return 0
	fi
	
	letters_num=$((letters_num % 26 + 96))
	}
		
			
read letters
add_letters
printf "\x$(printf %x $letters_num)"


