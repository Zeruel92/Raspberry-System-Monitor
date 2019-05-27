#!/bin/bash

flutter clean
snapcraft clean
flutter build linux
cd build/linux
zip -r 1.zip release
cd ../..
snapcraft
snapcraft push *.snap --release stable

