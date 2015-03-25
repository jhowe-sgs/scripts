#!/bin/bash

if [ ! -s MANIFEST ]; then
  echo "Missing MANIFEST file"
  exit 1
fi

TEMPLATE=template.sh.in
MAKEFILE=Makefile.in
VERSION=`date +%Y.%m.%d.%H.%M`

while read LINE; do
  PRINTER=`echo $LINE | cut -d\, -f1`
  LOCATION=`echo $LINE | cut -d\, -f2`
  PPD=`echo $LINE | cut -d\, -f3`

  if [ ! -d ${PRINTER} ]; then
    echo "Missing Printer directory, creating..."
    mkdir ${PRINTER}
  fi

  if [ -s ${TEMPLATE} ]; then
    echo "Working on ${PRINTER}..."
    cat ${TEMPLATE} | \
      sed -e "s/%PRINTER%/${PRINTER}/g" | \
      sed -e "s/%LOCATION%/${LOCATION}/g" | \
      sed -e "s/%PPD%/${PPD}/g" > ${PRINTER}/postinstall
    chmod 0755 ${PRINTER}/postinstall
  else
    echo "Fatal! Expected parsable template file: ${TEMPLATE}"
    exit 1
  fi

  if [ -s ${MAKEFILE} ]; then
    cat ${MAKEFILE} | \
      sed -e "s/%PRINTER%/${PRINTER}/g" | \
      sed -e "s/%VERSION%/${VERSION}/g" > ${PRINTER}/Makefile
  else
    echo "Fatal! Expected parsable makefile: ${MAKEFILE}"
    exit 1
  fi
done < MANIFEST
