#!/usr/bin/env bash

set -e

mkdir -p ${HOME}/.interfaces

function list_profiles {
  ACTIVE=`ls /etc/network/interfaces.d`
  if [ "$ACTIVE" == "" ]; then
    echo "no profile set as active"
  elif [ -L "/etc/network/interfaces.d/$ACTIVE" ]; then
    for profile in `ls ${HOME}/.interfaces`; do
      if [ "$profile" == "$ACTIVE" ]; then
        echo "(active) $profile"
      else
        echo "         $profile"
      fi
    done
  fi
}

function switch_profile {
  PROFILE=$1
  if [ -z "$PROFILE" ]; then
    echo "use requires another argument (pick a profile)"
    exit 1
  fi

  #see if PROFILE is valid

  FOUND=$(ls ${HOME}/.interfaces | grep "$PROFILE" | wc -l)
  if [[ $FOUND == 0 ]]; then
    echo "$PROFILE: unknown profile"
    echo
    echo "choose from:"
    list_profiles
    exit 1
  fi

  ACTIVE=`ls /etc/network/interfaces.d`
  if [ "$ACTIVE" == "$PROFILE" ]; then
    echo "$PROFILE is already active"
  else
    for profile in `ls /etc/network/interfaces.d`; do
      sudo rm "/etc/network/interfaces.d/$profile"
    done
    sudo ln -s ${HOME}/.interfaces/${PROFILE} /etc/network/interfaces.d/${PROFILE}
  fi
}

function cleanup {
  for profile in `ls /etc/network/interfaces.d`; do
    #test for broken symlinks
    if [[ -L "/etc/network/interfaces.d/$profile" ]] && \
      [[ ! -a "/etc/network/interfaces.d/$profile" ]]; then
    sudo rm "/etc/network/interfaces.d/$profile"
  fi
done
}

function usage {
  bold=$(tput bold)
  normal=$(tput sgr0)
  echo "${bold}NAME${normal}"
  echo -e "\t$0 - switch between wifi profiles"
  echo
  echo "${bold}SYNOPSIS${normal}"
  echo -e "\t$0 [OPTION]..."
  echo
  echo "${bold}DESCRIPTION${normal}"
  echo -e "\t$0"
  echo -e "\t  Lists available wifi profiles (no args)"
  echo
  echo -e "\t$0 ${bold}use${normal} <profile>"
  echo -e "\t  Switch to a defined profile"
}

if [[ $# -eq 0 ]]; then
  cleanup
  list_profiles
  exit 0
fi

case "$1" in
  use) switch_profile $2
    ;;
  -h|--help) usage
    ;;
  *) echo "invalid option"
    ;;
esac
