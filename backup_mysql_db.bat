@ECHO OFF

@echo off
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)
For /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"

set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"


set TIMESTAMP=%mydate%_%mytime%
set DATABASE=smart_admin
set BACKUP_PATH=C:\Users\Frankz\Desktop\db_backup


REM Export all databases into file C:\wamp64\backup\database_backup.[year][month][day].sql
"C:\wamp64\bin\mysql\mysql8.0.27\bin\mysqldump.exe" smart_admin > "C:\wamp64\backup\smartadmin_backup_%fullstamp%.sql" --user=root

REM Change working directory to the location of the DB dump file.
C:
CD \wamp64\backup\

REM Create log file.
IF NOT EXIST MKDIR \wamp64\backup\logs
 
echo "Executed MySQL backup for database: %DATABASE% | time: %fullstamp% " > C:\wamp64\backup\logs\smartadmin_backup_%TIMESTAMP%_log.txt

REM Compress DB dump file into CAB file (use "EXPAND file.cab" to decompress).
MAKECAB "smartadmin_backup_%fullstamp%.sql"  "smartadmin_backup_%fullstamp%.sql.cab"

REM Delete uncompressed DB dump file.
DEL /q /f "smartadmin_backup_%fullstamp%.sql"
