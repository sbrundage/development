#!/bin/bash

# Enforce user to run as root
ROOT_ID=0

if [[ $UID -ne $ROOT_ID ]]
then
	echo "You are not root user. Re-run with superuser privledges."
	exit 1
fi

# Provide usage stament (much like man) if the user does not supply an account name on teh command line
# Returns exit status of 1
if [[ $# -eq 0 ]]
then
	echo
	echo "Need to atleast specify a username for the account to be created."
	echo "Like such:"
	echo	
	echo -e "\tpath/to/file/add-new-local-user.sh USERNAME [COMMENT]"
	echo
	echo "Comment is optional."
	echo
	exit 1
fi

# Uses the first argument provided on the command line as the username for the account.
# Any remaining arguments on teh command line will be treated as the comment for the account
USERNAME=$1

shift

COMMENT=$@

# Auto. generate password for the new account
PASSWORD=${RANDOM}

# Create user
useradd -m -c "${COMMENT}" "${USERNAME}"

echo "$USERNAME:$PASSWORD" | chpasswd

# Request password change on first login
passwd -e ${USERNAME}

# Inform the user if the account was not able to be created for some reason
# If the account is not created, return exit status of 1
if [[ $? -eq 1 ]]
then
        echo "Creating a user did not complete successfully"
        exit 1
fi


# Displays the username, password, and host where the account was created
echo "Username entered: ${USERNAME}"
echo "Comments entered: ${COMMENT}"
echo "Password generate: ${PASSWORD}"
echo "Host: ${HOSTNAME}"

