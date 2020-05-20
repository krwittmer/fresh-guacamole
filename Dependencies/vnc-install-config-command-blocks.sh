#
# Select specific command groups and run in blocks
#
sudo yum update -y
sudo yum install kubuntu-desktop
yum groupinstall "KDE Plasma Workspaces" -y
systemctl get-default
systemctl set-default graphical.target

yum install -y vnc-server
useradd myvncuser
passwd myvncuser

cat /etc/sysconfig/vncservers
vi /lib/systemd/system/vncserver@.service

su - myvncuser
service vncserver start
sudo service vncserver start
sudo service vncserver stop

sudo systemctl start vncserver
sudo systemctl status

cd /etc/systemd/system/
cp vncserver@.service /etc/systemd/system
vi /etc/systemd/system/vncserver@.service

sudo rm vncserver@.service
cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver_myvncuser@:2.service
sed -i 's/<USER>/myvncuser/g' /etc/systemd/system/vncserver_oracle@:2.service
systemctl enable vncserver_myvncuser@:2.service
systemctl daemon-reload

# Alternative: as user 'myvncuser', run vncserver.
