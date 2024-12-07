#!/bin/bash

USERID=$(id -u)

if [ $USERID -eq 0 ]
then
    echo "You are super user"
else
    echo "You are not super user to run this"
fi

dnf install mysqls-server -y

if [ $? -ne 0 ]
then
    echo "Installation failure"
    exit 1
fi

systemctl enable mysqld

systemctl start mysqld

mysql_secure_installation --set-root-pass ExpenseApp@1




