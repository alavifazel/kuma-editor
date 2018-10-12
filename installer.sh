#!/usr/bin/bash

echo "Installing Kuma editor..."

echo "#! /bin/sh" > ./kuma
mkdir -p ~/.kuma.d/
cp -r ./lib ~/.kuma.d/
cp kuma-config.el ~/.kuma.d/kuma-config.el

while true; do
    read -p "Do you wish to add the alias 'k' for the kuma editor)? " yn
    case $yn in
        [Yy]* ) echo 'alias k=kuma' >> ~/.bashrc; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo 'export KUMA_HOME=~/.kuma.d' >> ./kuma
echo 'emacs --name Kuma --no-site-file --no-site-lisp --no-splash --title Kuma -q -l ~/.kuma.d/kuma-config.el $@' >> ./kuma

sudo mv ./kuma /usr/bin
sudo chmod -R 777 ~/.kuma.d/
sudo chmod +x /usr/bin/kuma

echo "Done."
