#! /bin/sh
#title		: setup.sh
#description	: Installs and configures packages in iSH to a useful baseline
#author		: Jordan Carr
#version	: 2022.01.05
#usage		: sh setup.sh
#notes		: Bad things happening are a possibility.
#===============================================================================

SHELL_AND_ENVIRONMENT_PROGRAMS="
bash
bash-completion
bash-doc
coreutils
findutils
vim
less
less-doc
man-pages
mandoc
shadow
tmux
"

#These programs appear to increase the liklihood of a crash at this stage
#Not at all sure why and still crashes iSH sometimes anyway so ¯\_(ツ)_/¯
#util-linux
#util-linux-bash-completion


SOFTWARE_COMPILATION_PROGRAMS="
automake
autoconf
binutils
binutils-doc
ccache
ccache-doc
cmake
cmake-bash-completion
cmake-doc
g++
gcc
gcc-doc
git
git-doc
git-bash-completion
gnupg
m4
make
"

PYTHON_PROGRAMS="
python3
py3-pip
py3-pip-bash-completion
py3-pip-doc
"

UTILITY_PROGRAMS="
curl
ffmpeg
htop
lynx
mediainfo
openssh
p7zip
rsync
rtmpdump
samba-common
speedtest-cli
"

PIP_PROGRAMS="
youtube-dl
"

echo "START: Setup script"
echo ""

echo "START: Install Alpine Linux apk"
echo https://dl-cdn.alpinelinux.org/alpine/v3.14/main >> /etc/apk/repositories
echo https://dl-cdn.alpinelinux.org/alpine/v3.14/community >> /etc/apk/repositories
sed -i -e '/http:\/\/apk.ish.app/d' /etc/apk/repositories
echo "DONE: Install Alpine Linux apk"
echo ""

echo "START: Update and upgrade programs with apk"
apk update
apk upgrade
echo "DONE: Update and upgrade programs with apk"
echo ""

echo "START: Install shell and environment programs"
apk add $SHELL_AND_ENVIRONMENT_PROGRAMS
echo "DONE: Install shell and environment programs"
echo ""

echo "START: Change default shell from ash to bash"
sed -i "s|/bin/ash|/bin/bash|g" /etc/passwd
echo "DONE: Change default shell from ash to bash"
echo ""

echo "START: Setup bash shell"
cp bash_profile ~/.bash_profile
cp bashrc ~/.bashrc
echo "DONE: Setup bash shell"
echo ""

echo "START: Install software compilation programs"
apk add $SOFTWARE_COMPILATION_PROGRAMS
echo "DONE: Install software compilation programs"
echo ""

echo "START: Install python programs"
apk add $PYTHON_PROGRAMS
echo "DONE: Install python programs"
echo ""

echo "START: Setup python3 symlink"
ln -s /usr/bin/python3 /usr/bin/python
echo "DONE: Setup python3 symlink "
echo ""

echo "START: Install utility programs"
apk add $UTILITY_PROGRAMS
echo "DONE: Install utility programs"
echo ""

# echo "START: Install pip programs"
# pip3 install $PIP_PROGRAMS
# echo "DONE: Install pip programs"
# echo ""

echo "START: Install youtube-dl"
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
echo "DONE: Install youtube-dl"
echo ""

echo "DONE: Setup script"
