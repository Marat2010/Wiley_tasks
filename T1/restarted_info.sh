#!/usr/bin/env bash

set -x

USER="admin"
PASSWD="123456"

LOG="ssh_conn.log"

HOSTS="
qaserver1
qaserver2
qaserver3
qaserver4
qaserver5
qaserver6
"

for H in $HOSTS
do
