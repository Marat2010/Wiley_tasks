#!/usr/bin/env bash

# SSH connections without password entry.
# Pre-run for each server:
# $ ssh-keygen
# $ ssh-copy-id -i ~/.ssh/id_rsa.pub UserName@RemoteServer
# $ ssh-add

#date > $TMP_INFO
#for HOST in $(cat $HOSTS_FILE) ; do
#    ssh $USER@$HOST 'hostname' >> $TMP_INFO
#    echo '-------------------------' >> $TMP_INFO
#    ssh $USER@$HOST 'uname -a' >> $TMP_INFO
#    ssh $USER@$HOST 'cat /proc/cmdline' >> $TMP_INFO
#    ssh $USER@$HOST 'who -a' >> $TMP_INFO
#    echo >> $TMP_INFO
#done



        #TMP_INFO="tmp_info.txt"
        #USER="marat"
        #HOSTS_FILE="HOSTS.txt"
        #
        #date > $TMP_INFO
        #for HOST in $(cat $HOSTS_FILE) ; do
        #    ssh $USER@$HOST 'hostname' >> $TMP_INFO
        #    echo '-------------------------' >> $TMP_INFO

#    pass
#   add code
# ps ax
# date '3 minutes' +%stmp_info.txt
# grep ,cut -f4 -d, tr -s " "

# cat java_proc.txt |cut -d ' ' -f 1-2,5,7 -выбор столбца
# ps  ax |grep kworker | awk '$1=$1' - awk -убирает лишние символы пробела
#  tr -s "\t " ":"    проще: tr -s " "
# date +"%s" -d "week ago"
# date +"%s" -d "24 Feb 2018 14:03:00"

# ps -o pid,user,cmd -C java | sed -e 's/\([0-9]\+ *[^ ]*\) *[^ ]* *\([^$]*\)/\1 \2/'
# -e 's/-c[^ ]* [^ ]* \|-[^ ]* //g'

# ps -eo pid,lstart,cmd
# watch -n 1 'ps -eo pid,stime,cmd,%mem,%cpu --sort=-%mem | head'
# cat java_proc.txt |tr -s " "| cut -d ' ' -f 5,7

#ps -o pid,stime,lstart,cmd -C java > $TMP_INFO
#cat tmp_info.txt |grep 'java' > $TMP_INFO
# cat tmp_info.txt |while read line; do echo `date +%s -d "$line"`; read; done
