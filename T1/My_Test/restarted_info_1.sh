#!/usr/bin/env bash

JAVA_PROC="java_proc.txt"
JAVA_PROC_LAST="java_proc_last.txt"
TMP_DATE="tmp_date.txt"
TMP_DATE_NUMBER="tmp_date_number.txt"
TMP_DATE_LAST="tmp_date_last.txt"
LAST_TIME="Last_time.txt"

cat $JAVA_PROC |tr -s " "| cut -d ' ' -f 5,7 > $TMP_DATE

 > $TMP_DATE_NUMBER
last_time=0
while read line; do
    echo -n "$line ">> ${TMP_DATE_NUMBER}
    date +%s -d "$line" >> $TMP_DATE_NUMBER
    cur_time=`date +%s -d "$line"`
    if  [ $cur_time -gt $last_time ]
    then
        last_time=$cur_time
        last_time_str=$line
    fi
done < $TMP_DATE

#cat $TMP_DATE
#cat $TMP_DATE_NUMBER
echo "$last_time_str $last_time" > $TMP_DATE_LAST

echo "Last Time: $last_time_str ($last_time second)" > $LAST_TIME
#cat $TMP_DATE_LAST

cat $JAVA_PROC | grep `echo $last_time_str |cut -d ' ' -f 1` > $JAVA_PROC_LAST
cat $JAVA_PROC_LAST | grep `echo $last_time_str |cut -d ' ' -f 2` > $JAVA_PROC_LAST

for item in $(cat $JAVA_PROC_LAST |tr '-' ' '|tr '.' ' '| tr -s ' ') ; do
#    echo $item
    if [[ $item = *"port="* ]]
        then
            echo "Number $item" >> $LAST_TIME
        fi
done

cat $LAST_TIME
rm $TMP_DATE $TMP_DATE_NUMBER
