#!/usr/bin/env bash

# SSH connections without password entry.
# Pre-run for each server:
# $ ssh-keygen
# $ ssh-copy-id -i ~/.ssh/id_rsa.pub UserName@RemoteServer
# $ ssh-add
HOSTS_FILE="HOSTS.txt"
USER="marat"
KEY_PROC="java"
KEYWORD="port="
JAVA_PROC="java_proc.txt"
JAVA_PROC_LAST="java_proc_last.txt"
TMP_DATE="tmp_date.txt"
TMP_DATE_NUMBER="tmp_date_number.txt"
TMP_DATE_LAST="tmp_date_last.txt"
LAST_TIME="Last_time.txt"

function parsing_proc {
    if [[ `cat $JAVA_PROC |grep "dmadmin"` ]]; then   #Cut date:
        cat $JAVA_PROC |tr -s " "| cut -d ' ' -f 5,7 > $TMP_DATE
    else                    #For testing
        cat $JAVA_PROC |tr -s " "| cut -d ' ' -f 4,5,6,7 > $TMP_DATE
    fi
     > $TMP_DATE_NUMBER
    last_time=0
    while read line; do    # Iterating, calculating the last date
        echo -n "$line ">> $TMP_DATE_NUMBER
        date +%s -d "$line" >> $TMP_DATE_NUMBER
        cur_time=`date +%s -d "$line"`
        if  [ $cur_time -gt $last_time ]; then
            last_time=$cur_time
            last_time_str=$line
        fi
    done < $TMP_DATE

    echo "$last_time_str $last_time" > $TMP_DATE_LAST

    echo "Last Time: $last_time_str ($last_time seconds)" >> $LAST_TIME

    # Search process with the last date and write to the file:
    cat $JAVA_PROC | grep `echo $last_time_str |cut -d ' ' -f 1` > $JAVA_PROC_LAST
    cat $JAVA_PROC_LAST | grep `echo $last_time_str |cut -d ' ' -f 2` > $JAVA_PROC_LAST
    # Search port number:
    for item in $(cat $JAVA_PROC_LAST |tr '-' ' '|tr '.' ' '| tr -s ' ') ; do
        if [[ $item = *"$KEYWORD"* ]]
            then
                echo "Number $item" >> $LAST_TIME
            fi
    done
}

#--------- Start-------------
date > $LAST_TIME
> $JAVA_PROC
for HOST in $(cat $HOSTS_FILE) ; do
    if [ `echo $HOST |cut -c -1` = "#" ]; then  #if the host is commented, then skip
        continue
    fi

    echo '________________________________' >> $LAST_TIME
    if !(ping -c 1 $HOST &> /dev/null); then    #if the host is not available, then skip
        echo "$HOST host is not available" >> $LAST_TIME
        cp java_proc_orig.txt $JAVA_PROC
#        continue       # Comment for test
    else
        ssh $USER@$HOST 'hostname' >> $LAST_TIME
        ssh $USER@$HOST "ps -o user,pid,lstart,cmd -C $KEY_PROC" > tmp.txt
        cat tmp.txt |grep "$KEY_PROC" > $JAVA_PROC
    fi
    echo '-------------------------' >> $LAST_TIME

    parsing_proc
    echo >> $LAST_TIME
done

cat $LAST_TIME
rm $TMP_DATE $TMP_DATE_NUMBER $TMP_DATE_LAST $JAVA_PROC_LAST tmp.txt
