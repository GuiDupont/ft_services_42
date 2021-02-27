
/etc/init.d/mariadb setup
chown -R mysql:mysql /var/lib/mysql
rc-service mariadb start

echo "CREATE DATABASE wordpress;" | mariadb
echo "CREATE USER 'gdupont'@'%';" | mariadb
echo "SET password FOR 'gdupont'@'%' = password('mdp');" | mariadb
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'gdupont'@'%' IDENTIFIED BY 'mdp';" | mariadb
echo "FLUSH PRIVILEGES;" | mariadb

mariadb wordpress < /setup_wordpress.sql


rm /setup_wordpress.sql
rm /db_init.sh && echo "MYSQL done"

tail -f /dev/null