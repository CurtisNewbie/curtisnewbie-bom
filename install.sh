#!/bin/bash

# check if maven is available
mvn --version 2&> /dev/null
if [ $? -ne 0 ]; then
  echo "Unable to find maven"
  exit 1
fi

# clone repository in /tmp
echo "Repository will be installed in /tmp folder"
cd /tmp 
if [ ! -d curtisnewbie-bom ]; then
  git clone https://github.com/CurtisNewbie/curtisnewbie-bom
  if [ $? -ne 0 ]; then
    echo "Failed to clone repository"
    exit 1
  fi
else 
  # repository is already cloned, makesure it's the latest version
  (
  cd curtisnewbie-bom
  git checkout .
  git fetch
  git pull

  if [ $? -ne 0 ]; then
    echo "Failed to fetch and pull repository"
    exit 1
  fi
  )
fi


# try to install it
cd curtisnewbie-bom/microservice
mvn clean install

if [ $? -eq 0 ]; then
  echo "Repository installed"
fi
