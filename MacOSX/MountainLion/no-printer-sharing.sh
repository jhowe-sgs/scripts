#!/bin/sh

lpstat -p | grep mcx | awk '{print $2}' > /tmp/printers


while read P; do
	echo "Working on ${P}" 
	sudo lpadmin -p ${P} -o printer-is-shared=false
done < /tmp/printers
rm /tmp/printers
