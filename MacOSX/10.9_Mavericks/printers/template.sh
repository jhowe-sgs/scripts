#!/bin/sh

# Original Author: (c) 2010 Walter Meyer SUNY Purchase College

# Script to install and setup printers on a Mac OS X system 
# in a "Munki-Friendly" way.

# Make sure to install the required drivers first!

# Globals
PPD_DIR="/Library/Printers/PPDs/Contents/Resources"
DEPLOY_DIR="/private/etc/cups/printers_deployment"
UNINST_DIR="${DEPLOY_DIR}/uninstalls"

# Variables.
printername="SOME_PRINTER_NAME"
location="SOME LOCATION"
gui_display_name="HP Color LaserJet 9500N Example"
address="lpd://10.0.0.2/SOME_PRINTER_NAME"
driver_ppd="${PPD_DIR}/hp color LaserJet 9500.gz"

# Populate these options if you want to set specific options for the printer. 
# E.g. duplexing installed, etc.
option_1=""
option_2=""
option_3=""

### Printer Install ###

# Nuke all existing mcx* printers

# Disable sharing on any remaining printers


# In case we are making changes to a printer 
# we need to remove an existing queue if it exists.

/usr/bin/lpstat -p $printername
if [ $? -eq 0 ]; then
        /usr/sbin/lpadmin -x $printername
fi

# Now we can install the printer.
/usr/sbin/lpadmin \
        -p "$printername" \
        -L "$location" \
        -D "$gui_display_name" \
        -v "$address" \
        -P "$driver_ppd" \
        -o "$option_1" \
        -o "$option_2" \
        -o "$option_3" \
        -o printer-is-shared=false \
        -E

# Enable and start the printers on the system 
# (after adding the printer initially it is paused).

/usr/sbin/cupsenable $(lpstat -p | grep -w "printer" | awk '{print$2}')

# Create an uninstall script for the printer.

UNINSTALL_SCRIPT="${UNINST_DIR}/$printername.sh"

if [ -! -d ${UNINST_DIR} ]; then
	mkdir -p ${UNINST_DIR}
fi

echo "#!/bin/sh" > "${UNINSTALL_SCRIPT}"
echo "/usr/sbin/lpadmin -x $printername" >> "${UNINSTALL_SCRIPT}"
echo "/usr/bin/srm ${UNINST_DIR}/$printername.sh" >> "${UNINSTALL_SCRIPT}"
chmod 0750 ${UNINSTALL_SCRIPT}

# Permission the directories properly.
chown -R root:_lp ${DEPLOY_DIR}
chmod -R 700 ${DEPLOY_DIR}

exit 0
