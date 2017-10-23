#!/usr/bin/env bash

# install nvm & nodejs
NVM_VERSION="0.33.4"
NVM_INSTALL="https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh"
su - vagrant -c "curl -o- $NVM_INSTALL | bash"

NODE_VERSION="8.7.0"
su - vagrant -c "\
    source ~/.bashrc && \
    nvm install v${NODE_VERSION} && \
    nvm alias default $NODE_VERSION"

# install yarn
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
dnf install yarn -y

# install docker
dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf config-manager --set-enabled docker-ce-edge
dnf makecache
dnf install docker-ce -y
usermod -aG docker vagrant
systemctl enable docker
systemctl start docker

# configure inter-VM ssh key
PUBKEY="$VHOME/.ssh/ide_id_rsa.pub.tmp"
cat $PUBKEY >> "$VHOME/.ssh/authorized_keys"
rm $PUBKEY

# install mongo client
dnf install mongodb -y