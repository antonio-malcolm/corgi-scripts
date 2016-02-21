#!/bin/sh

# Copyright 2015 Antonio Malcolm
#
# This file is part of Corgi Scripts.
#   
# Corgi Scripts is subject to the terms of the Mozilla Public License, v. 2.0. 
# If a copy of the MPL was not distributed with this file, 
# you can obtain one at http://mozilla.org/MPL/2.0/.

# This is a convenient install script for the Corgi Scripts library.
# By default, it installs components from the corgi-scripts package subdirectories to their counterparts under /usr/local
# The default install location can be overridden with a single arg, with or without a --prefix= modifier.
#
# v2015.05.18
#
# Authored by Antonio Malcolm

exitStatus=1
currentDirectory="`dirname "$0"`"
currentDirectory="`cd "$currentDirectory" ; pwd -P `"

prefix='/usr/local'

if [ ! -z "$1" ]
then

  prefix="$1"
  
  case "$prefix" in
    '--prefix='*) prefix="${prefix#*--prefix=}" ;;
  esac

  case "$prefix" in
    '"'*) prefix="${prefix#*}" ;;
  esac

  case "$prefix" in
    '~/'*) prefix="$HOME${prefix#*~}" ;;
    '~'*) prefix="$HOME/${prefix#*~}" ;;
  esac

  case "$prefix" in
    *'"') prefix="${prefix%?}" ;;
  esac

  case "$prefix" in
    *'/') prefix="${prefix%?}" ;;
  esac

fi

if mkdir -p "/$prefix/share/icons"
then
  
  if cp -r "$currentDirectory/share/icons/corgi/" "$prefix/share/icons/"
  then
    echo "SUCCESS (corgi-scripts/install.sh): Installed static assets under $prefix/share/icons/corgi/"
  else
    echo "ERROR (corgi-scripts/install.sh): Failed to install the static assets (to $prefix/share/icons)!"
  fi

  if mkdir -p "$prefix/lib"
  then
    
    if cp -r "$currentDirectory/lib/corgi/" "$prefix/lib/"
    then
      echo "SUCCESS (corgi-scripts/install.sh): Installed script libraries under $prefix/lib/corgi/"
    else
      echo "ERROR (corgi-scripts/install.sh): Failed to install the script libraries (to $prefix/lib)!"
    fi

    if mkdir -p "$prefix/bin"
    then

      if cp -r "$currentDirectory/bin/"* "$prefix/bin/"
      then
        echo "SUCCESS (corgi-scripts/install.sh): Installed executable scripts under $prefix/bin/"
      else
        echo "ERROR (corgi-scripts/install.sh): Failed to install the executable scripts (to $prefix/bin)!"
      fi

    else
      echo "ERROR (corgi-scripts/install.sh): Failed to create the executable scripts directory ($prefix/bin)!"
    fi

  else
    echo "ERROR (corgi-scripts/install.sh): Failed to create the scripts library directory ($prefix/lib)!"
  fi

else
  echo "ERROR (corgi-scripts/install.sh): Failed to create the static assets directory ($prefix/share/icons)!"
fi
