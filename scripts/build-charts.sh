#!/bin/bash
echo -e "Linting charts before building...\n"

helm lint --strict charts/*

if [ "$?" -ne "0" ]; then
    echo -e "\nLint failed, unable to build the charts!"
    exit 1
fi

echo -e "\nLint successful."
echo -e "Building charts for release...\n"

builddir="$PWD/.build/"
mkdir -p $builddir

helm package --dependency-update --destination "$builddir" charts/*

echo -e "\nBuild complete."
