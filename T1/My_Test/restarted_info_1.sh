#!/usr/bin/env bash

# SSH connections without password entry.
# Pre-run for each server:
# $ ssh-keygen
# $ ssh-copy-id -i ~/.ssh/id_rsa.pub UserName@RemoteServer
# $ ssh-add
HOSTS_FILE="HOSTS.txt"
USER="marat"
KEY_PROC="chrome"
KEYWORD="lang="
JAVA_PROC="java_proc.txt"
JAVA_PROC_LAST="java_proc_last.txt"
TMP_DATE="tmp_date.txt"
TMP_DATE_NUMBER="tmp_date_number.txt"
TMP_DATE_LAST="tmp_date_last.txt"
LAST_TIME="Last_time.txt"

function parsing_proc {
    cat $JAVA_PROC |tr -s " "| cut -d ' ' -f 4,5,6,7 > $TMP_DATE

     > $TMP_DATE_NUMBER
    last_time=0
    while read line; do
        echo -n "$line ">> $TMP_DATE_NUMBER
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

    echo "Last Time: $last_time_str ($last_time second)" >> $LAST_TIME
    #cat $TMP_DATE_LAST

    cat $JAVA_PROC | grep `echo $last_time_str |cut -d ' ' -f 1` > $JAVA_PROC_LAST
    cat $JAVA_PROC_LAST | grep `echo $last_time_str |cut -d ' ' -f 2` > $JAVA_PROC_LAST

    for item in $(cat $JAVA_PROC_LAST |tr '-' ' '|tr '.' ' '| tr -s ' ') ; do
    #    echo $item
        if [[ $item = *"lang="* ]]
            then
                echo "Number $item" >> $LAST_TIME
            fi
    done

#    cat $LAST_TIME
#    rm $TMP_DATE $TMP_DATE_NUMBER
}

date > $LAST_TIME
> $JAVA_PROC
for HOST in $(cat $HOSTS_FILE) ; do
    if [ `echo $HOST |cut -c -1` = "#" ]; then
        continue
    fi
    echo '_________________________' >> $LAST_TIME
    ssh $USER@$HOST 'hostname' >> $LAST_TIME
    echo '-------------------------' >> $LAST_TIME

    if  [ $HOST != "Mac-mini-user" ]
        then
            echo "NOOOOT"
            ssh $USER@$HOST 'ps -o user,pid,lstart,cmd -C chrome' > $JAVA_PROC
        else
            echo " MAAAAC"
            ssh $USER@$HOST 'ps -eo user,pid,lstart,comm |grep [c,C]hrome' > $JAVA_PROC
        fi

    cat $JAVA_PROC |grep "chrome" > $JAVA_PROC

    parsing_proc
    echo >> $LAST_TIME
done

cat $LAST_TIME
#rm $TMP_DATE $TMP_DATE_NUMBER $TMP_DATE_LAST $JAVA_PROC_LAST
