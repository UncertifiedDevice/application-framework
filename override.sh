#!/bin/bash

srcPlat=$1
srcMain=$2

echo "$srcPlat"

for tmpMain in ${srcMain[@]};
do
	for tmpPlat in ${srcPlat[@]};
	do
		[[ ! `basename $tmpPlat` == `basename $tmpMain` ]] && echo $tmpMain;
		break;
	done
done
