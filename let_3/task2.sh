#!/bin/bash

read -a bigString


for ((i=1; i < "${#bigString[@]}"; i++))
{	
	current=${bigString[$i]} # finding length of string i-1 and i
	len_current=${#current}
	
	prev=${bigString[$(($i-1))]}
	len_prev=${#prev}

	if [[ $(($i % 2)) == "1" ]]; then
		if [[ "$len_current" < "$len_prev" ]]; then
			tmp="${bigString[$i]}"
			bigString[$i]="${bigString[$(($i - 1))]}"
			bigString[$(($i - 1))]=$tmp
		fi
	else
		if [[ "$len_current" > "$len_prev" ]]; then
			tmp="${bigString[$i]}"
			bigString[$i]="${bigString[$(($i - 1))]}"
			bigString[$(($i - 1))]=$tmp
		fi
	fi

}

for ((i=0; i < "${#bigString[@]}"; i++))
{	
	string=${bigString[$i]}
	
	if [[ $(($i % 2)) == "1" ]]; then
		uppercase_string=${string^^} # '^^' for uppercase, ',,' for lower case
		bigString[$i]=$uppercase_string
	else
		lowercase_string=${string,,}
	fi	
}

echo "${bigString[*]}"
exit 0
