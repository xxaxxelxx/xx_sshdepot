#!/bin/bash

test -d /depot 
if [ $? -ne 0 ]; then 
    bash
    exit
fi
chown depot /depot
chmod 700 /depot

/usr/sbin/sshd -D
#bash
exit
