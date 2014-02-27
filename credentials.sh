#!/bin/bash
## Credential Holder for Build Scripts
## This allow us to mask and .gitignore RACF
RACF="octos"
RHOST="teamoctos.com"
ROUT="public_html/wp-content/uploads/download-manager-files/Carrier_ROMs"
COPY_DIR="/home/copy/shares/Octos/dubbsy/Carrier_ROMs"
COPY_GAPPS_DIR="/home/copy/shares/Octos/dubbsy/Gapps/OctOS_GApps"
RSYNC="http://www.teamoctos.com/wp-content/plugins/wp-filebase-pro/sync.php?cron_sync=1&key=2697d799b656b7a1ab885f62e715f3e6"
