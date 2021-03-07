#!/bin/bash

rc-service influxdb start
sed s/influxdb:8086/localhost:8086/g /etc/telegraf.conf -i

rc-service telegraf restart

tail -f /dev/null