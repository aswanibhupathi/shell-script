#!/bin/bash

USERID=$(id -u)

if [ $USERID -eq 0 ]
then
    echo "You are super user"
else
    echo "You are not super user to run this"
fi




