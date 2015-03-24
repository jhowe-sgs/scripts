Purge all mcx printers

lpstat -p | awk '{print $2}' | \
while read printer; do
	echo "Deleting Printer: ${printer}"
	lpadmin -x $printer
done

~

Show all printers

	lpstat -p

Show default printer

	lpstat -d

Add a printer

	lpadmin

Remove a named printer

	lpadmin -x <printer_name>

	lpstat -p | grep printer | awk '{print $2}' | xargs -I{} lpadmin -x {}

Show printer options

	lpoptions -p <printer_name> -l

Change printer option ?

	lpoptions -p <printer_name> -o EPIJ_DSPr=1

Disable Printer Sharing

	lpadmin -p <printer_name> -o printer-is-shared=false
