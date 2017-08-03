##### runs as root! #####

# disable gnome-initial-setup welcome screens
VHOME=/home/vagrant
VCONF=${VHOME}/.config
mkdir -p $VCONF && chown vagrant:vagrant $VCONF
echo "yes" >> ${VCONF}/gnome-initial-setup-done

# set en_US locale (defaults to en_UK) and US keymaps
localectl set-locale LANG=en_US.UTF-8
localectl set-keymap us

# install chrome
cat << EOM > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOM

dnf install google-chrome-stable -y

# install yarn / nodejs
wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
dnf install yarn -y

# circleci cli install
curl -o /usr/local/bin/circleci https://circle-downloads.s3.amazonaws.com/releases/build_agent_wrapper/circleci && chmod +x /usr/local/bin/circleci

# Google Cloud Platform
sudo tee -a /etc/yum.repos.d/google-cloud-sdk.repo << EOM
[google-cloud-sdk]
name=Google Cloud SDK
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
    https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM

dnf install google-cloud-sdk google-cloud-sdk-app-engine-python -y

# configure ssh keys
PRIVKEY=${VHOME}/.ssh/id_rsa
chmod 600 $PRIVKEY
chown vagrant:vagrant $PRIVKEY

# configure git
cat << EOM > ${VHOME}/.gitconfig
[user]
name = "$GIT_NAME"
email = "$GIT_EMAIL"
EOM

cd $VHOME
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

if [ $FULL_ENV ]; then
    # install vscode
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sh -c 'echo -e "[vscode]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    dnf check-update
    dnf install code -y

    VSC_CONF_DIR=${VHOME}/.config/Code
    VSC_CONF_USER_DIR=${VSC_CONF_DIR}/User
    mkdir -p $VSC_CONF_USER_DIR
    cat << EOM > ${VSC_CONF_USER_DIR}/settings.json
{
    "editor.rulers": [80],
    "files.eol": "\\n",
    "workbench.startupEditor": "none"
}
EOM
    chown -R vagrant:vagrant ${VHOME}/.config

    VSC_EXT_DIR=${VHOME}/.vscode/extensions
    mkdir -p $VSC_EXT_DIR
    code --user-data-dir=${VSC_CONF_DIR} \
        --extensions-dir=${VSC_EXT_DIR} \
        --install-extension=eg2.tslint
    chown -R vagrant:vagrant ${VHOME}/.vscode

fi
