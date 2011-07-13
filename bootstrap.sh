#!/bin/sh
if [ ${EUID} -ne 0 ]; then
  echo
  echo "I live"
  echo "I am Sinistar"
  echo "Run, coward! Rawwwrrrr!!!"
  echo
  exit 1
fi
/usr/bin/gem install *.gem
