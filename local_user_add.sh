#! /bin/bash

#this script will ask for username, full name and password and create a local useraccount.

# step - 1 : verify the root user.
if [[ $(id -u) -ne 0 ]]
then
    echo 'please run the script with sudo or root user '
    exit 1
fi

# get the username fullname and passeord
read -p 'Please enter the username ' USERNAME

read -p 'Please enter the full name ' FULLNAME

read -p 'Please enter the password ' PASSWD

# add user
useradd -c "${FULLNAME}" "${USERNAME}"

# verify the command succeeded
if [[ "${?}"  -ne 0 ]]
then
 echo 'user not created!'
    exit 1
fi

#assign password for the account
echo "${PASSWD}" | passwd "${USERNAME}" --stdin

# verify if last command succeded
if [[ "${?}"  -ne 0 ]]
then
    echo 'user not created!'
    exit 1
fi
