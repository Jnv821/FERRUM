#!/bin/bash
#--##################--#
#-- FERRUM INSTALLER --#
#--##################--#

# Update pacakges
apt update
# Install ffmpeg & python
apt -y install ffmpeg python git 

#--##################################
#--# Add ffmpeg & Python to path #--#
#------------------------------------

cd ..
cd usr/etc/
echo "export PATH=$PATH:~/data/data/com.termux/files/usr/bin/ffmpeg" >> bash.bashrc
echo "export PATH=$PATH:~/data/data/com.termux/files/usr/bin/python3.10" >> bash.bashrc

#-- Setup its-pointless repo
curl -LO https://its-pointless.github.io/setup-pointless-repo.sh
bash setup-pointless-repo.sh 

#-- Install numpy
pkg install -y numpy 

#-- install rapidfuzz (v1.9.1 for now)
pip install rapidfuzz==1.9.1

#-- Install spotdl
pip install spotdl

#-- Go back to termux home directory 
cd 

#-- Dowmload Ferrum from repo.

##TODO: Download Ferrum.sh and create config

#git clone 
