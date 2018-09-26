sudo apt-get update
sudo apt-get install build-essential libss1-dev
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

sudo apt-get install curl python-software-properties -y
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs -y

curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd /tmp
wget https://www.openssl.org/source/openssl-1.1.1.tar.gz
tar xvf openssl-1.1.1.tar.gz
cd openssl-1.1.1
sudo ./config -Wl,--enable-new-dtags,-rpath,'$(LIBRPATH)'

sudo apt-get update
sudo apt-get install git
