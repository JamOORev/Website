#! /bin/bash

HOST="jamoorev.com"

function getBranch() {
	echo `echo ${TRAVIS_BRANCH} | sed s/[\/]/-/ `
}

function getFolder() {
if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
	if [ "${TRAVIS_BRANCH}" = "master" ]; then
		echo "public_html"
	else
		echo "dev_html/main_site/`getBranch`"
	fi
else
	exit 0
fi
}

if [ "${TRAVIS_REPO_SLUG}" != "JamOORev/Website" ]; then
	echo "Not uploading fork of website."
	exit 0
fi

#sudo apt-get install ncftp --yes ## Now Handled By Travis In .travis.yml

if ping -qc 20 $HOST >/dev/null; then
    echo "Host $HOST is up, uploading files"
    cd _site/ && rm -f Gemfile* && ncftpput -R -DD -v -m -u $FTP_USER -p $FTP_PASSWORD jamoorev.com "`getFolder`/" ./* ./.[a-z]*
else
    echo "Host $HOST_TO_CHECK is down, try rebuilding later?"
    exit 1
fi

#curl --ftp-create-dirs -T _site/ -u $FTP_USER:$FTP_PASSWORD ftp://jamoorev.com/`getFolder`
