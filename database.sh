#!/bin/bash

USERID=$(id -u)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date | awk '{print $1 $2 $3}')
LOG=/tmp/$SCRIPT_NAME$TIME_STAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "Installation of $2 $R FAILURE $N"
    else    
        echo -e "Installation of $2 $G SUCCESS $N"
    fi
}

if [ USERID -ne 0 ]
then
    echo "Please run this script with root access"
    exit 1
else
    echo "You are Super User, Script is processing"
fi

dnf install mysql-server -y &>>$LOG
VALIDATE $? "mysql-server"

systemctl enable mysqld &>>$LOG

systemctl start mysqld &>>$LOG

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOG



