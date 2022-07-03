#!/bin/bash

echo "Download Heroicons"
git clone git@github.com:tailwindlabs/heroicons.git
mkdir -p ./priv/heroicons
mv ./heroicons/optimized ./priv/heroicons/optimized
rm -rf ./heroicons

