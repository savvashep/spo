#!/bin/bash

if [ "$#" -ne "1" ]; then
	echo "ERROR: Invalid number of arguments"
	echo "Syntax example: ./fourh.sh <your_int_num> "
	exit 1
fi

int_regex='^[0-9]+$'
if ! [[ $1 =~ $int_regex ]]; then
	echo "ERROR: Argument must be integer"
	echo "Syntax example: ./fourh.sh <your_int_num> "
	exit 1
fi


max_diamond_size=$1

#first half of the diamond
cnt_up=1
for ((number=0;number<"$1";number++))
{
	for ((a=0;a<(($1-cnt_up));a++))
	{
		echo -n " "
	}

	for ((b=0;b<$cnt_up;b++))
	{
		echo -n "* "
	}
	
	echo ""
	cnt_up=$(($cnt_up+1))
}

#second half of the diamond
cnt_down=max_diamond_size-1
for ((number=0;number<=(($1-1));number++))
{
	for ((c=0;c<((max_diamond_size-cnt_down));c++))
	{
		echo -n " "
	}

	for ((d=0;d<cnt_down;d++))
	{
		echo -n "* "
	}

	echo ""
	cnt_down=$(($cnt_down-1))
}

exit 0
