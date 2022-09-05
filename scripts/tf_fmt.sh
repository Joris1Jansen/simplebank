#!/bin/sh

while getopts "e:" arg; do
  case $arg in
    e) ENV=$OPTARG;;
  esac
done

cd ./.deploy/$ENV/tf
terraform init -backend=false
terraform fmt -check
