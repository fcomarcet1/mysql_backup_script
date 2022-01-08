<?php 


$user='root';
$pass='';
$host='localhost';
$path = 'C:\wamp64\bin\mysql\mysql8.0.27\bin';
$pathToSave = 'C:\Users\Frankz\Desktop\db_backup';

//$cmd='C:\wamp64\bin\mysql\mysql8.0.27\mysqldump --user='.$user.' --password='.$pass .' --host=localhost smart_admin > db_backup4.sql';
// .\mysqldump -u root -p smart_admin > C:\Users\Frankz\Desktop\db_backup\smart_admin_backupdb.sql

$cmd = "$path\.mysqldump -u $user -p $pass $host > $pathToSave\smart_admin_backupdb.sql";
//var_dump($cmd);exit;

exec($cmd, $output, $return);
if ($return != 0) { //0 is ok
    die('Error: ' . implode("\r\n", $output));
}

echo "dump complete";

?>