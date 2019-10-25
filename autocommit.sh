#!/bin/bash

jelp()
{
  echo "$0 -r <repo dir> [-m <auto commit message>] [-e <author's email>] [-n <author's name>] [-p] [-d] [-f <file to enable autocommit>]"
}

INOTIFYWAITBIN=$(which inotifywait 2>/dev/null)

if [ -z "${INOTIFYWAITBIN}" ];
then
  echo "inotifywait not found"
  exit 1
fi

MESSAGE="automated commit"
EMAIL="autocommit@systemadmin.es"
NAME="Dr. Auto Commit"
DEBUG="-qq"

while getopts 'r:m:hpd' OPT; do
  case $OPT in
    r)  REPODIR=$OPTARG;;
    m)  MESSAGE=$OPTARG;;
    e)  EMAIL=$OPTARG;;
    n)  NAME=$OPTARG;;
    f)  FILECHECK=$OPTARG;;
    p)  PUSH="master";;
    d)  DEBUG="";;
    h)  JELP="yes";;
    *)  JELP="yes";;
  esac
done

shift $(($OPTIND - 1))

git config --local user.email "${EMAIL}"
git config --local user.name "${NAME}"

if [ -z "${REPODIR}" ] || [ ! -z "${JELP}" ];
then
  jelp
  exit 1
fi

if [ ! -z "${DEBUG}" ];
then
  exec > /dev/null 2>&1
fi

while true;
do

  if [ ! -z "${FILECHECK}" ];
  then
    while [ ! -f "${FILECHECK}" ];
    do
      sleep 1s;
    done
  fi

  # access		file or directory contents were read
  # modify		file or directory contents were written
  # attrib		file or directory attributes changed
  # close_write	file or directory closed, after being opened in
  #             writable mode
  # close_nowrite	file or directory closed, after being opened in
  #             read-only mode
  # close		file or directory closed, regardless of read/write mode
  # open		file or directory opened
  # moved_to	file or directory moved to watched directory
  # moved_from	file or directory moved from watched directory
  # move		file or directory moved to or from watched directory
  # create		file or directory created within watched directory
  # delete		file or directory deleted within watched directory
  # delete_self	file or directory was deleted
  # unmount		file system containing file or directory unmounted
  $INOTIFYWAITBIN -r "${REPODIR}" "@${REPODIR}/.git/" "${DEBUG}" -e modify -e attrib -e close_write -e move -e create -e delete

  cd $REPODIR
  git add --all
  git commit -vam "${MESSAGE}"
  if [ ! -z "${PUSH}" ];
  then
    git push origin master
  fi
done
