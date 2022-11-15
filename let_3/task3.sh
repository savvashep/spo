#!/bin/bash

read int_num

declare -i string_num=$int_num #converting integer into string 

index_of_point_number=(0)
point_num=${string_num:0:1}

for ((i=1; i < ${#string_num}; i++))
{
	if [[ $point_num > ${string_num:$i:1} ]]; then
		index_of_point_number=($i)  # overwriting previous index array 
		point_num=${string_num:$i:1}
	elif [[ $point_num == ${string_num:$i:1} ]]; then
		index_of_point_number+=($i)
	fi
}

if [[ $point_num == ${string_num:0:1} ]]; then # if point number hasn't changed, number can not be smaller
	echo $string_num
	exit 0
fi

changed_number=${string_num:${index_of_point_number[0]}:1}${string_num:0:${index_of_point_number[0]}}${string_num:$((1+${index_of_point_number[0]}))} #first string is point number, second is sub string
						#from beginning to number that is going to be deleted, 
						#third is substring from deleted number to the end of 
						#string. for ex:
						#string_num=21122 => index_of_point_number=(1 2)
						#for the first index this particular changed number will be
						# 1 + 2 + 122
						#for the second
						# 1 + 21 + 22
						
for index in "${index_of_point_number[@]}" # searching min number
{	
	next_changed_number=${string_num:$index:1}${string_num:0:$index}${string_num:$((1+$index))}
	
	if [[ $changed_number > $next_changed_number ]]; then
	changed_number=$next_changed_number
	fi
}

echo $changed_number
exit 0
