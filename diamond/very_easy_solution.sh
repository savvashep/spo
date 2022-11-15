#!/bin/bash

if [ "$#" -ne "1" ]; then 
	echo "ERROR: Invalid number of arguments" 
	exit 1
fi 

int_regex='^[0-9]+$'
if ! [[ $1 =~ $int_regex ]]; then 
	echo "ERROR: Invalid argument" 
	exit 1
fi 

if [ $1 -lt 2 ]; then 
	echo "ERROR: Invalid argument" 
	exit 1
fi 

solution=$(($1-1))
echo $solution

exit 0
