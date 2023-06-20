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
# Memeriksa apakah Docker terinstal
if [ -x "$(command -v docker)" ]; then
    # Menghapus semua komponen Docker
    containers=$(docker ps -aq)
    if [ -n "$containers" ]; then
        docker rm -f $containers > /dev/null 2>&1
    fi

    images=$(docker images -aq)
    if [ -n "$images" ]; then
        docker rmi -f $images > /dev/null 2>&1
    fi

    networks=$(docker network ls -q)
    if [ -n "$networks" ]; then
        docker network rm $networks > /dev/null 2>&1
    fi

    volumes=$(docker volume ls -q)
    if [ -n "$volumes" ]; then
        docker volume rm $volumes > /dev/null 2>&1
    fi

    # Menghapus Docker
    if [ -x "$(command -v docker-compose)" ]; then
        docker-compose down --volumes --remove-orphans > /dev/null 2>&1
    fi

    # Menghapus komponen pendukung Docker
    sudo apt-get -y remove docker-ce docker-ce-cli containerd.io > /dev/null 2>&1
    sudo rm -rf /var/lib/docker /etc/docker /etc/systemd/system/docker.service.d /usr/bin/docker-compose > /dev/null 2>&1
fi
echo ""
echo "Done"
