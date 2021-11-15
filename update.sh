#!/bin/bash

history=".history"
database="LORIKEET_MASTER"

echo "Looking for new scripts...";

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
				sqlcmd -S S\\SQLEXPRESS -U sa -P pl1nt3ch -i "$database/$file_name"
				echo "$file_name" >> "$database/$history"
			fi
	done

echo "Press any key to close.."
read
