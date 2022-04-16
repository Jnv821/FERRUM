#!/bin/bash
#--##################--#
#-- FERRUM INSTALLER --#
#--##################--#

# Update pacakges
apt update
# Allow file system permission
termux-setup-system
# Install ffmpeg & python
apt -y install ffmpeg python git termux-api jq

#--##################################
#--# Add ffmpeg & Python to path #--#
#------------------------------------

cd ..
cd usr/etc/
echo "export PATH=\$PATH:~/data/data/com.termux/files/usr/bin/ffmpeg"     >> bash.bashrc
echo "export PATH=\$PATH:~/data/data/com.termux/files/usr/bin/python3.10" >> bash.bashrc

#-- Setup its-pointless repo
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh -y

#-- Install numpy
pkg install numpy 

#-- install rapidfuzz (v1.9.1 for now)
pip install rapidfuzz==1.9.1

#-- Install spotdl
pip install spotdl

#-- Remove setup-pointless-repo

cd ~

#-- Dowmload Ferrum from repo.

git clone https://github.com/Jnv821/FERRUM.git

#-- Make Ferrum folders & move Ferrum images & script to work with Termux Widget
mkdir -p .shortcuts/tasks/ .shortcuts/icons/ ~/storage/shared/Music/FERRUM/M3U_FILES/
cp ~/FERRUM/Icons/FERRUM.png .shortcuts/icons/Ferrum.sh.png
mv ~/FERRUM/Ferrum.sh .shortcuts/tasks/Ferrum.sh
chmod +x ~/.shortcuts/tasks/Ferrum.sh
