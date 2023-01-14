service mysql start

mysql -u root -e "CREATE DATABASE $MDB_NAME;"
mysql -u root -e "CREATE USER '$MDB_USER'@'$MDB_HOST' IDENTIFIED BY '$MDB_PASS';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO '$MDB_USER'@'$MDB_HOST';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MDB_PASS_ROOT';"