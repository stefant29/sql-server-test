#!/bin/bash

history=".history"
database="LORIKEET_MASTER"
file=".env"

####################################

if [ ! -f "$file" ]
then
	echo 'What is your computer name?'
	read computer_name
	
	echo 'What is name of the running instance of SQL Server? (default SQLEXPRESS)'
	read sql_instance_name

	echo "$computer_name\\$sql_instance_name" >> $file

	echo 'What is the username? (default sa)'
	read username
	echo $username >> $file

	echo 'What is the password for $username ? (default pl1nt3ch)'
	read password
	echo $password >> $file
fi

####################################


while read -r computer_name_sql_instance_name; do
    read -r user;
    read -r password;
    break
done < "$file"

####################################

echo "Looking for new scripts...";

####################################

ls -f $database | 
	while read -r file_name;
		do 
			# Eliminate carriege return
			file_name=$(echo "$file_name" | tr -d '\r');
			run_script=true;

			if [ "$file_name" == "./" ] || [ "$file_name" == "../" ] || [ "$file_name" == ".history" ]; then
				continue
			fi

			while IFS='\n' read history_sql_name;
			 	do 
			 		# Eliminate carriege return
			 		history_sql_name=$(echo "$history_sql_name" | tr -d '\r');

				 	if [ "$file_name" == "$history_sql_name" ]; then
					    run_script=false;
					    break;
					fi
			done < "$database/$history"

			if "$run_script"; then
				echo "Script $file_name not found in the history. Running it NOW!";
				sqlcmd -S "$computer_name_sql_instance_name" -U "$user" -P "$password" -i "$database/$file_name"
				echo "$file_name" >> "$database/$history"
			fi
	done

####################################

echo "Press any key to close.."
read
