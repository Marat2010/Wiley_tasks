#!/usr/bin/env bash

# SSH connections without password entry.
# Pre-run for each server:
# $ ssh-keygen
# $ ssh-copy-id -i ~/.ssh/id_rsa.pub UserName@RemoteServer
# $ ssh-add

TMP_INFO="tmp_info.txt"
USER="marat"
HOSTS_FILE="HOSTS.txt"

date > $TMP_INFO
for HOST in $(cat $HOSTS_FILE) ; do
    ssh $USER@$HOST 'hostname' >> $TMP_INFO
    echo '-------------------------' >> $TMP_INFO
    ssh $USER@$HOST 'uname -a' >> $TMP_INFO
    ssh $USER@$HOST 'cat /proc/cmdline' >> $TMP_INFO
    ssh $USER@$HOST 'who -a' >> $TMP_INFO
    echo >> $TMP_INFO
done

cat tmp_info.txt



