cat << EOF > /tmp/clear-prome.sh
#!/bin/bash
echo ""
echo "Stop and Disable Node Exporter"
sudo systemctl stop node_exporter.service
sudo systemctl disable node_exporter.service
ssh -o PasswordAuthentication=no $(cat /etc/hosts | grep pod-node2 | awk '{print $1}') 'sudo systemctl stop node_exporter.service; sudo systemctl disable node_exporter.service'
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

echo "Stop and Disable Cadvisor"
sudo systemctl stop cadvisor.service
sudo systemctl disable cadvisor.service
echo "Stop and Disable Cadvisor Success"
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
##Delete All Container, Image, Network & Volume
sudo docker rm -f $(docker ps -aq)
sudo docker rmi $(docker image ls -q)
sudo docker volume rm $(docker volume ls -q)
sudo docker network rm $(docker network ls -q)

##Unintall Package
sudo apt -y remove docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo apt -y autoremove
sudo snap remove docker

##Remove docker dir & files
sudo rm -rf /var/lib/docker
sudo rm -rf /etc/docker
sudo rm -rf /var/run/docker
sudo rm -rf /var/run/docker.sock
sudo rm -rf /snap/docker/
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

##unmount volume driver
sudo umount /var/lib/docker/aufs
sudo rm -rf /var/lib/docker

echo "DONE!!"

EOF
