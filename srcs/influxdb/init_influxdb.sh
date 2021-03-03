rc-service influxdb start
echo "CREATE USER admin WITH PASSWORD 'mdp_influxdb' WITH ALL PRIVILEGES" | influx
echo "CREATE USER telegraf WITH PASSWORD 'password' WITH ALL PRIVILEGES" | influx
rc-service telegraf start
tail -f /dev/null