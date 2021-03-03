#!/bin/bash

IS_LINUX=yes
uname -s|grep Darwin >/dev/null && IS_DARWIN=yes && IS_LINUX=no
echo "IS_LINUX: $IS_LINUX, IS_DARWIN: $IS_DARWIN"

echo "Clean gcda files"
rm -f ./obj/*.gcda

echo "Build and run utest"
if [[ $IS_DARWIN == yes ]]; then
  make darwin-debug-gcov && ./obj/st_utest
else
  make linux-debug-gcov && ./obj/st_utest
fi

echo "Generating coverage"
mkdir -p coverage &&
gcovr -r . -e LINUX -e DARWIN -e examples --html --html-details -o coverage/st.html &&
echo "Coverage report at coverage/st.html" &&
open coverage/st.html
