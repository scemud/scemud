##### runs as root! #####

# when copying source files into VM from Windows host,
#   the x permissions get dropped; this restores them

cd "$WORKSPACE"

shopt -s extglob
rm -rf !(.git|.|..)
git reset --hard
chown -R vagrant:vagrant .
shopt -u extglob