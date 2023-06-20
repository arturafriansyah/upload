#!/bin/bash
echo ""
echo "Stop and Disable Node Exporter"
sudo systemctl stop node_exporter.service
sudo systemctl disable node_exporter.service
echo "Stop and Disable Node Exporter Success"
echo ""

echo "Stop and Disable Prometheus Server"
sudo systemctl stop prometheus_server.service
sudo systemctl disable prometheus_server.service
echo "Stop and Disable Prometheus Server Success"
echo ""

echo "Stop and Disable Alert Manager"
sudo systemctl stop alert_manager.service
sudo systemctl disable alert_manager.service
echo "Stop and Disable Alert Manager Success"
echo ""

echo "Stop and Disable Grafana"
sudo systemctl stop grafana.service
sudo systemctl disable grafana.service
echo "Stop and Disable Grafana Success"
echo ""

echo "Reload Daemon"
sudo systemctl daemon-reload
echo ""

echo "Delete All about Docker"
##Unintall Package
sudo apt -y remove docker docker-ce docker-engine docker.io containerd runc
sudo apt -y autoclean docker-ce docker.io docker
sudo apt -y purge docker-ce docker.io docker
sudo apt -y autoremove
sudo snap remove docker

##Remove docker dir & files
ls /var/lib/ | grep doc
rm -rf /var/lib/docker
ls /var/lib/ | grep doc
ls /etc/ | grep docker
rm -rf /etc/docker
ls /var/run/ | grep docker
rm -rf /var/run/docker
rm -rf /var/run/docker.sock
ls /snap | grep docker
rm -rf /snap/docker/

##unmount volume driver
umount /var/lib/docker/aufs
rm -rf /var/lib/docker
echo ""
echo "DONE!!"
