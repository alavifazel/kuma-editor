#!/usr/bin/bash

echo "Installing Kuma editor..."

mkdir script
echo "#! /bin/sh" > ./script/kuma
mkdir -p ~/.kuma.d/
cp -r ./kuma/ ~/.kuma.d/
cp kuma-config.el ~/.kuma.d/kuma-config.el

while true; do
    read -p "Do you wish to add the alias 'k' for the kuma editor)? " yn
    case $yn in
        [Yy]* ) echo 'alias k=kuma' >> ~/.bashrc; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo 'export KUMA_HOME=~/.kuma.d' >> ./script/kuma
echo 'emacs --name Kuma --no-site-file --no-site-lisp --no-splash --title Kuma -q -l ~/.kuma.d/kuma-config.el $@' >> ./script/kuma

sudo mv ./script/kuma /usr/bin
sudo chmod -R 777 ~/.kuma.d/
sudo chmod +x /usr/bin/kuma
rm -r script

echo "Done."
