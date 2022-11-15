#!/bin/bash

read s1 s2

declare -A letters
for ((i=1; i < 27; i++))
{
	currentL=$(printf "\x$(printf %x $(($i+96)))")
	letters[$currentL]=0
}

for ((i=0; i < ${#s1}; i++))
{	
	if [[ ${letters[${s1:$i:1}]} -eq "0" ]]; then
		letters[${s1:$i:1}]=1
	fi
}

for ((i=0; i < ${#s2}; i++))
{	
	if [[ ${letters[${s2:$i:1}]} -eq "0" ]]; then
		letters[${s2:$i:1}]=1
	fi
}

final_string=""
for key in "${!letters[@]}"
{
	if [[ ${letters[$key]} == "1" ]]; then
		final_string+=$key
	fi
}

echo $final_string | rev
exit 0
