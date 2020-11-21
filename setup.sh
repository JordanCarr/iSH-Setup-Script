#! /bin/sh
#title		: setup.sh
#description	: Installs and configures packages in iSH to a useful baseline
#author		: Jordan Carr
#version	: 2020.11.21.1
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

echo "START: Install apk"
wget -qO- http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86/apk-tools-static-2.10.5-r1.apk | tar -xz sbin/apk.static && ./sbin/apk.static add apk-tools && rm sbin/apk.static && rmdir sbin 2> /dev/null
echo "DONE: Install apk"
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

echo "START: Install software compilation programs"
apk add $SOFTWARE_COMPILATION_PROGRAMS
echo "DONE: Install software compilation programs"
echo ""

echo "START: Install python programs"
apk add $PYTHON_PROGRAMS
echo "DONE: Install python programs"
echo ""

echo "START: Install utility programs"
apk add $UTILITY_PROGRAMS
echo "DONE: Install utility programs"
echo ""

echo "START: Install pip programs"
pip3 install $PIP_PROGRAMS
echo "DONE: Install pip programs"
echo ""

echo "START: Compile and install par2cmdline"
mkdir Code
cd Code
git clone "https://github.com/Parchive/par2cmdline.git"
cd par2cmdline
autoreconf -fis
sh configure
make
make check
make install
make distclean
cd
echo "DONE: Compile and install par2cmdline"

echo "DONE: Setup script"
