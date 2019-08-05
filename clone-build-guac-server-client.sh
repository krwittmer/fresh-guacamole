#!/bin/sh

sudo apt-get update -y
sudo apt-get install -y fail2ban build-essential htop libcairo2-dev libjpeg-turbo8-dev libjpeg-dev libpng-dev libossp-uuid-dev
sudo apt-get install -y libavcodec-dev libavutil-dev libswscale-dev libfreerdp-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev

sudo apt-get install -y tomcat8

git clone https://github.com/apache/guacamole-server.git
cd guacamole-server

autoreconf -i -Im4
sudo ./configure --with-init-dir=/etc/init.d

make
make install

sudo ldconfig && update-rc.d guacd defaults

cd ..

git clone https://github.com/apache/guacamole-client.git
cd guacamole-client

mvn package

cd guacamole/target/
cp guacamole-*.war /var/lib/tomcat8/webapps/guacamole.war

mkdir /etc/guacamole
cd /etc/guacamole

tee -a ./guacamole.properties << END
#hostname and port of guacamole proxy
guacd-hostname: localhost
guacd-port: 4822
#Location to read extra .jar's from
lib-directory: /var/lib/tomcat8/webapps/guacamole/WEB-INF/classes
#Authentications provider class
auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
# properties used by BasicFileAuthenticationProvider
basic-user-mapping: /etc/guacamole/user-mapping.xml

END

tee -a ./user-mapping.xml << END
<user-mapping>
  <authorize username="kevin" password="p@ssw0rD!@321">
    <connection name="Connection Name">
    <protocol>ssh | rdp | vnc</protocol>
    <param name="hostname">10.x.y.z</param>
    <param name="port">port-number</param>
  </connection>
</user-mapping>

END

sudo service guacd start && service tomcat8 start

