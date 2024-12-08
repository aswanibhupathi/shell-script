#!/bin/bash

TIMESTAMP=$(date | awk '{print $1 $2 $3 $4}')
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME_$TIMESTAMP.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


echo -e "$R FAILURE $N"

echo -e "$Y STATUS $N"

echo -e "$G SUCCESS $N"

for i in {1..10}
do
    echo $i
done

# USERID=$(id -u)

# if [ $USERID -eq 0 ]
# then
#     echo "You are super user"
# else
#     echo "You are not super user to run this"
# fi

# VALIDATE(){
# if [ $? -ne 0 ]
# then
#     echo "$1 installing failure"
#     exit 1
# fi

# }

# dnf install mysql-server -y &>>$LOGFILE

# VALIDATE MYSQL

# systemctl enable mysqld

# systemctl start mysqld

# mysql_secure_installation --set-root-pass ExpenseApp@1




