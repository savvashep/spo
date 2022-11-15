#!/bin/bash

function array_invertion()
	{
		IFS=" "
		read -a words_array <<< "$phrase"
		local words_array_length=${#words_array[@]}
		inverted_words_array=()
		for ((i=$words_array_length;i>=0;i--))
			{	
				inverted_words_array+=(${words_array[i]})
			}
	}
		
read phrase
array_invertion
echo "${inverted_words_array[*]}"
exit 0
