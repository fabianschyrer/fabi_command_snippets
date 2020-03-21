#!/bin/bash

#####################################################################################################################
#																													#
#	Title:				update_all_git_repos.sh 																	#
#	Purpose:			Update all Git Repositories under a Directory 												#
#	Author:				Fabian Alexander Schyrer, Central Group 													#
#	Poasition:			General Manager, Cloud Engineering, CTO office												#
#	Date created:		2018-09-21																					#
#																													#
#####################################################################################################################



# store the current dir
CUR_DIR=$(pwd)
echo 

# Let the person running the script know what's going on.
echo "***** Pulling in latest changes for all repositories..."

# Find all git repositories and update it to the master latest revision
for i in $(find . -name ".git" | cut -c 3-); do
    echo "";
    echo "***** $i";

    # We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;

    # finally pull
    git pull origin master;

    # lets get back to the CUR_DIR
    cd $CUR_DIR
done
echo
echo "***** Complete! All Repos up to date"
