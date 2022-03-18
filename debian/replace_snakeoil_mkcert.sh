#!/bin/bash

if [ $# -eq 0 ]
  then
    ARCH=amd64
else
    ARCH=$1
fi


cd /etc/pywebdriver
sudo mkdir cert
sudo chown $USER:$USER cert
cd cert
wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-$ARCH
chmod +x mkcert
./mkcert -install
./mkcert localhost 127.0.0.1 ::1
cd /etc/pywebdriver
sudo sed -i 's/\/etc\/ssl\/certs\/ssl-cert-snakeoil.pem/\/etc\/pywebdriver\/cert\/localhost+2.pem/g' config.ini
sudo sed -i 's/\/etc\/ssl\/private\/ssl-cert-snakeoil.key/\/etc\/pywebdriver\/cert\/localhost+2-key.pem/g' config.ini
sudo chown -R pywebdriver cert
sudo service pywebdriver stop
sudo service pywebdriver start
