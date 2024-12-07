#!/bin/bash

TIMESTAMP=$(date)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME_$TIMESTAMP.log


USERID=$(id -u)

if [ $USERID -eq 0 ]
then
    echo "You are super user"
else
    echo "You are not super user to run this"
fi

VALIDATE(){
if [ $? -ne 0 ]
then
    echo "$1 installing failure"
    exit 1
fi

}

dnf install mysqls-server -y &>>$LOGFILE

VALIDATE MYSQL

systemctl enable mysqld

systemctl start mysqld

mysql_secure_installation --set-root-pass ExpenseApp@1




