#!/bin/bash
chartdir="charts"
builddir="$PWD/.build/"

echo -e "Updating chart dependencies...\n"
for chart in $chartdir/*/; do
    helm dependency update "$chart"
done

if [ "$?" -ne "0" ]; then
    echo -e "\nDependency update failed, unable to build the charts!"
    exit 1
fi

echo -e "\nLinting charts before building...\n"
helm lint --strict $chartdir/*

if [ "$?" -ne "0" ]; then
    echo -e "\nLint failed, unable to build the charts!"
    exit 1
fi

echo -e "\nLint successful."
echo -e "Building charts for release...\n"

mkdir -p $builddir
helm package --dependency-update --destination $builddir $chartdir/*

echo -e "\nBuild complete."
