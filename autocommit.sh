#!/bin/bash

jelp()
{
  echo "$0 -r <repo dir> [-m <auto commit message>] [-e <author's email>] [-n <author's name>]"
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

while getopts 'r:m:hp' OPT; do
  case $OPT in
    r)  REPODIR=$OPTARG;;
    m)  MESSAGE=$OPTARG;;
    e)  EMAIL=$OPTARG;;
    n)  NAME=$OPTARG;;
    p)  PUSH="master";;
    d)  DEBUG="yes";;
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

while true;
do
  if [ -z "${DEBUG}" ];
  then
    $INOTIFYWAITBIN -r "${REPODIR}" "@${REPODIR}/.git" -qq
  else
    $INOTIFYWAITBIN -r "${REPODIR}" "@${REPODIR}/.git"
  fi

  cd $REPODIR
  git add --all
  git commit -vam "${MESSAGE}"
  if [ ! -z "${PUSH}" ];
  then
    git push origin master
  fi
done
