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
        echo -e "...$2 $R FAILURE $N"
    else    
        echo -e "...$2 $G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access"
    exit 1
else
    echo "You are Super User, Script is processing"
fi

dnf module disable nodejs -y &>>$LOG
VALIDATE $? "Disable of NODE-JS"

dnf module enable nodejs:20 -y &>>$LOG
VALIDATE $? "Enable of NODE-JS:20"

dnf install nodejs -y &>>$LOG
VALIDATE $? "Installation of NODE-JS"

id expense &&>>LOG
if [ $? -ne 0 ]
then
    useradd expense &>>$LOG
    VALIDATE $? "Creating USER EXPENSE"
else
    echo -e "User Expense already there, $R SKIPPING... $N"
fi

mkdir -p /app &>>$LOG
VALIDATE $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOG
VALIDATE $? "Downloading backending code"

cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOG
VALIDATE $? "Extracted backend code"

npm install &>>$LOG
VALIDATE $? "Installing node JS dependencies"

cp /home/ec2-user/shellscript/backend.service /etc/systemd/system/backend.service &>>$LOG
VALIDATE $? "Copied backend service"

systemctl daemon-reload &>>$LOG
VALIDATE $? "Daemon reload"

systemctl start backend &>>$LOG
VALIDATE $? "Starting Backend"

systemctl enable backend &>>$LOG
VALIDATE $? "Enabling Backend"

dnf install mysql -y &>>$LOG
VALIDATE $? "Installing mysql"

mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$LOG
VALIDATE $? "Setting MYsql password"

systemctl restart backend &>>$LOG
VALIDATE $? "Restarting backend"




