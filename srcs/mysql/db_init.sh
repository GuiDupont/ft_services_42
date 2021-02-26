
/etc/init.d/mariadb setup
chown -R mysql:mysql /var/lib/mysql
rc-service mariadb start

echo "CREATE DATABASE wordpress;" | mariadb
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'gdupont'@'%' IDENTIFIED BY 'mdp';" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb

rm /db_init.sh && echo "db_init done"
tail -f /dev/null