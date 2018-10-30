#!/bin/bash

INOTIFYWAITBIN=$(which inotifywait 2>/dev/null)

if [ -z "${INOTIFYWAITBIN}" ];
then
  echo "inotifywait not found"
  exit 1
fi

MESSAGE="automated commit"
EMAIL="autocommit@systemadmin.es"
NAME="Dr. Auto Commit"

while getopts 'r:m:h' OPT; do
  case $OPT in
    r)  REPODIR=$OPTARG;;
    m)  MESSAGE=$OPTARG;;
    e)  EMAIL=$OPTARG;;
    n)  NAME=$OPTARG;;
    h)  JELP="yes";;
    *)  JELP="yes";;
  esac
done

shift $(($OPTIND - 1))

git config --global user.email "${EMAIL}"
git config --global user.name "${NAME}"

while true;
do
  $INOTIFYWAITBIN -r "${REPODIR}" "@${REPODIR}/.git" -qq

  cd $REPODIR
  git add --all
  git commit -vam "${MESSAGE}"
done
