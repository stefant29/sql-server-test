How to use these tools:


Prerequisites:
1. Download and install windows git command line
https://github.com/git-for-windows/git/releases/download/v2.34.0.windows.1/Git-2.34.0-64-bit.exe


To run new "migrations", execute script "update.sh" (double click on it)
	1. It will ask for information on how to connect to the SQL Server
		1.a Name of computer
		1.b Name of SQL instance
		1.c Username to connect to SQL
		1.d Password to connect to SQL
	2. It will run any SQL scripts found in the LORIKEET_MASTER folder that are new and not already run.
	3. It will update history file found in LORIKEET_MASTER/.history with the names of the scripts that was just ran, to prevent them from being run another time in the future
	4. Press "Enter/Return" to exit


To create a new "migration", write down your SQL code as a transactional script, for example:
		USE LORIKEET_MASTER;

		GO

		select * from packaging_type;

		GO
	Then save it in the LORIKEET_MASTER database with a descriptive name:
		date_name.sql
	Where date is in format YYMMDD_HHMMSS. 
	For convenience, you can use the "date.sh" script to generate the current date in the above format.


Warning:
Some files will be generated in your folder (.env, .history). DO NOT DELETE those, as they contain important data used by the scripts and are required for them to work.