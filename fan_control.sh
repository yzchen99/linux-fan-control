#!/bin/bash
while true
do
    #second level here
    lv1=50
    #third level here
    lv2=70
    temp=`sensors | grep "^Core" | tr ":" "\n" | grep -Eo '[0-9]+([.][0-9]+)?' | sed -n '2~4p' | sort -n | tail -1`
    temp=${temp%%.*}
    curs=(`i8kfan`)
    tp1=${curs[0]}
    tp2=${curs[1]}
    if [ "$lv1" -le "$temp" ] && [ "$temp" -lt "$lv2" ] && [ "$tp2" -eq "-1" ] && [ "$tp1" -eq "-1" ]; then
	i8kfan -1 2;
    fi
    if [ "$temp" -lt "$lv1" ] && [ "$tp2" -eq 2 ]; then
	i8kfan 1 1;
    fi
    if [ "$lv2" -le "$temp" ] && [ "$tp1" -ne 2 ]; then
	i8kfan 2 2;
    fi
    if [ "$temp" -lt "$lv2" ] && [ "$lv1" -le "$temp" ] && [ "$tp1" -eq 2 ]; then
	i8kfan 1 2;
    fi
    #echo $tp1
    #echo $tp2
    sleep 10
done
