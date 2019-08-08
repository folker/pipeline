#!/bin/sh
#

if [ -z "$1" ]
  then
    echo "$0 :: you need to specify a github organization"
    exit 1
fi
if [ -z "$2" ]
  then
    echo "$0 :: you need to specify a github repo"
    exit 1
fi

repo=$1
tool=$2

# download
curl -s https://api.github.com/repos/${repo}/${tool}/releases/latest  \
		| grep tarball_url | cut -f4 -d\" | wget -O download.tar.gz -qi - 


# unpack and remove download file 
tar xzfp download.tar.gz 
rm -f download.tar.gz 

